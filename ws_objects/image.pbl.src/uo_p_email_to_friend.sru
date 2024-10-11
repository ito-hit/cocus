$PBExportHeader$uo_p_email_to_friend.sru
forward
global type uo_p_email_to_friend from uo_p_base
end type
end forward

global type uo_p_email_to_friend from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_to_friend.png"
end type
global uo_p_email_to_friend uo_p_email_to_friend

on uo_p_email_to_friend.create
call super::create
end on

on uo_p_email_to_friend.destroy
call super::destroy
end on

