$PBExportHeader$uo_p_radiolocator.sru
forward
global type uo_p_radiolocator from uo_p_base
end type
end forward

global type uo_p_radiolocator from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\find\radiolocator.png"
end type
global uo_p_radiolocator uo_p_radiolocator

on uo_p_radiolocator.create
call super::create
end on

on uo_p_radiolocator.destroy
call super::destroy
end on

