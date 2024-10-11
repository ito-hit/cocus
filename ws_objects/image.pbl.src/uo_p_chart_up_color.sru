$PBExportHeader$uo_p_chart_up_color.sru
forward
global type uo_p_chart_up_color from uo_p_base
end type
end forward

global type uo_p_chart_up_color from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\chart_up_color.png"
end type
global uo_p_chart_up_color uo_p_chart_up_color

on uo_p_chart_up_color.create
call super::create
end on

on uo_p_chart_up_color.destroy
call super::destroy
end on

