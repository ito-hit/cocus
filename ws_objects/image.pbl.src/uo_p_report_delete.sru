$PBExportHeader$uo_p_report_delete.sru
forward
global type uo_p_report_delete from uo_p_base
end type
end forward

global type uo_p_report_delete from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\report_delete.png"
end type
global uo_p_report_delete uo_p_report_delete

on uo_p_report_delete.create
call super::create
end on

on uo_p_report_delete.destroy
call super::destroy
end on

