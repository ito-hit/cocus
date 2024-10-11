$PBExportHeader$uo_p_file_save_as.sru
forward
global type uo_p_file_save_as from uo_p_base
end type
end forward

global type uo_p_file_save_as from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loadsave\file_save_as.png"
end type
global uo_p_file_save_as uo_p_file_save_as

on uo_p_file_save_as.create
call super::create
end on

on uo_p_file_save_as.destroy
call super::destroy
end on

