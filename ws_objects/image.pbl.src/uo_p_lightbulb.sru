$PBExportHeader$uo_p_lightbulb.sru
forward
global type uo_p_lightbulb from uo_p_base
end type
end forward

global type uo_p_lightbulb from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\lightbulb.png"
end type
global uo_p_lightbulb uo_p_lightbulb

on uo_p_lightbulb.create
call super::create
end on

on uo_p_lightbulb.destroy
call super::destroy
end on

