$PBExportHeader$uo_p_control_power_blue.sru
forward
global type uo_p_control_power_blue from uo_p_base
end type
end forward

global type uo_p_control_power_blue from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\control_power_blue.png"
end type
global uo_p_control_power_blue uo_p_control_power_blue

on uo_p_control_power_blue.create
call super::create
end on

on uo_p_control_power_blue.destroy
call super::destroy
end on

