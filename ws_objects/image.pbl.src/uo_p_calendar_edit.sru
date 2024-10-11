$PBExportHeader$uo_p_calendar_edit.sru
forward
global type uo_p_calendar_edit from uo_p_base
end type
end forward

global type uo_p_calendar_edit from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\calendar_edit.png"
end type
global uo_p_calendar_edit uo_p_calendar_edit

on uo_p_calendar_edit.create
call super::create
end on

on uo_p_calendar_edit.destroy
call super::destroy
end on

