$PBExportHeader$uo_p_information.sru
forward
global type uo_p_information from uo_p_base
end type
end forward

global type uo_p_information from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\information.png"
end type
global uo_p_information uo_p_information

on uo_p_information.create
call super::create
end on

on uo_p_information.destroy
call super::destroy
end on

