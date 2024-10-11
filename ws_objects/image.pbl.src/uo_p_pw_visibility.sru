$PBExportHeader$uo_p_pw_visibility.sru
forward
global type uo_p_pw_visibility from uo_p_base
end type
end forward

global type uo_p_pw_visibility from uo_p_base
integer width = 100
integer height = 60
integer transparency = 50
boolean originalsize = false
string picturename = "image\pw_visibility.png"
end type
global uo_p_pw_visibility uo_p_pw_visibility

on uo_p_pw_visibility.create
call super::create
end on

on uo_p_pw_visibility.destroy
call super::destroy
end on

