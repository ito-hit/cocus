$PBExportHeader$uo_p_toggle_expand.sru
forward
global type uo_p_toggle_expand from uo_p_base
end type
end forward

global type uo_p_toggle_expand from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\toggle_expand.png"
end type
global uo_p_toggle_expand uo_p_toggle_expand

on uo_p_toggle_expand.create
call super::create
end on

on uo_p_toggle_expand.destroy
call super::destroy
end on

