$PBExportHeader$ws_mise.srw
$PBExportComments$店一覧照会
forward
global type ws_mise from iw_main_window
end type
type st_touroku_date_from from ivo_statictext within ws_mise
end type
type sle_touroku_date_from from ivo_singlelineedit within ws_mise
end type
type st_touroku_date_to from ivo_statictext within ws_mise
end type
type sle_touroku_date_to from ivo_singlelineedit within ws_mise
end type
type cbx_syusoku_flg from ivo_checkbox within ws_mise
end type
type dw_list from ivo_datawindow within ws_mise
end type
type uo_tokui from cv_input_tokui within ws_mise
end type
type uo_bumon from cv_input_meisyo within ws_mise
end type
type uo_eigyo from cv_input_meisyo within ws_mise
end type
type uo_ka from cv_input_meisyo within ws_mise
end type
type cbx_heiten_flg from ivo_checkbox within ws_mise
end type
type ddplb_todofuken from sv_ddplb_meisyo within ws_mise
end type
type st_todofuken from ivo_statictext within ws_mise
end type
type st_mise_mei from ivo_statictext within ws_mise
end type
type sle_mise_mei from ivo_singlelineedit within ws_mise
end type
type st_mise_mei_aimai from ivo_statictext within ws_mise
end type
end forward

global type ws_mise from iw_main_window
integer width = 6684
string title = "店一覧照会"
windowanimationstyle closeanimation = rightroll!
st_touroku_date_from st_touroku_date_from
sle_touroku_date_from sle_touroku_date_from
st_touroku_date_to st_touroku_date_to
sle_touroku_date_to sle_touroku_date_to
cbx_syusoku_flg cbx_syusoku_flg
dw_list dw_list
uo_tokui uo_tokui
uo_bumon uo_bumon
uo_eigyo uo_eigyo
uo_ka uo_ka
cbx_heiten_flg cbx_heiten_flg
ddplb_todofuken ddplb_todofuken
st_todofuken st_todofuken
st_mise_mei st_mise_mei
sle_mise_mei sle_mise_mei
st_mise_mei_aimai st_mise_mei_aimai
end type
global ws_mise ws_mise

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str

end variables

forward prototypes
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_reset ();// constructorで各コントロールリセット

uo_tokui.event constructor( )
sle_touroku_date_from.event constructor( )
sle_touroku_date_to.event constructor( )
uo_bumon.event constructor( )
uo_eigyo.event constructor( )
uo_ka.event constructor( )
sle_mise_mei.event constructor( )
ddplb_todofuken.event constructor( )
cbx_heiten_flg.event constructor( )
cbx_syusoku_flg.event constructor( )

dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_dsp_back ();dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

on ws_mise.create
int iCurrent
call super::create
this.st_touroku_date_from=create st_touroku_date_from
this.sle_touroku_date_from=create sle_touroku_date_from
this.st_touroku_date_to=create st_touroku_date_to
this.sle_touroku_date_to=create sle_touroku_date_to
this.cbx_syusoku_flg=create cbx_syusoku_flg
this.dw_list=create dw_list
this.uo_tokui=create uo_tokui
this.uo_bumon=create uo_bumon
this.uo_eigyo=create uo_eigyo
this.uo_ka=create uo_ka
this.cbx_heiten_flg=create cbx_heiten_flg
this.ddplb_todofuken=create ddplb_todofuken
this.st_todofuken=create st_todofuken
this.st_mise_mei=create st_mise_mei
this.sle_mise_mei=create sle_mise_mei
this.st_mise_mei_aimai=create st_mise_mei_aimai
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_touroku_date_from
this.Control[iCurrent+2]=this.sle_touroku_date_from
this.Control[iCurrent+3]=this.st_touroku_date_to
this.Control[iCurrent+4]=this.sle_touroku_date_to
this.Control[iCurrent+5]=this.cbx_syusoku_flg
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.uo_tokui
this.Control[iCurrent+8]=this.uo_bumon
this.Control[iCurrent+9]=this.uo_eigyo
this.Control[iCurrent+10]=this.uo_ka
this.Control[iCurrent+11]=this.cbx_heiten_flg
this.Control[iCurrent+12]=this.ddplb_todofuken
this.Control[iCurrent+13]=this.st_todofuken
this.Control[iCurrent+14]=this.st_mise_mei
this.Control[iCurrent+15]=this.sle_mise_mei
this.Control[iCurrent+16]=this.st_mise_mei_aimai
end on

on ws_mise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_touroku_date_from)
destroy(this.sle_touroku_date_from)
destroy(this.st_touroku_date_to)
destroy(this.sle_touroku_date_to)
destroy(this.cbx_syusoku_flg)
destroy(this.dw_list)
destroy(this.uo_tokui)
destroy(this.uo_bumon)
destroy(this.uo_eigyo)
destroy(this.uo_ka)
destroy(this.cbx_heiten_flg)
destroy(this.ddplb_todofuken)
destroy(this.st_todofuken)
destroy(this.st_mise_mei)
destroy(this.sle_mise_mei)
destroy(this.st_mise_mei_aimai)
end on

event resize;call super::resize;// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

//st_second_upper.height	= 821
//cb_retrieve.y			= 836

st_second_upper.height	= 359


// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y

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

// st_second_upper高さ
st_second_upper.height	= l_row_3_y + sle_mise_mei.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event openquery;call super::openquery;i_str	= create nv_string
end event

event close;call super::close;destroy i_str
end event

event retrieve_event;call super::retrieve_event;string	l_sql_old, l_sql_new, l_sql_where, l_sql_tail

long	l_tokui_code, l_touroku_date_to, l_touroku_date_from
long	l_bumon_code, l_eigyo_code, l_ka_code, l_todofuken_code
string	l_mise_mei
boolean	l_heiten_flg, l_syusoku_flg


// 検索条件に入力された内容をインスタンス変数に保持

if sle_touroku_date_from.text <> "" then
	l_touroku_date_from		= long( i_str.of_replace( sle_touroku_date_from.text, "/", "" ) )
else
	l_touroku_date_from		= 0
end if

if sle_touroku_date_to.text <> "" then
	l_touroku_date_to		= long( i_str.of_replace( sle_touroku_date_to.text, "/", "" ) )
else
	l_touroku_date_to		= 0
end if

if sle_mise_mei.text <> "" then
	l_mise_mei		= sle_mise_mei.text
else
	l_mise_mei		= ""
end if

l_tokui_code		= uo_tokui.of_get_tokui_code()
l_bumon_code		= long( uo_bumon.of_get_meisyo_code() )
l_eigyo_code		= long( uo_eigyo.of_get_meisyo_code() )
l_ka_code			= long( uo_ka.of_get_meisyo_code() )
l_todofuken_code	= ddplb_todofuken.of_get_code_num( )
l_heiten_flg		= cbx_heiten_flg.checked
l_syusoku_flg		= cbx_syusoku_flg.checked

// 元のSQLを取得
l_sql_old	= dw_list.getsqlselect( )


// ## 条件作成 ## //

// 得意先
if l_tokui_code <> -1 then
	l_sql_where	+= "   and mise.tokui_code          = " + string( l_tokui_code ) + code.crlf
end if

// 登録日(開始)
if l_touroku_date_from <> 0 then
	l_sql_where	+= "   and trunc( tokui.touroku_date )          >= '" + fnc.db.of_date_format( string( l_touroku_date_from ) ) + "'" + code.crlf
end if

// 登録日(終了日)
if l_touroku_date_to <> 0 then
	l_sql_where	+= "   and trunc( tokui.touroku_date )          <= '" + fnc.db.of_date_format( string( l_touroku_date_to ) ) + "'" + code.crlf
end if

// 部門
if l_bumon_code <> 0 then
	l_sql_where	+= "   and tokui.bumon_code          = " + string( l_bumon_code ) + code.crlf
end if

// 営業所
if l_eigyo_code <> 0 then
	l_sql_where	+= "   and tanto.eigyosyo_code          = " + string( l_eigyo_code ) + code.crlf
end if

// 課
if l_ka_code <> 0 then
	l_sql_where	+= "   and tanto.ka_code          = " + string( l_ka_code ) + code.crlf
end if

// 都道府県
//if l_todofuken_code <> 0 then
//if ddplb_todofuken.text <> "" then
if not isnull(l_todofuken_code) then
	l_sql_where	+= "   and mise.todofuken_code          = " + string( l_todofuken_code ) + code.crlf
end if

// 店名（曖昧検索）
if l_mise_mei <> "" then
	l_sql_where	+= "   and replace(replace( mise.mise_mei,'　' ),' ')          LIKE '%' || replace(replace( '" + string( l_mise_mei ) + "','　' ),' ') || '%'" + code.crlf
end if

// 閉店を含む
if not l_heiten_flg then
	l_sql_where	+= "   and mise.heiten_flg     <> 1 " + code.crlf
end if

// 終息店を含む
if not l_syusoku_flg then
	l_sql_where	+= "and mise.syusoku_flg           <> 1" + code.crlf
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

// 店名
if not sle_mise_mei.event input_check( ) then
	return -1
end if

// 都道府県
if not ddplb_todofuken.event input_check( ) then
	return -1
end if

end event

type uo_signal from iw_main_window`uo_signal within ws_mise
end type

type st_date from iw_main_window`st_date within ws_mise
end type

type st_user_mei from iw_main_window`st_user_mei within ws_mise
end type

type uo_test_mode from iw_main_window`uo_test_mode within ws_mise
end type

type p_size_adjust from iw_main_window`p_size_adjust within ws_mise
end type

type st_title from iw_main_window`st_title within ws_mise
end type

type st_title_upper from iw_main_window`st_title_upper within ws_mise
end type

type st_upper from iw_main_window`st_upper within ws_mise
end type

type st_second_upper from iw_main_window`st_second_upper within ws_mise
integer height = 359
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_mise
integer x = 4272
integer y = 380
integer taborder = 90
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type st_touroku_date_from from ivo_statictext within ws_mise
integer x = 2528
integer y = 171
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "登録日"
alignment alignment = right!
end type

type sle_touroku_date_from from ivo_singlelineedit within ws_mise
integer x = 2792
integer y = 167
integer width = 408
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type st_touroku_date_to from ivo_statictext within ws_mise
integer x = 3216
integer y = 167
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_touroku_date_to from ivo_singlelineedit within ws_mise
integer x = 3320
integer y = 167
integer width = 408
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type cbx_syusoku_flg from ivo_checkbox within ws_mise
string tag = "終息店を含む"
integer x = 3760
integer y = 270
integer width = 488
long backcolor = 12632256
string text = "終息店を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= false
end event

type dw_list from ivo_datawindow within ws_mise
integer y = 512
integer width = 5100
integer height = 1703
integer taborder = 100
boolean bringtotop = true
string dataobject = "ds_mise"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }
this.i_sfunction_name	= { "登録詳細", "", "", "", "", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)
end event

event key_f05;call super::key_f05;// Excel出力
string	l_file

// フルパスで入れれば保存先フォルダが指定可能

l_file	= fnc.strg.of_format( "店一覧照会_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

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

event key_f01;call super::key_f01;// 登録詳細
long	l_tokui_code,l_mise_code

if keyflags = 1 then
	l_tokui_code	= this.object.tokui_code[this.getrow()]
	l_mise_code	= this.object.mise_code[this.getrow()]
	
	msg.of_info( "店登録画面遷移機能は未実装です。" )
end if
/*
long	l_syohin_code, l_iro_no

if keyflags = 1 then
	l_syohin_code	= this.object.syohin_code[this.getrow()]
	l_iro_no		= this.object.iro_no[this.getrow()]
	
	msg.of_info( "商品登録詳細画面は未実装です。" )
end if
*/

return 0
end event

type uo_tokui from cv_input_tokui within ws_mise
integer x = 32
integer y = 167
integer width = 2464
integer taborder = 10
boolean bringtotop = true
boolean f4_key = false
long title_width = 248
long input_width = 248
long bikou_width = 168
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

type uo_bumon from cv_input_meisyo within ws_mise
string tag = "部門"
integer x = 32
integer y = 270
integer width = 1240
integer taborder = 40
boolean bringtotop = true
string title_text = "部門"
long title_width = 248
long input_width = 88
long bikou_width = 0
integer meisyo_kbn = 21
end type

on uo_bumon.destroy
call cv_input_meisyo::destroy
end on

type uo_eigyo from cv_input_meisyo within ws_mise
string tag = "営業所"
integer x = 1288
integer y = 270
integer width = 1240
integer taborder = 50
boolean bringtotop = true
string title_text = "営業所"
long title_width = 248
long input_width = 88
long bikou_width = 0
integer meisyo_kbn = 22
end type

on uo_eigyo.destroy
call cv_input_meisyo::destroy
end on

type uo_ka from cv_input_meisyo within ws_mise
string tag = "課"
integer x = 2544
integer y = 270
integer width = 1120
integer taborder = 60
boolean bringtotop = true
string title_text = "課"
long title_width = 88
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 23
end type

on uo_ka.destroy
call cv_input_meisyo::destroy
end on

type cbx_heiten_flg from ivo_checkbox within ws_mise
string tag = "閉店を含む"
integer x = 3760
integer y = 167
integer width = 488
long backcolor = 553648127
string text = "閉店を含む"
end type

event constructor;call super::constructor;this.checked	= false
end event

type ddplb_todofuken from sv_ddplb_meisyo within ws_mise
integer x = 3524
integer y = 380
integer width = 428
integer taborder = 80
boolean bringtotop = true
boolean selecttext = false
integer meisyo_kbn = 32
boolean enabled_null = true
end type

type st_todofuken from ivo_statictext within ws_mise
integer x = 3176
integer y = 388
integer width = 328
boolean bringtotop = true
long backcolor = 553648127
string text = "都道府県"
alignment alignment = right!
end type

type st_mise_mei from ivo_statictext within ws_mise
integer x = 32
integer y = 388
integer width = 248
boolean bringtotop = true
long backcolor = 553648127
string text = "店名"
alignment alignment = right!
end type

type sle_mise_mei from ivo_singlelineedit within ws_mise
integer x = 296
integer y = 380
integer width = 2408
integer taborder = 70
boolean bringtotop = true
integer init_imemode = 1
string text = ""
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_mise_mei_aimai from ivo_statictext within ws_mise
integer x = 2728
integer y = 388
integer width = 408
boolean bringtotop = true
long backcolor = 553648127
string text = "(曖昧検索)"
alignment alignment = right!
end type

