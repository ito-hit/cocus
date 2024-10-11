$PBExportHeader$sv_pb_exit.sru
$PBExportComments$メニュー画面で使用するピクチャボタン（終了）
forward
global type sv_pb_exit from ivo_picturebutton
end type
end forward

global type sv_pb_exit from ivo_picturebutton
integer width = 660
integer height = 132
string text = "  終  了"
boolean originalsize = false
string picturename = "image\pbn_icon\pbn_cross.png"
boolean confirm_enabled = true
boolean cmdb_close = true
end type
global sv_pb_exit sv_pb_exit

on sv_pb_exit.create
call super::create
end on

on sv_pb_exit.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "pb_exit"


end event

