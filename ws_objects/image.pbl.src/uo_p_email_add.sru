$PBExportHeader$uo_p_email_add.sru
forward
global type uo_p_email_add from uo_p_base
end type
end forward

global type uo_p_email_add from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_add.png"
end type
global uo_p_email_add uo_p_email_add

on uo_p_email_add.create
call super::create
end on

on uo_p_email_add.destroy
call super::destroy
end on

