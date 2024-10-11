$PBExportHeader$uo_p_calendar.sru
forward
global type uo_p_calendar from uo_p_base
end type
end forward

global type uo_p_calendar from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\calendar.png"
end type
global uo_p_calendar uo_p_calendar

on uo_p_calendar.create
call super::create
end on

on uo_p_calendar.destroy
call super::destroy
end on

