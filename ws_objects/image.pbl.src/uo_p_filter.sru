$PBExportHeader$uo_p_filter.sru
forward
global type uo_p_filter from uo_p_base
end type
end forward

global type uo_p_filter from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\find\filter.png"
end type
global uo_p_filter uo_p_filter

on uo_p_filter.create
call super::create
end on

on uo_p_filter.destroy
call super::destroy
end on

