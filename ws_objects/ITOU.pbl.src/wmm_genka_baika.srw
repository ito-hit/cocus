$PBExportHeader$wmm_genka_baika.srw
$PBExportComments$原価売価登録
forward
global type wmm_genka_baika from iw_main_window
end type
end forward

global type wmm_genka_baika from iw_main_window
string title = "原価売価登録"
end type
global wmm_genka_baika wmm_genka_baika

on wmm_genka_baika.create
int iCurrent
call super::create
end on

on wmm_genka_baika.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_signal from iw_main_window`uo_signal within wmm_genka_baika
end type

type st_date from iw_main_window`st_date within wmm_genka_baika
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_genka_baika
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_genka_baika
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_genka_baika
end type

type st_title from iw_main_window`st_title within wmm_genka_baika
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_genka_baika
end type

type st_upper from iw_main_window`st_upper within wmm_genka_baika
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_genka_baika
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_genka_baika
end type

