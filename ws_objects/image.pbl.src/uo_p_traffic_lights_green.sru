$PBExportHeader$uo_p_traffic_lights_green.sru
forward
global type uo_p_traffic_lights_green from uo_p_base
end type
end forward

global type uo_p_traffic_lights_green from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\traffic_lights_green.png"
end type
global uo_p_traffic_lights_green uo_p_traffic_lights_green

on uo_p_traffic_lights_green.create
call super::create
end on

on uo_p_traffic_lights_green.destroy
call super::destroy
end on

