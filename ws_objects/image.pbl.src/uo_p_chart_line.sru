$PBExportHeader$uo_p_chart_line.sru
forward
global type uo_p_chart_line from uo_p_base
end type
end forward

global type uo_p_chart_line from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\chart_line.png"
end type
global uo_p_chart_line uo_p_chart_line

on uo_p_chart_line.create
call super::create
end on

on uo_p_chart_line.destroy
call super::destroy
end on

