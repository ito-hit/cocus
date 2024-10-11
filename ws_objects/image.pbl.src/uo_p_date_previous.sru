$PBExportHeader$uo_p_date_previous.sru
forward
global type uo_p_date_previous from uo_p_base
end type
end forward

global type uo_p_date_previous from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\date_previous.png"
end type
global uo_p_date_previous uo_p_date_previous

on uo_p_date_previous.create
call super::create
end on

on uo_p_date_previous.destroy
call super::destroy
end on

