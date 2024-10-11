$PBExportHeader$uo_p_next_comment.sru
forward
global type uo_p_next_comment from uo_p_base
end type
end forward

global type uo_p_next_comment from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\next_comment.png"
end type
global uo_p_next_comment uo_p_next_comment

on uo_p_next_comment.create
call super::create
end on

on uo_p_next_comment.destroy
call super::destroy
end on

