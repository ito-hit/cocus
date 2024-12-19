$PBExportHeader$ws_tokui_mise.srw
$PBExportComments$得意先＆店検索
forward
global type ws_tokui_mise from iw_main_window
end type
type dw_list from ivo_datawindow within ws_tokui_mise
end type
type st_jyusyo from ivo_statictext within ws_tokui_mise
end type
type sle_jyusyo from ivo_singlelineedit within ws_tokui_mise
end type
type sle_kana_mei from ivo_singlelineedit within ws_tokui_mise
end type
type st_kana_mei from ivo_statictext within ws_tokui_mise
end type
type sle_meisyo from ivo_singlelineedit within ws_tokui_mise
end type
type st_meisyo from ivo_statictext within ws_tokui_mise
end type
type st_tel_fax from ivo_statictext within ws_tokui_mise
end type
type sle_tel_fax from ivo_singlelineedit within ws_tokui_mise
end type
type st_todofuken from ivo_statictext within ws_tokui_mise
end type
type ddplb_todofuken from ivo_dropdownpicturelistbox within ws_tokui_mise
end type
type cb_clear from ivo_commandbutton within ws_tokui_mise
end type
type ddplb_tokuisaki_mei from ivo_dropdownpicturelistbox within ws_tokui_mise
end type
type st_tokuisaki_mei from ivo_statictext within ws_tokui_mise
end type
type ddplb_mise_mei from ivo_dropdownpicturelistbox within ws_tokui_mise
end type
type st_mise_mei from ivo_statictext within ws_tokui_mise
end type
type st_kakukoumoku from ivo_statictext within ws_tokui_mise
end type
end forward

global type ws_tokui_mise from iw_main_window
integer width = 6684
string title = "得意先＆店検索"
windowanimationstyle closeanimation = rightroll!
boolean confirm_update = false
dw_list dw_list
st_jyusyo st_jyusyo
sle_jyusyo sle_jyusyo
sle_kana_mei sle_kana_mei
st_kana_mei st_kana_mei
sle_meisyo sle_meisyo
st_meisyo st_meisyo
st_tel_fax st_tel_fax
sle_tel_fax sle_tel_fax
st_todofuken st_todofuken
ddplb_todofuken ddplb_todofuken
cb_clear cb_clear
ddplb_tokuisaki_mei ddplb_tokuisaki_mei
st_tokuisaki_mei st_tokuisaki_mei
ddplb_mise_mei ddplb_mise_mei
st_mise_mei st_mise_mei
st_kakukoumoku st_kakukoumoku
end type
global ws_tokui_mise ws_tokui_mise

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str

end variables

forward prototypes
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public subroutine of_filter_make ()
public subroutine of_filter_set ()
end prototypes

public subroutine of_dsp_reset ();
// constructorで各コントロールリセット

//uo_tokui.event constructor( )
//sle_touroku_date_from.event constructor( )
//sle_touroku_date_to.event constructor( )
//uo_bumon.event constructor( )
//uo_eigyo.event constructor( )
//uo_ka.event constructor( )
//sle_mise_mei.event constructor( )
//ddplb_todofuken.event constructor( )
//cbx_heiten_flg.event constructor( )
//cbx_syusoku_flg.event constructor( )

sle_meisyo.event constructor( )
sle_kana_mei.event constructor( )
sle_jyusyo.event constructor( )
sle_tel_fax.event constructor( )
dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_dsp_back ();dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_filter_make ();
// フィルター条件セット
long	l_row
string	l_todofuken
string	l_tokuisaki_mei
string	l_mise_mei

string	l_msg

long	l_rtn

// 初期化
ddplb_todofuken.event constructor( )
//ddplb_msg.event constructor( )
ddplb_tokuisaki_mei.event constructor( )
ddplb_mise_mei.event constructor( )

for l_row = 1 to dw_list.rowcount()
	
	l_todofuken	    = dw_list.object.mei_todofuken[l_row]
	l_tokuisaki_mei	= dw_list.object.tokui_mei[l_row]	
	l_mise_mei	    = dw_list.object.mise_mei[l_row]	
	
//	l_msg		= dw_list.object.msg[l_row]
	
	// 都道府県
	l_rtn	= ddplb_todofuken.FindItem( l_todofuken, 0 )
	
	if ddplb_todofuken.FindItem( l_todofuken, 0 ) = -1 then
		ddplb_todofuken.insertitem( l_todofuken, upperbound( ddplb_todofuken.item ) + 1 )
	end if
	// メッセージ
//	if ddplb_msg.finditem( l_msg, 0 ) = -1 then
//		ddplb_msg.insertitem( l_msg, upperbound( ddplb_msg.item ) + 1 )
//	end if


	// 得意先名
	if ddplb_tokuisaki_mei.FindItem( l_tokuisaki_mei, 0 ) = -1 then
		ddplb_tokuisaki_mei.insertitem( l_tokuisaki_mei, upperbound( ddplb_tokuisaki_mei.item ) + 1 )
	end if
	
	// 店名
	if ddplb_mise_mei.FindItem( l_mise_mei, 0 ) = -1 then
		ddplb_mise_mei.insertitem( l_mise_mei, upperbound( ddplb_mise_mei.item ) + 1 )
	end if

next


ddplb_todofuken.sorted = true
ddplb_tokuisaki_mei.sorted = true
ddplb_mise_mei.sorted = true
end subroutine

public subroutine of_filter_set ();
// フィルター実行

string	l_todofuken
string	l_tokuisaki_mei
string	l_mise_mei

string	l_msg

integer	l_row
string	l_filter	= ""

//if dw_list.rowcount() = 0 then
//	return
//end if

l_todofuken	= ddplb_todofuken.text
l_tokuisaki_mei	= ddplb_tokuisaki_mei.text
l_mise_mei	= ddplb_mise_mei.text

//l_msg		= ddplb_msg.text

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()

// 都道府県
if l_todofuken <> "(未選択)" then
	l_filter	+= "and mei_todofuken = '" + l_todofuken + "'"
//	l_filter	= "status like '%" + l_status + "%'"
end if

// 得意先名
if l_tokuisaki_mei <> "(未選択)" then
	l_filter	+= "and tokui_mei = '" + l_tokuisaki_mei + "'"
//	l_filter	= "status like '%" + l_status + "%'"
end if

// 店名
if l_mise_mei <> "(未選択)" then
	l_filter	+= "and mise_mei = '" + l_mise_mei + "'"
//	l_filter	= "status like '%" + l_status + "%'"
end if

if l_filter <> "" then
	l_filter = Mid(l_filter, 4) // 最初の3文字を削除
end if

//comment LIKE ~'%o_a15progress%~'
//comment like ~'%o*_a15progress%~' escape ~'*~' 

// メッセージ
//if l_msg <> "(未選択)" then
//	if len( l_filter ) <> 0 then
//		l_filter	= l_filter + " and msg = '" + l_msg + "'"
//	else
//		l_filter	= "msg = '" + l_msg + "'"
//	end if
//end if

if len( l_filter ) <> 0 then
	// フィルタセット
	dw_list.setfilter( l_filter )
	dw_list.filter()
else
	// フィルタのリセット
	dw_list.setfilter( "" )
	dw_list.filter()
	
end if

// 選択行にスクロール
//dw_list.scrolltorow( l_row )

dw_list.SetSort("#2 A, #6 A")
dw_list.Sort()

dw_list.setredraw( true )
end subroutine

on ws_tokui_mise.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_jyusyo=create st_jyusyo
this.sle_jyusyo=create sle_jyusyo
this.sle_kana_mei=create sle_kana_mei
this.st_kana_mei=create st_kana_mei
this.sle_meisyo=create sle_meisyo
this.st_meisyo=create st_meisyo
this.st_tel_fax=create st_tel_fax
this.sle_tel_fax=create sle_tel_fax
this.st_todofuken=create st_todofuken
this.ddplb_todofuken=create ddplb_todofuken
this.cb_clear=create cb_clear
this.ddplb_tokuisaki_mei=create ddplb_tokuisaki_mei
this.st_tokuisaki_mei=create st_tokuisaki_mei
this.ddplb_mise_mei=create ddplb_mise_mei
this.st_mise_mei=create st_mise_mei
this.st_kakukoumoku=create st_kakukoumoku
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_jyusyo
this.Control[iCurrent+3]=this.sle_jyusyo
this.Control[iCurrent+4]=this.sle_kana_mei
this.Control[iCurrent+5]=this.st_kana_mei
this.Control[iCurrent+6]=this.sle_meisyo
this.Control[iCurrent+7]=this.st_meisyo
this.Control[iCurrent+8]=this.st_tel_fax
this.Control[iCurrent+9]=this.sle_tel_fax
this.Control[iCurrent+10]=this.st_todofuken
this.Control[iCurrent+11]=this.ddplb_todofuken
this.Control[iCurrent+12]=this.cb_clear
this.Control[iCurrent+13]=this.ddplb_tokuisaki_mei
this.Control[iCurrent+14]=this.st_tokuisaki_mei
this.Control[iCurrent+15]=this.ddplb_mise_mei
this.Control[iCurrent+16]=this.st_mise_mei
this.Control[iCurrent+17]=this.st_kakukoumoku
end on

on ws_tokui_mise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.st_jyusyo)
destroy(this.sle_jyusyo)
destroy(this.sle_kana_mei)
destroy(this.st_kana_mei)
destroy(this.sle_meisyo)
destroy(this.st_meisyo)
destroy(this.st_tel_fax)
destroy(this.sle_tel_fax)
destroy(this.st_todofuken)
destroy(this.ddplb_todofuken)
destroy(this.cb_clear)
destroy(this.ddplb_tokuisaki_mei)
destroy(this.st_tokuisaki_mei)
destroy(this.ddplb_mise_mei)
destroy(this.st_mise_mei)
destroy(this.st_kakukoumoku)
end on

event resize;call super::resize;
// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

//st_second_upper.height	= 821
//cb_retrieve.y			= 836

st_second_upper.height	= 359

long	l_width

// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if


/*
// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
uo_tokui.y				= l_row_1_y
st_touroku_date_from.y	= l_row_1_y + 7
sle_touroku_date_from.y	= l_row_1_y
st_touroku_date_to.y	= l_row_1_y + 7
sle_touroku_date_to.y	= l_row_1_y
cbx_heiten_flg.y		= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + uo_tokui.height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_bumon.y			= l_row_2_y
uo_eigyo.y			= l_row_2_y
uo_ka.y				= l_row_2_y
cbx_syusoku_flg.y	= l_row_2_y

// 3行目
l_row_3_y	= l_row_2_y + uo_bumon.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_mise_mei.y		= l_row_3_y + 7
sle_mise_mei.y		= l_row_3_y
st_mise_mei_aimai.y	= l_row_3_y + 7
st_todofuken.y		= l_row_3_y + 7
ddplb_todofuken.y	= l_row_3_y
*/


// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
st_meisyo.y	= l_row_1_y + 7
sle_meisyo.y				= l_row_1_y


// 2行目
l_row_2_y	= l_row_1_y + sle_meisyo.height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
st_kana_mei.y			= l_row_2_y+7
sle_kana_mei.y			= l_row_2_y


// 3行目
l_row_3_y	= l_row_2_y + sle_kana_mei.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_jyusyo.y		= l_row_3_y + 7
sle_jyusyo.y		= l_row_3_y

// st_second_upper高さ
st_second_upper.height	= l_row_3_y + sle_jyusyo.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y





// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// フィルター部
st_todofuken.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_todofuken.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE

st_tokuisaki_mei.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_tokuisaki_mei.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE

st_mise_mei.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_mise_mei.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE

//st_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
//ddplb_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.x			= l_width - cb_clear.width - code.MGN_YOKO

// dw_list
//dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
//dw_list.x				= code.MGN_YOKO
//dw_list.width			= newwidth - code.MGN_YOKO * 2
//dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
dw_list.y			= cb_clear.y + cb_clear.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event openquery;call super::openquery;i_str	= create nv_string
end event

event close;call super::close;
destroy i_str
end event

event retrieve_event;call super::retrieve_event;string	l_sql_old, l_sql_new, l_sql_where, l_sql_tail

long	l_tokui_code, l_touroku_date_to, l_touroku_date_from
long	l_bumon_code, l_eigyo_code, l_ka_code, l_todofuken_code

string  l_meisyo
string  l_kana_mei
string  l_jyusyo
string  l_tel_fax

string	l_mise_mei

boolean	l_heiten_flg, l_syusoku_flg


// 検索条件に入力された内容をインスタンス変数に保持

//if sle_touroku_date_from.text <> "" then
//	l_touroku_date_from		= long( i_str.of_replace( sle_touroku_date_from.text, "/", "" ) )
//else
//	l_touroku_date_from		= 0
//end if
//
//if sle_touroku_date_to.text <> "" then
//	l_touroku_date_to		= long( i_str.of_replace( sle_touroku_date_to.text, "/", "" ) )
//else
//	l_touroku_date_to		= 0
//end if
//
//if sle_mise_mei.text <> "" then
//	l_mise_mei		= sle_mise_mei.text
//else
//	l_mise_mei		= ""
//end if
//
//l_tokui_code		= uo_tokui.of_get_tokui_code()
//l_bumon_code		= long( uo_bumon.of_get_meisyo_code() )
//l_eigyo_code		= long( uo_eigyo.of_get_meisyo_code() )
//l_ka_code			= long( uo_ka.of_get_meisyo_code() )
//l_todofuken_code	= ddplb_todofuken.of_get_code_num( )
//l_heiten_flg		= cbx_heiten_flg.checked
//l_syusoku_flg		= cbx_syusoku_flg.checked

if sle_meisyo.text <> "" then
	l_meisyo		= sle_meisyo.text
else
	l_meisyo		= ""
end if

if sle_kana_mei.text <> "" then
	l_kana_mei		= sle_kana_mei.text
else
	l_kana_mei		= ""
end if

if sle_jyusyo.text <> "" then
	l_jyusyo		= sle_jyusyo.text
else
	l_jyusyo		= ""
end if

if sle_tel_fax.text <> "" then
	l_tel_fax		= sle_tel_fax.text
else
	l_tel_fax		= ""
end if

// 元のSQLを取得
l_sql_old	= dw_list.getsqlselect( )


// ## 条件作成 ## //

//// 得意先
//if l_tokui_code <> -1 then
//	l_sql_where	+= "   and mise.tokui_code          = " + string( l_tokui_code ) + code.crlf
//end if
//
//// 登録日(開始)
//if l_touroku_date_from <> 0 then
//	l_sql_where	+= "   and trunc( tokui.touroku_date )          >= '" + fnc.db.of_date_format( string( l_touroku_date_from ) ) + "'" + code.crlf
//end if
//
//// 登録日(終了日)
//if l_touroku_date_to <> 0 then
//	l_sql_where	+= "   and trunc( tokui.touroku_date )          <= '" + fnc.db.of_date_format( string( l_touroku_date_to ) ) + "'" + code.crlf
//end if
//
//// 部門
//if l_bumon_code <> 0 then
//	l_sql_where	+= "   and tokui.bumon_code          = " + string( l_bumon_code ) + code.crlf
//end if
//
//// 営業所
//if l_eigyo_code <> 0 then
//	l_sql_where	+= "   and tanto.eigyosyo_code          = " + string( l_eigyo_code ) + code.crlf
//end if
//
//// 課
//if l_ka_code <> 0 then
//	l_sql_where	+= "   and tanto.ka_code          = " + string( l_ka_code ) + code.crlf
//end if
//
//// 都道府県
////if l_todofuken_code <> 0 then
////if ddplb_todofuken.text <> "" then
//if not isnull(l_todofuken_code) then
//	l_sql_where	+= "   and mise.todofuken_code          = " + string( l_todofuken_code ) + code.crlf
//end if

//// 店名（曖昧検索）
//if l_mise_mei <> "" then
//	l_sql_where	+= "   and replace(replace( mise.mise_mei,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_mise_mei ) + "','　' ),' ') || '%'" + code.crlf
//end if
//
//// 閉店を含む
//if not l_heiten_flg then
//	l_sql_where	+= "   and mise.heiten_flg     <> 1 " + code.crlf
//end if
//
//// 終息店を含む
//if not l_syusoku_flg then
//	l_sql_where	+= "and mise.syusoku_flg           <> 1" + code.crlf
//end if

// 名称
if l_meisyo <> "" then
	l_sql_where	+= "AND  (replace(replace( wk.tokui_mei,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_meisyo ) + "','　' ),' ') || '%'" + code.crlf
	l_sql_where	+= "   OR  replace(replace( wk.mise_mei,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_meisyo ) + "','　' ),' ') || '%'" + code.crlf
	l_sql_where	+= "   OR  replace(replace( wk.seisiki_mei,'　' ),' ')       LIKE '%' || replace(replace( '" + string( l_meisyo ) + "','　' ),' ') || '%'" + code.crlf
	l_sql_where	+= "   OR  replace(replace( wk.syagai_mei,'　' ),' ')        LIKE '%' || replace(replace( '" + string( l_meisyo ) + "','　' ),' ') || '%')" + code.crlf

end if

// カナ名
if l_kana_mei <> "" then
	l_sql_where	+= "AND  replace(replace( wk.kana_mei,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_kana_mei ) + "','　' ),' ') || '%'" + code.crlf
end if

// 住所
if l_jyusyo <> "" then
	l_sql_where	+= "AND  replace(replace( wk.jyusyo,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_jyusyo ) + "','　' ),' ') || '%'" + code.crlf
end if

// 電話FAX
if l_tel_fax <> "" then
	l_sql_where	+= "AND  (replace(replace( wk.tel_no,'　' ),' ')          LIKE '%' || replace(replace(replace( '" + string( l_tel_fax ) + "','　' ),' '),'-') || '%'" + code.crlf
	l_sql_where	+= "   OR  replace(replace( wk.fax_no,'　' ),' ')        LIKE '%' || replace(replace(replace( '" + string( l_tel_fax ) + "','　' ),' '),'-') || '%')" + code.crlf

end if

if l_sql_where <> "" then
	l_sql_where = Mid(l_sql_where, 4) // 最初の3文字を削除
	l_sql_where = "where " + l_sql_where
end if

// 最後に出現する"order by"の前にWhere句を追加する
l_sql_new	= Mid( l_sql_old, 1, LastPos( l_sql_old, "order by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, LastPos( l_sql_old, "order by" ) )

dw_list.reset( )


// 組み立てたSQLをセットする
dw_list.setsqlselect( l_sql_new )

// 検索
if dw_list.retrieve( ) = 0 then
	// SQLを元に戻す
	dw_list.setsqlselect( l_sql_old )
	
//	msg.of_error( "入力した条件に該当するデータはありません。" )
	msg.of_error( "検索されたデータはありません。" )
	return -1
end if

// SQLを元に戻す
dw_list.setsqlselect( l_sql_old )

dw_list.setfocus( )

	// フィルタ条件セット
	of_filter_make()

end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event open;call super::open;// 初期表示
of_set_firstfocus( )

end event

event key_f06;call super::key_f06;// 戻り
of_dsp_back()

return 0
end event

event retrieve_check;call super::retrieve_check;// Retrieve前の事前チェック

/*
// 得意先
// 空の場合falseが返ってくるので空の場合だけチェックする
if uo_tokui.of_get_input( ) <> "" AND not uo_tokui.event sle_input_check( ) then
	return -1
end if

// 登録日(開始)
if not sle_touroku_date_from.event input_check( ) then
	return -1
end if

// 登録日(終了)
if not sle_touroku_date_to.event input_check( ) then
	return -1
end if

// 部門
// 空の場合falseが返ってくるので空の場合だけチェックする
if uo_bumon.of_get_input( ) <> "" AND not uo_bumon.event sle_input_check( ) then
	return -1
end if

// 営業所
if uo_eigyo.of_get_input() <> "" AND not uo_eigyo.event sle_input_check( ) then
	return -1
end if

// 課
if uo_ka.of_get_input() <> "" AND not uo_ka.event sle_input_check( ) then
	return -1
end if
*/
// 住所
//if not sle_jyusyo.event input_check( ) then
//	return -1
//end if

/*
// 都道府県
if not ddplb_todofuken.event input_check( ) then
	return -1
end if
*/

// 課
//if uo_ka.of_get_input() <> "" AND not uo_ka.event sle_input_check( ) then
//	return -1
//end if

// 各SLEの入力内容を取得し、空白をトリムします
//string ls_text1 = Trim(sle_meisyo.Text)
//string ls_text2 = Trim(sle_2.Text)
//string ls_text3 = Trim(sle_3.Text)
//
//// 3つすべてが未入力の場合のチェック
//IF ls_text1 = "" AND ls_text2 = "" AND ls_text3 = "" THEN
//    MessageBox("エラー", "少なくとも1つの項目を入力してください。")
//    RETURN
//END IF

if sle_meisyo.text = "" and  sle_kana_mei.text = "" and  sle_jyusyo.text = "" and sle_tel_fax.text = "" then
	msg.of_error_sle( sle_meisyo, "いずれか一つ以上を入力してください。" )
	sle_meisyo.setfocus()
	return -1
end if

//
//// 入力がある場合の処理
//MessageBox("確認", "入力が確認されました。")





end event

type uo_signal from iw_main_window`uo_signal within ws_tokui_mise
end type

type st_date from iw_main_window`st_date within ws_tokui_mise
end type

type st_user_mei from iw_main_window`st_user_mei within ws_tokui_mise
end type

type uo_test_mode from iw_main_window`uo_test_mode within ws_tokui_mise
end type

type p_size_adjust from iw_main_window`p_size_adjust within ws_tokui_mise
end type

type st_title from iw_main_window`st_title within ws_tokui_mise
end type

type st_title_upper from iw_main_window`st_title_upper within ws_tokui_mise
end type

type st_upper from iw_main_window`st_upper within ws_tokui_mise
end type

type st_second_upper from iw_main_window`st_second_upper within ws_tokui_mise
integer height = 359
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_tokui_mise
integer x = 4272
integer y = 380
integer taborder = 50
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type dw_list from ivo_datawindow within ws_tokui_mise
integer y = 693
integer width = 5100
integer height = 1522
integer taborder = 100
boolean bringtotop = true
string dataobject = "ds_tokui_mise"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)
end event

event key_f05;call super::key_f05;// Excel出力
string	l_file

// フルパスで入れれば保存先フォルダが指定可能

l_file	= fnc.strg.of_format( "得意先＆店検索_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event getfocus;call super::getfocus;if this.rowcount() > 0 then
	sf1_key	= true
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	sf1_key	= false
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

end event

event clicked;call super::clicked;
string	l_columnname

choose case right( dwo.name, 2 )
	case "_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
end choose

end event

type st_jyusyo from ivo_statictext within ws_tokui_mise
integer x = 32
integer y = 359
integer width = 272
integer height = 82
boolean bringtotop = true
long backcolor = 553648127
string text = "住所"
alignment alignment = right!
end type

type sle_jyusyo from ivo_singlelineedit within ws_tokui_mise
integer x = 328
integer y = 356
integer width = 1500
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 1
string text = ""
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type sle_kana_mei from ivo_singlelineedit within ws_tokui_mise
integer x = 328
integer y = 256
integer width = 1500
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 1
string text = ""
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_kana_mei from ivo_statictext within ws_tokui_mise
integer x = 32
integer y = 260
integer width = 272
integer height = 82
boolean bringtotop = true
long backcolor = 553648127
string text = "カナ名"
alignment alignment = right!
end type

type sle_meisyo from ivo_singlelineedit within ws_tokui_mise
integer x = 328
integer y = 156
integer width = 1500
integer taborder = 10
boolean bringtotop = true
integer init_imemode = 1
string text = ""
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_meisyo from ivo_statictext within ws_tokui_mise
integer x = 32
integer y = 160
integer width = 272
integer height = 82
boolean bringtotop = true
long backcolor = 553648127
string text = "名称"
alignment alignment = right!
end type

type st_tel_fax from ivo_statictext within ws_tokui_mise
integer x = 1852
integer y = 363
boolean bringtotop = true
long backcolor = 553648127
string text = "電話FAX"
alignment alignment = right!
end type

type sle_tel_fax from ivo_singlelineedit within ws_tokui_mise
integer x = 2168
integer y = 356
integer width = 536
integer taborder = 40
boolean bringtotop = true
integer init_imemode = 1
string text = ""
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_todofuken from ivo_statictext within ws_tokui_mise
integer x = 32
integer y = 519
integer width = 332
integer height = 82
boolean bringtotop = true
string text = "都道府県"
alignment alignment = right!
end type

type ddplb_todofuken from ivo_dropdownpicturelistbox within ws_tokui_mise
integer x = 380
integer y = 516
integer width = 372
integer height = 363
integer taborder = 60
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","",""}
integer itempictureindex[] = {1,0,0,0}
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;
// 初期化
this.reset( )
this.enabled	= true
this.insertitem( "(未選択)", upperbound( this.item ) + 1 )
this.selectitem( "(未選択)", 1 )

this.event selectionchanged( i_idx )

end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type cb_clear from ivo_commandbutton within ws_tokui_mise
integer x = 4272
integer y = 537
integer width = 408
integer taborder = 90
boolean bringtotop = true
string text = "条件クリア"
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event execution;call super::execution;
// フィルター解除

ddplb_todofuken.selectitem ( "(未選択)", 0 )
ddplb_tokuisaki_mei.selectitem ( "(未選択)", 0 )
ddplb_mise_mei.selectitem ( "(未選択)", 0 )

//ddplb_msg.selectitem ( "(未選択)", 0 )

of_filter_set()


return 0



end event

type ddplb_tokuisaki_mei from ivo_dropdownpicturelistbox within ws_tokui_mise
integer x = 1128
integer y = 512
integer width = 1300
integer height = 363
integer taborder = 70
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","",""}
integer itempictureindex[] = {1,0,0,0}
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;
// 初期化
this.reset( )
this.enabled	= true
this.insertitem( "(未選択)", upperbound( this.item ) + 1 )
this.selectitem( "(未選択)", 1 )

this.event selectionchanged( i_idx )

end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type st_tokuisaki_mei from ivo_statictext within ws_tokui_mise
integer x = 784
integer y = 526
integer width = 332
integer height = 82
boolean bringtotop = true
string text = "得意先名"
alignment alignment = right!
end type

type ddplb_mise_mei from ivo_dropdownpicturelistbox within ws_tokui_mise
integer x = 2688
integer y = 512
integer width = 1300
integer height = 363
integer taborder = 80
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","",""}
integer itempictureindex[] = {1,0,0,0}
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter2tab = false
end type

event constructor;call super::constructor;
// 初期化
this.reset( )
this.enabled	= true
this.insertitem( "(未選択)", upperbound( this.item ) + 1 )
this.selectitem( "(未選択)", 1 )

this.event selectionchanged( i_idx )

end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type st_mise_mei from ivo_statictext within ws_tokui_mise
integer x = 2460
integer y = 526
integer width = 212
integer height = 82
boolean bringtotop = true
string text = "店名"
alignment alignment = right!
end type

type st_kakukoumoku from ivo_statictext within ws_tokui_mise
integer x = 1852
integer y = 171
integer width = 556
boolean bringtotop = true
long backcolor = 553648127
string text = "※各項目をAND検索"
alignment alignment = right!
end type

