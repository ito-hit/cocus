$PBExportHeader$uo_p_chart_curve.sru
forward
global type uo_p_chart_curve from uo_p_base
end type
end forward

global type uo_p_chart_curve from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\graph\chart_curve.png"
end type
global uo_p_chart_curve uo_p_chart_curve

on uo_p_chart_curve.create
call super::create
end on

on uo_p_chart_curve.destroy
call super::destroy
end on

