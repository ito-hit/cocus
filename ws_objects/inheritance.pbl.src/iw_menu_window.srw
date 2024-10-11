$PBExportHeader$iw_menu_window.srw
$PBExportComments$aw_windowから継承したメニューウインドウの先祖オブジェクト
forward
global type iw_menu_window from aw_base_window
end type
type tab_menu from ivo_tab within iw_menu_window
end type
type tab_menu from ivo_tab within iw_menu_window
end type
type pb_exit from sv_pb_exit within iw_menu_window
end type
type pb_logoff from sv_pb_logoff within iw_menu_window
end type
type shl_notifi from ivo_statichyperlink within iw_menu_window
end type
type uo_band_message from cv_band_message within iw_menu_window
end type
type nv_notifi from nv_notification within iw_menu_window
end type
end forward

global type iw_menu_window from aw_base_window
integer width = 5152
integer height = 3360
string icon = "image\menu.ico"
boolean f5_key = true
boolean fnkey_enabled = false
tab_menu tab_menu
pb_exit pb_exit
pb_logoff pb_logoff
shl_notifi shl_notifi
uo_band_message uo_band_message
nv_notifi nv_notifi
end type
global iw_menu_window iw_menu_window

type variables

protected:
	boolean	auto_generate_menu	= true	// True:起動時にメニューマスタから自動生成 False:起動時に自動生成しない

private:
	constant string c_mymenu	= "マイメニュー"
	
	boolean	logoff, logout
end variables

forward prototypes
private function integer create_tab_menu (string p_tab_id)
public function string of_get_menu_id ()
private subroutine create_menu ()
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
end prototypes

private function integer create_tab_menu (string p_tab_id);cv_menu			l_menu
str_para_menu	l_para

integer			l_tab_index

l_para.menu_id	= i_pg_id
l_para.tab_id	= p_tab_id
l_para.param	= ""

l_tab_index	= upperbound( tab_menu.control ) + 1

tab_menu.opentabwithparm( l_menu, l_para, "cv_menu", l_tab_index )

return l_tab_index

end function

public function string of_get_menu_id ();return this.classname()
end function

private subroutine create_menu ();string	l_init_tab,l_tab
integer	l_idx

l_init_tab	= user.init_tab_id

// メニュー一覧(タブ一覧)を取得するカーソル
declare menu_cur cursor for
	select distinct tab_id
	  from m_menu
	 where menu_id	= :i_pg_id
using cocos;

open menu_cur;
if cocos.sqlcode <> 0 then
	msg.of_error_db( fnc.strg.of_format( "メニュー情報({1})の取得開始に失敗しました。", i_pg_id ), cocos )
else
	// 初回fetch
	fetch menu_cur into :l_tab;
	if cocos.sqlcode <> 0 then
		msg.of_error_db( fnc.strg.of_format( "メニュー情報({1})の取得に失敗しました。", i_pg_id ), cocos )
	else
		do until cocos.sqlcode <> 0
			// タブ生成
			l_idx	= create_tab_menu( l_tab )

			if l_init_tab = l_tab then
				tab_menu.selecttab( l_idx )
			end if

			// 次のレコード読み込み
			fetch menu_cur into :l_tab;
			choose case cocos.sqlcode
				case 0,100
				case else
					msg.of_error_db( fnc.strg.of_format( "メニュー情報({1})の取得に失敗しました。", i_pg_id ), cocos )
			end choose
		loop
	end if

	close menu_cur;
end if

// 最後にマイメニュータブを生成する
l_idx	= create_tab_menu( c_mymenu )

if l_init_tab = l_tab then
	tab_menu.selecttab( l_idx )
end if

tab_menu.control[l_idx].tabtextcolor	= rgb( 255, 0, 0 )

// 初期表示タブが存在しなかったら１番目のタブを選択する
if tab_menu.selectedtab = 0 then
	tab_menu.selecttab( 1 )
end if

end subroutine

public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled);
unsignedlong	l_keyflags
boolean			l_visible

choose case p_keycode
	case keyf1!
		f1_key	= p_enabled
	case keyf2!
		f2_key	= p_enabled
	case keyf3!
		f3_key	= p_enabled
	case keyf4!
		f4_key	= p_enabled
	case keyf5!
		f5_key	= p_enabled
	case keyf6!
		f6_key	= p_enabled
	case keyf7!
		f7_key	= p_enabled
	case keyf8!
		f8_key	= p_enabled
	case keyf9!
		f9_key	= p_enabled
	case keyf10!
		f10_key	= p_enabled
	case keyf11!
		f11_key	= p_enabled
	case keyf12!
		f12_key	= p_enabled
	case else
end choose

l_visible	= of_get_fnkey_visibled()

if l_visible then
	// 初期値設定
	key_fnc.base_function_name		= function_name
	key_fnc.base_function_enabled	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }

	key_fnc.base_sfunction_name		= sfunction_name
	key_fnc.base_sfunction_enabled	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }

	key_fnc.focusobj				= this

	key_fnc.of_set_fuction_name( )
	key_fnc.show()
else
	key_fnc.hide( )
end if

key_fnc.visible		= l_visible

end subroutine

on iw_menu_window.create
int iCurrent
call super::create
this.tab_menu=create tab_menu
this.pb_exit=create pb_exit
this.pb_logoff=create pb_logoff
this.shl_notifi=create shl_notifi
this.uo_band_message=create uo_band_message
this.nv_notifi=create nv_notifi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_menu
this.Control[iCurrent+2]=this.pb_exit
this.Control[iCurrent+3]=this.pb_logoff
this.Control[iCurrent+4]=this.shl_notifi
this.Control[iCurrent+5]=this.uo_band_message
end on

on iw_menu_window.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_menu)
destroy(this.pb_exit)
destroy(this.pb_logoff)
destroy(this.shl_notifi)
destroy(this.uo_band_message)
destroy(this.nv_notifi)
end on

event open;call super::open;
object_type	= "menu_window"

// window
integer	l_newwidth,l_newheight

l_newwidth	= pixelstounits( code.def_mnu_width, xpixelstounits! )
l_newheight	= pixelstounits( code.def_mnu_height, ypixelstounits! )

resize( l_newwidth, l_newheight )

if auto_generate_menu then
	create_menu()
end if

if not unyo.of_get_operation() then
	if not uo_band_message.of_running() then
		uo_band_message.of_show_error("システム運用時間外です。まだ作業中の場合は早めに作業を終えて終了してください。")
	end if
end if

// 通知情報取得のためタイマ起動(初回は直接起動)
event timer()
 timer( 5 )
end event

event resize;call super::resize;
if this.width < 3924 then
	this.width	= 3924
end if

pb_exit.x				= newwidth - pb_exit.width - code.MGN_YOKO
pb_exit.y				= newheight - pb_exit.height - 16

pb_logoff.x				= pb_exit.x - pb_logoff.width - code.MGN_GROUP_YOKO
pb_logoff.y				= pb_exit.y

tab_menu.x				= 0
tab_menu.y				= st_upper.y + st_upper.height
tab_menu.width			= newwidth
tab_menu.height			= pb_logoff.y - tab_menu.y - 16

shl_notifi.x			= st_user_mei.x + st_user_mei.width + 24
shl_notifi.y			= st_user_mei.y

uo_band_message.x		= 0
uo_band_message.y		= 257
uo_band_message.width	= newwidth

end event

event key_f10;call super::key_f10;//if msg.of_question( "終了しますか？" ) then
	close( this )
//end if

return 0
end event

event timer;call super::timer;long	l_notifi_cnt

l_notifi_cnt	= nv_notifi.of_get_notifi_cnt( )

if l_notifi_cnt <> 0 then
	shl_notifi.text	= fnc.strg.of_format( "未読通知があります({1})", string( l_notifi_cnt ) )
	shl_notifi.of_set_on( )
else
	shl_notifi.text	= fnc.strg.of_format( "未読通知はありません({1})", string( l_notifi_cnt ) )
	shl_notifi.of_set_off( )
end if
end event

event close;call super::close;// タイマ終了
timer( 0 )
end event

event key_f05;call super::key_f05;integer	l_row

for l_row = 1 to upperbound( tab_menu.control )
	tab_menu.control[l_row].dynamic of_reload()
next

return 0
end event

type uo_signal from aw_base_window`uo_signal within iw_menu_window
integer x = 4044
end type

type st_date from aw_base_window`st_date within iw_menu_window
integer x = 4700
end type

type st_user_mei from aw_base_window`st_user_mei within iw_menu_window
end type

type uo_test_mode from aw_base_window`uo_test_mode within iw_menu_window
integer x = 3380
integer y = 14
end type

event click_event;call super::click_event;uo_band_message.of_show_warning("そろそろシステム終了時刻となります。まだ作業中の場合は早めに作業を終えて終了してください。")
end event

type p_size_adjust from aw_base_window`p_size_adjust within iw_menu_window
integer x = 1632
end type

type st_title from aw_base_window`st_title within iw_menu_window
integer x = 2412
end type

type st_title_upper from aw_base_window`st_title_upper within iw_menu_window
integer x = 1752
end type

type st_upper from aw_base_window`st_upper within iw_menu_window
integer width = 5120
end type

type tab_menu from ivo_tab within iw_menu_window
integer x = 72
integer y = 164
integer width = 4424
integer taborder = 10
boolean bringtotop = true
boolean multiline = true
integer selectedtab = 0
boolean f5_key = true
end type

type pb_exit from sv_pb_exit within iw_menu_window
integer x = 3860
integer y = 1490
integer taborder = 20
boolean bringtotop = true
boolean cmdb_close = false
end type

event execution;call super::execution;winctl.post of_close( parent.classname(), false )
end event

type pb_logoff from sv_pb_logoff within iw_menu_window
integer x = 3192
integer y = 1493
integer taborder = 30
boolean bringtotop = true
boolean confirm_enabled = true
end type

event execution;call super::execution;winctl.post of_close( parent.classname(), true )
end event

type shl_notifi from ivo_statichyperlink within iw_menu_window
integer x = 444
integer y = 25
integer width = 672
boolean bringtotop = true
long textcolor = 255
string text = "※通知情報を取得中です..."
end type

type uo_band_message from cv_band_message within iw_menu_window
integer y = 256
boolean bringtotop = true
end type

on uo_band_message.destroy
call cv_band_message::destroy
end on

event constructor;call super::constructor;this.bringtotop	= true
end event

type nv_notifi from nv_notification within iw_menu_window descriptor "pb_nvo" = "true" 
end type

on nv_notifi.create
call super::create
end on

on nv_notifi.destroy
call super::destroy
end on

