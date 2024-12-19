$PBExportHeader$wmm_untin.srw
$PBExportComments$運賃登録
forward
global type wmm_untin from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_untin
end type
type dw_list from ivo_datawindow within wmm_untin
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_untin
end type
type dw_entry from ivo_datawindow within wmm_untin
end type
type st_kyoten_code from ivo_statictext within wmm_untin
end type
type sle_kyoten_code from ivo_singlelineedit within wmm_untin
end type
type cb_kyoten_code from sv_cb_modal within wmm_untin
end type
type st_kyoten_mei from sv_st_meisyo within wmm_untin
end type
type st_key_syubetu from ivo_statictext within wmm_untin
end type
type st_untin_kbn from ivo_statictext within wmm_untin
end type
type ddplb_key_syubetu from sv_ddplb_meisyo within wmm_untin
end type
type ddplb_untin_kbn from sv_ddplb_meisyo within wmm_untin
end type
end forward

global type wmm_untin from iw_main_window
string title = "運賃登録"
long backcolor = 1073741824
st_syori_kbn st_syori_kbn
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
dw_entry dw_entry
st_kyoten_code st_kyoten_code
sle_kyoten_code sle_kyoten_code
cb_kyoten_code cb_kyoten_code
st_kyoten_mei st_kyoten_mei
st_key_syubetu st_key_syubetu
st_untin_kbn st_untin_kbn
ddplb_key_syubetu ddplb_key_syubetu
ddplb_untin_kbn ddplb_untin_kbn
end type
global wmm_untin wmm_untin

type variables

private:
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	//integer	i_permission	
	
	// 呼出し部の情報を保管
	string	i_syori_kbn	// 処理区分
	string	i_key_syubetu
	string	i_untin_kbn

end variables

forward prototypes
private function boolean of_record_lock (string p_key_code, string p_unso_code, boolean p_lock)
end prototypes

private function boolean of_record_lock (string p_key_code, string p_unso_code, boolean p_lock);
boolean l_result
l_result = false	// 処理結果:排他を正常に(獲得/解放)できるまで

choose case p_lock
	case true
		// ★排他ロック取得(引数指定キーの全レコード対象)
		string	l_rowid
		string	l_kousin_date,l_kousin_user_id,l_kousin_client_id,l_kousin_pg_id
		string	l_user_mei,l_window_mei
		integer	l_haita_flg
		
		string  l_kyoten_code
		string  l_key_syubetu
		string  l_untin_kbn
		l_kyoten_code = sle_kyoten_code.text
		l_key_syubetu = left(ddplb_key_syubetu.text,pos(ddplb_key_syubetu.text,"：")-1)
		l_untin_kbn = left(ddplb_untin_kbn.text,pos(ddplb_untin_kbn.text,"：")-1)
		
		// ★更新・排他情報を取得
		declare cur_haita cursor for
			select	m.rowid,m.haita_flg,
					nvl(to_char(m.kousin_date,'yyyy/mm/dd hh24:mi:ss'),'????/??/?? ??:??:??'),
					nvl(m.kousin_user_id,'???'),
					nvl(mu.user_mei,'???'),
					nvl(m.kousin_client_id,'???'),
					nvl(m.kousin_pg_id,'???'),
					nvl(mw.window_name,'???')
			  from	m_untin m,
					m_user mu,
					m_window mw
			 where	m.kousin_user_id	= mu.user_id(+)
			   and	m.kousin_pg_id		= mw.window_id(+)
			   and	m.kyoten_code		= :l_kyoten_code
			   and	m.key_syubetu		= :l_key_syubetu
			   and	m.key_code			= :p_key_code
			   and	m.unso_code			= :p_unso_code
			   and	m.untin_kbn			= :l_untin_kbn
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
				rollback using cocos;
				msg.of_error(fnc.strg.of_format("他の端末で編集中です。{1}{2}{1}{3}{1}{4}～",code.crlf,l_user_mei,l_window_mei,l_kousin_date))
				
				// 排他に失敗
				exit
			else
				// ★排他ロック取得
				update	m_untin
				   set	haita_flg			= 1,
						kousin_date			= SYSDATE,
						kousin_user_id		= :user.user_id,
						kousin_client_id	= :device.name,
						kousin_pg_id		= :i_pg_id
				 where	rowid	= :l_rowid
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
		update m_untin
		   set haita_flg		= 0,
		       kousin_date		= SYSDATE,
			   kousin_user_id	= :user.user_id,
			   kousin_client_id	= :device.name,
			   kousin_pg_id		= :i_pg_id
		 where haita_flg = 1
		   and kyoten_code	= :l_kyoten_code
		   and key_syubetu	= :l_key_syubetu
		   and key_code		= :p_key_code
		   and unso_code	= :p_unso_code
		   and untin_kbn	= :l_untin_kbn
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

on wmm_untin.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.dw_list=create dw_list
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_entry=create dw_entry
this.st_kyoten_code=create st_kyoten_code
this.sle_kyoten_code=create sle_kyoten_code
this.cb_kyoten_code=create cb_kyoten_code
this.st_kyoten_mei=create st_kyoten_mei
this.st_key_syubetu=create st_key_syubetu
this.st_untin_kbn=create st_untin_kbn
this.ddplb_key_syubetu=create ddplb_key_syubetu
this.ddplb_untin_kbn=create ddplb_untin_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.ddplb_syori_kbn
this.Control[iCurrent+4]=this.dw_entry
this.Control[iCurrent+5]=this.st_kyoten_code
this.Control[iCurrent+6]=this.sle_kyoten_code
this.Control[iCurrent+7]=this.cb_kyoten_code
this.Control[iCurrent+8]=this.st_kyoten_mei
this.Control[iCurrent+9]=this.st_key_syubetu
this.Control[iCurrent+10]=this.st_untin_kbn
this.Control[iCurrent+11]=this.ddplb_key_syubetu
this.Control[iCurrent+12]=this.ddplb_untin_kbn
end on

on wmm_untin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.dw_list)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_entry)
destroy(this.st_kyoten_code)
destroy(this.sle_kyoten_code)
destroy(this.cb_kyoten_code)
destroy(this.st_kyoten_mei)
destroy(this.st_key_syubetu)
destroy(this.st_untin_kbn)
destroy(this.ddplb_key_syubetu)
destroy(this.ddplb_untin_kbn)
end on

event resize;call super::resize;
// データウィンドウ ReSize
//dw_entry.x	= code.MGN_YOKO	//ReSize:変更なし
//dw_entry.y	= dw_entry.y	//ReSize:変更なし
dw_entry.width	= newwidth - code.MGN_YOKO * 2	//ReSize:(新幅)-横マージン*2(左右)
//dw_entry.height	= dw_entry.y	//ReSize:変更なし

//dw_entry.object.henkou_date.x = dw_entry.width - dw_entry.object.henkou_date.width - code.MGN_YOKO
////dw_entry.object.henkou_date.y = dw_entry.object.henkou_date.y	//ReSize:変更なし
//dw_entry.object.henkou_date_t.x = dw_entry.object.henkou_date.x - dw_entry.object.henkou_date_t.width - code.MGN_DW_GROUP_YOKO
////dw_entry.object.henkou_date_t.y = dw_entry.object.henkou_date_t.y	//ReSize:変更なし
//dw_entry.object.touroku_date.x = dw_entry.object.henkou_date_t.x - dw_entry.object.touroku_date.width - code.MGN_DW_ITEM_YOKO
////dw_entry.object.touroku_date.y = dw_entry.object.touroku_date.y	//ReSize:変更なし
//dw_entry.object.touroku_date_t.x = dw_entry.object.touroku_date.x - dw_entry.object.touroku_date_t.width - code.MGN_DW_GROUP_YOKO
////dw_entry.object.touroku_date_t.y = dw_entry.object.touroku_date_t.y	//ReSize:変更なし

dw_entry.object.henkou_date.x	= dw_entry.width - long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x	= long( dw_entry.object.henkou_date.x ) - long( dw_entry.object.henkou_date_t.width ) - 20
dw_entry.object.touroku_date.x	= long( dw_entry.object.henkou_date_t.x ) - long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x	= long( dw_entry.object.touroku_date.x ) - long( dw_entry.object.touroku_date_t.width ) - 20

//dw_list.x		= code.MGN_YOKO	//ReSize:変更なし
//dw_list.y		= dw_list.y	//ReSize:変更なし
dw_list.width	= newwidth - code.MGN_YOKO * 2	//ReSize:(新幅)-横マージン*2(左右)
dw_list.height	= newheight - dw_list.y - code.MGN_TATE - key_fnc.height	//ReSize:(新高さ)-自y(=固定部高さ)-縦マージン-ファンクション高さ

return 0

end event

event open;call super::open;
// 初期表示
of_set_firstfocus()
end event

event retrieve_event;call super::retrieve_event;
integer l_i // ループ処理用カウンタ(= m_mymenu.button_no)

dw_list.clear()

// データ取得
dw_list.retrieve(long(sle_kyoten_code.text),ddplb_key_syubetu.of_get_code_num(),ddplb_untin_kbn.of_get_code_num())

// 呼出部：ロック
ddplb_syori_kbn.enabled	= false
cb_retrieve.enabled = false
		
// 明細部：アンロック
dw_list.enabled = true

// [F5:Excel出力]ファンクション：アンロック
dw_list.f5_key = true

// [F6:戻り]ファンクション：アンロック
dw_list.f6_key = true

//if ddplb_syori_kbn.text = "照会" then
//	// [F12:更新]ファンクション：ロック
//	dw_list.f12_key = false
//else
//	// [F12:更新]ファンクション：アンロック
//	dw_list.f12_key = true
//end if

// フォーカスを明細部へ
dw_list.setfocus()

return 0
end event

event update_event;call super::update_event;
// 処理区分別対応
choose case ddplb_syori_kbn.text
	case "登録","変更","削除"
		setredraw(false)
		if ddplb_syori_kbn.text = "削除" then
			//行の削除
			dw_entry.deleterow(1)
		end if
		setredraw(true)
		
		// 更新 (accepttext実行、更新フラグはリセットしない)
		if not dw_entry.update(true,false) = 1 then
			msg.of_error(fnc.strg.of_format("{1}の{3}処理でエラーが発生しました。{2}{4}：{5}",this.title,code.crlf,ddplb_syori_kbn.text,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
			of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
			rollback using cocos;
			return 1
		end if

	case "照会"
		
end choose

msg.of_info(fnc.strg.of_format("{1}しました",ddplb_syori_kbn.text))

commit using cocos;

// 戻り処理
this.event key_f06(keyf6!,0)

return 0

end event

event key_f09;call super::key_f09;
// 初期表示リセット処理
this.event key_f06(keyf6!,0)	// 戻り処理

// 呼出部：入力項目リセット
ddplb_syori_kbn.text = "照会"

// 初期表示
of_set_firstfocus()

return 0
end event

event update_check;call super::update_check;
//入力確定


// 更新チェック
return 0 // チェック通過
end event

event key_f12;call super::key_f12;
// DW更新開始
if not of_evt_update(0,0) then
	return -1
end if

return 0

end event

event key_f06;call super::key_f06;
// 戻り処理(明細部⇒呼出部)
string l_key_code
string l_unso_code

// 排他ロック解放
if not of_record_lock(l_key_code,l_unso_code,false) then
	return -1
end if

// 明細部:データウィンドウをリセット
dw_list.reset()
dw_list.enabled = false

// 呼出部:項目ロックを解除
ddplb_syori_kbn.enabled	= true
cb_retrieve.enabled		= true

// 呼出条件1にフォーカス
cb_retrieve.setfocus()

return 0

end event

event closequery;call super::closequery;
// データ変更[排他ロック]中に終了される場合、
if uo_signal.of_get_status() then
	// 排他ロック解放する
	string l_key_code
	string l_unso_code
	if not of_record_lock(l_key_code,l_unso_code,false) then
		// ロック解放の成否は問わない
		//return 1
	end if
end if

// 処理継続
return 0

end event

event retrieve_check;call super::retrieve_check;
integer l_datacount	// 既存登録確認(件数取得して判断する)

string  l_kyoten_code
string  l_key_syubetu
string  l_untin_kbn
l_kyoten_code = sle_kyoten_code.text
l_key_syubetu = left(ddplb_key_syubetu.text,pos(ddplb_key_syubetu.text,"：")-1)
l_untin_kbn = left(ddplb_untin_kbn.text,pos(ddplb_untin_kbn.text,"：")-1)

// 登録データ件数取得
select	count(*)
  into	:l_datacount
  from 	m_untin
 where	kyoten_code = :l_kyoten_code
   and	key_syubetu = :l_key_syubetu
   and	untin_kbn   = :l_untin_kbn
 using	cocos;

if cocos.sqlcode <> 0 then
	// 通常エラーにはならない。想定外エラー
	msg.of_error(fnc.strg.of_format("{1}の検索処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
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

end choose

return 0
end event

type uo_signal from iw_main_window`uo_signal within wmm_untin
end type

type st_date from iw_main_window`st_date within wmm_untin
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_untin
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_untin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_untin
end type

type st_title from iw_main_window`st_title within wmm_untin
integer x = 2340
integer width = 440
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_untin
end type

type st_upper from iw_main_window`st_upper within wmm_untin
integer y = 4
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_untin
integer y = 139
boolean f9_key = true
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_untin
integer taborder = 20
boolean f9_key = true
boolean f10_key = true
end type

type st_syori_kbn from ivo_statictext within wmm_untin
integer x = 32
integer y = 160
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_list from ivo_datawindow within wmm_untin
integer y = 796
integer width = 4800
integer height = 1564
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_untin_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
boolean row_focus_ind = true
long input_ena_backcolor = 16777215
end type

event constructor;call super::constructor;
// データ転送オブジェクト設定
this.settransobject(cocos)

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

event doubleclicked;call super::doubleclicked;
// リストDクリック時処理

// 処理区分別対応
choose case ddplb_syori_kbn.text
	case "登録"
		// 登録時は明細部を使用しない
		//nop.
		
	case "照会"
		// 照会時は入力部を使用しない
		return 0
		
	case "変更","削除"
		// 入力部データ取得
//		dw_entry.retrieve(
//			string(this.object.kyoten_code[row]),
//			string(this.object.key_syubetu[row]),
//			string(this.object.key_code[row]),
//			string(this.object.unso_code[row]),
//			string(this.object.untin_kbn[row]))

		// [F12:更新]ファンクション：アンロック
		dw_entry.f12_key = true
		
end choose

end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_untin
integer x = 376
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

type dw_entry from ivo_datawindow within wmm_untin
integer y = 370
integer width = 4800
integer height = 427
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_untin_entry"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
// データ転送オブジェクト設定
this.settransobject(cocos)

this.insertrow(0)
end event

type st_kyoten_code from ivo_statictext within wmm_untin
integer x = 32
integer y = 263
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "出荷元拠点"
alignment alignment = right!
end type

type sle_kyoten_code from ivo_singlelineedit within wmm_untin
string tag = "名称区分"
integer x = 376
integer y = 256
integer width = 180
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
string text = ""
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean chk_required = true
boolean chk_digits = true
boolean chk_type_num = true
integer i_limit = 3
end type

event key_f08;call super::key_f08;
// モーダル検索：拠点
//str_mdlpara_meisyo_parent l_meisyo
//
//l_meisyo	= mdl.of_open_modal( "w_modal_meisyo_parent", l_meisyo )
//
//if l_meisyo.ret then
//	sle_meisyo_kbn.text	= l_meisyo.out_meisyo_code
//	st_meisyo_mei.text	= l_meisyo.out_meisyo_1
//end if
//
msg.of_info("sle_kyoten_code.Key_F08")
return 0
end event

event input_check;call super::input_check;
string	l_code
string	l_kyoten_code,l_kyoten_mei
integer	l_kengen

l_code	= trim(sle_kyoten_code.text)

// 必須チェック
if len(l_code) = 0 then
	msg.of_error_sle(this,fnc.strg.of_format("必須入力項目に値が設定されていません。[ {1} ]","拠点コード" ) )
	this.setfocus()
	return false
end if

// 存在チェック
select kyoten_mei
  into :st_kyoten_mei.text
  from m_kyoten
 where kyoten_code	= :l_code
using cocos;
	
choose case cocos.sqlcode
	case 0
		return true
	case 100
		// 入力コード:存在しない
		of_msg_error(fnc.strg.of_format("入力された{1}はマスタに存在しません。","拠点コード"))
		this.setfocus()
		return false
	case else
		// DBエラー
		of_msg_error(fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）",this.tag,code.crlf,fnc.strg.of_replace(cocos.sqlerrtext,code.lf," ")))
		this.setfocus()
		return false
end choose

return true

end event

type cb_kyoten_code from sv_cb_modal within wmm_untin
integer x = 560
integer y = 256
integer taborder = 40
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event execution;call super::execution;// 入力項目:F8キーイベント Raise
sle_kyoten_code.event key_f08(keyf8!,0)
end event

type st_kyoten_mei from sv_st_meisyo within wmm_untin
integer x = 668
integer y = 260
integer width = 488
boolean bringtotop = true
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_key_syubetu from ivo_statictext within wmm_untin
integer x = 1184
integer y = 263
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "登録区分"
alignment alignment = right!
end type

type st_untin_kbn from ivo_statictext within wmm_untin
integer x = 2240
integer y = 263
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "運賃区分"
alignment alignment = right!
end type

type ddplb_key_syubetu from sv_ddplb_meisyo within wmm_untin
integer x = 1536
integer y = 256
integer width = 736
integer height = 341
integer taborder = 50
boolean bringtotop = true
integer meisyo_kbn = 169
boolean code_visible = true
end type

type ddplb_untin_kbn from sv_ddplb_meisyo within wmm_untin
integer x = 2592
integer y = 256
integer width = 416
integer height = 341
integer taborder = 60
boolean bringtotop = true
integer meisyo_kbn = 168
boolean code_visible = true
string init_code = "2"
end type

