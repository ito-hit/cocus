$PBExportHeader$cv_band_message.sru
$PBExportComments$メッセージバンド（全体通知用）カスタムオブジェクト
forward
global type cv_band_message from ivo_userobject
end type
type dw_message from ivo_datawindow within cv_band_message
end type
type ln_upper from line within cv_band_message
end type
type ln_lower from line within cv_band_message
end type
type uo_scroll from inv_timing within cv_band_message
end type
type uo_visible from inv_timing within cv_band_message
end type
end forward

global type cv_band_message from ivo_userobject
boolean visible = false
integer height = 92
integer transparency = 100
dw_message dw_message
ln_upper ln_upper
ln_lower ln_lower
uo_scroll uo_scroll
uo_visible uo_visible
end type
global cv_band_message cv_band_message

type variables
private constant integer	c_interval		= 50	// フェードイン用タイマイベントのインターバル
private constant integer	c_step			= 5		// 透明度の変化量

private constant integer	c_scl_interval	= 10	// スクロール用タイマイベントのインターバル
private constant integer	c_scl_step		= 80	// 1ターンのスクロール量

private boolean	i_mode_visible

long	i_sleep	= 0	// メッセージストップカウント

private integer	i_step
private long	i_scl_min, i_scl_max, i_scl_now

integer	i_turn_limit	= 0		// 指定回数繰り返したら閉じる（0は閉じずに繰り返す）
integer	i_stop_sec		= 5		// 停止時間(秒)

private integer	i_turn			// 繰り返しの回数
private integer	i_sleep_limit	// メッセージストップ時間（ c_sleep * c_scl_interval ミリ秒 ）

boolean	i_running	// true：表示中 false：停止中
end variables

forward prototypes
private subroutine set_mode (boolean p_visible)
public subroutine of_scroll_start ()
public subroutine of_scroll_stop ()
public subroutine of_set_text (string p_text)
public subroutine of_show (string p_text)
public subroutine of_show ()
public subroutine of_hide ()
public subroutine of_set_color (integer p_msg_code)
public subroutine of_show_info ()
public subroutine of_show_success ()
public subroutine of_show_warning ()
public subroutine of_show_error ()
public subroutine of_show_error (string p_text)
public subroutine of_show_info (string p_text)
public subroutine of_show_success (string p_text)
public subroutine of_show_warning (string p_text)
private subroutine scroll_reset ()
public subroutine of_set_turn_limit (integer p_turn)
public function boolean of_running ()
end prototypes

private subroutine set_mode (boolean p_visible);// タイマをどっち方向で刻むか

if p_visible then
	i_step	= c_step * -1
else
	i_step	= c_step
end if

i_mode_visible	= p_visible
end subroutine

public subroutine of_scroll_start ();i_turn	= 0
i_sleep_limit	= ( i_stop_sec - 1 ) * 1000 / c_scl_interval	// マイナス１したのはタイマ開始/停止を繰り返すことから微妙にずれるための補正

uo_scroll.of_start()
end subroutine

public subroutine of_scroll_stop ();uo_scroll.of_stop()
end subroutine

public subroutine of_set_text (string p_text);dw_message.object.text[1]	= p_text
end subroutine

public subroutine of_show (string p_text);of_set_text( p_text )

of_show()
end subroutine

public subroutine of_show ();i_running	= true

set_mode( true )
this.visible	= true

scroll_reset()

uo_visible.of_start()

end subroutine

public subroutine of_hide ();set_mode( false )
of_scroll_stop()

uo_visible.of_start()

i_running	= false
end subroutine

public subroutine of_set_color (integer p_msg_code);choose case p_msg_code
	case code.msg_info
		this.backcolor						= palette.info_back
		dw_message.object.datawindow.color	= palette.info_back
		dw_message.object.text.color		= palette.info_text
		ln_upper.linecolor					= palette.info_text
		ln_lower.linecolor					= palette.info_text
	case code.msg_success
		this.backcolor						= palette.success_back
		dw_message.object.datawindow.color	= palette.success_back
		dw_message.object.text.color		= palette.success_text
		ln_upper.linecolor					= palette.success_text
		ln_lower.linecolor					= palette.success_text
	case code.msg_warning
		this.backcolor						= palette.warning_back
		dw_message.object.datawindow.color	= palette.warning_back
		dw_message.object.text.color		= palette.warning_text
		ln_upper.linecolor					= palette.warning_text
		ln_lower.linecolor					= palette.warning_text
	case code.msg_error
		this.backcolor						= palette.error_back
		dw_message.object.datawindow.color	= palette.error_back
		dw_message.object.text.color		= palette.error_text
		ln_upper.linecolor					= palette.error_text
		ln_lower.linecolor					= palette.error_text
	case else
		this.backcolor						= palette.info_back
		dw_message.object.datawindow.color	= palette.info_back
		dw_message.object.text.color		= palette.info_text
		ln_upper.linecolor					= palette.info_text
		ln_lower.linecolor					= palette.info_text
end choose
		




end subroutine

public subroutine of_show_info ();of_set_color( code.msg_info )
of_show()

end subroutine

public subroutine of_show_success ();of_set_color( code.msg_success )
of_show()

end subroutine

public subroutine of_show_warning ();of_set_color( code.msg_warning )
of_show()

end subroutine

public subroutine of_show_error ();of_set_color( code.msg_error )
of_show()

end subroutine

public subroutine of_show_error (string p_text);of_set_text( p_text )

of_show_error()
end subroutine

public subroutine of_show_info (string p_text);of_set_text( p_text )

of_show_info()
end subroutine

public subroutine of_show_success (string p_text);of_set_text( p_text )

of_show_success()
end subroutine

public subroutine of_show_warning (string p_text);of_set_text( p_text )

of_show_warning()
end subroutine

private subroutine scroll_reset ();i_scl_min	= 0
i_scl_now	= i_scl_min
i_scl_max	= long( dw_message.object.datawindow.horizontalscrollmaximum )
dw_message.object.datawindow.horizontalscrollposition	= string( i_scl_now )

end subroutine

public subroutine of_set_turn_limit (integer p_turn);i_turn	= p_turn
end subroutine

public function boolean of_running ();return i_running
end function

on cv_band_message.create
int iCurrent
call super::create
this.dw_message=create dw_message
this.ln_upper=create ln_upper
this.ln_lower=create ln_lower
this.uo_scroll=create uo_scroll
this.uo_visible=create uo_visible
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_message
this.Control[iCurrent+2]=this.ln_upper
this.Control[iCurrent+3]=this.ln_lower
end on

on cv_band_message.destroy
call super::destroy
destroy(this.dw_message)
destroy(this.ln_upper)
destroy(this.ln_lower)
destroy(this.uo_scroll)
destroy(this.uo_visible)
end on

event resize;call super::resize;dw_message.x		= 40
dw_message.y		= 9
dw_message.width	= this.width - 80
dw_message.height	= 75

ln_upper.beginy		= 6
ln_upper.endy		= 6
ln_upper.beginx		= 0
ln_upper.endx		= this.width

ln_lower.beginy		= this.height - 4
ln_lower.endy		= this.height - 4
ln_lower.beginx		= 0
ln_lower.endx		= this.width

dw_message.object.space_left.width		= string( this.width )
dw_message.object.space_right.width		= string( this.width )
dw_message.object.text.width			= string( this.width )

dw_message.object.text.x				= string( long( dw_message.object.space_left.x ) + long( dw_message.object.space_left.width ) )
dw_message.object.space_right.x			= string( long( dw_message.object.text.x ) + long( dw_message.object.text.width ) )

scroll_reset()
end event

event constructor;call super::constructor;this.height	= 94

dw_message.reset()
dw_message.insertrow(0)

dw_message.object.text[1]				= ""

i_scl_now	= i_scl_min

uo_scroll.interval_msec		= c_scl_interval
uo_visible.interval_msec	= c_interval

of_set_color( code.msg_info )
end event

event destructor;call super::destructor;uo_scroll.of_stop()
uo_visible.of_stop()

end event

type dw_message from ivo_datawindow within cv_band_message
integer x = 144
integer y = 11
integer height = 75
integer taborder = 10
string dataobject = "d_band_message"
boolean border = false
end type

type ln_upper from line within cv_band_message
long linecolor = 33554432
integer linethickness = 6
integer beginx = 184
integer beginy = 7
integer endx = 900
integer endy = 7
end type

type ln_lower from line within cv_band_message
long linecolor = 33554432
integer linethickness = 6
integer beginx = 340
integer beginy = 89
integer endx = 628
integer endy = 89
end type

type uo_scroll from inv_timing within cv_band_message descriptor "pb_nvo" = "true" 
long interval_msec = 5
end type

on uo_scroll.create
call super::create
end on

on uo_scroll.destroy
call super::destroy
end on

event timer_event;call super::timer_event;

if i_scl_now >= long( dw_message.object.text.width ) then
	if i_sleep_limit > i_sleep then
		i_sleep = i_sleep + 1
		return
	end if

	// 繰り返し回数が指定されているか
	if i_turn_limit <> 0 then
		if i_turn >= i_turn_limit - 1 then
			parent.of_scroll_stop()
			parent.post of_hide()
			return
		end if
	end if
end if

if i_scl_now < long( dw_message.object.text.width ) and i_scl_now + c_scl_step > long( dw_message.object.text.width ) then
	i_scl_now	= long( dw_message.object.text.width )
else
	i_scl_now	= i_scl_now + c_scl_step
end if

if i_scl_now > i_scl_max then
	i_scl_now	= i_scl_min
	i_sleep		= 0
	i_turn		= i_turn + 1
end if

dw_message.object.datawindow.horizontalscrollposition	= string( i_scl_now )

yield()
end event

type uo_visible from inv_timing within cv_band_message descriptor "pb_nvo" = "true" 
long interval_msec = 50
end type

on uo_visible.create
call super::create
end on

on uo_visible.destroy
call super::destroy
end on

event timer_event;call super::timer_event;integer	l_step

l_step	= parent.i_step

parent.transparency	= parent.transparency + l_step

if i_mode_visible then
	if parent.transparency <= 0 then
		parent.transparency	= 0
		of_scroll_start()
		of_stop()
	end if
else
	if parent.transparency >= 100 then
		parent.transparency	= 100
		parent.visible		= false
		of_stop()
	end if
end if

yield()
end event

