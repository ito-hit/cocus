$PBExportHeader$uo_p_comments_delete.sru
forward
global type uo_p_comments_delete from uo_p_base
end type
end forward

global type uo_p_comments_delete from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\message\comments_delete.png"
end type
global uo_p_comments_delete uo_p_comments_delete

on uo_p_comments_delete.create
call super::create
end on

on uo_p_comments_delete.destroy
call super::destroy
end on

