$PBExportHeader$ws_syohin_aki_code.srw
$PBExportComments$商品空きコード検索
forward
global type ws_syohin_aki_code from iw_main_window
end type
type st_syohin_code from ivo_statictext within ws_syohin_aki_code
end type
type sle_syohin_code_from from ivo_singlelineedit within ws_syohin_aki_code
end type
type st_syohin_code_to from ivo_statictext within ws_syohin_aki_code
end type
type sle_syohin_code_to from ivo_singlelineedit within ws_syohin_aki_code
end type
type dw_list from ivo_datawindow within ws_syohin_aki_code
end type
end forward

global type ws_syohin_aki_code from iw_main_window
integer width = 6684
string title = "商品空きコード検索"
windowanimationstyle closeanimation = rightroll!
st_syohin_code st_syohin_code
sle_syohin_code_from sle_syohin_code_from
st_syohin_code_to st_syohin_code_to
sle_syohin_code_to sle_syohin_code_to
dw_list dw_list
end type
global ws_syohin_aki_code ws_syohin_aki_code

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

sle_syohin_code_from.event constructor()
sle_syohin_code_to.event constructor()

dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_dsp_back ();
dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

on ws_syohin_aki_code.create
int iCurrent
call super::create
this.st_syohin_code=create st_syohin_code
this.sle_syohin_code_from=create sle_syohin_code_from
this.st_syohin_code_to=create st_syohin_code_to
this.sle_syohin_code_to=create sle_syohin_code_to
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syohin_code
this.Control[iCurrent+2]=this.sle_syohin_code_from
this.Control[iCurrent+3]=this.st_syohin_code_to
this.Control[iCurrent+4]=this.sle_syohin_code_to
this.Control[iCurrent+5]=this.dw_list
end on

on ws_syohin_aki_code.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syohin_code)
destroy(this.sle_syohin_code_from)
destroy(this.st_syohin_code_to)
destroy(this.sle_syohin_code_to)
destroy(this.dw_list)
end on

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

// 呼出部
// 1行目
sle_syohin_code_to.y	= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」
sle_syohin_code_from.y	= st_second_upper.y + code.MGN_UPPER_TATE
st_syohin_code_to.y	    = st_second_upper.y + code.MGN_UPPER_TATE + 7		// タイトル「+7」
st_syohin_code.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7

// st_second_upper高さ
st_second_upper.height	= sle_syohin_code_from.y + sle_syohin_code_from.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_list.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y

end event

event openquery;call super::openquery;
i_str	= create nv_string
end event

event close;call super::close;
destroy i_str
end event

event retrieve_event;call super::retrieve_event;
string	l_sql_old, l_sql_new, l_sql_where, l_sql_tail

long	l_tokui_code, l_touroku_date_to, l_touroku_date_from
long	l_bumon_code, l_eigyo_code, l_ka_code, l_todofuken_code
string	l_mise_mei
boolean	l_heiten_flg, l_syusoku_flg


string l_syohin_code_from
string l_syohin_code_to


l_syohin_code_from	= sle_syohin_code_from.text
l_syohin_code_to	= sle_syohin_code_to.text

// 検索条件に入力された内容をインスタンス変数に保持


l_syohin_code_from	= sle_syohin_code_from.text
l_syohin_code_to	= sle_syohin_code_to.text


//
//if sle_mise_mei.text <> "" then
//	l_mise_mei		= sle_mise_mei.text
//else
//	l_mise_mei		= ""
//end if

//l_tokui_code		= uo_tokui.of_get_tokui_code()
//l_bumon_code		= long( uo_bumon.of_get_meisyo_code() )
//l_eigyo_code		= long( uo_eigyo.of_get_meisyo_code() )
//l_ka_code			= long( uo_ka.of_get_meisyo_code() )
//l_todofuken_code	= ddplb_todofuken.of_get_code_num( )
//l_heiten_flg		= cbx_heiten_flg.checked
//l_syusoku_flg		= cbx_syusoku_flg.checked

// 元のSQLを取得
l_sql_old	= dw_list.getsqlselect( )


// ## 条件作成 ## //


// 商品コード　表示範囲
if l_syohin_code_from <> "" then
	l_sql_where	+= " and   n.syohin_code  >=  " + l_syohin_code_from  + code.crlf
end if

if l_syohin_code_to <> "" then
	l_sql_where	+= " and   n.syohin_code  <=  " + l_syohin_code_to  + code.crlf
end if

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
//
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


// 最後に出現する"group by"の前にWhere句を追加する
l_sql_new	= Mid( l_sql_old, 1, LastPos( l_sql_old, "group by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, LastPos( l_sql_old, "group by" ) )

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

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
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

event retrieve_check;call super::retrieve_check;
// Retrieve前の事前チェック

string l_syohin_code_from
string l_syohin_code_to

// 商品コード表示範囲　スタート
if not sle_syohin_code_from.event input_check( ) then
	return -1
end if

// 商品コード表示範囲　エンド
if not sle_syohin_code_to.event input_check( ) then
	return -1
end if

// 大小チェック
l_syohin_code_from	= sle_syohin_code_from.text
l_syohin_code_to	= sle_syohin_code_to.text

if long(l_syohin_code_from) > long(l_syohin_code_to) then
	msg.of_error_sle( sle_syohin_code_from, "表示範囲の前のコードが後ろのコードより大きいです。" )
	sle_syohin_code_from.setfocus()
	return -1
end if


end event

type uo_signal from iw_main_window`uo_signal within ws_syohin_aki_code
end type

type st_date from iw_main_window`st_date within ws_syohin_aki_code
end type

type st_user_mei from iw_main_window`st_user_mei within ws_syohin_aki_code
end type

type uo_test_mode from iw_main_window`uo_test_mode within ws_syohin_aki_code
end type

type p_size_adjust from iw_main_window`p_size_adjust within ws_syohin_aki_code
end type

type st_title from iw_main_window`st_title within ws_syohin_aki_code
end type

type st_title_upper from iw_main_window`st_title_upper within ws_syohin_aki_code
end type

type st_upper from iw_main_window`st_upper within ws_syohin_aki_code
end type

type st_second_upper from iw_main_window`st_second_upper within ws_syohin_aki_code
integer height = 359
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_syohin_aki_code
integer x = 4272
integer y = 380
integer taborder = 90
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type st_syohin_code from ivo_statictext within ws_syohin_aki_code
integer x = 32
integer y = 160
integer width = 332
boolean bringtotop = true
long backcolor = 12632256
string text = "表示範囲"
alignment alignment = right!
end type

type sle_syohin_code_from from ivo_singlelineedit within ws_syohin_aki_code
integer x = 380
integer y = 156
integer width = 272
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= "0"

end event

event input_check;call super::input_check;
boolean l_ret
long	l_syohin_code
string  l_input
string  l_msg

l_ret       = true
l_input		= trim( this.text )

// 入力チェック
if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		msg.of_error_sle( this,fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_syohin_code	= long( l_input )
	
else

		l_msg	= "表示範囲にコードを入力してください。"
		l_ret	= false

end if

// falseの処理
if not l_ret then
	msg.of_error_sle( this, l_msg)
	sle_syohin_code_from.setfocus()
end if

return l_ret
end event

type st_syohin_code_to from ivo_statictext within ws_syohin_aki_code
integer x = 668
integer y = 156
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_syohin_code_to from ivo_singlelineedit within ws_syohin_aki_code
integer x = 772
integer y = 156
integer width = 272
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= "999999"

end event

event input_check;call super::input_check;
boolean l_ret
long	l_syohin_code
string  l_input
string  l_msg

l_ret       = true
l_input		= trim( this.text )

// 入力チェック
if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		msg.of_error_sle( this,fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_syohin_code	= long( l_input )
	

else

		l_msg	= "表示範囲にコードを入力してください。"
		l_ret	= false

end if

// falseの処理
if not l_ret then
	msg.of_error_sle( this, l_msg)
	sle_syohin_code_to.setfocus()
end if

return l_ret
end event

type dw_list from ivo_datawindow within ws_syohin_aki_code
integer y = 512
integer width = 5100
integer height = 1703
integer taborder = 100
boolean bringtotop = true
string dataobject = "ds_syohin_aki_code"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)
end event

event key_f05;call super::key_f05;
// Excel出力
string	l_file

// フルパスで入れれば保存先フォルダが指定可能

l_file	= fnc.strg.of_format( "商品空きコード検索_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
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

// クリックされたところがヘッダなら、そこを起点にソートをかける
if string( dwo.type ) = "text" and right( string( dwo.name ), 2 ) = "_t" then
	l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) - 2 )
	of_set_dynamic_sort( l_columnname )
end if

end event

