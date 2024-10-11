$PBExportHeader$uo_p_connect.sru
forward
global type uo_p_connect from uo_p_base
end type
end forward

global type uo_p_connect from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\connect.png"
end type
global uo_p_connect uo_p_connect

on uo_p_connect.create
call super::create
end on

on uo_p_connect.destroy
call super::destroy
end on

