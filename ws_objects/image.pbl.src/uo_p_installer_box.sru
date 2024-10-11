$PBExportHeader$uo_p_installer_box.sru
forward
global type uo_p_installer_box from uo_p_base
end type
end forward

global type uo_p_installer_box from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\installer_box.png"
end type
global uo_p_installer_box uo_p_installer_box

on uo_p_installer_box.create
call super::create
end on

on uo_p_installer_box.destroy
call super::destroy
end on

