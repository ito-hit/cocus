$PBExportHeader$aw_window.srw
$PBExportComments$全てのウインドウの始祖オブジェクト
forward
global type aw_window from window
end type
end forward

global type aw_window from window
integer width = 3464
integer height = 1532
boolean titlebar = true
string title = "タイトル未設定"
string menuname = "am_menu_keytrg"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event update_event pbm_custom63
event update_check pbm_custom64
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
event openquery ( )
event print_event pbm_custom65
event print_check pbm_custom66
event retrieve_event pbm_custom61
event retrieve_check pbm_custom62
event type long fnkeyevent ( keycode p_keycode,  integer p_control,  integer p_shift )
event print_preview_event pbm_custom66
event print_preview_open pbm_custom67
event type long print_createdata ( ref inv_datastore p_dws[] )
end type
global aw_window aw_window

type variables
public:
	string	object_type
	string	i_pg_id

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

	// ファンクションキー(表示/非表示)
	boolean	fnkey_enabled

	// ファンクションキー名(通常/Shift)
	string	function_name[]		= { "", "", "", "", "", "", "", "", "", "終了", "", "" }
	string	sfunction_name[]	= { "", "", "", "", "", "", "", "", "", "終了", "", "" }

protected:	
	// カスタムビジュアルオブジェクト
	cv_key_function_set	key_fnc
	cv_loading			loading
	
	// 印刷用データウインドウ（印刷するものを都度セットして使用）
	inv_datastore	dw_prints[]
	
	// 印刷・読込・更新の各イベント実行時に確認メッセージを表示するか(有効/無効)
	boolean	confirm_print, confirm_preview, confirm_retrieve, confirm_update
	
	// 更新時の確認メッセージ「更新しますか？」の"更新"を別のものに変える（初期は「更新」）
	string	upd_head_msg
	
	// 印刷及び印刷プレビュー時のイベント実行可否
	boolean	print_retrieve, print_update

	// 複数DWの混合印刷
	boolean	marge_print	// 通常印刷と異なるため、先祖の印刷（print_event,print_preview_event内のロジックは動作しない）
end variables

forward prototypes
public subroutine of_loading (boolean p_visible)
public subroutine of_add_db_log (string p_text)
public subroutine of_add_db_log (long p_error_code, string p_text)
public subroutine of_add_db_log (string p_event_id, long p_error_code, string p_text)
public function string of_typeof ()
public function boolean of_evt_retrieve (boolean p_loading, unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_retrieve (unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_update (boolean p_loading, unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_update (unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_print_preview (boolean p_loading, unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_print_preview (unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_print (boolean p_loading, unsignedlong p_wparam, long p_lparam)
public function boolean of_evt_print (unsignedlong p_wparam, long p_lparam)
public function boolean of_get_key_enabled (keycode p_key, unsignedlong p_keyflags)
public subroutine of_fnkey_setting (graphicobject p_control, string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags)
public function boolean of_get_fnkey_visibled ()
protected subroutine of_set_firstfocus ()
protected subroutine of_set_secondfocus ()
private subroutine set_focus (integer p_order)
end prototypes

event update_event;// 処理中メッセージ

end event

event update_check;// 更新チェック

end event

event type long key_f01(keycode key, unsignedlong keyflags);// f1が押された時の処理 //
return 0
end event

event type long key_f02(keycode key, unsignedlong keyflags);// f2が押された時の処理 //
return 0
end event

event type long key_f03(keycode key, unsignedlong keyflags);// f3が押された時の処理 //
return 0
end event

event type long key_f04(keycode key, unsignedlong keyflags);// f4が押された時の処理 //
return 0
end event

event type long key_f05(keycode key, unsignedlong keyflags);// f5が押された時の処理 //
return 0
end event

event type long key_f06(keycode key, unsignedlong keyflags);// f6が押された時の処理 //
return 0
end event

event type long key_f07(keycode key, unsignedlong keyflags);// f7が押された時の処理 //
return 0
end event

event type long key_f08(keycode key, unsignedlong keyflags);// f8が押された時の処理 //
return 0
end event

event type long key_f09(keycode key, unsignedlong keyflags);// f9が押された時の処理 //
return 0
end event

event type long key_f10(keycode key, unsignedlong keyflags);// f10が押された時の処理 //
return 0
end event

event type long key_f11(keycode key, unsignedlong keyflags);// f11が押された時の処理 //
return 0
end event

event type long key_f12(keycode key, unsignedlong keyflags);// f12が押された時の処理 //
return 0
end event

event type long key_enter(keycode key, unsignedlong keyflags);// enterが押された時の処理 //
return 0
end event

event type long key_left(keycode key, unsignedlong keyflags);// ←が押された時の処理 //
return 0
end event

event type long key_right(keycode key, unsignedlong keyflags);// →が押された時の処理 //
return 0
end event

event type long key_up(keycode key, unsignedlong keyflags);// ↑が押された時の処理 //
return 0
end event

event type long key_down(keycode key, unsignedlong keyflags);// ↓が押された時の処理 //
return 0
end event

event type long key_pgup(keycode key, unsignedlong keyflags);// pageupが押された時の処理 //
return 0
end event

event type long key_pgdown(keycode key, unsignedlong keyflags);// pagedownが押された時の処理 //
return 0
end event

event type long key_end(keycode key, unsignedlong keyflags);// endが押された時の処理 //
return 0
end event

event type long key_home(keycode key, unsignedlong keyflags);// homeが押された時の処理 //
return 0
end event

event type long key_ins(keycode key, unsignedlong keyflags);// insertが押された時の処理 //
return 0
end event

event type long key_del(keycode key, unsignedlong keyflags);// deleteが押された時の処理 //
return 0
end event

event type long key_pause(keycode key, unsignedlong keyflags);// pauseが押された時の処理 //
return 0
end event

event type long key_bs(keycode key, unsignedlong keyflags);// backspaceが押された時の処理 //
return 0
end event

event type long key_space(keycode key, unsignedlong keyflags);// spaceが押された時の処理 //
return 0
end event

event type long key_esc(keycode key, unsignedlong keyflags);// escが押された時の処理 //
return 0
end event

event openquery();i_pg_id	= this.classname()


end event

event print_event;// 印刷処理
end event

event print_check;// 印刷チェック
end event

event retrieve_event;// データ取得
end event

event retrieve_check;// データ取得チェック
end event

event type long fnkeyevent(keycode p_keycode, integer p_control, integer p_shift);integer	l_keyflags

if p_control = 1 then
	l_keyflags = l_keyflags + 2
end if

if p_shift = 1 then
	l_keyflags = l_keyflags + 1
end if

//if of_get_key_enabled( p_keycode ) then
	choose case p_keycode
		case KeyF1!
			return event key_f01( p_keycode, l_keyflags )
		case KeyF2!
			return event key_f02( p_keycode, l_keyflags )
		case KeyF3!
			return event key_f03( p_keycode, l_keyflags )
		case KeyF4!
			return event key_f04( p_keycode, l_keyflags )
		case KeyF5!
			return event key_f05( p_keycode, l_keyflags )
		case KeyF6!
			return event key_f06( p_keycode, l_keyflags )
		case KeyF7!
			return event key_f07( p_keycode, l_keyflags )
		case KeyF8!
			return event key_f08( p_keycode, l_keyflags )
		case KeyF9!
			return event key_f09( p_keycode, l_keyflags )
		case KeyF10!
			return event key_f10( p_keycode, l_keyflags )
		case KeyF11!
			return event key_f11( p_keycode, l_keyflags )
		case KeyF12!
			return event key_f12( p_keycode, l_keyflags )
		case else
	end choose
//end if

return 0

end event

event print_preview_event;// 印刷プレビュー処理
end event

event print_preview_open;// 印刷プレビューウインドウ表示
end event

event type long print_createdata(ref inv_datastore p_dws[]);
// 印刷イメージ及び印刷プロパティ設定のイベント
return 0
end event

public subroutine of_loading (boolean p_visible);if p_visible then
//	this.enabled	= false
	loading.post of_show()
else
	loading.post of_hide()
//	this.enabled	= true
end if

yield()

end subroutine

public subroutine of_add_db_log (string p_text);of_add_db_log( "", 0, p_text )
end subroutine

public subroutine of_add_db_log (long p_error_code, string p_text);of_add_db_log( "", p_error_code, p_text )
end subroutine

public subroutine of_add_db_log (string p_event_id, long p_error_code, string p_text);string	l_pg_id

l_pg_id	= this.classname()

fnc.db.of_add_log( l_pg_id, p_event_id, p_error_code, p_text )
end subroutine

public function string of_typeof ();return object_type
end function

public function boolean of_evt_retrieve (boolean p_loading, unsignedlong p_wparam, long p_lparam);
integer	l_ret
pointer	old_pointer

if event retrieve_check( p_wparam, p_lparam ) <> 0 then
	return false
end if

// 確認メッセージ
if confirm_retrieve then
	if not msg.of_question( "表示しますか？" ) then
		return false
	end if
end if

if p_loading then
	of_loading( true )
end if

old_pointer = setpointer( HourGlass! )
l_ret		= event retrieve_event( p_wparam, p_lparam )

// update_event内でcloseされるとオブジェクトが消えるのでtry-catchで強引に
try
	if p_loading then
		of_loading( false )
	end if
catch ( NullObjectError exp )
end try

setpointer( old_pointer )

if l_ret <> 0 then
	return false
end if

return true

end function

public function boolean of_evt_retrieve (unsignedlong p_wparam, long p_lparam);return of_evt_retrieve( true, p_wparam, p_lparam )
end function

public function boolean of_evt_update (boolean p_loading, unsignedlong p_wparam, long p_lparam);
integer	l_ret
pointer	old_pointer

if event update_check( p_wparam, p_lparam ) <> 0 then
	return false
end if

// 確認メッセージ
string	l_msg

if confirm_update then
	if len( upd_head_msg ) = 0 or isnull( upd_head_msg ) then
		l_msg	= "更新しますか？"
	else
		l_msg	= fnc.strg.of_format( "{1}しますか？", upd_head_msg )
	end if
	
	if not msg.of_question( l_msg ) then
		return false
	end if
end if

if p_loading then
	of_loading( true )
end if

old_pointer = setpointer( HourGlass! )
l_ret		= event update_event( p_wparam, p_lparam )

// update_event内でcloseされるとオブジェクトが消えるのでtry-catchで強引に
try
	if p_loading then
		of_loading( false )
	end if
catch ( NullObjectError exp )
end try

setpointer( old_pointer )

if l_ret <> 0 then
	return false
end if

return true

end function

public function boolean of_evt_update (unsignedlong p_wparam, long p_lparam);return of_evt_update( true, p_wparam, p_lparam )
end function

public function boolean of_evt_print_preview (boolean p_loading, unsignedlong p_wparam, long p_lparam);
integer	l_ret
pointer	old_pointer

if event print_check( p_wparam, p_lparam ) <> 0 then
	return false
end if

// 確認メッセージ
if confirm_preview then
	if not msg.of_question( "印刷プレビューを表示しますか？" ) then
		return false
	end if
end if

if p_loading then
	of_loading( true )
end if

old_pointer = setpointer( HourGlass! )
l_ret		= event print_preview_event( p_wparam, p_lparam )

// update_event内でcloseされるとオブジェクトが消えるのでtry-catchで強引に
try
	if p_loading then
		of_loading( false )
	end if
catch ( nullobjecterror exp )
end try

setpointer( old_pointer )

if l_ret <> 0 then
	return false
end if

return true

end function

public function boolean of_evt_print_preview (unsignedlong p_wparam, long p_lparam);return of_evt_print_preview( true, p_wparam, p_lparam )
end function

public function boolean of_evt_print (boolean p_loading, unsignedlong p_wparam, long p_lparam);
integer	l_ret
pointer	old_pointer

if event print_check( p_wparam, p_lparam ) <> 0 then
	return false
end if

// 確認メッセージ
if confirm_print then
	if not msg.of_question( "印刷しますか？" ) then
		return false
	end if
end if

if p_loading then
	of_loading( true )
end if

old_pointer = setpointer( HourGlass! )

// 印刷前に読込がある場合（印刷画面でRetrieveが必要なケースやPreviewとの共通化が目的
if print_retrieve then
	if event retrieve_check( 0, 0 ) <> 0 then
		l_ret	= -1
	else
		if event retrieve_event( 0, 0 ) <> 0 then
			l_ret	= -1
		end if
	end if
end if

if l_ret = 0 then
	l_ret		= event print_event( p_wparam, p_lparam )
end if

// 通常印刷の場合の更新処理を別に書くならこっちへ
if l_ret = 0 then
	if print_update then
		if event update_check( 0, 0 ) <> 0 then
			l_ret	= -1
		else
			if event update_event( 0, 0 ) <> 0 then
				l_ret	= -1
			end if
		end if
	end if
end if

// update_event内でcloseされるとオブジェクトが消えるのでtry-catchで強引に
try
	if p_loading then
		of_loading( false )
	end if
catch ( nullobjecterror exp )
end try

setpointer( old_pointer )

if l_ret <> 0 then
	return false
end if

return true

end function

public function boolean of_evt_print (unsignedlong p_wparam, long p_lparam);return of_evt_print( true, p_wparam, p_lparam )
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

public subroutine of_fnkey_setting (graphicobject p_control, string p_fn_name[], boolean p_fn_enabled[], unsignedlong p_keyflags);if isvalid( key_fnc ) then
	if fnkey_enabled then
		key_fnc.focusobj	= p_control

		key_fnc.of_set_fuction_name( p_fn_name, p_fn_enabled, p_keyflags )
		//key_fnc.of_set_fuction_name( )
	end if
end if
end subroutine

public function boolean of_get_fnkey_visibled ();return false
end function

protected subroutine of_set_firstfocus ();set_focus( 1 )
end subroutine

protected subroutine of_set_secondfocus ();set_focus( 2 )


end subroutine

private subroutine set_focus (integer p_order);
// タブ順序を取得するための一時オブジェクト
animation				l_anmtin
checkbox				l_chkbox
commandbutton			l_cmdbtn
datawindow				l_datwin
datepicker				l_dtpick
dropdownlistbox			l_dpdnlst
dropdownpicturelistbox	l_dpdnpiclst
editmask				l_edtmsk
graph					l_graph
groupbox				l_grpbox
hprogressbar			l_hprgrs
hscrollbar				l_hscrl
htrackbar				l_htrck
inkedit					l_inkedt
inkpicture				l_inkpic
listbox					l_lstbox
listview				l_lstview
monthcalendar			l_monthcal
multilineedit			l_mltilinedt
picture					l_pic
picturebutton			l_picbtn
picturehyperlink		l_pichyplnk
picturelistbox			l_piclst
radiobutton				l_rdiobtn
richtextedit			l_rtxtedt
singlelineedit			l_sgllineedt
statichyperlink			l_stchyplnk
statictext				l_stctxt
tab						l_tab
treeview				l_trview
userobject				l_usrobj
vprogressbar			l_vprgrs
vscrollbar				l_vscrl
vtrackbar				l_vtrck


// コントロール配列からコントロール名とタブオーダーを取得
long	l_taborder, l_taborders[], l_tmp_taborders[]
string	l_name, l_names[], l_tmp_names[]
integer	l_idx, l_idxs[], l_tmp_idxs[]

integer			l_cnt, l_cnt2
graphicobject	l_obj

for l_idx = 1 to upperbound( control )
	l_obj	= control[l_idx]
	
	choose case typeof( l_obj )
		case animation!
			l_anmtin		= l_obj
			l_name			= l_anmtin.classname()
			l_taborder		= l_anmtin.taborder
		case checkbox!
			l_chkbox		= l_obj
			l_name			= l_chkbox.classname()
			l_taborder		= l_chkbox.taborder
		case commandbutton!
			l_cmdbtn		= l_obj
			l_name			= l_cmdbtn.classname()
			l_taborder		= l_cmdbtn.taborder
		case datawindow!
			l_datwin		= l_obj
			l_name			= l_datwin.classname()
			l_taborder		= l_datwin.taborder
		case datepicker!
			l_dtpick		= l_obj
			l_name			= l_dtpick.classname()
			l_taborder		= l_dtpick.taborder
		case dropdownlistbox!
			l_dpdnlst		= l_obj
			l_name			= l_dpdnlst.classname()
			l_taborder		= l_dpdnlst.taborder
		case dropdownpicturelistbox!
			l_dpdnpiclst	= l_obj
			l_name			= l_dpdnpiclst.classname()
			l_taborder		= l_dpdnpiclst.taborder
		case editmask!
			l_edtmsk		= l_obj
			l_name			= l_edtmsk.classname()
			l_taborder		= l_edtmsk.taborder
		case graph!
			l_graph			= l_obj
			l_name			= l_graph.classname()
			l_taborder		= l_graph.taborder
		case groupbox!
			l_grpbox		= l_obj
			l_name			= l_grpbox.classname()
			l_taborder		= l_grpbox.taborder
		case hprogressbar!
			l_hprgrs		= l_obj
			l_name			= l_hprgrs.classname()
			l_taborder		= l_hprgrs.taborder
		case hscrollbar!
			l_hscrl			= l_obj
			l_name			= l_hscrl.classname()
			l_taborder		= l_hscrl.taborder
		case htrackbar!
			l_htrck			= l_obj
			l_name			= l_htrck.classname()
			l_taborder		= l_htrck.taborder
		case inkedit!
			l_inkedt		= l_obj
			l_name			= l_inkedt.classname()
			l_taborder		= l_inkedt.taborder
		case inkpicture!
			l_inkpic		= l_obj
			l_name			= l_inkpic.classname()
			l_taborder		= l_inkpic.taborder
		case listbox!
			l_lstbox		= l_obj
			l_name			= l_lstbox.classname()
			l_taborder		= l_lstbox.taborder
		case listview!
			l_lstview		= l_obj
			l_name			= l_lstview.classname()
			l_taborder		= l_lstview.taborder
		case monthcalendar!
			l_monthcal		= l_obj
			l_name			= l_monthcal.classname()
			l_taborder		= l_monthcal.taborder
		case multilineedit!
			l_mltilinedt	= l_obj
			l_name			= l_mltilinedt.classname()
			l_taborder		= l_mltilinedt.taborder
		case picture!
			l_pic			= l_obj
			l_name			= l_pic.classname()
			l_taborder		= l_pic.taborder
		case picturebutton!
			l_picbtn		= l_obj
			l_name			= l_picbtn.classname()
			l_taborder		= l_picbtn.taborder
		case picturehyperlink!
			l_pichyplnk		= l_obj
			l_name			= l_pichyplnk.classname()
			l_taborder		= l_pichyplnk.taborder
		case picturelistbox!
			l_piclst		= l_obj
			l_name			= l_piclst.classname()
			l_taborder		= l_piclst.taborder
		case radiobutton!
			l_rdiobtn		= l_obj
			l_name			= l_rdiobtn.classname()
			l_taborder		= l_rdiobtn.taborder
		case richtextedit!
			l_rtxtedt		= l_obj
			l_name			= l_rtxtedt.classname()
			l_taborder		= l_rtxtedt.taborder
		case singlelineedit!
			l_sgllineedt	= l_obj
			l_name			= l_sgllineedt.classname()
			l_taborder		= l_sgllineedt.taborder
		case statichyperlink!
			l_stchyplnk		= l_obj
			l_name			= l_stchyplnk.classname()
			l_taborder		= l_stchyplnk.taborder
		case statictext!
			l_stctxt		= l_obj
			l_name			= l_stctxt.classname()
			l_taborder		= l_stctxt.taborder
		case tab!
			l_tab			= l_obj
			l_name			= l_tab.classname()
			l_taborder		= l_tab.taborder
		case treeview!
			l_trview		= l_obj
			l_name			= l_trview.classname()
			l_taborder		= l_trview.taborder
		case userobject!
			l_usrobj		= l_obj
			l_name			= l_usrobj.classname()
			l_taborder		= l_usrobj.taborder
		case vprogressbar!
			l_vprgrs		= l_obj
			l_name			= l_vprgrs.classname()
			l_taborder		= l_vprgrs.taborder
		case vscrollbar!
			l_vscrl			= l_obj
			l_name			= l_vscrl.classname()
			l_taborder		= l_vscrl.taborder
		case vtrackbar!
			l_vtrck			= l_obj
			l_name			= l_vtrck.classname()
			l_taborder		= l_vtrck.taborder
		case else
			l_taborder	= 0
	end choose

	if l_taborder <> 0 then
		l_tmp_taborders[l_taborder]	= l_taborder
		l_tmp_names[l_taborder]		= l_name
		l_tmp_idxs[l_taborder]		= l_idx
	end if
next

l_cnt2	= 1
for l_cnt = 1 to upperbound( l_tmp_taborders )
	if l_tmp_idxs[l_cnt] <> 0 then
		l_taborders[l_cnt2]	= l_tmp_taborders[l_cnt]
		l_names[l_cnt2]		= l_tmp_names[l_cnt]
		l_idxs[l_cnt2]		= l_tmp_idxs[l_cnt]
		
		l_cnt2				= l_cnt2 + 1
	end if
next

// ターゲットにsetfocus
l_obj	= control[l_idxs[p_order]]

choose case typeof( l_obj )
	case animation!
		l_anmtin		= l_obj
		l_anmtin.setfocus()
	case checkbox!
		l_chkbox		= l_obj
		l_chkbox.setfocus()
	case commandbutton!
		l_cmdbtn		= l_obj
		l_cmdbtn.setfocus()
	case datawindow!
		l_datwin		= l_obj
		l_datwin.setfocus()
	case datepicker!
		l_dtpick		= l_obj
		l_dtpick.setfocus()
	case dropdownlistbox!
		l_dpdnlst		= l_obj
		l_dpdnlst.setfocus()
	case dropdownpicturelistbox!
		l_dpdnpiclst	= l_obj
		l_dpdnpiclst.setfocus()
	case editmask!
		l_edtmsk		= l_obj
		l_edtmsk.setfocus()
	case graph!
		l_graph			= l_obj
		l_graph.setfocus()
	case groupbox!
		l_grpbox		= l_obj
		l_grpbox.setfocus()
	case hprogressbar!
		l_hprgrs		= l_obj
		l_hprgrs.setfocus()
	case hscrollbar!
		l_hscrl			= l_obj
		l_hscrl.setfocus()
	case htrackbar!
		l_htrck			= l_obj
		l_htrck.setfocus()
	case inkedit!
		l_inkedt		= l_obj
		l_inkedt.setfocus()
	case inkpicture!
		l_inkpic		= l_obj
		l_inkpic.setfocus()
	case listbox!
		l_lstbox		= l_obj
		l_lstbox.setfocus()
	case listview!
		l_lstview		= l_obj
		l_lstview.setfocus()
	case monthcalendar!
		l_monthcal		= l_obj
		l_monthcal.setfocus()
	case multilineedit!
		l_mltilinedt	= l_obj
		l_mltilinedt.setfocus()
	case picture!
		l_pic			= l_obj
		l_pic.setfocus()
	case picturebutton!
		l_picbtn		= l_obj
		l_picbtn.setfocus()
	case picturehyperlink!
		l_pichyplnk		= l_obj
		l_pichyplnk.setfocus()
	case picturelistbox!
		l_piclst		= l_obj
		l_piclst.setfocus()
	case radiobutton!
		l_rdiobtn		= l_obj
		l_rdiobtn.setfocus()
	case richtextedit!
		l_rtxtedt		= l_obj
		l_rtxtedt.setfocus()
	case singlelineedit!
		l_sgllineedt	= l_obj
		l_sgllineedt.setfocus()
	case statichyperlink!
		l_stchyplnk		= l_obj
		l_stchyplnk.setfocus()
	case statictext!
		l_stctxt		= l_obj
		l_stctxt.setfocus()
	case tab!
		l_tab			= l_obj
		l_tab.setfocus()
	case treeview!
		l_trview		= l_obj
		l_trview.setfocus()
	case userobject!
		l_usrobj		= l_obj
		l_usrobj.dynamic of_setfocus()
	case vprogressbar!
		l_vprgrs		= l_obj
		l_vprgrs.setfocus()
	case vscrollbar!
		l_vscrl			= l_obj
		l_vscrl.setfocus()
	case vtrackbar!
		l_vtrck			= l_obj
		l_vtrck.setfocus()
	case else
end choose

end subroutine

event key;graphicobject l_control

// keyflags
// 1:Shift 2:Ctrl 3:Shift+Ctrl

// フォーカスのあるコントロール情報を取得
l_control	= getfocus()

//if isvalid( l_control ) then
//	// コントロールのKeyが有効となっている場合はWindow側のキーイベントは実行しない
//	if l_control.dynamic of_get_key_enabled( key ) then
//		// ただしDWだけは自力でイベントが発動しないのでこちらからアクションを起こす //
//		if l_control.typeof() = datawindow! then
//			l_control.event dynamic key_f10( key, keyflags )
//		end if
//		return
//	end if
//end if

// Window側のキーイベント実行
if of_get_key_enabled( key, keyflags ) then
	choose case key
//		case KeyF1!
//			return event key_f01( key, keyflags )
//		case KeyF2!
//			return event key_f02( key, keyflags )
//		case KeyF3!
//			return event key_f03( key, keyflags )
//		case KeyF4!
//			return event key_f04( key, keyflags )
//		case KeyF5!
//			return event key_f05( key, keyflags )
//		case KeyF6!
//			return event key_f06( key, keyflags )
//		case KeyF7!
//			return event key_f07( key, keyflags )
//		case KeyF8!
//			return event key_f08( key, keyflags )
//		case KeyF9!
//			return event key_f09( key, keyflags )
//		case KeyF10!
//			return event key_f10( key, keyflags )
//		case KeyF11!
//			return event key_f11( key, keyflags )
//		case KeyF12!
//			return event key_f12( key, keyflags )
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
	//	case KeyTab!
	//		return event key_tab( key, keyflags )
	//	case KeyCapsLock!
	//		return event key_caps( key, keyflags )
	//	case KeyPrintScreen!
	//		return event key_prtsc( key, keyflags )
	
		case else
			return
	end choose
end if

end event

on aw_window.create
if this.MenuName = "am_menu_keytrg" then this.MenuID = create am_menu_keytrg
end on

on aw_window.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//setredraw( false )

end event

event open; event openquery( )

end event

event dragdrop;// ドロップされたときのイベント
choose case source.classname()
	case "p_drag_size_adjust"
		w_size_adjust.event callback( "window", this )
end choose
end event

