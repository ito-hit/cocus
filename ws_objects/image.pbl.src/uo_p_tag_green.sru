$PBExportHeader$uo_p_tag_green.sru
forward
global type uo_p_tag_green from uo_p_base
end type
end forward

global type uo_p_tag_green from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\tag\tag_green.png"
end type
global uo_p_tag_green uo_p_tag_green

on uo_p_tag_green.create
call super::create
end on

on uo_p_tag_green.destroy
call super::destroy
end on

