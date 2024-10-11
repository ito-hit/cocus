$PBExportHeader$wsm_syohin.srw
$PBExportComments$商品検索のモーダル
forward
global type wsm_syohin from iw_modal_window
end type
type cbx_haiban_kbn from ivo_checkbox within wsm_syohin
end type
type sle_hin_ban from ivo_singlelineedit within wsm_syohin
end type
type st_hin_ban from ivo_statictext within wsm_syohin
end type
type st_hin_mei from ivo_statictext within wsm_syohin
end type
type sle_hin_mei from ivo_singlelineedit within wsm_syohin
end type
type cbx_bettyu_flg from ivo_checkbox within wsm_syohin
end type
type st_jan_code from ivo_statictext within wsm_syohin
end type
type sle_jan_code from ivo_singlelineedit within wsm_syohin
end type
type cbx_syusoku_flg from ivo_checkbox within wsm_syohin
end type
type st_and from ivo_statictext within wsm_syohin
end type
end forward

global type wsm_syohin from iw_modal_window
integer width = 3672
integer height = 2322
string title = "商品検索"
boolean immediate_retrieve = false
integer dw_height = 1442
integer dw_width = 3537
cbx_haiban_kbn cbx_haiban_kbn
sle_hin_ban sle_hin_ban
st_hin_ban st_hin_ban
st_hin_mei st_hin_mei
sle_hin_mei sle_hin_mei
cbx_bettyu_flg cbx_bettyu_flg
st_jan_code st_jan_code
sle_jan_code sle_jan_code
cbx_syusoku_flg cbx_syusoku_flg
st_and st_and
end type
global wsm_syohin wsm_syohin

type variables

public:
	str_mdlpara_msyohin	i_mdl_syohin	// 親ウインドウとの受け渡し用構造体

private:
	str_msyohin			i_para_reset[]	// i_mdl_syohin.retの初期化用
	
	string				i_hin_ban		// retrieveに使うパラメータ用
	string				i_hin_mei		// retrieveに使うパラメータ用
	string				i_jan_code		// retrieveに使うパラメータ用

end variables

forward prototypes
public subroutine of_set_filter ()
end prototypes

public subroutine of_set_filter ();
// チェックボックスの状態を見てフィルタをかける関数

string	l_filter
integer	l_row

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()

// 別注フラグ
if not cbx_bettyu_flg.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and " + "bettyu_flg <> 1"
	else
		l_filter	= "bettyu_flg <> 1"
	end if
end if

// 廃番フラグ
if not cbx_haiban_kbn.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and " + "haiban_kbn = 1"
	else
		l_filter	= "haiban_kbn = 1"
	end if
end if

// 終息フラグ
if not cbx_syusoku_flg.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and " + "syusoku_flg <> 1"
	else
		l_filter	= "syusoku_flg <> 1"
	end if
end if

// フィルタセット
dw_list.setfilter( l_filter )
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

end subroutine

on wsm_syohin.create
int iCurrent
call super::create
this.cbx_haiban_kbn=create cbx_haiban_kbn
this.sle_hin_ban=create sle_hin_ban
this.st_hin_ban=create st_hin_ban
this.st_hin_mei=create st_hin_mei
this.sle_hin_mei=create sle_hin_mei
this.cbx_bettyu_flg=create cbx_bettyu_flg
this.st_jan_code=create st_jan_code
this.sle_jan_code=create sle_jan_code
this.cbx_syusoku_flg=create cbx_syusoku_flg
this.st_and=create st_and
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_haiban_kbn
this.Control[iCurrent+2]=this.sle_hin_ban
this.Control[iCurrent+3]=this.st_hin_ban
this.Control[iCurrent+4]=this.st_hin_mei
this.Control[iCurrent+5]=this.sle_hin_mei
this.Control[iCurrent+6]=this.cbx_bettyu_flg
this.Control[iCurrent+7]=this.st_jan_code
this.Control[iCurrent+8]=this.sle_jan_code
this.Control[iCurrent+9]=this.cbx_syusoku_flg
this.Control[iCurrent+10]=this.st_and
end on

on wsm_syohin.destroy
call super::destroy
destroy(this.cbx_haiban_kbn)
destroy(this.sle_hin_ban)
destroy(this.st_hin_ban)
destroy(this.st_hin_mei)
destroy(this.sle_hin_mei)
destroy(this.cbx_bettyu_flg)
destroy(this.st_jan_code)
destroy(this.sle_jan_code)
destroy(this.cbx_syusoku_flg)
destroy(this.st_and)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_syohin.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_syohin.ret[l_index].syohin_code				= dw_list.object.syohin_code[l_row]
i_mdl_syohin.ret[l_index].iro_no					= dw_list.object.iro_no[l_row]
i_mdl_syohin.ret[l_index].eda_no					= dw_list.object.eda_no[l_row]
i_mdl_syohin.ret[l_index].size_iti					= dw_list.object.size_iti[l_row]
i_mdl_syohin.ret[l_index].size_code					= dw_list.object.size_code[l_row]
i_mdl_syohin.ret[l_index].sku_code					= dw_list.object.sku_code[l_row]
i_mdl_syohin.ret[l_index].hin_ban					= dw_list.object.hin_ban[l_row]
i_mdl_syohin.ret[l_index].hin_mei_kana				= dw_list.object.hin_mei_kana[l_row]
i_mdl_syohin.ret[l_index].iro_mei_kana				= dw_list.object.iro_mei_kana[l_row]
i_mdl_syohin.ret[l_index].hin_mei					= dw_list.object.hin_mei[l_row]
i_mdl_syohin.ret[l_index].iro_mei					= dw_list.object.iro_mei[l_row]
i_mdl_syohin.ret[l_index].size_mei					= dw_list.object.size_mei[l_row]
i_mdl_syohin.ret[l_index].hi_toriatukai_flg			= dw_list.object.hi_toriatukai_flg[l_row]
i_mdl_syohin.ret[l_index].bumon_code				= dw_list.object.bumon_code[l_row]
i_mdl_syohin.ret[l_index].kyoyo_flg					= dw_list.object.kyoyo_flg[l_row]
i_mdl_syohin.ret[l_index].brand_code				= dw_list.object.brand_code[l_row]
i_mdl_syohin.ret[l_index].subbrand_code				= dw_list.object.subbrand_code[l_row]
i_mdl_syohin.ret[l_index].season_code				= dw_list.object.season_code[l_row]
i_mdl_syohin.ret[l_index].daibunrui_code			= dw_list.object.daibunrui_code[l_row]
i_mdl_syohin.ret[l_index].tyubunrui_code			= dw_list.object.tyubunrui_code[l_row]
i_mdl_syohin.ret[l_index].syobunrui_code			= dw_list.object.syobunrui_code[l_row]
i_mdl_syohin.ret[l_index].group_code				= dw_list.object.group_code[l_row]
i_mdl_syohin.ret[l_index].seriese_code				= dw_list.object.seriese_code[l_row]
i_mdl_syohin.ret[l_index].iro_keitou_code			= dw_list.object.iro_keitou_code[l_row]
i_mdl_syohin.ret[l_index].category_code_1			= dw_list.object.category_code_1[l_row]
i_mdl_syohin.ret[l_index].category_code_2			= dw_list.object.category_code_2[l_row]
i_mdl_syohin.ret[l_index].category_code_3			= dw_list.object.category_code_3[l_row]
i_mdl_syohin.ret[l_index].category_code_4			= dw_list.object.category_code_4[l_row]
i_mdl_syohin.ret[l_index].category_code_5			= dw_list.object.category_code_5[l_row]
i_mdl_syohin.ret[l_index].hatubai_date				= dw_list.object.hatubai_date[l_row]
i_mdl_syohin.ret[l_index].haiban_kbn				= dw_list.object.haiban_kbn[l_row]
i_mdl_syohin.ret[l_index].haiban_flg				= dw_list.object.haiban_flg[l_row]
i_mdl_syohin.ret[l_index].haiban_date				= dw_list.object.haiban_date[l_row]
i_mdl_syohin.ret[l_index].haiban_riyu_kbn			= dw_list.object.haiban_riyu_kbn[l_row]
i_mdl_syohin.ret[l_index].syusoku_flg				= dw_list.object.syusoku_flg[l_row]
i_mdl_syohin.ret[l_index].syobunhin_flg				= dw_list.object.syobunhin_flg[l_row]
i_mdl_syohin.ret[l_index].jyutenhin_flg				= dw_list.object.jyutenhin_flg[l_row]
i_mdl_syohin.ret[l_index].jyoudai					= dw_list.object.jyoudai[l_row]
i_mdl_syohin.ret[l_index].jyoudai_koukai_flg		= dw_list.object.jyoudai_koukai_flg[l_row]
i_mdl_syohin.ret[l_index].kakaku_group_kbn			= dw_list.object.kakaku_group_kbn[l_row]
i_mdl_syohin.ret[l_index].up_iti					= dw_list.object.up_iti[l_row]
i_mdl_syohin.ret[l_index].up_gaku					= dw_list.object.up_gaku[l_row]
i_mdl_syohin.ret[l_index].up_gaku_j					= dw_list.object.up_gaku_j[l_row]
i_mdl_syohin.ret[l_index].tanka_touroku_flg			= dw_list.object.tanka_touroku_flg[l_row]
i_mdl_syohin.ret[l_index].kyuu_jyoudai				= dw_list.object.kyuu_jyoudai[l_row]
i_mdl_syohin.ret[l_index].jyoudai_henkou_date		= dw_list.object.jyoudai_henkou_date[l_row]
i_mdl_syohin.ret[l_index].sin_jyoudai				= dw_list.object.sin_jyoudai[l_row]
i_mdl_syohin.ret[l_index].sin_jyoudai_tekiyou_date	= dw_list.object.sin_jyoudai_tekiyou_date[l_row]
i_mdl_syohin.ret[l_index].kibou_kouri_kakaku		= dw_list.object.kibou_kouri_kakaku[l_row]
i_mdl_syohin.ret[l_index].yotei_genka				= dw_list.object.yotei_genka[l_row]
i_mdl_syohin.ret[l_index].hyojyun_genka				= dw_list.object.hyojyun_genka[l_row]
i_mdl_syohin.ret[l_index].jissai_genka				= dw_list.object.jissai_genka[l_row]
i_mdl_syohin.ret[l_index].siiresaki_code			= dw_list.object.siiresaki_code[l_row]
i_mdl_syohin.ret[l_index].maker_hinban				= dw_list.object.maker_hinban[l_row]
i_mdl_syohin.ret[l_index].syohin_kukaku_kbn			= dw_list.object.syohin_kukaku_kbn[l_row]
i_mdl_syohin.ret[l_index].bettyu_flg				= dw_list.object.bettyu_flg[l_row]
i_mdl_syohin.ret[l_index].bettyu_running_flg		= dw_list.object.bettyu_running_flg[l_row]
i_mdl_syohin.ret[l_index].tokui_code				= dw_list.object.tokui_code[l_row]
i_mdl_syohin.ret[l_index].bukken_code				= dw_list.object.bukken_code[l_row]
i_mdl_syohin.ret[l_index].tokutei_tokui_kbn			= dw_list.object.tokutei_tokui_kbn[l_row]
i_mdl_syohin.ret[l_index].irisu						= dw_list.object.irisu[l_row]
i_mdl_syohin.ret[l_index].ball_irisu				= dw_list.object.ball_irisu[l_row]
i_mdl_syohin.ret[l_index].tani_kbn					= dw_list.object.tani_kbn[l_row]
i_mdl_syohin.ret[l_index].hatyu_tanni_su			= dw_list.object.hatyu_tanni_su[l_row]
i_mdl_syohin.ret[l_index].hanbai_tanni_su			= dw_list.object.hanbai_tanni_su[l_row]
i_mdl_syohin.ret[l_index].rank						= dw_list.object.rank[l_row]
i_mdl_syohin.ret[l_index].seihin_syohin_kbn			= dw_list.object.seihin_syohin_kbn[l_row]
i_mdl_syohin.ret[l_index].irisu_hyoji_kbn			= dw_list.object.irisu_hyoji_kbn[l_row]
i_mdl_syohin.ret[l_index].keikaku_kbn				= dw_list.object.keikaku_kbn[l_row]
i_mdl_syohin.ret[l_index].hatyu_kbn					= dw_list.object.hatyu_kbn[l_row]
i_mdl_syohin.ret[l_index].hatyusaki_kbn				= dw_list.object.hatyusaki_kbn[l_row]
i_mdl_syohin.ret[l_index].syozai_kbn				= dw_list.object.syozai_kbn[l_row]
i_mdl_syohin.ret[l_index].syokuti_flg				= dw_list.object.syokuti_flg[l_row]
i_mdl_syohin.ret[l_index].zaiko_kanri_flg			= dw_list.object.zaiko_kanri_flg[l_row]
i_mdl_syohin.ret[l_index].suryo_keisan_flg			= dw_list.object.suryo_keisan_flg[l_row]
i_mdl_syohin.ret[l_index].kingaku_keisan_flg		= dw_list.object.kingaku_keisan_flg[l_row]
i_mdl_syohin.ret[l_index].arari_keisan_flg			= dw_list.object.arari_keisan_flg[l_row]
i_mdl_syohin.ret[l_index].hako_keisan_flg			= dw_list.object.hako_keisan_flg[l_row]
i_mdl_syohin.ret[l_index].kenpin_taisyo_flg			= dw_list.object.kenpin_taisyo_flg[l_row]
i_mdl_syohin.ret[l_index].muryo_kyoka_flg			= dw_list.object.muryo_kyoka_flg[l_row]
i_mdl_syohin.ret[l_index].bhin_flg					= dw_list.object.bhin_flg[l_row]
i_mdl_syohin.ret[l_index].tankahyo_hakkou_kbn		= dw_list.object.tankahyo_hakkou_kbn[l_row]
i_mdl_syohin.ret[l_index].kankyo_hairyo_flg			= dw_list.object.kankyo_hairyo_flg[l_row]
i_mdl_syohin.ret[l_index].zeiritu_kbn				= dw_list.object.zeiritu_kbn[l_row]
i_mdl_syohin.ret[l_index].siirehin_flg				= dw_list.object.siirehin_flg[l_row]
i_mdl_syohin.ret[l_index].kuuyu_kinsi_flg			= dw_list.object.kuuyu_kinsi_flg[l_row]
i_mdl_syohin.ret[l_index].sozai						= dw_list.object.sozai[l_row]
i_mdl_syohin.ret[l_index].konritu_1					= dw_list.object.konritu_1[l_row]
i_mdl_syohin.ret[l_index].konritu_2					= dw_list.object.konritu_2[l_row]
i_mdl_syohin.ret[l_index].konritu_3					= dw_list.object.konritu_3[l_row]
i_mdl_syohin.ret[l_index].konritu_4					= dw_list.object.konritu_4[l_row]
i_mdl_syohin.ret[l_index].konritu_5					= dw_list.object.konritu_5[l_row]
i_mdl_syohin.ret[l_index].konritu_6					= dw_list.object.konritu_6[l_row]
i_mdl_syohin.ret[l_index].konritu_7					= dw_list.object.konritu_7[l_row]
i_mdl_syohin.ret[l_index].konritu_8					= dw_list.object.konritu_8[l_row]
i_mdl_syohin.ret[l_index].konritu_9					= dw_list.object.konritu_9[l_row]
i_mdl_syohin.ret[l_index].konritu_10				= dw_list.object.konritu_10[l_row]
i_mdl_syohin.ret[l_index].seisankoku_code			= dw_list.object.seisankoku_code[l_row]
i_mdl_syohin.ret[l_index].yoki_kami					= dw_list.object.yoki_kami[l_row]
i_mdl_syohin.ret[l_index].yoki_pla					= dw_list.object.yoki_pla[l_row]
i_mdl_syohin.ret[l_index].housou_kami				= dw_list.object.housou_kami[l_row]
i_mdl_syohin.ret[l_index].housou_pla				= dw_list.object.housou_pla[l_row]
i_mdl_syohin.ret[l_index].sunpo_tate				= dw_list.object.sunpo_tate[l_row]
i_mdl_syohin.ret[l_index].sunpo_yoko				= dw_list.object.sunpo_yoko[l_row]
i_mdl_syohin.ret[l_index].sunpo_takasa				= dw_list.object.sunpo_takasa[l_row]
i_mdl_syohin.ret[l_index].jyuryo					= dw_list.object.jyuryo[l_row]
i_mdl_syohin.ret[l_index].tijimi_ritu				= dw_list.object.tijimi_ritu[l_row]
i_mdl_syohin.ret[l_index].flg_1						= dw_list.object.flg_1[l_row]
i_mdl_syohin.ret[l_index].flg_2						= dw_list.object.flg_2[l_row]
i_mdl_syohin.ret[l_index].flg_3						= dw_list.object.flg_3[l_row]
i_mdl_syohin.ret[l_index].flg_4						= dw_list.object.flg_4[l_row]
i_mdl_syohin.ret[l_index].flg_5						= dw_list.object.flg_5[l_row]
i_mdl_syohin.ret[l_index].kbn_1						= dw_list.object.kbn_1[l_row]
i_mdl_syohin.ret[l_index].kbn_2						= dw_list.object.kbn_2[l_row]
i_mdl_syohin.ret[l_index].kbn_3						= dw_list.object.kbn_3[l_row]
i_mdl_syohin.ret[l_index].kbn_4						= dw_list.object.kbn_4[l_row]
i_mdl_syohin.ret[l_index].kbn_5						= dw_list.object.kbn_5[l_row]
i_mdl_syohin.ret[l_index].touroku_kbn				= dw_list.object.touroku_kbn[l_row]
i_mdl_syohin.ret[l_index].touroku_date				= dw_list.object.touroku_date[l_row]
i_mdl_syohin.ret[l_index].touroku_user_id			= dw_list.object.touroku_user_id[l_row]
i_mdl_syohin.ret[l_index].touroku_client_id			= dw_list.object.touroku_client_id[l_row]
i_mdl_syohin.ret[l_index].touroku_pg_id				= dw_list.object.touroku_pg_id[l_row]
i_mdl_syohin.ret[l_index].henkou_date				= dw_list.object.henkou_date[l_row]
i_mdl_syohin.ret[l_index].henkou_user_id			= dw_list.object.henkou_user_id[l_row]
i_mdl_syohin.ret[l_index].henkou_client_id			= dw_list.object.henkou_client_id[l_row]
i_mdl_syohin.ret[l_index].henkou_pg_id				= dw_list.object.henkou_pg_id[l_row]
i_mdl_syohin.ret[l_index].kousin_date				= dw_list.object.kousin_date[l_row]
i_mdl_syohin.ret[l_index].kousin_user_id			= dw_list.object.kousin_user_id[l_row]
i_mdl_syohin.ret[l_index].kousin_client_id			= dw_list.object.kousin_client_id[l_row]
i_mdl_syohin.ret[l_index].kousin_pg_id				= dw_list.object.kousin_pg_id[l_row]
i_mdl_syohin.ret[l_index].haita_flg					= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_syohin )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_syohin	= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_syohin.ret	= i_para_reset
end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// sle_hin_ban
sle_hin_ban.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_hin_ban
st_hin_ban.y		= sle_hin_ban.y + sle_hin_ban.height / 2 - st_hin_ban.height / 2
st_hin_ban.x		= dw_list.x

sle_hin_ban.x		= st_hin_ban.x + st_hin_ban.width + code.MGN_GROUP_YOKO
sle_hin_ban.width	= this.width * 0.2

// st_and
st_and.y			= sle_hin_ban.y + sle_hin_ban.height / 2 - st_and.height / 2

/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_hin_mei
sle_hin_mei.y		= sle_hin_ban.y + sle_hin_ban.height + code.MGN_TATE

// st_hin_mei
st_hin_mei.y		= sle_hin_mei.y + sle_hin_mei.height / 2 - st_hin_mei.height / 2
st_hin_mei.x		= dw_list.x

sle_hin_mei.x		= st_hin_mei.x + st_hin_mei.width + code.MGN_GROUP_YOKO
sle_hin_mei.width	= this.width * 0.5

st_and.x			= sle_hin_mei.x + sle_hin_mei.width + code.MGN_ITEM_YOKO

/*---下の段--------------------------------------------------------------------------------------*/
// sle_jan_code
sle_jan_code.y		= sle_hin_mei.y + sle_hin_mei.height + code.MGN_TATE

// st_jan_code
st_jan_code.y		= sle_jan_code.y + sle_jan_code.height / 2 - st_jan_code.height / 2
st_jan_code.x		= dw_list.x

sle_jan_code.x		= st_jan_code.x + st_jan_code.width + code.MGN_GROUP_YOKO
sle_jan_code.width	= this.width * 0.2

// cbx_bettyu_flg
cbx_bettyu_flg.y	= sle_jan_code.y// + sle_jan_code.height / 2 - cbx_bettyu_flg.height / 2
cbx_bettyu_flg.x	= sle_jan_code.x + sle_jan_code.width + code.MGN_YOKO * 15

// cbx_haiban_kbn
cbx_haiban_kbn.y	= sle_jan_code.y// + sle_jan_code.height / 2 - cbx_haiban_kbn.height / 2
cbx_haiban_kbn.x	= cbx_bettyu_flg.x + cbx_bettyu_flg.width + code.MGN_YOKO

// cbx_syusoku_flg
cbx_syusoku_flg.y	= sle_jan_code.y// + sle_jan_code.height / 2 - cbx_haiban_kbn.height / 2
cbx_syusoku_flg.x	= cbx_haiban_kbn.x + cbx_haiban_kbn.width + code.MGN_YOKO

// cb_retrieve
cb_retrieve.y		= sle_jan_code.y

return 0
end event

event open;call super::open;
sle_hin_ban.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_hin_ban, l_hin_mei, l_jan_code

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 品番
l_hin_ban	= trim( sle_hin_ban.text )

if len( l_hin_ban ) <> 0 then
	i_hin_ban	= l_hin_ban
else
	setnull( i_hin_ban )
end if

// 品名
l_hin_mei	= trim( sle_hin_mei.text )

if len( l_hin_mei ) <> 0 then
	i_hin_mei	= l_hin_mei
else
	setnull( i_hin_mei )
end if

// JANコード
l_jan_code	= trim( sle_jan_code.text )

if len( l_jan_code ) <> 0 then
	i_jan_code	= l_jan_code
else
	setnull( i_jan_code )
end if

if dw_list.retrieve( i_hin_ban, i_hin_mei, i_jan_code ) > 0 then
	dw_list.setfocus()
else
	sle_hin_ban.setfocus()
end if

// DWにフィルタ適用
of_set_filter()

return 0
end event

event retrieve_check;call super::retrieve_check;
string	l_hin_ban
string	l_hin_mei
string	l_jan_code
boolean	l_ret

l_ret	= false

// 品番
l_hin_ban	= trim( sle_hin_ban.text )

if len( l_hin_ban ) <> 0 then
	l_ret	= true
end if

// 品名
l_hin_mei	= trim( sle_hin_mei.text )

if len( l_hin_mei ) <> 0 then
	l_ret	= true
end if

// JANコード
l_jan_code	= trim( sle_jan_code.text )

if len( l_jan_code ) <> 0 then
	l_ret	= true
end if

if not l_ret then	// 入力項目に何も入力がなかったら
	msg.of_error( "値を入力してください。" )
	return -1
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_syohin
end type

type st_date from iw_modal_window`st_date within wsm_syohin
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_syohin
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_syohin
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_syohin
end type

type st_title from iw_modal_window`st_title within wsm_syohin
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_syohin
end type

type st_upper from iw_modal_window`st_upper within wsm_syohin
end type

type st_tail from iw_modal_window`st_tail within wsm_syohin
integer y = 2009
integer width = 2204
end type

type cb_ok from iw_modal_window`cb_ok within wsm_syohin
integer x = 1540
integer y = 2030
integer taborder = 60
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_syohin
integer x = 1888
integer y = 2030
integer taborder = 70
end type

type dw_list from iw_modal_window`dw_list within wsm_syohin
integer x = 32
integer y = 807
integer width = 2260
integer height = 1127
integer taborder = 50
string dataobject = "dsm_syohin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_hin_ban.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_syohin
integer x = 1900
integer y = 555
integer taborder = 40
end type

type cbx_haiban_kbn from ivo_checkbox within wsm_syohin
integer x = 1816
integer y = 409
integer width = 488
string text = "廃番を含む"
end type

event clicked;call super::clicked;
// フィルターをかける
of_set_filter( )
end event

type sle_hin_ban from ivo_singlelineedit within wsm_syohin
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "品番を入力"
end type

type st_hin_ban from ivo_statictext within wsm_syohin
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "品番"
alignment alignment = right!
end type

type st_hin_mei from ivo_statictext within wsm_syohin
integer x = 32
integer y = 284
boolean bringtotop = true
string text = "品名"
alignment alignment = right!
end type

type sle_hin_mei from ivo_singlelineedit within wsm_syohin
integer x = 364
integer y = 281
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "品名を入力"
end type

type cbx_bettyu_flg from ivo_checkbox within wsm_syohin
integer x = 1188
integer y = 423
integer width = 488
string text = "別注を含む"
boolean checked = true
end type

event clicked;call super::clicked;
// フィルターをかける
of_set_filter( )
end event

type st_jan_code from ivo_statictext within wsm_syohin
integer x = 32
integer y = 430
boolean bringtotop = true
string text = "JANコード"
alignment alignment = right!
end type

type sle_jan_code from ivo_singlelineedit within wsm_syohin
integer x = 364
integer y = 427
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "JANコードを入力"
end type

type cbx_syusoku_flg from ivo_checkbox within wsm_syohin
integer x = 2400
integer y = 416
integer width = 528
string text = "終息商品を含む"
end type

event clicked;call super::clicked;
// フィルターをかける
of_set_filter( )
end event

type st_and from ivo_statictext within wsm_syohin
integer x = 1200
integer y = 185
integer width = 544
boolean bringtotop = true
string text = "※各項目をAND検索"
alignment alignment = right!
end type

