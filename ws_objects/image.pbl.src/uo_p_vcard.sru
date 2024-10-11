$PBExportHeader$uo_p_vcard.sru
forward
global type uo_p_vcard from uo_p_base
end type
end forward

global type uo_p_vcard from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\user\vcard.png"
end type
global uo_p_vcard uo_p_vcard

on uo_p_vcard.create
call super::create
end on

on uo_p_vcard.destroy
call super::destroy
end on

