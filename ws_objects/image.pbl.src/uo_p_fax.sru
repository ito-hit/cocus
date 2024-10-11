$PBExportHeader$uo_p_fax.sru
forward
global type uo_p_fax from uo_p_base
end type
end forward

global type uo_p_fax from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\fax.png"
end type
global uo_p_fax uo_p_fax

on uo_p_fax.create
call super::create
end on

on uo_p_fax.destroy
call super::destroy
end on

