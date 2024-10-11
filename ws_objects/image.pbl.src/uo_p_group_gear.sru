$PBExportHeader$uo_p_group_gear.sru
forward
global type uo_p_group_gear from uo_p_base
end type
end forward

global type uo_p_group_gear from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\user\group_gear.png"
end type
global uo_p_group_gear uo_p_group_gear

on uo_p_group_gear.create
call super::create
end on

on uo_p_group_gear.destroy
call super::destroy
end on

