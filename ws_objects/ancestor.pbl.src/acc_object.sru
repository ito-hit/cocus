$PBExportHeader$acc_object.sru
$PBExportComments$カスタムクラスの始祖オブジェクト
forward
global type acc_object from nonvisualobject
end type
end forward

global type acc_object from nonvisualobject
end type
global acc_object acc_object

type variables
boolean	on_alert_msg, on_alert_log, on_debug

acc_txtlog	txtlog
end variables

on acc_object.create
call super::create
TriggerEvent( this, "constructor" )
end on

on acc_object.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//コンストラクタ
txtlog	= create acc_txtlog

txtlog.on_alert_msg	= on_alert_msg
txtlog.on_alert_log	= on_alert_log
txtlog.on_debug		= on_debug

end event

event destructor;//デストラクタ
destroy txtlog
end event

