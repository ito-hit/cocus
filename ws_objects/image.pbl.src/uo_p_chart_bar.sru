$PBExportHeader$uo_p_chart_bar.sru
forward
global type uo_p_chart_bar from uo_p_base
end type
end forward

global type uo_p_chart_bar from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\chart_bar.png"
end type
global uo_p_chart_bar uo_p_chart_bar

on uo_p_chart_bar.create
call super::create
end on

on uo_p_chart_bar.destroy
call super::destroy
end on

