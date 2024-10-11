$PBExportHeader$ivo_singlelineedit_spin.sru
$PBExportComments$シングルラインエディットコントロール（スピン仕様）の先祖オブジェクト
forward
global type ivo_singlelineedit_spin from ivo_userobject
end type
type cb_down from ivo_commandbutton within ivo_singlelineedit_spin
end type
type cb_up from ivo_commandbutton within ivo_singlelineedit_spin
end type
type sle_value from ivo_singlelineedit within ivo_singlelineedit_spin
end type
end forward

global type ivo_singlelineedit_spin from ivo_userobject
integer width = 380
integer height = 89
event type boolean input_check ( )
cb_down cb_down
cb_up cb_up
sle_value sle_value
end type
global ivo_singlelineedit_spin ivo_singlelineedit_spin

type variables

public:
	boolean	displayonly	= false
	
	integer	init_value		= 1

protected:

	integer	spinbtn_font	= 8		// スピンボタンのフォントサイズ（高さに合わせて変更可能）
	integer	spinbtn_width	= 80	// スピンボタンの横幅（全体サイズに合わせて横幅の変更可能）

	integer	setstep			= 1		// up/downで刻む数
	
	integer	range_min		= 1		// 入力可能最小値
	integer	range_max		= 100	// 入力可能最大値

private:
	constant integer	default_width		= 300	// 参照用（忘れるので記載しているが使用していない）
	constant integer	default_height		= 89	// 参照用（忘れるので記載しているが使用していない）

end variables

forward prototypes
private subroutine add_value (integer p_step)
public subroutine of_enabled (boolean p_enabled)
public subroutine of_set_displayonly (boolean p_enabled)
end prototypes

event type boolean input_check();
long	l_value

l_value	= long( sle_value.text )

if l_value < range_min or l_value > range_max then
	sle_value.of_msg_error( fnc.strg.of_format( "入力可能な範囲を超えています（範囲：{1}～{2} 実際：{3}）", string( range_min ), string( range_max ), sle_value.text ) )
	return false
end if

return true
end event

private subroutine add_value (integer p_step);
integer	l_value

if sle_value.of_isna() or not sle_value.of_isnumber() then
	sle_value.text	= string( range_min )
else
	l_value			= long( sle_value.text ) + p_step
	
	if l_value >= range_min and l_value <= range_max then
		sle_value.text	= string( l_value )
	end if
end if

sle_value.setfocus()
end subroutine

public subroutine of_enabled (boolean p_enabled);
sle_value.enabled	= p_enabled
cb_up.enabled		= p_enabled
cb_down.enabled		= p_enabled
end subroutine

public subroutine of_set_displayonly (boolean p_enabled);
sle_value.of_set_displayonly( p_enabled )

cb_up.enabled			= not p_enabled
cb_down.enabled			= not p_enabled

end subroutine

on ivo_singlelineedit_spin.create
int iCurrent
call super::create
this.cb_down=create cb_down
this.cb_up=create cb_up
this.sle_value=create sle_value
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_down
this.Control[iCurrent+2]=this.cb_up
this.Control[iCurrent+3]=this.sle_value
end on

on ivo_singlelineedit_spin.destroy
call super::destroy
destroy(this.cb_down)
destroy(this.cb_up)
destroy(this.sle_value)
end on

event resize;call super::resize;
sle_value.x			= 0
sle_value.width		= newwidth - spinbtn_width

cb_up.x				= sle_value.x + sle_value.width
cb_up.width			= spinbtn_width
cb_down.x			= cb_up.x
cb_down.width		= cb_up.width

sle_value.y			= 0
sle_value.height	= newheight

cb_up.height		= ceiling( newheight / 2 )
cb_down.height		= cb_up.height

cb_up.y				= sle_value.y
cb_down.y			= sle_value.y + sle_value.height - cb_down.height


end event

event key_down;call super::key_down;
add_value( setstep * -1 )

return 0
end event

event key_up;call super::key_up;
add_value( setstep )

return 0
end event

event constructor;call super::constructor;object_type	= "singlelineedit_spin"

of_enabled( this.enabled )

if this.enabled then
	of_set_displayonly( displayonly )
end if

sle_value.text	= string( init_value )


end event

type cb_down from ivo_commandbutton within ivo_singlelineedit_spin
integer x = 300
integer y = 43
integer width = 80
integer height = 46
integer textsize = -8
string text = "▼"
end type

event execution;call super::execution;
sle_value.event key_down( keydownarrow!, 0 )
end event

type cb_up from ivo_commandbutton within ivo_singlelineedit_spin
integer x = 300
integer width = 80
integer height = 46
integer textsize = -8
string text = "▲"
end type

event execution;call super::execution;
sle_value.event key_up( keyuparrow!, 0 )
end event

type sle_value from ivo_singlelineedit within ivo_singlelineedit_spin
integer taborder = 10
integer init_imemode = 3
string text = ""
boolean up_key = true
boolean down_key = true
boolean chk_type_num = true
end type

event key_up;call super::key_up;
return parent.event key_up( key, keyflags )
end event

event key_down;call super::key_down;
return parent.event key_down( key, keyflags )
end event

event input_check;call super::input_check;
return parent.event input_check()
end event

event change;call super::change;parent.text	= this.text
end event

