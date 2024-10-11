$PBExportHeader$asv_userobject.sru
$PBExportComments$ユーザーオブジェクトコントロール（タブページ）の始祖オブジェクト
forward
global type asv_userobject from userobject
end type
end forward

global type asv_userobject from userobject
integer width = 1940
integer height = 768
long backcolor = 67108864
string text = "未設定"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event syskeydown pbm_keydown
event type long key_f01 ( keycode key,  unsignedlong keyflags )
event type long key_f02 ( keycode key,  unsignedlong keyflags )
event type long key_f03 ( keycode key,  unsignedlong keyflags )
event type long key_f04 ( keycode key,  unsignedlong keyflags )
event type long key_f05 ( keycode key,  unsignedlong keyflags )
event type long key_f06 ( keycode key,  unsignedlong keyflags )
event type long key_f07 ( keycode key,  unsignedlong keyflags )
event type long key_f08 ( keycode key,  unsignedlong keyflags )
event type long key_f09 ( keycode key,  unsignedlong keyflags )
event type long key_f10 ( keycode key,  unsignedlong keyflags )
event type long key_f11 ( keycode key,  unsignedlong keyflags )
event type long key_f12 ( keycode key,  unsignedlong keyflags )
event type long key_enter ( keycode key,  unsignedlong keyflags )
event type long key_left ( keycode key,  unsignedlong keyflags )
event type long key_right ( keycode key,  unsignedlong keyflags )
event type long key_up ( keycode key,  unsignedlong keyflags )
event type long key_down ( keycode key,  unsignedlong keyflags )
event type long key_pgup ( keycode key,  unsignedlong keyflags )
event type long key_pgdown ( keycode key,  unsignedlong keyflags )
event type long key_end ( keycode key,  unsignedlong keyflags )
event type long key_home ( keycode key,  unsignedlong keyflags )
event type long key_ins ( keycode key,  unsignedlong keyflags )
event type long key_del ( keycode key,  unsignedlong keyflags )
event type long key_pause ( keycode key,  unsignedlong keyflags )
event type long key_bs ( keycode key,  unsignedlong keyflags )
event type long key_space ( keycode key,  unsignedlong keyflags )
event type long key_esc ( keycode key,  unsignedlong keyflags )
event update_check pbm_custom02
event update_event pbm_custom01
event resize pbm_size
event type long fnkeyevent ( keycode p_keycode,  integer p_control,  integer p_shift )
event syskeyup pbm_keyup
event getfocus ( )
end type
global asv_userobject asv_userobject

type variables
public:
	string			object_type
	graphicobject	thisobj
	
	// ファンクションキー(有効/無効)
	boolean	f1_key,f2_key,f3_key,f4_key,f5_key,f6_key,f7_key,f8_key,f9_key,f10_key,f11_key,f12_key
	boolean	sf1_key,sf2_key,sf3_key,sf4_key,sf5_key,sf6_key,sf7_key,sf8_key,sf9_key,sf10_key,sf11_key,sf12_key
	
	// Enterキー(有効/無効)
	boolean	enter_key

	// その他キー(有効/無効)
	boolean	left_key,right_key,up_key,down_key
	boolean	pgup_key,pgdown_key
	boolean	end_key,home_key,ins_key,del_key
	boolean	pause_key,bs_key,space_key,esc_key
	
	// Enterキー操作でタブ移動(有効/無効)
	boolean	enter2tab
	
	// ファンクションキー名(通常/Shift)
	string	i_function_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }
	string	i_sfunction_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }


end variables

forward prototypes
public function boolean of_update ()
public function boolean of_get_selfevent_status (keycode p_keycode)
public function string of_get_pg_id ()
public function string of_typeof ()
public function boolean of_get_fnkey_visibled ()
public function boolean of_get_key_enabled (keycode p_key, unsignedlong p_keyflags)
public subroutine of_fnkey_setting (graphicobject p_control, string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags)
public subroutine of_setfocus ()
end prototypes

event syskeydown;// keyflags
// 1:Shift 2:Ctrl 3:Shift+Ctrl

if of_get_key_enabled( key, keyflags ) then
	choose case key
		case KeyEnter!
			return event key_enter( key, keyflags )
		case KeyLeftArrow!
			return event key_left( key, keyflags )
		case KeyRightArrow!
			return event key_right( key, keyflags )
		case KeyUpArrow!
			return event key_up( key, keyflags )
		case KeyDownArrow!
			return event key_down( key, keyflags )
		case KeyPageUp!
			return event key_pgup( key, keyflags )
		case KeyPageDown!
			return event key_pgdown( key, keyflags )
		case KeyEnd!
			return event key_end( key, keyflags )
		case KeyHome!
			return event key_home( key, keyflags )
		case KeyInsert!
			return event key_ins( key, keyflags )
		case KeyDelete!
			return event key_del( key, keyflags )
		case KeyPause!
			return event key_pause( key, keyflags )
		case KeyBack!
			return event key_bs( key, keyflags )
		case KeySpaceBar!
			return event key_space( key, keyflags )
		case KeyEscape!
			return event key_esc( key, keyflags )
	
	// イベント拾えないのでコメント化
	//	case KeyCapsLock!
	//		return event key_caps( key, keyflags )
	//	case KeyTab!
	//		return event key_tab( key, keyflags )
	//	case KeyPrintScreen!
	//		return event key_prtsc( key, keyflags )
		case else
			return
	end choose
//else
//	// DW側のキーが無効になっている場合、自力でWindowのイベントが発動しないのでこちらからアクションを起こす //
//	if parent.typeof() = window! then
//		parent.event dynamic key( key, keyflags )
//	else
//		parent.event dynamic keydown( key, keyflags )
//	end if
end if

end event

event type long  key_f01(keycode key, unsignedlong keyflags);// f1が押された時の処理 //
return 0
end event

event type long  key_f02(keycode key, unsignedlong keyflags);// f2が押された時の処理 //
return 0
end event

event type long  key_f03(keycode key, unsignedlong keyflags);// f3が押された時の処理 //
return 0
end event

event type long  key_f04(keycode key, unsignedlong keyflags);// f4が押された時の処理 //
return 0
end event

event type long  key_f05(keycode key, unsignedlong keyflags);// f5が押された時の処理 //
return 0
end event

event type long  key_f06(keycode key, unsignedlong keyflags);// f6が押された時の処理 //
return 0
end event

event type long  key_f07(keycode key, unsignedlong keyflags);// f7が押された時の処理 //
return 0
end event

event type long  key_f08(keycode key, unsignedlong keyflags);// f8が押された時の処理 //
return 0
end event

event type long  key_f09(keycode key, unsignedlong keyflags);// f9が押された時の処理 //
return 0
end event

event type long  key_f10(keycode key, unsignedlong keyflags);// f10が押された時の処理 //
return 0
end event

event type long  key_f11(keycode key, unsignedlong keyflags);// f11が押された時の処理 //
return 0
end event

event type long  key_f12(keycode key, unsignedlong keyflags);// f12が押された時の処理 //
return 0
end event

event type long  key_enter(keycode key, unsignedlong keyflags);// enterが押された時の処理 //
return 0
end event

event type long  key_left(keycode key, unsignedlong keyflags);// ←が押された時の処理 //
return 0
end event

event type long  key_right(keycode key, unsignedlong keyflags);// →が押された時の処理 //
return 0
end event

event key_up;// ↑が押された時の処理 //
return 0
end event

event type long  key_down(keycode key, unsignedlong keyflags);// ↓が押された時の処理 //
return 0
end event

event type long  key_pgup(keycode key, unsignedlong keyflags);// pageupが押された時の処理 //
return 0
end event

event type long  key_pgdown(keycode key, unsignedlong keyflags);// pagedownが押された時の処理 //
return 0
end event

event type long key_end(keycode key, unsignedlong keyflags);// endが押された時の処理 //
return 0
end event

event type long  key_home(keycode key, unsignedlong keyflags);// homeが押された時の処理 //
return 0
end event

event type long  key_ins(keycode key, unsignedlong keyflags);// insertが押された時の処理 //
return 0
end event

event type long key_del(keycode key, unsignedlong keyflags);// deleteが押された時の処理 //
return 0
end event

event type long  key_pause(keycode key, unsignedlong keyflags);// pauseが押された時の処理 //
return 0
end event

event type long key_bs(keycode key, unsignedlong keyflags);// backspaceが押された時の処理 //
return 0
end event

event type long  key_space(keycode key, unsignedlong keyflags);// spaceが押された時の処理 //
return 0
end event

event type long  key_esc(keycode key, unsignedlong keyflags);// escが押された時の処理 //
return 0
end event

event update_check;// 更新チェック
end event

event update_event;// 処理中メッセージ
end event

event type long fnkeyevent(keycode p_keycode, integer p_control, integer p_shift);integer	l_keyflags

if p_control = 1 then
	l_keyflags = l_keyflags + 2
end if

if p_shift = 1 then
	l_keyflags = l_keyflags + 1
end if

if of_get_key_enabled( p_keycode, l_keyflags ) then
	choose case p_keycode
		case KeyF1!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f01( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f01( p_keycode, l_keyflags )
			end if
		case KeyF2!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f02( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f02( p_keycode, l_keyflags )
			end if
		case KeyF3!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f03( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f03( p_keycode, l_keyflags )
			end if
		case KeyF4!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f04( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f04( p_keycode, l_keyflags )
			end if
		case KeyF5!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f05( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f05( p_keycode, l_keyflags )
			end if
		case KeyF6!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f06( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f06( p_keycode, l_keyflags )
			end if
		case KeyF7!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f07( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f07( p_keycode, l_keyflags )
			end if
		case KeyF8!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f08( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f08( p_keycode, l_keyflags )
			end if
		case KeyF9!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f09( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f09( p_keycode, l_keyflags )
			end if
		case KeyF10!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f10( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f10( p_keycode, l_keyflags )
			end if
		case KeyF11!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f11( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f11( p_keycode, l_keyflags )
			end if
		case KeyF12!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f12( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f12( p_keycode, l_keyflags )
			end if
		case else
			return 0
	end choose

	return parent.dynamic event fnkeyevent( p_keycode, p_control, p_shift )
end if

return 0
end event

event syskeyup;
// keyflags
// 1:Shift 2:Ctrl 3:Shift+Ctrl
// keyupはCrrlとShiftの動作のみ検知する（keycodeは無視がベター）

return 0

end event

event getfocus();
// カスタムオブジェクト向けのgetfocusイベント
end event

public function boolean of_update ();if event update_check( 0, 0 ) <> 0 then
	return false
end if

if event update_event( 0, 0 ) <> 0 then
	return false
end if

return true

end function

public function boolean of_get_selfevent_status (keycode p_keycode);integer	l_col

choose case p_keycode
	case KeyF1!
		l_col	= 1
	case KeyF2!
		l_col	= 2
	case KeyF3!
		l_col	= 3
	case KeyF4!
		l_col	= 4
	case KeyF5!
		l_col	= 5
	case KeyF6!
		l_col	= 6
	case KeyF7!
		l_col	= 7
	case KeyF8!
		l_col	= 8
	case KeyF9!
		l_col	= 9
	case KeyF10!
		l_col	= 10
	case KeyF11!
		l_col	= 11
	case KeyF12!
		l_col	= 12
	case else
		return false
end choose

if of_get_fnkey_visibled( ) then
	if len( i_function_name[l_col] ) > 0 then
		return true
	else
		return false
	end if
end if

return true

end function

public function string of_get_pg_id ();return parent.dynamic of_get_pg_id()
end function

public function string of_typeof ();return object_type
end function

public function boolean of_get_fnkey_visibled ();return parent.dynamic of_get_fnkey_visibled()

end function

public function boolean of_get_key_enabled (keycode p_key, unsignedlong p_keyflags);
// ファンクションキー
if p_keyflags = 0 then
	choose case p_key
		case KeyF1!
			return f1_key
		case KeyF2!
			return f2_key
		case KeyF3!
			return f3_key
		case KeyF4!
			return f4_key
		case KeyF5!
			return f5_key
		case KeyF6!
			return f6_key
		case KeyF7!
			return f7_key
		case KeyF8!
			return f8_key
		case KeyF9!
			return f9_key
		case KeyF10!
			return f10_key
		case KeyF11!
			return f11_key
		case KeyF12!
			return f12_key
	end choose
else
	choose case p_key
		case KeyF1!
			return sf1_key
		case KeyF2!
			return sf2_key
		case KeyF3!
			return sf3_key
		case KeyF4!
			return sf4_key
		case KeyF5!
			return sf5_key
		case KeyF6!
			return sf6_key
		case KeyF7!
			return sf7_key
		case KeyF8!
			return sf8_key
		case KeyF9!
			return sf9_key
		case KeyF10!
			return sf10_key
		case KeyF11!
			return sf11_key
		case KeyF12!
			return sf12_key
	end choose
end if

// その他のキー
choose case p_key
	case KeyEnter!
		return enter_key
	case KeyLeftArrow!
		return left_key
	case KeyRightArrow!
		return right_key
	case KeyUpArrow!
		return up_key
	case KeyDownArrow!
		return down_key
	case KeyPageUp!
		return pgup_key
	case KeyPageDown!
		return pgdown_key
	case KeyEnd!
		return end_key
	case KeyHome!
		return home_key
	case KeyInsert!
		return ins_key
	case KeyDelete!
		return del_key
	case KeyPause!
		return pause_key
	case KeyBack!
		return bs_key
	case KeySpaceBar!
		return space_key
	case KeyEscape!
		return esc_key
end choose

return false

end function

public subroutine of_fnkey_setting (graphicobject p_control, string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags);parent.dynamic of_fnkey_setting( p_control, p_fn_name, p_fn_enabled, p_keyflags )
end subroutine

public subroutine of_setfocus ();
this.event getfocus( )
end subroutine

on asv_userobject.create
end on

on asv_userobject.destroy
end on

event constructor;// コンストラクター
end event

event destructor;// デストラクタ //
end event

event dragdrop;// ドロップされたときのイベント
choose case source.classname()
	case "p_drag_size_adjust"
		w_size_adjust.event callback( "userobject", this )
end choose
end event

