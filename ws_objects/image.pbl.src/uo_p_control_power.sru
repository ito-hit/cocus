$PBExportHeader$uo_p_control_power.sru
forward
global type uo_p_control_power from uo_p_base
end type
end forward

global type uo_p_control_power from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\control_power.png"
end type
global uo_p_control_power uo_p_control_power

on uo_p_control_power.create
call super::create
end on

on uo_p_control_power.destroy
call super::destroy
end on

