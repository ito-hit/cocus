$PBExportHeader$uo_p_file_extension_xls.sru
forward
global type uo_p_file_extension_xls from uo_p_base
end type
end forward

global type uo_p_file_extension_xls from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\file_extension_xls.png"
end type
global uo_p_file_extension_xls uo_p_file_extension_xls

on uo_p_file_extension_xls.create
call super::create
end on

on uo_p_file_extension_xls.destroy
call super::destroy
end on

