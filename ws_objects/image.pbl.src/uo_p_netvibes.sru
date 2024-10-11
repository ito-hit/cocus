$PBExportHeader$uo_p_netvibes.sru
forward
global type uo_p_netvibes from uo_p_base
end type
end forward

global type uo_p_netvibes from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\netvibes.png"
end type
global uo_p_netvibes uo_p_netvibes

on uo_p_netvibes.create
call super::create
end on

on uo_p_netvibes.destroy
call super::destroy
end on

