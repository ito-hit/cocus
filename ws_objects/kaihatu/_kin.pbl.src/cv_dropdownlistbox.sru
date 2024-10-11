$PBExportHeader$cv_dropdownlistbox.sru
forward
global type cv_dropdownlistbox from ivo_userobject
end type
type cb_ddown from ivo_commandbutton within cv_dropdownlistbox
end type
type sle_input from ivo_singlelineedit within cv_dropdownlistbox
end type
type uo_timer from inv_timing within cv_dropdownlistbox
end type
end forward

global type cv_dropdownlistbox from ivo_userobject
integer width = 400
integer height = 92
event selectionchanged ( integer p_index )
cb_ddown cb_ddown
sle_input sle_input
uo_timer uo_timer
end type
global cv_dropdownlistbox cv_dropdownlistbox

type variables
public:
	string	i_text					// 入力されたテキスト
	boolean	i_arrow_edit			// True:編集可能
	string	i_dataobject			// "":リストボックス 以外:データウインドウリスト
	
	boolean	i_showlist				// True:常時リスト表示
	
	integer	i_interval		= 300	//
	boolean	i_filter				//

	boolean	i_list_open_f4	= true	// 一般的にF4キーでリストがオープンするので

private:
	integer	c_base_height	= 91

	integer	c_arrow_y		= 4
	integer	c_arrow_width	= 84

	integer	c_list_ymargin	= 2

	window	parent_window

	string	this_name
	integer	win_x,win_y
	integer	this_x,this_y,this_width,this_height
	integer	other_x,other_y

	boolean			list_created	// リストのオブジェクトが生成されている（未生成時のresize対応）
	cv_dropdownlist	list
end variables

forward prototypes
private function window get_parent_window ()
public subroutine list_reposition ()
public subroutine of_list_show ()
public subroutine of_list_action ()
public subroutine of_list_hide ()
public subroutine of_set_showlist (boolean p_visible)
public subroutine of_callback (string p_event, string p_value, boolean p_close)
end prototypes

event selectionchanged(integer p_index);string	l_text

if len( i_dataobject ) > 0 then
else
	l_text	= list.lbox.selecteditem( )
end if

sle_input.text = l_text
end event

private function window get_parent_window ();
boolean	l_find

window		l_window

graphicobject	l_graphic
userobject		l_obj
tab				l_tab

integer			l_x,l_y

// こいつの親からスタート
l_graphic	= parent

do until l_find
	choose case typeof( l_graphic )
		case window!
			l_window	= l_graphic
			l_find		= true
		case tab!
			l_tab		= l_graphic

			// ネストされた配置ならそれぞれの配置位置を加算していく
			l_x			= l_x + l_tab.x
			l_y			= l_y + l_tab.y

			l_graphic	= l_tab.getparent()
		case userobject!
			l_obj	= l_graphic

			// ネストされた配置ならそれぞれの配置位置を加算していく
			l_x			= l_x + l_obj.x
			l_y			= l_y + l_obj.y

			l_graphic	= l_obj.getparent()
		case else
			messagebox( "", "違う" )
	end choose
loop

other_x	= l_x
other_y	= l_y

return l_window
end function

public subroutine list_reposition ();
window	l_window

this_x		= this.x
this_y		= this.y
this_width	= this.width
this_height	= this.height

l_window	= get_parent_window( )

list.x		= this_x + other_x
list.y		= this_y + other_y + this_height + c_list_ymargin
list.width	= this_width

end subroutine

public subroutine of_list_show ();
list.show()
end subroutine

public subroutine of_list_action ();
if not list.show_active then
	of_list_show( )
	list.of_setfocus()
	list.show_active	= true
else
	of_list_hide( )
	sle_input.setfocus()
	list.show_active	= false
end if


end subroutine

public subroutine of_list_hide ();
list.hide()

end subroutine

public subroutine of_set_showlist (boolean p_visible);
cb_ddown.visible	= not p_visible

if p_visible then
	of_list_show()
else
	of_list_hide()
end if
end subroutine

public subroutine of_callback (string p_event, string p_value, boolean p_close);
choose case p_event
	case "getfocus"
	case "losefocus"
//		of_list_hide()
	case "selectionchanged"
		event selectionchanged( long( p_value ) )
		
		if p_close then
			of_list_hide()
			sle_input.setfocus()
			list.show_active	= false
		end if
end choose


end subroutine

on cv_dropdownlistbox.create
int iCurrent
call super::create
this.cb_ddown=create cb_ddown
this.sle_input=create sle_input
this.uo_timer=create uo_timer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ddown
this.Control[iCurrent+2]=this.sle_input
end on

on cv_dropdownlistbox.destroy
call super::destroy
destroy(this.cb_ddown)
destroy(this.sle_input)
destroy(this.uo_timer)
end on

event resize;call super::resize;
sle_input.y			= 0
sle_input.x			= 0
cb_ddown.y			= c_arrow_y

this.height			= c_base_height
sle_input.height	= this.height
cb_ddown.height		= this.height - c_arrow_y * 2

sle_input.width		= newwidth
cb_ddown.width		= c_arrow_width
cb_ddown.x			= sle_input.width - cb_ddown.width - c_arrow_y

if list_created then
	list_reposition()
end if

end event

event constructor;call super::constructor;
this_name	= this.classname()

// 親Window取得
parent_window	= get_parent_window( )

parent_window.openuserobject( list )
of_list_hide( )

//list_enabled	= true

// listの内部初期化
list.of_constructor( this, i_dataobject )

list.of_additem( "222" )
list.of_additem( "333" )

list_reposition()


end event

event destructor;call super::destructor;
parent_window.closeuserobject( list )

end event

type cb_ddown from ivo_commandbutton within cv_dropdownlistbox
integer x = 312
integer y = 4
integer width = 84
integer height = 85
integer taborder = 30
fontcharset fontcharset = ansi!
fontfamily fontfamily = roman!
string facename = "MingLiU-ExtB"
string text = ""
end type

event execution;call super::execution;
if not list.show_active then
	of_list_show()
	list.of_setfocus()
	list.show_active	= true
else
	of_list_hide()
	sle_input.setfocus()
	list.show_active	= false
end if


end event

type sle_input from ivo_singlelineedit within cv_dropdownlistbox
integer width = 400
integer height = 92
integer taborder = 10
string text = ""
end type

event change;call super::change;
// selecttionchangedイベント駆動時は動作しない
string	l_text

uo_timer.stop()

i_filter	= true

uo_timer.start( i_interval / 1000 )

end event

event fnkeyevent;call super::fnkeyevent;
choose case p_keycode
	case keyf4!
		if i_list_open_f4 then
			cb_ddown.event execution( 0, 0 )
		end if
end choose

return 0
end event

type uo_timer from inv_timing within cv_dropdownlistbox descriptor "pb_nvo" = "true" 
end type

on uo_timer.create
call super::create
end on

on uo_timer.destroy
call super::destroy
end on

event timer_event;call super::timer_event;
if i_filter then
	this.stop()

	// リスト非表示状態なら表示状態に変更（絞り込みが分かりやすくなる）
//	if not i_showlist then
//		of_set_showlist( true )
//	end if
//	
//	// リスト再生成
//	list.of_filter( sle_input.text )
//	
//	// リスト再生成
//	l_text	= ddplb_tokui.text
//	l_row2	= 1
//
//	if len( l_text ) > 0 then
//		for l_row = 1 to upperbound( i_list_tokui )
//			if pos( i_list_tokui[l_row], l_text ) > 0 then
//				l_list[l_row2]	= i_list_tokui[l_row]
//				l_row2			= l_row2 + 1
//			end if
//		next
//	else
//		l_list	= i_list_tokui
//	end if
//
//	l_row	= ddplb_tokui.totalitems()
//
//
//	do until l_row = 0
//		l_row	= ddplb_tokui.deleteitem( 1 )
//	loop
//	
//	for l_row = 1 to upperbound( l_list )
//		ddplb_tokui.additem( l_list[l_row] )
//	next
//
//	ddplb_tokui.text	= l_text
//	ddplb_tokui.selecttext( len( l_text ) + 1, 0 )
//	
//	i_dynamic_filter_tokui	= false

//	ddplb_tokui.setredraw( true )
end if

end event

