$PBExportHeader$uo_p_barcode.sru
forward
global type uo_p_barcode from uo_p_base
end type
end forward

global type uo_p_barcode from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\barcode\barcode.png"
end type
global uo_p_barcode uo_p_barcode

on uo_p_barcode.create
call super::create
end on

on uo_p_barcode.destroy
call super::destroy
end on

