$PBExportHeader$w_menu_hanbai1.srw
$PBExportComments$販売メニュー１
forward
global type w_menu_hanbai1 from iw_menu_window
end type
end forward

global type w_menu_hanbai1 from iw_menu_window
string title = "販売管理メニュー１"
end type
global w_menu_hanbai1 w_menu_hanbai1

on w_menu_hanbai1.create
int iCurrent
call super::create
end on

on w_menu_hanbai1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_test_mode from iw_menu_window`uo_test_mode within w_menu_hanbai1
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_menu_hanbai1
end type

type st_title from iw_menu_window`st_title within w_menu_hanbai1
end type

type st_title_upper from iw_menu_window`st_title_upper within w_menu_hanbai1
end type

type st_upper from iw_menu_window`st_upper within w_menu_hanbai1
end type

type tab_menu from iw_menu_window`tab_menu within w_menu_hanbai1
integer x = 12
integer y = 146
integer width = 96
integer height = 78
end type

type pb_exit from iw_menu_window`pb_exit within w_menu_hanbai1
end type

type pb_logoff from iw_menu_window`pb_logoff within w_menu_hanbai1
end type

