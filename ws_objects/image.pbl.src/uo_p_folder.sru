$PBExportHeader$uo_p_folder.sru
forward
global type uo_p_folder from uo_p_base
end type
end forward

global type uo_p_folder from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\folder\folder.png"
end type
global uo_p_folder uo_p_folder

on uo_p_folder.create
call super::create
end on

on uo_p_folder.destroy
call super::destroy
end on

