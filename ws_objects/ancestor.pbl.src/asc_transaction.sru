$PBExportHeader$asc_transaction.sru
$PBExportComments$トランザクションオブジェクトの始祖オブジェクト
forward
global type asc_transaction from transaction
end type
end forward

global type asc_transaction from transaction
end type
global asc_transaction asc_transaction

type variables
boolean	on_alert_msg, on_alert_log, on_debug

acc_txtlog	txtlog
end variables

forward prototypes
public function boolean of_setup (string p_name, boolean p_test)
end prototypes

public function boolean of_setup (string p_name, boolean p_test);if isnull( p_name ) or len( p_name ) = 0 then
	msg.of_error( fnc.strg.of_format( "トランザクション名が指定されていません。({1})", this.classname() ) )
	return false
end if

return true
end function

on asc_transaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on asc_transaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//デストラクタ
destroy txtlog
end event

event constructor;//コンストラクタ
txtlog	= create acc_txtlog

txtlog.on_alert_msg	= on_alert_msg
txtlog.on_alert_log	= on_alert_log
txtlog.on_debug		= on_debug

end event

