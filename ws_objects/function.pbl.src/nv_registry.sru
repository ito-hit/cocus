$PBExportHeader$nv_registry.sru
$PBExportComments$レジストリ操作関数
forward
global type nv_registry from inv_object
end type
type lstr_registry from structure within nv_registry
end type
type lstr_system from structure within nv_registry
end type
type lstr_device from structure within nv_registry
end type
type lstr_computer from structure within nv_registry
end type
type lstr_window from structure within nv_registry
end type
type lstr_user from structure within nv_registry
end type
end forward

type lstr_registry from structure
	lstr_system		sys
	lstr_device		dev
	lstr_computer		cmp
	lstr_window		win
end type

type lstr_system from structure
	string		name
end type

type lstr_device from structure
	string		name
end type

type lstr_computer from structure
	string		name
end type

type lstr_window from structure
	string		name
	string		last_window
	string		last_tab
end type

type lstr_user from structure
	long		user_id
	string		user_mei
end type

global type nv_registry from inv_object
end type
global nv_registry nv_registry

type variables
public:

protected:

private:
	constant string	base_registry		= "HKEY_CURRENT_USER\Software\cocos"
	
	constant string	base_key			= "liberation"
	
	constant string	app_subkey			= "app"
	constant string	app_win_subkey		= "window"
	constant string	app_win_pos_subkey	= "window\position"
	constant string	app_wub_siz_subkey	= "window\size"
	constant string	app_tab_subkey		= "tab"
	
	constant string	device_subkey		= "device"
	constant string	device_prn_subkey	= "printer"
	
	constant string	user_subkey			= "user"
	constant string	user_log_subkey		= "login"
	constant string	user_prf_subkey		= "profile"
	
	constant string	test_subkey			= "test"
	
	constant integer TYPE_STR		= 0
	constant integer TYPE_NUM		= 1
	
	constant string	reg_printer		= "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices"
	constant string	reg_printer_def	= "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"
	constant string	reg_shelldir	= "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
	
	string	target_path


end variables

forward prototypes
private function boolean get_registry_keys (string p_path, ref string p_keys[])
private function boolean get_registries (string p_path, ref string p_value[])
private function boolean del_registry (string p_path, string p_key)
private function boolean get_registry (string p_path, string p_key, integer p_type, ref any p_value)
public function string of_get_user_user_mei ()
public function any of_get_os_printers ()
private function string get_path_user (string p_sub_path)
private function string get_path_device (string p_sub_path)
private function string get_path_app (string p_sub_path)
public function any of_get_user_registry (string p_sub_path, string p_key, integer p_type)
public function any of_get_user_registry (string p_key, integer p_type)
public function any of_get_device_registry (string p_sub_path, string p_key, integer p_type)
public function any of_get_device_registry (string p_key, integer p_type)
public function any of_get_app_registry (string p_sub_path, string p_key, integer p_type)
public function any of_get_app_registry (string p_key, integer p_type)
public function string of_get_app_window_id ()
public function string of_get_app_window_name ()
public function string of_get_app_tab_id ()
public function string of_get_app_tab_name ()
public function string of_get_device_printer_lbp ()
public function string of_get_device_printer_sdp ()
public function string of_get_device_printer_lvp ()
public function string of_get_device_printer_tgp ()
public function boolean of_set_device_registry (string p_sub_path, string p_key, integer p_type, any p_value)
public function boolean of_set_user_registry (string p_sub_path, string p_key, integer p_type, any p_value)
public function boolean of_set_app_registry (string p_sub_path, string p_key, integer p_type, any p_value)
public function boolean of_set_app_registry (string p_key, integer p_type, any p_value)
public function boolean of_set_device_registry (string p_key, integer p_type, any p_value)
public function boolean of_set_user_registry (string p_key, integer p_type, any p_value)
public function boolean of_set_user_user_mei (string p_value)
public function boolean of_set_app_window_width (integer p_value)
public function boolean of_set_app_window_height (integer p_value)
public function boolean of_set_app_window_id (string p_value)
public function boolean of_set_app_window_name (string p_value)
public function boolean of_set_app_window_x (integer p_value)
public function boolean of_set_app_window_y (integer p_value)
public function boolean of_set_app_tab_id (string p_value)
public function boolean of_set_app_tab_name (string p_value)
public function boolean of_set_app_tab_position (integer p_value)
public function boolean of_set_device_printer_lbp (string p_value)
public function boolean of_set_device_printer_lvp (string p_value)
public function boolean of_set_device_printer_sdp (string p_value)
public function boolean of_set_device_printer_tgp (string p_value)
public function integer of_get_app_window_x ()
public function integer of_get_app_window_y ()
public function integer of_get_app_window_width ()
public function integer of_get_app_window_height ()
public function integer of_get_app_tab_position ()
private function boolean set_registry (string p_path, string p_key, integer p_type, string p_value)
public function string of_get_dir_desktop ()
private function string get_special_folders (string p_key)
public function string of_get_dir_documents ()
public function boolean of_set_user_user_id (string p_value)
public function string of_get_user_user_id ()
public function string of_get_os_default_printer ()
end prototypes

private function boolean get_registry_keys (string p_path, ref string p_keys[]);if registrykeys( p_path, p_keys ) <> 1 then
	return false
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "get_registry_keys", -999, "レジストリの読み込みに失敗しました。（" + p_path + "）")
end if

return true
end function

private function boolean get_registries (string p_path, ref string p_value[]);if registryvalues( p_path, p_value ) <> 1 then
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "get_registries", -999, "レジストリの読み込みに失敗しました。（" + p_path + "）")
	return false
end if

return true

end function

private function boolean del_registry (string p_path, string p_key);if registrydelete( p_path, p_key ) <> 1 then
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "set_registry", -999, "レジストリの書き込みに失敗しました。（" + fnc.strg.of_format( "{1}｜{2}", p_path, p_key ) + "）")
	return false
end if

return true
end function

private function boolean get_registry (string p_path, string p_key, integer p_type, ref any p_value);string	l_str_value
ulong	l_lng_value

integer	l_ret

registryvaluetype	l_type

choose case p_type
	case TYPE_STR
		l_type	= RegString!
		l_ret	= registryget( p_path, p_key, l_type, l_str_value )
		p_value	= l_str_value
	case TYPE_NUM
		l_type	= ReguLong!
		l_ret	= registryget( p_path, p_key, l_type, l_lng_value )
		p_value	= l_lng_value
	case else
		l_type	= RegString!
		l_ret	= registryget( p_path, p_key, l_type, l_str_value )
		p_value	= l_str_value
end choose

// レジストリが存在しない場合もエラーが帰ってきてしまうのでエラーメッセージは出さない
if l_ret <> 1 then
	setnull( p_value )
//	txtlog.of_sys_alert( txtlog.TYPE_ALT, "set_registry", -999, "レジストリの読み込みに失敗しました。（" + fnc.strg.of_format( "{1}｜{2}｜{3}｜{4}", p_path, p_key, string( p_type ), string( p_value ) ) + "）")
//	return false
end if

return true

end function

public function string of_get_user_user_mei ();string	l_key	= "user_mei"
integer	l_type	= TYPE_STR

return of_get_user_registry( user_log_subkey, l_key, l_type )

end function

public function any of_get_os_printers ();string	l_os_printers[]

if not get_registries( reg_printer, l_os_printers ) then
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "of_get_os_printers", -999, "OSのプリンタ情報の読み込みに失敗しました。（" + reg_printer + "）")
	setnull( l_os_printers )
end if

return l_os_printers
end function

private function string get_path_user (string p_sub_path);if len( p_sub_path ) > 0 then
	return target_path + "\" + user_subkey + "\" + p_sub_path
else
	return target_path + "\" + user_subkey
end if
end function

private function string get_path_device (string p_sub_path);if len( p_sub_path ) > 0 then
	return target_path + "\" + device_subkey + "\" + p_sub_path
else
	return target_path + "\" + device_subkey
end if
end function

private function string get_path_app (string p_sub_path);if len( p_sub_path ) > 0 then
	return target_path + "\" + app_subkey + "\" + p_sub_path
else
	return target_path + "\" + app_subkey
end if
end function

public function any of_get_user_registry (string p_sub_path, string p_key, integer p_type);any	l_value

if not get_registry( get_path_user( p_sub_path ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function any of_get_user_registry (string p_key, integer p_type);any	l_value

if not get_registry( get_path_user( "" ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function any of_get_device_registry (string p_sub_path, string p_key, integer p_type);any	l_value

if not get_registry( get_path_device( p_sub_path ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function any of_get_device_registry (string p_key, integer p_type);any	l_value

if not get_registry( get_path_device( "" ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function any of_get_app_registry (string p_sub_path, string p_key, integer p_type);any	l_value

if not get_registry( get_path_app( p_sub_path ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function any of_get_app_registry (string p_key, integer p_type);any	l_value

if not get_registry( get_path_app( "" ), p_key, p_type, l_value ) then
	return setnull( l_value )
end if


return l_value
end function

public function string of_get_app_window_id ();string	l_key	= "id"
integer	l_type	= TYPE_STR

return of_get_app_registry( app_win_subkey, l_key, l_type )

end function

public function string of_get_app_window_name ();string	l_key	= "name"
integer	l_type	= TYPE_STR

return of_get_app_registry( app_win_subkey, l_key, l_type )

end function

public function string of_get_app_tab_id ();string	l_key	= "id"
integer	l_type	= TYPE_STR

return of_get_app_registry( app_tab_subkey, l_key, l_type )

end function

public function string of_get_app_tab_name ();string	l_key	= "name"
integer	l_type	= TYPE_STR

return of_get_app_registry( app_tab_subkey, l_key, l_type )

end function

public function string of_get_device_printer_lbp ();string	l_key	= "lbp_name"
integer	l_type	= TYPE_STR

return of_get_device_registry( device_prn_subkey, l_key, l_type )

end function

public function string of_get_device_printer_sdp ();string	l_key	= "sdp_name"
integer	l_type	= TYPE_STR

return of_get_device_registry( device_prn_subkey, l_key, l_type )

end function

public function string of_get_device_printer_lvp ();string	l_key	= "lvp_name"
integer	l_type	= TYPE_STR

return of_get_device_registry( device_prn_subkey, l_key, l_type )

end function

public function string of_get_device_printer_tgp ();string	l_key	= "tgp_name"
integer	l_type	= TYPE_STR

return of_get_device_registry( device_prn_subkey, l_key, l_type )

end function

public function boolean of_set_device_registry (string p_sub_path, string p_key, integer p_type, any p_value);return set_registry( get_path_device( p_sub_path ), p_key, p_type, string( p_value ) )

end function

public function boolean of_set_user_registry (string p_sub_path, string p_key, integer p_type, any p_value);return set_registry( get_path_user( p_sub_path ), p_key, p_type, string( p_value ) )

end function

public function boolean of_set_app_registry (string p_sub_path, string p_key, integer p_type, any p_value);return set_registry( get_path_app( p_sub_path ), p_key, p_type, string( p_value ) )
end function

public function boolean of_set_app_registry (string p_key, integer p_type, any p_value);return of_set_app_registry( "", p_key, p_type, p_value )
end function

public function boolean of_set_device_registry (string p_key, integer p_type, any p_value);return of_set_device_registry( "", p_key, p_type, p_value )

end function

public function boolean of_set_user_registry (string p_key, integer p_type, any p_value);return of_set_user_registry( "", p_key, p_type, p_value )

end function

public function boolean of_set_user_user_mei (string p_value);string	l_key	= "user_mei"
integer	l_type	= TYPE_STR

return of_set_user_registry( user_log_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_width (integer p_value);string	l_key	= "width"
integer	l_type	= TYPE_NUM

return of_set_app_registry( app_wub_siz_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_height (integer p_value);string	l_key	= "height"
integer	l_type	= TYPE_NUM

return of_set_app_registry( app_wub_siz_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_id (string p_value);string	l_key	= "id"
integer	l_type	= TYPE_STR

return of_set_app_registry( app_win_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_name (string p_value);string	l_key	= "name"
integer	l_type	= TYPE_STR

return of_set_app_registry( app_win_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_x (integer p_value);string	l_key	= "x"
integer	l_type	= TYPE_NUM

return of_set_app_registry( app_win_pos_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_window_y (integer p_value);string	l_key	= "y"
integer	l_type	= TYPE_NUM

return of_set_app_registry( app_win_pos_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_tab_id (string p_value);string	l_key	= "id"
integer	l_type	= TYPE_STR

return of_set_app_registry( app_tab_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_tab_name (string p_value);string	l_key	= "name"
integer	l_type	= TYPE_STR

return of_set_app_registry( app_tab_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_app_tab_position (integer p_value);string	l_key	= "position"
integer	l_type	= TYPE_NUM

return of_set_app_registry( app_tab_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_device_printer_lbp (string p_value);string	l_key	= "lbp_name"
integer	l_type	= TYPE_STR

return of_set_device_registry( device_prn_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_device_printer_lvp (string p_value);string	l_key	= "lvp_name"
integer	l_type	= TYPE_STR

return of_set_device_registry( device_prn_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_device_printer_sdp (string p_value);string	l_key	= "sdp_name"
integer	l_type	= TYPE_STR

return of_set_device_registry( device_prn_subkey, l_key, l_type, p_value )

end function

public function boolean of_set_device_printer_tgp (string p_value);string	l_key	= "tgp_name"
integer	l_type	= TYPE_STR

return of_set_device_registry( device_prn_subkey, l_key, l_type, p_value )

end function

public function integer of_get_app_window_x ();string	l_key	= "x"
integer	l_type	= TYPE_NUM

return of_get_app_registry( app_win_pos_subkey, l_key, l_type )

end function

public function integer of_get_app_window_y ();string	l_key	= "y"
integer	l_type	= TYPE_NUM

return of_get_app_registry( app_win_pos_subkey, l_key, l_type )

end function

public function integer of_get_app_window_width ();string	l_key	= "width"
integer	l_type	= TYPE_NUM

return of_get_app_registry( app_wub_siz_subkey, l_key, l_type )

end function

public function integer of_get_app_window_height ();string	l_key	= "height"
integer	l_type	= TYPE_NUM

return of_get_app_registry( app_wub_siz_subkey, l_key, l_type )

end function

public function integer of_get_app_tab_position ();string	l_key	= "position"
integer	l_type	= TYPE_NUM

return of_get_app_registry( app_tab_subkey, l_key, l_type )

end function

private function boolean set_registry (string p_path, string p_key, integer p_type, string p_value);string	l_str_value
long	l_lng_value

integer	l_ret

registryvaluetype	l_type

choose case p_type
	case TYPE_STR
		l_type		= RegString!
		l_str_value	= p_value
		
		l_ret	= registryset( p_path, p_key, l_type, l_str_value )
	case TYPE_NUM
		l_type	= ReguLong!

		if isnumber( string( p_value ) ) then
			l_lng_value	= long( p_value )

			l_ret	= registryset( p_path, p_key, l_type, l_lng_value )
		else
			txtlog.of_sys_alert( txtlog.TYPE_ALT, "set_registry", -999, "レジストリの書き込みで数値タイプが指定されましたが、数値に変換できません。（" + p_value + "）")
			return false
		end if
	case else
		l_type		= RegString!
		l_str_value	= p_value

		l_ret	= registryset( p_path, p_key, l_type, l_str_value )
end choose

if l_ret <> 1 then
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "set_registry", -999, "レジストリの書き込みに失敗しました。（" + fnc.strg.of_format( "{1}｜{2}｜{3}｜{4}", p_path, p_key, string( p_type ), p_value ) + "）")
	return false
end if

return true

end function

public function string of_get_dir_desktop ();constant string	l_key	= "Desktop"

return	get_special_folders( l_key )

end function

private function string get_special_folders (string p_key);constant integer	l_type	= TYPE_STR

any	l_value

get_registry(  reg_shelldir, p_key, l_type, l_value )

return string( l_value )
end function

public function string of_get_dir_documents ();constant string	l_key	= "Personal"

return	get_special_folders( l_key )

end function

public function boolean of_set_user_user_id (string p_value);string	l_key	= "user_id"
integer	l_type	= TYPE_STR

return of_set_user_registry( user_log_subkey, l_key, l_type, p_value )

end function

public function string of_get_user_user_id ();string	l_key	= "user_id"
integer	l_type	= TYPE_STR

return of_get_user_registry( user_log_subkey, l_key, l_type )

end function

public function string of_get_os_default_printer ();any	l_default_printer

if not get_registry( reg_printer_def, "Device", TYPE_STR, l_default_printer ) then
	txtlog.of_sys_alert( txtlog.TYPE_ALT, "of_get_os_default_printer", -999, "OSの通常使うプリンタ情報の読み込みに失敗しました。（" + reg_printer_def + "）")
	setnull( l_default_printer )
end if

// 取得したままは余計なものが入っているので除去
// 例）C5535(システム),winspool,Ne09:
l_default_printer	= left( l_default_printer, pos( l_default_printer, "," ) - 1 )

return l_default_printer
end function

on nv_registry.create
call super::create
end on

on nv_registry.destroy
call super::destroy
end on

event constructor;call super::constructor;target_path	= base_registry + "\" + base_key
end event

