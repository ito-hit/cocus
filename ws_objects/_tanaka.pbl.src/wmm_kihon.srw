$PBExportHeader$wmm_kihon.srw
$PBExportComments$基本情報登録
forward
global type wmm_kihon from iw_main_window
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_kihon
end type
type st_syori_kbn from ivo_statictext within wmm_kihon
end type
type dw_entry from ivo_datawindow within wmm_kihon
end type
type uo_kanri_code from cv_input_kihon within wmm_kihon
end type
end forward

global type wmm_kihon from iw_main_window
string title = "基本情報登録"
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
uo_kanri_code uo_kanri_code
end type
global wmm_kihon wmm_kihon

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long	i_kanri_code
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
//	constant integer	c_act_update	= 5	// 更新時

	string	meisyo_code[]
	long	meisyo_code_num[]
	string	meisyo_mei[]

protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible

	// 初期選択させておきたい名称コード
	string	init_code
	
	integer	i_idx


end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_back ()
public function boolean of_chk_digit_ora (singlelineedit p_sle, string p_column_name, integer p_inp_digit)
public subroutine of_dsp_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_record_lock (long p_kanri_code, boolean p_lock)
public function boolean of_record_lock (boolean p_lock)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		uo_kanri_code.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
end choose
end subroutine

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_entry.event constructor( )
of_set_secondfocus( )

end subroutine

public function boolean of_chk_digit_ora (singlelineedit p_sle, string p_column_name, integer p_inp_digit);
// Oracle定義を見て桁数チェック

constant string	c_table_name	= "m_kihon"

string	l_col_type
integer	l_col_length

// 登録可能桁数取得
//if not fnc.db.of_get_column_info( c_table_name, p_column_name, l_col_type, l_col_length ) then
//	msg.of_error_sle( p_sle, "登録可能な桁数の取得に失敗しました。" )
//	return false
//end if
		
// 桁数チェック
if l_col_length < p_inp_digit then
	msg.of_error_sle( p_sle, fnc.strg.of_format( "入力可能な桁数を超えています。（入力桁数：{1}／最大桁数：{2}）", string( p_inp_digit ), string( l_col_length ) ) )

	return false
end if

return true
end function

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn = ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
ddplb_syori_kbn.event constructor( )
uo_kanri_code.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_kihon
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "基本情報マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装あり

/*
// 参照設定
str_mdlpara_mtanto	l_mdl_tanto
str_mdlpara_mmeisyo	l_mdl_meisyo
//str_mdlpara_muser	l_mdl_user

// F8:参照
choose case p_dwo.name
	case "nayose_code", "b_nayose"
		// 名寄せ
		l_mdl_tanto	= mdl.of_open_modal( "wsm_tanto", l_mdl_tanto )
		if upperbound( l_mdl_tanto.ret ) > 0 then
			p_dw.object.nayose_code[p_row]	= l_mdl_tanto.ret[1].tanto_code
			p_dw.object.nayose_mei[p_row]	= l_mdl_tanto.ret[1].tanto_mei
		end if

	case "bumon_code", "b_bumon"
		// 部門
		l_mdl_meisyo.in_meisyo_kbn	= 21
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo_parent", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.bumon_code[p_row]	= l_mdl_meisyo.ret[1].meisyo_code
			p_dw.object.bumon_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
		end if
		
	case "eigyosyo_code", "b_eigyosyo"
		// 営業所
		l_mdl_meisyo.in_meisyo_kbn	= 22
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo_parent", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.eigyosyo_code[p_row]	= l_mdl_meisyo.ret[1].meisyo_code
			p_dw.object.eigyosyo_mei[p_row]		= l_mdl_meisyo.ret[1].meisyo_1
		end if
	case "ka_code", "b_ka"
		// 課
		l_mdl_meisyo.in_meisyo_kbn	= 23
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo_parent", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.ka_code[p_row]	= l_mdl_meisyo.ret[1].meisyo_code
			p_dw.object.ka_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
		end if
	case "user_id", "b_user"
		// ユーザー 未実装

end choose

*/


// 未実装あり

// 参照設定
str_mdlpara_mnendo	l_mdl_nendo

// 照会はF8使用不可
if i_syori_kbn = "照会" then
	return
end if

// F8:参照
choose case p_dwo.name
	case "jigyo_nendo", "b_jigyo_nendo"
		// 事業年度
		l_mdl_nendo	= mdl.of_open_modal( "wsm_nendo", l_mdl_nendo )
		if upperbound( l_mdl_nendo.ret ) > 0 then
			p_dw.object.jigyo_nendo[p_row]	= l_mdl_nendo.ret[1].nendo_code
			p_dw.object.jigyo_nendo_mei[p_row]	= l_mdl_nendo.ret[1].nendo_mei
		end if
		
end choose


end subroutine

public function boolean of_record_lock (long p_kanri_code, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mk.rowid,mk.haita_flg,
       nvl( to_char( mk.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mk.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mk.henkou_client_id, '???' ),
       nvl( mk.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_kihon mk,
       m_user mu,
       m_window mw
	 where mk.henkou_user_id= mu.user_id(+)
	   and mk.henkou_pg_id	= mw.window_id(+)
	   and mk.kanri_code	= :p_kanri_code
   for update
using cocos;
	
choose case cocos.sqlcode
	case 0
		if l_henkou_user_id <> user.user_id then
			if l_haita_flg <> 0 then
				rollback using cocos;
				msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
				return false
			end if
		end if

		// commitはこっちで行う
		return of_record_lock_rowid( l_rowid, p_lock )
	case 100
		rollback using cocos;
		msg.of_error( "対象レコードが存在しません。" )
	case else
		rollback using cocos;
		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
		return false
end choose

return false

end function

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_kihon_lock( i_pg_id, i_kanri_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_kihon_unlock( i_pg_id, i_kanri_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if

// 
uo_signal.of_on_signal( p_lock )


return true
end function

on wmm_kihon.create
int iCurrent
call super::create
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.uo_kanri_code=create uo_kanri_code
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori_kbn
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.uo_kanri_code
end on

on wmm_kihon.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_kanri_code)
end on

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not uo_kanri_code.event sle_input_check( ) then
	return -1
end if
end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_kanri_code	= long(uo_kanri_code.of_get_input())


choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor()
		dw_entry.object.kanri_code[1]		= i_kanri_code
		if dw_entry.rowcount() = 0 then
			dw_entry.insertrow(0)

		end if
		
	case "変更", "削除"
		// 排他処理
		if not of_record_lock( true ) then
			return -1
		end if
		if dw_entry.retrieve( i_kanri_code ) = 0 then
			msg.of_error( "入力した管理コードで登録されたデータはありません。" )
			uo_kanri_code.setfocus()
			return -1
		end if
	case "照会"
		if dw_entry.retrieve( i_kanri_code ) = 0 then
			msg.of_error( "入力した管理コードで登録されたデータはありません。" )
			uo_kanri_code.setfocus()
			return -1
		end if

end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

dw_entry.setfocus()



end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0
end event

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if



dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= key_fnc.y - code.MGN_TATE - dw_entry.y


// DWの登録日時と変更日時

dw_entry.object.henkou_date.x = dw_entry.width -long( dw_entry.object.henkou_date.width ) - 40
dw_entry.object.henkou_date_t.x = long( dw_entry.object.henkou_date.x ) -long( dw_entry.object.henkou_date_t.width ) - 20

dw_entry.object.touroku_date.x = long( dw_entry.object.henkou_date_t.x ) -long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x = long( dw_entry.object.touroku_date.x ) -long( dw_entry.object.touroku_date_t.width ) - 20

end event

event update_event;call super::update_event;
long		l_row
long		l_count


choose case i_syori_kbn
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "基本情報登録の登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if
		
	case "削除"

		//行の削除
		l_count = dw_entry.rowcount()
		for l_row = 1 to l_count
			dw_entry.deleterow(1)
		next
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "基本情報登録の登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if
		
end choose

// ログ出力( イベントID, エラーコード, メッセージ )
of_add_db_log( "update_event", 0, st_title.text + "[" + string( uo_kanri_code.of_get_kanri_code( ) ) + " " + trim( uo_kanri_code.of_get_kaisya_mei( ))+"]" + i_syori_kbn )


msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
of_dsp_back()

end event

event update_check;call super::update_check;
long	l_row
long	l_nayose_code
long	l_cnt

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

if dw_entry.event itemchanged( l_row, dw_entry.object.kaisya_mei, string( dw_entry.object.kaisya_mei[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.kaisya_mei_ryaku, string( dw_entry.object.kaisya_mei_ryaku[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.yubin_no, string( dw_entry.object.yubin_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo, string( dw_entry.object.jyusyo[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.tel_no, string( dw_entry.object.tel_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.fax_no, string( dw_entry.object.fax_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jigyosya_code, string( dw_entry.object.jigyosya_code[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.houjin_no, string( dw_entry.object.houjin_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jigyo_nendo, string( dw_entry.object.jigyo_nendo[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.syori_date, string( dw_entry.object.syori_date[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.uriage_sime_date, string( dw_entry.object.uriage_sime_date[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.siire_sime_date, string( dw_entry.object.siire_sime_date[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.zei_hasuu_uriage, string( dw_entry.object.zei_hasuu_uriage[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.zeiritu_henpin_str_date, string( dw_entry.object.zeiritu_henpin_str_date[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.zeiritu_henpin_end_date, string( dw_entry.object.zeiritu_henpin_end_date[l_row] ) ) <> 0 then
	return -1
end if

end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0
end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
end if
end event

type uo_signal from iw_main_window`uo_signal within wmm_kihon
end type

type st_date from iw_main_window`st_date within wmm_kihon
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_kihon
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_kihon
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_kihon
end type

type st_title from iw_main_window`st_title within wmm_kihon
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_kihon
end type

type st_upper from iw_main_window`st_upper within wmm_kihon
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_kihon
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_kihon
integer taborder = 30
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_kihon
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "変更"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.event selectionchanged( i_idx )

setnull( i_syori_kbn )


end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )
i_syori_kbn	= trim( this.text )
 
// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_kanri_code.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_kanri_code.of_set_dbchk_exst( )

	case else
		// 何もしない
end choose
end event

type st_syori_kbn from ivo_statictext within wmm_kihon
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_kihon
integer y = 377
integer width = 4152
integer height = 1380
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_kihon"
boolean hscrollbar = true
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		if this.rowcount() > 0 then
			this.of_set_fnkey( keyf12!, true )
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )
end event

event constructor;call super::constructor;
DataWindowChild	ldwc
long		init_row
integer		l_code_visible
long	l_row
string l_rowid

//this.reset()
//this.settransobject(cocos)

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "zei_hasuu_uriage", ldwc)
ldwc.settransobject( cocos )

meisyo_kbn		= 102
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
			of_record_lock( false )
	end choose
end if

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

this.reset()
this.insertrow(0)
this.settransobject(cocos)

end event

event clicked;call super::clicked;
// F8:参照
choose case dwo.name
	case "b_jigyo_nendo"
		// 参照起動
		of_reference( this, dwo, row )
		
end choose


//// F8:参照
//choose case dwo.name
//	case "b_nayose", "b_bumon", "b_eigyosyo", "b_ka", "b_user"
//		// 参照起動
//		of_reference( this, dwo, row )
//		
//end choose

end event

event itemfocuschanged;call super::itemfocuschanged;
// F8:参照の有効/無効設定

choose case dwo.name
	case "jigyo_nendo"
		// 参照可能
		this.of_set_fnkey( keyf8!, true )
		
	case else
		// 参照不可
		this.of_set_fnkey( keyf8!, false )

end choose
end event

event itemchanged;call super::itemchanged;
long	l_code
string	l_mei
long	l_cnt
string	l_syori_date
string  l_uriage_sime_date
string	l_siire_sime_date
string  l_zeiritu_henpin_str_date
string  l_zeiritu_henpin_end_date

string	l_input
string	l_colnm
string	l_tableid	= "m_kihon"
string	l_msg

string	l_meisyo_code,l_meisyo_mei

// 入力チェック
choose case dwo.name
	case "kaisya_mei","kaisya_mei_ryaku","jigyo_nendo","zeiritu_henpin_str_date","zeiritu_henpin_end_date"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
case "kaisya_mei","kaisya_mei_ryaku","yubin_no","jyusyo","tel_no","fax_no","jigyosya_code","houjin_no"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別チェック
choose case dwo.name
	case "jigyo_nendo"
		if lena( trim( data ) ) > 0 then
			l_input	= trim( data )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
		
			if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

			// 存在チェック
			select nendo_mei
			  into :l_mei
			  from m_nendo
			 where nendo_code	= :data
			using cocos	;
				
			choose case cocos.sqlcode
				case 0
					this.object.jigyo_nendo_mei[row]		= trim( l_mei )
				case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		end if


	case "syori_date_inp"


		if  data=""  then
			msg.of_error_dwo( dw_entry.object.syori_date_inp, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "基本情報登録" ) )
			return 1
		end if
		
		l_syori_date = fnc.db.of_date_format( data )
		
		//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    if not IsDate(l_syori_date) THEN
        	return 1
    	
		else
			this.object.syori_date[row]		= long( string( date(l_syori_date), "yyyymmdd" ) )
			this.object.syori_date_inp[row]		= l_syori_date

		
			l_input	= string( this.object.syori_date[row] )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, "syori_date", l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

//			return 2	
		end if
		
	case "uriage_sime_date_inp"

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.uriage_sime_date_inp, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "基本情報登録" ) )
			return 1
		end if
		
		l_uriage_sime_date = fnc.db.of_date_format( data )
		
		//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    if not IsDate(l_uriage_sime_date) THEN
        	return 1
    	
		else
			this.object.uriage_sime_date[row]		= long( string( date(l_uriage_sime_date), "yyyymmdd" ) )
			this.object.uriage_sime_date_inp[row]		= l_uriage_sime_date

		
			l_input	= string( this.object.uriage_sime_date[row] )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, "uriage_sime_date", l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

//			return 2	
		end if

	case "siire_sime_date_inp"

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.siire_sime_date_inp, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "基本情報登録" ) )
			return 1
		end if

		l_siire_sime_date = fnc.db.of_date_format( data )
		
		//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    if not IsDate(l_siire_sime_date) THEN
        	return 1
    	
		else
			this.object.siire_sime_date[row]		= long( string( date(l_siire_sime_date), "yyyymmdd" ) )
			this.object.siire_sime_date_inp[row]		= l_siire_sime_date

		
			l_input	= string( this.object.siire_sime_date[row] )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, "siire_sime_date", l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

//			return 2	
		end if

	case "zei_hasuu_uriage"
							
		l_mei	= data 
	
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.zei_hasuu_uriage, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
		
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 102
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.zei_hasuu_uriage[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("zei_hasuu_uriage.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	if integer(this.object.zei_hasuu_uriage[row])=9 then
		msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}は選択できません。", describe(dwo.name + ".tag")))
		return 1
	end if
				
				
	case "zeiritu_henpin_str_date_inp"

		l_zeiritu_henpin_str_date = fnc.db.of_date_format( data )
		
		//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    if not IsDate(l_zeiritu_henpin_str_date) THEN
        	return 1
    	
		else
			this.object.zeiritu_henpin_str_date[row]		= long( string( date(l_zeiritu_henpin_str_date), "yyyymmdd" ) )
			this.object.zeiritu_henpin_str_date_inp[row]		= l_zeiritu_henpin_str_date

		
			l_input	= string( this.object.zeiritu_henpin_str_date[row] )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, "zeiritu_henpin_str_date", l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

//			return 2	
		end if
		
	case "zeiritu_henpin_end_date_inp"

		l_zeiritu_henpin_end_date = fnc.db.of_date_format( data )
		
		//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    if not IsDate(l_zeiritu_henpin_end_date) THEN
        	return 1
    	
		else
			this.object.zeiritu_henpin_end_date[row]		= long( string( date(l_zeiritu_henpin_end_date), "yyyymmdd" ) )
			this.object.zeiritu_henpin_end_date_inp[row]		= l_zeiritu_henpin_end_date

		
			l_input	= string( this.object.zeiritu_henpin_str_date[row] )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, "zeiritu_henpin_str_date", l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if

//			return 2	
		end if

	case else
end choose

setredraw( true )
return 0
end event

event key_f08;call super::key_f08;
// F8:参照
choose case this.getcolumnname()
//choose case i_colname
	case "jigyo_nendo", "b_jigyo_nendo"
		// 事業年度
		of_reference( this, this.object.jigyo_nendo, this.getrow() )
		
end choose


return 0
end event

type uo_kanri_code from cv_input_kihon within wmm_kihon
string tag = "管理コード"
integer x = 40
integer y = 256
integer taborder = 20
boolean bringtotop = true
end type

on uo_kanri_code.destroy
call cv_input_kihon::destroy
end on

event sle_input_check;call super::sle_input_check;

string	l_code
//string	l_hin_ban
//string	l_hin_mei
//string	l_syusoku_flg
//long	l_cnt

//l_code		= trim( sle_syohin_code.text )
l_code		=string( uo_kanri_code.of_get_input( ) )

i_syori_kbn	= ddplb_syori_kbn.text
//
//// 必須チェック
//if len( l_code ) = 0 then
////	msg.of_error( this, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ) )
//	this.setfocus()
//	return false
//end if

// 必須チェック
if len( l_code ) = 0 then
	msg.of_error(fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ))
	this.setfocus()
	return false
end if

/*
//

string	l_code
integer	l_syusoku_flg
string	l_input
string	l_colnm
string	l_tableid	= "m_ryutu_kako"
string	l_msg

l_code	= trim( of_get_input( ) )
//l_code		= string( uo_tokui_tanto.text )

// 存在チェック
select syusoku_flg
  into :l_syusoku_flg
  from m_tokui
 where tokui_code	= to_number( :l_code )
using cocos;

messagebox("test",string(l_syusoku_flg))
choose case cocos.sqlcode
	case 0
		if l_syusoku_flg=1 then
			//msg.of_error_sle( this, fnc.strg.of_format( "選択している得意先は終息しているため、この処理は実行できません。", "" ) )
			msg.of_error( "選択している得意先は終息しているため、この処理は実行できません。")

			this.setfocus()
			return false
		end if
	case 100
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		this.setfocus()
		return false
	case else
//		msg.of_error_sle( this, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )

		this.setfocus()
		return false
end choose
*/

return true


end event

