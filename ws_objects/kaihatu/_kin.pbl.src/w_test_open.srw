$PBExportHeader$w_test_open.srw
forward
global type w_test_open from iw_main_window
end type
end forward

global type w_test_open from iw_main_window
end type
global w_test_open w_test_open

on w_test_open.create
int iCurrent
call super::create
end on

on w_test_open.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_signal from iw_main_window`uo_signal within w_test_open
end type

type st_date from iw_main_window`st_date within w_test_open
end type

type st_user_mei from iw_main_window`st_user_mei within w_test_open
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_test_open
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_test_open
end type

type st_title from iw_main_window`st_title within w_test_open
end type

type st_title_upper from iw_main_window`st_title_upper within w_test_open
end type

type st_upper from iw_main_window`st_upper within w_test_open
end type

type st_second_upper from iw_main_window`st_second_upper within w_test_open
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_test_open
end type

