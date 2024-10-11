$PBExportHeader$uo_p_exclamation.sru
forward
global type uo_p_exclamation from uo_p_base
end type
end forward

global type uo_p_exclamation from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\exclamation.png"
end type
global uo_p_exclamation uo_p_exclamation

on uo_p_exclamation.create
call super::create
end on

on uo_p_exclamation.destroy
call super::destroy
end on

