$PBExportHeader$uo_p_traffic_lights.sru
forward
global type uo_p_traffic_lights from uo_p_base
end type
end forward

global type uo_p_traffic_lights from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\traffic_lights.png"
end type
global uo_p_traffic_lights uo_p_traffic_lights

on uo_p_traffic_lights.create
call super::create
end on

on uo_p_traffic_lights.destroy
call super::destroy
end on

