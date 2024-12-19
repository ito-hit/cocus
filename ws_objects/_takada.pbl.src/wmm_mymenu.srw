﻿$PBExportHeader$wmm_mymenu.srw
$PBExportComments$マイメニュー登録
forward
global type wmm_mymenu from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_mymenu
end type
type st_tab from ivo_statictext within wmm_mymenu
end type
type st_user from ivo_statictext within wmm_mymenu
end type
type st_v_tab from sv_st_meisyo within wmm_mymenu
end type
type st_v_user from sv_st_meisyo within wmm_mymenu
end type
type dw_list from ivo_datawindow within wmm_mymenu
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_mymenu
end type
end forward

global type wmm_mymenu from iw_main_window
string title = "マイメニュー登録"
long backcolor = 1073741824
st_syori_kbn st_syori_kbn
st_tab st_tab
st_user st_user
st_v_tab st_v_tab
st_v_user st_v_user
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
end type
global wmm_mymenu wmm_mymenu

type variables

private:
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	//integer	i_permission	
	
	// 呼出し部の情報を保管
	//string	i_syori_kbn	// 処理区分

end variables

forward prototypes
private function boolean of_record_lock (boolean p_lock)
end prototypes

private function boolean of_record_lock (boolean p_lock);
boolean l_result
l_result = false	// 処理結果:排他を正常に(獲得/解放)できるまで

choose case p_lock
	case true
		// ★排他ロック取得(引数指定キーの全レコード対象)
		string	l_rowid
		string	l_kousin_date,l_kousin_user_id,l_kousin_client_id,l_kousin_pg_id
		string	l_user_mei,l_window_mei
		integer	l_haita_flg
		
		// ★更新・排他情報を取得
		declare cur_haita cursor for
			select	m.rowid,m.haita_flg,
					nvl(to_char(m.kousin_date,'yyyy/mm/dd hh24:mi:ss'),'????/??/?? ??:??:??'),
					nvl(m.kousin_user_id,'???'),
					nvl(mu.user_mei,'???'),
					nvl(m.kousin_client_id,'???'),
					nvl(m.kousin_pg_id,'???'),
					nvl(mw.window_name,'???')
			  from	m_mymenu m,
					m_user mu,
					m_window mw
			 where	m.kousin_user_id	= mu.user_id(+)
			   and	m.kousin_pg_id		= mw.window_id(+)
			   and	m.user_id			= :user.user_id
			   for update
			 using cocos;
		
		open cur_haita;
		
		fetch next cur_haita
		 into :l_rowid,
		 	  :l_haita_flg,
		 	  :l_kousin_date,
		 	  :l_kousin_user_id,
		 	  :l_user_mei,
		 	  :l_kousin_client_id,
		 	  :l_kousin_pg_id,
		 	  :l_window_mei;
		
		if cocos.sqlcode <> 0 then
			// 初回FetchがNot Found or Error(=排他ロック対象がない)
			close cur_haita;
			
			// 排他に失敗
			return l_result;
		end if
		
		do while cocos.sqlcode = 0
			// 排他チェック
			if (l_kousin_user_id <> user.user_id) and (l_haita_flg <> 0) then
				// 最終更新が自分ではない、ロック行を検出
				msg.of_error(fnc.strg.of_format("他の端末で編集中です。{1}{2}{1}{3}{1}{4}～",code.crlf,l_user_mei,l_window_mei,l_kousin_date))
				
				// 排他に失敗
				exit
			else
				// ★排他ロック取得
				update	m_mymenu
				   set	haita_flg			= 1,
						kousin_date			= SYSDATE,
						kousin_user_id		= :user.user_id,
						kousin_client_id	= :device.name,
						kousin_pg_id		= :i_pg_id
				 where	rowid				= :l_rowid
				 using cocos;
				 
				if cocos.sqlcode <> 0 then exit
			end if
			
			// 次行取得
			fetch cur_haita
			 into :l_rowid,
				  :l_haita_flg,
				  :l_kousin_date,
				  :l_kousin_user_id,
				  :l_user_mei,
				  :l_kousin_client_id,
				  :l_kousin_pg_id,
				  :l_window_mei;
		loop
		
		// カーソルループを脱出(排他後処理)
		choose case cocos.sqlcode
			case 0
				// 他端末ロック検出時に到達
				rollback using cocos;
				close cur_haita;
				
				return l_result
				
			case 100
				// 最終Fetchまで取得・更新できた(=排他を獲得)
				commit using cocos;
				close cur_haita;
				
				// 変更中シグナル:(On)
				uo_signal.of_on_signal(true)

				l_result = true
				return l_result
				
			case else
				// SQLエラー(DBログ出力対象)
				msg.of_error(fnc.strg.of_format("{1}の排他処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
				of_add_db_log("of_record_lock",cocos.last_sqlerrcode,cocos.last_sqlerrtext)

				rollback using cocos;
				close cur_haita;
				
				return l_result
		end choose
		
	case false
		// ★排他ロック解除(引数指定キーの排他中レコードが対象)
		update m_mymenu
		   set haita_flg		= 0,
		       kousin_date		= SYSDATE,
			   kousin_user_id	= :user.user_id,
			   kousin_client_id	= :device.name,
			   kousin_pg_id		= :i_pg_id
		 where user_id			= :user.user_id
		   and haita_flg		= 1
		 using cocos;
		
		// DB処理結果
		choose case cocos.sqlcode
			case 0
				// 正常終了
				commit using cocos;
				l_result = true
				
				// 変更中シグナル:(Off)
				uo_signal.of_on_signal(false)

				return l_result
				
			case 100
				// 解除対象なし(正常終了とする)
				commit using cocos;
				l_result = true
				
				// 変更中シグナル:(Off)
				uo_signal.of_on_signal(false)
				
				return l_result
				
			case else
				// SQLエラー(DBログ出力対象)
				msg.of_error(fnc.strg.of_format("{1}の排他処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
				of_add_db_log("of_record_lock",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
				
				rollback using cocos;
				return l_result
				
		end choose
		
end choose

// ※此処には到達しない
return l_result

end function

on wmm_mymenu.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.st_tab=create st_tab
this.st_user=create st_user
this.st_v_tab=create st_v_tab
this.st_v_user=create st_v_user
this.dw_list=create dw_list
this.ddplb_syori_kbn=create ddplb_syori_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.st_tab
this.Control[iCurrent+3]=this.st_user
this.Control[iCurrent+4]=this.st_v_tab
this.Control[iCurrent+5]=this.st_v_user
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.ddplb_syori_kbn
end on

on wmm_mymenu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.st_tab)
destroy(this.st_user)
destroy(this.st_v_tab)
destroy(this.st_v_user)
destroy(this.dw_list)
destroy(this.ddplb_syori_kbn)
end on

event resize;call super::resize;
// データウィンドウ ReSize
//dw_list.x		= code.MGN_YOKO	//ReSize:変更なし
//dw_list.y		= dw_list.y	//ReSize:変更なし
dw_list.width	= newwidth - code.MGN_YOKO * 2	//ReSize:(新幅)-横マージン*2(左右)
dw_list.height	= newheight - dw_list.y - code.MGN_TATE - key_fnc.height	//ReSize:(新高さ)-自y(=固定部高さ)-縦マージン-ファンクション高さ

return 0

end event

event open;call super::open;
// 固定項目:ユーザー名
st_v_user.text = user.user_mei

// 初期表示
of_set_firstfocus()

return 0

end event

event retrieve_event;call super::retrieve_event;
integer l_i // ループ処理用カウンタ(= m_mymenu.button_no)

dw_list.clear()

// 処理区分別対応
// 処理区分別対応(前段)
choose case ddplb_syori_kbn.text
	case "登録","変更"
		dw_list.object.window_id.update = true

	case "削除","照会"
		dw_list.object.window_id.update = false

end choose

choose case ddplb_syori_kbn.text
	case "登録"
		// ウィンドウ描画停止
		setredraw(false)
		
		// 新規(空データ)を生成する
		for l_i = 1 to 45
			dw_list.insertrow(0)	// 新規行追加
			dw_list.object.button_no[l_i]	= l_i
			dw_list.object.user_id[l_i]		= user.user_id
		next
		
		// 生成された空行の先頭にフォーカスする
		dw_list.scrolltorow(1)
		dw_list.selectrow(1,true)
		
		// ウィンドウ描画開始
		setredraw(true)

	case "変更","削除","照会"
		// データ取得
		dw_list.retrieve(user.user_id)
		
end choose

// 呼出部：ロック
ddplb_syori_kbn.enabled	= false
cb_retrieve.enabled = false
		
// 明細部：アンロック
dw_list.enabled = true

// [F5:Excel出力]ファンクション：アンロック
dw_list.f5_key = true

// [F6:戻り]ファンクション：アンロック
dw_list.f6_key = true

if ddplb_syori_kbn.text = "照会" then
	// [F12:更新]ファンクション：ロック
	dw_list.f12_key = false
else
	// [F12:更新]ファンクション：アンロック
	dw_list.f12_key = true
end if

// フォーカスを明細部へ
dw_list.setfocus()

return 0
end event

event update_event;call super::update_event;
integer l_i	// ループ処理用カウンタ(= m_mymenu.button_no)

// 処理区分別対応
choose case ddplb_syori_kbn.text
	case "登録","変更","削除"
		setredraw(false)
		if ddplb_syori_kbn.text = "削除" then
		//行の削除
			for l_i = 1 to 45
				dw_list.deleterow(1)
			next
		end if
		setredraw(true)
		
		// 更新(排他フラグはリセットしない)
		if not dw_list.update(true,false) = 1 then
			msg.of_error(fnc.strg.of_format("{1}の{3}処理でエラーが発生しました。{2}{4}：{5}",this.title,code.crlf,ddplb_syori_kbn.text,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
			of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
			rollback using cocos;
			return 1
		end if
	
	case "削除"
		//削除実行
		delete from m_mymenu
		 where user_id = :user.user_id
		using cocos;
	case "照会"
		
end choose

msg.of_info(fnc.strg.of_format("{1}しました",ddplb_syori_kbn.text))

commit using cocos;

// 戻り処理
dw_list.event key_f06(keyf6!,0)

return 0

end event

event key_f09;call super::key_f09;
// 初期表示リセット処理
this.event key_f06(keyf6!,0)	// 戻り処理

// 呼出部：入力項目リセット
ddplb_syori_kbn.text = "照会"

return 0
end event

event update_check;call super::update_check;
// 更新チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

return 0 // チェック通過
end event

event key_f12;call super::key_f12;
// DW更新開始
if not of_evt_update(0,0) then
	return -1
end if

return 0

end event

event closequery;call super::closequery;
// データ変更[排他ロック]中に終了される場合、
if uo_signal.of_get_status() then
	// 排他ロック解放する
	if not of_record_lock(false) then
		// ロック解放の成否は問わない
		//return 1
	end if
end if

return 0

end event

event retrieve_check;call super::retrieve_check;
integer l_datacount	// 既存登録確認(件数取得して判断する)

// 登録データ件数取得
select	count(*)
  into	:l_datacount
  from 	m_mymenu
 where 	user_id = :user.user_id
 using cocos;

if cocos.sqlcode <> 0 then
	// 通常エラーにはならない。想定外エラー
	msg.of_error(fnc.strg.of_format("{2}の検索処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
	of_add_db_log("retrieve_check",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
	return -1
end if

// 処理区分別対応(前段)
choose case ddplb_syori_kbn.text
	case "登録"
		// 既存データ確認
		if l_datacount <> 0 then
			// (エラー)データ既存メッセージ表示:後処理継続しない
			msg.of_error("該当データが存在します。この処理は実行できません。")
			return -1
		end if

	case "変更","削除","照会"
		// 既存データ確認
		if l_datacount = 0 then
			// (エラー)既存登録なしメッセージ表示:後処理継続しない
			msg.of_error("該当データが存在しません。この処理は実行できません。")
			return -1
		end if
		
		if ddplb_syori_kbn.text <> "照会" then
			// 排他ロック取得
			if not of_record_lock(true) then
				// 排他ロック取得に失敗:後処理継続しない
				return -1
			end if
		end if

end choose

return 0
end event

event key_f06;call super::key_f06;
// 戻り処理(明細部⇒呼出部)
// 排他ロック解放
if not of_record_lock(false) then
	return -1
end if

// 明細部:データウィンドウをリセット
dw_list.reset()
dw_list.enabled = false

// 呼出部:項目ロックを解除
ddplb_syori_kbn.enabled	= true
cb_retrieve.enabled		= true

// 呼出条件1にフォーカス
of_set_firstfocus()

return 0

end event

event key_f05;call super::key_f05;
// Excel保存先
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format("{1}{2}",this.title,string(today(),"yyyymmdd"))

// Excel出力
if not dw_list.of_saveas_excel(l_file) then
	return -1
end if

return 0

end event

type uo_signal from iw_main_window`uo_signal within wmm_mymenu
end type

type st_date from iw_main_window`st_date within wmm_mymenu
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_mymenu
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_mymenu
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_mymenu
end type

type st_title from iw_main_window`st_title within wmm_mymenu
integer x = 2340
integer width = 440
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_mymenu
end type

type st_upper from iw_main_window`st_upper within wmm_mymenu
integer y = 4
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_mymenu
integer y = 139
boolean f9_key = true
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_mymenu
integer taborder = 20
boolean f9_key = true
boolean f10_key = true
end type

type st_syori_kbn from ivo_statictext within wmm_mymenu
integer x = 32
integer y = 160
integer width = 328
integer height = 82
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type st_tab from ivo_statictext within wmm_mymenu
integer x = 32
integer y = 263
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "タブ"
alignment alignment = right!
end type

type st_user from ivo_statictext within wmm_mymenu
integer x = 1616
integer y = 263
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "ユーザー"
alignment alignment = right!
end type

type st_v_tab from sv_st_meisyo within wmm_mymenu
integer x = 376
integer y = 260
integer width = 1208
boolean bringtotop = true
string text = "マイメニュー"
end type

type st_v_user from sv_st_meisyo within wmm_mymenu
integer x = 1960
integer y = 260
integer width = 808
boolean bringtotop = true
end type

type dw_list from ivo_datawindow within wmm_mymenu
integer y = 388
integer width = 4460
integer height = 1252
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_mymenu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f5_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean row_focus_ind = true
long input_ena_backcolor = 16777215
end type

event constructor;call super::constructor;
// データ転送オブジェクト設定
this.settransobject(cocos)

return 0

end event

event itemchanged;call super::itemchanged;
DataWindowChild	ldwc
long	l_row
string	l_msg

choose case dwo.name
	case "window_id"
		// ウィンドウID:項目変更時
		// dddwより関連項目の値を取得し、画面にセットする
		this.getchild("window_id",ldwc)	//dddw_window_id ドロップダウンデータウィンドウ
		l_row	= ldwc.getrow()
		this.object.window_name[row]	= ldwc.getitemstring(l_row,"window_name")		// ウィンドウ名称
		this.object.kengen_kbn_mei[row]	= ldwc.getitemstring(l_row,"kengen_kbn_mei")	// 必要権限

	case "param"
		// 引数:項目変更時
		if this.object.param[row] <> data then
			if not fnc.of_chk_column_info(trim(data),false,dwo.tag,"m_mymenu",dwo.name,l_msg) then
				msg.of_error_dwo(dwo,l_msg)
				return -1
			end if
		end if

	case else
		// 引数:上記以外
		// nop.
end choose

return 0
end event

event key_f05;call super::key_f05;
parent.event key_f05(keyf5!,0)

return 0
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_mymenu
integer x = 376
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

