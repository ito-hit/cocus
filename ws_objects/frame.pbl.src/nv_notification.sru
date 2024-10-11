$PBExportHeader$nv_notification.sru
$PBExportComments$通知管理オブジェクト
forward
global type nv_notification from inv_object
end type
type nv_timer from inv_timing within nv_notification
end type
end forward

global type nv_notification from inv_object
nv_timer nv_timer
end type
global nv_notification nv_notification

type variables

long	i_notifi_cnt	= 0
end variables

forward prototypes
public subroutine of_start ()
public subroutine of_stop ()
public function long of_get_notifi_cnt ()
end prototypes

public subroutine of_start ();nv_timer.of_start( )
end subroutine

public subroutine of_stop ();nv_timer.of_stop( )
end subroutine

public function long of_get_notifi_cnt ();return i_notifi_cnt
end function

on nv_notification.create
call super::create
this.nv_timer=create nv_timer
end on

on nv_notification.destroy
call super::destroy
destroy(this.nv_timer)
end on

event constructor;call super::constructor;nv_timer	= create inv_timing

end event

type nv_timer from inv_timing within nv_notification descriptor "pb_nvo" = "true" 
long interval_msec = 5000
end type

on nv_timer.create
call super::create
end on

on nv_timer.destroy
call super::destroy
end on

event timer_event;call super::timer_event;long	l_cnt
string	l_user_id

l_user_id	= user.user_id

select count(*)
  into :l_cnt
  from d_tuuti
 where kidoku_flg	= 0
   and user_id		= :l_user_id
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( "通知情報の取得に失敗しました。" )
	l_cnt	= 0
end if

i_notifi_cnt	= l_cnt
end event

