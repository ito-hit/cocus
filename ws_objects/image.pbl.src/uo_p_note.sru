$PBExportHeader$uo_p_note.sru
forward
global type uo_p_note from uo_p_base
end type
end forward

global type uo_p_note from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\memo\note.png"
end type
global uo_p_note uo_p_note

on uo_p_note.create
call super::create
end on

on uo_p_note.destroy
call super::destroy
end on

