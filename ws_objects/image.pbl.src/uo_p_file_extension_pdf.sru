$PBExportHeader$uo_p_file_extension_pdf.sru
forward
global type uo_p_file_extension_pdf from uo_p_base
end type
end forward

global type uo_p_file_extension_pdf from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\file_extension_pdf.png"
end type
global uo_p_file_extension_pdf uo_p_file_extension_pdf

on uo_p_file_extension_pdf.create
call super::create
end on

on uo_p_file_extension_pdf.destroy
call super::destroy
end on

