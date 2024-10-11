$PBExportHeader$uo_p_clock_history_frame.sru
forward
global type uo_p_clock_history_frame from uo_p_base
end type
end forward

global type uo_p_clock_history_frame from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\clock_history_frame.png"
end type
global uo_p_clock_history_frame uo_p_clock_history_frame

on uo_p_clock_history_frame.create
call super::create
end on

on uo_p_clock_history_frame.destroy
call super::destroy
end on

