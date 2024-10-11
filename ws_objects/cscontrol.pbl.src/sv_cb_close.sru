$PBExportHeader$sv_cb_close.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（終了ボタン設定済）
forward
global type sv_cb_close from ivo_commandbutton
end type
end forward

global type sv_cb_close from ivo_commandbutton
integer width = 380
string text = "終 了"
boolean confirm_enabled = true
boolean cmdb_close = true
end type
global sv_cb_close sv_cb_close

on sv_cb_close.create
call super::create
end on

on sv_cb_close.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_close"


end event

