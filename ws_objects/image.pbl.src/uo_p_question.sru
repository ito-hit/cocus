$PBExportHeader$uo_p_question.sru
forward
global type uo_p_question from uo_p_base
end type
end forward

global type uo_p_question from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\question.png"
end type
global uo_p_question uo_p_question

on uo_p_question.create
call super::create
end on

on uo_p_question.destroy
call super::destroy
end on

