$PBExportHeader$uo_p_comments.sru
forward
global type uo_p_comments from uo_p_base
end type
end forward

global type uo_p_comments from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\comments.png"
end type
global uo_p_comments uo_p_comments

on uo_p_comments.create
call super::create
end on

on uo_p_comments.destroy
call super::destroy
end on

