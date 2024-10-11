$PBExportHeader$uo_p_date_next.sru
forward
global type uo_p_date_next from uo_p_base
end type
end forward

global type uo_p_date_next from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\date_next.png"
end type
global uo_p_date_next uo_p_date_next

on uo_p_date_next.create
call super::create
end on

on uo_p_date_next.destroy
call super::destroy
end on

