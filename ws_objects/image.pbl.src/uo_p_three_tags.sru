$PBExportHeader$uo_p_three_tags.sru
forward
global type uo_p_three_tags from uo_p_base
end type
end forward

global type uo_p_three_tags from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\tag\three_tags.png"
end type
global uo_p_three_tags uo_p_three_tags

on uo_p_three_tags.create
call super::create
end on

on uo_p_three_tags.destroy
call super::destroy
end on

