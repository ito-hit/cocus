$PBExportHeader$uo_p_key.sru
forward
global type uo_p_key from uo_p_base
end type
end forward

global type uo_p_key from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\lock\key.png"
end type
global uo_p_key uo_p_key

on uo_p_key.create
call super::create
end on

on uo_p_key.destroy
call super::destroy
end on

