$PBExportHeader$acv_key_function.sru
$PBExportComments$メインウインドウ下段のファンクションキーに関する始祖オブジェクト
forward
global type acv_key_function from asv_userobject
end type
type st_key3 from asv_statictext within acv_key_function
end type
type st_key4 from asv_statictext within acv_key_function
end type
type cb_key4 from asv_commandbutton within acv_key_function
end type
type cb_key3 from asv_commandbutton within acv_key_function
end type
type cb_key2 from asv_commandbutton within acv_key_function
end type
type st_key2 from asv_statictext within acv_key_function
end type
type cb_key1 from asv_commandbutton within acv_key_function
end type
type st_key1 from asv_statictext within acv_key_function
end type
end forward

global type acv_key_function from asv_userobject
integer width = 1212
integer height = 192
event button_clicked ( string p_fn_name )
st_key3 st_key3
st_key4 st_key4
cb_key4 cb_key4
cb_key3 cb_key3
cb_key2 cb_key2
st_key2 st_key2
cb_key1 cb_key1
st_key1 st_key1
end type
global acv_key_function acv_key_function

type variables
graphicobject 			focusobj

private:
	ivo_animation				i_anmtin
	ivo_checkbox				i_chkbox
	ivo_commandbutton			i_cmdbtn
	ivo_datawindow				i_datwin
	ivo_datepicker				i_dtpick
	ivo_dropdownlistbox			i_dpdnlst
	ivo_dropdownpicturelistbox	i_dpdnpiclst
	ivo_editmask				i_edtmsk
	ivo_graph					i_graph
	ivo_groupbox				i_grpbox
	ivo_hprogressbar			i_hprgrs
	ivo_hscrollbar				i_hscrl
	ivo_htrackbar				i_htrck
	ivo_inkedit					i_inkedt
	ivo_inkpicture				i_inkpic
	ivo_listbox					i_lstbox
	ivo_listview				i_lstview
	ivo_monthcalendar			i_monthcal
	ivo_multilineedit			i_mltilinedt
	ivo_picture					i_pic
	ivo_picturebutton			i_picbtn
	ivo_picturehyperlink		i_pichyplnk
	ivo_picturelistbox			i_piclst
	ivo_radiobutton				i_rdiobtn
	ivo_richtextedit			i_rtxtedt
	ivo_singlelineedit			i_sgllineedt
	ivo_statichyperlink			i_stchyplnk
	ivo_statictext				i_stctxt
	ivo_tab						i_tab
	ivo_treeview				i_trview
	ivo_userobject				i_usrobj
	ivo_vprogressbar			i_vprgrs
	ivo_vscrollbar				i_vscrl
	ivo_vtrackbar				i_vtrck
	aw_window					i_win

end variables

forward prototypes
private function keycode get_keycode (string p_fn_name)
end prototypes

event button_clicked(string p_fn_name);boolean	l_parent_window	= false
keycode	l_keycode

choose case typeof( focusobj )
	case animation!
		i_anmtin		= focusobj
		i_anmtin.setfocus( )
	case checkbox!
		i_chkbox		= focusobj
		i_chkbox.setfocus()
	case commandbutton!
		i_cmdbtn		= focusobj
		i_cmdbtn.setfocus()
	case datawindow!
		i_datwin		= focusobj
		i_datwin.setfocus()
	case datepicker!
		i_dtpick		= focusobj
		i_dtpick.setfocus()
	case dropdownlistbox!
		i_dpdnlst		= focusobj
		i_dpdnlst.setfocus()
	case dropdownpicturelistbox!
		i_dpdnpiclst	= focusobj
		i_dpdnpiclst.setfocus()
	case editmask!
		i_edtmsk		= focusobj
		i_edtmsk.setfocus()
	case graph!
		i_graph			= focusobj
		i_graph.setfocus()
	case groupbox!
		i_grpbox		= focusobj
		i_grpbox.setfocus()
	case hprogressbar!
		i_hprgrs		= focusobj
		i_hprgrs.setfocus()
	case hscrollbar!
		i_hscrl			= focusobj
		i_hscrl.setfocus()
	case htrackbar!
		i_htrck			= focusobj
		i_htrck.setfocus()
	case inkedit!
		i_inkedt		= focusobj
		i_inkedt.setfocus()
	case inkpicture!
		i_inkpic		= focusobj
		i_inkpic.setfocus()
	case listbox!
		i_lstbox		= focusobj
		i_lstbox.setfocus()
	case listview!
		i_lstview		= focusobj
		i_lstview.setfocus()
	case monthcalendar!
		i_monthcal		= focusobj
		i_monthcal.setfocus()
	case multilineedit!
		i_mltilinedt	= focusobj
		i_mltilinedt.setfocus()
	case picture!
		i_pic			= focusobj
		i_pic.setfocus()
	case picturebutton!
		i_picbtn		= focusobj
		i_picbtn.setfocus()
	case picturehyperlink!
		i_pichyplnk		= focusobj
		i_pichyplnk.setfocus()
	case picturelistbox!
		i_piclst		= focusobj
		i_piclst.setfocus()
	case radiobutton!
		i_rdiobtn		= focusobj
		i_rdiobtn.setfocus()
	case richtextedit!
		i_rtxtedt		= focusobj
		i_rtxtedt.setfocus()
	case singlelineedit!
		i_sgllineedt	= focusobj
		i_sgllineedt.setfocus()
	case statichyperlink!
		i_stchyplnk		= focusobj
		i_stchyplnk.setfocus()
	case statictext!
		i_stctxt		= focusobj
		i_stctxt.setfocus()
	case tab!
		i_tab			= focusobj
		i_tab.setfocus()
	case treeview!
		i_trview		= focusobj
		i_trview.setfocus()
	case userobject!
		i_usrobj		= focusobj
		i_usrobj.setfocus()
	case vprogressbar!
		i_vprgrs		= focusobj
		i_vprgrs.setfocus()
	case vscrollbar!
		i_vscrl			= focusobj
		i_vscrl.setfocus()
	case vtrackbar!
		i_vtrck			= focusobj
		i_vtrck.setfocus()
	case window!
		i_win			= focusobj
		i_win.setfocus()
	case else
		//messagebox( p_fn_name, "else" )
end choose

// ファンクションキーのヘッダからキーコード取得
l_keycode	= get_keycode( p_fn_name )

// keyflags取得
unsignedlong	l_keyflags
integer			l_shift, l_control

l_keyflags	= parent.dynamic of_get_keyflags()

choose case l_keyflags
	case 0
		l_shift		= 0
		l_control	= 0
	case 1
		l_shift		= 1
		l_control	= 0
	case 2
		l_shift		= 0
		l_control	= 1
	case 3
		l_shift		= 1
		l_control	= 1
	case else
		l_shift		= 0
		l_control	= 0
end choose


// フォーカスがある各コントロールのfnkeyeventをキック
focusobj.dynamic event fnkeyevent( l_keycode, l_control, l_shift )

end event

private function keycode get_keycode (string p_fn_name);choose case upper( p_fn_name )
	case "F1"
		return KeyF1!
	case "F2"
		return KeyF2!
	case "F3"
		return KeyF3!
	case "F4"
		return KeyF4!
	case "F5"
		return KeyF5!
	case "F6"
		return KeyF6!
	case "F7"
		return KeyF7!
	case "F8"
		return KeyF8!
	case "F9"
		return KeyF9!
	case "F10"
		return KeyF10!
	case "F11"
		return KeyF11!
	case "F12"
		return KeyF12!
end choose

msg.of_error( "ファンクションキーの指定に誤りがあります。(acv_key_function:get_keycode:" + p_fn_name + ")" )
return KeyF10!




end function

on acv_key_function.create
int iCurrent
call super::create
this.st_key3=create st_key3
this.st_key4=create st_key4
this.cb_key4=create cb_key4
this.cb_key3=create cb_key3
this.cb_key2=create cb_key2
this.st_key2=create st_key2
this.cb_key1=create cb_key1
this.st_key1=create st_key1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_key3
this.Control[iCurrent+2]=this.st_key4
this.Control[iCurrent+3]=this.cb_key4
this.Control[iCurrent+4]=this.cb_key3
this.Control[iCurrent+5]=this.cb_key2
this.Control[iCurrent+6]=this.st_key2
this.Control[iCurrent+7]=this.cb_key1
this.Control[iCurrent+8]=this.st_key1
end on

on acv_key_function.destroy
call super::destroy
destroy(this.st_key3)
destroy(this.st_key4)
destroy(this.cb_key4)
destroy(this.cb_key3)
destroy(this.cb_key2)
destroy(this.st_key2)
destroy(this.cb_key1)
destroy(this.st_key1)
end on

event resize;call super::resize;integer	l_width,l_space

l_space	= 2
l_width	= this.width - ( l_space * 2 * 4 ) - 7

cb_key1.width	= l_width / 4
cb_key2.width	= l_width / 4
cb_key3.width	= l_width / 4
cb_key4.width	= l_width / 4

cb_key1.x	= l_space
cb_key2.x	= cb_key1.x + cb_key1.width + l_space * 2
cb_key3.x	= cb_key2.x + cb_key2.width + l_space * 2
cb_key4.x	= cb_key3.x + cb_key3.width + l_space * 2

st_key1.x	= cb_key1.x
st_key2.x	= cb_key2.x
st_key3.x	= cb_key3.x
st_key4.x	= cb_key4.x

end event

event fnkeyevent;return 0
end event

type st_key3 from asv_statictext within acv_key_function
integer x = 604
integer width = 104
integer height = 60
fontcharset fontcharset = ansi!
string facename = "Yu Gothic UI Semilight"
string text = "F3"
end type

event getfocus;//
end event

type st_key4 from asv_statictext within acv_key_function
integer x = 908
integer width = 104
integer height = 60
fontcharset fontcharset = ansi!
string facename = "Yu Gothic UI Semilight"
string text = "F4"
end type

event getfocus;//
end event

type cb_key4 from asv_commandbutton within acv_key_function
integer x = 908
integer y = 57
integer height = 132
integer taborder = 20
integer textsize = -11
string facename = "Yu Gothic UI Semilight"
string text = "Excel出力"
end type

event clicked;parent.event button_clicked( st_key4.text )
end event

event getfocus;//
end event

event fnkeyevent;return 0
end event

type cb_key3 from asv_commandbutton within acv_key_function
integer x = 604
integer y = 57
integer height = 132
integer taborder = 20
integer textsize = -11
string facename = "Yu Gothic UI Semilight"
string text = "Excel出力"
end type

event clicked;parent.event button_clicked( st_key3.text )
end event

event getfocus;//
end event

event fnkeyevent;return 0
end event

type cb_key2 from asv_commandbutton within acv_key_function
integer x = 304
integer y = 57
integer height = 132
integer taborder = 10
integer textsize = -11
string facename = "Yu Gothic UI Semilight"
string text = "Excel出力"
end type

event clicked;parent.event button_clicked( st_key2.text )
end event

event getfocus;//
end event

event fnkeyevent;return 0
end event

type st_key2 from asv_statictext within acv_key_function
integer x = 304
integer width = 104
integer height = 60
fontcharset fontcharset = ansi!
string facename = "Yu Gothic UI Semilight"
string text = "F2"
end type

event getfocus;//
end event

type cb_key1 from asv_commandbutton within acv_key_function
integer y = 57
integer height = 132
integer taborder = 10
integer textsize = -11
string facename = "Yu Gothic UI Semilight"
string text = "Excel出力"
end type

event clicked;parent.event button_clicked( st_key1.text )

end event

event getfocus;//
end event

event fnkeyevent;return 0
end event

type st_key1 from asv_statictext within acv_key_function
integer width = 104
integer height = 60
fontcharset fontcharset = ansi!
string facename = "Yu Gothic UI Semilight"
string text = "F1"
end type

event getfocus;//
end event

