$PBExportHeader$uo_p_events.sru
forward
global type uo_p_events from uo_p_base
end type
end forward

global type uo_p_events from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\events.png"
end type
global uo_p_events uo_p_events

on uo_p_events.create
call super::create
end on

on uo_p_events.destroy
call super::destroy
end on

