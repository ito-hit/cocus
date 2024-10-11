$PBExportHeader$uo_p_tick.sru
forward
global type uo_p_tick from uo_p_base
end type
end forward

global type uo_p_tick from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\tick.png"
end type
global uo_p_tick uo_p_tick

on uo_p_tick.create
call super::create
end on

on uo_p_tick.destroy
call super::destroy
end on

