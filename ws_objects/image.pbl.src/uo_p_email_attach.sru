$PBExportHeader$uo_p_email_attach.sru
forward
global type uo_p_email_attach from uo_p_base
end type
end forward

global type uo_p_email_attach from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_attach.png"
end type
global uo_p_email_attach uo_p_email_attach

on uo_p_email_attach.create
call super::create
end on

on uo_p_email_attach.destroy
call super::destroy
end on

