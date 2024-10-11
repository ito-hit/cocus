$PBExportHeader$uo_p_door_in.sru
forward
global type uo_p_door_in from uo_p_base
end type
end forward

global type uo_p_door_in from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\door_in.png"
end type
global uo_p_door_in uo_p_door_in

on uo_p_door_in.create
call super::create
end on

on uo_p_door_in.destroy
call super::destroy
end on

