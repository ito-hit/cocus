$PBExportHeader$w_yamamoto_test_input.srw
$PBExportComments$入力フォームのテスト画面
forward
global type w_yamamoto_test_input from iw_main_window
end type
type uo_tokui from cv_input_tokui within w_yamamoto_test_input
end type
type uo_mise from cv_input_mise within w_yamamoto_test_input
end type
type uo_tanto from cv_input_tanto within w_yamamoto_test_input
end type
type uo_menu from cv_input_menu within w_yamamoto_test_input
end type
type uo_tab from cv_input_tab within w_yamamoto_test_input
end type
type cb_syohizei from ivo_commandbutton within w_yamamoto_test_input
end type
type st_torihiki from ivo_statictext within w_yamamoto_test_input
end type
type st_syohizei from ivo_statictext within w_yamamoto_test_input
end type
type cb_torihiki from ivo_commandbutton within w_yamamoto_test_input
end type
type st_syusoku from ivo_statictext within w_yamamoto_test_input
end type
type cb_syusoku from ivo_commandbutton within w_yamamoto_test_input
end type
type st_syozoku from ivo_statictext within w_yamamoto_test_input
end type
type st_syozoku_code from sv_st_meisyo within w_yamamoto_test_input
end type
type st_syozoku_mei from sv_st_meisyo within w_yamamoto_test_input
end type
type st_eigyosyo from ivo_statictext within w_yamamoto_test_input
end type
type st_eigyosyo_code from sv_st_meisyo within w_yamamoto_test_input
end type
type st_eigyosyo_mei from sv_st_meisyo within w_yamamoto_test_input
end type
type st_ka from ivo_statictext within w_yamamoto_test_input
end type
type st_ka_code from sv_st_meisyo within w_yamamoto_test_input
end type
type st_ka_mei from sv_st_meisyo within w_yamamoto_test_input
end type
type st_bumon from ivo_statictext within w_yamamoto_test_input
end type
type cb_bumon from ivo_commandbutton within w_yamamoto_test_input
end type
type st_tanto from ivo_statictext within w_yamamoto_test_input
end type
type cb_tanto from ivo_commandbutton within w_yamamoto_test_input
end type
type uo_okuri_mise from cv_input_mise within w_yamamoto_test_input
end type
type uo_daibunrui from cv_input_bunrui within w_yamamoto_test_input
end type
type uo_tyubunrui from cv_input_bunrui within w_yamamoto_test_input
end type
type uo_syobunrui from cv_input_bunrui within w_yamamoto_test_input
end type
type uo_syohin from cv_input_syohin within w_yamamoto_test_input
end type
type cb_reset from ivo_commandbutton within w_yamamoto_test_input
end type
type uo_iro from cv_input within w_yamamoto_test_input
end type
type ddplb_syori from sv_ddplb_syori within w_yamamoto_test_input
end type
type uo_syohin2 from cv_input_syohin within w_yamamoto_test_input
end type
type uo_unso from cv_input_unso within w_yamamoto_test_input
end type
type uo_yubin from cv_input_yubin within w_yamamoto_test_input
end type
type uo_seikyu from cv_input_tokui_seikyu within w_yamamoto_test_input
end type
type uo_tokui_tanto from cv_input_tokui_tanto within w_yamamoto_test_input
end type
end forward

global type w_yamamoto_test_input from iw_main_window
string title = "テスト画面"
uo_tokui uo_tokui
uo_mise uo_mise
uo_tanto uo_tanto
uo_menu uo_menu
uo_tab uo_tab
cb_syohizei cb_syohizei
st_torihiki st_torihiki
st_syohizei st_syohizei
cb_torihiki cb_torihiki
st_syusoku st_syusoku
cb_syusoku cb_syusoku
st_syozoku st_syozoku
st_syozoku_code st_syozoku_code
st_syozoku_mei st_syozoku_mei
st_eigyosyo st_eigyosyo
st_eigyosyo_code st_eigyosyo_code
st_eigyosyo_mei st_eigyosyo_mei
st_ka st_ka
st_ka_code st_ka_code
st_ka_mei st_ka_mei
st_bumon st_bumon
cb_bumon cb_bumon
st_tanto st_tanto
cb_tanto cb_tanto
uo_okuri_mise uo_okuri_mise
uo_daibunrui uo_daibunrui
uo_tyubunrui uo_tyubunrui
uo_syobunrui uo_syobunrui
uo_syohin uo_syohin
cb_reset cb_reset
uo_iro uo_iro
ddplb_syori ddplb_syori
uo_syohin2 uo_syohin2
uo_unso uo_unso
uo_yubin uo_yubin
uo_seikyu uo_seikyu
uo_tokui_tanto uo_tokui_tanto
end type
global w_yamamoto_test_input w_yamamoto_test_input

type variables

public:
	long	i_new_width
end variables

forward prototypes
public function string of_get_tyakuten_code (integer p_unso_code, string p_yubin_no, long p_tokui_code, long p_mise_code)
public function string of_get_tyakuten_code (integer p_unso_code, string p_yubin_no)
end prototypes

public function string of_get_tyakuten_code (integer p_unso_code, string p_yubin_no, long p_tokui_code, long p_mise_code);
// 運送便コードと郵便番号から着店コードを返す関数
string					l_tyakuten_code
nv_master				mst
str_mtyakuten			l_tyakuten[]
str_mdlpara_mtyakuten	l_mdl_tyakuten

l_tyakuten_code	= ""

if mst.of_tyakuten_get( p_unso_code, p_yubin_no, l_tyakuten ) > 0 then
	// レコードが2つ以上あるならモーダルを呼び出す
	if upperbound( l_tyakuten ) > 1 then
		l_mdl_tyakuten.in_tokui_code	= p_tokui_code
		l_mdl_tyakuten.in_mise_code		= p_mise_code
		l_mdl_tyakuten.in_unso_code		= p_unso_code
		l_mdl_tyakuten.in_yubin_no		= p_yubin_no
		
		// モーダルの呼び出し
		l_mdl_tyakuten	= mdl.of_open_modal( "wsm_tyakuten", l_mdl_tyakuten )

		if upperbound( l_mdl_tyakuten.ret ) > 0 then
			l_tyakuten_code	= l_mdl_tyakuten.ret[1].tyakuten_code_tome
		end if
	else
		l_tyakuten_code	= l_tyakuten[1].tyakuten_code
	end if
end if

return l_tyakuten_code
end function

public function string of_get_tyakuten_code (integer p_unso_code, string p_yubin_no);
long	l_tokui_code, l_mise_code

setnull( l_tokui_code )
setnull( l_mise_code )

return of_get_tyakuten_code( p_unso_code, p_yubin_no, l_tokui_code, l_mise_code )
end function

on w_yamamoto_test_input.create
int iCurrent
call super::create
this.uo_tokui=create uo_tokui
this.uo_mise=create uo_mise
this.uo_tanto=create uo_tanto
this.uo_menu=create uo_menu
this.uo_tab=create uo_tab
this.cb_syohizei=create cb_syohizei
this.st_torihiki=create st_torihiki
this.st_syohizei=create st_syohizei
this.cb_torihiki=create cb_torihiki
this.st_syusoku=create st_syusoku
this.cb_syusoku=create cb_syusoku
this.st_syozoku=create st_syozoku
this.st_syozoku_code=create st_syozoku_code
this.st_syozoku_mei=create st_syozoku_mei
this.st_eigyosyo=create st_eigyosyo
this.st_eigyosyo_code=create st_eigyosyo_code
this.st_eigyosyo_mei=create st_eigyosyo_mei
this.st_ka=create st_ka
this.st_ka_code=create st_ka_code
this.st_ka_mei=create st_ka_mei
this.st_bumon=create st_bumon
this.cb_bumon=create cb_bumon
this.st_tanto=create st_tanto
this.cb_tanto=create cb_tanto
this.uo_okuri_mise=create uo_okuri_mise
this.uo_daibunrui=create uo_daibunrui
this.uo_tyubunrui=create uo_tyubunrui
this.uo_syobunrui=create uo_syobunrui
this.uo_syohin=create uo_syohin
this.cb_reset=create cb_reset
this.uo_iro=create uo_iro
this.ddplb_syori=create ddplb_syori
this.uo_syohin2=create uo_syohin2
this.uo_unso=create uo_unso
this.uo_yubin=create uo_yubin
this.uo_seikyu=create uo_seikyu
this.uo_tokui_tanto=create uo_tokui_tanto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tokui
this.Control[iCurrent+2]=this.uo_mise
this.Control[iCurrent+3]=this.uo_tanto
this.Control[iCurrent+4]=this.uo_menu
this.Control[iCurrent+5]=this.uo_tab
this.Control[iCurrent+6]=this.cb_syohizei
this.Control[iCurrent+7]=this.st_torihiki
this.Control[iCurrent+8]=this.st_syohizei
this.Control[iCurrent+9]=this.cb_torihiki
this.Control[iCurrent+10]=this.st_syusoku
this.Control[iCurrent+11]=this.cb_syusoku
this.Control[iCurrent+12]=this.st_syozoku
this.Control[iCurrent+13]=this.st_syozoku_code
this.Control[iCurrent+14]=this.st_syozoku_mei
this.Control[iCurrent+15]=this.st_eigyosyo
this.Control[iCurrent+16]=this.st_eigyosyo_code
this.Control[iCurrent+17]=this.st_eigyosyo_mei
this.Control[iCurrent+18]=this.st_ka
this.Control[iCurrent+19]=this.st_ka_code
this.Control[iCurrent+20]=this.st_ka_mei
this.Control[iCurrent+21]=this.st_bumon
this.Control[iCurrent+22]=this.cb_bumon
this.Control[iCurrent+23]=this.st_tanto
this.Control[iCurrent+24]=this.cb_tanto
this.Control[iCurrent+25]=this.uo_okuri_mise
this.Control[iCurrent+26]=this.uo_daibunrui
this.Control[iCurrent+27]=this.uo_tyubunrui
this.Control[iCurrent+28]=this.uo_syobunrui
this.Control[iCurrent+29]=this.uo_syohin
this.Control[iCurrent+30]=this.cb_reset
this.Control[iCurrent+31]=this.uo_iro
this.Control[iCurrent+32]=this.ddplb_syori
this.Control[iCurrent+33]=this.uo_syohin2
this.Control[iCurrent+34]=this.uo_unso
this.Control[iCurrent+35]=this.uo_yubin
this.Control[iCurrent+36]=this.uo_seikyu
this.Control[iCurrent+37]=this.uo_tokui_tanto
end on

on w_yamamoto_test_input.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tokui)
destroy(this.uo_mise)
destroy(this.uo_tanto)
destroy(this.uo_menu)
destroy(this.uo_tab)
destroy(this.cb_syohizei)
destroy(this.st_torihiki)
destroy(this.st_syohizei)
destroy(this.cb_torihiki)
destroy(this.st_syusoku)
destroy(this.cb_syusoku)
destroy(this.st_syozoku)
destroy(this.st_syozoku_code)
destroy(this.st_syozoku_mei)
destroy(this.st_eigyosyo)
destroy(this.st_eigyosyo_code)
destroy(this.st_eigyosyo_mei)
destroy(this.st_ka)
destroy(this.st_ka_code)
destroy(this.st_ka_mei)
destroy(this.st_bumon)
destroy(this.cb_bumon)
destroy(this.st_tanto)
destroy(this.cb_tanto)
destroy(this.uo_okuri_mise)
destroy(this.uo_daibunrui)
destroy(this.uo_tyubunrui)
destroy(this.uo_syobunrui)
destroy(this.uo_syohin)
destroy(this.cb_reset)
destroy(this.uo_iro)
destroy(this.ddplb_syori)
destroy(this.uo_syohin2)
destroy(this.uo_unso)
destroy(this.uo_yubin)
destroy(this.uo_seikyu)
destroy(this.uo_tokui_tanto)
end on

event key_f10;call super::key_f10;winctl.post of_close( this.classname(), false )

return 0
end event

event open;call super::open;
// ロックするとき
//uo_meisyo.of_set_protect( false )

//uo_daibunrui.of_set_dbchk_exst( )
//uo_tyubunrui.of_set_dbchk_exst( )
//uo_syobunrui.of_set_dbchk_exst( )

// 表示のみのとき
//uo_daibunrui.of_set_dbchk_none( )
//uo_tyubunrui.of_set_dbchk_none( )
//uo_syobunrui.of_set_dbchk_none( )
//
//uo_menu.of_set_dbchk_none( )
//uo_tab.of_set_dbchk_none( )
//
//uo_tanto.of_set_dbchk_none( )
//
//uo_tokui.of_set_dbchk_none( )
//uo_mise.of_set_dbchk_none( )
//uo_seikyu.of_set_dbchk_none( )
//
//uo_syohin2.of_set_dbchk_none( )
end event

type uo_signal from iw_main_window`uo_signal within w_yamamoto_test_input
end type

type st_date from iw_main_window`st_date within w_yamamoto_test_input
end type

type st_user_mei from iw_main_window`st_user_mei within w_yamamoto_test_input
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_yamamoto_test_input
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_yamamoto_test_input
end type

type st_title from iw_main_window`st_title within w_yamamoto_test_input
end type

type st_title_upper from iw_main_window`st_title_upper within w_yamamoto_test_input
end type

type st_upper from iw_main_window`st_upper within w_yamamoto_test_input
end type

type st_second_upper from iw_main_window`st_second_upper within w_yamamoto_test_input
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_yamamoto_test_input
integer taborder = 0
end type

type uo_tokui from cv_input_tokui within w_yamamoto_test_input
integer x = 12
integer y = 619
integer width = 2260
integer height = 96
integer taborder = 20
boolean bringtotop = true
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	// インスタンスに格納できているかのチェックのために、input_checkを呼び出し
//	sle_ins_tokui.event	input_check()
	msg.of_info( string( of_get_tokui_code() ) )
end if

return ancestorreturnvalue
end event

type uo_mise from cv_input_mise within w_yamamoto_test_input
integer x = 2360
integer y = 537
integer width = 2224
integer taborder = 30
boolean bringtotop = true
end type

on uo_mise.destroy
call cv_input_mise::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	// インスタンスに格納できているかのチェックのために、input_checkを呼び出し
//	sle_ins_tokui.event	input_check()
//	msg.of_info( string( this.i_tokui_code ) )
	msg.of_info( string( of_get_mise_code() ) )
end if

return ancestorreturnvalue
end event

type uo_tanto from cv_input_tanto within w_yamamoto_test_input
integer x = 496
integer y = 149
integer taborder = 110
boolean bringtotop = true
boolean chk_required = true
end type

event sle_input_check;call super::sle_input_check;
str_mmeisyo	l_meisyo[]

if ancestorreturnvalue then
	// 部門 meisyo_kbn = 21
	if mst.of_meisyo_get( 21, string( this.of_get_bumon_code( ) ), l_meisyo ) > 0 then
		st_syozoku_code.text	= string( this.of_get_bumon_code( ) )
		st_syozoku_mei.text		= l_meisyo[1].meisyo_1
	end if

	// 営業所 meisyo_kbn = 22
	if mst.of_meisyo_get( 22, string( this.of_get_eigyosyo_code( ) ), l_meisyo ) > 0 then
		st_eigyosyo_code.text	= string( this.of_get_eigyosyo_code( ) )
		st_eigyosyo_mei.text	= l_meisyo[1].meisyo_1
	end if

	// 課 meisyo_kbn = 23
	if mst.of_meisyo_get( 23, string( this.of_get_ka_code( ) ), l_meisyo ) > 0 then
		st_ka_code.text	= string( this.of_get_ka_code( ) )
		st_ka_mei.text	= l_meisyo[1].meisyo_1
	end if
else
	// 部門 初期化
	st_syozoku_code.text	= ""
	st_syozoku_mei.text		= ""

	// 営業所 初期化
	st_eigyosyo_code.text	= ""
	st_eigyosyo_mei.text	= ""

	// 課 初期化
	st_ka_code.text			= ""
	st_ka_mei.text			= ""
end if

return ancestorreturnvalue
end event

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

type uo_menu from cv_input_menu within w_yamamoto_test_input
integer y = 1134
integer width = 1244
integer taborder = 130
boolean bringtotop = true
integer i_dbchk_mode = 2
end type

on uo_menu.destroy
call cv_input_menu::destroy
end on

event sle_input_check;call super::sle_input_check;
msg.of_info( this.of_get_menu_id() )

return ancestorreturnvalue
end event

type uo_tab from cv_input_tab within w_yamamoto_test_input
integer y = 1230
integer width = 1244
integer taborder = 140
boolean bringtotop = true
integer i_dbchk_mode = 2
end type

on uo_tab.destroy
call cv_input_tab::destroy
end on

event sle_input_check;call super::sle_input_check;
msg.of_info( this.of_get_tab_id() )

return ancestorreturnvalue
end event

type cb_syohizei from ivo_commandbutton within w_yamamoto_test_input
integer x = 60
integer y = 491
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

if uo_tokui.syohizei_hyoji then
	uo_tokui.syohizei_hyoji	= false
else
	uo_tokui.syohizei_hyoji	= true
end if

l_bool		= uo_tokui.syohizei_hyoji
this.text	= string( l_bool )

uo_tokui.event sle_input_check()

return 0
end event

type st_torihiki from ivo_statictext within w_yamamoto_test_input
integer x = 432
integer y = 388
integer width = 376
boolean bringtotop = true
long backcolor = 12632256
string text = "取引停止区分"
end type

type st_syohizei from ivo_statictext within w_yamamoto_test_input
integer x = 68
integer y = 388
boolean bringtotop = true
long backcolor = 12632256
string text = "消費税"
end type

type cb_torihiki from ivo_commandbutton within w_yamamoto_test_input
integer x = 424
integer y = 491
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

if uo_tokui.torihiki_hyoji then
	uo_tokui.torihiki_hyoji	= false
else
	uo_tokui.torihiki_hyoji	= true
end if

l_bool		= uo_tokui.torihiki_hyoji
this.text	= string( l_bool )

uo_tokui.event sle_input_check()

return 0
end event

type st_syusoku from ivo_statictext within w_yamamoto_test_input
integer x = 908
integer y = 388
boolean bringtotop = true
long backcolor = 12632256
string text = "終息"
end type

type cb_syusoku from ivo_commandbutton within w_yamamoto_test_input
integer x = 900
integer y = 491
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

if uo_tokui.syusoku_hyoji then
	uo_tokui.syusoku_hyoji	= false
else
	uo_tokui.syusoku_hyoji	= true
end if

l_bool		= uo_tokui.syusoku_hyoji
this.text	= string( l_bool )

uo_tokui.event sle_input_check()

return 0
end event

type st_syozoku from ivo_statictext within w_yamamoto_test_input
integer x = 2316
integer y = 149
boolean bringtotop = true
long backcolor = 12632256
string text = "現所属"
end type

type st_syozoku_code from sv_st_meisyo within w_yamamoto_test_input
integer x = 2632
integer y = 146
integer width = 228
boolean bringtotop = true
string text = ""
end type

type st_syozoku_mei from sv_st_meisyo within w_yamamoto_test_input
integer x = 2884
integer y = 146
integer width = 512
boolean bringtotop = true
string text = ""
end type

type st_eigyosyo from ivo_statictext within w_yamamoto_test_input
integer x = 632
integer y = 263
boolean bringtotop = true
long backcolor = 12632256
string text = "営業所"
end type

type st_eigyosyo_code from sv_st_meisyo within w_yamamoto_test_input
integer x = 948
integer y = 260
integer width = 148
boolean bringtotop = true
string text = ""
end type

type st_eigyosyo_mei from sv_st_meisyo within w_yamamoto_test_input
integer x = 1124
integer y = 260
integer width = 512
boolean bringtotop = true
string text = ""
end type

type st_ka from ivo_statictext within w_yamamoto_test_input
integer x = 1688
integer y = 267
integer width = 144
boolean bringtotop = true
long backcolor = 12632256
string text = "課"
end type

type st_ka_code from sv_st_meisyo within w_yamamoto_test_input
integer x = 1848
integer y = 267
integer width = 128
boolean bringtotop = true
string text = ""
end type

type st_ka_mei from sv_st_meisyo within w_yamamoto_test_input
integer x = 1996
integer y = 263
integer width = 464
boolean bringtotop = true
string text = ""
end type

type st_bumon from ivo_statictext within w_yamamoto_test_input
integer x = 8
integer y = 2322
boolean bringtotop = true
long backcolor = 12632256
string text = "bumon"
end type

type cb_bumon from ivo_commandbutton within w_yamamoto_test_input
integer y = 2425
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

if uo_tokui_tanto.bumon_visible then
	l_bool							= false
	uo_tokui_tanto.bumon_visible	= l_bool
	this.text						= string( l_bool )
else
	l_bool									= true
	uo_tokui_tanto.bumon_visible			= l_bool
	uo_tokui_tanto.st_bumon_title.visible	= l_bool
	uo_tokui_tanto.st_bumon_mei.visible		= l_bool
	this.text								= string( l_bool )
end if

uo_tokui_tanto.event resize( 1, 1, 1 )

return 0
end event

type st_tanto from ivo_statictext within w_yamamoto_test_input
integer x = 372
integer y = 2322
boolean bringtotop = true
long backcolor = 12632256
string text = "tanto"
end type

type cb_tanto from ivo_commandbutton within w_yamamoto_test_input
integer x = 364
integer y = 2425
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

if uo_tokui_tanto.tanto_visible then
	l_bool							= false
	uo_tokui_tanto.tanto_visible	= l_bool
	this.text						= string( l_bool )
else
	l_bool									= true
	uo_tokui_tanto.tanto_visible			= l_bool
	uo_tokui_tanto.st_tanto_title.visible	= l_bool
	uo_tokui_tanto.st_tanto_code.visible	= l_bool
	uo_tokui_tanto.st_tanto_mei.visible		= l_bool
	this.text								= string( l_bool )
end if

uo_tokui_tanto.event resize( 1, 1, 1 )

return 0
end event

type uo_okuri_mise from cv_input_mise within w_yamamoto_test_input
integer x = 2360
integer y = 633
boolean bringtotop = true
boolean chk_required = true
string title_text = "送り店"
end type

on uo_okuri_mise.destroy
call cv_input_mise::destroy
end on

type uo_daibunrui from cv_input_bunrui within w_yamamoto_test_input
event destroy ( )
integer y = 786
integer taborder = 60
boolean bringtotop = true
end type

on uo_daibunrui.destroy
call cv_input_bunrui::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	msg.of_info( "大分類コード：" + string( uo_daibunrui.of_get_daibunrui_code() ) )
	msg.of_info( "中分類コード：" + string( uo_tyubunrui.of_get_tyubunrui_code() ) )
	msg.of_info( "小分類コード：" + string( uo_syobunrui.of_get_syobunrui_code() ) )
end if

return ancestorreturnvalue
end event

type uo_tyubunrui from cv_input_bunrui within w_yamamoto_test_input
event destroy ( )
integer y = 892
integer taborder = 70
boolean bringtotop = true
boolean daibunrui = false
boolean tyubunrui = true
end type

on uo_tyubunrui.destroy
call cv_input_bunrui::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	msg.of_info( "大分類コード：" + string( uo_daibunrui.of_get_daibunrui_code() ) )
	msg.of_info( "中分類コード：" + string( uo_tyubunrui.of_get_tyubunrui_code() ) )
	msg.of_info( "小分類コード：" + string( uo_syobunrui.of_get_syobunrui_code() ) )

//	msg.of_info( this.i_para_bunrui[1].tyubunrui_mei )
end if

return ancestorreturnvalue
end event

type uo_syobunrui from cv_input_bunrui within w_yamamoto_test_input
event destroy ( )
integer y = 999
integer taborder = 80
boolean bringtotop = true
boolean daibunrui = false
boolean syobunrui = true
end type

on uo_syobunrui.destroy
call cv_input_bunrui::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	msg.of_info( "大分類コード：" + string( uo_daibunrui.of_get_daibunrui_code() ) )
	msg.of_info( "中分類コード：" + string( uo_tyubunrui.of_get_tyubunrui_code() ) )
	msg.of_info( "小分類コード：" + string( uo_syobunrui.of_get_syobunrui_code() ) )
end if

return ancestorreturnvalue
end event

type uo_syohin from cv_input_syohin within w_yamamoto_test_input
integer y = 1497
integer width = 3064
integer taborder = 90
boolean bringtotop = true
string title_text = "商品コード"
boolean bikou_visible = false
boolean chk_relation = false
boolean input_iro_visible = false
boolean arrow_visible = false
boolean iro_mei_visible = false
end type

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
//	msg.of_info( string( of_get_syohin_code() ) )
	msg.of_info( string( of_get_iro_no() ) )
//	msg.of_info( "色番無し：" + string( of_get_bettyu_flg() ) )
//	msg.of_info( "色番あり：" + string( of_get_bettyu_flg( 2 ) ) )
//	msg.of_info( "サイズコードあり：" + string( of_get_bettyu_flg( 2, "S" ) ) )
end if

return true
end event

on uo_syohin.destroy
call cv_input_syohin::destroy
end on

type cb_reset from ivo_commandbutton within w_yamamoto_test_input
integer x = 8
integer y = 1362
integer taborder = 100
boolean bringtotop = true
string text = "初期化"
end type

event execution;call super::execution;
uo_syohin.event constructor( )
//uo_tokui_tanto.event constructor( )
end event

type uo_iro from cv_input within w_yamamoto_test_input
integer y = 1614
integer taborder = 120
boolean bringtotop = true
string title_text = "色番"
boolean bikou_visible = false
end type

on uo_iro.destroy
call cv_input::destroy
end on

event constructor;call super::constructor;
// 初期化処理
this.of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_msyohin	l_mdl_syohin

// モーダルを開く
l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )

if upperbound( l_mdl_syohin.ret ) > 0 then
	// 名称のセット
	this.of_set_input( string( l_mdl_syohin.ret[1].iro_no ) )
	this.of_set_meisyo( l_mdl_syohin.ret[1].iro_mei )
end if

return true

end event

event sle_input_check;call super::sle_input_check;
string		l_input
long		l_syohin_code, l_iro_no
str_msyohin	l_syohin[]

// 商品コードが入力されているか確認
if upperbound( uo_syohin.i_para_syohin ) = 0 then
	this.sle_input.of_msg_error( "商品コードが入力されていません。" )
	of_reset( "meisyobikou" )	// 備考も消す
	uo_syohin.sle_input.setfocus()
	
	return false
end if

l_input			= trim( this.of_get_input( ) )
l_syohin_code	= uo_syohin.i_para_syohin[1].syohin_code	// uo_syohinの商品コードを取得

if len( l_input ) > 0 then
	l_iro_no	= long( l_input )
	
	// データ取得と存在チェック
	if mst.of_syohin_get( l_syohin_code, l_iro_no, l_syohin ) > 0 then
		// 名称のセット
		of_set_meisyo( string( l_syohin[1].iro_mei ) )
	else
		sle_input.of_msg_error( "入力された色番はマスタに存在しません。" )
		of_reset( "meisyobikou" )	// 備考も消す
		sle_input.setfocus()
		
		return false
	end if
else
	of_reset( "meisyobikou" )	// 備考も消す
	return false
end if

return true
end event

type ddplb_syori from sv_ddplb_syori within w_yamamoto_test_input
integer x = 48
integer y = 153
integer taborder = 10
boolean bringtotop = true
string init_disp = "照会"
end type

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_daibunrui.of_set_dbchk_dupe( )
		uo_tyubunrui.of_set_dbchk_dupe( )
		uo_syobunrui.of_set_dbchk_dupe( )
		
		uo_menu.of_set_dbchk_dupe( )
		uo_tab.of_set_dbchk_dupe( )
		
		uo_tanto.of_set_dbchk_dupe( )
		uo_seikyu.of_set_dbchk_dupe( )
		
		uo_tokui.of_set_dbchk_dupe( )
		uo_mise.of_set_dbchk_dupe( )
		
		uo_syohin2.of_set_dbchk_dupe( )
	case "変更", "削除"
		// 存在チェックをする
		uo_daibunrui.of_set_dbchk_exst( )
		uo_tyubunrui.of_set_dbchk_exst( )
		uo_syobunrui.of_set_dbchk_exst( )
		
		uo_menu.of_set_dbchk_exst( )
		uo_tab.of_set_dbchk_exst( )
		
		uo_tanto.of_set_dbchk_exst( )
		uo_seikyu.of_set_dbchk_exst( )
		
		uo_tokui.of_set_dbchk_exst( )
		uo_mise.of_set_dbchk_exst( )
		
		uo_syohin2.of_set_dbchk_exst( )
	case "照会"
		uo_daibunrui.of_set_dbchk_none( )
		uo_tyubunrui.of_set_dbchk_none( )
		uo_syobunrui.of_set_dbchk_none( )
		
		uo_menu.of_set_dbchk_none( )
		uo_tab.of_set_dbchk_none( )
		
		uo_tanto.of_set_dbchk_none( )
		uo_seikyu.of_set_dbchk_none( )
		
		uo_tokui.of_set_dbchk_none( )
		uo_mise.of_set_dbchk_none( )
		
		uo_syohin2.of_set_dbchk_none( )
	case else
		// 何もしない
end choose
end event

type uo_syohin2 from cv_input_syohin within w_yamamoto_test_input
event destroy ( )
integer y = 1788
integer taborder = 150
boolean bringtotop = true
boolean syusoku_hyoji = false
boolean yoyaku_hyoji = true
end type

on uo_syohin2.destroy
call cv_input_syohin::destroy
end on

event sle_input_check;call super::sle_input_check;
msg.of_info( string( this.get ) )
	
if ancestorreturnvalue then
	msg.of_info( "得意先コード：" + string( this.i_tokui_code ) )
	msg.of_info( "商品コード：" + string( of_get_syohin_code() ) )
//	msg.of_info( "色番無し：" + string( of_get_bettyu_flg() ) )
//	msg.of_info( "色番あり：" + string( of_get_bettyu_flg( 2 ) ) )
//	msg.of_info( "サイズコードあり：" + string( of_get_bettyu_flg( 2, "S" ) ) )
end if

return ancestorreturnvalue
end event

event sle_iro_input_check;call super::sle_iro_input_check;
//msg.of_info( string( this.get ))
msg.of_info( "得意先コード：" + string( this.i_tokui_code ) )
msg.of_info( "商品コード：" + string( this.of_get_syohin_code() ) )

return ancestorreturnvalue
end event

type uo_unso from cv_input_unso within w_yamamoto_test_input
integer x = 2360
integer y = 768
integer taborder = 40
boolean bringtotop = true
end type

on uo_unso.destroy
call cv_input_unso::destroy
end on

type uo_yubin from cv_input_yubin within w_yamamoto_test_input
integer x = 2360
integer y = 882
integer taborder = 50
boolean bringtotop = true
end type

on uo_yubin.destroy
call cv_input_yubin::destroy
end on

event sle_input_check;call super::sle_input_check;
long	l_tokui_code, l_mise_code
integer	l_unso_code
string	l_yubin_no, l_tyakuten_code

if ancestorreturnvalue then
	l_unso_code		= uo_unso.of_get_unso_code()
	l_yubin_no		= trim( this.of_get_yubin_no() )
	l_tokui_code	= uo_tokui.of_get_tokui_code()
	l_mise_code		= uo_mise.of_get_mise_code()
	
	l_tyakuten_code	= of_get_tyakuten_code( l_unso_code, l_yubin_no, l_tokui_code, l_mise_code )
	msg.of_info( l_tyakuten_code )
end if

return ancestorreturnvalue
end event

type uo_seikyu from cv_input_tokui_seikyu within w_yamamoto_test_input
integer x = 1388
integer y = 384
integer taborder = 20
boolean bringtotop = true
end type

on uo_seikyu.destroy
call cv_input_tokui_seikyu::destroy
end on

type uo_tokui_tanto from cv_input_tokui_tanto within w_yamamoto_test_input
integer x = 20
integer y = 2564
integer taborder = 160
boolean bringtotop = true
boolean bumon_visible = true
end type

on uo_tokui_tanto.destroy
call cv_input_tokui_tanto::destroy
end on

