$PBExportHeader$uo_p_saved_imports.sru
forward
global type uo_p_saved_imports from uo_p_base
end type
end forward

global type uo_p_saved_imports from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loadsave\saved_imports.png"
end type
global uo_p_saved_imports uo_p_saved_imports

on uo_p_saved_imports.create
call super::create
end on

on uo_p_saved_imports.destroy
call super::destroy
end on

