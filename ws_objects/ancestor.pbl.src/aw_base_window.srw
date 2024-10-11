$PBExportHeader$aw_base_window.srw
$PBExportComments$メインウインドウ始祖オブジェクト
forward
global type aw_base_window from aw_window
end type
type uo_signal from cv_signal within aw_base_window
end type
type st_date from ivo_statictext within aw_base_window
end type
type st_user_mei from ivo_statictext within aw_base_window
end type
type uo_test_mode from cv_test_mode within aw_base_window
end type
type p_size_adjust from uo_p_base within aw_base_window
end type
type st_title from ivo_statictext within aw_base_window
end type
type st_title_upper from ivo_statictext within aw_base_window
end type
type st_upper from ivo_statictext within aw_base_window
end type
end forward

global type aw_base_window from aw_window
integer width = 4240
boolean fnkey_enabled = true
uo_signal uo_signal
st_date st_date
st_user_mei st_user_mei
uo_test_mode uo_test_mode
p_size_adjust p_size_adjust
st_title st_title
st_title_upper st_title_upper
st_upper st_upper
end type
global aw_base_window aw_base_window

type variables

protected:
	// メッセージオブジェクト
	message	i_msgparm

end variables

forward prototypes
public function string of_get_pg_id ()
public function boolean of_get_fnkey_visibled ()
private subroutine fnkey_initialize (boolean p_visible)
public function boolean of_get_controls (ref graphicobject p_controls[])
end prototypes

public function string of_get_pg_id ();return i_pg_id
end function

public function boolean of_get_fnkey_visibled ();return fnkey_enabled
end function

private subroutine fnkey_initialize (boolean p_visible);if p_visible then
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

key_fnc.visible		= p_visible

//this.resize( this.width, this.height )

end subroutine

public function boolean of_get_controls (ref graphicobject p_controls[]);
p_controls	= this.control

return true
end function

on aw_base_window.create
int iCurrent
call super::create
this.uo_signal=create uo_signal
this.st_date=create st_date
this.st_user_mei=create st_user_mei
this.uo_test_mode=create uo_test_mode
this.p_size_adjust=create p_size_adjust
this.st_title=create st_title
this.st_title_upper=create st_title_upper
this.st_upper=create st_upper
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_signal
this.Control[iCurrent+2]=this.st_date
this.Control[iCurrent+3]=this.st_user_mei
this.Control[iCurrent+4]=this.uo_test_mode
this.Control[iCurrent+5]=this.p_size_adjust
this.Control[iCurrent+6]=this.st_title
this.Control[iCurrent+7]=this.st_title_upper
this.Control[iCurrent+8]=this.st_upper
end on

on aw_base_window.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_signal)
destroy(this.st_date)
destroy(this.st_user_mei)
destroy(this.uo_test_mode)
destroy(this.p_size_adjust)
destroy(this.st_title)
destroy(this.st_title_upper)
destroy(this.st_upper)
end on

event open;call super::open;
openuserobject( loading )
openuserobject( key_fnc )

st_title.text	= this.title

if test_mode then
	this.title		= this.title + "【" + this.classname() + "】"
else
	this.title		= this.title
end if

fnkey_initialize( fnkey_enabled )

winctl.of_array_add( this.classname(), this )
end event

event resize;call super::resize;// st_upper
st_upper.x		= 0
st_upper.y		= 4
st_upper.width	= newwidth
st_upper.height	= 140

// st_title_upper
st_title_upper.height	= 96
st_title_upper.width	= st_upper.width * 0.4
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title_upper.y		= st_upper.height / 2 - st_title_upper.height / 2 + st_upper.y

// st_title
st_title.height	= 82
st_title.width	= st_title_upper.width * 0.9
st_title.x		= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
st_title.y		= st_title_upper.height / 2 - st_title.height / 2 + st_title_upper.y

// uo_test_mode
uo_test_mode.x	= st_title_upper.x + st_title_upper.width + 8
uo_test_mode.y	= st_upper.height / 2 - uo_test_mode.height / 2 + st_upper.y

// p_size_adjust
p_size_adjust.y	= st_upper.height / 2 - p_size_adjust.height / 2 + st_upper.y
p_size_adjust.x	= st_title_upper.x - p_size_adjust.width - 8

// st_user_mei
st_user_mei.x	= 24
st_user_mei.y	= st_upper.height / 2 - st_user_mei.height / 2 + st_upper.y

// st_date
st_date.x		= st_upper.x + st_upper.width - st_date.width - 24
st_date.y		= st_upper.height / 2 - st_date.height / 2 + st_upper.y

// uo_signal
uo_signal.x		= st_date.x - uo_signal.width  - 24
uo_signal.y		= st_upper.height / 2 - uo_signal.height / 2 + st_upper.y



// 処理中メッセージ位置調整
if isvalid( loading ) then
	loading.x	= newwidth / 2 - loading.width / 2
	loading.y	= newheight / 2 - loading.height
end if

// ファンクション
if isvalid( key_fnc ) then
	if fnkey_enabled then
		key_fnc.x		= 0
		key_fnc.width	= newwidth
		key_fnc.y		= newheight - key_fnc.height - code.mgn_tate
		
		key_fnc.event resize( sizetype, newwidth, newheight )
	end if
end if

end event

event close;call super::close;setredraw( false )

winctl.of_array_remove( this.classname() )

closeuserobject( key_fnc )
closeuserobject( loading )

end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_msgparm	= message


end event

event print_event;call super::print_event;
// 処理順：retrieve_check → retrieve_event → print_check → print_event → update_check → update_event
// 「retrieve_～」は"print_retrieve"が有効な場合、,「update_～」は"print_update"が有効な場合
// 注意；
end event

event print_createdata;call super::print_createdata;
//integer	l_row
//
//for l_row = 1 to upperbound( dw_print )
//	// ドキュメント名セット
//	if isnull( dw_print[l_row].of_get_document_name() ) then
//		// 無名の場合は画面タイトルをドキュメント名にする
//		dw_print[l_row].of_set_document_name( fnc.strg.of_format( "{1}(2)【{3}】", this.title, string( l_row ), user.user_id ) )
//	else
//		// ドキュメント名にユーザー名を付け加える
//		dw_print[l_row].of_set_document_name( fnc.strg.of_format( "{1}【{2}】", dw_print[l_row].of_get_document_name(), user.user_id ) )
//	end if
//next

return 0

end event

type uo_signal from cv_signal within aw_base_window
boolean visible = false
integer x = 3320
integer y = 14
string i_signal = "変更中"
end type

on uo_signal.destroy
call cv_signal::destroy
end on

type st_date from ivo_statictext within aw_base_window
integer x = 3832
integer y = 28
integer width = 356
string text = "システム日付"
alignment alignment = right!
end type

event constructor;call super::constructor;this.text	= string( fo_num_today(), "####/##/##" )
end event

type st_user_mei from ivo_statictext within aw_base_window
integer x = 44
integer y = 28
integer width = 500
string text = "ユーザー名"
end type

event constructor;call super::constructor;this.text	= fnc.strg.of_format( "{1} {2}", user.user_id, user.user_mei )

end event

type uo_test_mode from cv_test_mode within aw_base_window
boolean visible = false
integer x = 2536
integer y = 11
end type

event constructor;call super::constructor;if test_mode then
	this.visible	= true
end if
end event

on uo_test_mode.destroy
call cv_test_mode::destroy
end on

type p_size_adjust from uo_p_base within aw_base_window
integer x = 780
integer y = 18
integer width = 108
integer height = 96
string pointer = "HyperLink!"
boolean originalsize = false
string picturename = "image\emotion_detective.png"
end type

event clicked;call super::clicked;open( w_size_adjust )
end event

event constructor;call super::constructor;if test_mode then
	this.visible	= true
else
	this.visible	= false
end if


end event

type st_title from ivo_statictext within aw_base_window
integer x = 1568
integer y = 32
integer height = 82
integer textsize = -13
long textcolor = 16777215
long backcolor = 134217745
string text = "タイトル"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type st_title_upper from ivo_statictext within aw_base_window
integer x = 908
integer y = 21
integer width = 1620
integer height = 96
long backcolor = 134217745
string text = ""
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_upper from ivo_statictext within aw_base_window
integer width = 4212
integer height = 139
string text = ""
boolean border = true
borderstyle borderstyle = styleraised!
end type

