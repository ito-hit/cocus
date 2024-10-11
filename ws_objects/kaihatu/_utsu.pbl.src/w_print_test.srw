$PBExportHeader$w_print_test.srw
$PBExportComments$印刷テスト用
forward
global type w_print_test from iw_print_window
end type
end forward

global type w_print_test from iw_print_window
string title = "内海印刷テスト用"
end type
global w_print_test w_print_test

on w_print_test.create
int iCurrent
call super::create
end on

on w_print_test.destroy
call super::destroy
end on

type uo_signal from iw_print_window`uo_signal within w_print_test
end type

type st_date from iw_print_window`st_date within w_print_test
end type

type st_user_mei from iw_print_window`st_user_mei within w_print_test
end type

type uo_test_mode from iw_print_window`uo_test_mode within w_print_test
end type

type p_size_adjust from iw_print_window`p_size_adjust within w_print_test
end type

type st_title from iw_print_window`st_title within w_print_test
end type

type st_title_upper from iw_print_window`st_title_upper within w_print_test
end type

type st_upper from iw_print_window`st_upper within w_print_test
end type

type ddplb_1 from iw_print_window`ddplb_1 within w_print_test
boolean type_lbp = true
end type

