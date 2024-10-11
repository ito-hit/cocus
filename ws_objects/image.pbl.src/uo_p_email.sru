$PBExportHeader$uo_p_email.sru
forward
global type uo_p_email from uo_p_base
end type
end forward

global type uo_p_email from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email.png"
end type
global uo_p_email uo_p_email

on uo_p_email.create
call super::create
end on

on uo_p_email.destroy
call super::destroy
end on

