$PBExportHeader$uo_p_flashdisk_logo.sru
forward
global type uo_p_flashdisk_logo from uo_p_base
end type
end forward

global type uo_p_flashdisk_logo from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\flashdisk_logo.png"
end type
global uo_p_flashdisk_logo uo_p_flashdisk_logo

on uo_p_flashdisk_logo.create
call super::create
end on

on uo_p_flashdisk_logo.destroy
call super::destroy
end on

