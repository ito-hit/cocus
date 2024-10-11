$PBExportHeader$uo_p_lock.sru
forward
global type uo_p_lock from uo_p_base
end type
end forward

global type uo_p_lock from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\lock\lock.png"
end type
global uo_p_lock uo_p_lock

on uo_p_lock.create
call super::create
end on

on uo_p_lock.destroy
call super::destroy
end on

