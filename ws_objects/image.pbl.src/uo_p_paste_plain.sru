$PBExportHeader$uo_p_paste_plain.sru
forward
global type uo_p_paste_plain from uo_p_base
end type
end forward

global type uo_p_paste_plain from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\clip\paste_plain.png"
end type
global uo_p_paste_plain uo_p_paste_plain

on uo_p_paste_plain.create
call super::create
end on

on uo_p_paste_plain.destroy
call super::destroy
end on

