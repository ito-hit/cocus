﻿$PBExportHeader$uo_p_note_edit.sru
forward
global type uo_p_note_edit from uo_p_base
end type
end forward

global type uo_p_note_edit from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\memo\note_edit.png"
end type
global uo_p_note_edit uo_p_note_edit

on uo_p_note_edit.create
call super::create
end on

on uo_p_note_edit.destroy
call super::destroy
end on
