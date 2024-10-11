$PBExportHeader$wp_kin_test.srw
forward
global type wp_kin_test from iw_print_window
end type
type cb_1 from commandbutton within wp_kin_test
end type
type cb_2 from commandbutton within wp_kin_test
end type
type cb_3 from commandbutton within wp_kin_test
end type
type cb_4 from commandbutton within wp_kin_test
end type
end forward

global type wp_kin_test from iw_print_window
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global wp_kin_test wp_kin_test

on wp_kin_test.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
end on

on wp_kin_test.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

type uo_signal from iw_print_window`uo_signal within wp_kin_test
end type

type st_date from iw_print_window`st_date within wp_kin_test
end type

type st_user_mei from iw_print_window`st_user_mei within wp_kin_test
end type

type uo_test_mode from iw_print_window`uo_test_mode within wp_kin_test
end type

type p_size_adjust from iw_print_window`p_size_adjust within wp_kin_test
end type

type st_title from iw_print_window`st_title within wp_kin_test
end type

type st_title_upper from iw_print_window`st_title_upper within wp_kin_test
end type

type st_upper from iw_print_window`st_upper within wp_kin_test
end type

type ddplb_printer from iw_print_window`ddplb_printer within wp_kin_test
end type

type st_bottom from iw_print_window`st_bottom within wp_kin_test
end type

type cb_preview from iw_print_window`cb_preview within wp_kin_test
end type

type cb_print from iw_print_window`cb_print within wp_kin_test
end type

type cb_cancel from iw_print_window`cb_cancel within wp_kin_test
end type

type st_printer from iw_print_window`st_printer within wp_kin_test
end type

type st_busu from iw_print_window`st_busu within wp_kin_test
end type

type sle_busu from iw_print_window`sle_busu within wp_kin_test
end type

type cb_test from iw_print_window`cb_test within wp_kin_test
end type

type cb_1 from commandbutton within wp_kin_test
integer x = 76
integer y = 313
integer width = 312
integer height = 75
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
string text = "構造体引数１"
end type

event clicked;
window	l_win
string	l_id	= "wp_preview"

str_mkihon	l_str_para

l_str_para.fax_no = "0847-40-3134"

openwithparm( l_win, l_str_para, l_id )
end event

type cb_2 from commandbutton within wp_kin_test
integer x = 76
integer y = 384
integer width = 312
integer height = 75
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
string text = "構造体引数２"
end type

event clicked;
window	l_win
string	l_id	= "wp_preview"

str_mkyoten	l_str_para

l_str_para.fax_no = "0847-40-3134"

openwithparm( l_win, l_str_para, l_id )


end event

type cb_3 from commandbutton within wp_kin_test
integer x = 76
integer y = 455
integer width = 312
integer height = 75
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
string text = "DW引数１"
end type

event clicked;
window	l_win
string	l_id	= "wp_preview"

datastore	l_ds[]
str_pblob	l_blob

l_ds[1]	= create datastore
l_ds[2]	= create datastore

l_ds[1].dataobject	= "dmm_user_entry"
l_ds[2].dataobject	= "dmm_user_entry"

l_ds[1].settransobject( cocos )
l_ds[2].settransobject( cocos )

l_ds[1].retrieve( "2206" )
l_ds[2].retrieve( "1208" )

l_ds[1].getfullstate( l_blob.pdws[1] )
l_ds[2].getfullstate( l_blob.pdws[2] )

openwithparm( l_win, l_blob, l_id )


end event

type cb_4 from commandbutton within wp_kin_test
integer x = 76
integer y = 526
integer width = 312
integer height = 75
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
string text = "DW引数１"
end type

