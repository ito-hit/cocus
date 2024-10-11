$PBExportHeader$sv_cb_update.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（実行ボタン設定済）
forward
global type sv_cb_update from ivo_commandbutton
end type
end forward

global type sv_cb_update from ivo_commandbutton
integer width = 380
string text = "更 新"
boolean confirm_enabled = true
boolean cmdb_update = true
end type
global sv_cb_update sv_cb_update

on sv_cb_update.create
call super::create
end on

on sv_cb_update.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_update"


end event

