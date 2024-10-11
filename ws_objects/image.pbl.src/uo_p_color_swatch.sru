$PBExportHeader$uo_p_color_swatch.sru
forward
global type uo_p_color_swatch from uo_p_base
end type
end forward

global type uo_p_color_swatch from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\paint\color_swatch.png"
end type
global uo_p_color_swatch uo_p_color_swatch

on uo_p_color_swatch.create
call super::create
end on

on uo_p_color_swatch.destroy
call super::destroy
end on

