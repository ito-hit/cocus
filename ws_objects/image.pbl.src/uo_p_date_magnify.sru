$PBExportHeader$uo_p_date_magnify.sru
forward
global type uo_p_date_magnify from uo_p_base
end type
end forward

global type uo_p_date_magnify from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\date_magnify.png"
end type
global uo_p_date_magnify uo_p_date_magnify

on uo_p_date_magnify.create
call super::create
end on

on uo_p_date_magnify.destroy
call super::destroy
end on

