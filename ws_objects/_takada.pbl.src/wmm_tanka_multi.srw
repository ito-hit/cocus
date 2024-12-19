$PBExportHeader$wmm_tanka_multi.srw
$PBExportComments$単価登録(一覧)
forward
global type wmm_tanka_multi from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_tanka_multi
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanka_multi
end type
type dw_entry from ivo_datawindow within wmm_tanka_multi
end type
type uo_tokuisaki from cv_input_tokui within wmm_tanka_multi
end type
type uo_daibunrui from cv_input_bunrui within wmm_tanka_multi
end type
type uo_tyubunrui from cv_input_bunrui within wmm_tanka_multi
end type
type uo_syobunrui from cv_input_bunrui within wmm_tanka_multi
end type
type uo_1 from cv_input_group within wmm_tanka_multi
end type
type uo_kojyo from cv_input_tokui within wmm_tanka_multi
end type
type uo_2 from cv_input_brand within wmm_tanka_multi
end type
end forward

global type wmm_tanka_multi from iw_main_window
string title = "単価登録(一覧)"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_entry dw_entry
uo_tokuisaki uo_tokuisaki
uo_daibunrui uo_daibunrui
uo_tyubunrui uo_tyubunrui
uo_syobunrui uo_syobunrui
uo_1 uo_1
uo_kojyo uo_kojyo
uo_2 uo_2
end type
global wmm_tanka_multi wmm_tanka_multi

type variables
private:
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	integer	i_permission	
	
	// 呼出し部の情報を保管
	string	i_syori_kbn	// 処理区分
	
	// ロック状態
	boolean	i_lck_mymenu

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
			  from m_tanka m,
				   m_user mu,
				   m_window mw
				 where m.kousin_user_id	= mu.user_id(+)
				   and m.kousin_pg_id	= mw.window_id(+)
				   and m.syohin_code	= :uo_tokuisaki.text
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
				// 最終変更が自分ではない、ロック行を検出
				rollback using cocos;
				msg.of_error(fnc.strg.of_format("他の端末で編集中です。{1}{2}{1}{3}{1}{4}～",code.crlf,l_user_mei,l_window_mei,l_kousin_date))
				
				// 排他に失敗
				exit
			else
				// ★排他ロック取得
				update m_tanka
				   set haita_flg		= 1,
				   	   kousin_date		= SYSDATE,
				   	   kousin_user_id	= :user.user_id,
				   	   kousin_client_id	= :device.name,
				   	   kousin_pg_id		= :i_pg_id
				 where rowid			= :l_rowid
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
		update m_tanka
		   set haita_flg		= 0,
		       kousin_date		= SYSDATE,
			   kousin_user_id	= :user.user_id,
			   kousin_client_id	= :device.name,
			   kousin_pg_id		= :i_pg_id
		 where syohin_code		= :uo_tokuisaki.text
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

on wmm_tanka_multi.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_entry=create dw_entry
this.uo_tokuisaki=create uo_tokuisaki
this.uo_daibunrui=create uo_daibunrui
this.uo_tyubunrui=create uo_tyubunrui
this.uo_syobunrui=create uo_syobunrui
this.uo_1=create uo_1
this.uo_kojyo=create uo_kojyo
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.uo_tokuisaki
this.Control[iCurrent+5]=this.uo_daibunrui
this.Control[iCurrent+6]=this.uo_tyubunrui
this.Control[iCurrent+7]=this.uo_syobunrui
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.uo_kojyo
this.Control[iCurrent+10]=this.uo_2
end on

on wmm_tanka_multi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_tokuisaki)
destroy(this.uo_daibunrui)
destroy(this.uo_tyubunrui)
destroy(this.uo_syobunrui)
destroy(this.uo_1)
destroy(this.uo_kojyo)
destroy(this.uo_2)
end on

event open;call super::open;
// 初期表示
of_set_firstfocus()
end event

event retrieve_event;call super::retrieve_event;
choose case ddplb_syori_kbn.text
	case "登録"
		if dw_entry.rowcount() = 0 then
			dw_entry.insertrow(0)
		end if
		
	case "変更","削除","照会"
		// 既存データ取得できなければ、エラー
		if dw_entry.retrieve("") = 0 then
			msg.of_error("入力した拠点コードで登録されたデータはありません。")
			//sle_kyoten_code.setfocus()
			return -1
		end if

		if ddplb_syori_kbn.text <> "照会" then
			// 排他ロック取得
			if not of_record_lock(true) then
				return -1
			end if
		end if
		
end choose

// 呼出部：ロック
ddplb_syori_kbn.enabled	= false
cb_retrieve.enabled = false

// 入力部：アンロック
dw_entry.enabled = true

if ddplb_syori_kbn.text = "照会" then
	// [F12:更新]ファンクション：ロック
	dw_entry.f12_key = false
else
	// [F12:更新]ファンクション：アンロック
	dw_entry.f12_key = true
end if

// フォーカスを入力部へ
dw_entry.setfocus()

return 0

end event

event update_event;call super::update_event;
// 更新実行(accepttext実行、更新フラグはリセットしない)
if not dw_entry.update(true,false) = 1 then
	msg.of_error(fnc.strg.of_format("{1}の登録処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
	of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
	rollback using cocos;
	
	return 1
end if

// 排他ロック解放
if not of_record_lock(false) then
	return -1
end if

// [登録/変更/削除]処理成功
msg.of_info(fnc.strg.of_format("{1}しました",ddplb_syori_kbn.text))

commit using cocos;

// 戻り処理
dw_entry.event key_f06(keyf6!,0)

return 0

end event

event key_f09;call super::key_f09;
// 初期表示リセット処理
// 戻り処理
dw_entry.event key_f06(keyf6!,0)

// 呼出部：入力項目リセット
ddplb_syori_kbn.text = "照会"

// 初期表示
of_set_firstfocus()

return 0
end event

event closequery;call super::closequery;
// データ変更[排他ロック]中に終了される場合、
if uo_signal.of_get_status() then
	// 排他ロック解放する
	if not of_record_lock(false) then
		// ロック解放の成否は問わない
		return 0
	end if
end if

end event

event retrieve_check;call super::retrieve_check;
// 呼び出し部入力チェック
//if not sle_kyoten_code.event input_check( ) then
//	return -1
//end if

end event

event resize;call super::resize;
// データウィンドウ ReSize
//dw_entry.x	= code.MGN_YOKO	//ReSize:変更なし
//dw_entry.y	= dw_entry.y	//ReSize:変更なし
dw_entry.width	= newwidth - code.MGN_YOKO * 2	//ReSize:(新幅)-横マージン*2(左右)
//dw_entry.height	= dw_entry.y	//ReSize:変更なし

dw_entry.object.henkou_date.x = dw_entry.width - dw_entry.object.henkou_date.width - code.MGN_YOKO
//dw_entry.object.henkou_date.y = dw_entry.object.henkou_date.y	//ReSize:変更なし
dw_entry.object.henkou_date_t.x = dw_entry.object.henkou_date.x - dw_entry.object.henkou_date_t.width - code.MGN_DW_GROUP_YOKO
//dw_entry.object.henkou_date_t.y = dw_entry.object.henkou_date_t.y	//ReSize:変更なし
dw_entry.object.touroku_date.x = dw_entry.object.t_henkou_date.x - dw_entry.object.touroku_date.width - code.MGN_DW_ITEM_YOKO
//dw_entry.object.touroku_date.y = dw_entry.object.touroku_date.y	//ReSize:変更なし
dw_entry.object.touroku_date_t.x = dw_entry.object.touroku_date.x - dw_entry.object.touroku_date_t.width - code.MGN_DW_GROUP_YOKO
//dw_entry.object.touroku_date_t.y = dw_entry.object.touroku_date_t.y	//ReSize:変更なし

end event

type uo_signal from iw_main_window`uo_signal within wmm_tanka_multi
end type

type st_date from iw_main_window`st_date within wmm_tanka_multi
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tanka_multi
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tanka_multi
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tanka_multi
end type

type st_title from iw_main_window`st_title within wmm_tanka_multi
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tanka_multi
end type

type st_upper from iw_main_window`st_upper within wmm_tanka_multi
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tanka_multi
integer y = 107
integer height = 782
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tanka_multi
integer y = 764
integer height = 82
integer taborder = 40
end type

type st_syori_kbn from ivo_statictext within wmm_tanka_multi
integer x = 32
integer y = 160
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanka_multi
integer x = 376
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

type dw_entry from ivo_datawindow within wmm_tanka_multi
integer y = 875
integer width = 5088
integer height = 1678
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_tanka_multi"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean save_excel = false
end type

event itemfocuschanged;call super::itemfocuschanged;
// DW内フォーカスアイテム変更
// フォーカスアイテム毎対応
choose case dwo.name
	case "sle_yubin_no","sle_unso_code"
		//[F8:参照]を許可
		this.f8_key = true
		
	case else
		//[F8:参照]不許可
		this.f8_key = false
end choose

end event

event constructor;call super::constructor;
// データ転送オブジェクト設定
this.settransobject(cocos)

end event

event key_f06;call super::key_f06;
// 戻り処理(入力部⇒呼出部)

// 排他ロック解放
if not of_record_lock(false) then
	return -1
end if

// 入力部:データウィンドウをリセット
dw_entry.reset()

// 呼出部:項目ロックを解除
ddplb_syori_kbn.enabled	= true
cb_retrieve.enabled		= true

// 呼出条件1にフォーカス
//sle_kyoten_code.setfocus()

return 0
end event

type uo_tokuisaki from cv_input_tokui within wmm_tanka_multi
integer x = 640
integer y = 160
integer taborder = 20
boolean bringtotop = true
boolean down_key = true
boolean syusoku_hyoji = false
boolean syohizei_hyoji = true
end type

on uo_tokuisaki.destroy
call cv_input_tokui::destroy
end on

type uo_daibunrui from cv_input_bunrui within wmm_tanka_multi
event destroy ( )
integer x = 64
integer y = 267
integer taborder = 20
boolean bringtotop = true
string title_text = "大分類"
end type

on uo_daibunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_tyubunrui from cv_input_bunrui within wmm_tanka_multi
event destroy ( )
integer x = 64
integer y = 359
integer taborder = 30
boolean bringtotop = true
string title_text = "中分類"
boolean daibunrui = false
boolean tyubunrui = true
end type

on uo_tyubunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_syobunrui from cv_input_bunrui within wmm_tanka_multi
event destroy ( )
integer x = 64
integer y = 448
integer taborder = 40
boolean bringtotop = true
string title_text = "小分類"
boolean daibunrui = false
boolean syobunrui = true
end type

on uo_syobunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_1 from cv_input_group within wmm_tanka_multi
event destroy ( )
integer x = 64
integer y = 548
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call cv_input_group::destroy
end on

type uo_kojyo from cv_input_tokui within wmm_tanka_multi
integer x = 1760
integer y = 267
integer taborder = 30
boolean bringtotop = true
boolean down_key = true
string title_text = "工場仕入先"
boolean bikou_visible = false
boolean syusoku_hyoji = false
end type

on uo_kojyo.destroy
call cv_input_tokui::destroy
end on

type uo_2 from cv_input_brand within wmm_tanka_multi
integer x = 1760
integer y = 359
integer taborder = 40
boolean bringtotop = true
end type

on uo_2.destroy
call cv_input_brand::destroy
end on

