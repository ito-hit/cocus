$PBExportHeader$uo_p_progressbar.sru
forward
global type uo_p_progressbar from uo_p_base
end type
end forward

global type uo_p_progressbar from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\system\progressbar.png"
end type
global uo_p_progressbar uo_p_progressbar

on uo_p_progressbar.create
call super::create
end on

on uo_p_progressbar.destroy
call super::destroy
end on

