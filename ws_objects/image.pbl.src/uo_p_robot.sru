$PBExportHeader$uo_p_robot.sru
forward
global type uo_p_robot from uo_p_base
end type
end forward

global type uo_p_robot from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\robot.png"
end type
global uo_p_robot uo_p_robot

on uo_p_robot.create
call super::create
end on

on uo_p_robot.destroy
call super::destroy
end on

