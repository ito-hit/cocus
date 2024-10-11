$PBExportHeader$uo_p_marketwatch.sru
forward
global type uo_p_marketwatch from uo_p_base
end type
end forward

global type uo_p_marketwatch from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\marketwatch.png"
end type
global uo_p_marketwatch uo_p_marketwatch

on uo_p_marketwatch.create
call super::create
end on

on uo_p_marketwatch.destroy
call super::destroy
end on

