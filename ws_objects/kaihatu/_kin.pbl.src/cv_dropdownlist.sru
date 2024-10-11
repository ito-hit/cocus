$PBExportHeader$cv_dropdownlist.sru
forward
global type cv_dropdownlist from ivo_userobject
end type
type dwlist from ivo_datawindow within cv_dropdownlist
end type
type lbox from ivo_listbox within cv_dropdownlist
end type
end forward

global type cv_dropdownlist from ivo_userobject
long backcolor = 134217730
boolean f4_key = true
dwlist dwlist
lbox lbox
end type
global cv_dropdownlist cv_dropdownlist

type variables
public:
	cv_dropdownlistbox	parentobj
	boolean	show_active

private:
	// 共通
	string	filter_text	// フィルタ条件のテキスト
	
	// リストボックス用
	boolean	seledted_close	= true	// True:選択後にリストを閉じる
	string	lbox_original[]
	
	// データウインドウ用
	boolean	enabled_dw	// True:DW有効
	string	dataobject	// DWオブジェクト

end variables

forward prototypes
public subroutine of_additem (string p_value)
public subroutine of_setfocus ()
public subroutine of_constructor (cv_dropdownlistbox p_parent)
public subroutine of_constructor (cv_dropdownlistbox p_parent, string p_dataobject)
public function integer of_filter (string p_text)
private function integer filter_datawindow ()
private function integer filter_listbox ()
public function integer of_create (string p_data[])
public function integer of_create (datawindow p_data)
private function integer create_datawindow (datawindow p_data)
private function integer create_listbox (string p_data[])
end prototypes

public subroutine of_additem (string p_value);
lbox.additem( p_value )
end subroutine

public subroutine of_setfocus ();
if enabled_dw then
	dwlist.setfocus()
else
	lbox.setfocus()
end if
end subroutine

public subroutine of_constructor (cv_dropdownlistbox p_parent);
of_constructor( p_parent, "" )
end subroutine

public subroutine of_constructor (cv_dropdownlistbox p_parent, string p_dataobject);
// 初期化
enabled_dw			= false

dwlist.dataobject	= ""

dwlist.visible		= false
lbox.visible		= false

parentobj	= p_parent

if len( p_dataobject ) > 0 then
	dataobject	= p_dataobject
	enabled_dw	= true

	dwlist.visible	= true

	dwlist.dataobject	= dataobject
	dwlist.settransobject( cocos )
else
	lbox.visible	= true
end if
end subroutine

public function integer of_filter (string p_text);
filter_text	= p_text

if enabled_dw then
	// データウインドウオブジェクトにフィルタ
	post filter_datawindow( )
else
	// リストボックスにフィルタ
	post filter_listbox( )
end if

return 0
end function

private function integer filter_datawindow ();
return 0
end function

private function integer filter_listbox ();
integer	l_row, l_row2
string	l_list[]

l_row2	= 1

if len( filter_text ) > 0 then
	for l_row = 1 to upperbound( lbox_original )
		if pos( lbox_original[l_row], filter_text ) > 0 then
			l_list[l_row2]	= lbox_original[l_row]
			l_row2			= l_row2 + 1
		end if
	next
else
	l_list	= lbox_original
end if

l_row	= lbox.totalitems()

lbox.reset()
	
for l_row = 1 to upperbound( l_list )
	lbox.additem( l_list[l_row] )
next

return 0
end function

public function integer of_create (string p_data[]);
create_listbox( p_data )

return 0
end function

public function integer of_create (datawindow p_data);
 create_datawindow( p_data )

return 0
end function

private function integer create_datawindow (datawindow p_data);
return 0
end function

private function integer create_listbox (string p_data[]);
return 0
end function

on cv_dropdownlist.create
int iCurrent
call super::create
this.dwlist=create dwlist
this.lbox=create lbox
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dwlist
this.Control[iCurrent+2]=this.lbox
end on

on cv_dropdownlist.destroy
call super::destroy
destroy(this.dwlist)
destroy(this.lbox)
end on

event resize;call super::resize;lbox.x			= 0
lbox.y			= 0
lbox.width		= newwidth
lbox.height		= newheight

dwlist.x		= 0
dwlist.y		= 0
dwlist.width	= newwidth
dwlist.height	= newheight

end event

event key_f04;call super::key_f04;messagebox( "", "List_F4" )

return 0
end event

event key_enter;call super::key_enter;
seledted_close	= true

lbox.event selectionchanged( lbox.selectedindex() )

return 0
end event

event key_up;call super::key_up;
seledted_close	= false

return 0
end event

event key_down;call super::key_down;
seledted_close	= false

return 0
end event

type dwlist from ivo_datawindow within cv_dropdownlist
boolean visible = false
integer x = 984
integer y = 213
integer taborder = 20
boolean vscrollbar = true
boolean border = false
end type

event key_down;call super::key_down;
parent.event key_down( key, keyflags )

return 0
end event

event key_f01;call super::key_f01;
parent.event key_f01( key, keyflags )

return 0
end event

event key_f02;call super::key_f02;
parent.event key_f02( key, keyflags )

return 0
end event

event key_f03;call super::key_f03;
parent.event key_f03( key, keyflags )

return 0
end event

event key_f04;call super::key_f04;
parent.event key_f04( key, keyflags )

return 0
end event

event key_f05;call super::key_f05;
parent.event key_f05( key, keyflags )

return 0
end event

event key_f06;call super::key_f06;
parent.event key_f06( key, keyflags )

return 0
end event

event key_f07;call super::key_f07;
parent.event key_f07( key, keyflags )

return 0
end event

event key_f08;call super::key_f08;
parent.event key_f08( key, keyflags )

return 0
end event

event key_f09;call super::key_f09;
parent.event key_f09( key, keyflags )

return 0
end event

event key_f10;call super::key_f10;
parent.event key_f10( key, keyflags )

return 0
end event

event key_f11;call super::key_f11;
parent.event key_f11( key, keyflags )

return 0
end event

event key_f12;call super::key_f12;
parent.event key_f12( key, keyflags )

return 0
end event

event key_up;call super::key_up;
parent.event key_up( key, keyflags )

return 0
end event

type lbox from ivo_listbox within cv_dropdownlist
event clicked pbm_lbuttonclk
boolean visible = false
integer x = 284
integer y = 302
integer taborder = 10
boolean vscrollbar = true
boolean disablenoscroll = true
boolean f4_key = true
boolean up_key = true
boolean down_key = true
boolean enter2tab = false
end type

event clicked;messagebox( "","クリック" )
end event

event selectionchanged;call super::selectionchanged;
parentobj.of_callback( "selectionchanged", string( index ), seledted_close )

seledted_close	= true
end event

event getfocus;call super::getfocus;
if this.totalitems() > 0 then
	if this.selectedindex() > 0 then
	else
		this.selectitem( 1 )
	end if

	parentobj.of_callback( "getfocus", "", seledted_close )
end if

end event

event losefocus;call super::losefocus;
parentobj.of_callback( "losefocus", "", seledted_close )


end event

event rbuttondown;call super::rbuttondown;messagebox( "", "右マウスクリック" )
end event

event key_f04;call super::key_f04;
parent.event key_f04( key, keyflags )

return 0
end event

event key_f05;call super::key_f05;
parent.event key_f05( key, keyflags )

return 0
end event

event key_f06;call super::key_f06;
parent.event key_f06( key, keyflags )

return 0
end event

event key_f07;call super::key_f07;
parent.event key_f07( key, keyflags )

return 0
end event

event key_f08;call super::key_f08;
parent.event key_f08( key, keyflags )

return 0
end event

event key_f09;call super::key_f09;
parent.event key_f09( key, keyflags )

return 0
end event

event key_f10;call super::key_f10;
parent.event key_f10( key, keyflags )

return 0
end event

event key_f11;call super::key_f11;
parent.event key_f11( key, keyflags )

return 0
end event

event key_f12;call super::key_f12;
parent.event key_f12( key, keyflags )

return 0
end event

event key_f01;call super::key_f01;
parent.event key_f01( key, keyflags )

return 0
end event

event key_f02;call super::key_f02;
parent.event key_f02( key, keyflags )

return 0
end event

event key_f03;call super::key_f03;
parent.event key_f03( key, keyflags )

return 0
end event

event key_down;call super::key_down;
parent.event key_down( key, keyflags )

return 0
end event

event key_enter;call super::key_enter;
parent.event key_enter( key, keyflags )

return 0
end event

event key_up;call super::key_up;
parent.event key_up( key, keyflags )

return 0
end event

