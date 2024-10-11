$PBExportHeader$uo_p_setting_tools.sru
forward
global type uo_p_setting_tools from uo_p_base
end type
end forward

global type uo_p_setting_tools from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\setting_tools.png"
end type
global uo_p_setting_tools uo_p_setting_tools

on uo_p_setting_tools.create
call super::create
end on

on uo_p_setting_tools.destroy
call super::destroy
end on

