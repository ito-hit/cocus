$PBExportHeader$uo_p_monitor.sru
forward
global type uo_p_monitor from uo_p_base
end type
end forward

global type uo_p_monitor from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\monitor.png"
end type
global uo_p_monitor uo_p_monitor

on uo_p_monitor.create
call super::create
end on

on uo_p_monitor.destroy
call super::destroy
end on

