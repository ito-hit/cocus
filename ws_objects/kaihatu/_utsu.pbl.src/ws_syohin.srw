$PBExportHeader$ws_syohin.srw
$PBExportComments$商品一覧照会
forward
global type ws_syohin from iw_main_window
end type
type gb_displayunit from ivo_groupbox within ws_syohin
end type
type st_1 from ivo_statictext within ws_syohin
end type
type rb_syoiro from ivo_radiobutton within ws_syohin
end type
type rb_sku from ivo_radiobutton within ws_syohin
end type
type st_2 from ivo_statictext within ws_syohin
end type
type sle_hatubai_date_from from ivo_singlelineedit within ws_syohin
end type
type st_3 from ivo_statictext within ws_syohin
end type
type sle_hatubai_date_to from ivo_singlelineedit within ws_syohin
end type
type st_4 from ivo_statictext within ws_syohin
end type
type sle_seriese_code from ivo_singlelineedit within ws_syohin
end type
type st_5 from ivo_statictext within ws_syohin
end type
type sle_syohin_code from ivo_singlelineedit within ws_syohin
end type
type sle_iro_no from ivo_singlelineedit within ws_syohin
end type
type st_6 from ivo_statictext within ws_syohin
end type
type cb_syoiro from ivo_commandbutton within ws_syohin
end type
type sle_daibunrui_code from ivo_singlelineedit within ws_syohin
end type
type cb_daibunrui from ivo_commandbutton within ws_syohin
end type
type st_daibunrui_mei from ivo_statictext within ws_syohin
end type
type st_8 from ivo_statictext within ws_syohin
end type
type sle_tyubunrui_code from ivo_singlelineedit within ws_syohin
end type
type cb_tyubunrui from ivo_commandbutton within ws_syohin
end type
type st_tyubunrui_mei from ivo_statictext within ws_syohin
end type
type st_syobunrui_mei from ivo_statictext within ws_syohin
end type
type cb_syobunrui from ivo_commandbutton within ws_syohin
end type
type sle_syobunrui_code from ivo_singlelineedit within ws_syohin
end type
type st_11 from ivo_statictext within ws_syohin
end type
type st_12 from ivo_statictext within ws_syohin
end type
type sle_bukken_code from ivo_singlelineedit within ws_syohin
end type
type cb_bukken from ivo_commandbutton within ws_syohin
end type
type st_bukken_mei from ivo_statictext within ws_syohin
end type
type st_14 from ivo_statictext within ws_syohin
end type
type sle_group_code from ivo_singlelineedit within ws_syohin
end type
type cb_group from ivo_commandbutton within ws_syohin
end type
type st_group_mei from ivo_statictext within ws_syohin
end type
type st_brand_mei from ivo_statictext within ws_syohin
end type
type cb_brand from ivo_commandbutton within ws_syohin
end type
type sle_brand_code from ivo_singlelineedit within ws_syohin
end type
type st_17 from ivo_statictext within ws_syohin
end type
type st_18 from ivo_statictext within ws_syohin
end type
type sle_subbrand_code from ivo_singlelineedit within ws_syohin
end type
type cb_subbrand from ivo_commandbutton within ws_syohin
end type
type st_subbrand_mei from ivo_statictext within ws_syohin
end type
type st_season_mei from ivo_statictext within ws_syohin
end type
type cb_season from ivo_commandbutton within ws_syohin
end type
type sle_season_code from ivo_singlelineedit within ws_syohin
end type
type st_21 from ivo_statictext within ws_syohin
end type
type st_22 from ivo_statictext within ws_syohin
end type
type ddplb_bumon_code from sv_ddplb_meisyo within ws_syohin
end type
type st_23 from ivo_statictext within ws_syohin
end type
type ddplb_haiban_kbn from sv_ddplb_meisyo within ws_syohin
end type
type st_24 from ivo_statictext within ws_syohin
end type
type ddplb_seisankoku_code from sv_ddplb_meisyo within ws_syohin
end type
type st_25 from ivo_statictext within ws_syohin
end type
type ddplb_syozai_kbn from sv_ddplb_meisyo within ws_syohin
end type
type st_26 from ivo_statictext within ws_syohin
end type
type ddplb_syohin_kikaku_kbn from sv_ddplb_meisyo within ws_syohin
end type
type st_27 from ivo_statictext within ws_syohin
end type
type ddplb_kakaku_group_kbn from sv_ddplb_meisyo within ws_syohin
end type
type st_28 from ivo_statictext within ws_syohin
end type
type ddplb_tankahyo_hakkou_kbn from sv_ddplb_meisyo within ws_syohin
end type
type cbx_betusun_flg from ivo_checkbox within ws_syohin
end type
type cbx_hi_toriatukai_flg from ivo_checkbox within ws_syohin
end type
type cbx_syusoku_flg from ivo_checkbox within ws_syohin
end type
type dw_list from ivo_datawindow within ws_syohin
end type
end forward

global type ws_syohin from iw_main_window
string title = "商品一覧照会"
gb_displayunit gb_displayunit
st_1 st_1
rb_syoiro rb_syoiro
rb_sku rb_sku
st_2 st_2
sle_hatubai_date_from sle_hatubai_date_from
st_3 st_3
sle_hatubai_date_to sle_hatubai_date_to
st_4 st_4
sle_seriese_code sle_seriese_code
st_5 st_5
sle_syohin_code sle_syohin_code
sle_iro_no sle_iro_no
st_6 st_6
cb_syoiro cb_syoiro
sle_daibunrui_code sle_daibunrui_code
cb_daibunrui cb_daibunrui
st_daibunrui_mei st_daibunrui_mei
st_8 st_8
sle_tyubunrui_code sle_tyubunrui_code
cb_tyubunrui cb_tyubunrui
st_tyubunrui_mei st_tyubunrui_mei
st_syobunrui_mei st_syobunrui_mei
cb_syobunrui cb_syobunrui
sle_syobunrui_code sle_syobunrui_code
st_11 st_11
st_12 st_12
sle_bukken_code sle_bukken_code
cb_bukken cb_bukken
st_bukken_mei st_bukken_mei
st_14 st_14
sle_group_code sle_group_code
cb_group cb_group
st_group_mei st_group_mei
st_brand_mei st_brand_mei
cb_brand cb_brand
sle_brand_code sle_brand_code
st_17 st_17
st_18 st_18
sle_subbrand_code sle_subbrand_code
cb_subbrand cb_subbrand
st_subbrand_mei st_subbrand_mei
st_season_mei st_season_mei
cb_season cb_season
sle_season_code sle_season_code
st_21 st_21
st_22 st_22
ddplb_bumon_code ddplb_bumon_code
st_23 st_23
ddplb_haiban_kbn ddplb_haiban_kbn
st_24 st_24
ddplb_seisankoku_code ddplb_seisankoku_code
st_25 st_25
ddplb_syozai_kbn ddplb_syozai_kbn
st_26 st_26
ddplb_syohin_kikaku_kbn ddplb_syohin_kikaku_kbn
st_27 st_27
ddplb_kakaku_group_kbn ddplb_kakaku_group_kbn
st_28 st_28
ddplb_tankahyo_hakkou_kbn ddplb_tankahyo_hakkou_kbn
cbx_betusun_flg cbx_betusun_flg
cbx_hi_toriatukai_flg cbx_hi_toriatukai_flg
cbx_syusoku_flg cbx_syusoku_flg
dw_list dw_list
end type
global ws_syohin ws_syohin

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str

	// 呼出し部の情報を保管
	long	i_hatubai_date_from
	long	i_hatubai_date_to
	long	i_seriese_code
	long	i_syohin_code
	long	i_iro_no
	long	i_daibunrui_code
	long	i_tyubunrui_code
	long	i_syobunrui_code
	long	i_bukken_code
	long	i_group_code
	long	i_brand_code
	long	i_subbrand_code
	long	i_season_code
	
	long	i_bumon_code
	long	i_haiban_kbn
	long	i_seisankoku_code
	long	i_syozai_kbn
	long	i_syohin_kikaku_kbn
	long	i_kakaku_group_kbn
	long	i_tankahyo_hakkou_kbn
	boolean	i_betusun_flg
	boolean	i_hi_toriatukai_flg
	boolean	i_syusoku_flg
	
	
end variables

forward prototypes
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_reset ();// constructorで各コントロールリセット

rb_syoiro.event constructor( )
rb_sku.event constructor( )
sle_hatubai_date_from.event constructor( )
sle_hatubai_date_to.event constructor( )
sle_seriese_code.event constructor( )
sle_syohin_code.event constructor( )
sle_iro_no.event constructor( )

sle_daibunrui_code.event constructor( )
st_daibunrui_mei.event constructor( )
sle_tyubunrui_code.event constructor( )
st_tyubunrui_mei.event constructor( )
sle_syobunrui_code.event constructor( )
st_syobunrui_mei.event constructor( )
sle_bukken_code.event constructor( )
st_bukken_mei.event constructor( )
sle_group_code.event constructor( )
st_group_mei.event constructor( )
sle_brand_code.event constructor( )
st_brand_mei.event constructor( )
sle_subbrand_code.event constructor( )
st_subbrand_mei.event constructor( )
sle_season_code.event constructor( )
st_season_mei.event constructor( )

ddplb_bumon_code.event constructor( )
ddplb_haiban_kbn.event constructor( )
ddplb_seisankoku_code.event constructor( )
ddplb_syozai_kbn.event constructor( )
ddplb_syohin_kikaku_kbn.event constructor( )
ddplb_kakaku_group_kbn.event constructor( )
ddplb_tankahyo_hakkou_kbn.event constructor( )
cbx_betusun_flg.event constructor( )
cbx_hi_toriatukai_flg.event constructor( )
cbx_syusoku_flg.event constructor( )

dw_list.event constructor( )

end subroutine

public subroutine of_dsp_back ();dw_list.event constructor( )

rb_syoiro.setfocus( )

end subroutine

on ws_syohin.create
int iCurrent
call super::create
this.gb_displayunit=create gb_displayunit
this.st_1=create st_1
this.rb_syoiro=create rb_syoiro
this.rb_sku=create rb_sku
this.st_2=create st_2
this.sle_hatubai_date_from=create sle_hatubai_date_from
this.st_3=create st_3
this.sle_hatubai_date_to=create sle_hatubai_date_to
this.st_4=create st_4
this.sle_seriese_code=create sle_seriese_code
this.st_5=create st_5
this.sle_syohin_code=create sle_syohin_code
this.sle_iro_no=create sle_iro_no
this.st_6=create st_6
this.cb_syoiro=create cb_syoiro
this.sle_daibunrui_code=create sle_daibunrui_code
this.cb_daibunrui=create cb_daibunrui
this.st_daibunrui_mei=create st_daibunrui_mei
this.st_8=create st_8
this.sle_tyubunrui_code=create sle_tyubunrui_code
this.cb_tyubunrui=create cb_tyubunrui
this.st_tyubunrui_mei=create st_tyubunrui_mei
this.st_syobunrui_mei=create st_syobunrui_mei
this.cb_syobunrui=create cb_syobunrui
this.sle_syobunrui_code=create sle_syobunrui_code
this.st_11=create st_11
this.st_12=create st_12
this.sle_bukken_code=create sle_bukken_code
this.cb_bukken=create cb_bukken
this.st_bukken_mei=create st_bukken_mei
this.st_14=create st_14
this.sle_group_code=create sle_group_code
this.cb_group=create cb_group
this.st_group_mei=create st_group_mei
this.st_brand_mei=create st_brand_mei
this.cb_brand=create cb_brand
this.sle_brand_code=create sle_brand_code
this.st_17=create st_17
this.st_18=create st_18
this.sle_subbrand_code=create sle_subbrand_code
this.cb_subbrand=create cb_subbrand
this.st_subbrand_mei=create st_subbrand_mei
this.st_season_mei=create st_season_mei
this.cb_season=create cb_season
this.sle_season_code=create sle_season_code
this.st_21=create st_21
this.st_22=create st_22
this.ddplb_bumon_code=create ddplb_bumon_code
this.st_23=create st_23
this.ddplb_haiban_kbn=create ddplb_haiban_kbn
this.st_24=create st_24
this.ddplb_seisankoku_code=create ddplb_seisankoku_code
this.st_25=create st_25
this.ddplb_syozai_kbn=create ddplb_syozai_kbn
this.st_26=create st_26
this.ddplb_syohin_kikaku_kbn=create ddplb_syohin_kikaku_kbn
this.st_27=create st_27
this.ddplb_kakaku_group_kbn=create ddplb_kakaku_group_kbn
this.st_28=create st_28
this.ddplb_tankahyo_hakkou_kbn=create ddplb_tankahyo_hakkou_kbn
this.cbx_betusun_flg=create cbx_betusun_flg
this.cbx_hi_toriatukai_flg=create cbx_hi_toriatukai_flg
this.cbx_syusoku_flg=create cbx_syusoku_flg
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_displayunit
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_syoiro
this.Control[iCurrent+4]=this.rb_sku
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_hatubai_date_from
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_hatubai_date_to
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.sle_seriese_code
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.sle_syohin_code
this.Control[iCurrent+13]=this.sle_iro_no
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.cb_syoiro
this.Control[iCurrent+16]=this.sle_daibunrui_code
this.Control[iCurrent+17]=this.cb_daibunrui
this.Control[iCurrent+18]=this.st_daibunrui_mei
this.Control[iCurrent+19]=this.st_8
this.Control[iCurrent+20]=this.sle_tyubunrui_code
this.Control[iCurrent+21]=this.cb_tyubunrui
this.Control[iCurrent+22]=this.st_tyubunrui_mei
this.Control[iCurrent+23]=this.st_syobunrui_mei
this.Control[iCurrent+24]=this.cb_syobunrui
this.Control[iCurrent+25]=this.sle_syobunrui_code
this.Control[iCurrent+26]=this.st_11
this.Control[iCurrent+27]=this.st_12
this.Control[iCurrent+28]=this.sle_bukken_code
this.Control[iCurrent+29]=this.cb_bukken
this.Control[iCurrent+30]=this.st_bukken_mei
this.Control[iCurrent+31]=this.st_14
this.Control[iCurrent+32]=this.sle_group_code
this.Control[iCurrent+33]=this.cb_group
this.Control[iCurrent+34]=this.st_group_mei
this.Control[iCurrent+35]=this.st_brand_mei
this.Control[iCurrent+36]=this.cb_brand
this.Control[iCurrent+37]=this.sle_brand_code
this.Control[iCurrent+38]=this.st_17
this.Control[iCurrent+39]=this.st_18
this.Control[iCurrent+40]=this.sle_subbrand_code
this.Control[iCurrent+41]=this.cb_subbrand
this.Control[iCurrent+42]=this.st_subbrand_mei
this.Control[iCurrent+43]=this.st_season_mei
this.Control[iCurrent+44]=this.cb_season
this.Control[iCurrent+45]=this.sle_season_code
this.Control[iCurrent+46]=this.st_21
this.Control[iCurrent+47]=this.st_22
this.Control[iCurrent+48]=this.ddplb_bumon_code
this.Control[iCurrent+49]=this.st_23
this.Control[iCurrent+50]=this.ddplb_haiban_kbn
this.Control[iCurrent+51]=this.st_24
this.Control[iCurrent+52]=this.ddplb_seisankoku_code
this.Control[iCurrent+53]=this.st_25
this.Control[iCurrent+54]=this.ddplb_syozai_kbn
this.Control[iCurrent+55]=this.st_26
this.Control[iCurrent+56]=this.ddplb_syohin_kikaku_kbn
this.Control[iCurrent+57]=this.st_27
this.Control[iCurrent+58]=this.ddplb_kakaku_group_kbn
this.Control[iCurrent+59]=this.st_28
this.Control[iCurrent+60]=this.ddplb_tankahyo_hakkou_kbn
this.Control[iCurrent+61]=this.cbx_betusun_flg
this.Control[iCurrent+62]=this.cbx_hi_toriatukai_flg
this.Control[iCurrent+63]=this.cbx_syusoku_flg
this.Control[iCurrent+64]=this.dw_list
end on

on ws_syohin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_displayunit)
destroy(this.st_1)
destroy(this.rb_syoiro)
destroy(this.rb_sku)
destroy(this.st_2)
destroy(this.sle_hatubai_date_from)
destroy(this.st_3)
destroy(this.sle_hatubai_date_to)
destroy(this.st_4)
destroy(this.sle_seriese_code)
destroy(this.st_5)
destroy(this.sle_syohin_code)
destroy(this.sle_iro_no)
destroy(this.st_6)
destroy(this.cb_syoiro)
destroy(this.sle_daibunrui_code)
destroy(this.cb_daibunrui)
destroy(this.st_daibunrui_mei)
destroy(this.st_8)
destroy(this.sle_tyubunrui_code)
destroy(this.cb_tyubunrui)
destroy(this.st_tyubunrui_mei)
destroy(this.st_syobunrui_mei)
destroy(this.cb_syobunrui)
destroy(this.sle_syobunrui_code)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.sle_bukken_code)
destroy(this.cb_bukken)
destroy(this.st_bukken_mei)
destroy(this.st_14)
destroy(this.sle_group_code)
destroy(this.cb_group)
destroy(this.st_group_mei)
destroy(this.st_brand_mei)
destroy(this.cb_brand)
destroy(this.sle_brand_code)
destroy(this.st_17)
destroy(this.st_18)
destroy(this.sle_subbrand_code)
destroy(this.cb_subbrand)
destroy(this.st_subbrand_mei)
destroy(this.st_season_mei)
destroy(this.cb_season)
destroy(this.sle_season_code)
destroy(this.st_21)
destroy(this.st_22)
destroy(this.ddplb_bumon_code)
destroy(this.st_23)
destroy(this.ddplb_haiban_kbn)
destroy(this.st_24)
destroy(this.ddplb_seisankoku_code)
destroy(this.st_25)
destroy(this.ddplb_syozai_kbn)
destroy(this.st_26)
destroy(this.ddplb_syohin_kikaku_kbn)
destroy(this.st_27)
destroy(this.ddplb_kakaku_group_kbn)
destroy(this.st_28)
destroy(this.ddplb_tankahyo_hakkou_kbn)
destroy(this.cbx_betusun_flg)
destroy(this.cbx_hi_toriatukai_flg)
destroy(this.cbx_syusoku_flg)
destroy(this.dw_list)
end on

event resize;call super::resize;// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

st_second_upper.height	= 821
cb_retrieve.y			= 836

dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event openquery;call super::openquery;i_str	= create nv_string
end event

event close;call super::close;destroy i_str

end event

event retrieve_event;call super::retrieve_event;string	l_sql_old, l_sql_new, l_sql_where, l_sql_tail

// 検索条件に入力された内容をインスタンス変数に保持
if sle_hatubai_date_from.text <> "" then
	i_hatubai_date_from		= long( i_str.of_replace( sle_hatubai_date_from.text, "/", "" ) )
else
	i_hatubai_date_from		= 0
end if

if sle_hatubai_date_to.text <> "" then
	i_hatubai_date_to		= long( i_str.of_replace( sle_hatubai_date_to.text, "/", "" ) )
else
	i_hatubai_date_to		= 0
end if

if sle_seriese_code.text <> "" then
	i_seriese_code			= long( sle_seriese_code.text )
else
	i_seriese_code			= 0	
end if

if sle_syohin_code.text <> "" then
	i_syohin_code			= long( sle_syohin_code.text )
else
	i_syohin_code			= 0	
end if

if sle_iro_no.text <> "" then
	i_iro_no				= long( sle_iro_no.text )
else
	i_iro_no				= 0	
end if

if sle_daibunrui_code.text <> "" then
	i_daibunrui_code		= long( sle_daibunrui_code.text )
else
	i_daibunrui_code		= 0	
end if

if sle_tyubunrui_code.text <> "" then
	i_tyubunrui_code		= long( sle_tyubunrui_code.text )
else
	i_tyubunrui_code		= 0	
end if

if sle_syobunrui_code.text <> "" then
	i_syobunrui_code		= long( sle_syobunrui_code.text )
else
	i_syobunrui_code		= 0	
end if

if sle_bukken_code.text <> "" then
	i_bukken_code			= long( sle_bukken_code.text )
else
	i_bukken_code			= 0	
end if

if sle_group_code.text <> "" then
	i_group_code			= long( sle_group_code.text )
else
	i_group_code			= 0	
end if

if sle_brand_code.text <> "" then
	i_brand_code			= long( sle_brand_code.text )
else
	i_brand_code			= 0
end if

if sle_subbrand_code.text <> "" then
	i_subbrand_code			= long( sle_subbrand_code.text )
else
	i_subbrand_code			= 0	
end if

if sle_season_code.text <> "" then
	i_season_code			= long( sle_season_code.text )
else
	i_season_code			= 0
end if

i_bumon_code			= ddplb_bumon_code.of_get_code_num( )
i_haiban_kbn			= ddplb_haiban_kbn.of_get_code_num( )
i_seisankoku_code		= ddplb_seisankoku_code.of_get_code_num( )
i_syozai_kbn			= ddplb_syozai_kbn.of_get_code_num( )
i_syohin_kikaku_kbn		= ddplb_syohin_kikaku_kbn.of_get_code_num( )
i_kakaku_group_kbn		= ddplb_kakaku_group_kbn.of_get_code_num( )
i_tankahyo_hakkou_kbn	= ddplb_tankahyo_hakkou_kbn.of_get_code_num( )
i_betusun_flg			= cbx_betusun_flg.checked
i_hi_toriatukai_flg		= cbx_hi_toriatukai_flg.checked
i_syusoku_flg			= cbx_syusoku_flg.checked

// 元のSQLを取得
l_sql_old	= dw_list.getsqlselect( )


// ## 条件作成 ## //
// 発売日(開始)
if i_hatubai_date_from <> 0 then
	l_sql_where	+= "   and syohin.hatubai_date          >= " + string( i_hatubai_date_from ) + code.crlf
end if

// 発売日(終了日)
if i_hatubai_date_to <> 0 then
	l_sql_where	+= "   and syohin.hatubai_date          <= " + string( i_hatubai_date_to ) + code.crlf
end if

// シリーズ
if i_seriese_code <> 0 then
	l_sql_where	+= "   and syohin.seriese_code          = " + string( i_seriese_code ) + code.crlf
end if

// 商品CD
if i_syohin_code <> 0 then
	l_sql_where	+= "   and syohin.syohin_code          = " + string( i_syohin_code ) + code.crlf
end if

// 色番
if i_iro_no <> 0 then
	l_sql_where	+= "   and syohin.iro_no                = " + string( i_iro_no ) + code.crlf
end if

// 大分類
if i_daibunrui_code <> 0 and not isnull( i_daibunrui_code ) then
	l_sql_where	+= "   and syohin.daibunrui_code        = " + string( i_daibunrui_code ) + code.crlf
end if

// 中分類
if i_tyubunrui_code <> 0 and not isnull( i_tyubunrui_code ) then
	l_sql_where	+= "   and syohin.tyubunrui_code        = " + string( i_tyubunrui_code ) + code.crlf
end if

// 小分類
if i_syobunrui_code <> 0 and not isnull( i_syobunrui_code ) then
	l_sql_where	+= "   and syohin.syobunrui_code        = " + string( i_syobunrui_code ) + code.crlf
end if

// 物件
if i_bukken_code <> 0 then
	l_sql_where	+= "   and syohin.bukken_code           = " + string( i_bukken_code ) + code.crlf
end if

// グループ
if i_group_code <> 0 then
	l_sql_where	+= "   and syohin.group_code            = " + string( i_group_code ) + code.crlf
end if

// ブランド
if i_brand_code <> 0 then
	l_sql_where	+= "   and syohin.brand_code            = " + string( i_brand_code ) + code.crlf
end if

// サブブランド
if i_subbrand_code <> 0 then
	l_sql_where	+= "   and syohin.subbrand_code         = " + string( i_subbrand_code ) + code.crlf
end if

// シーズン
if i_season_code <> 0 then
	l_sql_where	+= "   and syohin.season_code           = " + string( i_season_code ) + code.crlf
end if

// 管理部門
if i_bumon_code <> 0 then
	l_sql_where	+= "   and syohin.bumon_code            = " + string( i_bumon_code ) + code.crlf
end if

// 廃番区分
if i_haiban_kbn <> 0 then
	l_sql_where	+= "   and syohin.haiban_kbn            = " + string( i_haiban_kbn ) + code.crlf
end if

// 生産国
if i_seisankoku_code <> 0 then
	l_sql_where	+= "   and syohin.seisankoku_code       = " + string( i_seisankoku_code ) + code.crlf
end if

// 商材区分
if i_syozai_kbn <> 0 then
	l_sql_where	+= "   and syohin.syozai_kbn            = " + string( i_syozai_kbn ) + code.crlf
end if

// 規格
if i_syohin_kikaku_kbn <> 0 then
	l_sql_where	+= "   and syohin.syohin_kukaku_kbn            = " + string( i_syohin_kikaku_kbn ) + code.crlf
end if

// 価格GRP
if i_kakaku_group_kbn <> 0 then
	l_sql_where	+= "   and syohin.kakaku_group_kbn      = " + string( i_kakaku_group_kbn ) + code.crlf
end if

// 単価表発行
if i_tankahyo_hakkou_kbn <> 0 then
	l_sql_where	+= "   and syohin.tankahyo_hakkou_kbn   = " + string( i_tankahyo_hakkou_kbn ) + code.crlf
end if

// 別寸を含む
if not i_betusun_flg then
	l_sql_where	+= "   and syohin.size_code not in ( 'ﾍﾞﾂｽﾝ','ﾍﾞｯｽﾝ' ) " + code.crlf
end if

// 非取扱サイズを含む
if not i_hi_toriatukai_flg then
	l_sql_where	+= "   and syohin.hi_toriatukai_flg     <> 1 " + code.crlf
end if

// 終息商品を含む
if not i_syusoku_flg then
	l_sql_where	+= "and syohin.syusoku_flg           <> 1" + code.crlf
end if

// SQL組み立て
if rb_syoiro.checked then
	// 商品色単位
	l_sql_new	= Mid( l_sql_old, 1, Pos( l_sql_old, "group by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, Pos( l_sql_old, "group by" ) )
else
	// SKU単位
	l_sql_new	= l_sql_old + code.crlf + l_sql_where
end if

dw_list.reset( )


// 組み立てたSQLをセットする
dw_list.setsqlselect( l_sql_new )

// 検索
if dw_list.retrieve( ) = 0 then
	// SQLを元に戻す
	dw_list.setsqlselect( l_sql_old )
	
	msg.of_error( "入力したた条件に該当するデータはありません。" )
	return -1
end if

// SQLを元に戻す
dw_list.setsqlselect( l_sql_old )

dw_list.setfocus( )
end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event open;call super::open;// 初期表示
of_set_firstfocus( )
end event

event key_f06;call super::key_f06;// 戻り
of_dsp_back()

return 0
end event

event retrieve_check;call super::retrieve_check;// Retrieve前の事前チェック

// 発売日(開始)
if not sle_hatubai_date_from.event input_check( ) then
	return -1
end if

// 発売日(終了)
if not sle_hatubai_date_to.event input_check( ) then
	return -1
end if

// シリーズ
if not sle_seriese_code.event input_check( ) then
	return -1
end if

// 商品CD
if not sle_syohin_code.event input_check( ) then
	return -1
end if

// 色番
if not sle_iro_no.event input_check( ) then
	return -1
end if

// 大分類
if not sle_daibunrui_code.event input_check( ) then
	return -1
end if

// 中分類
if not sle_tyubunrui_code.event input_check( ) then
	return -1
end if

// 小分類
if not sle_syobunrui_code.event input_check( ) then
	return -1
end if

// 物件
if not sle_bukken_code.event input_check( ) then
	return -1
end if

// グループ
if not sle_group_code.event input_check( ) then
	return -1
end if

// ブランド
if not sle_brand_code.event input_check( ) then
	return -1
end if

// サブブランド
if not sle_subbrand_code.event input_check( ) then
	return -1
end if

// シーズン
if not sle_season_code.event input_check( ) then
	return -1
end if


end event

type uo_signal from iw_main_window`uo_signal within ws_syohin
end type

type st_date from iw_main_window`st_date within ws_syohin
end type

type st_user_mei from iw_main_window`st_user_mei within ws_syohin
end type

type uo_test_mode from iw_main_window`uo_test_mode within ws_syohin
end type

type p_size_adjust from iw_main_window`p_size_adjust within ws_syohin
end type

type st_title from iw_main_window`st_title within ws_syohin
end type

type st_title_upper from iw_main_window`st_title_upper within ws_syohin
end type

type st_upper from iw_main_window`st_upper within ws_syohin
end type

type st_second_upper from iw_main_window`st_second_upper within ws_syohin
integer height = 821
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_syohin
integer x = 4700
integer y = 836
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type gb_displayunit from ivo_groupbox within ws_syohin
integer x = 340
integer y = 153
integer width = 788
integer height = 139
long backcolor = 12632256
string text = ""
end type

type st_1 from ivo_statictext within ws_syohin
integer x = 24
integer y = 192
boolean bringtotop = true
long backcolor = 12632256
string text = "表示単位"
alignment alignment = right!
end type

type rb_syoiro from ivo_radiobutton within ws_syohin
string tag = "商品色単位"
integer x = 360
integer y = 192
integer width = 396
integer taborder = 20
long backcolor = 12632256
string text = "商品色単位"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= true
end event

event clicked;call super::clicked;dw_list.dataobject	= "ds_syohin_iro"
dw_list.event constructor( )
end event

type rb_sku from ivo_radiobutton within ws_syohin
string tag = "SKU単位"
integer x = 796
integer y = 192
integer width = 320
integer taborder = 30
long backcolor = 12632256
string text = "SKU単位"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;rb_syoiro.event constructor()
end event

event clicked;call super::clicked;dw_list.dataobject	= "ds_syohin_sku"
dw_list.event constructor( )
end event

type st_2 from ivo_statictext within ws_syohin
integer x = 1192
integer y = 192
integer width = 232
boolean bringtotop = true
long backcolor = 12632256
string text = "発売日"
alignment alignment = right!
end type

type sle_hatubai_date_from from ivo_singlelineedit within ws_syohin
string tag = "発売日(開始日)"
integer x = 1440
integer y = 192
integer width = 340
integer taborder = 40
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

i_hatubai_date_from		= 0
end event

event input_check;call super::input_check;//日付チェック

string	l_code

this.text	= trim( this.text )
l_code		= this.text

if l_code = "" then
	return true
end if

//if not isdate( fnc.of_date_format( l_code ) ) then
//	this.of_msg_error( "入力された日付に誤りがあります。" )
//	return false
//end if

//l_code				= fnc.of_date_format( l_code )
this.text			= l_code

//日付の前後関係チェック
if i_hatubai_date_to <> 0 then
	if i_hatubai_date_from > i_hatubai_date_to then
		this.of_msg_error( "発売日の前後関係が不正です。" )
		return false
	end if
end if

return true
end event

type st_3 from ivo_statictext within ws_syohin
integer x = 1780
integer y = 199
integer width = 76
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_hatubai_date_to from ivo_singlelineedit within ws_syohin
string tag = "発売日(終了日)"
integer x = 1856
integer y = 192
integer width = 340
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

i_hatubai_date_to		= 0

end event

event input_check;call super::input_check;//日付チェック
string	l_code

this.text	= trim( this.text )
l_code		= this.text

if l_code = "" then
	return true
end if

//if not isdate( fnc.of_date_format( l_code ) ) then
//	this.of_msg_error( "入力された日付に誤りがあります。" )
//	return false
//end if

//l_code				= fnc.of_date_format( l_code )
this.text			= l_code

if i_hatubai_date_from <> 0 then
	if i_hatubai_date_from > i_hatubai_date_to then
		this.of_msg_error( "発売日の前後関係が不正です。" )
		return false
	end if
end if

return true
end event

type st_4 from ivo_statictext within ws_syohin
integer x = 2288
integer y = 192
integer width = 232
boolean bringtotop = true
long backcolor = 12632256
string text = "シリーズ"
alignment alignment = right!
end type

type sle_seriese_code from ivo_singlelineedit within ws_syohin
string tag = "シリーズ"
integer x = 2548
integer y = 192
integer width = 224
integer taborder = 60
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "123456"
integer limit = 6
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""
i_seriese_code			= 0
end event

event input_check;call super::input_check;string	l_code

this.text	= trim( this.text )
l_code		= this.text

if this.text = "" then
	return true
end if

if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) ) 
	return false
end if
	
return true
end event

type st_5 from ivo_statictext within ws_syohin
integer x = 2980
integer y = 192
integer width = 364
boolean bringtotop = true
long backcolor = 12632256
string text = "商品CD・色番"
alignment alignment = right!
end type

type sle_syohin_code from ivo_singlelineedit within ws_syohin
string tag = "商品CO"
integer x = 3376
integer y = 192
integer width = 260
integer taborder = 70
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "1234567"
integer limit = 7
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text				= ""
i_syohin_code			= 0
end event

event key_f08;call super::key_f08;str_mdlpara_syohin	l_syohin

l_syohin	= mdl.of_open_modal( "w_modal_syohin", l_syohin )

if l_syohin.ret then
	sle_syohin_code.text	= string( l_syohin.out_syohin_code )
	sle_iro_no.text			= string( l_syohin.out_iro_no )
end if

return 0

end event

event input_check;call super::input_check;string	l_code

this.text	= trim( this.text )
l_code		= this.text

if this.text = "" then
	return true
end if

if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) ) 
	return false
end if
	
return true
end event

type sle_iro_no from ivo_singlelineedit within ws_syohin
string tag = "色番"
integer x = 3652
integer y = 192
integer width = 136
integer taborder = 80
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""
i_iro_no	= 0
end event

event key_f08;call super::key_f08;sle_syohin_code.event key_f08( keyf8!, 0 )

return 0
end event

event input_check;call super::input_check;string	l_code

this.text	= trim( this.text )
l_code		= this.text

if this.text = "" then
	return true
end if

if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) ) 
	return false
end if
	
return true
end event

type st_6 from ivo_statictext within ws_syohin
integer x = 24
integer y = 327
boolean bringtotop = true
long backcolor = 12632256
string text = "大分類"
alignment alignment = right!
end type

type cb_syoiro from ivo_commandbutton within ws_syohin
integer x = 3796
integer y = 192
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_syohin_code.event key_f08( keyf8!, 0 )
end event

type sle_daibunrui_code from ivo_singlelineedit within ws_syohin
string tag = "大分類"
integer x = 344
integer y = 324
integer width = 252
integer taborder = 90
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text				= ""

//setnull( i_daibunrui_code )
i_daibunrui_code		= 0
end event

event input_check;call super::input_check;// 大分類チェック

string	l_code
long	l_daibunrui_code
string	l_daibunrui_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_daibunrui_code.event constructor()
	st_daibunrui_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_daibunrui_code	= long( l_code )

// 存在チェック
select daibunrui_mei
  into :l_daibunrui_mei
  from m_bunrui
 where daibunrui_code	= :l_daibunrui_code
   and tyubunrui_code	= 0
   and syobunrui_code	= 0
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_daibunrui_mei.text	= trim( l_daibunrui_mei )
		
	case 100
		// データが無い場合は初期化
		st_daibunrui_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type cb_daibunrui from ivo_commandbutton within ws_syohin
integer x = 604
integer y = 324
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_daibunrui_code.event key_f08( keyf8!, 0 )
end event

type st_daibunrui_mei from ivo_statictext within ws_syohin
integer x = 708
integer y = 324
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_8 from ivo_statictext within ws_syohin
integer x = 24
integer y = 430
boolean bringtotop = true
long backcolor = 12632256
string text = "中分類"
alignment alignment = right!
end type

type sle_tyubunrui_code from ivo_singlelineedit within ws_syohin
string tag = "中分類"
integer x = 344
integer y = 427
integer width = 252
integer taborder = 100
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text				= ""

//setnull( i_tyubunrui_code )
i_tyubunrui_code		= 0
end event

event input_check;call super::input_check;// 中分類チェック

string	l_code
long	l_tyubunrui_code
string	l_tyubunrui_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_tyubunrui_code.event constructor()
	st_tyubunrui_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_tyubunrui_code	= long( l_code )

// 存在チェック
select tyubunrui_mei
  into :l_tyubunrui_mei
  from m_bunrui
 where tyubunrui_code	<> 0
   and daibunrui_code	= :i_daibunrui_code
   and tyubunrui_code	= :l_tyubunrui_code
   and syobunrui_code	= 0
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_tyubunrui_mei.text	= trim( l_tyubunrui_mei )
		
	case 100
		// データが無い場合は初期化
		st_tyubunrui_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type cb_tyubunrui from ivo_commandbutton within ws_syohin
integer x = 604
integer y = 427
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_tyubunrui_code.event key_f08( keyf8!, 0 )
end event

type st_tyubunrui_mei from ivo_statictext within ws_syohin
integer x = 708
integer y = 427
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_syobunrui_mei from ivo_statictext within ws_syohin
integer x = 708
integer y = 530
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type cb_syobunrui from ivo_commandbutton within ws_syohin
integer x = 604
integer y = 530
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_syobunrui_code.event key_f08( keyf8!, 0 )
end event

type sle_syobunrui_code from ivo_singlelineedit within ws_syohin
string tag = "小分類"
integer x = 344
integer y = 530
integer width = 252
integer taborder = 110
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 4
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text				= ""

//setnull( i_syobunrui_code )
i_syobunrui_code		= 0
end event

event input_check;call super::input_check;// 小分類チェック

string	l_code

long	l_syobunrui_code
string	l_syobunrui_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_syobunrui_code.event constructor()
	st_syobunrui_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_syobunrui_code	= long( l_code )

// 存在チェック
select syobunrui_mei
  into :l_syobunrui_mei
  from m_bunrui
 where tyubunrui_code	<> 0
   and syobunrui_code	<> 0
   and daibunrui_code	= :i_daibunrui_code
   and tyubunrui_code	= :i_tyubunrui_code
   and syobunrui_code	= :l_syobunrui_code
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_syobunrui_mei.text	= trim( l_syobunrui_mei )
		
	case 100
		// データが無い場合は初期化
		st_syobunrui_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type st_11 from ivo_statictext within ws_syohin
integer x = 24
integer y = 533
boolean bringtotop = true
long backcolor = 12632256
string text = "小分類"
alignment alignment = right!
end type

type st_12 from ivo_statictext within ws_syohin
integer x = 24
integer y = 636
boolean bringtotop = true
long backcolor = 12632256
string text = "物件"
alignment alignment = right!
end type

type sle_bukken_code from ivo_singlelineedit within ws_syohin
string tag = "物件"
integer x = 344
integer y = 633
integer width = 252
integer taborder = 120
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 5
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""

i_bukken_code	= 0
end event

event input_check;call super::input_check;string	l_code
long	l_bukken_code
string	l_bukken_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_bukken_code.event constructor()
	st_bukken_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_bukken_code	= long( l_code )

// 存在チェック
select bukken_mei
  into :l_bukken_mei
  from m_bukken
 where bukken_code	= :l_bukken_code
 using cocos;

choose case cocos.sqlcode
	case 0
		st_bukken_mei.text	= trim( l_bukken_mei )
		
	case 100
		// データが無い場合は初期化
		st_bukken_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type cb_bukken from ivo_commandbutton within ws_syohin
integer x = 604
integer y = 633
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_bukken_code.event key_f08( keyf8!, 0 )
end event

type st_bukken_mei from ivo_statictext within ws_syohin
integer x = 708
integer y = 633
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_14 from ivo_statictext within ws_syohin
integer x = 2124
integer y = 334
boolean bringtotop = true
long backcolor = 12632256
string text = "グループ"
alignment alignment = right!
end type

type sle_group_code from ivo_singlelineedit within ws_syohin
string tag = "グループ"
integer x = 2444
integer y = 324
integer width = 252
integer taborder = 130
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""

i_group_code	= 0
end event

event input_check;call super::input_check;string	l_code
long	l_group_code
string	l_group_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_group_code.event constructor()
	st_group_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_group_code	= long( l_code )

// 存在チェック
select group_mei
  into :l_group_mei
  from m_group
 where group_code   = :l_group_code
 using cocos;

choose case cocos.sqlcode
	case 0
		st_group_mei.text	= trim( l_group_mei )
		
	case 100
		// データが無い場合は初期化
		st_group_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type cb_group from ivo_commandbutton within ws_syohin
integer x = 2704
integer y = 324
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_group_code.event key_f08( keyf8!, 0 )
end event

type st_group_mei from ivo_statictext within ws_syohin
integer x = 2808
integer y = 324
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_brand_mei from ivo_statictext within ws_syohin
integer x = 2808
integer y = 427
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type cb_brand from ivo_commandbutton within ws_syohin
integer x = 2704
integer y = 427
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_brand_code.event key_f08( keyf8!, 0 )
end event

type sle_brand_code from ivo_singlelineedit within ws_syohin
string tag = "ブランド"
integer x = 2444
integer y = 427
integer width = 252
integer taborder = 140
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""

i_brand_code	= 0

end event

event input_check;call super::input_check;string	l_code
long	l_brand_code
string	l_brand_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_brand_code.event constructor()
	st_brand_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_brand_code	= long( l_code )

// 存在チェック
select brand_mei
  into :l_brand_mei
  from m_brand
 where brand_code	= :l_brand_code
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_brand_mei.text	= trim( l_brand_mei )
		
	case 100
		// データが無い場合は初期化
		st_brand_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type st_17 from ivo_statictext within ws_syohin
integer x = 2124
integer y = 430
boolean bringtotop = true
long backcolor = 12632256
string text = "ブランド"
alignment alignment = right!
end type

type st_18 from ivo_statictext within ws_syohin
integer x = 2124
integer y = 533
boolean bringtotop = true
long backcolor = 12632256
string text = "サブブランド"
alignment alignment = right!
end type

type sle_subbrand_code from ivo_singlelineedit within ws_syohin
string tag = "サブブランド"
integer x = 2444
integer y = 530
integer width = 252
integer taborder = 150
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text		= ""

i_subbrand_code	= 0
end event

event input_check;call super::input_check;string	l_code
long	l_subbrand_code
string	l_subbrand_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_subbrand_code.event constructor()
	st_subbrand_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_subbrand_code	= long( l_code )

// 存在チェック
select brand_mei
  into :l_subbrand_mei
  from m_brand
 where brand_code	= :l_subbrand_code
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_subbrand_mei.text	= trim( l_subbrand_mei )
		
	case 100
		// データが無い場合は初期化
		st_subbrand_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type cb_subbrand from ivo_commandbutton within ws_syohin
integer x = 2704
integer y = 530
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_subbrand_code.event key_f08( keyf8!, 0 )
end event

type st_subbrand_mei from ivo_statictext within ws_syohin
integer x = 2808
integer y = 530
integer width = 1408
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_season_mei from ivo_statictext within ws_syohin
integer x = 2808
integer y = 633
integer width = 392
integer height = 89
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type cb_season from ivo_commandbutton within ws_syohin
integer x = 2704
integer y = 633
integer width = 92
boolean bringtotop = true
integer textsize = -8
string text = "･･･"
end type

event execution;call super::execution;sle_season_code.event key_f08( keyf8!, 0 )
end event

type sle_season_code from ivo_singlelineedit within ws_syohin
string tag = "シーズン"
integer x = 2444
integer y = 633
integer width = 252
integer taborder = 160
boolean bringtotop = true
integer textsize = -11
string text = "123"
integer limit = 3
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text				= ""
i_season_code		= 0
end event

event input_check;call super::input_check;string	l_code
long	l_season_code
string	l_season_mei

this.text	= trim( this.text )
l_code		= this.text

// 空にされた場合は初期化
if l_code = "" then
	sle_season_code.event constructor()
	st_season_mei.event constructor()
	
	return true
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_season_code	= long( l_code )

// 存在チェック
select meisyo_mei
  into :l_season_mei
  from m_meisyo
 where meisyo_kbn   = 121
   and meisyo_code	= :l_season_code
 using cocos;

choose case cocos.sqlcode
	case 0
		st_season_mei.text	= trim( l_season_mei )
		
	case 100
		// データが無い場合は初期化
		st_season_mei.event constructor()

	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true
end event

event key_f08;call super::key_f08;msg.of_warning( "まだ検索画面は未作成です。" )

return 0
end event

type st_21 from ivo_statictext within ws_syohin
integer x = 2124
integer y = 636
boolean bringtotop = true
long backcolor = 12632256
string text = "シーズン"
alignment alignment = right!
end type

type st_22 from ivo_statictext within ws_syohin
integer x = 24
integer y = 740
boolean bringtotop = true
long backcolor = 12632256
string text = "管理部門"
alignment alignment = right!
end type

type ddplb_bumon_code from sv_ddplb_meisyo within ws_syohin
string tag = "管理部門"
integer x = 344
integer y = 736
integer width = 456
integer taborder = 170
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 160
string init_code = "0"
end type

event constructor;call super::constructor;//i_bumon_code	= this.of_get_code_num( )
end event

type st_23 from ivo_statictext within ws_syohin
integer x = 828
integer y = 740
boolean bringtotop = true
long backcolor = 12632256
string text = "廃番区分"
alignment alignment = right!
end type

type ddplb_haiban_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "廃番区分"
integer x = 1152
integer y = 736
integer width = 456
integer taborder = 180
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 122
string init_code = "1"
end type

event constructor;call super::constructor;//i_haiban_kbn	= this.of_get_code_num( )
end event

type st_24 from ivo_statictext within ws_syohin
integer x = 1628
integer y = 740
integer width = 200
boolean bringtotop = true
long backcolor = 12632256
string text = "生産国"
alignment alignment = right!
end type

type ddplb_seisankoku_code from sv_ddplb_meisyo within ws_syohin
string tag = "生産国"
integer x = 1856
integer y = 736
integer taborder = 190
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 130
string init_code = "0"
end type

event constructor;call super::constructor;//i_seisankoku_code	= this.of_get_code_num( )
end event

type st_25 from ivo_statictext within ws_syohin
integer x = 2608
integer y = 740
integer width = 256
boolean bringtotop = true
long backcolor = 12632256
string text = "商材区分"
alignment alignment = right!
end type

type ddplb_syozai_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "商材区分"
integer x = 2880
integer y = 736
integer taborder = 200
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 127
string init_code = "1"
end type

event selectionchanged;call super::selectionchanged;//i_syozai_kbn	= this.of_get_code_num( )
end event

type st_26 from ivo_statictext within ws_syohin
integer x = 3600
integer y = 740
integer width = 196
boolean bringtotop = true
long backcolor = 12632256
string text = "規格"
alignment alignment = right!
end type

type ddplb_syohin_kikaku_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "規格"
integer x = 3812
integer y = 736
integer width = 304
integer taborder = 210
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 120
string init_code = "1"
end type

event constructor;call super::constructor;//i_syohin_kikaku_kbn	= this.of_get_code_num( )
end event

type st_27 from ivo_statictext within ws_syohin
integer x = 24
integer y = 839
boolean bringtotop = true
long backcolor = 12632256
string text = "価格GRP"
alignment alignment = right!
end type

type ddplb_kakaku_group_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "価格GRP"
integer x = 344
integer y = 836
integer width = 456
integer taborder = 220
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 131
string init_code = "1"
end type

event selectionchanged;call super::selectionchanged;//i_kakaku_group_kbn	= this.of_get_code_num( )
end event

type st_28 from ivo_statictext within ws_syohin
integer x = 812
integer y = 839
integer width = 316
boolean bringtotop = true
long backcolor = 12632256
string text = "単価表発行"
alignment alignment = right!
end type

type ddplb_tankahyo_hakkou_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "単価表発行"
integer x = 1152
integer y = 836
integer width = 456
integer taborder = 230
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 159
string init_code = "1"
end type

event constructor;call super::constructor;//i_tankahyo_hakkou_kbn	= this.of_get_code_num( )
end event

type cbx_betusun_flg from ivo_checkbox within ws_syohin
string tag = "別寸を含む"
integer x = 1876
integer y = 836
integer width = 368
integer taborder = 240
long backcolor = 12632256
string text = "別寸を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= false
i_betusun_flg	= false

end event

type cbx_hi_toriatukai_flg from ivo_checkbox within ws_syohin
string tag = "非取扱サイズを含む"
integer x = 2396
integer y = 836
integer width = 568
integer taborder = 250
long backcolor = 12632256
string text = "非取扱サイズを含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked		= false
i_hi_toriatukai_flg	= false
end event

type cbx_syusoku_flg from ivo_checkbox within ws_syohin
string tag = "終息商品を含む"
integer x = 3100
integer y = 836
integer width = 488
integer taborder = 260
long backcolor = 12632256
string text = "終息商品を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= false
i_syusoku_flg	= false
end event

type dw_list from ivo_datawindow within ws_syohin
integer y = 981
integer width = 5120
integer height = 1703
integer taborder = 270
boolean bringtotop = true
string dataobject = "ds_syohin_iro"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f9_key = true
boolean f10_key = true
boolean row_multi_select = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }
this.i_sfunction_name	= { "登録詳細", "", "", "", "", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)
end event

event key_f05;call super::key_f05;// Excel出力

string	l_file

// フルパスで入れれば保存先フォルダが指定可能

if rb_syoiro.checked then
	// 商品色単位
	l_file	= fnc.strg.of_format( "商品一覧照会_商品色単位_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )
else
	l_file	= fnc.strg.of_format( "商品一覧照会_SKU単位_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )
end if

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event getfocus;call super::getfocus;if this.rowcount() > 0 then
	sf1_key	= true
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	sf1_key	= false
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

end event

event clicked;call super::clicked;string	l_columnname

choose case right( dwo.name, 2 )
	case "_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
end choose

end event

event doubleclicked;call super::doubleclicked;long	l_syohin_code, l_iro_no

// 商品色単位時にダブルクリックした際は、対象商品をSKU別に検索する
if row > 0 then
	if rb_syoiro.checked then
		l_syohin_code			= this.object.syohin_code[row]
		l_iro_no				= this.object.iro_no[row]
		
		sle_syohin_code.text	= string( l_syohin_code )
		sle_syohin_code.event input_check( )
		
		sle_iro_no.text			= string( l_iro_no )
		sle_iro_no.event input_check( )
		
		rb_sku.checked			= true
		rb_sku.event clicked( )
		
		cb_retrieve.event clicked( )
		
		// ファンクションキーが有効にならない対策
		this.event getfocus( )
	end if
end if
end event

event key_f01;call super::key_f01;// 登録詳細
long	l_syohin_code, l_iro_no

if keyflags = 1 then
	l_syohin_code	= this.object.syohin_code[this.getrow()]
	l_iro_no		= this.object.iro_no[this.getrow()]
	
	msg.of_info( "商品登録詳細画面は未実装です。" )
end if

return 0
end event

