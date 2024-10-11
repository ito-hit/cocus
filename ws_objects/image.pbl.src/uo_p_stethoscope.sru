$PBExportHeader$uo_p_stethoscope.sru
forward
global type uo_p_stethoscope from uo_p_base
end type
end forward

global type uo_p_stethoscope from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\stethoscope.png"
end type
global uo_p_stethoscope uo_p_stethoscope

on uo_p_stethoscope.create
call super::create
end on

on uo_p_stethoscope.destroy
call super::destroy
end on

