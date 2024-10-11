$PBExportHeader$wse_tuuti.srw
$PBExportComments$通知画面明細表示ウインドウ
forward
global type wse_tuuti from aw_base_window
end type
type cb_close from sv_cb_close within wse_tuuti
end type
type dw_list from ivo_datawindow within wse_tuuti
end type
type ln_line from line within wse_tuuti
end type
end forward

global type wse_tuuti from aw_base_window
integer width = 2228
integer height = 1390
string title = ""
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean fnkey_enabled = false
cb_close cb_close
dw_list dw_list
ln_line ln_line
end type
global wse_tuuti wse_tuuti

type variables
private:
	string	i_rowid
end variables

on wse_tuuti.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_list=create dw_list
this.ln_line=create ln_line
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.ln_line
end on

on wse_tuuti.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_list)
destroy(this.ln_line)
end on

event openquery;call super::openquery;// パラメーターでROWIDを取得
i_rowid	= message.stringparm

//i_rowid	= "AAAZX3AAOAAAACEAAB"	// tuuti_no	= 10000029
//i_rowid	= "AAAZX3AAOAAAACGAAA"	// tuuti_no	= 10000028
//i_rowid	= "AAAZX3AAOAAAACEAAy"		// tuuti_no	= 10000030 and user_id	= 8138
end event

event resize;call super::resize;p_size_adjust.x	= 0
p_size_adjust.y	= 0

uo_test_mode.x	= p_size_adjust.x + p_size_adjust.width
uo_test_mode.y	= p_size_adjust.y + p_size_adjust.height / 2 - uo_test_mode.height / 2

// dw_list
dw_list.x		= code.MGN_YOKO
dw_list.y		= code.MGN_TATE

dw_list.width  	= this.width - code.MGN_YOKO * 3
dw_list.height 	= 1084//1152

// dw_listのobjectの位置
dw_list.object.message.width	= dw_list.width - 4 - 4
dw_list.object.touroku_date.x	= long( dw_list.object.message.x ) + long( dw_list.object.message.width ) - long( dw_list.object.touroku_date.width ) - 4

// ln_line	y = 1191
ln_line.beginy	= dw_list.y + dw_list.height + code.MGN_TATE
ln_line.endy	= dw_list.y + dw_list.height + code.MGN_TATE

// cb_close
cb_close.x	= this.width / 2 - cb_close.width / 2
cb_close.y	= ln_line.beginy + code.MGN_TATE

this.height	= cb_close.y + cb_close.height + code.MGN_TATE * 8

end event

event open;call super::open;long	l_row

dw_list.retrieve( i_rowid )

l_row		= dw_list.getrow( )
this.title	= dw_list.object.syubetu[l_row]
end event

type uo_signal from aw_base_window`uo_signal within wse_tuuti
end type

type st_date from aw_base_window`st_date within wse_tuuti
boolean visible = false
end type

type st_user_mei from aw_base_window`st_user_mei within wse_tuuti
boolean visible = false
end type

type uo_test_mode from aw_base_window`uo_test_mode within wse_tuuti
end type

type p_size_adjust from aw_base_window`p_size_adjust within wse_tuuti
boolean visible = false
end type

type st_title from aw_base_window`st_title within wse_tuuti
boolean visible = false
end type

type st_title_upper from aw_base_window`st_title_upper within wse_tuuti
boolean visible = false
end type

type st_upper from aw_base_window`st_upper within wse_tuuti
boolean visible = false
end type

type cb_close from sv_cb_close within wse_tuuti
integer x = 916
integer y = 1205
integer taborder = 10
boolean bringtotop = true
string text = "閉じる"
boolean confirm_enabled = false
end type

type dw_list from ivo_datawindow within wse_tuuti
integer width = 2204
integer height = 1148
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_tuuti_meisai"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
dw_list.settransobject(cocos)
end event

type ln_line from line within wse_tuuti
string tag = "y = 1191"
boolean visible = false
integer linethickness = 5
integer beginy = 1191
integer endx = 2200
integer endy = 1191
end type

event constructor;
this.visible	= false
end event

