$PBExportHeader$w_kin_menu.srw
$PBExportComments$金藤さんメニュー
forward
global type w_kin_menu from iw_menu_window
end type
type cb_1 from ivo_commandbutton within w_kin_menu
end type
type cb_2 from ivo_commandbutton within w_kin_menu
end type
type cb_3 from ivo_commandbutton within w_kin_menu
end type
type cb_6 from ivo_commandbutton within w_kin_menu
end type
type cb_7 from ivo_commandbutton within w_kin_menu
end type
type cb_9 from ivo_commandbutton within w_kin_menu
end type
type cb_8 from ivo_commandbutton within w_kin_menu
end type
type cb_12 from ivo_commandbutton within w_kin_menu
end type
type cb_13 from ivo_commandbutton within w_kin_menu
end type
type cb_14 from ivo_commandbutton within w_kin_menu
end type
type cb_19 from ivo_commandbutton within w_kin_menu
end type
type cb_5 from ivo_commandbutton within w_kin_menu
end type
type cb_4 from ivo_commandbutton within w_kin_menu
end type
type cb_10 from ivo_commandbutton within w_kin_menu
end type
type uo_1 from sv_ddplb_nendo within w_kin_menu
end type
type ddplb_1 from sv_ddplb_meisyo within w_kin_menu
end type
type cb_11 from ivo_commandbutton within w_kin_menu
end type
end forward

global type w_kin_menu from iw_menu_window
string title = "金藤さんメニュー"
boolean auto_generate_menu = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_6 cb_6
cb_7 cb_7
cb_9 cb_9
cb_8 cb_8
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
cb_19 cb_19
cb_5 cb_5
cb_4 cb_4
cb_10 cb_10
uo_1 uo_1
ddplb_1 ddplb_1
cb_11 cb_11
end type
global w_kin_menu w_kin_menu

forward prototypes
public function boolean of_exists_syohin (long p_syohin_code)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
end prototypes

public function boolean of_exists_syohin (long p_syohin_code);long	l_cnt

select count(*)
  into :l_cnt
  from m_syohin
 where syohin_code	= :p_syohin_code
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true

end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);
select hin_ban,hin_mei,iro_mei
  into :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
   and size_code	= :p_size_code
using cocos;

if cocos.sqlcode <> 0 then
	return false
end if

return true
end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);long	l_cnt

select count(*),
       max( hin_ban ),max( hin_mei ),max( iro_mei )
  into :l_cnt,
       :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true


end function

on w_kin_menu.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_19=create cb_19
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_10=create cb_10
this.uo_1=create uo_1
this.ddplb_1=create ddplb_1
this.cb_11=create cb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_6
this.Control[iCurrent+5]=this.cb_7
this.Control[iCurrent+6]=this.cb_9
this.Control[iCurrent+7]=this.cb_8
this.Control[iCurrent+8]=this.cb_12
this.Control[iCurrent+9]=this.cb_13
this.Control[iCurrent+10]=this.cb_14
this.Control[iCurrent+11]=this.cb_19
this.Control[iCurrent+12]=this.cb_5
this.Control[iCurrent+13]=this.cb_4
this.Control[iCurrent+14]=this.cb_10
this.Control[iCurrent+15]=this.uo_1
this.Control[iCurrent+16]=this.ddplb_1
this.Control[iCurrent+17]=this.cb_11
end on

on w_kin_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_19)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_10)
destroy(this.uo_1)
destroy(this.ddplb_1)
destroy(this.cb_11)
end on

event resize;call super::resize;
end event

type uo_signal from iw_menu_window`uo_signal within w_kin_menu
end type

type st_date from iw_menu_window`st_date within w_kin_menu
end type

type st_user_mei from iw_menu_window`st_user_mei within w_kin_menu
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_kin_menu
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_kin_menu
end type

type st_title from iw_menu_window`st_title within w_kin_menu
end type

type st_title_upper from iw_menu_window`st_title_upper within w_kin_menu
end type

type st_upper from iw_menu_window`st_upper within w_kin_menu
end type

type tab_menu from iw_menu_window`tab_menu within w_kin_menu
boolean visible = false
integer x = 20
integer y = 149
integer width = 52
integer height = 50
boolean enabled = false
end type

type pb_exit from iw_menu_window`pb_exit within w_kin_menu
end type

type pb_logoff from iw_menu_window`pb_logoff within w_kin_menu
end type

type shl_notifi from iw_menu_window`shl_notifi within w_kin_menu
end type

type uo_band_message from iw_menu_window`uo_band_message within w_kin_menu
end type

type cb_1 from ivo_commandbutton within w_kin_menu
integer x = 36
integer y = 384
integer width = 700
integer taborder = 10
boolean bringtotop = true
string text = "ユーザー登録"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "wmm_user"

open( l_win, l_win_name )
end event

type cb_2 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 384
integer width = 700
integer taborder = 10
boolean bringtotop = true
string text = "マルチスレッドテスト"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_test_multi"

open( l_win, l_win_name )
end event

type cb_3 from ivo_commandbutton within w_kin_menu
integer x = 32
integer y = 491
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "印刷画面（サンプル）"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "wp_kin_test"

open( l_win, l_win_name )
end event

type cb_6 from ivo_commandbutton within w_kin_menu
integer x = 32
integer y = 697
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "帯メッセージ表示"
end type

event clicked;call super::clicked;messagebox( "","" )
//uo_band_msg.transparency	= 100
//uo_band_msg.visible			= true
//
//uo_band_msg.setredraw( true )
//
//uo_band_msg.of_show( "現在システムは運用停止状態です。速やかに終了するようにお願いします。" )
end event

type cb_7 from ivo_commandbutton within w_kin_menu
integer x = 32
integer y = 796
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "メール送信テスト"
end type

event clicked;call super::clicked;mail.of_send_mail( "maverick.hiro08@gmail.com", "テストメール", "powerbuilerからのメール送信" )
end event

type cb_9 from ivo_commandbutton within w_kin_menu
integer x = 28
integer y = 903
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "帯メッセージ終了"
end type

event clicked;call super::clicked;//uo_band_msg.transparency	= 100
//uo_band_msg.visible			= true
//
//uo_band_msg.setredraw( true )
//
uo_band_message.of_hide()
end event

type cb_8 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 491
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "通知画面"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_tuuti"

open( l_win, l_win_name )
end event

type cb_12 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 587
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "通知管理登録"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_tuuti_kanri"

open( l_win, l_win_name )
end event

type cb_13 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 683
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "通知管理登録テスト"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_tuuti_kin"

open( l_win, l_win_name )
end event

type cb_14 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 779
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "通知管理登録テスト2"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_tuuti_kin2"

open( l_win, l_win_name )
end event

type cb_19 from ivo_commandbutton within w_kin_menu
integer x = 28
integer y = 1188
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "WebAPIテスト(銀行取得)"
end type

event clicked;call super::clicked;
nv_webapi	l_api

l_api	= create nv_webapi

l_api.of_test( )

destroy l_api
end event

type cb_5 from ivo_commandbutton within w_kin_menu
integer x = 28
integer y = 1280
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "WebAPIテスト(Teams送信)"
end type

event clicked;call super::clicked;
nv_webapi_teams	l_teams

l_teams	= create nv_webapi_teams

l_teams.of_send( "テスト", "メッセージ送信" )

destroy l_teams

//LibraryDirectoryEx
end event

type cb_4 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 871
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "サンプル"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_kin_sample"

open( l_win, l_win_name )
end event

type cb_10 from ivo_commandbutton within w_kin_menu
integer x = 788
integer y = 971
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "nvテスト"
end type

event clicked;call super::clicked;
nv_kin_test	l_kin


l_kin	= create nv_kin_test

l_kin.of_start( )

destroy l_kin
end event

type uo_1 from sv_ddplb_nendo within w_kin_menu
integer x = 1836
integer y = 700
integer height = 103
integer taborder = 60
boolean bringtotop = true
boolean enabled_null = true
boolean enabled_all = true
end type

on uo_1.destroy
call sv_ddplb_nendo::destroy
end on

type ddplb_1 from sv_ddplb_meisyo within w_kin_menu
integer x = 1736
integer y = 434
integer taborder = 30
boolean bringtotop = true
boolean enabled_null = true
end type

type cb_11 from ivo_commandbutton within w_kin_menu
integer x = 2456
integer y = 437
integer taborder = 40
boolean bringtotop = true
end type

event clicked;call super::clicked;
ddplb_1.event constructor()
end event

