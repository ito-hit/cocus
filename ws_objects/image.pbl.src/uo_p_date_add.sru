$PBExportHeader$uo_p_date_add.sru
forward
global type uo_p_date_add from uo_p_base
end type
end forward

global type uo_p_date_add from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\calendar\date_add.png"
end type
global uo_p_date_add uo_p_date_add

on uo_p_date_add.create
call super::create
end on

on uo_p_date_add.destroy
call super::destroy
end on

