$PBExportHeader$uo_p_error.sru
forward
global type uo_p_error from uo_p_base
end type
end forward

global type uo_p_error from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\error.png"
end type
global uo_p_error uo_p_error

on uo_p_error.create
call super::create
end on

on uo_p_error.destroy
call super::destroy
end on

