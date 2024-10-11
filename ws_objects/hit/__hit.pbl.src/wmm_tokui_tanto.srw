$PBExportHeader$wmm_tokui_tanto.srw
$PBExportComments$得意先担当者登録
forward
global type wmm_tokui_tanto from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_tokui_tanto
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tokui_tanto
end type
type uo_tokui_tanto from cv_input_tokui_tanto within wmm_tokui_tanto
end type
type uo_nendo from sv_ddplb_nendo within wmm_tokui_tanto
end type
type dw_list from ivo_datawindow within wmm_tokui_tanto
end type
end forward

global type wmm_tokui_tanto from iw_main_window
string title = "得意先担当者登録"
long backcolor = 1073741824
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
uo_tokui_tanto uo_tokui_tanto
uo_nendo uo_nendo
dw_list dw_list
end type
global wmm_tokui_tanto wmm_tokui_tanto

type variables
private:
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	//integer	i_permission	
	
	// 呼出し部の情報を保管
	string	i_syori_kbn	// 処理区分

end variables

forward prototypes
private function boolean of_record_lock (boolean p_lock)
end prototypes

private function boolean of_record_lock (boolean p_lock);
boolean l_result
l_result = false	// 処理結果:排他を正常に(獲得/解放)できるまで

long l_tokui_code
l_tokui_code = long(uo_tokui_tanto.of_get_input())
long l_nengetu_from,l_nengetu_to
l_nengetu_from	= long(fnc.strg.of_replace(uo_nendo.st_meisyo_kisyo.text,"/",""))
l_nengetu_to = long(fnc.strg.of_replace(uo_nendo.st_meisyo_kimatu.text,"/",""))

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
					nvl(to_char(m.kousin_date,'yyyy/mtt/dd hh24:mi:ss'),'????/??/?? ??:??:??'),
					nvl(m.kousin_user_id,'???'),
					nvl(mu.user_mei,'???'),
					nvl(m.kousin_client_id,'???'),
					nvl(m.kousin_pg_id,'???'),
					nvl(mw.window_name,'???')
			  from	m_tokui_tanto m,
					m_user mu,
					m_window mw
			 where	m.kousin_user_id	= mu.user_id(+)
			   and	m.kousin_pg_id		= mw.window_id(+)
			   and	m.tokui_code		= :l_tokui_code
			   and	m.nengetu between :l_nengetu_from and :l_nengetu_to
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
				return l_result
			else
				// ★排他ロック取得
				update	m_tokui_tanto
				   set	haita_flg			= 1,
						kousin_date			= SYSDATE,
						kousin_user_id		= :user.user_id,
						kousin_client_id	= :device.name,
						kousin_pg_id		= :i_pg_id
				 where	rowid = :l_rowid
				 using cocos;
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
				// 此処には到達しない
				return l_result
				
			case 100
				// 最終Fetchまで取得・更新できた(=排他を獲得)
				commit using cocos;
				
				// 変更中シグナル:(On)
				uo_signal.of_on_signal(true)

				l_result = true
				return l_result
				
			case else
				// SQLエラー(DBログ出力対象)
				msg.of_error(fnc.strg.of_format("{1}の排他処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
				of_add_db_log("of_record_lock",cocos.last_sqlerrcode,cocos.last_sqlerrtext)

				rollback using cocos;
				return l_result
		end choose
		
	case false
		// ★排他ロック解除(引数指定キーの排他中レコードが対象)
		update	m_tokui_tanto
		   set	haita_flg			= 0,
				kousin_date			= SYSDATE,
				kousin_user_id		= :user.user_id,
				kousin_client_id	= :device.name,
				kousin_pg_id		= :i_pg_id
		 where	tokui_code	= :l_tokui_code
		   and	nengetu between :l_nengetu_from and :l_nengetu_to
		   and	haita_flg	= 1
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
		
	case else
		// 引数不正(※Bool値のため、ほぼ有り得ない)
		return l_result
		
end choose

// ※此処には到達しない
return l_result

end function

on wmm_tokui_tanto.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.uo_tokui_tanto=create uo_tokui_tanto
this.uo_nendo=create uo_nendo
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.uo_tokui_tanto
this.Control[iCurrent+4]=this.uo_nendo
this.Control[iCurrent+5]=this.dw_list
end on

on wmm_tokui_tanto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.uo_tokui_tanto)
destroy(this.uo_nendo)
destroy(this.dw_list)
end on

event resize;call super::resize;st_second_upper.height	= 370

// データウィンドウ ReSize
//dw_list.x		= code.MGN_YOKO	//ReSize:変更なし
//dw_list.y		= dw_list.y	//ReSize:変更なし
dw_list.width	= newwidth - code.MGN_YOKO * 2	//ReSize:(新幅)-横マージン*2(左右)
dw_list.width	= dw_list.width	//ReSize:変更なし
dw_list.height	= newheight - dw_list.y - code.MGN_TATE - key_fnc.height	//ReSize:(新高さ)-自y(=固定部高さ)-縦マージン-ファンクション高さ
end event

event open;call super::open;
// 初期表示
of_set_firstfocus()
end event

event retrieve_event;call super::retrieve_event;long l_tokui_code
long l_kisyo_date,l_kimatu_date

l_tokui_code = long(uo_tokui_tanto.of_get_input())
l_kisyo_date = long(fnc.strg.of_replace(uo_nendo.st_meisyo_kisyo.text,"/",""))
l_kimatu_date = long(fnc.strg.of_replace(uo_nendo.st_meisyo_kimatu.text,"/",""))

// データ取得
dw_list.retrieve(l_tokui_code,l_kisyo_date,l_kimatu_date)

// 処理区分別対応
// Retrieve後のウィンドウ項目ロック
choose case ddplb_syori_kbn.text
	case "登録"
		// 呼出部：ロック
		ddplb_syori_kbn.enabled	= false
		cb_retrieve.enabled		= false
		
		// 明細部：アンロック
		dw_list.enabled 		= true
		
		// [F12:更新]ファンクション：アンロック
		dw_list.f12_key		= true

		// フォーカスを入力部へ
		dw_list.setfocus()
		
	case "変更"
		// 呼出部：ロック
		ddplb_syori_kbn.enabled	= false
		cb_retrieve.enabled		= false
		
		// 明細部：アンロック
		dw_list.enabled 		= true
		
		// [F12:更新]ファンクション：アンロック
		dw_list.f12_key		= true

		// フォーカスを入力部へ
		dw_list.setfocus()
		
	case "削除"
		// 呼出部：ロック
		ddplb_syori_kbn.enabled	= false
		cb_retrieve.enabled		= false
		
		// 明細部：ロック
		dw_list.enabled 		= false
		
		// [F12:更新]ファンクション：アンロック
		dw_list.f12_key		= true

		// フォーカスを入力部へ
		dw_list.setfocus()
		
	case "照会"
		// 呼出部：アンロック
		ddplb_syori_kbn.enabled	= true
		cb_retrieve.enabled		= true
		
		// 明細部：ロック
		dw_list.enabled 		= false
		
		// [F12:更新]ファンクション：ロック
		dw_list.f12_key		= false

		// フォーカスを呼出部へ
		uo_tokui_tanto.setfocus()
		
end choose

end event

event update_event;call super::update_event;
long l_i	// ループ処理用カウンタ
long l_nengetu
long l_nen
long l_tuki
long l_tanto_code
decimal l_uriage_mokuhyo
decimal l_arari_mokuhyo
long l_tokui_code

l_tokui_code = long(uo_tokui_tanto.of_get_input())

// 処理区分別対応
choose case ddplb_syori_kbn.text
	case "登録","変更"
		// データウィンドウ内、行毎に登録/更新を行う
		for l_i = 1 to dw_list.rowcount()
			l_nengetu 			= long(dw_list.object.nengetu[l_i])
			l_nen 				= long(dw_list.object.nen[l_i])
			l_tuki 				= long(dw_list.object.tuki[l_i])
			l_tanto_code 		= long(dw_list.object.tanto_code[l_i])
			l_uriage_mokuhyo 	= dec(dw_list.object.uriage_mokuhyo[l_i] * 1000)
			l_arari_mokuhyo 	= dec(dw_list.object.arari_mokuhyo[l_i] * 1000)
			
			choose case ddplb_syori_kbn.text
				case "登録"
					// 得意先担当者マスタ1行登録
					insert into m_tokui_tanto (
						tokui_code,
						nengetu,nen,tuki,
						tanto_code,
						uriage_mokuhyo,arari_mokuhyo,
						touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id,
						henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id,
						kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id)
					values (
						:l_tokui_code,
						:l_nengetu,:l_nen,:l_tuki,
						:l_tanto_code,
						:l_uriage_mokuhyo,:l_arari_mokuhyo,
						SYSDATE,:user.user_id,:device.name,:i_pg_id,
						SYSDATE,:user.user_id,:device.name,:i_pg_id,
						SYSDATE,:user.user_id,:device.name,:i_pg_id)
					using cocos;
					
					if cocos.sqlcode <> 0 then
						// 登録エラー
						msg.of_error(fnc.strg.of_format("{1}の登録処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
						of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
						rollback using cocos;
						return 1
					end if

				case "変更"
					// 得意先担当者マスタ1行更新試行
					update	m_tokui_tanto
					   set	tanto_code			= :l_tanto_code,
							uriage_mokuhyo		= :l_uriage_mokuhyo,
							arari_mokuhyo		= :l_arari_mokuhyo,
							henkou_date			= SYSDATE,
							henkou_user_id		= :user.user_id,
							henkou_client_id	= :device.name,
							henkou_pg_id		= :i_pg_id,
							kousin_date			= SYSDATE,
							kousin_user_id		= :user.user_id,
							kousin_client_id	= :device.name,
							kousin_pg_id		= :i_pg_id
					 where	tokui_code	= :l_tokui_code
					   and	nengetu		= :l_nengetu
					 using	cocos;
					
					if cocos.sqlcode <> 0 then
						// (更新)更新エラー
						msg.of_error(fnc.strg.of_format("{1}の更新処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
						of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
						rollback using cocos;
						return 1
					end if

			end choose
		next

	case "削除","照会"
		
end choose

msg.of_info(fnc.strg.of_format("{1}しました",ddplb_syori_kbn.text))

commit using cocos;

// 戻り処理
dw_list.event key_f06(keyf6!,0)


end event

event key_f09;call super::key_f09;
// 初期表示リセット処理
this.event key_f06(keyf6!,0)	// 戻り処理

// 呼出部：入力項目リセット
ddplb_syori_kbn.text = "照会"
uo_tokui_tanto.text = ""

return 0
end event

event update_check;call super::update_check;
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
		return 0
	end if
end if

end event

event retrieve_check;call super::retrieve_check;
// 呼び出し部入力チェック
//if not uo_tokui_tanto.event input_check( ) then
//	return -1
//end if

long l_datacount	// 既存登録確認(件数取得して判断する)
string l_tokui_code

l_tokui_code = uo_tokui_tanto.of_get_input()

// 登録データ件数取得
select	count(*)
  into	:l_datacount
  from	m_tokui_tanto
 where	tokui_code	= :l_tokui_code
 using	cocos;

if cocos.sqlcode <> 0 then
	// 通常エラーにはならない。想定外エラー
	msg.of_error(fnc.strg.of_format("{1}の検索処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
	of_add_db_log("retrieve_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
	return -1
end if

// 処理区分別対応(前段)
choose case ddplb_syori_kbn.text
	case "登録"
		// 既存データ確認
		if l_datacount <> 0 then
			// (エラー)データ既存メッセージ表示
			msg.of_error("該当データが存在します。この処理は実行できません。")
			
			// 後処理継続しない
			return -1
		end if
		
	case "変更","削除","照会"
		// 既存データ確認
		if l_datacount = 0 then
			// (エラー)既存登録なしメッセージ表示
			msg.of_error("該当データが存在しません。この処理は実行できません。")
			
			// 後処理継続しない
			return -1
		end if
		
		if ddplb_syori_kbn.text <> "照会" then
			// 排他ロック取得
			if not of_record_lock(true) then
				return -1
			end if
		end if
		
end choose

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

event key_f06;call super::key_f06;
// 戻り処理(明細部⇒呼出部)
// 排他ロック解放
if not of_record_lock(false) then
	return -1
end if

// 明細部:データウィンドウをリセット
dw_list.reset()

// 呼出部:項目ロックを解除
ddplb_syori_kbn.enabled	= true
uo_tokui_tanto.enabled	= true
cb_retrieve.enabled		= true

// 呼出条件1にフォーカス
of_set_firstfocus()

return 0

end event

type uo_signal from iw_main_window`uo_signal within wmm_tokui_tanto
end type

type st_date from iw_main_window`st_date within wmm_tokui_tanto
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tokui_tanto
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tokui_tanto
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tokui_tanto
end type

type st_title from iw_main_window`st_title within wmm_tokui_tanto
integer x = 2340
integer width = 440
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tokui_tanto
end type

type st_upper from iw_main_window`st_upper within wmm_tokui_tanto
integer y = 4
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tokui_tanto
integer y = 114
integer height = 370
boolean f9_key = true
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tokui_tanto
integer y = 366
integer taborder = 40
boolean f9_key = true
boolean f10_key = true
end type

type st_syori_kbn from ivo_statictext within wmm_tokui_tanto
integer x = 20
integer y = 160
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tokui_tanto
integer x = 356
integer y = 149
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean visible_sakujyo = false
string init_disp = "照会"
end type

type uo_tokui_tanto from cv_input_tokui_tanto within wmm_tokui_tanto
event destroy ( )
integer x = 40
integer y = 263
integer taborder = 20
boolean bringtotop = true
boolean chk_required = true
end type

on uo_tokui_tanto.destroy
call cv_input_tokui_tanto::destroy
end on

type uo_nendo from sv_ddplb_nendo within wmm_tokui_tanto
event destroy ( )
integer x = 20
integer y = 366
integer taborder = 30
boolean bringtotop = true
boolean meisyo_display_on = true
end type

on uo_nendo.destroy
call sv_ddplb_nendo::destroy
end on

type dw_list from ivo_datawindow within wmm_tokui_tanto
integer y = 498
integer width = 4512
integer height = 1479
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_tokui_tanto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
long input_ena_backcolor = 16777215
end type

event itemchanged;call super::itemchanged;
//choose case dwo.name
//	case "kyoten_use"
//		// 拠点使用:項目変更時
//		choose case this.object.kyoten_use[row]
//			case 0
//				// チェックボックス:Off
//				this.object.kyoten_sort_no[row]	= 0
//				//this.object.kyoten_sort_no[row].enabled	= false
//				
//			case 1
//				// チェックボックス:On
//				//this.object.kyoten_sort_no[row].enabled	= true
//				
//			case else
//				
//		end choose
//
//	case else
//		// 引数:上記以外
//		// nop.
//end choose
//
return 0
end event

event key_f05;call super::key_f05;
parent.event key_f05(keyf5!,0)

return 0

end event

event constructor;call super::constructor;
// データ転送オブジェクト設定
this.settransobject(cocos)

end event

