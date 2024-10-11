$PBExportHeader$inv_timing.sru
$PBExportComments$タイミングオブジェクトの先祖オブジェクト
forward
global type inv_timing from asc_timing
end type
end forward

global type inv_timing from asc_timing
long interval_msec = 1000
end type
global inv_timing inv_timing

type variables
boolean	auto_start	= false
end variables

forward prototypes
public subroutine of_start ()
public subroutine of_stop ()
public subroutine of_set_interval (long p_msec)
public function long of_get_interval ()
end prototypes

public subroutine of_start ();this.start( interval_msec / 1000 )


end subroutine

public subroutine of_stop ();this.stop()
end subroutine

public subroutine of_set_interval (long p_msec);interval_msec	= p_msec
end subroutine

public function long of_get_interval ();return interval_msec
end function

on inv_timing.create
call super::create
end on

on inv_timing.destroy
call super::destroy
end on

event timer_event;call super::timer_event;// タイマで実行したいロジックはここに記述すること
//msg.of_info( "inv timer_event" )

end event

event constructor;call super::constructor;if auto_start then
	this.of_start()
end if
end event

