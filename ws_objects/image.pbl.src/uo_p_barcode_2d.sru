$PBExportHeader$uo_p_barcode_2d.sru
forward
global type uo_p_barcode_2d from uo_p_base
end type
end forward

global type uo_p_barcode_2d from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\barcode\barcode_2d.png"
end type
global uo_p_barcode_2d uo_p_barcode_2d

on uo_p_barcode_2d.create
call super::create
end on

on uo_p_barcode_2d.destroy
call super::destroy
end on

