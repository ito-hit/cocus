$PBExportHeader$uo_p_email_go.sru
forward
global type uo_p_email_go from uo_p_base
end type
end forward

global type uo_p_email_go from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\mail\email_go.png"
end type
global uo_p_email_go uo_p_email_go

on uo_p_email_go.create
call super::create
end on

on uo_p_email_go.destroy
call super::destroy
end on

