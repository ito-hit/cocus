$PBExportHeader$iw_print_window.srw
$PBExportComments$aw_windowから継承した印刷ウインドウの先祖オブジェクト
forward
global type iw_print_window from aw_base_window
end type
type ddplb_printer from sv_ddplb_printer within iw_print_window
end type
type st_bottom from ivo_statictext within iw_print_window
end type
type cb_preview from sv_cb_print_preview within iw_print_window
end type
type cb_print from sv_cb_print within iw_print_window
end type
type cb_cancel from sv_cb_close within iw_print_window
end type
type st_printer from ivo_statictext within iw_print_window
end type
type st_busu from ivo_statictext within iw_print_window
end type
type sle_busu from ivo_singlelineedit within iw_print_window
end type
type cb_test from commandbutton within iw_print_window
end type
end forward

global type iw_print_window from aw_base_window
integer width = 4296
integer height = 1746
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "image\printer.ico"
integer animationtime = 100
boolean f8_key = true
boolean f10_key = true
boolean f11_key = true
boolean f12_key = true
boolean fnkey_enabled = false
boolean confirm_print = true
boolean confirm_preview = true
boolean print_retrieve = true
boolean print_update = true
ddplb_printer ddplb_printer
st_bottom st_bottom
cb_preview cb_preview
cb_print cb_print
cb_cancel cb_cancel
st_printer st_printer
st_busu st_busu
sle_busu sle_busu
cb_test cb_test
end type
global iw_print_window iw_print_window

type variables
public:

protected:
	// プレビュー受け渡し用
	blob			i_pv_blobs[]

	// イベント用パラメータ
	unsignedlong	i_wparam
	long			i_lparam


end variables

forward prototypes
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
end prototypes

public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled);
unsignedlong	l_keyflags
boolean			l_visible

choose case p_keycode
	case keyf1!
		f1_key	= p_enabled
	case keyf2!
		f2_key	= p_enabled
	case keyf3!
		f3_key	= p_enabled
	case keyf4!
		f4_key	= p_enabled
	case keyf5!
		f5_key	= p_enabled
	case keyf6!
		f6_key	= p_enabled
	case keyf7!
		f7_key	= p_enabled
	case keyf8!
		f8_key	= p_enabled
	case keyf9!
		f9_key	= p_enabled
	case keyf10!
		f10_key	= p_enabled
	case keyf11!
		f11_key	= p_enabled
	case keyf12!
		f12_key	= p_enabled
	case else
end choose

l_visible	= of_get_fnkey_visibled()

if l_visible then
	// 初期値設定
	key_fnc.base_function_name		= function_name
	key_fnc.base_function_enabled	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }

	key_fnc.base_sfunction_name		= sfunction_name
	key_fnc.base_sfunction_enabled	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }

	key_fnc.focusobj				= this

	key_fnc.of_set_fuction_name( )
	key_fnc.show()
else
	key_fnc.hide( )
end if

key_fnc.visible		= l_visible

end subroutine

on iw_print_window.create
int iCurrent
call super::create
this.ddplb_printer=create ddplb_printer
this.st_bottom=create st_bottom
this.cb_preview=create cb_preview
this.cb_print=create cb_print
this.cb_cancel=create cb_cancel
this.st_printer=create st_printer
this.st_busu=create st_busu
this.sle_busu=create sle_busu
this.cb_test=create cb_test
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_printer
this.Control[iCurrent+2]=this.st_bottom
this.Control[iCurrent+3]=this.cb_preview
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.st_printer
this.Control[iCurrent+7]=this.st_busu
this.Control[iCurrent+8]=this.sle_busu
this.Control[iCurrent+9]=this.cb_test
end on

on iw_print_window.destroy
call super::destroy
destroy(this.ddplb_printer)
destroy(this.st_bottom)
destroy(this.cb_preview)
destroy(this.cb_print)
destroy(this.cb_cancel)
destroy(this.st_printer)
destroy(this.st_busu)
destroy(this.sle_busu)
destroy(this.cb_test)
end on

event open;call super::open;
object_type	= "print_window"

// window
integer	l_newwidth,l_newheight

l_newwidth	= pixelstounits( code.def_prt_width, xpixelstounits! )
l_newheight	= pixelstounits( code.def_prt_height, ypixelstounits! )

resize( l_newwidth - 39, l_newheight )


end event

event resize;call super::resize;
if this.width < 3924 then
	this.width	= 3924
end if

st_bottom.height	= 139
st_bottom.y			= newheight - st_bottom.height
st_bottom.x			= 0
st_bottom.width		= newwidth

cb_preview.width	= 380
cb_preview.height	= 85
cb_preview.y		= st_bottom.y + st_bottom.height / 2 - cb_preview.height / 2
cb_preview.x		= code.MGN_YOKO

cb_cancel.width		= cb_preview.width
cb_cancel.height	= cb_preview.height
cb_cancel.y			= cb_preview.y
cb_cancel.x			= newwidth - cb_cancel.width - code.MGN_YOKO

cb_print.width		= cb_preview.width
cb_print.height		= cb_preview.height
cb_print.y			= cb_preview.y
cb_print.x			= cb_cancel.x - cb_print.width - code.MGN_YOKO

integer	l_width, l_left_x

st_printer.width	= 300
ddplb_printer.width	= 1470

l_width		= st_printer.width + code.MGN_GROUP_YOKO + ddplb_printer.width
l_left_x	= ceiling( ( newwidth - l_width ) / 2 )

st_printer.x	= l_left_x
ddplb_printer.x	= st_printer.x + st_printer.width + code.MGN_GROUP_YOKO

sle_busu.y		= st_bottom.y - sle_busu.height - code.MGN_TATE_LARGE * 3
ddplb_printer.y	= sle_busu.y - sle_busu.height - code.MGN_TATE_MIDDLE		// ddplb_printer.heightを使用したいがリスト部も高さに含まれるので代わりにsleで

sle_busu.x		= ddplb_printer.x
st_busu.x		= st_printer.x

st_busu.y		= sle_busu.y + sle_busu.height / 2 - st_busu.height / 2
st_printer.y	= ddplb_printer.y + sle_busu.height / 2 - st_printer.height / 2

end event

event openquery;call super::openquery;
// レスポンスウインドウなので
changemenu( am_menu_keytrg )


end event

event key_f10;call super::key_f10;close( this )
return 0
end event

event key_f12;call super::key_f12;// プレビュー画面表示
if msg.of_question( "印刷しますか？" ) then
	if of_evt_update( i_wparam, i_lparam ) then
		if of_evt_print( i_wparam, i_lparam ) then
			commit using cocos;
		end if
	end if
	
	// とりあえずここに入れておけば間違いない
	rollback using cocos;
end if

return 0
end event

event update_event;call super::update_event;
// 印刷用データや更新処理（commitは不要）
// ※ここに入る前にupdate_checkイベントが実行される
end event

event print_event;call super::print_event;
// 印刷処理（戻り値 0:commit -1:rollback）
// ※ここに入る前にprint_checkイベントが実行される
end event

event print_preview_event;call super::print_preview_event;
// 印刷プレビュー処理（戻り値 0:rollback -1:rollback）
// ※ここに入る前にprint_checkイベントが実行される

winctl.of_open( "wp_preview" )
end event

event retrieve_event;call super::retrieve_event;
// 印刷画面では基本使用しない
end event

event key_f11;call super::key_f11;// プレビュー画面表示
if msg.of_question( "プレビュー表示しますか？" ) then
	if of_evt_update( i_wparam, i_lparam ) then
		if of_evt_print_preview( i_wparam, i_lparam ) then
		end if
	end if

	rollback using cocos;
end if

return 0
end event

event print_createdata;call super::print_createdata;
integer	l_row

for l_row = 1 to upperbound( dw_prints )
	// ドキュメント名セット
	if isnull( dw_prints[l_row].of_get_document_name() ) then
		dw_prints[l_row].of_set_document_name( fnc.strg.of_format( "{1}(2)【{3}】", this.title, string( l_row ), user.user_id ) )
	else
		dw_prints[l_row].of_set_document_name( fnc.strg.of_format( "{1}【{2}】", dw_prints[l_row].of_get_document_name(), user.user_id ) )
	end if
next

//ddplb_printer.text

return 0

end event

type uo_signal from aw_base_window`uo_signal within iw_print_window
end type

type st_date from aw_base_window`st_date within iw_print_window
end type

type st_user_mei from aw_base_window`st_user_mei within iw_print_window
end type

type uo_test_mode from aw_base_window`uo_test_mode within iw_print_window
integer x = 2860
end type

type p_size_adjust from aw_base_window`p_size_adjust within iw_print_window
integer x = 1120
end type

type st_title from aw_base_window`st_title within iw_print_window
integer x = 1900
end type

type st_title_upper from aw_base_window`st_title_upper within iw_print_window
integer x = 1240
end type

type st_upper from aw_base_window`st_upper within iw_print_window
integer width = 4288
end type

type ddplb_printer from sv_ddplb_printer within iw_print_window
integer x = 1476
integer y = 981
integer width = 1472
integer taborder = 10
boolean bringtotop = true
boolean f8_key = true
boolean f10_key = true
boolean f11_key = true
boolean f12_key = true
end type

type st_bottom from ivo_statictext within iw_print_window
integer y = 1529
integer width = 4288
integer height = 139
boolean bringtotop = true
long backcolor = 12632256
string text = ""
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_preview from sv_cb_print_preview within iw_print_window
integer x = 52
integer y = 1561
integer taborder = 20
boolean bringtotop = true
end type

type cb_print from sv_cb_print within iw_print_window
integer x = 3360
integer y = 1557
integer taborder = 30
boolean bringtotop = true
end type

type cb_cancel from sv_cb_close within iw_print_window
integer x = 3816
integer y = 1557
integer taborder = 40
boolean bringtotop = true
string text = "キャンセル"
end type

type st_printer from ivo_statictext within iw_print_window
integer x = 1148
integer y = 988
boolean bringtotop = true
string text = "印刷先"
alignment alignment = right!
end type

type st_busu from ivo_statictext within iw_print_window
integer x = 1136
integer y = 1120
boolean bringtotop = true
string text = "部数"
alignment alignment = right!
end type

type sle_busu from ivo_singlelineedit within iw_print_window
integer x = 1472
integer y = 1120
integer taborder = 20
boolean bringtotop = true
string text = "1"
end type

type cb_test from commandbutton within iw_print_window
integer x = 80
integer y = 185
integer width = 300
integer height = 75
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
string text = "未設定"
end type

