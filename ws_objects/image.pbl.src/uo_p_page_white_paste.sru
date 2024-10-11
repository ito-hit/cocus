$PBExportHeader$uo_p_page_white_paste.sru
forward
global type uo_p_page_white_paste from uo_p_base
end type
end forward

global type uo_p_page_white_paste from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\clip\page_white_paste.png"
end type
global uo_p_page_white_paste uo_p_page_white_paste

on uo_p_page_white_paste.create
call super::create
end on

on uo_p_page_white_paste.destroy
call super::destroy
end on

