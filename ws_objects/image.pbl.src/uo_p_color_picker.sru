$PBExportHeader$uo_p_color_picker.sru
forward
global type uo_p_color_picker from uo_p_base
end type
end forward

global type uo_p_color_picker from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\paint\color_picker.png"
end type
global uo_p_color_picker uo_p_color_picker

on uo_p_color_picker.create
call super::create
end on

on uo_p_color_picker.destroy
call super::destroy
end on

