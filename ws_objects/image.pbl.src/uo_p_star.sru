$PBExportHeader$uo_p_star.sru
forward
global type uo_p_star from uo_p_base
end type
end forward

global type uo_p_star from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\star.png"
end type
global uo_p_star uo_p_star

on uo_p_star.create
call super::create
end on

on uo_p_star.destroy
call super::destroy
end on

