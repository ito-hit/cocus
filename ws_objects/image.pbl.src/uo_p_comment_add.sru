$PBExportHeader$uo_p_comment_add.sru
forward
global type uo_p_comment_add from uo_p_base
end type
end forward

global type uo_p_comment_add from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\comment_add.png"
end type
global uo_p_comment_add uo_p_comment_add

on uo_p_comment_add.create
call super::create
end on

on uo_p_comment_add.destroy
call super::destroy
end on

