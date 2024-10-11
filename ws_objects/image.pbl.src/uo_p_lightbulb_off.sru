$PBExportHeader$uo_p_lightbulb_off.sru
forward
global type uo_p_lightbulb_off from uo_p_base
end type
end forward

global type uo_p_lightbulb_off from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\lightbulb_off.png"
end type
global uo_p_lightbulb_off uo_p_lightbulb_off

on uo_p_lightbulb_off.create
call super::create
end on

on uo_p_lightbulb_off.destroy
call super::destroy
end on

