$PBExportHeader$wp_keep_warning_tyohyo.srw
$PBExportComments$キープ期限警告リスト発行帳票ウィンドウ
forward
global type wp_keep_warning_tyohyo from iw_print_window
end type
type dw_list from ivo_datawindow within wp_keep_warning_tyohyo
end type
end forward

global type wp_keep_warning_tyohyo from iw_print_window
string title = "キープ期限警告リスト発行"
dw_list dw_list
end type
global wp_keep_warning_tyohyo wp_keep_warning_tyohyo

on wp_keep_warning_tyohyo.create
int iCurrent
call super::create
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
end on

on wp_keep_warning_tyohyo.destroy
call super::destroy
destroy(this.dw_list)
end on

event open;call super::open;

dw_list.retrieve()
end event

type uo_signal from iw_print_window`uo_signal within wp_keep_warning_tyohyo
end type

type st_date from iw_print_window`st_date within wp_keep_warning_tyohyo
end type

type st_user_mei from iw_print_window`st_user_mei within wp_keep_warning_tyohyo
end type

type uo_test_mode from iw_print_window`uo_test_mode within wp_keep_warning_tyohyo
end type

type p_size_adjust from iw_print_window`p_size_adjust within wp_keep_warning_tyohyo
end type

type st_title from iw_print_window`st_title within wp_keep_warning_tyohyo
end type

type st_title_upper from iw_print_window`st_title_upper within wp_keep_warning_tyohyo
string tag = "キープ期限警告リスト発行"
end type

type st_upper from iw_print_window`st_upper within wp_keep_warning_tyohyo
end type

type ddplb_printer from iw_print_window`ddplb_printer within wp_keep_warning_tyohyo
end type

type st_bottom from iw_print_window`st_bottom within wp_keep_warning_tyohyo
end type

type cb_preview from iw_print_window`cb_preview within wp_keep_warning_tyohyo
end type

type cb_print from iw_print_window`cb_print within wp_keep_warning_tyohyo
end type

type cb_cancel from iw_print_window`cb_cancel within wp_keep_warning_tyohyo
end type

type st_printer from iw_print_window`st_printer within wp_keep_warning_tyohyo
end type

type st_busu from iw_print_window`st_busu within wp_keep_warning_tyohyo
end type

type sle_busu from iw_print_window`sle_busu within wp_keep_warning_tyohyo
end type

type cb_test from iw_print_window`cb_test within wp_keep_warning_tyohyo
end type

type dw_list from ivo_datawindow within wp_keep_warning_tyohyo
integer y = 135
integer width = 5100
integer height = 1703
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_keep_warning_tyohyo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f2_key = true
boolean f3_key = true
boolean f5_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
end type

event constructor;call super::constructor;this.reset()
this.settransobject(cocos)

/*
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)


DataWindowChild	ldwc_houhou
DataWindowChild	ldwc_riyu
//DataWindowChild	ldwc_tuuti_lvl

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "houhou_kbn", ldwc_houhou)
ldwc_houhou.settransobject( cocos )

meisyo_kbn		= 152
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_houhou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "riyu_kbn", ldwc_riyu)
ldwc_riyu.settransobject( cocos )

meisyo_kbn		= 153
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_riyu.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

this.reset()

this.settransobject(cocos)
*/
end event

