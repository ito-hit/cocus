$PBExportHeader$w_test_modal.srw
$PBExportComments$モーダルテスト
forward
global type w_test_modal from iw_menu_window
end type
type cb_9 from ivo_commandbutton within w_test_modal
end type
type cb_meisyo_parent from ivo_commandbutton within w_test_modal
end type
type st_usercode from sv_st_meisyo within w_test_modal
end type
type st_usermei from sv_st_meisyo within w_test_modal
end type
type st_meisyo_parent from sv_st_meisyo within w_test_modal
end type
type cb_meisyo from ivo_commandbutton within w_test_modal
end type
type sle_meisyo from ivo_singlelineedit within w_test_modal
end type
type st_meisyo_code from sv_st_meisyo within w_test_modal
end type
type st_meisyo_1 from sv_st_meisyo within w_test_modal
end type
type st_meisyo_2 from sv_st_meisyo within w_test_modal
end type
type st_meisyo_3 from sv_st_meisyo within w_test_modal
end type
type cb_syohin from ivo_commandbutton within w_test_modal
end type
type st_syohin_code from sv_st_meisyo within w_test_modal
end type
type st_iro_ban from sv_st_meisyo within w_test_modal
end type
type st_size_mei from sv_st_meisyo within w_test_modal
end type
type cb_tab from ivo_commandbutton within w_test_modal
end type
type sle_menu_id from ivo_singlelineedit within w_test_modal
end type
type st_tab_id from sv_st_meisyo within w_test_modal
end type
type cb_menu from ivo_commandbutton within w_test_modal
end type
type st_menu from sv_st_meisyo within w_test_modal
end type
type cb_tokui from ivo_commandbutton within w_test_modal
end type
type st_tokui from sv_st_meisyo within w_test_modal
end type
type cb_mise from ivo_commandbutton within w_test_modal
end type
type sle_tokui_code from ivo_singlelineedit within w_test_modal
end type
type st_tokui_code from sv_st_meisyo within w_test_modal
end type
type st_mise from sv_st_meisyo within w_test_modal
end type
type st_tokui_mei from sv_st_meisyo within w_test_modal
end type
end forward

global type w_test_modal from iw_menu_window
string title = "テストメニュー"
boolean auto_generate_menu = false
cb_9 cb_9
cb_meisyo_parent cb_meisyo_parent
st_usercode st_usercode
st_usermei st_usermei
st_meisyo_parent st_meisyo_parent
cb_meisyo cb_meisyo
sle_meisyo sle_meisyo
st_meisyo_code st_meisyo_code
st_meisyo_1 st_meisyo_1
st_meisyo_2 st_meisyo_2
st_meisyo_3 st_meisyo_3
cb_syohin cb_syohin
st_syohin_code st_syohin_code
st_iro_ban st_iro_ban
st_size_mei st_size_mei
cb_tab cb_tab
sle_menu_id sle_menu_id
st_tab_id st_tab_id
cb_menu cb_menu
st_menu st_menu
cb_tokui cb_tokui
st_tokui st_tokui
cb_mise cb_mise
sle_tokui_code sle_tokui_code
st_tokui_code st_tokui_code
st_mise st_mise
st_tokui_mei st_tokui_mei
end type
global w_test_modal w_test_modal

on w_test_modal.create
int iCurrent
call super::create
this.cb_9=create cb_9
this.cb_meisyo_parent=create cb_meisyo_parent
this.st_usercode=create st_usercode
this.st_usermei=create st_usermei
this.st_meisyo_parent=create st_meisyo_parent
this.cb_meisyo=create cb_meisyo
this.sle_meisyo=create sle_meisyo
this.st_meisyo_code=create st_meisyo_code
this.st_meisyo_1=create st_meisyo_1
this.st_meisyo_2=create st_meisyo_2
this.st_meisyo_3=create st_meisyo_3
this.cb_syohin=create cb_syohin
this.st_syohin_code=create st_syohin_code
this.st_iro_ban=create st_iro_ban
this.st_size_mei=create st_size_mei
this.cb_tab=create cb_tab
this.sle_menu_id=create sle_menu_id
this.st_tab_id=create st_tab_id
this.cb_menu=create cb_menu
this.st_menu=create st_menu
this.cb_tokui=create cb_tokui
this.st_tokui=create st_tokui
this.cb_mise=create cb_mise
this.sle_tokui_code=create sle_tokui_code
this.st_tokui_code=create st_tokui_code
this.st_mise=create st_mise
this.st_tokui_mei=create st_tokui_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_9
this.Control[iCurrent+2]=this.cb_meisyo_parent
this.Control[iCurrent+3]=this.st_usercode
this.Control[iCurrent+4]=this.st_usermei
this.Control[iCurrent+5]=this.st_meisyo_parent
this.Control[iCurrent+6]=this.cb_meisyo
this.Control[iCurrent+7]=this.sle_meisyo
this.Control[iCurrent+8]=this.st_meisyo_code
this.Control[iCurrent+9]=this.st_meisyo_1
this.Control[iCurrent+10]=this.st_meisyo_2
this.Control[iCurrent+11]=this.st_meisyo_3
this.Control[iCurrent+12]=this.cb_syohin
this.Control[iCurrent+13]=this.st_syohin_code
this.Control[iCurrent+14]=this.st_iro_ban
this.Control[iCurrent+15]=this.st_size_mei
this.Control[iCurrent+16]=this.cb_tab
this.Control[iCurrent+17]=this.sle_menu_id
this.Control[iCurrent+18]=this.st_tab_id
this.Control[iCurrent+19]=this.cb_menu
this.Control[iCurrent+20]=this.st_menu
this.Control[iCurrent+21]=this.cb_tokui
this.Control[iCurrent+22]=this.st_tokui
this.Control[iCurrent+23]=this.cb_mise
this.Control[iCurrent+24]=this.sle_tokui_code
this.Control[iCurrent+25]=this.st_tokui_code
this.Control[iCurrent+26]=this.st_mise
this.Control[iCurrent+27]=this.st_tokui_mei
end on

on w_test_modal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_9)
destroy(this.cb_meisyo_parent)
destroy(this.st_usercode)
destroy(this.st_usermei)
destroy(this.st_meisyo_parent)
destroy(this.cb_meisyo)
destroy(this.sle_meisyo)
destroy(this.st_meisyo_code)
destroy(this.st_meisyo_1)
destroy(this.st_meisyo_2)
destroy(this.st_meisyo_3)
destroy(this.cb_syohin)
destroy(this.st_syohin_code)
destroy(this.st_iro_ban)
destroy(this.st_size_mei)
destroy(this.cb_tab)
destroy(this.sle_menu_id)
destroy(this.st_tab_id)
destroy(this.cb_menu)
destroy(this.st_menu)
destroy(this.cb_tokui)
destroy(this.st_tokui)
destroy(this.cb_mise)
destroy(this.sle_tokui_code)
destroy(this.st_tokui_code)
destroy(this.st_mise)
destroy(this.st_tokui_mei)
end on

type uo_signal from iw_menu_window`uo_signal within w_test_modal
end type

type st_date from iw_menu_window`st_date within w_test_modal
end type

type st_user_mei from iw_menu_window`st_user_mei within w_test_modal
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_test_modal
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_test_modal
end type

type st_title from iw_menu_window`st_title within w_test_modal
end type

type st_title_upper from iw_menu_window`st_title_upper within w_test_modal
end type

type st_upper from iw_menu_window`st_upper within w_test_modal
end type

type tab_menu from iw_menu_window`tab_menu within w_test_modal
boolean visible = false
integer x = 12
integer y = 146
integer width = 96
integer height = 78
end type

type pb_exit from iw_menu_window`pb_exit within w_test_modal
integer taborder = 140
end type

type pb_logoff from iw_menu_window`pb_logoff within w_test_modal
integer taborder = 130
end type

type shl_notifi from iw_menu_window`shl_notifi within w_test_modal
end type

type uo_band_message from iw_menu_window`uo_band_message within w_test_modal
integer taborder = 150
end type

type cb_9 from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 373
integer width = 700
integer taborder = 20
string text = "モーダル（ユーザー）"
end type

event clicked;call super::clicked;str_mdlpara_user l_user

l_user	= mdl.of_open_modal( "w_modal_user", l_user )

if l_user.ret then
	st_usercode.text	= l_user.out_user_id
	st_usermei.text		= l_user.out_user_mei
end if

end event

type cb_meisyo_parent from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 498
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "モーダル（名称区分）"
end type

event clicked;call super::clicked;str_mdlpara_meisyo_parent l_meisyo_parent

// inパラメータがあるときは記述必要
// l_user.user_id	= sle_user.test

l_meisyo_parent	= mdl.of_open_modal( "w_modal_meisyo_parent", l_meisyo_parent )

if l_meisyo_parent.ret then
	st_meisyo_parent.text	= l_meisyo_parent.out_meisyo_code
end if

end event

type st_usercode from sv_st_meisyo within w_test_modal
integer x = 776
integer y = 377
boolean bringtotop = true
end type

type st_usermei from sv_st_meisyo within w_test_modal
integer x = 1088
integer y = 373
integer width = 468
boolean bringtotop = true
end type

type st_meisyo_parent from sv_st_meisyo within w_test_modal
integer x = 776
integer y = 505
boolean bringtotop = true
end type

type cb_meisyo from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 622
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "モーダル（名称）"
end type

event clicked;call super::clicked;str_mdlpara_meisyo l_meisyo

//l_meisyo.meisyo_kbn	= 100
l_meisyo.in_meisyo_kbn	= long( sle_meisyo.text )

l_meisyo	= mdl.of_open_modal( "w_modal_meisyo", l_meisyo )

if l_meisyo.ret then
	st_meisyo_code.text	= l_meisyo.out_meisyo_code
	st_meisyo_1.text	= l_meisyo.out_meisyo_1
	st_meisyo_2.text	= l_meisyo.out_meisyo_2
	st_meisyo_3.text	= l_meisyo.out_meisyo_3
end if
end event

type sle_meisyo from ivo_singlelineedit within w_test_modal
integer x = 776
integer y = 622
integer taborder = 50
boolean bringtotop = true
string text = ""
end type

type st_meisyo_code from sv_st_meisyo within w_test_modal
integer x = 1096
integer y = 629
boolean bringtotop = true
end type

type st_meisyo_1 from sv_st_meisyo within w_test_modal
integer x = 1416
integer y = 629
boolean bringtotop = true
end type

type st_meisyo_2 from sv_st_meisyo within w_test_modal
integer x = 1736
integer y = 629
boolean bringtotop = true
end type

type st_meisyo_3 from sv_st_meisyo within w_test_modal
integer x = 2056
integer y = 629
boolean bringtotop = true
end type

type cb_syohin from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 747
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "モーダル（商品）"
end type

event clicked;call super::clicked;str_mdlpara_syohin l_syohin

//l_syohin.in_syohin_kbn	= long( sle_syohin.text )

l_syohin	= mdl.of_open_modal( "w_modal_syohin", l_syohin )

if l_syohin.ret then
	st_syohin_code.text	= string( l_syohin.out_syohin_code )
	st_iro_ban.text		= string( l_syohin.out_iro_no )
	st_size_mei.text	= string( l_syohin.out_size_mei )
end if
end event

type st_syohin_code from sv_st_meisyo within w_test_modal
integer x = 776
integer y = 754
boolean bringtotop = true
end type

type st_iro_ban from sv_st_meisyo within w_test_modal
integer x = 1096
integer y = 754
boolean bringtotop = true
end type

type st_size_mei from sv_st_meisyo within w_test_modal
integer x = 1416
integer y = 754
boolean bringtotop = true
end type

type cb_tab from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 878
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "モーダル（タブ）"
end type

event clicked;call super::clicked;str_mdlpara_tab		l_tab
//str_mdlpara_menu	l_menu

//l_tab.tab_kbn	= 100
l_tab.in_menu_id	= sle_menu_id.text //l_menu.out_menu_id

l_tab	= mdl.of_open_modal( "w_modal_tab", l_tab )

if l_tab.ret then
	st_tab_id.text	= l_tab.out_tab_id
end if
end event

type sle_menu_id from ivo_singlelineedit within w_test_modal
integer x = 776
integer y = 878
integer width = 600
integer taborder = 80
boolean bringtotop = true
string text = ""
end type

type st_tab_id from sv_st_meisyo within w_test_modal
integer x = 1416
integer y = 885
integer width = 628
boolean bringtotop = true
end type

type cb_menu from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 1006
integer width = 700
integer taborder = 90
boolean bringtotop = true
string text = "モーダル（メニュー）"
end type

event clicked;call super::clicked;str_mdlpara_menu l_menu

// inパラメータがあるときは記述必要
// l_user.user_id	= sle_user.test

l_menu	= mdl.of_open_modal( "w_modal_menu", l_menu )

if l_menu.ret then
	st_menu.text		= l_menu.out_menu_id
	sle_menu_id.text	= l_menu.out_menu_id
end if
end event

type st_menu from sv_st_meisyo within w_test_modal
integer x = 776
integer y = 1013
integer width = 628
boolean bringtotop = true
end type

type cb_tokui from ivo_commandbutton within w_test_modal
integer x = 56
integer y = 1145
integer width = 700
integer taborder = 100
boolean bringtotop = true
string text = "モーダル（得意先）"
end type

event clicked;call super::clicked;str_mdlpara_tokui l_tokui

l_tokui	= mdl.of_open_modal( "w_modal_tokui", l_tokui )

if l_tokui.ret then
	st_tokui.text		= string( l_tokui.out_tokui_code )
	st_tokui_mei.text	= string( l_tokui.out_tokui_mei )
end if

end event

type st_tokui from sv_st_meisyo within w_test_modal
integer x = 776
integer y = 1152
boolean bringtotop = true
end type

type cb_mise from ivo_commandbutton within w_test_modal
integer x = 60
integer y = 1276
integer width = 700
integer taborder = 110
boolean bringtotop = true
string text = "モーダル（店）"
end type

event clicked;call super::clicked;str_mdlpara_mise l_mise

l_mise.in_tokui_code	= long( trim( sle_tokui_code.text ) )

l_mise	= mdl.of_open_modal( "w_modal_mise", l_mise )

if l_mise.ret then
	st_tokui_code.text	= string( l_mise.out_tokui_code )
	st_mise.text		= string( l_mise.out_mise_code )
end if

end event

type sle_tokui_code from ivo_singlelineedit within w_test_modal
integer x = 776
integer y = 1276
integer taborder = 120
boolean bringtotop = true
string text = ""
end type

type st_tokui_code from sv_st_meisyo within w_test_modal
integer x = 1096
integer y = 1284
boolean bringtotop = true
end type

type st_mise from sv_st_meisyo within w_test_modal
integer x = 1416
integer y = 1284
boolean bringtotop = true
end type

type st_tokui_mei from sv_st_meisyo within w_test_modal
integer x = 1096
integer y = 1152
integer width = 628
boolean bringtotop = true
end type

