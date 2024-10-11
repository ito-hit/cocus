$PBExportHeader$uo_p_calendar_add.sru
forward
global type uo_p_calendar_add from uo_p_base
end type
end forward

global type uo_p_calendar_add from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\calendar_add.png"
end type
global uo_p_calendar_add uo_p_calendar_add

on uo_p_calendar_add.create
call super::create
end on

on uo_p_calendar_add.destroy
call super::destroy
end on

