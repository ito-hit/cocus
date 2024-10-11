$PBExportHeader$sv_cb_menu_button.sru
$PBExportComments$コマンドボタンコントロールの先祖オブジェクト（サイズ設定のみ開発用メニュー向け）
forward
global type sv_cb_menu_button from ivo_commandbutton
end type
end forward

global type sv_cb_menu_button from ivo_commandbutton
integer width = 700
integer textsize = -12
end type
global sv_cb_menu_button sv_cb_menu_button

on sv_cb_menu_button.create
call super::create
end on

on sv_cb_menu_button.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "cb_menu_button"


end event

