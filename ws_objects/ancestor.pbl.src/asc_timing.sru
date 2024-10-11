$PBExportHeader$asc_timing.sru
$PBExportComments$タイミングオブジェクトの始祖オブジェクト
forward
global type asc_timing from timing
end type
end forward

global type asc_timing from timing
event timer_event ( )
end type
global asc_timing asc_timing

type variables
boolean	on_alert_msg, on_alert_log, on_debug

acc_txtlog	txtlog

long	interval_msec

private	boolean	timer_event_running


end variables

forward prototypes
public subroutine of_evt_timer ()
end prototypes

event timer_event();// タイマで実行したいロジックはここに記述すること

end event

public subroutine of_evt_timer ();try
	// タイマイベントが二重起動しないようにフラグを立てる
	timer_event_running	= true

	triggerevent( "timer_event" )
	
	// 処理が終了したらフラグを戻す
	timer_event_running	= false
catch ( NullObjectError exp )
	this.stop()
end try

end subroutine

on asc_timing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on asc_timing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;if not timer_event_running then
	of_evt_timer( )
end if

// ここにはロジックは記載せず「timer_event」へ記述する
end event

event constructor;//コンストラクタ
txtlog	= create acc_txtlog

txtlog.on_alert_msg	= on_alert_msg
txtlog.on_alert_log	= on_alert_log
txtlog.on_debug		= on_debug

end event

event destructor;//デストラクタ
destroy txtlog
end event

