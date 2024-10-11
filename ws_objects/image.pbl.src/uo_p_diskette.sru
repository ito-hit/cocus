$PBExportHeader$uo_p_diskette.sru
forward
global type uo_p_diskette from uo_p_base
end type
end forward

global type uo_p_diskette from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loadsave\diskette.png"
end type
global uo_p_diskette uo_p_diskette

on uo_p_diskette.create
call super::create
end on

on uo_p_diskette.destroy
call super::destroy
end on

