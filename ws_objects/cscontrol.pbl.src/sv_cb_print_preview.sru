$PBExportHeader$sv_cb_print_preview.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（印刷プレビューボタン設定済）
forward
global type sv_cb_print_preview from ivo_commandbutton
end type
end forward

global type sv_cb_print_preview from ivo_commandbutton
integer width = 380
string text = "プレビュー"
boolean cmdb_preview = true
end type
global sv_cb_print_preview sv_cb_print_preview

on sv_cb_print_preview.create
call super::create
end on

on sv_cb_print_preview.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_print_preview"


end event

