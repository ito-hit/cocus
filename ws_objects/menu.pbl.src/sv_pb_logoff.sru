$PBExportHeader$sv_pb_logoff.sru
$PBExportComments$メニュー画面で使用するピクチャボタン（ログオフ）
forward
global type sv_pb_logoff from ivo_picturebutton
end type
end forward

global type sv_pb_logoff from ivo_picturebutton
integer width = 660
integer height = 132
string text = "  ログオフ"
boolean originalsize = false
string picturename = "image\pbn_icon\pbn_rearrange_account.png"
end type
global sv_pb_logoff sv_pb_logoff

on sv_pb_logoff.create
call super::create
end on

on sv_pb_logoff.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "pb_logoff"


end event

