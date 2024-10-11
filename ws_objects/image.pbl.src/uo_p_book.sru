$PBExportHeader$uo_p_book.sru
forward
global type uo_p_book from uo_p_base
end type
end forward

global type uo_p_book from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\address\book.png"
end type
global uo_p_book uo_p_book

on uo_p_book.create
call super::create
end on

on uo_p_book.destroy
call super::destroy
end on

