$PBExportHeader$uo_p_tag_pink.sru
forward
global type uo_p_tag_pink from uo_p_base
end type
end forward

global type uo_p_tag_pink from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\tag\tag_pink.png"
end type
global uo_p_tag_pink uo_p_tag_pink

on uo_p_tag_pink.create
call super::create
end on

on uo_p_tag_pink.destroy
call super::destroy
end on

