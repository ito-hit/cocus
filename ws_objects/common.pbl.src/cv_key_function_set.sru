$PBExportHeader$cv_key_function_set.sru
$PBExportComments$メインウインドウ下段のファンクションキーに関するカスタムオブジェクト
forward
global type cv_key_function_set from asv_userobject
end type
type uo_keyset3 from acv_key_function within cv_key_function_set
end type
type uo_keyset2 from acv_key_function within cv_key_function_set
end type
type uo_keyset1 from acv_key_function within cv_key_function_set
end type
end forward

global type cv_key_function_set from asv_userobject
integer width = 3892
integer height = 203
event resize pbm_size
uo_keyset3 uo_keyset3
uo_keyset2 uo_keyset2
uo_keyset1 uo_keyset1
end type
global cv_key_function_set cv_key_function_set

type variables
public:
	graphicobject focusobj

	string	base_function_name[]
	boolean	base_function_enabled[]

	string	base_sfunction_name[]
	boolean	base_sfunction_enabled[]

protected:
	boolean	on_shift, on_control

end variables

forward prototypes
public subroutine of_set_fuction_name ()
private subroutine set_base_function (ref commandbutton p_button, string p_name, boolean p_enabled)
public subroutine of_set_fuction_name (string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags)
public function integer of_get_keyflags ()
end prototypes

event resize;this.height	= uo_keyset1.height

integer	l_width
integer	l_space = 40

l_width	= this.width - ( l_space * 3 * 2 ) // 角ボタンの左右スペースを省いた横幅

uo_keyset1.width	= l_width / 3
uo_keyset2.width	= l_width / 3
uo_keyset3.width	= l_width / 3

// とりあえず最大サイズを1800に(1800はとりあえず)
if uo_keyset1.width > 1800 then
	uo_keyset1.width	= 1800
	uo_keyset2.width	= 1800
	uo_keyset3.width	= 1800

	l_space	= ( this.width - ( uo_keyset3.width * 3 ) ) / 6
end if

uo_keyset1.x	= l_space
uo_keyset2.x	= uo_keyset1.x + uo_keyset1.width + l_space * 2
uo_keyset3.x	= uo_keyset2.x + uo_keyset2.width + l_space * 2

uo_keyset1.event resize( sizetype, newwidth, newheight )
uo_keyset2.event resize( sizetype, newwidth, newheight )
uo_keyset3.event resize( sizetype, newwidth, newheight )


end event

public subroutine of_set_fuction_name ();string			l_fn_name[]
boolean			l_fn_enabled[]
unsignedlong	l_keyflags

l_keyflags	= 0

of_set_fuction_name( l_fn_name, l_fn_enabled, l_keyflags )

end subroutine

private subroutine set_base_function (ref commandbutton p_button, string p_name, boolean p_enabled);if p_name <> "" then
	p_button.text		= p_name
else
	p_button.text		= ""
end if

p_button.enabled	= p_enabled
end subroutine

public subroutine of_set_fuction_name (string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags);this.setredraw( false )

// keyflags情報セット
choose case p_keyflags
	case 0
		on_shift	= false
		on_control	= false
	case 1
		on_shift	= true
		on_control	= false
	case 2
		on_shift	= false
		on_control	= true
	case 3
		on_shift	= true
		on_control	= true
	case else
		on_shift	= false
		on_control	= false
end choose

// 初期化
this.uo_keyset1.cb_key1.enabled	= true
this.uo_keyset1.cb_key2.enabled	= true
this.uo_keyset1.cb_key3.enabled	= true
this.uo_keyset1.cb_key4.enabled	= true
this.uo_keyset2.cb_key1.enabled	= true
this.uo_keyset2.cb_key2.enabled	= true
this.uo_keyset2.cb_key3.enabled	= true
this.uo_keyset2.cb_key4.enabled	= true
this.uo_keyset3.cb_key1.enabled	= true
this.uo_keyset3.cb_key2.enabled	= true
this.uo_keyset3.cb_key3.enabled	= true
this.uo_keyset3.cb_key4.enabled	= true

// Shiftキー押下状態でセットするベース内容を変更する
string	l_base_name[]
boolean	l_base_enabled[]

if not on_shift then
	l_base_name		= base_function_name
	l_base_enabled	= base_function_enabled
else
	l_base_name		= base_sfunction_name
	l_base_enabled	= base_sfunction_enabled
end if

if upperbound( p_fn_name ) <> 0 then
	if p_fn_name[1] <> "" then
		this.uo_keyset1.cb_key1.text	= p_fn_name[1]
		this.uo_keyset1.cb_key1.enabled	= p_fn_enabled[1]
	else
		set_base_function( this.uo_keyset1.cb_key1, l_base_name[1], p_fn_enabled[1] )
	end if

	if p_fn_name[2] <> "" then
		this.uo_keyset1.cb_key2.text	= p_fn_name[2]
		this.uo_keyset1.cb_key2.enabled	= p_fn_enabled[2]
	else
		set_base_function( this.uo_keyset1.cb_key2, l_base_name[2], p_fn_enabled[2] )
	end if

	if p_fn_name[3] <> "" then
		this.uo_keyset1.cb_key3.text	= p_fn_name[3]
		this.uo_keyset1.cb_key3.enabled	= p_fn_enabled[3]
	else
		set_base_function( this.uo_keyset1.cb_key3, l_base_name[3], p_fn_enabled[3] )
	end if

	if p_fn_name[4] <> "" then
		this.uo_keyset1.cb_key4.text	= p_fn_name[4]
		this.uo_keyset1.cb_key4.enabled	= p_fn_enabled[4]
	else
		set_base_function( this.uo_keyset1.cb_key4, l_base_name[4], p_fn_enabled[4] )
	end if

	if p_fn_name[5] <> "" then
		this.uo_keyset2.cb_key1.text	= p_fn_name[5]
		this.uo_keyset2.cb_key1.enabled	= p_fn_enabled[5]
	else
		set_base_function( this.uo_keyset2.cb_key1, l_base_name[5], p_fn_enabled[5] )
	end if

	if p_fn_name[6] <> "" then
		this.uo_keyset2.cb_key2.text	= p_fn_name[6]
		this.uo_keyset2.cb_key2.enabled	= p_fn_enabled[6]
	else
		set_base_function( this.uo_keyset2.cb_key2, l_base_name[6], p_fn_enabled[6] )
	end if

	if p_fn_name[7] <> "" then
		this.uo_keyset2.cb_key3.text	= p_fn_name[7]
		this.uo_keyset2.cb_key3.enabled	= p_fn_enabled[7]
	else
		set_base_function( this.uo_keyset2.cb_key3, l_base_name[7], p_fn_enabled[7] )
	end if

	if p_fn_name[8] <> "" then
		this.uo_keyset2.cb_key4.text	= p_fn_name[8]
		this.uo_keyset2.cb_key4.enabled	= p_fn_enabled[8]
	else
		set_base_function( this.uo_keyset2.cb_key4, l_base_name[8], p_fn_enabled[8] )
	end if

	if p_fn_name[9] <> "" then
		this.uo_keyset3.cb_key1.text	= p_fn_name[9]
		this.uo_keyset3.cb_key1.enabled	= p_fn_enabled[9]
	else
		set_base_function( this.uo_keyset3.cb_key1, l_base_name[9], p_fn_enabled[9] )
	end if

	if p_fn_name[10] <> "" then
		this.uo_keyset3.cb_key2.text	= p_fn_name[10]
		this.uo_keyset3.cb_key2.enabled	= p_fn_enabled[10]
	else
		set_base_function( this.uo_keyset3.cb_key2, l_base_name[10], p_fn_enabled[10] )
	end if

	if p_fn_name[11] <> "" then
		this.uo_keyset3.cb_key3.text	= p_fn_name[11]
		this.uo_keyset3.cb_key3.enabled	= p_fn_enabled[11]
	else
		set_base_function( this.uo_keyset3.cb_key3, l_base_name[11], p_fn_enabled[11] )
	end if

	if p_fn_name[12] <> "" then
		this.uo_keyset3.cb_key4.text	= p_fn_name[12]
		this.uo_keyset3.cb_key4.enabled	= p_fn_enabled[12]
	else
		set_base_function( this.uo_keyset3.cb_key4, l_base_name[12], p_fn_enabled[12] )
	end if
else
	// p_fn_nameに配列がなければベース設定
	set_base_function( this.uo_keyset1.cb_key1, l_base_name[1], l_base_enabled[1] )
	set_base_function( this.uo_keyset1.cb_key2, l_base_name[2], l_base_enabled[2] )
	set_base_function( this.uo_keyset1.cb_key3, l_base_name[3], l_base_enabled[3] )
	set_base_function( this.uo_keyset1.cb_key4, l_base_name[4], l_base_enabled[4] )
	set_base_function( this.uo_keyset2.cb_key1, l_base_name[5], l_base_enabled[5] )
	set_base_function( this.uo_keyset2.cb_key2, l_base_name[6], l_base_enabled[6] )
	set_base_function( this.uo_keyset2.cb_key3, l_base_name[7], l_base_enabled[7] )
	set_base_function( this.uo_keyset2.cb_key4, l_base_name[8], l_base_enabled[8] )
	set_base_function( this.uo_keyset3.cb_key1, l_base_name[9], l_base_enabled[9] )
	set_base_function( this.uo_keyset3.cb_key2, l_base_name[10], l_base_enabled[10] )
	set_base_function( this.uo_keyset3.cb_key3, l_base_name[11], l_base_enabled[11] )
	set_base_function( this.uo_keyset3.cb_key4, l_base_name[12], l_base_enabled[12] )
end if

this.uo_keyset1.focusobj	= focusobj
this.uo_keyset2.focusobj	= focusobj
this.uo_keyset3.focusobj	= focusobj

this.setredraw( true )

end subroutine

public function integer of_get_keyflags ();unsignedlong	l_keyflags

if on_shift then
	l_keyflags	= l_keyflags + 1
end if

if on_control then
	l_keyflags	= l_keyflags + 2
end if
	
return l_keyflags
end function

on cv_key_function_set.create
int iCurrent
call super::create
this.uo_keyset3=create uo_keyset3
this.uo_keyset2=create uo_keyset2
this.uo_keyset1=create uo_keyset1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_keyset3
this.Control[iCurrent+2]=this.uo_keyset2
this.Control[iCurrent+3]=this.uo_keyset1
end on

on cv_key_function_set.destroy
call super::destroy
destroy(this.uo_keyset3)
destroy(this.uo_keyset2)
destroy(this.uo_keyset1)
end on

event constructor;object_type	= "key_function_set"

uo_keyset1.st_key1.text	= "F1"
uo_keyset1.st_key2.text	= "F2"
uo_keyset1.st_key3.text	= "F3"
uo_keyset1.st_key4.text	= "F4"

uo_keyset2.st_key1.text	= "F5"
uo_keyset2.st_key2.text	= "F6"
uo_keyset2.st_key3.text	= "F7"
uo_keyset2.st_key4.text	= "F8"

uo_keyset3.st_key1.text	= "F9"
uo_keyset3.st_key2.text	= "F10"
uo_keyset3.st_key3.text	= "F11"
uo_keyset3.st_key4.text	= "F12"


end event

event fnkeyevent;return 0
end event

type uo_keyset3 from acv_key_function within cv_key_function_set
integer x = 2520
integer taborder = 30
end type

on uo_keyset3.destroy
call acv_key_function::destroy
end on

type uo_keyset2 from acv_key_function within cv_key_function_set
integer x = 1276
integer taborder = 40
end type

on uo_keyset2.destroy
call acv_key_function::destroy
end on

type uo_keyset1 from acv_key_function within cv_key_function_set
integer taborder = 30
end type

on uo_keyset1.destroy
call acv_key_function::destroy
end on

