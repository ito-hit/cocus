$PBExportHeader$uo_p_group_delete.sru
forward
global type uo_p_group_delete from uo_p_base
end type
end forward

global type uo_p_group_delete from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\user\group_delete.png"
end type
global uo_p_group_delete uo_p_group_delete

on uo_p_group_delete.create
call super::create
end on

on uo_p_group_delete.destroy
call super::destroy
end on

