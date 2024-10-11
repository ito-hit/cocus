$PBExportHeader$uo_p_report_add.sru
forward
global type uo_p_report_add from uo_p_base
end type
end forward

global type uo_p_report_add from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\report_add.png"
end type
global uo_p_report_add uo_p_report_add

on uo_p_report_add.create
call super::create
end on

on uo_p_report_add.destroy
call super::destroy
end on

