$PBExportHeader$liberation.sra
$PBExportComments$新基幹システムアプリケーション
forward
global type liberation from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
constant integer	kengen_admin	= 1	// 権限管理マスタ「システム管理者権限」

// ユーザー関数（共通）
nv_func		fnc
//nv_dbfunc	dbfnc

// メッセージ関数
nv_message	msg

// 定数
nv_code		code

// 運用管理
nv_unyo		unyo

// 権限管理
nv_kengen	kengen

// ウインドウ管理
nv_window	winctl

// モーダル
nv_modal	mdl

// メール送信
nv_smtp		mail

// 悲観ロック関数
nv_lock		lck

str_app		app		// アプリケーション管理
str_device	device	// デバイス管理
str_user	user	// ユーザー管理

str_palette	palette	// システムカラー情報

inv_transaction	cocos, syukkadb, seisandb, bunsekidb, edidb, faxdb, logdb, host, systemdb

boolean	test_mode


end variables
global type liberation from application
string appname = "liberation"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "image\main.ico"
string appruntimeversion = "19.2.0.2803"
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global liberation liberation

on liberation.create
appname="liberation"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on liberation.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;nv_startup	l_startup

// 開始処理
l_startup	= create nv_startup
l_startup.of_execute()

destroy l_startup

end event

event close;nv_shutdown	l_shutdown

// 終了処理
l_shutdown	= create nv_shutdown
l_shutdown.of_execute()

destroy l_shutdown 

end event

