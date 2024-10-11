$PBExportHeader$iw_main_window.srw
$PBExportComments$aw_windowから継承したメインウインドウの先祖オブジェクト
forward
global type iw_main_window from aw_base_window
end type
type st_second_upper from ivo_statictext within iw_main_window
end type
type cb_retrieve from sv_cb_retrieve within iw_main_window
end type
end forward

global type iw_main_window from aw_base_window
integer width = 5152
integer height = 3360
string icon = "image\window.ico"
integer animationtime = 50
boolean f9_key = true
boolean f10_key = true
boolean confirm_update = true
st_second_upper st_second_upper
cb_retrieve cb_retrieve
end type
global iw_main_window iw_main_window

type variables
protected:
	// 照会のみ(有効/無効)
	boolean	i_readonly

	// パラメーター
	string	i_para

end variables

forward prototypes
public function boolean of_get_readonly ()
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
public function string of_get_focusname ()
end prototypes

public function boolean of_get_readonly ();return i_readonly
end function

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

public function string of_get_focusname ();
graphicobject	l_control
string			l_name

l_control	= getfocus()
l_name		= l_control.classname()

return l_name
end function

on iw_main_window.create
int iCurrent
call super::create
this.st_second_upper=create st_second_upper
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_second_upper
this.Control[iCurrent+2]=this.cb_retrieve
end on

on iw_main_window.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_second_upper)
destroy(this.cb_retrieve)
end on

event open;call super::open;object_type	= "main_window"

// window
integer	l_newwidth,l_newheight

l_newwidth	= pixelstounits( code.def_win_width, xpixelstounits! )
l_newheight	= pixelstounits( code.def_win_height, ypixelstounits! )

resize( l_newwidth, l_newheight )

integer			l_row
string			l_typeof
graphicobject	l_obj

if i_readonly then
	for l_row = 1 to upperbound( this.control )
		l_obj		= this.control[l_row]
		l_typeof	= l_obj.dynamic of_typeof()
		
		// 処理区分が画面上にある場合、照会モードのみの場合は「照会」以外は削除する
		if l_typeof = "ddplb_syori_kbn" then
			l_obj.dynamic of_set_readonly()
		end if
	next
end if

end event

event resize;call super::resize;// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

if this.width < 3924 then
	this.width	= 3924
end if

st_second_upper.width	= st_upper.width
st_second_upper.x		= st_upper.x
st_second_upper.height	= 228
st_second_upper.y		= st_upper.y + st_upper.height


//cb_retrieve.y		= 256

cb_retrieve.width	= 380
cb_retrieve.height	= 85
cb_retrieve.y		= st_second_upper.y + st_second_upper.height - cb_retrieve.height - code.MGN_TATE
cb_retrieve.x		= newwidth - cb_retrieve.width - code.MGN_YOKO

//setredraw( true )


end event

event key_f10;call super::key_f10;
if msg.of_question( "終了しますか？" ) then
	close( this )
end if

return 0
end event

event openquery;call super::openquery;str_para_window	l_para

l_para		= i_msgparm.powerobjectparm

function_name[]	= { "全選択", "行追加", "行削除", "", "Excel出力", "戻り", "ファイル読込", "参照", "初期表示", "終了", "印刷", "更新" }

try
	i_readonly	= l_para.readonly_flg
	i_para		= l_para.param
catch( nullobjecterror ex )
	// パラメータ飛んでこなかったらNullオブジェクトでエラーになるので回避
end try



end event

type uo_signal from aw_base_window`uo_signal within iw_main_window
boolean visible = true
integer x = 4208
integer y = 18
end type

type st_date from aw_base_window`st_date within iw_main_window
integer x = 4720
integer y = 32
end type

type st_user_mei from aw_base_window`st_user_mei within iw_main_window
end type

type uo_test_mode from aw_base_window`uo_test_mode within iw_main_window
integer x = 3424
integer y = 14
end type

type p_size_adjust from aw_base_window`p_size_adjust within iw_main_window
integer x = 1620
integer y = 21
end type

type st_title from aw_base_window`st_title within iw_main_window
integer x = 2412
end type

type st_title_upper from aw_base_window`st_title_upper within iw_main_window
integer x = 1752
end type

type st_upper from aw_base_window`st_upper within iw_main_window
integer width = 5120
end type

type st_second_upper from ivo_statictext within iw_main_window
integer y = 135
integer width = 5120
integer height = 228
long backcolor = 12632256
string text = ""
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_retrieve from sv_cb_retrieve within iw_main_window
integer x = 4176
integer y = 256
integer taborder = 10
boolean bringtotop = true
boolean enter2tab = false
end type

