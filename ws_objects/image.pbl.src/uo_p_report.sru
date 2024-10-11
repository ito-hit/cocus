$PBExportHeader$uo_p_report.sru
forward
global type uo_p_report from uo_p_base
end type
end forward

global type uo_p_report from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\report.png"
end type
global uo_p_report uo_p_report

on uo_p_report.create
call super::create
end on

on uo_p_report.destroy
call super::destroy
end on

