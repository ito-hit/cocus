$PBExportHeader$uo_p_lightning.sru
forward
global type uo_p_lightning from uo_p_base
end type
end forward

global type uo_p_lightning from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\lightning.png"
end type
global uo_p_lightning uo_p_lightning

on uo_p_lightning.create
call super::create
end on

on uo_p_lightning.destroy
call super::destroy
end on

