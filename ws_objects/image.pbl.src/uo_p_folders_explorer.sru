$PBExportHeader$uo_p_folders_explorer.sru
forward
global type uo_p_folders_explorer from uo_p_base
end type
end forward

global type uo_p_folders_explorer from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\folder\folders_explorer.png"
end type
global uo_p_folders_explorer uo_p_folders_explorer

on uo_p_folders_explorer.create
call super::create
end on

on uo_p_folders_explorer.destroy
call super::destroy
end on

