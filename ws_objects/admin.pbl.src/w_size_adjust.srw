$PBExportHeader$w_size_adjust.srw
$PBExportComments$コントロールの位置やサイズを測定／調整
forward
global type w_size_adjust from aw_window
end type
type pb_width_narrow from asv_picturebutton within w_size_adjust
end type
type pb_width_wide from asv_picturebutton within w_size_adjust
end type
type p_drag_size_adjust from uo_p_base within w_size_adjust
end type
type cb_close from asv_commandbutton within w_size_adjust
end type
type pb_height_narrow from asv_picturebutton within w_size_adjust
end type
type pb_height_wide from asv_picturebutton within w_size_adjust
end type
type pb_right from asv_picturebutton within w_size_adjust
end type
type pb_left from asv_picturebutton within w_size_adjust
end type
type pb_down from asv_picturebutton within w_size_adjust
end type
type pb_up from asv_picturebutton within w_size_adjust
end type
type st_12 from asv_statictext within w_size_adjust
end type
type st_11 from asv_statictext within w_size_adjust
end type
type st_original_x from asv_statictext within w_size_adjust
end type
type st_original_y from asv_statictext within w_size_adjust
end type
type st_original_width from asv_statictext within w_size_adjust
end type
type st_original_height from asv_statictext within w_size_adjust
end type
type sle_height from asv_singlelineedit within w_size_adjust
end type
type sle_width from asv_singlelineedit within w_size_adjust
end type
type sle_y from asv_singlelineedit within w_size_adjust
end type
type sle_x from asv_singlelineedit within w_size_adjust
end type
type st_control from asv_statictext within w_size_adjust
end type
type st_5 from asv_statictext within w_size_adjust
end type
type st_4 from asv_statictext within w_size_adjust
end type
type st_3 from asv_statictext within w_size_adjust
end type
type st_2 from asv_statictext within w_size_adjust
end type
type st_1 from asv_statictext within w_size_adjust
end type
type gb_control from asv_groupbox within w_size_adjust
end type
end forward

global type w_size_adjust from aw_window
integer width = 1492
integer height = 1031
string title = "コントロール測定／調整ツール"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
string icon = "image\maintenance.ico"
event callback ( string p_control,  any p_object )
pb_width_narrow pb_width_narrow
pb_width_wide pb_width_wide
p_drag_size_adjust p_drag_size_adjust
cb_close cb_close
pb_height_narrow pb_height_narrow
pb_height_wide pb_height_wide
pb_right pb_right
pb_left pb_left
pb_down pb_down
pb_up pb_up
st_12 st_12
st_11 st_11
st_original_x st_original_x
st_original_y st_original_y
st_original_width st_original_width
st_original_height st_original_height
sle_height sle_height
sle_width sle_width
sle_y sle_y
sle_x sle_x
st_control st_control
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_control gb_control
end type
global w_size_adjust w_size_adjust

type variables
private string			i_control

animation				i_animation
checkbox				i_checkbox
commandbutton			i_commandbutton
datawindow				i_datawindow
datepicker				i_datepicker
dropdownlistbox			i_dropdownlistbox
dropdownpicturelistbox	i_dropdownpicturelistbox
editmask				i_editmask
graph					i_graph
groupbox				i_groupbox
hprogressbar			i_hprogressbar
hscrollbar				i_hscrollbar
htrackbar				i_htrackbar
inkedit					i_inkedit
inkpicture				i_inkpicture
listbox					i_listbox
listview				i_listview
monthcalendar			i_monthcalendar
multilineedit			i_multilineedit
picture					i_picture
picturebutton			i_picturebutton
picturehyperlink		i_picturehyperlink
picturelistbox			i_picturelistbox
radiobutton				i_radiobutton
richtextedit			i_richtextedit
singlelineedit			i_singlelineedit
statichyperlink			i_statichyperlink
statictext				i_statictext
tab						i_tab
treeview				i_treeview
userobject				i_userobject
vprogressbar			i_vprogressbar
vscrollbar				i_vscrollbar
vtrackbar				i_vtrackbar
window					i_window

end variables

forward prototypes
public subroutine of_result ()
public subroutine of_up (singlelineedit p_sle)
public subroutine of_down (singlelineedit p_sle)
end prototypes

event callback(string p_control, any p_object);i_control	= p_control

// msg.of_info( p_control )

choose case p_control
	case "animation"
		i_animation					= p_object

		st_control.text				= i_animation.classname()
		st_original_x.text			= string( i_animation.x )
		sle_x.text					= string( i_animation.x )
		st_original_y.text			= string( i_animation.y )
		sle_y.text					= string( i_animation.y )
		st_original_width.text		= string( i_animation.width )
		sle_width.text				= string( i_animation.width )
		st_original_height.text		= string( i_animation.height )
		sle_height.text				= string( i_animation.height )
	case "checkbox"
		i_checkbox					= p_object

		st_control.text				= i_checkbox.classname()
		st_original_x.text			= string( i_checkbox.x )
		sle_x.text					= string( i_checkbox.x )
		st_original_y.text			= string( i_checkbox.y )
		sle_y.text					= string( i_checkbox.y )
		st_original_width.text		= string( i_checkbox.width )
		sle_width.text				= string( i_checkbox.width )
		st_original_height.text		= string( i_checkbox.height )
		sle_height.text				= string( i_checkbox.height )
	case "commandbutton"
		i_commandbutton				= p_object

		st_control.text				= i_commandbutton.classname()
		st_original_x.text			= string( i_commandbutton.x )
		sle_x.text					= string( i_commandbutton.x )
		st_original_y.text			= string( i_commandbutton.y )
		sle_y.text					= string( i_commandbutton.y )
		st_original_width.text		= string( i_commandbutton.width )
		sle_width.text				= string( i_commandbutton.width )
		st_original_height.text		= string( i_commandbutton.height )
		sle_height.text				= string( i_commandbutton.height )
	case "datawindow"
		i_datawindow				= p_object

		st_control.text				= i_datawindow.classname()
		st_original_x.text			= string( i_datawindow.x )
		sle_x.text					= string( i_datawindow.x )
		st_original_y.text			= string( i_datawindow.y )
		sle_y.text					= string( i_datawindow.y )
		st_original_width.text		= string( i_datawindow.width )
		sle_width.text				= string( i_datawindow.width )
		st_original_height.text		= string( i_datawindow.height )
		sle_height.text				= string( i_datawindow.height )
	case "datepicker"
		i_datepicker				= p_object

		st_control.text				= i_datepicker.classname()
		st_original_x.text			= string( i_datepicker.x )
		sle_x.text					= string( i_datepicker.x )
		st_original_y.text			= string( i_datepicker.y )
		sle_y.text					= string( i_datepicker.y )
		st_original_width.text		= string( i_datepicker.width )
		sle_width.text				= string( i_datepicker.width )
		st_original_height.text		= string( i_datepicker.height )
		sle_height.text				= string( i_datepicker.height )
	case "dropdownlistbox"
		i_dropdownlistbox			= p_object

		st_control.text				= i_dropdownlistbox.classname()
		st_original_x.text			= string( i_dropdownlistbox.x )
		sle_x.text					= string( i_dropdownlistbox.x )
		st_original_y.text			= string( i_dropdownlistbox.y )
		sle_y.text					= string( i_dropdownlistbox.y )
		st_original_width.text		= string( i_dropdownlistbox.width )
		sle_width.text				= string( i_dropdownlistbox.width )
		st_original_height.text		= string( i_dropdownlistbox.height )
		sle_height.text				= string( i_dropdownlistbox.height )
	case "dropdownpicturelistbox"
		i_dropdownpicturelistbox	= p_object

		st_control.text				= i_dropdownpicturelistbox.classname()
		st_original_x.text			= string( i_dropdownpicturelistbox.x )
		sle_x.text					= string( i_dropdownpicturelistbox.x )
		st_original_y.text			= string( i_dropdownpicturelistbox.y )
		sle_y.text					= string( i_dropdownpicturelistbox.y )
		st_original_width.text		= string( i_dropdownpicturelistbox.width )
		sle_width.text				= string( i_dropdownpicturelistbox.width )
		st_original_height.text		= string( i_dropdownpicturelistbox.height )
		sle_height.text				= string( i_dropdownpicturelistbox.height )
	case "editmask"
		i_editmask					= p_object

		st_control.text				= i_editmask.classname()
		st_original_x.text			= string( i_editmask.x )
		sle_x.text					= string( i_editmask.x )
		st_original_y.text			= string( i_editmask.y )
		sle_y.text					= string( i_editmask.y )
		st_original_width.text		= string( i_editmask.width )
		sle_width.text				= string( i_editmask.width )
		st_original_height.text		= string( i_editmask.height )
		sle_height.text				= string( i_editmask.height )
	case "graph"
		i_graph						= p_object

		st_control.text				= i_graph.classname()
		st_original_x.text			= string( i_graph.x )
		sle_x.text					= string( i_graph.x )
		st_original_y.text			= string( i_graph.y )
		sle_y.text					= string( i_graph.y )
		st_original_width.text		= string( i_graph.width )
		sle_width.text				= string( i_graph.width )
		st_original_height.text		= string( i_graph.height )
		sle_height.text				= string( i_graph.height )
	case "groupbox"
		i_groupbox					= p_object

		st_control.text				= i_groupbox.classname()
		st_original_x.text			= string( i_groupbox.x )
		sle_x.text					= string( i_groupbox.x )
		st_original_y.text			= string( i_groupbox.y )
		sle_y.text					= string( i_groupbox.y )
		st_original_width.text		= string( i_groupbox.width )
		sle_width.text				= string( i_groupbox.width )
		st_original_height.text		= string( i_groupbox.height )
		sle_height.text				= string( i_groupbox.height )
	case "hprogressbar"
		i_hprogressbar				= p_object

		st_control.text				= i_hprogressbar.classname()
		st_original_x.text			= string( i_hprogressbar.x )
		sle_x.text					= string( i_hprogressbar.x )
		st_original_y.text			= string( i_hprogressbar.y )
		sle_y.text					= string( i_hprogressbar.y )
		st_original_width.text		= string( i_hprogressbar.width )
		sle_width.text				= string( i_hprogressbar.width )
		st_original_height.text		= string( i_hprogressbar.height )
		sle_height.text				= string( i_hprogressbar.height )
	case "hscrollbar"
		i_hscrollbar				= p_object

		st_control.text				= i_hscrollbar.classname()
		st_original_x.text			= string( i_hscrollbar.x )
		sle_x.text					= string( i_hscrollbar.x )
		st_original_y.text			= string( i_hscrollbar.y )
		sle_y.text					= string( i_hscrollbar.y )
		st_original_width.text		= string( i_hscrollbar.width )
		sle_width.text				= string( i_hscrollbar.width )
		st_original_height.text		= string( i_hscrollbar.height )
		sle_height.text				= string( i_hscrollbar.height )
	case "htrackbar"
		i_htrackbar					= p_object

		st_control.text				= i_htrackbar.classname()
		st_original_x.text			= string( i_htrackbar.x )
		sle_x.text					= string( i_htrackbar.x )
		st_original_y.text			= string( i_htrackbar.y )
		sle_y.text					= string( i_htrackbar.y )
		st_original_width.text		= string( i_htrackbar.width )
		sle_width.text				= string( i_htrackbar.width )
		st_original_height.text		= string( i_htrackbar.height )
		sle_height.text				= string( i_htrackbar.height )
	case "inkedit"
		i_inkedit					= p_object

		st_control.text				= i_inkedit.classname()
		st_original_x.text			= string( i_inkedit.x )
		sle_x.text					= string( i_inkedit.x )
		st_original_y.text			= string( i_inkedit.y )
		sle_y.text					= string( i_inkedit.y )
		st_original_width.text		= string( i_inkedit.width )
		sle_width.text				= string( i_inkedit.width )
		st_original_height.text		= string( i_inkedit.height )
		sle_height.text				= string( i_inkedit.height )
	case "inkpicture"
		i_inkpicture				= p_object

		st_control.text				= i_inkpicture.classname()
		st_original_x.text			= string( i_inkpicture.x )
		sle_x.text					= string( i_inkpicture.x )
		st_original_y.text			= string( i_inkpicture.y )
		sle_y.text					= string( i_inkpicture.y )
		st_original_width.text		= string( i_inkpicture.width )
		sle_width.text				= string( i_inkpicture.width )
		st_original_height.text		= string( i_inkpicture.height )
		sle_height.text				= string( i_inkpicture.height )
	case "listbox"
		i_listbox					= p_object

		st_control.text				= i_listbox.classname()
		st_original_x.text			= string( i_listbox.x )
		sle_x.text					= string( i_listbox.x )
		st_original_y.text			= string( i_listbox.y )
		sle_y.text					= string( i_listbox.y )
		st_original_width.text		= string( i_listbox.width )
		sle_width.text				= string( i_listbox.width )
		st_original_height.text		= string( i_listbox.height )
		sle_height.text				= string( i_listbox.height )
	case "listview"
		i_listview					= p_object

		st_control.text				= i_listview.classname()
		st_original_x.text			= string( i_listview.x )
		sle_x.text					= string( i_listview.x )
		st_original_y.text			= string( i_listview.y )
		sle_y.text					= string( i_listview.y )
		st_original_width.text		= string( i_listview.width )
		sle_width.text				= string( i_listview.width )
		st_original_height.text		= string( i_listview.height )
		sle_height.text				= string( i_listview.height )
	case "monthcalendar"
		i_monthcalendar				= p_object

		st_control.text				= i_monthcalendar.classname()
		st_original_x.text			= string( i_monthcalendar.x )
		sle_x.text					= string( i_monthcalendar.x )
		st_original_y.text			= string( i_monthcalendar.y )
		sle_y.text					= string( i_monthcalendar.y )
		st_original_width.text		= string( i_monthcalendar.width )
		sle_width.text				= string( i_monthcalendar.width )
		st_original_height.text		= string( i_monthcalendar.height )
		sle_height.text				= string( i_monthcalendar.height )
	case "multilineedit"
		i_multilineedit				= p_object

		st_control.text				= i_multilineedit.classname()
		st_original_x.text			= string( i_multilineedit.x )
		sle_x.text					= string( i_multilineedit.x )
		st_original_y.text			= string( i_multilineedit.y )
		sle_y.text					= string( i_multilineedit.y )
		st_original_width.text		= string( i_multilineedit.width )
		sle_width.text				= string( i_multilineedit.width )
		st_original_height.text		= string( i_multilineedit.height )
		sle_height.text				= string( i_multilineedit.height )
	case "picture"
		i_picture					= p_object

		st_control.text				= i_picture.classname()
		st_original_x.text			= string( i_picture.x )
		sle_x.text					= string( i_picture.x )
		st_original_y.text			= string( i_picture.y )
		sle_y.text					= string( i_picture.y )
		st_original_width.text		= string( i_picture.width )
		sle_width.text				= string( i_picture.width )
		st_original_height.text		= string( i_picture.height )
		sle_height.text				= string( i_picture.height )
	case "picturebutton"
		i_picturebutton				= p_object

		st_control.text				= i_picturebutton.classname()
		st_original_x.text			= string( i_picturebutton.x )
		sle_x.text					= string( i_picturebutton.x )
		st_original_y.text			= string( i_picturebutton.y )
		sle_y.text					= string( i_picturebutton.y )
		st_original_width.text		= string( i_picturebutton.width )
		sle_width.text				= string( i_picturebutton.width )
		st_original_height.text		= string( i_picturebutton.height )
		sle_height.text				= string( i_picturebutton.height )
	case "picturehyperlink"
		i_picturehyperlink			= p_object

		st_control.text				= i_picturehyperlink.classname()
		st_original_x.text			= string( i_picturehyperlink.x )
		sle_x.text					= string( i_picturehyperlink.x )
		st_original_y.text			= string( i_picturehyperlink.y )
		sle_y.text					= string( i_picturehyperlink.y )
		st_original_width.text		= string( i_picturehyperlink.width )
		sle_width.text				= string( i_picturehyperlink.width )
		st_original_height.text		= string( i_picturehyperlink.height )
		sle_height.text				= string( i_picturehyperlink.height )
	case "picturelistbox"
		i_picturelistbox			= p_object

		st_control.text				= i_picturelistbox.classname()
		st_original_x.text			= string( i_picturelistbox.x )
		sle_x.text					= string( i_picturelistbox.x )
		st_original_y.text			= string( i_picturelistbox.y )
		sle_y.text					= string( i_picturelistbox.y )
		st_original_width.text		= string( i_picturelistbox.width )
		sle_width.text				= string( i_picturelistbox.width )
		st_original_height.text		= string( i_picturelistbox.height )
		sle_height.text				= string( i_picturelistbox.height )
	case "radiobutton"
		i_radiobutton				= p_object

		st_control.text				= i_radiobutton.classname()
		st_original_x.text			= string( i_radiobutton.x )
		sle_x.text					= string( i_radiobutton.x )
		st_original_y.text			= string( i_radiobutton.y )
		sle_y.text					= string( i_radiobutton.y )
		st_original_width.text		= string( i_radiobutton.width )
		sle_width.text				= string( i_radiobutton.width )
		st_original_height.text		= string( i_radiobutton.height )
		sle_height.text				= string( i_radiobutton.height )
	case "richtextedit"
		i_richtextedit				= p_object

		st_control.text				= i_richtextedit.classname()
		st_original_x.text			= string( i_richtextedit.x )
		sle_x.text					= string( i_richtextedit.x )
		st_original_y.text			= string( i_richtextedit.y )
		sle_y.text					= string( i_richtextedit.y )
		st_original_width.text		= string( i_richtextedit.width )
		sle_width.text				= string( i_richtextedit.width )
		st_original_height.text		= string( i_richtextedit.height )
		sle_height.text				= string( i_richtextedit.height )
	case "singlelineedit"
		i_singlelineedit			= p_object

		st_control.text				= i_singlelineedit.classname()
		st_original_x.text			= string( i_singlelineedit.x )
		sle_x.text					= string( i_singlelineedit.x )
		st_original_y.text			= string( i_singlelineedit.y )
		sle_y.text					= string( i_singlelineedit.y )
		st_original_width.text		= string( i_singlelineedit.width )
		sle_width.text				= string( i_singlelineedit.width )
		st_original_height.text		= string( i_singlelineedit.height )
		sle_height.text				= string( i_singlelineedit.height )
	case "statichyperlink"
		i_statichyperlink			= p_object

		st_control.text				= i_statichyperlink.classname()
		st_original_x.text			= string( i_statichyperlink.x )
		sle_x.text					= string( i_statichyperlink.x )
		st_original_y.text			= string( i_statichyperlink.y )
		sle_y.text					= string( i_statichyperlink.y )
		st_original_width.text		= string( i_statichyperlink.width )
		sle_width.text				= string( i_statichyperlink.width )
		st_original_height.text		= string( i_statichyperlink.height )
		sle_height.text				= string( i_statichyperlink.height )
	case "statictext"
		i_statictext				= p_object

		st_control.text				= i_statictext.classname()
		st_original_x.text			= string( i_statictext.x )
		sle_x.text					= string( i_statictext.x )
		st_original_y.text			= string( i_statictext.y )
		sle_y.text					= string( i_statictext.y )
		st_original_width.text		= string( i_statictext.width )
		sle_width.text				= string( i_statictext.width )
		st_original_height.text		= string( i_statictext.height )
		sle_height.text				= string( i_statictext.height )
	case "tab"
		i_tab						= p_object

		st_control.text				= i_tab.classname()
		st_original_x.text			= string( i_tab.x )
		sle_x.text					= string( i_tab.x )
		st_original_y.text			= string( i_tab.y )
		sle_y.text					= string( i_tab.y )
		st_original_width.text		= string( i_tab.width )
		sle_width.text				= string( i_tab.width )
		st_original_height.text		= string( i_tab.height )
		sle_height.text				= string( i_tab.height )
	case "treeview"
		i_treeview					= p_object

		st_control.text				= i_treeview.classname()
		st_original_x.text			= string( i_treeview.x )
		sle_x.text					= string( i_treeview.x )
		st_original_y.text			= string( i_treeview.y )
		sle_y.text					= string( i_treeview.y )
		st_original_width.text		= string( i_treeview.width )
		sle_width.text				= string( i_treeview.width )
		st_original_height.text		= string( i_treeview.height )
		sle_height.text				= string( i_treeview.height )
	case "userobject"
		i_userobject				= p_object

		st_control.text				= i_userobject.classname()
		st_original_x.text			= string( i_userobject.x )
		sle_x.text					= string( i_userobject.x )
		st_original_y.text			= string( i_userobject.y )
		sle_y.text					= string( i_userobject.y )
		st_original_width.text		= string( i_userobject.width )
		sle_width.text				= string( i_userobject.width )
		st_original_height.text		= string( i_userobject.height )
		sle_height.text				= string( i_userobject.height )
	case "vprogressbar"
		i_vprogressbar				= p_object

		st_control.text				= i_vprogressbar.classname()
		st_original_x.text			= string( i_vprogressbar.x )
		sle_x.text					= string( i_vprogressbar.x )
		st_original_y.text			= string( i_vprogressbar.y )
		sle_y.text					= string( i_vprogressbar.y )
		st_original_width.text		= string( i_vprogressbar.width )
		sle_width.text				= string( i_vprogressbar.width )
		st_original_height.text		= string( i_vprogressbar.height )
		sle_height.text				= string( i_vprogressbar.height )
	case "vscrollbar"
		i_vscrollbar				= p_object

		st_control.text				= i_vscrollbar.classname()
		st_original_x.text			= string( i_vscrollbar.x )
		sle_x.text					= string( i_vscrollbar.x )
		st_original_y.text			= string( i_vscrollbar.y )
		sle_y.text					= string( i_vscrollbar.y )
		st_original_width.text		= string( i_vscrollbar.width )
		sle_width.text				= string( i_vscrollbar.width )
		st_original_height.text		= string( i_vscrollbar.height )
		sle_height.text				= string( i_vscrollbar.height )
	case "vtrackbar"
		i_vtrackbar					= p_object

		st_control.text				= i_vtrackbar.classname()
		st_original_x.text			= string( i_vtrackbar.x )
		sle_x.text					= string( i_vtrackbar.x )
		st_original_y.text			= string( i_vtrackbar.y )
		sle_y.text					= string( i_vtrackbar.y )
		st_original_width.text		= string( i_vtrackbar.width )
		sle_width.text				= string( i_vtrackbar.width )
		st_original_height.text		= string( i_vtrackbar.height )
		sle_height.text				= string( i_vtrackbar.height )
	case "window"
		i_window					= p_object

		st_control.text				= i_window.classname()
		st_original_x.text			= string( i_window.x )
		sle_x.text					= string( i_window.x )
		st_original_y.text			= string( i_window.y )
		sle_y.text					= string( i_window.y )
		st_original_width.text		= string( i_window.width )
		sle_width.text				= string( i_window.width )
		st_original_height.text		= string( i_window.height )
		sle_height.text				= string( i_window.height )
	case else
end choose

end event

public subroutine of_result ();integer	l_x,l_y,l_width,l_height

l_x			= long( sle_x.text )
l_y			= long( sle_y.text )
l_width		= long( sle_width.text )
l_height	= long( sle_height.text )

choose case i_control
	case "animation"
		i_animation.x					= l_x
		i_animation.y					= l_y
		i_animation.width				= l_width
		i_animation.height				= l_height
	case "checkbox"
		i_checkbox.x					= l_x
		i_checkbox.y					= l_y
		i_checkbox.width				= l_width
		i_checkbox.height				= l_height
	case "commandbutton"
		i_commandbutton.x				= l_x
		i_commandbutton.y				= l_y
		i_commandbutton.width			= l_width
		i_commandbutton.height			= l_height
	case "datawindow"
		i_datawindow.x					= l_x
		i_datawindow.y					= l_y
		i_datawindow.width				= l_width
		i_datawindow.height				= l_height
	case "datepicker"
		i_datepicker.x					= l_x
		i_datepicker.y					= l_y
		i_datepicker.width				= l_width
		i_datepicker.height				= l_height
	case "dropdownlistbox"
		i_dropdownlistbox.x				= l_x
		i_dropdownlistbox.y				= l_y
		i_dropdownlistbox.width			= l_width
		i_dropdownlistbox.height		= l_height
	case "dropdownpicturelistbox"
		i_dropdownpicturelistbox.x		= l_x
		i_dropdownpicturelistbox.y		= l_y
		i_dropdownpicturelistbox.width	= l_width
		i_dropdownpicturelistbox.height	= l_height
	case "editmask"
		i_editmask.x					= l_x
		i_editmask.y					= l_y
		i_editmask.width				= l_width
		i_editmask.height				= l_height
	case "graph"
		i_graph.x						= l_x
		i_graph.y						= l_y
		i_graph.width					= l_width
		i_graph.height					= l_height
	case "groupbox"
		i_groupbox.x					= l_x
		i_groupbox.y					= l_y
		i_groupbox.width				= l_width
		i_groupbox.height				= l_height
	case "hprogressbar"
		i_hprogressbar.x				= l_x
		i_hprogressbar.y				= l_y
		i_hprogressbar.width			= l_width
		i_hprogressbar.height			= l_height
	case "hscrollbar"
		i_hscrollbar.x					= l_x
		i_hscrollbar.y					= l_y
		i_hscrollbar.width				= l_width
		i_hscrollbar.height				= l_height
	case "htrackbar"
		i_htrackbar.x					= l_x
		i_htrackbar.y					= l_y
		i_htrackbar.width				= l_width
		i_htrackbar.height				= l_height
	case "inkedit"
		i_inkedit.x						= l_x
		i_inkedit.y						= l_y
		i_inkedit.width					= l_width
		i_inkedit.height				= l_height
	case "inkpicture"
		i_inkpicture.x					= l_x
		i_inkpicture.y					= l_y
		i_inkpicture.width				= l_width
		i_inkpicture.height				= l_height
	case "listbox"
		i_listbox.x						= l_x
		i_listbox.y						= l_y
		i_listbox.width					= l_width
		i_listbox.height				= l_height
	case "listview"
		i_listview.x					= l_x
		i_listview.y					= l_y
		i_listview.width				= l_width
		i_listview.height				= l_height
	case "monthcalendar"
		i_monthcalendar.x				= l_x
		i_monthcalendar.y				= l_y
		i_monthcalendar.width			= l_width
		i_monthcalendar.height			= l_height
	case "multilineedit"
		i_multilineedit.x				= l_x
		i_multilineedit.y				= l_y
		i_multilineedit.width			= l_width
		i_multilineedit.height			= l_height
	case "picture"
		i_picture.x						= l_x
		i_picture.y						= l_y
		i_picture.width					= l_width
		i_picture.height				= l_height
	case "picturebutton"
		i_picturebutton.x				= l_x
		i_picturebutton.y				= l_y
		i_picturebutton.width			= l_width
		i_picturebutton.height			= l_height
	case "picturehyperlink"
		i_picturehyperlink.x			= l_x
		i_picturehyperlink.y			= l_y
		i_picturehyperlink.width		= l_width
		i_picturehyperlink.height		= l_height
	case "picturelistbox"
		i_picturelistbox.x				= l_x
		i_picturelistbox.y				= l_y
		i_picturelistbox.width			= l_width
		i_picturelistbox.height			= l_height
	case "radiobutton"
		i_radiobutton.x					= l_x
		i_radiobutton.y					= l_y
		i_radiobutton.width				= l_width
		i_radiobutton.height			= l_height
	case "richtextedit"
		i_richtextedit.x				= l_x
		i_richtextedit.y				= l_y
		i_richtextedit.width			= l_width
		i_richtextedit.height			= l_height
	case "singlelineedit"
		i_singlelineedit.x				= l_x
		i_singlelineedit.y				= l_y
		i_singlelineedit.width			= l_width
		i_singlelineedit.height			= l_height
	case "statichyperlink"
		i_statichyperlink.x				= l_x
		i_statichyperlink.y				= l_y
		i_statichyperlink.width			= l_width
		i_statichyperlink.height		= l_height
	case "statictext"
		i_statictext.x					= l_x
		i_statictext.y					= l_y
		i_statictext.width				= l_width
		i_statictext.height				= l_height
	case "tab"
		i_tab.x							= l_x
		i_tab.y							= l_y
		i_tab.width						= l_width
		i_tab.height					= l_height
	case "treeview"
		i_treeview.x					= l_x
		i_treeview.y					= l_y
		i_treeview.width				= l_width
		i_treeview.height				= l_height
	case "userobject"
		i_userobject.x					= l_x
		i_userobject.y					= l_y
		i_userobject.width				= l_width
		i_userobject.height				= l_height
	case "vprogressbar"
		i_vprogressbar.x				= l_x
		i_vprogressbar.y				= l_y
		i_vprogressbar.width			= l_width
		i_vprogressbar.height			= l_height
	case "vscrollbar"
		i_vscrollbar.x					= l_x
		i_vscrollbar.y					= l_y
		i_vscrollbar.width				= l_width
		i_vscrollbar.height				= l_height
	case "vtrackbar"
		i_vtrackbar.x					= l_x
		i_vtrackbar.y					= l_y
		i_vtrackbar.width				= l_width
		i_vtrackbar.height				= l_height
	case "window"
		i_window.x						= l_x
		i_window.y						= l_y
		i_window.width					= l_width
		i_window.height					= l_height
	case else
end choose

end subroutine

public subroutine of_up (singlelineedit p_sle);integer	l_value

if not isnumber( p_sle.text ) then
	return
end if

l_value	= long( p_sle.text )

l_value	= l_value	+ 1

p_sle.text	= string( l_value )

of_result()

end subroutine

public subroutine of_down (singlelineedit p_sle);integer	l_value

if not isnumber( p_sle.text ) then
	return
end if

l_value	= long( p_sle.text )

if l_value > 1 then
	l_value	= l_value	- 1
end if

p_sle.text	= string( l_value )

of_result()

end subroutine

on w_size_adjust.create
int iCurrent
call super::create
this.pb_width_narrow=create pb_width_narrow
this.pb_width_wide=create pb_width_wide
this.p_drag_size_adjust=create p_drag_size_adjust
this.cb_close=create cb_close
this.pb_height_narrow=create pb_height_narrow
this.pb_height_wide=create pb_height_wide
this.pb_right=create pb_right
this.pb_left=create pb_left
this.pb_down=create pb_down
this.pb_up=create pb_up
this.st_12=create st_12
this.st_11=create st_11
this.st_original_x=create st_original_x
this.st_original_y=create st_original_y
this.st_original_width=create st_original_width
this.st_original_height=create st_original_height
this.sle_height=create sle_height
this.sle_width=create sle_width
this.sle_y=create sle_y
this.sle_x=create sle_x
this.st_control=create st_control
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_control=create gb_control
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_width_narrow
this.Control[iCurrent+2]=this.pb_width_wide
this.Control[iCurrent+3]=this.p_drag_size_adjust
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.pb_height_narrow
this.Control[iCurrent+6]=this.pb_height_wide
this.Control[iCurrent+7]=this.pb_right
this.Control[iCurrent+8]=this.pb_left
this.Control[iCurrent+9]=this.pb_down
this.Control[iCurrent+10]=this.pb_up
this.Control[iCurrent+11]=this.st_12
this.Control[iCurrent+12]=this.st_11
this.Control[iCurrent+13]=this.st_original_x
this.Control[iCurrent+14]=this.st_original_y
this.Control[iCurrent+15]=this.st_original_width
this.Control[iCurrent+16]=this.st_original_height
this.Control[iCurrent+17]=this.sle_height
this.Control[iCurrent+18]=this.sle_width
this.Control[iCurrent+19]=this.sle_y
this.Control[iCurrent+20]=this.sle_x
this.Control[iCurrent+21]=this.st_control
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.st_2
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.gb_control
end on

on w_size_adjust.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_width_narrow)
destroy(this.pb_width_wide)
destroy(this.p_drag_size_adjust)
destroy(this.cb_close)
destroy(this.pb_height_narrow)
destroy(this.pb_height_wide)
destroy(this.pb_right)
destroy(this.pb_left)
destroy(this.pb_down)
destroy(this.pb_up)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_original_x)
destroy(this.st_original_y)
destroy(this.st_original_width)
destroy(this.st_original_height)
destroy(this.sle_height)
destroy(this.sle_width)
destroy(this.sle_y)
destroy(this.sle_x)
destroy(this.st_control)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_control)
end on

event resize;call super::resize;// 固定サイズおよび位置

// 選択中のコントロール
st_5.x						= 24
st_5.y						= 32
st_5.width					= 520
st_5.height					= 53

// st_control
st_control.x				= st_5.x + st_5.width + 8
st_control.y				= 25
st_control.height			= 66

// 値
st_11.y						= 107
st_11.width					= 72
st_11.height				= 53

// 元の値
st_12.y						= st_11.y
st_12.width					= 192
st_12.height				= st_11.height

// 横位置【x】
st_1.x						= 8
st_1.y						= 171
st_1.width					= 408
st_1.height					= 53

// 縦位置【ｙ】
st_2.x						= st_1.x
st_2.y						= st_1.y + st_1.height + 25
st_2.width					= st_1.width
st_2.height					= st_1.height

// 幅【width】
st_3.x						= st_1.x
st_3.y						= st_2.y + st_2.height + 25
st_3.width					= st_1.width
st_3.height					= st_1.height

// 高さ【height】
st_4.x						= st_1.x
st_4.y						= st_3.y + st_3.height + 25
st_4.width					= st_1.width
st_4.height					= st_1.height

// sle_x
sle_x.x						= st_1.x + st_1.width + 8
sle_x.y						= st_1.y - 11
sle_x.width					= 476
sle_x.height				= 75

// sle_y
sle_y.x						= sle_x.x
sle_y.y						= st_2.y - 11
sle_y.width					= sle_x.width
sle_y.height				= sle_x.height

// sle_width
sle_width.x					= sle_x.x
sle_width.y					= st_3.y - 11
sle_width.width				= sle_x.width
sle_width.height			= sle_x.height

// sle_height
sle_height.x				= sle_x.x
sle_height.y				= st_4.y - 11
sle_height.width			= sle_x.width
sle_height.height			= sle_x.height

// 値
st_11.x						= sle_x.x


// st_original_x
st_original_x.x				= sle_x.x + sle_x.width + 12
st_original_x.y				= st_1.y - 4
st_original_x.height		= 60

// st_original_y
st_original_y.x				= st_original_x.x
st_original_y.y				= st_2.y - 4
st_original_y.height		= st_original_x.height

// st_original_width
st_original_width.x			= st_original_x.x
st_original_width.y			= st_3.y - 4
st_original_width.height	= st_original_x.height

// st_original_height
st_original_height.x		= st_original_x.x
st_original_height.y		= st_4.y - 4
st_original_height.height	= st_original_x.height

// 元の値
st_12.x						= st_original_x.x

// gb_control
gb_control.x				= 16
gb_control.y				= sle_height.y + 100

// pb_up
pb_up.x						= gb_control.x + 36
pb_up.y						= gb_control.y + 53
pb_up.width					= 170
pb_up.height				= 140

// pb_down
pb_down.x					= pb_up.x + pb_up.width
pb_down.y					= pb_up.y
pb_down.width				= pb_up.width
pb_down.height				= pb_up.height

// pb_left
pb_left.x					= pb_down.x + pb_down.width + 12
pb_left.y					= pb_up.y
pb_left.width				= pb_up.width
pb_left.height				= pb_up.height

// pb_right
pb_right.x					= pb_left.x + pb_left.width
pb_right.y					= pb_up.y
pb_right.width				= pb_up.width
pb_right.height				= pb_up.height

// pb_height_wide
pb_height_wide.x			= pb_right.x + pb_right.width + 12
pb_height_wide.y			= pb_up.y
pb_height_wide.width		= pb_up.width
pb_height_wide.height		= pb_up.height

// pb_height_narrow
pb_height_narrow.x			= pb_height_wide.x + pb_height_wide.width
pb_height_narrow.y			= pb_up.y
pb_height_narrow.width		= pb_up.width
pb_height_narrow.height		= pb_up.height

// pb_width_wide
pb_width_wide.x				= pb_height_narrow.x + pb_height_narrow.width + 12
pb_width_wide.y				= pb_up.y
pb_width_wide.width			= pb_up.width
pb_width_wide.height		= pb_up.height

// pb_width_narrow
pb_width_narrow.x			= pb_width_wide.x + pb_width_wide.width
pb_width_narrow.y			= pb_up.y
pb_width_narrow.width		= pb_up.width
pb_width_narrow.height		= pb_up.height

// gb_control
gb_control.width			= pb_width_narrow.x + pb_width_narrow.width + 24
gb_control.height			= pb_up.height + 90

this.width					= gb_control.x + gb_control.width + 40

// p_drag_size_adjust
p_drag_size_adjust.y		= 12
p_drag_size_adjust.width	= 116
p_drag_size_adjust.height	= 96

// p_drag
p_drag_size_adjust.x		= this.width - p_drag_size_adjust.width - 32

// st_control
// st_control.width			= gb_control.x + gb_control.width - st_control.x
st_control.width			= p_drag_size_adjust.x - st_control.x - 16

// st_original_x
st_original_x.width			= gb_control.x + gb_control.width - st_original_x.x

// st_original_y
st_original_y.width			= st_original_x.width

// st_original_width
st_original_width.width		= st_original_x.width

// st_original_height
st_original_height.width	= st_original_x.width

// cb_close
cb_close.y					= gb_control.y + gb_control.height + 8
cb_close.width				= 380
cb_close.height				= 85

// cb_close
cb_close.x					= gb_control.x + gb_control.width - cb_close.width - 16

this.height					= cb_close.y + cb_close.height + 120

end event

type pb_width_narrow from asv_picturebutton within w_size_adjust
integer x = 1224
integer y = 558
integer width = 172
integer height = 139
integer taborder = 60
string text = ""
boolean originalsize = false
string picturename = "image\arrow\width_narrow_arrow.png"
string powertiptext = "横幅を広くします"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_up( sle_width )
end event

type pb_width_wide from asv_picturebutton within w_size_adjust
integer x = 1056
integer y = 558
integer width = 172
integer height = 139
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "image\arrow\width_wide_arrow.png"
string powertiptext = "横幅を狭くします"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_down( sle_width )
end event

type p_drag_size_adjust from uo_p_base within w_size_adjust
integer x = 1200
integer y = 18
integer width = 116
integer height = 96
string dragicon = "image\emotion_detective.ico"
boolean dragauto = true
string pointer = "HyperLink!"
boolean originalsize = false
string picturename = "image\emotion_detective.png"
boolean focusrectangle = true
end type

event dragdrop;call super::dragdrop;msg.of_info("drop")
end event

type cb_close from asv_commandbutton within w_size_adjust
integer x = 1036
integer y = 796
integer width = 380
integer height = 85
integer textsize = -11
string text = "終 了"
end type

event clicked;call super::clicked;close( parent )
end event

type pb_height_narrow from asv_picturebutton within w_size_adjust
integer x = 884
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\height_narrow_arrow.png"
string powertiptext = "縦幅を狭くします"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_down( sle_height )
end event

type pb_height_wide from asv_picturebutton within w_size_adjust
integer x = 716
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\height_wide_arrow.png"
string powertiptext = "縦幅を広くします"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_up( sle_height )
end event

type pb_right from asv_picturebutton within w_size_adjust
integer x = 544
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\right_arrow.png"
string powertiptext = "右に移動します"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_up( sle_x )
end event

type pb_left from asv_picturebutton within w_size_adjust
integer x = 376
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\left_arrow.png"
string powertiptext = "左に移動します"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_down( sle_x )
end event

type pb_down from asv_picturebutton within w_size_adjust
integer x = 204
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\down_arrow.png"
string powertiptext = "下に移動します"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_down( sle_y )
end event

type pb_up from asv_picturebutton within w_size_adjust
integer x = 36
integer y = 558
integer width = 172
integer height = 139
string text = ""
boolean originalsize = false
string picturename = "image\arrow\up_arrow.png"
string powertiptext = "上に移動します"
long backcolor = 67108864
end type

event clicked;call super::clicked;of_up( sle_y )
end event

type st_12 from asv_statictext within w_size_adjust
integer x = 904
integer y = 107
integer width = 192
integer height = 53
integer textsize = -11
integer weight = 700
string text = "元の値"
end type

type st_11 from asv_statictext within w_size_adjust
integer x = 416
integer y = 107
integer width = 72
integer height = 53
integer textsize = -11
integer weight = 700
string text = "値"
end type

type st_original_x from asv_statictext within w_size_adjust
integer x = 904
integer y = 167
integer width = 408
integer height = 60
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean border = true
end type

type st_original_y from asv_statictext within w_size_adjust
integer x = 904
integer y = 245
integer width = 408
integer height = 60
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean border = true
end type

type st_original_width from asv_statictext within w_size_adjust
integer x = 904
integer y = 324
integer width = 408
integer height = 60
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean border = true
end type

type st_original_height from asv_statictext within w_size_adjust
integer x = 904
integer y = 402
integer width = 408
integer height = 60
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean border = true
end type

type sle_height from asv_singlelineedit within w_size_adjust
integer x = 416
integer y = 395
integer width = 476
integer taborder = 40
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean up_key = true
boolean down_key = true
end type

event key_up;call super::key_up;of_up( this )

return 0
end event

event key_down;call super::key_down;of_down( this )

return 0
end event

type sle_width from asv_singlelineedit within w_size_adjust
integer x = 416
integer y = 316
integer width = 476
integer taborder = 30
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean up_key = true
boolean down_key = true
end type

event key_up;call super::key_up;of_up( this )

return 0
end event

event key_down;call super::key_down;of_down( this )

return 0
end event

type sle_y from asv_singlelineedit within w_size_adjust
integer x = 416
integer y = 238
integer width = 476
integer taborder = 20
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean up_key = true
boolean down_key = true
end type

event key_up;call super::key_up;of_up( this )

return 0
end event

event key_down;call super::key_down;of_down( this )

return 0
end event

type sle_x from asv_singlelineedit within w_size_adjust
integer x = 416
integer y = 160
integer width = 476
integer taborder = 10
integer textsize = -11
fontpitch fontpitch = fixed!
string facename = "ＭＳ ゴシック"
string text = ""
boolean up_key = true
boolean down_key = true
end type

event key_up;call super::key_up;of_up( this )

return 0
end event

event key_down;call super::key_down;of_down( this )

return 0
end event

type st_control from asv_statictext within w_size_adjust
integer x = 616
integer y = 25
integer width = 600
integer height = 68
integer textsize = -11
string text = "※選択してください"
boolean border = true
end type

type st_5 from asv_statictext within w_size_adjust
integer x = 16
integer y = 32
integer width = 520
integer height = 53
integer textsize = -11
integer weight = 700
long backcolor = 134217752
string text = "選択中のｺﾝﾄﾛｰﾙ："
end type

type st_4 from asv_statictext within w_size_adjust
integer y = 405
integer width = 408
integer height = 53
integer textsize = -11
integer weight = 700
string text = "高さ【height】："
alignment alignment = right!
end type

type st_3 from asv_statictext within w_size_adjust
integer y = 327
integer width = 408
integer height = 53
integer textsize = -11
integer weight = 700
string text = "幅【width】："
alignment alignment = right!
end type

type st_2 from asv_statictext within w_size_adjust
integer y = 249
integer width = 408
integer height = 53
integer textsize = -11
integer weight = 700
string text = "縦位置【ｙ】："
alignment alignment = right!
end type

type st_1 from asv_statictext within w_size_adjust
integer y = 171
integer width = 408
integer height = 53
integer textsize = -11
integer weight = 700
string text = "横位置【x】："
alignment alignment = right!
end type

type gb_control from asv_groupbox within w_size_adjust
integer y = 505
integer width = 1436
integer height = 249
string text = "コントロールパネル"
end type

