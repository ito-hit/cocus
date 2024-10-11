$PBExportHeader$w_menu_test.srw
$PBExportComments$テスト用メニュー
forward
global type w_menu_test from iw_menu_window
end type
type cb_1 from ivo_commandbutton within w_menu_test
end type
type cb_2 from ivo_commandbutton within w_menu_test
end type
type cb_3 from ivo_commandbutton within w_menu_test
end type
type cb_5 from ivo_commandbutton within w_menu_test
end type
type cb_6 from ivo_commandbutton within w_menu_test
end type
type cb_7 from ivo_commandbutton within w_menu_test
end type
type cb_8 from ivo_commandbutton within w_menu_test
end type
type cb_9 from ivo_commandbutton within w_menu_test
end type
type cb_10 from ivo_commandbutton within w_menu_test
end type
type cb_11 from ivo_commandbutton within w_menu_test
end type
type cb_4 from ivo_commandbutton within w_menu_test
end type
end forward

global type w_menu_test from iw_menu_window
string title = "テストメニュー"
boolean auto_generate_menu = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_4 cb_4
end type
global w_menu_test w_menu_test

on w_menu_test.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.cb_6
this.Control[iCurrent+6]=this.cb_7
this.Control[iCurrent+7]=this.cb_8
this.Control[iCurrent+8]=this.cb_9
this.Control[iCurrent+9]=this.cb_10
this.Control[iCurrent+10]=this.cb_11
this.Control[iCurrent+11]=this.cb_4
end on

on w_menu_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_4)
end on

type uo_signal from iw_menu_window`uo_signal within w_menu_test
end type

type st_date from iw_menu_window`st_date within w_menu_test
end type

type st_user_mei from iw_menu_window`st_user_mei within w_menu_test
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_menu_test
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_menu_test
end type

type st_title from iw_menu_window`st_title within w_menu_test
end type

type st_title_upper from iw_menu_window`st_title_upper within w_menu_test
end type

type st_upper from iw_menu_window`st_upper within w_menu_test
end type

type tab_menu from iw_menu_window`tab_menu within w_menu_test
boolean visible = false
integer x = 12
integer y = 146
integer width = 96
integer height = 78
end type

type pb_exit from iw_menu_window`pb_exit within w_menu_test
integer taborder = 110
end type

type pb_logoff from iw_menu_window`pb_logoff within w_menu_test
integer taborder = 100
end type

type shl_notifi from iw_menu_window`shl_notifi within w_menu_test
end type

type uo_band_message from iw_menu_window`uo_band_message within w_menu_test
end type

type cb_1 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 373
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "名称マスタメンテナンス"
boolean enter2tab = false
end type

event execution;call super::execution;winctl.of_open( "w_master_meisyo" )
end event

type cb_2 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 469
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "ファンクションキーテスト"
boolean enter2tab = false
end type

event execution;call super::execution;//open( w_test_function )
end event

type cb_3 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 608
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "名称マスタメンテ(読取)"
boolean enter2tab = false
end type

event execution;call super::execution;winctl.of_open_readonly( "w_master_meisyo" )
end event

type cb_5 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 843
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "内海メニュー"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_utsumi_menu"

open( l_win, l_win_name )






end event

type cb_6 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 949
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "金藤メニュー"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_kin_menu"

open( l_win, l_win_name )
end event

type cb_7 from ivo_commandbutton within w_menu_test
integer x = 56
integer y = 1056
integer width = 700
integer taborder = 120
boolean bringtotop = true
string text = "山本メニュー"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_yamamoto_menu"

open( l_win, l_win_name )

end event

type cb_8 from ivo_commandbutton within w_menu_test
integer x = 776
integer y = 373
integer width = 700
integer taborder = 80
boolean bringtotop = true
string text = "販売管理メニュー１"
boolean enter2tab = false
end type

event execution;call super::execution;window 	l_win
string	l_menu	= "w_menu_hanbai1"

open( l_win, l_menu )
 
end event

type cb_9 from ivo_commandbutton within w_menu_test
integer x = 776
integer y = 469
integer width = 700
integer taborder = 90
boolean bringtotop = true
string text = "モーダルテスト"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_test_modal"

open( l_win, l_win_name )
end event

type cb_10 from ivo_commandbutton within w_menu_test
integer x = 776
integer y = 604
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "通知管理テスト"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_tuuti"

open( l_win, l_win_name )
end event

type cb_11 from ivo_commandbutton within w_menu_test
integer x = 776
integer y = 843
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "HITさんメニュー"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_hit_menu"

open( l_win, l_win_name )

end event

type cb_4 from ivo_commandbutton within w_menu_test
integer x = 1496
integer y = 373
integer width = 720
integer taborder = 40
boolean bringtotop = true
string text = "カレンダーマスタ（サンプル）"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_mente_calendar"

open( l_win, l_win_name )
end event

