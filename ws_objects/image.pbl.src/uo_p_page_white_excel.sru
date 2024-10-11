$PBExportHeader$uo_p_page_white_excel.sru
forward
global type uo_p_page_white_excel from uo_p_base
end type
end forward

global type uo_p_page_white_excel from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\page_white_excel.png"
end type
global uo_p_page_white_excel uo_p_page_white_excel

on uo_p_page_white_excel.create
call super::create
end on

on uo_p_page_white_excel.destroy
call super::destroy
end on

