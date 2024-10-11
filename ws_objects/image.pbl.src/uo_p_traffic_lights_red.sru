$PBExportHeader$uo_p_traffic_lights_red.sru
forward
global type uo_p_traffic_lights_red from uo_p_base
end type
end forward

global type uo_p_traffic_lights_red from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\traffic_lights_red.png"
end type
global uo_p_traffic_lights_red uo_p_traffic_lights_red

on uo_p_traffic_lights_red.create
call super::create
end on

on uo_p_traffic_lights_red.destroy
call super::destroy
end on

