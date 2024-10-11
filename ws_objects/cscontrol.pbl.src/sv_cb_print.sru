$PBExportHeader$sv_cb_print.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（印刷ボタン設定済）
forward
global type sv_cb_print from ivo_commandbutton
end type
end forward

global type sv_cb_print from ivo_commandbutton
integer width = 380
string text = "印 刷"
boolean cmdb_print = true
end type
global sv_cb_print sv_cb_print

on sv_cb_print.create
call super::create
end on

on sv_cb_print.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_print"


end event

