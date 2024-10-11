$PBExportHeader$w_test_winctl.srw
forward
global type w_test_winctl from iw_modal_window
end type
end forward

global type w_test_winctl from iw_modal_window
end type
global w_test_winctl w_test_winctl

on w_test_winctl.create
int iCurrent
call super::create
end on

on w_test_winctl.destroy
call super::destroy
end on

type uo_signal from iw_modal_window`uo_signal within w_test_winctl
end type

type st_date from iw_modal_window`st_date within w_test_winctl
end type

type st_user_mei from iw_modal_window`st_user_mei within w_test_winctl
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_test_winctl
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_test_winctl
end type

type st_title from iw_modal_window`st_title within w_test_winctl
end type

type st_title_upper from iw_modal_window`st_title_upper within w_test_winctl
end type

type st_upper from iw_modal_window`st_upper within w_test_winctl
end type

type st_tail from iw_modal_window`st_tail within w_test_winctl
end type

type cb_ok from iw_modal_window`cb_ok within w_test_winctl
end type

type cb_cancel from iw_modal_window`cb_cancel within w_test_winctl
end type

type dw_list from iw_modal_window`dw_list within w_test_winctl
boolean visible = false
end type

