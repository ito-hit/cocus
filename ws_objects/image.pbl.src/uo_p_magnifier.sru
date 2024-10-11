$PBExportHeader$uo_p_magnifier.sru
forward
global type uo_p_magnifier from uo_p_base
end type
end forward

global type uo_p_magnifier from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\find\magnifier.png"
end type
global uo_p_magnifier uo_p_magnifier

on uo_p_magnifier.create
call super::create
end on

on uo_p_magnifier.destroy
call super::destroy
end on

