$PBExportHeader$uo_p_date.sru
forward
global type uo_p_date from uo_p_base
end type
end forward

global type uo_p_date from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\date.png"
end type
global uo_p_date uo_p_date

on uo_p_date.create
call super::create
end on

on uo_p_date.destroy
call super::destroy
end on

