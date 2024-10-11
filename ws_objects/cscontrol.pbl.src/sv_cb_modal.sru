$PBExportHeader$sv_cb_modal.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（モーダール表示ボタン設定済）
forward
global type sv_cb_modal from ivo_commandbutton
end type
end forward

global type sv_cb_modal from ivo_commandbutton
integer width = 112
string text = "･･･"
end type
global sv_cb_modal sv_cb_modal

on sv_cb_modal.create
call super::create
end on

on sv_cb_modal.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_modal"


end event

