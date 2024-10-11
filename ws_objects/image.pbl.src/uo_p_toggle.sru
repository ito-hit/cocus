$PBExportHeader$uo_p_toggle.sru
forward
global type uo_p_toggle from uo_p_base
end type
end forward

global type uo_p_toggle from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\toggle.png"
end type
global uo_p_toggle uo_p_toggle

on uo_p_toggle.create
call super::create
end on

on uo_p_toggle.destroy
call super::destroy
end on

