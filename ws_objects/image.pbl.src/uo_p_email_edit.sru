$PBExportHeader$uo_p_email_edit.sru
forward
global type uo_p_email_edit from uo_p_base
end type
end forward

global type uo_p_email_edit from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_edit.png"
end type
global uo_p_email_edit uo_p_email_edit

on uo_p_email_edit.create
call super::create
end on

on uo_p_email_edit.destroy
call super::destroy
end on

