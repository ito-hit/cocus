$PBExportHeader$uo_p_sort_desc_az.sru
forward
global type uo_p_sort_desc_az from uo_p_base
end type
end forward

global type uo_p_sort_desc_az from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\sort\sort_desc_az.png"
end type
global uo_p_sort_desc_az uo_p_sort_desc_az

on uo_p_sort_desc_az.create
call super::create
end on

on uo_p_sort_desc_az.destroy
call super::destroy
end on

