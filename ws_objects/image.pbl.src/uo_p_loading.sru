$PBExportHeader$uo_p_loading.sru
forward
global type uo_p_loading from uo_p_base
end type
end forward

global type uo_p_loading from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loading.gif"
end type
global uo_p_loading uo_p_loading

on uo_p_loading.create
call super::create
end on

on uo_p_loading.destroy
call super::destroy
end on

