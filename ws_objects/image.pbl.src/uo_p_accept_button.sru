$PBExportHeader$uo_p_accept_button.sru
forward
global type uo_p_accept_button from uo_p_base
end type
end forward

global type uo_p_accept_button from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\accept_button.png"
end type
global uo_p_accept_button uo_p_accept_button

on uo_p_accept_button.create
call super::create
end on

on uo_p_accept_button.destroy
call super::destroy
end on

