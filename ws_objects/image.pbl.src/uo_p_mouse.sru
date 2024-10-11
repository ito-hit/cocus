$PBExportHeader$uo_p_mouse.sru
forward
global type uo_p_mouse from uo_p_base
end type
end forward

global type uo_p_mouse from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\mouse.png"
end type
global uo_p_mouse uo_p_mouse

on uo_p_mouse.create
call super::create
end on

on uo_p_mouse.destroy
call super::destroy
end on

