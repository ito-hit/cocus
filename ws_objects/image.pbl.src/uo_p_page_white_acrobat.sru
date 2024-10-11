$PBExportHeader$uo_p_page_white_acrobat.sru
forward
global type uo_p_page_white_acrobat from uo_p_base
end type
end forward

global type uo_p_page_white_acrobat from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\page_white_acrobat.png"
end type
global uo_p_page_white_acrobat uo_p_page_white_acrobat

on uo_p_page_white_acrobat.create
call super::create
end on

on uo_p_page_white_acrobat.destroy
call super::destroy
end on

