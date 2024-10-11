$PBExportHeader$uo_p_file_extension_jpg.sru
forward
global type uo_p_file_extension_jpg from uo_p_base
end type
end forward

global type uo_p_file_extension_jpg from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\file_extension_jpg.png"
end type
global uo_p_file_extension_jpg uo_p_file_extension_jpg

on uo_p_file_extension_jpg.create
call super::create
end on

on uo_p_file_extension_jpg.destroy
call super::destroy
end on

