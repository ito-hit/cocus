$PBExportHeader$uo_p_plus_button.sru
forward
global type uo_p_plus_button from uo_p_base
end type
end forward

global type uo_p_plus_button from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\plus_button.png"
end type
global uo_p_plus_button uo_p_plus_button

on uo_p_plus_button.create
call super::create
end on

on uo_p_plus_button.destroy
call super::destroy
end on

