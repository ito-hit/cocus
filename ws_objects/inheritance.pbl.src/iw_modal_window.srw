$PBExportHeader$iw_modal_window.srw
$PBExportComments$aw_windowから継承したモーダルウインドウの先祖オブジェクト
forward
global type iw_modal_window from aw_base_window
end type
type st_tail from ivo_statictext within iw_modal_window
end type
type cb_ok from sv_cb_update within iw_modal_window
end type
type cb_cancel from sv_cb_close within iw_modal_window
end type
type dw_list from ivo_datawindow within iw_modal_window
end type
type cb_retrieve from sv_cb_retrieve within iw_modal_window
end type
type lstr_close from structure within iw_modal_window
end type
end forward

type lstr_close from structure
	boolean		result
end type

global type iw_modal_window from aw_base_window
integer width = 3648
integer height = 900
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
integer animationtime = 100
boolean fnkey_enabled = false
st_tail st_tail
cb_ok cb_ok
cb_cancel cb_cancel
dw_list dw_list
cb_retrieve cb_retrieve
end type
global iw_modal_window iw_modal_window

type variables
protected:
	// 起動時にretrieve実行(有効/無効)
	boolean	immediate_retrieve	= true

	// DWサイズ（DWサイズでウインドウサイズを決める）
	integer	dw_height,dw_width

private:
	boolean			cancel		= true

	// イベント用パラメーター
	unsignedlong	i_wparam	= 0
	long			i_lparam	= 0

	// 自動配置除外コントロールリスト
	string			exclude_control[]	= { "uo_signal", "st_date", "st_user_mei", "uo_test_mode", "p_size_adjust", "st_title", "st_title_upper", "st_tail", "st_upper", "cb_ok", "cb_cancel", "dw_list", "cv_loading", "cv_key_function_set" }


end variables

forward prototypes
private function integer get_dw_position ()
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
end prototypes

private function integer get_dw_position ();animation				l_anmtin
checkbox				l_chkbox
commandbutton			l_cmdbtn
datawindow				l_datwin
datepicker				l_dtpick
dropdownlistbox			l_dpdnlst
dropdownpicturelistbox	l_dpdnpiclst
editmask				l_edtmsk
graph					l_graph
groupbox				l_grpbox
hprogressbar			l_hprgrs
hscrollbar				l_hscrl
htrackbar				l_htrck
inkedit					l_inkedt
inkpicture				l_inkpic
listbox					l_lstbox
listview				l_lstview
monthcalendar			l_monthcal
multilineedit			l_mltilinedt
picture					l_pic
picturebutton			l_picbtn
picturehyperlink		l_pichyplnk
picturelistbox			l_piclst
radiobutton				l_rdiobtn
richtextedit			l_rtxtedt
singlelineedit			l_sgllineedt
statichyperlink			l_stchyplnk
statictext				l_stctxt
tab						l_tab
treeview				l_trview
userobject				l_usrobj
vprogressbar			l_vprgrs
vscrollbar				l_vscrl
vtrackbar				l_vtrck


integer	l_row, l_row2
integer	l_upper_pos, l_lower_pos

boolean	l_hit
graphicobject	l_obj

l_upper_pos	= st_upper.y + st_upper.height
l_lower_pos	= l_upper_pos

for l_row = 1 to upperbound( this.control )
	l_hit	= false

	for l_row2 = 1 to upperbound( exclude_control )
 		if this.control[l_row].classname() = exclude_control[l_row2] then
			l_hit	= true
			exit
		end if
	next
	
	if not l_hit then
		choose case this.control[l_row].typeof()
			case animation!
				l_anmtin		= this.control[l_row]
				
				if l_anmtin.y + l_anmtin.height > l_lower_pos then
					l_lower_pos	= l_anmtin.y + l_anmtin.height
				end if
			case checkbox!
				l_chkbox		= this.control[l_row]

				if l_chkbox.y + l_chkbox.height > l_lower_pos then
					l_lower_pos	= l_chkbox.y + l_chkbox.height
				end if
			case commandbutton!
				l_cmdbtn		= this.control[l_row]

				if l_cmdbtn.y + l_cmdbtn.height > l_lower_pos then
					l_lower_pos	= l_cmdbtn.y + l_cmdbtn.height
				end if
			case datawindow!
				l_datwin		= this.control[l_row]

				if l_datwin.y + l_datwin.height > l_lower_pos then
					l_lower_pos	= l_datwin.y + l_datwin.height
				end if
			case datepicker!
				l_dtpick		= this.control[l_row]

				if l_dtpick.y + l_dtpick.height > l_lower_pos then
					l_lower_pos	= l_dtpick.y + l_dtpick.height
				end if
			case dropdownlistbox!
				l_dpdnlst		= this.control[l_row]

				if l_dpdnlst.y + l_dpdnlst.height > l_lower_pos then
					l_lower_pos	= l_dpdnlst.y + l_dpdnlst.height
				end if
			case dropdownpicturelistbox!
				l_dpdnpiclst	= this.control[l_row]

				if l_dpdnpiclst.y + l_dpdnpiclst.height > l_lower_pos then
					l_lower_pos	= l_dpdnpiclst.y + l_dpdnpiclst.height
				end if
			case editmask!
				l_edtmsk		= this.control[l_row]

				if l_edtmsk.y + l_edtmsk.height > l_lower_pos then
					l_lower_pos	= l_edtmsk.y + l_edtmsk.height
				end if
			case graph!
				l_graph			= this.control[l_row]

				if l_graph.y + l_graph.height > l_lower_pos then
					l_lower_pos	= l_graph.y + l_graph.height
				end if
			case groupbox!
				l_grpbox		= this.control[l_row]

				if l_grpbox.y + l_grpbox.height > l_lower_pos then
					l_lower_pos	= l_grpbox.y + l_grpbox.height
				end if
			case hprogressbar!
				l_hprgrs		= this.control[l_row]

				if l_hprgrs.y + l_hprgrs.height > l_lower_pos then
					l_lower_pos	= l_hprgrs.y + l_hprgrs.height
				end if
			case hscrollbar!
				l_hscrl			= this.control[l_row]

				if l_hscrl.y + l_hscrl.height > l_lower_pos then
					l_lower_pos	= l_hscrl.y + l_hscrl.height
				end if
			case htrackbar!
				l_htrck			= this.control[l_row]

				if l_htrck.y + l_htrck.height > l_lower_pos then
					l_lower_pos	= l_htrck.y + l_htrck.height
				end if
			case inkedit!
				l_inkedt		= this.control[l_row]

				if l_inkedt.y + l_inkedt.height > l_lower_pos then
					l_lower_pos	= l_inkedt.y + l_inkedt.height
				end if
			case inkpicture!
				l_inkpic		= this.control[l_row]

				if l_inkpic.y + l_inkpic.height > l_lower_pos then
					l_lower_pos	= l_inkpic.y + l_inkpic.height
				end if
			case listbox!
				l_lstbox		= this.control[l_row]

				if l_lstbox.y + l_lstbox.height > l_lower_pos then
					l_lower_pos	= l_lstbox.y + l_lstbox.height
				end if
			case listview!
				l_lstview		= this.control[l_row]

				if l_lstview.y + l_lstview.height > l_lower_pos then
					l_lower_pos	= l_lstview.y + l_lstview.height
				end if
			case monthcalendar!
				l_monthcal		= this.control[l_row]

				if l_monthcal.y + l_monthcal.height > l_lower_pos then
					l_lower_pos	= l_monthcal.y + l_monthcal.height
				end if
			case multilineedit!
				l_mltilinedt	= this.control[l_row]

				if l_mltilinedt.y + l_mltilinedt.height > l_lower_pos then
					l_lower_pos	= l_mltilinedt.y + l_mltilinedt.height
				end if
			case picture!
				l_pic			= this.control[l_row]

				if l_pic.y + l_pic.height > l_lower_pos then
					l_lower_pos	= l_pic.y + l_pic.height
				end if
			case picturebutton!
				l_picbtn		= this.control[l_row]

				if l_picbtn.y + l_picbtn.height > l_lower_pos then
					l_lower_pos	= l_picbtn.y + l_picbtn.height
				end if
			case picturehyperlink!
				l_pichyplnk		= this.control[l_row]

				if l_pichyplnk.y + l_pichyplnk.height > l_lower_pos then
					l_lower_pos	= l_pichyplnk.y + l_pichyplnk.height
				end if
			case picturelistbox!
				l_piclst		= this.control[l_row]

				if l_piclst.y + l_piclst.height > l_lower_pos then
					l_lower_pos	= l_piclst.y + l_piclst.height
				end if
			case radiobutton!
				l_rdiobtn		= this.control[l_row]

				if l_rdiobtn.y + l_rdiobtn.height > l_lower_pos then
					l_lower_pos	= l_rdiobtn.y + l_rdiobtn.height
				end if
			case richtextedit!
				l_rtxtedt		= this.control[l_row]

				if l_rtxtedt.y + l_rtxtedt.height > l_lower_pos then
					l_lower_pos	= l_rtxtedt.y + l_rtxtedt.height
				end if
			case singlelineedit!
				l_sgllineedt	= this.control[l_row]

				if l_sgllineedt.y + l_sgllineedt.height > l_lower_pos then
					l_lower_pos	= l_sgllineedt.y + l_sgllineedt.height
				end if
			case statichyperlink!
				l_stchyplnk		= this.control[l_row]

				if l_stchyplnk.y + l_stchyplnk.height > l_lower_pos then
					l_lower_pos	= l_stchyplnk.y + l_stchyplnk.height
				end if
			case statictext!
				l_stctxt		= this.control[l_row]

				if l_stctxt.y + l_stctxt.height > l_lower_pos then
					l_lower_pos	= l_stctxt.y + l_stctxt.height
				end if
			case tab!
				l_tab			= this.control[l_row]

				if l_tab.y + l_tab.height > l_lower_pos then
					l_lower_pos	= l_tab.y + l_tab.height
				end if
			case treeview!
				l_trview		= this.control[l_row]

				if l_trview.y + l_trview.height > l_lower_pos then
					l_lower_pos	= l_trview.y + l_trview.height
				end if
			case userobject!
				l_usrobj		= this.control[l_row]

				if l_usrobj.y + l_usrobj.height > l_lower_pos then
					l_lower_pos	= l_usrobj.y + l_usrobj.height
				end if
			case vprogressbar!
				l_vprgrs		= this.control[l_row]

				if l_vprgrs.y + l_vprgrs.height > l_lower_pos then
					l_lower_pos	= l_vprgrs.y + l_vprgrs.height
				end if
			case vscrollbar!
				l_vscrl			= this.control[l_row]

				if l_vscrl.y + l_vscrl.height > l_lower_pos then
					l_lower_pos	= l_vscrl.y + l_vscrl.height
				end if
			case vtrackbar!
				l_vtrck			= this.control[l_row]

				if l_vtrck.y + l_vtrck.height > l_lower_pos then
					l_lower_pos	= l_vtrck.y + l_vtrck.height
				end if
		end choose
	end if
next



if l_upper_pos > l_lower_pos then
	return l_upper_pos
else
	return l_lower_pos
end if

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

on iw_modal_window.create
int iCurrent
call super::create
this.st_tail=create st_tail
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_list=create dw_list
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tail
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.cb_retrieve
end on

on iw_modal_window.destroy
call super::destroy
destroy(this.st_tail)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_list)
destroy(this.cb_retrieve)
end on

event open;call super::open;object_type	= "modal_window"

// 起動時にリトリーブする
if immediate_retrieve then
	if not of_evt_retrieve( i_wparam, i_lparam ) then
		return -1
	end if
end if

dw_list.setfocus()
end event

event resize;call super::resize;// データウインドウサイズにウインドウサイズを調整する
// get_dw_positionは上段部で一番下方にあるオブジェクトを特定してDWの位置を決める
//dw_list.y	= st_upper.y + st_upper.height + code.MGN_TATE
dw_list.y	= get_dw_position() + code.MGN_TATE
dw_list.x	= code.MGN_YOKO

dw_list.width	= dw_width
dw_list.height	= dw_height

this.width	= dw_list.x + dw_list.width + code.MGN_YOKO + 20

// cb_retrieve
cb_retrieve.x	= dw_list.x + dw_list.width - cb_retrieve.width


// st_upper
st_upper.width	= this.width - 20

// window( ログイン画面は中身でWindowsサイズを決めるため再設定 )
st_title_upper.width	= st_upper.width * 0.8
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title.width			= st_title_upper.width * 0.9
st_title.x				= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x

// st_tail
st_tail.width	= st_upper.width
st_tail.y		= dw_list.y + dw_list.height + code.MGN_TATE

// cb_cancel
cb_cancel.width		= 340
cb_cancel.y			= st_tail.height / 2 - cb_cancel.height / 2 + st_tail.y
cb_cancel.x			= st_tail.width - cb_cancel.width - code.MGN_YOKO

// cb_ok
cb_ok.width		= 340
cb_ok.y			= st_tail.height / 2 - cb_ok.height / 2 + st_tail.y
cb_ok.x			= cb_cancel.x - cb_ok.width - code.MGN_GROUP_YOKO


this.height		= st_tail.y + st_tail.height + 100	// 100はおまじない

//setredraw( true )

end event

event update_check;call super::update_check;if dw_list.getrow() > 0 then
	return 0
else
	msg.of_error( "行が選択されていません。" )
	return -1
end if
end event

event update_event;call super::update_event;cancel	= false
end event

event close;call super::close;if cancel then
	closewithreturn( this, -1 )
end if
end event

event key_f10;call super::key_f10;close( this )

return 0
end event

event openquery;call super::openquery;
// レスポンスウインドウなので
changemenu( am_menu_keytrg )

// 上部の入力フォームの位置が確定した後じゃないとほかの位置やサイズが決まらないので強制呼び出し
resize( this.width, this.height )

end event

type uo_signal from aw_base_window`uo_signal within iw_modal_window
integer x = 2668
integer y = 18
end type

type st_date from aw_base_window`st_date within iw_modal_window
boolean visible = false
integer x = 3244
integer y = 21
end type

type st_user_mei from aw_base_window`st_user_mei within iw_modal_window
boolean visible = false
end type

type uo_test_mode from aw_base_window`uo_test_mode within iw_modal_window
boolean visible = true
integer x = 2284
integer y = 18
end type

type p_size_adjust from aw_base_window`p_size_adjust within iw_modal_window
integer x = 552
end type

type st_title from aw_base_window`st_title within iw_modal_window
integer x = 1316
integer y = 25
end type

type st_title_upper from aw_base_window`st_title_upper within iw_modal_window
integer x = 656
integer y = 14
end type

type st_upper from aw_base_window`st_upper within iw_modal_window
integer width = 3636
end type

type st_tail from ivo_statictext within iw_modal_window
integer y = 700
integer width = 1732
integer height = 128
boolean bringtotop = true
string text = ""
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_ok from sv_cb_update within iw_modal_window
integer x = 1012
integer y = 722
integer taborder = 30
boolean bringtotop = true
string text = "O K"
boolean confirm_enabled = false
end type

type cb_cancel from sv_cb_close within iw_modal_window
integer x = 1360
integer y = 722
integer taborder = 40
boolean bringtotop = true
string text = "キャンセル"
boolean confirm_enabled = false
end type

type dw_list from ivo_datawindow within iw_modal_window
integer x = 92
integer y = 228
integer taborder = 20
boolean bringtotop = true
boolean row_focus_ind = true
end type

event key_enter;call super::key_enter;cb_ok.event clicked( )

return 0
end event

event constructor;call super::constructor;if dw_height = 0 then
	dw_height	= this.height
end if

if dw_width = 0 then
	dw_width	= this.width
end if
end event

type cb_retrieve from sv_cb_retrieve within iw_modal_window
integer x = 1172
integer y = 149
integer taborder = 10
boolean bringtotop = true
end type

