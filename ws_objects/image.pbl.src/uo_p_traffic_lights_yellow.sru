$PBExportHeader$uo_p_traffic_lights_yellow.sru
forward
global type uo_p_traffic_lights_yellow from uo_p_base
end type
end forward

global type uo_p_traffic_lights_yellow from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\signal\traffic_lights_yellow.png"
end type
global uo_p_traffic_lights_yellow uo_p_traffic_lights_yellow

on uo_p_traffic_lights_yellow.create
call super::create
end on

on uo_p_traffic_lights_yellow.destroy
call super::destroy
end on

