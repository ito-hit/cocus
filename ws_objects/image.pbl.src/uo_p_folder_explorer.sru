$PBExportHeader$uo_p_folder_explorer.sru
forward
global type uo_p_folder_explorer from uo_p_base
end type
end forward

global type uo_p_folder_explorer from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\folder\folder_explorer.png"
end type
global uo_p_folder_explorer uo_p_folder_explorer

on uo_p_folder_explorer.create
call super::create
end on

on uo_p_folder_explorer.destroy
call super::destroy
end on

