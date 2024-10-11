$PBExportHeader$uo_p_computer.sru
forward
global type uo_p_computer from uo_p_base
end type
end forward

global type uo_p_computer from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\computer.png"
end type
global uo_p_computer uo_p_computer

on uo_p_computer.create
call super::create
end on

on uo_p_computer.destroy
call super::destroy
end on

