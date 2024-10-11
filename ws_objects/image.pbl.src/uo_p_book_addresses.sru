$PBExportHeader$uo_p_book_addresses.sru
forward
global type uo_p_book_addresses from uo_p_base
end type
end forward

global type uo_p_book_addresses from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\address\book_addresses.png"
end type
global uo_p_book_addresses uo_p_book_addresses

on uo_p_book_addresses.create
call super::create
end on

on uo_p_book_addresses.destroy
call super::destroy
end on

