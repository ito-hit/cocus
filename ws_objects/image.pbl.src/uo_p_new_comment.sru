$PBExportHeader$uo_p_new_comment.sru
forward
global type uo_p_new_comment from uo_p_base
end type
end forward

global type uo_p_new_comment from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\new_comment.png"
end type
global uo_p_new_comment uo_p_new_comment

on uo_p_new_comment.create
call super::create
end on

on uo_p_new_comment.destroy
call super::destroy
end on

