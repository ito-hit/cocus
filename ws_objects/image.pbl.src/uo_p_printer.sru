$PBExportHeader$uo_p_printer.sru
forward
global type uo_p_printer from uo_p_base
end type
end forward

global type uo_p_printer from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\printer\printer.png"
end type
global uo_p_printer uo_p_printer

on uo_p_printer.create
call super::create
end on

on uo_p_printer.destroy
call super::destroy
end on

