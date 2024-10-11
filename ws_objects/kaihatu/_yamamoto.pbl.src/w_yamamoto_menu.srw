$PBExportHeader$w_yamamoto_menu.srw
$PBExportComments$金藤さんメニュー
forward
global type w_yamamoto_menu from iw_menu_window
end type
type st_1 from ivo_statictext within w_yamamoto_menu
end type
type cb_test from ivo_commandbutton within w_yamamoto_menu
end type
type cb_input_test from ivo_commandbutton within w_yamamoto_menu
end type
type cb_master_nendo from ivo_commandbutton within w_yamamoto_menu
end type
type cb_mm_teisu from ivo_commandbutton within w_yamamoto_menu
end type
type cb_teisu from ivo_commandbutton within w_yamamoto_menu
end type
type cb_ws_azukari_suito from ivo_commandbutton within w_yamamoto_menu
end type
type cb_per from ivo_commandbutton within w_yamamoto_menu
end type
type cb_jutyu from ivo_commandbutton within w_yamamoto_menu
end type
type cb_meisyo from ivo_commandbutton within w_yamamoto_menu
end type
type cb_hit from ivo_commandbutton within w_yamamoto_menu
end type
type cb_test_syohin from ivo_commandbutton within w_yamamoto_menu
end type
end forward

global type w_yamamoto_menu from iw_menu_window
string title = "山本さんメニュー"
boolean auto_generate_menu = false
st_1 st_1
cb_test cb_test
cb_input_test cb_input_test
cb_master_nendo cb_master_nendo
cb_mm_teisu cb_mm_teisu
cb_teisu cb_teisu
cb_ws_azukari_suito cb_ws_azukari_suito
cb_per cb_per
cb_jutyu cb_jutyu
cb_meisyo cb_meisyo
cb_hit cb_hit
cb_test_syohin cb_test_syohin
end type
global w_yamamoto_menu w_yamamoto_menu

type variables

end variables

on w_yamamoto_menu.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_test=create cb_test
this.cb_input_test=create cb_input_test
this.cb_master_nendo=create cb_master_nendo
this.cb_mm_teisu=create cb_mm_teisu
this.cb_teisu=create cb_teisu
this.cb_ws_azukari_suito=create cb_ws_azukari_suito
this.cb_per=create cb_per
this.cb_jutyu=create cb_jutyu
this.cb_meisyo=create cb_meisyo
this.cb_hit=create cb_hit
this.cb_test_syohin=create cb_test_syohin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_test
this.Control[iCurrent+3]=this.cb_input_test
this.Control[iCurrent+4]=this.cb_master_nendo
this.Control[iCurrent+5]=this.cb_mm_teisu
this.Control[iCurrent+6]=this.cb_teisu
this.Control[iCurrent+7]=this.cb_ws_azukari_suito
this.Control[iCurrent+8]=this.cb_per
this.Control[iCurrent+9]=this.cb_jutyu
this.Control[iCurrent+10]=this.cb_meisyo
this.Control[iCurrent+11]=this.cb_hit
this.Control[iCurrent+12]=this.cb_test_syohin
end on

on w_yamamoto_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_test)
destroy(this.cb_input_test)
destroy(this.cb_master_nendo)
destroy(this.cb_mm_teisu)
destroy(this.cb_teisu)
destroy(this.cb_ws_azukari_suito)
destroy(this.cb_per)
destroy(this.cb_jutyu)
destroy(this.cb_meisyo)
destroy(this.cb_hit)
destroy(this.cb_test_syohin)
end on

type uo_signal from iw_menu_window`uo_signal within w_yamamoto_menu
end type

type st_date from iw_menu_window`st_date within w_yamamoto_menu
end type

type st_user_mei from iw_menu_window`st_user_mei within w_yamamoto_menu
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_yamamoto_menu
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_yamamoto_menu
end type

type st_title from iw_menu_window`st_title within w_yamamoto_menu
end type

type st_title_upper from iw_menu_window`st_title_upper within w_yamamoto_menu
end type

type st_upper from iw_menu_window`st_upper within w_yamamoto_menu
end type

type tab_menu from iw_menu_window`tab_menu within w_yamamoto_menu
boolean visible = false
integer x = 4
integer y = 139
integer width = 80
integer height = 82
integer taborder = 0
end type

type pb_exit from iw_menu_window`pb_exit within w_yamamoto_menu
integer taborder = 0
end type

type pb_logoff from iw_menu_window`pb_logoff within w_yamamoto_menu
integer taborder = 0
end type

type shl_notifi from iw_menu_window`shl_notifi within w_yamamoto_menu
end type

type uo_band_message from iw_menu_window`uo_band_message within w_yamamoto_menu
end type

type st_1 from ivo_statictext within w_yamamoto_menu
boolean visible = false
integer x = 2120
integer y = 206
integer width = 2108
boolean bringtotop = true
end type

event constructor;call super::constructor;string	l_text	= "123456789"

st_1.text	= fnc.strg.of_substr( l_text, "2", "8" )

// 2～8 になるか ←こっちが理想
// 3～7 になるか ←こっちだった
end event

type cb_test from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 409
integer width = 700
integer taborder = 10
boolean bringtotop = true
string text = "テスト"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_yamamoto_test"

open( l_win, l_win_name )

end event

type cb_input_test from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 526
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "入力フォームテスト"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_yamamoto_test_input"

open( l_win, l_win_name )

end event

type cb_master_nendo from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 761
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "事業年度登録"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_master_nendo"

open( l_win, l_win_name )

end event

type cb_mm_teisu from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 644
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "定数登録"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "wmm_teisu"

open( l_win, l_win_name )

end event

type cb_teisu from ivo_commandbutton within w_yamamoto_menu
integer x = 3056
integer y = 526
integer width = 700
boolean bringtotop = true
string text = "得意先マスタメンテナンス"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_master_tokui"

open( l_win, l_win_name )

end event

type cb_ws_azukari_suito from ivo_commandbutton within w_yamamoto_menu
integer x = 3056
integer y = 647
integer width = 700
boolean bringtotop = true
string text = "預り出納照会"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "ws_azukari_suito"

open( l_win, l_win_name )

end event

type cb_per from ivo_commandbutton within w_yamamoto_menu
integer x = 3056
integer y = 405
integer width = 700
boolean bringtotop = true
string text = "テスト2個目"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_yamamoto_test02"

open( l_win, l_win_name )

end event

type cb_jutyu from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 878
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "受注入力"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_juchu_01"

open( l_win, l_win_name )

end event

type cb_meisyo from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 996
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "名称登録"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "wmm_meisyo"

open( l_win, l_win_name )

end event

type cb_hit from ivo_commandbutton within w_yamamoto_menu
integer x = 92
integer y = 1113
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "HITさんメニュー"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_hit_menu"

open( l_win, l_win_name )

end event

type cb_test_syohin from ivo_commandbutton within w_yamamoto_menu
integer x = 3056
integer y = 768
integer width = 700
boolean bringtotop = true
string text = "入力フォーム動作テスト"
boolean enter2tab = false
end type

event execution;call super::execution;window	l_win
string	l_win_name

l_win_name	= "w_test_syohin"

open( l_win, l_win_name )

end event

