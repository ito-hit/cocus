$PBExportHeader$uo_p_email_inbox.sru
forward
global type uo_p_email_inbox from uo_p_base
end type
end forward

global type uo_p_email_inbox from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_inbox.png"
end type
global uo_p_email_inbox uo_p_email_inbox

on uo_p_email_inbox.create
call super::create
end on

on uo_p_email_inbox.destroy
call super::destroy
end on

