$PBExportHeader$nv_authenticated.sru
$PBExportComments$ログイン後のユーザーコントロールに関するスクリプト
forward
global type nv_authenticated from inv_object
end type
end forward

global type nv_authenticated from inv_object
end type
global nv_authenticated nv_authenticated

forward prototypes
private function boolean set_profile ()
public function boolean of_start ()
private function boolean set_mail_profile ()
public function boolean of_release ()
end prototypes

private function boolean set_profile ();// レジストリに登録されたユーザー以外の情報をプロパティにセット
nv_registry	l_reg

l_reg	= create nv_registry

app.window.id			= l_reg.of_get_app_window_id()
app.window.name			= l_reg.of_get_app_window_name()

app.window.position.x	= l_reg.of_get_app_window_x()
app.window.position.y	= l_reg.of_get_app_window_y()

app.window.size.width	= l_reg.of_get_app_window_width()
app.window.size.height	= l_reg.of_get_app_window_height()

app.tab.id				= l_reg.of_get_app_tab_id()
app.tab.name			= l_reg.of_get_app_tab_name()
app.tab.position		= l_reg.of_get_app_tab_position()

device.name				= fnc.of_get_computer_name( )
device.ipv4_addr		= ""
device.ipv6_addr		= ""
device.mac_addr			= ""

device.printer.lbp_name	= l_reg.of_get_device_printer_lbp()
device.printer.sdp_name	= l_reg.of_get_device_printer_sdp()
device.printer.lvp_name	= l_reg.of_get_device_printer_lvp()
device.printer.tgp_name	= l_reg.of_get_device_printer_tgp()

device.folder.desktop	= l_reg.of_get_dir_desktop()
device.folder.documents	= l_reg.of_get_dir_documents()

destroy l_reg

return true
end function

public function boolean of_start ();
// ユーザー情報以外のプロパティ情報をセット
if not set_profile() then
	return false
end if

// メール送信に関するユーザー情報セット
if not set_mail_profile() then
	return false
end if

// システムトレイ準備
//winctl.of_open( "w_tuuti" )


// 初期画面オープン
window 	l_win
string	l_menu

l_menu	= string( user.init_menu_id )

open( l_win, l_menu )


return true
 
end function

private function boolean set_mail_profile ();string	l_userid
string	l_password
string	l_from_addr
string	l_from_name

l_userid	= fnc.strg.of_replace( user.mail_address, "@", "%" )
l_password	= user.password
l_from_addr	= user.mail_address
l_from_name	= user.user_mei

mail.of_init_settings( l_userid, l_password, l_from_addr, l_from_name )

return true
end function

public function boolean of_release ();// ログイン時にセットされたユーザー情報をクリアする
str_app		l_app
str_device	l_device
str_user	l_user

string	l_userid, l_password, l_from_addr, l_from_name

setnull( l_userid )
setnull( l_password )
setnull( l_from_addr )
setnull( l_from_name )

// プロファイルクリア
l_user.login	= user.login

app		= l_app
device	= l_device
user	= l_user

// メールプロファイルクリア
mail.of_init_settings( l_userid, l_password, l_from_addr, l_from_name )

return true
 
end function

on nv_authenticated.create
call super::create
end on

on nv_authenticated.destroy
call super::destroy
end on

