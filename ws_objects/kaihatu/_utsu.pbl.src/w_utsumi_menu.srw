$PBExportHeader$w_utsumi_menu.srw
$PBExportComments$内海専用メニュー
forward
global type w_utsumi_menu from iw_menu_window
end type
type cb_1 from ivo_commandbutton within w_utsumi_menu
end type
type cb_2 from ivo_commandbutton within w_utsumi_menu
end type
type cb_3 from ivo_commandbutton within w_utsumi_menu
end type
type cb_hit_menu from ivo_commandbutton within w_utsumi_menu
end type
type cb_4 from ivo_commandbutton within w_utsumi_menu
end type
end forward

global type w_utsumi_menu from iw_menu_window
string title = "内海様メニュー"
boolean auto_generate_menu = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_hit_menu cb_hit_menu
cb_4 cb_4
end type
global w_utsumi_menu w_utsumi_menu

on w_utsumi_menu.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_hit_menu=create cb_hit_menu
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_hit_menu
this.Control[iCurrent+5]=this.cb_4
end on

on w_utsumi_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_hit_menu)
destroy(this.cb_4)
end on

type uo_signal from iw_menu_window`uo_signal within w_utsumi_menu
end type

type st_date from iw_menu_window`st_date within w_utsumi_menu
end type

type st_user_mei from iw_menu_window`st_user_mei within w_utsumi_menu
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_utsumi_menu
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_utsumi_menu
end type

type st_title from iw_menu_window`st_title within w_utsumi_menu
end type

type st_title_upper from iw_menu_window`st_title_upper within w_utsumi_menu
end type

type st_upper from iw_menu_window`st_upper within w_utsumi_menu
end type

type tab_menu from iw_menu_window`tab_menu within w_utsumi_menu
boolean visible = false
integer width = 80
integer height = 82
end type

type pb_exit from iw_menu_window`pb_exit within w_utsumi_menu
end type

type pb_logoff from iw_menu_window`pb_logoff within w_utsumi_menu
end type

type shl_notifi from iw_menu_window`shl_notifi within w_utsumi_menu
end type

type uo_band_message from iw_menu_window`uo_band_message within w_utsumi_menu
end type

type cb_1 from ivo_commandbutton within w_utsumi_menu
integer x = 76
integer y = 380
integer width = 700
integer taborder = 10
boolean bringtotop = true
string text = "ウインドウ登録"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_window"

open( l_win, l_win_name )
end event

type cb_2 from ivo_commandbutton within w_utsumi_menu
integer x = 76
integer y = 484
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "内海テスト用"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_utsumi_test"

open( l_win, l_win_name )
end event

type cb_3 from ivo_commandbutton within w_utsumi_menu
integer x = 76
integer y = 654
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "印刷テスト用"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_print_test"

open( l_win, l_win_name )
end event

type cb_hit_menu from ivo_commandbutton within w_utsumi_menu
integer x = 1972
integer y = 380
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "HITさんメニュー"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_hit_menu"

open( l_win, l_win_name )
end event

type cb_4 from ivo_commandbutton within w_utsumi_menu
integer x = 860
integer y = 380
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "商品一覧照会"
end type

event clicked;call super::clicked;winctl.of_open( "ws_syohin" )
end event

