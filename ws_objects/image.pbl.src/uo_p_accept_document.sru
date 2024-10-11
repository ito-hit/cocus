$PBExportHeader$uo_p_accept_document.sru
forward
global type uo_p_accept_document from uo_p_base
end type
end forward

global type uo_p_accept_document from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\file\accept_document.png"
end type
global uo_p_accept_document uo_p_accept_document

on uo_p_accept_document.create
call super::create
end on

on uo_p_accept_document.destroy
call super::destroy
end on

