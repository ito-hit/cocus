$PBExportHeader$uo_p_chart_pie_title.sru
forward
global type uo_p_chart_pie_title from uo_p_base
end type
end forward

global type uo_p_chart_pie_title from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\chart_pie_title.png"
end type
global uo_p_chart_pie_title uo_p_chart_pie_title

on uo_p_chart_pie_title.create
call super::create
end on

on uo_p_chart_pie_title.destroy
call super::destroy
end on

