$PBExportHeader$ws_syohin.srw
$PBExportComments$商品一覧照会
forward
global type ws_syohin from iw_main_window
end type
type rb_syoiro_t from ivo_statictext within ws_syohin
end type
type rb_syoiro from ivo_radiobutton within ws_syohin
end type
type rb_sku from ivo_radiobutton within ws_syohin
end type
type sle_hatubai_date_from_t from ivo_statictext within ws_syohin
end type
type sle_hatubai_date_from from ivo_singlelineedit within ws_syohin
end type
type sle_hatubai_date_to_t from ivo_statictext within ws_syohin
end type
type sle_hatubai_date_to from ivo_singlelineedit within ws_syohin
end type
type sle_seriese_code_t from ivo_statictext within ws_syohin
end type
type sle_seriese_code from ivo_singlelineedit within ws_syohin
end type
type ddplb_bumon_code_t from ivo_statictext within ws_syohin
end type
type ddplb_bumon_code from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_haiban_kbn_t from ivo_statictext within ws_syohin
end type
type ddplb_haiban_kbn from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_seisankoku_code_t from ivo_statictext within ws_syohin
end type
type ddplb_seisankoku_code from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_syozai_kbn_t from ivo_statictext within ws_syohin
end type
type ddplb_syozai_kbn from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_syohin_kikaku_kbn_t from ivo_statictext within ws_syohin
end type
type ddplb_syohin_kikaku_kbn from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_kakaku_group_kbn_t from ivo_statictext within ws_syohin
end type
type ddplb_kakaku_group_kbn from sv_ddplb_meisyo within ws_syohin
end type
type ddplb_tankahyo_hakkou_kbn_t from ivo_statictext within ws_syohin
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
type uo_daibunrui from cv_input_bunrui within ws_syohin
end type
type uo_tyubunrui from cv_input_bunrui within ws_syohin
end type
type uo_syobunrui from cv_input_bunrui within ws_syohin
end type
type uo_bukken from cv_input_bukken within ws_syohin
end type
type uo_group from cv_input_group within ws_syohin
end type
type uo_brand from cv_input_brand within ws_syohin
end type
type uo_subbrand from cv_input_brand within ws_syohin
end type
type uo_season from cv_input_meisyo within ws_syohin
end type
type uo_syohin from cv_input_syohin within ws_syohin
end type
end forward

global type ws_syohin from iw_main_window
string title = "商品一覧照会"
rb_syoiro_t rb_syoiro_t
rb_syoiro rb_syoiro
rb_sku rb_sku
sle_hatubai_date_from_t sle_hatubai_date_from_t
sle_hatubai_date_from sle_hatubai_date_from
sle_hatubai_date_to_t sle_hatubai_date_to_t
sle_hatubai_date_to sle_hatubai_date_to
sle_seriese_code_t sle_seriese_code_t
sle_seriese_code sle_seriese_code
ddplb_bumon_code_t ddplb_bumon_code_t
ddplb_bumon_code ddplb_bumon_code
ddplb_haiban_kbn_t ddplb_haiban_kbn_t
ddplb_haiban_kbn ddplb_haiban_kbn
ddplb_seisankoku_code_t ddplb_seisankoku_code_t
ddplb_seisankoku_code ddplb_seisankoku_code
ddplb_syozai_kbn_t ddplb_syozai_kbn_t
ddplb_syozai_kbn ddplb_syozai_kbn
ddplb_syohin_kikaku_kbn_t ddplb_syohin_kikaku_kbn_t
ddplb_syohin_kikaku_kbn ddplb_syohin_kikaku_kbn
ddplb_kakaku_group_kbn_t ddplb_kakaku_group_kbn_t
ddplb_kakaku_group_kbn ddplb_kakaku_group_kbn
ddplb_tankahyo_hakkou_kbn_t ddplb_tankahyo_hakkou_kbn_t
ddplb_tankahyo_hakkou_kbn ddplb_tankahyo_hakkou_kbn
cbx_betusun_flg cbx_betusun_flg
cbx_hi_toriatukai_flg cbx_hi_toriatukai_flg
cbx_syusoku_flg cbx_syusoku_flg
dw_list dw_list
uo_daibunrui uo_daibunrui
uo_tyubunrui uo_tyubunrui
uo_syobunrui uo_syobunrui
uo_bukken uo_bukken
uo_group uo_group
uo_brand uo_brand
uo_subbrand uo_subbrand
uo_season uo_season
uo_syohin uo_syohin
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
uo_syohin.event constructor( )
//sle_syohin_code.event constructor( )
//sle_iro_no.event constructor( )
//sle_daibunrui_code.event constructor( )
//st_daibunrui_mei.event constructor( )
//sle_tyubunrui_code.event constructor( )
//st_tyubunrui_mei.event constructor( )
//sle_syobunrui_code.event constructor( )
//st_syobunrui_mei.event constructor( )
//sle_bukken_code.event constructor( )
//st_bukken_mei.event constructor( )
//sle_group_code.event constructor( )
//st_group_mei.event constructor( )
//sle_brand_code.event constructor( )
//st_brand_mei.event constructor( )
//sle_subbrand_code.event constructor( )
//st_subbrand_mei.event constructor( )
//sle_season_code.event constructor( )
//st_season_mei.event constructor( )

uo_daibunrui.event constructor( )
uo_daibunrui.event constructor( )
uo_daibunrui.event constructor( )
uo_bukken.event constructor( )
uo_group.event constructor( )
uo_brand.event constructor( )
uo_subbrand.event constructor( )
uo_season.event constructor( )

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
this.rb_syoiro_t=create rb_syoiro_t
this.rb_syoiro=create rb_syoiro
this.rb_sku=create rb_sku
this.sle_hatubai_date_from_t=create sle_hatubai_date_from_t
this.sle_hatubai_date_from=create sle_hatubai_date_from
this.sle_hatubai_date_to_t=create sle_hatubai_date_to_t
this.sle_hatubai_date_to=create sle_hatubai_date_to
this.sle_seriese_code_t=create sle_seriese_code_t
this.sle_seriese_code=create sle_seriese_code
this.ddplb_bumon_code_t=create ddplb_bumon_code_t
this.ddplb_bumon_code=create ddplb_bumon_code
this.ddplb_haiban_kbn_t=create ddplb_haiban_kbn_t
this.ddplb_haiban_kbn=create ddplb_haiban_kbn
this.ddplb_seisankoku_code_t=create ddplb_seisankoku_code_t
this.ddplb_seisankoku_code=create ddplb_seisankoku_code
this.ddplb_syozai_kbn_t=create ddplb_syozai_kbn_t
this.ddplb_syozai_kbn=create ddplb_syozai_kbn
this.ddplb_syohin_kikaku_kbn_t=create ddplb_syohin_kikaku_kbn_t
this.ddplb_syohin_kikaku_kbn=create ddplb_syohin_kikaku_kbn
this.ddplb_kakaku_group_kbn_t=create ddplb_kakaku_group_kbn_t
this.ddplb_kakaku_group_kbn=create ddplb_kakaku_group_kbn
this.ddplb_tankahyo_hakkou_kbn_t=create ddplb_tankahyo_hakkou_kbn_t
this.ddplb_tankahyo_hakkou_kbn=create ddplb_tankahyo_hakkou_kbn
this.cbx_betusun_flg=create cbx_betusun_flg
this.cbx_hi_toriatukai_flg=create cbx_hi_toriatukai_flg
this.cbx_syusoku_flg=create cbx_syusoku_flg
this.dw_list=create dw_list
this.uo_daibunrui=create uo_daibunrui
this.uo_tyubunrui=create uo_tyubunrui
this.uo_syobunrui=create uo_syobunrui
this.uo_bukken=create uo_bukken
this.uo_group=create uo_group
this.uo_brand=create uo_brand
this.uo_subbrand=create uo_subbrand
this.uo_season=create uo_season
this.uo_syohin=create uo_syohin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_syoiro_t
this.Control[iCurrent+2]=this.rb_syoiro
this.Control[iCurrent+3]=this.rb_sku
this.Control[iCurrent+4]=this.sle_hatubai_date_from_t
this.Control[iCurrent+5]=this.sle_hatubai_date_from
this.Control[iCurrent+6]=this.sle_hatubai_date_to_t
this.Control[iCurrent+7]=this.sle_hatubai_date_to
this.Control[iCurrent+8]=this.sle_seriese_code_t
this.Control[iCurrent+9]=this.sle_seriese_code
this.Control[iCurrent+10]=this.ddplb_bumon_code_t
this.Control[iCurrent+11]=this.ddplb_bumon_code
this.Control[iCurrent+12]=this.ddplb_haiban_kbn_t
this.Control[iCurrent+13]=this.ddplb_haiban_kbn
this.Control[iCurrent+14]=this.ddplb_seisankoku_code_t
this.Control[iCurrent+15]=this.ddplb_seisankoku_code
this.Control[iCurrent+16]=this.ddplb_syozai_kbn_t
this.Control[iCurrent+17]=this.ddplb_syozai_kbn
this.Control[iCurrent+18]=this.ddplb_syohin_kikaku_kbn_t
this.Control[iCurrent+19]=this.ddplb_syohin_kikaku_kbn
this.Control[iCurrent+20]=this.ddplb_kakaku_group_kbn_t
this.Control[iCurrent+21]=this.ddplb_kakaku_group_kbn
this.Control[iCurrent+22]=this.ddplb_tankahyo_hakkou_kbn_t
this.Control[iCurrent+23]=this.ddplb_tankahyo_hakkou_kbn
this.Control[iCurrent+24]=this.cbx_betusun_flg
this.Control[iCurrent+25]=this.cbx_hi_toriatukai_flg
this.Control[iCurrent+26]=this.cbx_syusoku_flg
this.Control[iCurrent+27]=this.dw_list
this.Control[iCurrent+28]=this.uo_daibunrui
this.Control[iCurrent+29]=this.uo_tyubunrui
this.Control[iCurrent+30]=this.uo_syobunrui
this.Control[iCurrent+31]=this.uo_bukken
this.Control[iCurrent+32]=this.uo_group
this.Control[iCurrent+33]=this.uo_brand
this.Control[iCurrent+34]=this.uo_subbrand
this.Control[iCurrent+35]=this.uo_season
this.Control[iCurrent+36]=this.uo_syohin
end on

on ws_syohin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_syoiro_t)
destroy(this.rb_syoiro)
destroy(this.rb_sku)
destroy(this.sle_hatubai_date_from_t)
destroy(this.sle_hatubai_date_from)
destroy(this.sle_hatubai_date_to_t)
destroy(this.sle_hatubai_date_to)
destroy(this.sle_seriese_code_t)
destroy(this.sle_seriese_code)
destroy(this.ddplb_bumon_code_t)
destroy(this.ddplb_bumon_code)
destroy(this.ddplb_haiban_kbn_t)
destroy(this.ddplb_haiban_kbn)
destroy(this.ddplb_seisankoku_code_t)
destroy(this.ddplb_seisankoku_code)
destroy(this.ddplb_syozai_kbn_t)
destroy(this.ddplb_syozai_kbn)
destroy(this.ddplb_syohin_kikaku_kbn_t)
destroy(this.ddplb_syohin_kikaku_kbn)
destroy(this.ddplb_kakaku_group_kbn_t)
destroy(this.ddplb_kakaku_group_kbn)
destroy(this.ddplb_tankahyo_hakkou_kbn_t)
destroy(this.ddplb_tankahyo_hakkou_kbn)
destroy(this.cbx_betusun_flg)
destroy(this.cbx_hi_toriatukai_flg)
destroy(this.cbx_syusoku_flg)
destroy(this.dw_list)
destroy(this.uo_daibunrui)
destroy(this.uo_tyubunrui)
destroy(this.uo_syobunrui)
destroy(this.uo_bukken)
destroy(this.uo_group)
destroy(this.uo_brand)
destroy(this.uo_subbrand)
destroy(this.uo_season)
destroy(this.uo_syohin)
end on

event resize;call super::resize;
// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y
long l_row_4_y
long l_row_5_y
long l_row_6_y
long l_row_7_y

long l_komoku_height = 89

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE
rb_syoiro.y						= l_row_1_y
rb_sku.y						= l_row_1_y
sle_hatubai_date_from.y			= l_row_1_y
sle_hatubai_date_to.y			= l_row_1_y
sle_seriese_code.y				= l_row_1_y
uo_syohin.y							= l_row_1_y
//sle_syohin_code.y				= l_row_1_y
//sle_iro_no.y					= l_row_1_y
//cb_syoiro.y						= l_row_1_y
rb_syoiro_t.y					= l_row_1_y + 7
sle_hatubai_date_from_t.y		= l_row_1_y + 7
sle_hatubai_date_to_t.y			= l_row_1_y + 7
sle_seriese_code_t.y			= l_row_1_y + 7
//sle_iro_no_t.y					= l_row_1_y + 7

// 2行目
l_row_2_y						= l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE
uo_daibunrui.y					= l_row_2_y
uo_group.y						= l_row_2_y

// 3行目
l_row_3_y						= l_row_2_y + l_komoku_height + code.MGN_UPPER_TATE
uo_tyubunrui.y					= l_row_3_y
uo_brand.y						= l_row_3_y

// 4行目
l_row_4_y						= l_row_3_y + l_komoku_height + code.MGN_UPPER_TATE
uo_syobunrui.y					= l_row_4_y
uo_subbrand.y					= l_row_4_y

// 5行目
l_row_5_y						= l_row_4_y + l_komoku_height + code.MGN_UPPER_TATE
uo_bukken.y						= l_row_5_y
uo_season.y						= l_row_5_y

// 6行目
l_row_6_y						= l_row_5_y + l_komoku_height + code.MGN_UPPER_TATE
ddplb_bumon_code.y				= l_row_6_y
ddplb_haiban_kbn.y				= l_row_6_y
ddplb_seisankoku_code.y			= l_row_6_y
ddplb_syozai_kbn.y				= l_row_6_y
ddplb_syohin_kikaku_kbn.y		= l_row_6_y
ddplb_bumon_code_t.y			= l_row_6_y + 7
ddplb_haiban_kbn_t.y			= l_row_6_y + 7
ddplb_seisankoku_code_t.y		= l_row_6_y + 7
ddplb_syozai_kbn_t.y			= l_row_6_y + 7
ddplb_syohin_kikaku_kbn_t.y		= l_row_6_y + 7

// 7行目
l_row_7_y						= l_row_6_y + l_komoku_height + code.MGN_UPPER_TATE
ddplb_kakaku_group_kbn.y		= l_row_7_y
ddplb_kakaku_group_kbn.y		= l_row_7_y
ddplb_tankahyo_hakkou_kbn.y		= l_row_7_y
cbx_betusun_flg.y				= l_row_7_y
cbx_hi_toriatukai_flg.y			= l_row_7_y
cbx_syusoku_flg.y				= l_row_7_y

ddplb_kakaku_group_kbn_t.y		= l_row_7_y + 7
ddplb_tankahyo_hakkou_kbn_t.y	= l_row_7_y + 7

// st_second_upper高さ
st_second_upper.height	= l_row_7_y + l_komoku_height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
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

//if sle_syohin_code.text <> "" then
//	i_syohin_code			= long( sle_syohin_code.text )
//else
//	i_syohin_code			= 0	
//end if
//
//if sle_iro_no.text <> "" then
//	i_iro_no				= long( sle_iro_no.text )
//else
//	i_iro_no				= 0	
//end if

//if sle_daibunrui_code.text <> "" then
//	i_daibunrui_code		= long( sle_daibunrui_code.text )
//else
//	i_daibunrui_code		= 0	
//end if
//
//if sle_tyubunrui_code.text <> "" then
//	i_tyubunrui_code		= long( sle_tyubunrui_code.text )
//else
//	i_tyubunrui_code		= 0	
//end if
//
//if sle_syobunrui_code.text <> "" then
//	i_syobunrui_code		= long( sle_syobunrui_code.text )
//else
//	i_syobunrui_code		= 0	
//end if
//
//if sle_bukken_code.text <> "" then
//	i_bukken_code			= long( sle_bukken_code.text )
//else
//	i_bukken_code			= 0	
//end if
//
//if sle_group_code.text <> "" then
//	i_group_code			= long( sle_group_code.text )
//else
//	i_group_code			= 0	
//end if
//
//if sle_brand_code.text <> "" then
//	i_brand_code			= long( sle_brand_code.text )
//else
//	i_brand_code			= 0
//end if
//
//if sle_subbrand_code.text <> "" then
//	i_subbrand_code			= long( sle_subbrand_code.text )
//else
//	i_subbrand_code			= 0	
//end if
//
//if sle_season_code.text <> "" then
//	i_season_code			= long( sle_season_code.text )
//else
//	i_season_code			= 0
//end if

// コード以外を使う時
//if uo_syohin.get then
//	l_kbn	= uo_syohin.of_get_kbn( )
//end if

i_syohin_code			= uo_syohin.of_get_syohin_code( )
i_iro_no				= uo_syohin.of_get_iro_no( )

i_daibunrui_code		= uo_daibunrui.of_get_daibunrui_code( )
i_tyubunrui_code		= uo_tyubunrui.of_get_tyubunrui_code( )
i_syobunrui_code		= uo_syobunrui.of_get_syobunrui_code( )
i_bukken_code			= uo_bukken.of_get_bukken_code( )
i_group_code			= uo_group.of_get_group_code( )
i_brand_code			= uo_brand.of_get_brand_code( )
i_subbrand_code			= uo_subbrand.of_get_brand_code( )
i_season_code			= long( uo_season.of_get_meisyo_code( ) )

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
//msg.of_info( "商品コード：" + string( i_syohin_code ) )
if i_syohin_code <> -1 then
	l_sql_where	+= "   and syohin.syohin_code          = " + string( i_syohin_code ) + code.crlf
end if

if uo_syohin.get then
//	l_bettyu_flg	= uo_syohin.of_get_bettyu_flg( )
end if

// 色番
//msg.of_info( "色番：" + string( i_iro_no ) )
if i_iro_no <> -1 then
	l_sql_where	+= "   and syohin.iro_no                = " + string( i_iro_no ) + code.crlf
end if

// 大分類
if i_daibunrui_code <> -1 then
	l_sql_where	+= "   and syohin.daibunrui_code        = " + string( i_daibunrui_code ) + code.crlf
end if

// 中分類
if i_tyubunrui_code <> -1 then
	l_sql_where	+= "   and syohin.tyubunrui_code        = " + string( i_tyubunrui_code ) + code.crlf
end if

// 小分類
if i_syobunrui_code <> -1 then
	l_sql_where	+= "   and syohin.syobunrui_code        = " + string( i_syobunrui_code ) + code.crlf
end if

// 物件
if i_bukken_code <> -1 then
	l_sql_where	+= "   and syohin.bukken_code           = " + string( i_bukken_code ) + code.crlf
end if

// グループ
if i_group_code <> -1 then
	l_sql_where	+= "   and syohin.group_code            = " + string( i_group_code ) + code.crlf
end if

// ブランド
if i_brand_code <> -1 then
	l_sql_where	+= "   and syohin.brand_code            = " + string( i_brand_code ) + code.crlf
end if

// サブブランド
if i_subbrand_code <> -1 then
	l_sql_where	+= "   and syohin.subbrand_code         = " + string( i_subbrand_code ) + code.crlf
end if

// シーズン
if i_season_code <> 0 then
	l_sql_where	+= "   and syohin.season_code           = " + string( i_season_code ) + code.crlf
end if

// 管理部門
if not isnull( i_bumon_code ) then
	l_sql_where	+= "   and syohin.bumon_code            = " + string( i_bumon_code ) + code.crlf
end if

// 廃番区分
if not isnull( i_haiban_kbn ) then
	l_sql_where	+= "   and syohin.haiban_kbn            = " + string( i_haiban_kbn ) + code.crlf
end if

// 生産国
if not isnull( i_seisankoku_code ) then
	l_sql_where	+= "   and syohin.seisankoku_code       = " + string( i_seisankoku_code ) + code.crlf
end if

// 商材区分
if not isnull( i_syozai_kbn ) then
	l_sql_where	+= "   and syohin.syozai_kbn            = " + string( i_syozai_kbn ) + code.crlf
end if

// 規格
if not isnull( i_syohin_kikaku_kbn ) then
	l_sql_where	+= "   and syohin.syohin_kukaku_kbn            = " + string( i_syohin_kikaku_kbn ) + code.crlf
end if

// 価格GRP
if not isnull( i_kakaku_group_kbn ) then
	l_sql_where	+= "   and syohin.kakaku_group_kbn      = " + string( i_kakaku_group_kbn ) + code.crlf
end if

// 単価表発行
if not isnull( i_tankahyo_hakkou_kbn ) then
	l_sql_where	+= "   and syohin.tankahyo_hakkou_kbn   = " + string( i_tankahyo_hakkou_kbn ) + code.crlf
end if


// 別寸を含む
if not i_betusun_flg then
//	l_sql_where	+= "   and syohin.size_code not in ( 'ﾍﾞﾂｽﾝ','ﾍﾞｯｽﾝ' ) " + code.crlf
	l_sql_where	+= "   and syohin.up_iti between 0 AND 4" + code.crlf
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
	// 最後に出現する"group by"の前にWhere句を追加する
	l_sql_new	= Mid( l_sql_old, 1, LastPos( l_sql_old, "group by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, LastPos( l_sql_old, "group by" ) )
else
	// SKU単位
//	l_sql_new	= l_sql_old + code.crlf + l_sql_where
	// 最後に出現する"order by"の前にWhere句を追加する
	l_sql_new	= Mid( l_sql_old, 1, LastPos( l_sql_old, "order by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, LastPos( l_sql_old, "order by" ) )

end if

dw_list.reset( )


// 組み立てたSQLをセットする
dw_list.setsqlselect( l_sql_new )

// 検索
if dw_list.retrieve( ) = 0 then
	// SQLを元に戻す
	dw_list.setsqlselect( l_sql_old )
	
	msg.of_error( "入力した条件に該当するデータはありません。" )
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

// 処理区分があるときと同様に存在チェックをする
//uo_daibunrui.of_set_dbchk_exst( )
//uo_tyubunrui.of_set_dbchk_exst( )
//uo_syobunrui.of_set_dbchk_exst( )

uo_syohin.of_set_dbchk_none( )
uo_daibunrui.of_set_dbchk_none( )
uo_tyubunrui.of_set_dbchk_none( )
uo_syobunrui.of_set_dbchk_none( )
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
if not uo_syohin.event sle_input_check( ) then
	return -1
end if

// 色番
// TODO:商品CDの入力値が無い場合エラーメッセージがでる
if not uo_syohin.event sle_iro_input_check( ) then
	return -1
end if

// 大分類
if uo_daibunrui.of_get_input( ) <> "" AND not uo_daibunrui.event sle_input_check( ) then
	return -1
end if

// 中分類
// TODO:入力値があると、大分類=0の条件で取得している？ので常にデータがないエラー発生する
// TODO:入力値がない　AND　大分類に入力値がある場合中分類＝0になる、大分類なければ中分類＝-1になる
if uo_tyubunrui.of_get_input( ) <> "" AND not uo_tyubunrui.event sle_input_check( ) then
	return -1
end if

// 小分類
if uo_syobunrui.of_get_input( ) <> "" AND not uo_syobunrui.event sle_input_check( ) then
	return -1
end if

// 物件
if uo_bukken.of_get_input( ) <> "" AND not uo_bukken.event sle_input_check( ) then
	return -1
end if

// グループ
if uo_group.of_get_input( ) <> "" AND not uo_group.event sle_input_check( ) then
	return -1
end if

// ブランド
if uo_brand.of_get_input( ) <> "" AND not uo_brand.event sle_input_check( ) then
	return -1
end if

// サブブランド
if uo_subbrand.of_get_input( ) <> "" AND not uo_subbrand.event sle_input_check( ) then
	return -1
end if

// シーズン
if uo_season.of_get_input( ) <> "" AND not uo_season.event sle_input_check( ) then
	return -1
end if

//// 大分類
//if not sle_daibunrui_code.event input_check( ) then
//	return -1
//end if
//
//// 中分類
//if not sle_tyubunrui_code.event input_check( ) then
//	return -1
//end if
//
//// 小分類
//if not sle_syobunrui_code.event input_check( ) then
//	return -1
//end if
//
//// 物件
//if not sle_bukken_code.event input_check( ) then
//	return -1
//end if
//
//// グループ
//if not sle_group_code.event input_check( ) then
//	return -1
//end if
//
//// ブランド
//if not sle_brand_code.event input_check( ) then
//	return -1
//end if
//
//// サブブランド
//if not sle_subbrand_code.event input_check( ) then
//	return -1
//end if
//
//// シーズン
//if not sle_season_code.event input_check( ) then
//	return -1
//end if
//

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
integer y = 132
integer height = 942
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_syohin
integer x = 4700
integer y = 853
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type rb_syoiro_t from ivo_statictext within ws_syohin
integer x = 32
integer y = 199
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "表示単位"
alignment alignment = right!
end type

type rb_syoiro from ivo_radiobutton within ws_syohin
string tag = "商品色単位"
integer x = 376
integer y = 192
integer width = 488
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
integer x = 880
integer y = 192
integer width = 328
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

type sle_hatubai_date_from_t from ivo_statictext within ws_syohin
integer x = 1240
integer y = 199
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "発売日"
alignment alignment = right!
end type

type sle_hatubai_date_from from ivo_singlelineedit within ws_syohin
string tag = "発売日(開始日)"
integer x = 1504
integer y = 192
integer width = 404
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

event input_check;call super::input_check;
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_hatubai_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			this.of_msg_error( "発売日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type sle_hatubai_date_to_t from ivo_statictext within ws_syohin
integer x = 1924
integer y = 199
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_hatubai_date_to from ivo_singlelineedit within ws_syohin
string tag = "発売日(終了日)"
integer x = 2028
integer y = 192
integer width = 404
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

event input_check;call super::input_check;
string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_from	= sle_hatubai_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date_from > l_date then
			this.of_msg_error( "発売日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type sle_seriese_code_t from ivo_statictext within ws_syohin
integer x = 2464
integer y = 199
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "シリーズ"
alignment alignment = right!
end type

type sle_seriese_code from ivo_singlelineedit within ws_syohin
string tag = "シリーズ"
integer x = 2728
integer y = 192
integer width = 248
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

type ddplb_bumon_code_t from ivo_statictext within ws_syohin
integer x = 32
integer y = 750
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "管理部門"
alignment alignment = right!
end type

type ddplb_bumon_code from sv_ddplb_meisyo within ws_syohin
string tag = "管理部門"
integer x = 376
integer y = 743
integer width = 428
integer taborder = 160
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 21
boolean enabled_null = true
end type

type ddplb_haiban_kbn_t from ivo_statictext within ws_syohin
integer x = 836
integer y = 750
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "廃番区分"
alignment alignment = right!
end type

type ddplb_haiban_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "廃番区分"
integer x = 1180
integer y = 743
integer width = 668
integer taborder = 170
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 122
boolean enabled_null = true
end type

type ddplb_seisankoku_code_t from ivo_statictext within ws_syohin
integer x = 1880
integer y = 750
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "生産国"
alignment alignment = right!
end type

type ddplb_seisankoku_code from sv_ddplb_meisyo within ws_syohin
string tag = "生産国"
integer x = 2144
integer y = 743
integer width = 668
integer taborder = 180
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 130
boolean enabled_null = true
end type

type ddplb_syozai_kbn_t from ivo_statictext within ws_syohin
integer x = 2844
integer y = 750
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "商材区分"
alignment alignment = right!
end type

type ddplb_syozai_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "商材区分"
integer x = 3188
integer y = 743
integer width = 668
integer taborder = 190
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 127
boolean enabled_null = true
end type

type ddplb_syohin_kikaku_kbn_t from ivo_statictext within ws_syohin
integer x = 3888
integer y = 750
integer width = 168
boolean bringtotop = true
long backcolor = 12632256
string text = "規格"
alignment alignment = right!
end type

type ddplb_syohin_kikaku_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "規格"
integer x = 4072
integer y = 743
integer width = 268
integer taborder = 200
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 120
boolean enabled_null = true
end type

type ddplb_kakaku_group_kbn_t from ivo_statictext within ws_syohin
integer x = 32
integer y = 860
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "価格GRP"
alignment alignment = right!
end type

type ddplb_kakaku_group_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "価格GRP"
integer x = 376
integer y = 853
integer width = 428
integer taborder = 210
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 131
boolean enabled_null = true
end type

type ddplb_tankahyo_hakkou_kbn_t from ivo_statictext within ws_syohin
integer x = 836
integer y = 860
integer width = 408
boolean bringtotop = true
long backcolor = 12632256
string text = "単価表発行"
alignment alignment = right!
end type

type ddplb_tankahyo_hakkou_kbn from sv_ddplb_meisyo within ws_syohin
string tag = "単価表発行"
integer x = 1260
integer y = 853
integer width = 508
integer taborder = 220
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 159
boolean enabled_null = true
end type

type cbx_betusun_flg from ivo_checkbox within ws_syohin
string tag = "別寸を含む"
integer x = 1800
integer y = 853
integer width = 488
integer taborder = 230
long backcolor = 12632256
string text = "別寸を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= true

end event

type cbx_hi_toriatukai_flg from ivo_checkbox within ws_syohin
string tag = "非取扱サイズを含む"
integer x = 2304
integer y = 853
integer width = 728
integer taborder = 240
long backcolor = 12632256
string text = "非取扱サイズを含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked		= true
end event

type cbx_syusoku_flg from ivo_checkbox within ws_syohin
string tag = "終息商品を含む"
integer x = 3048
integer y = 853
integer width = 568
integer taborder = 250
long backcolor = 12632256
string text = "終息商品を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= true
end event

type dw_list from ivo_datawindow within ws_syohin
integer y = 1092
integer width = 5120
integer height = 1703
integer taborder = 260
boolean bringtotop = true
string dataobject = "ds_syohin_iro"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f9_key = true
boolean f10_key = true
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
		
//		sle_syohin_code.text	= string( l_syohin_code )
//		sle_syohin_code.event input_check( )
//		
//		sle_iro_no.text			= string( l_iro_no )
//		sle_iro_no.event input_check( )

		uo_syohin.sle_input.text		= string( l_syohin_code )
		uo_syohin.event sle_input_check( )

		uo_syohin.sle_input_iro.text	= string( l_iro_no )
		uo_syohin.event sle_iro_input_check( )

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

type uo_daibunrui from cv_input_bunrui within ws_syohin
integer x = 32
integer y = 302
integer width = 2240
integer taborder = 80
boolean bringtotop = true
string title_text = "大分類"
long title_width = 328
long input_width = 128
long bikou_width = 0
end type

on uo_daibunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_tyubunrui from cv_input_bunrui within ws_syohin
integer x = 32
integer y = 412
integer width = 2240
integer taborder = 90
boolean bringtotop = true
string title_text = "中分類"
long title_width = 328
long input_width = 128
long bikou_width = 0
boolean daibunrui = false
boolean tyubunrui = true
end type

on uo_tyubunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_syobunrui from cv_input_bunrui within ws_syohin
integer x = 32
integer y = 523
integer width = 2280
integer taborder = 100
boolean bringtotop = true
string title_text = "小分類"
long title_width = 328
long input_width = 168
long bikou_width = 0
boolean daibunrui = false
boolean syobunrui = true
end type

on uo_syobunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_bukken from cv_input_bukken within ws_syohin
integer x = 32
integer y = 633
integer width = 2320
integer taborder = 110
boolean bringtotop = true
long title_width = 328
long input_width = 208
long bikou_width = 0
end type

on uo_bukken.destroy
call cv_input_bukken::destroy
end on

type uo_group from cv_input_group within ws_syohin
integer x = 2336
integer y = 302
integer taborder = 120
boolean bringtotop = true
long title_width = 488
long input_width = 128
long bikou_width = 0
end type

on uo_group.destroy
call cv_input_group::destroy
end on

type uo_brand from cv_input_brand within ws_syohin
integer x = 2336
integer y = 412
integer taborder = 130
boolean bringtotop = true
long title_width = 488
long input_width = 128
long bikou_width = 0
end type

on uo_brand.destroy
call cv_input_brand::destroy
end on

type uo_subbrand from cv_input_brand within ws_syohin
integer x = 2336
integer y = 523
integer taborder = 140
boolean bringtotop = true
string title_text = "サブブランド"
long title_width = 488
long input_width = 128
long bikou_width = 0
end type

on uo_subbrand.destroy
call cv_input_brand::destroy
end on

type uo_season from cv_input_meisyo within ws_syohin
integer x = 2336
integer y = 633
integer width = 1200
integer taborder = 150
boolean bringtotop = true
string title_text = "シーズン"
long title_width = 488
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 121
end type

on uo_season.destroy
call cv_input_meisyo::destroy
end on

type uo_syohin from cv_input_syohin within ws_syohin
integer x = 3008
integer y = 192
integer width = 1064
integer taborder = 70
boolean bringtotop = true
string title_text = "商品CD・色番"
long title_width = 488
long bikou_width = 0
boolean meisyo_visible = false
boolean bikou_visible = false
long input_iro_width = 128
long meisyo_width = 0
long iro_mei_width = 0
boolean arrow_visible = false
boolean hin_mei_visible = false
boolean iro_mei_visible = false
boolean syusoku_hyoji = false
end type

on uo_syohin.destroy
call cv_input_syohin::destroy
end on

