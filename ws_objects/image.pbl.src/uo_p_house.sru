$PBExportHeader$uo_p_house.sru
forward
global type uo_p_house from uo_p_base
end type
end forward

global type uo_p_house from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\house.png"
end type
global uo_p_house uo_p_house

on uo_p_house.create
call super::create
end on

on uo_p_house.destroy
call super::destroy
end on

