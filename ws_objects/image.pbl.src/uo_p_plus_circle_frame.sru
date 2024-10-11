$PBExportHeader$uo_p_plus_circle_frame.sru
forward
global type uo_p_plus_circle_frame from uo_p_base
end type
end forward

global type uo_p_plus_circle_frame from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\plus_circle_frame.png"
end type
global uo_p_plus_circle_frame uo_p_plus_circle_frame

on uo_p_plus_circle_frame.create
call super::create
end on

on uo_p_plus_circle_frame.destroy
call super::destroy
end on

