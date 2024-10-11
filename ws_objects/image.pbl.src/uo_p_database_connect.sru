$PBExportHeader$uo_p_database_connect.sru
forward
global type uo_p_database_connect from uo_p_base
end type
end forward

global type uo_p_database_connect from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\database_connect.png"
end type
global uo_p_database_connect uo_p_database_connect

on uo_p_database_connect.create
call super::create
end on

on uo_p_database_connect.destroy
call super::destroy
end on

