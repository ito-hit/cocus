$PBExportHeader$uo_p_tag_orange.sru
forward
global type uo_p_tag_orange from uo_p_base
end type
end forward

global type uo_p_tag_orange from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\tag\tag_orange.png"
end type
global uo_p_tag_orange uo_p_tag_orange

on uo_p_tag_orange.create
call super::create
end on

on uo_p_tag_orange.destroy
call super::destroy
end on

