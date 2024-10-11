$PBExportHeader$sv_cb_retrieve.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（表示ボタン設定済）
forward
global type sv_cb_retrieve from ivo_commandbutton
end type
end forward

global type sv_cb_retrieve from ivo_commandbutton
integer width = 380
string text = "表 示"
boolean cmdb_retrieve = true
end type
global sv_cb_retrieve sv_cb_retrieve

on sv_cb_retrieve.create
call super::create
end on

on sv_cb_retrieve.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_retrieve"


end event

