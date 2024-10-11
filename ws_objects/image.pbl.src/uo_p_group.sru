$PBExportHeader$uo_p_group.sru
forward
global type uo_p_group from uo_p_base
end type
end forward

global type uo_p_group from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\user\group.png"
end type
global uo_p_group uo_p_group

on uo_p_group.create
call super::create
end on

on uo_p_group.destroy
call super::destroy
end on

