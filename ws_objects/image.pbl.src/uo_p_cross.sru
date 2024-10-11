$PBExportHeader$uo_p_cross.sru
forward
global type uo_p_cross from uo_p_base
end type
end forward

global type uo_p_cross from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\cross.png"
end type
global uo_p_cross uo_p_cross

on uo_p_cross.create
call super::create
end on

on uo_p_cross.destroy
call super::destroy
end on

