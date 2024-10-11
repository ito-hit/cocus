$PBExportHeader$uo_p_saved_exports.sru
forward
global type uo_p_saved_exports from uo_p_base
end type
end forward

global type uo_p_saved_exports from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loadsave\saved_exports.png"
end type
global uo_p_saved_exports uo_p_saved_exports

on uo_p_saved_exports.create
call super::create
end on

on uo_p_saved_exports.destroy
call super::destroy
end on

