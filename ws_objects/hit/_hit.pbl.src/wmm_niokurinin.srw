$PBExportHeader$wmm_niokurinin.srw
$PBExportComments$荷送人登録
forward
global type wmm_niokurinin from iw_main_window
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_niokurinin
end type
type st_syori_kbn from ivo_statictext within wmm_niokurinin
end type
type dw_entry from ivo_datawindow within wmm_niokurinin
end type
type uo_niokurinin from cv_input_niokurinin within wmm_niokurinin
end type
end forward

global type wmm_niokurinin from iw_main_window
string title = "荷送人登録"
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
uo_niokurinin uo_niokurinin
end type
global wmm_niokurinin wmm_niokurinin

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long	i_niokurinin_code

	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時
	
end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_record_lock (long p_niokurinin_code, boolean p_lock)
end prototypes

public subroutine of_dsp_back ();
dw_entry.event constructor( )

of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		uo_niokurinin.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled

	case "dw_entry"

		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.object.syori_kbn.Expression = "'" + i_syori_kbn + "'"
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "kanri_mei" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if


end choose

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
ddplb_syori_kbn.event constructor( )
uo_niokurinin.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

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

update m_niokurinin
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "荷送人マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 参照設定
str_mdlpara_mtanto	l_mdl_tanto
str_mdlpara_mmeisyo	l_mdl_meisyo
//str_mdlpara_muser	l_mdl_user
str_mdlpara_myubin	l_mdl_yubin

// 照会はF8使用不可
if i_syori_kbn = "照会" then
	return
end if

// F8:参照
choose case p_dwo.name
	case "yubin_no", "b_yubin"
		l_mdl_yubin	= mdl.of_open_modal( "wsm_yubin", l_mdl_yubin )
		if upperbound( l_mdl_yubin.ret ) > 0 then
			p_dw.object.yubin_no[p_row]	= l_mdl_yubin.ret[1].yubin_no
			p_dw.object.jyusyo1[p_row]	= l_mdl_yubin.ret[1].todofu_mei + l_mdl_yubin.ret[1].sikutyo_mei + l_mdl_yubin.ret[1].tyoiki_mei
			p_dw.object.jyusyo2[p_row]	= l_mdl_yubin.ret[1].tyome
		end if

end choose


end subroutine

public function boolean of_record_lock (long p_niokurinin_code, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mn.rowid,mn.haita_flg,
       nvl( to_char( mn.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mn.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mn.henkou_client_id, '???' ),
       nvl( mn.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_niokurinin mn,
       m_user mu,
       m_window mw
	 where mn.henkou_user_id	= mu.user_id(+)
	   and mn.henkou_pg_id		= mw.window_id(+)
	   and mn.niokurinin_code	= :p_niokurinin_code
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

on wmm_niokurinin.create
int iCurrent
call super::create
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.uo_niokurinin=create uo_niokurinin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori_kbn
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.uo_niokurinin
end on

on wmm_niokurinin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_niokurinin)
end on

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width
long	l_row_1_y

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

// 呼出部
// 1行目
l_row_1_y			= st_second_upper.y + code.MGN_UPPER_TATE	// 1行目「MGN_UPPER_TATE:21」
ddplb_syori_kbn.y	= l_row_1_y
st_syori_kbn.y		= l_row_1_y + 7								// タイトル「+7」
uo_niokurinin.y		= l_row_1_y

// st_second_upper高さ
st_second_upper.height	= l_row_1_y + uo_niokurinin.height + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )


dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= key_fnc.y - code.MGN_TATE - dw_entry.y

// 登録日時＆変更日時
dw_entry.object.henkou_date.x		= dw_entry.width - long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x		= long( dw_entry.object.henkou_date.x ) - long( dw_entry.object.henkou_date_t.width ) - 20
dw_entry.object.touroku_date.x		= long( dw_entry.object.henkou_date_t.x ) - long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x	= long( dw_entry.object.touroku_date.x ) - long( dw_entry.object.touroku_date_t.width ) - 20


end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
//i_admin	= kengen.of_check_admin( )


end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0
end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック

//nv_master	mst
//str_mniokurinin	l_niokurinin[]
//
//i_syori_kbn	= ddplb_syori_kbn.text
//
//choose case i_syori_kbn
//	case "登録"
//		// 存在する場合エラー
//		if mst.of_niokurinin_check( uo_niokurinin.of_get_niokurinin_code( ) ) > 0 then
//			msg.of_error ( fnc.strg.of_format( "該当データが存在します。この処理は実行できません。", "" ) )
//			return -1
//		end if
//		
//	case "変更", "削除", "照会"
//		// 存在しない場合エラー
//		if not uo_niokurinin.event sle_input_check( ) then
//			return -1
//		end if
//
//end choose
//

if not uo_niokurinin.event sle_input_check( ) then
	return -1
end if


return 0

end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn			= ddplb_syori_kbn.text
i_niokurinin_code	= long( uo_niokurinin.of_get_input( ) )

choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor()
		if dw_entry.rowcount() = 0 then
			dw_entry.insertrow(0)
			dw_entry.object.niokurinin_code[1]	= i_niokurinin_code
		end if
		
	case "変更", "削除"
		// 排他処理
//		TODO:一時的にコメントアウト
//		if not of_record_lock( i_niokurinin_code, true ) then
//			return -1
//		end if
		if dw_entry.retrieve( i_niokurinin_code ) = 0 then
			msg.of_error( "入力した荷送人コードで登録されたデータはありません。" )
			uo_niokurinin.setfocus()
			return -1
		end if
	case "照会"
		if dw_entry.retrieve( i_niokurinin_code ) = 0 then
			msg.of_error( "入力した荷送人コードで登録されたデータはありません。" )
			uo_niokurinin.setfocus()
			return -1
		end if

end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

of_dsp_edit( "dw_entry", true )

// 一旦フォーカスを明細部へ
dw_entry.setfocus()



end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

if dw_entry.event itemchanged( l_row, dw_entry.object.kanri_mei, string( dw_entry.object.kanri_mei[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.yubin_no, string( dw_entry.object.yubin_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo1, string( dw_entry.object.jyusyo1[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo2, string( dw_entry.object.jyusyo2[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.niokurinin_mei, string( dw_entry.object.niokurinin_mei[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.tel_no, string( dw_entry.object.tel_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.memo, string( dw_entry.object.memo[l_row] ) ) <> 0 then
	return -1
end if


end event

event update_event;call super::update_event;long		l_row
long		l_count


choose case i_syori_kbn
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "荷送人マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
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
			msg.of_error( fnc.strg.of_format( "荷送人マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if

end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
of_dsp_back()

end event

type uo_signal from iw_main_window`uo_signal within wmm_niokurinin
end type

type st_date from iw_main_window`st_date within wmm_niokurinin
integer height = 75
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_niokurinin
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_niokurinin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_niokurinin
end type

type st_title from iw_main_window`st_title within wmm_niokurinin
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_niokurinin
end type

type st_upper from iw_main_window`st_upper within wmm_niokurinin
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_niokurinin
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_niokurinin
integer taborder = 40
integer textsize = -11
fontcharset fontcharset = shiftjis!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_niokurinin
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )
 
// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_niokurinin.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_niokurinin.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose

end event

type st_syori_kbn from ivo_statictext within wmm_niokurinin
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_niokurinin
integer y = 377
integer width = 5056
integer height = 1589
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_niokurinin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
long			l_row


// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
//		TODO:一時的にコメントアウト
//			of_record_lock( i_niokurinin_code, false )
	end choose
end if

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

//i_colname	= ""

this.reset()
this.settransobject(cocos)

end event

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

event itemchanged;call super::itemchanged;
string	l_input
string	l_colnm
string	l_tableid	= "m_niokurinin"
string	l_msg
nv_master	mst
str_myubin	l_yubin[]

l_input	= trim( data )
l_colnm	= dwo.tag		// タグ値で項目名を取得

// 入力チェック
choose case dwo.name

	case "kanri_mei"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case "yubin_no", "jyusyo1", "jyusyo2", "niokurinin_mei", "tel_no", "memo"
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別チェック
choose case dwo.name

	case "yubin_no"
		if lena( l_input ) > 0 then
			if mst.of_yubin_get_full( data, l_yubin ) > 0 then
				this.object.jyusyo1[row]		= l_yubin[1].todofu_mei + l_yubin[1].sikutyo_mei + l_yubin[1].tyoiki_mei
				this.object.jyusyo2[row]		= l_yubin[1].tyome
			else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			end if
		end if
	case else
end choose

return 0
end event

event itemfocuschanged;call super::itemfocuschanged;
// F8:参照の有効/無効設定

//i_colname	= dwo.name

choose case dwo.name
	case "yubin_no", "b_yubin"
		// 参照可能
		this.of_set_fnkey( keyf8!, true )
		
	case else
		// 参照不可
		this.of_set_fnkey( keyf8!, false )

end choose
end event

event key_f08;call super::key_f08;
// F8:参照
choose case this.getcolumnname()
	case "yubin_no", "b_yubin"
		// ユーザー 未実装
		of_reference( this, this.object.yubin_no, this.getrow() )

end choose


return 0
end event

event clicked;call super::clicked;
// F8:参照
choose case dwo.name
	case "b_yubin"
		// 参照起動
		of_reference( this, dwo, row )
		
end choose

end event

type uo_niokurinin from cv_input_niokurinin within wmm_niokurinin
integer x = 624
integer y = 153
integer width = 2292
integer taborder = 20
boolean bringtotop = true
boolean chk_required = true
long input_width = 208
long bikou_width = 0
end type

on uo_niokurinin.destroy
call cv_input_niokurinin::destroy
end on

