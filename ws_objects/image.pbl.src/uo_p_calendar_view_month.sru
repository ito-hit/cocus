$PBExportHeader$uo_p_calendar_view_month.sru
forward
global type uo_p_calendar_view_month from uo_p_base
end type
end forward

global type uo_p_calendar_view_month from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\calendar_view_month.png"
end type
global uo_p_calendar_view_month uo_p_calendar_view_month

on uo_p_calendar_view_month.create
call super::create
end on

on uo_p_calendar_view_month.destroy
call super::destroy
end on

