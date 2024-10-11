﻿$PBExportHeader$wsm_seikyu.srw
$PBExportComments$請求先検索のモーダル
forward
global type wsm_seikyu from iw_modal_window
end type
type uo_tanto from cv_input_tanto within wsm_seikyu
end type
type st_seikyu_mei from ivo_statictext within wsm_seikyu
end type
type sle_seikyu_mei from ivo_singlelineedit within wsm_seikyu
end type
type st_seikyu_mei_kana from ivo_statictext within wsm_seikyu
end type
type sle_seikyu_mei_kana from ivo_singlelineedit within wsm_seikyu
end type
type st_and from ivo_statictext within wsm_seikyu
end type
type cbx_torihiki_teisi_kbn from ivo_checkbox within wsm_seikyu
end type
type cbx_syusoku_flg from ivo_checkbox within wsm_seikyu
end type
end forward

global type wsm_seikyu from iw_modal_window
integer width = 3664
integer height = 1390
string title = "請求先検索"
boolean immediate_retrieve = false
integer dw_height = 1442
integer dw_width = 3500
uo_tanto uo_tanto
st_seikyu_mei st_seikyu_mei
sle_seikyu_mei sle_seikyu_mei
st_seikyu_mei_kana st_seikyu_mei_kana
sle_seikyu_mei_kana sle_seikyu_mei_kana
st_and st_and
cbx_torihiki_teisi_kbn cbx_torihiki_teisi_kbn
cbx_syusoku_flg cbx_syusoku_flg
end type
global wsm_seikyu wsm_seikyu

type variables

public:
	str_mdlpara_mtokui	i_mdl_seikyu	// 親ウインドウとの受け渡し用構造体

private:
	str_mtokui			i_para_reset[]	// i_mdl_seikyu.retの初期化用

	long				i_tanto_code
	string				i_seikyu_mei
	string				i_seikyu_mei_kana
end variables

forward prototypes
public subroutine of_set_filter ()
end prototypes

public subroutine of_set_filter ();
// チェックボックスの状態を確認してフィルターをかける関数

integer	l_row
string	l_filter

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()
		
// 取引停止先 3:完全停止のみを表示対象外とする
if not cbx_torihiki_teisi_kbn.checked then
	l_filter	=  "torihiki_teisi_kbn <> 3"
end if

// 終息得意先
if not cbx_syusoku_flg.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and syusoku_flg <> 1"
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

on wsm_seikyu.create
int iCurrent
call super::create
this.uo_tanto=create uo_tanto
this.st_seikyu_mei=create st_seikyu_mei
this.sle_seikyu_mei=create sle_seikyu_mei
this.st_seikyu_mei_kana=create st_seikyu_mei_kana
this.sle_seikyu_mei_kana=create sle_seikyu_mei_kana
this.st_and=create st_and
this.cbx_torihiki_teisi_kbn=create cbx_torihiki_teisi_kbn
this.cbx_syusoku_flg=create cbx_syusoku_flg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tanto
this.Control[iCurrent+2]=this.st_seikyu_mei
this.Control[iCurrent+3]=this.sle_seikyu_mei
this.Control[iCurrent+4]=this.st_seikyu_mei_kana
this.Control[iCurrent+5]=this.sle_seikyu_mei_kana
this.Control[iCurrent+6]=this.st_and
this.Control[iCurrent+7]=this.cbx_torihiki_teisi_kbn
this.Control[iCurrent+8]=this.cbx_syusoku_flg
end on

on wsm_seikyu.destroy
call super::destroy
destroy(this.uo_tanto)
destroy(this.st_seikyu_mei)
destroy(this.sle_seikyu_mei)
destroy(this.st_seikyu_mei_kana)
destroy(this.sle_seikyu_mei_kana)
destroy(this.st_and)
destroy(this.cbx_torihiki_teisi_kbn)
destroy(this.cbx_syusoku_flg)
end on

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// uo_tanto
uo_tanto.y					= st_upper.y + st_upper.height + code.MGN_TATE
uo_tanto.x					= dw_list.x

/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_seikyu_mei
sle_seikyu_mei.y			= uo_tanto.y + uo_tanto.height + code.MGN_TATE

// st_seikyu_mei
st_seikyu_mei.y				= sle_seikyu_mei.y + sle_seikyu_mei.height / 2 - st_seikyu_mei.height / 2
st_seikyu_mei.x				= dw_list.x

sle_seikyu_mei.x			= st_seikyu_mei.x + st_seikyu_mei.width + code.MGN_GROUP_YOKO

// st_and
st_and.y					= sle_seikyu_mei.y + sle_seikyu_mei.height / 2 - st_and.height / 2

// cbx_torihiki_teisi_kbn
cbx_torihiki_teisi_kbn.y	= sle_seikyu_mei.y + sle_seikyu_mei.height / 2 - cbx_torihiki_teisi_kbn.height / 2
cbx_torihiki_teisi_kbn.x	= cb_retrieve.x - cbx_torihiki_teisi_kbn.width - code.MGN_ITEM_YOKO

st_and.x					= cbx_torihiki_teisi_kbn.x - st_and.width - code.MGN_ITEM_YOKO
sle_seikyu_mei.width		= st_and.x - sle_seikyu_mei.x - code.MGN_ITEM_YOKO

/*---下の段--------------------------------------------------------------------------------------*/
// sle_seikyu_mei_kana
sle_seikyu_mei_kana.y		= sle_seikyu_mei.y + sle_seikyu_mei.height + code.MGN_TATE

// st_seikyu_mei_kana
st_seikyu_mei_kana.y		= sle_seikyu_mei_kana.y + sle_seikyu_mei_kana.height / 2 - st_seikyu_mei_kana.height / 2
st_seikyu_mei_kana.x		= dw_list.x

sle_seikyu_mei_kana.x		= st_seikyu_mei_kana.x + st_seikyu_mei_kana.width + code.MGN_GROUP_YOKO

// cbx_syusoku_flg
cbx_syusoku_flg.y			= sle_seikyu_mei_kana.y + sle_seikyu_mei_kana.height / 2 - st_seikyu_mei_kana.height / 2
cbx_syusoku_flg.x			= cb_retrieve.x - cbx_syusoku_flg.width - code.MGN_ITEM_YOKO

sle_seikyu_mei_kana.width	= sle_seikyu_mei.width	// 請求先名の横幅に合わせる

// cb_retrieve
cb_retrieve.y				= sle_seikyu_mei_kana.y

return 0
end event

event retrieve_check;call super::retrieve_check;
long	l_tanto_code
string	l_seikyu_mei, l_seikyu_mei_kana
boolean	l_ret

l_ret	= false

// 担当者コード
l_tanto_code	= uo_tanto.of_get_tanto_code()

if l_tanto_code <> -1 then
	l_ret	= true
end if

// 請求先名
l_seikyu_mei	= trim( sle_seikyu_mei.text )

if len( l_seikyu_mei ) <> 0 then
	l_ret	= true
end if

// カナ名
l_seikyu_mei_kana	= trim( sle_seikyu_mei_kana.text )

if len( l_seikyu_mei_kana ) <> 0 then
	l_ret	= true
end if

if not l_ret then	// 入力項目に何も入力がなかったら
	msg.of_error( "値を入力してください。" )
	return -1
end if

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_seikyu_mei, l_seikyu_mei_kana

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 担当者コードは必須ではない
i_tanto_code	= uo_tanto.of_get_tanto_code()

if i_tanto_code = -1 then
	setnull( i_tanto_code )	// 値が取得できなければnull
end if

// 請求先名
l_seikyu_mei	= trim( sle_seikyu_mei.text )

if len( l_seikyu_mei ) <> 0 then
	i_seikyu_mei	= l_seikyu_mei
else
	setnull( i_seikyu_mei )
end if

// カナ名
l_seikyu_mei_kana	= trim( sle_seikyu_mei_kana.text )

if len( l_seikyu_mei_kana ) <> 0 then
	i_seikyu_mei_kana	= l_seikyu_mei_kana
else
	setnull( i_seikyu_mei_kana )
end if

if dw_list.retrieve( i_tanto_code, i_seikyu_mei, i_seikyu_mei_kana ) > 0 then
	dw_list.setfocus()
else
	uo_tanto.setfocus()
end if

// DWにフィルタ適用
cbx_torihiki_teisi_kbn.event clicked( )
cbx_syusoku_flg.event clicked( )

return 0
end event

event open;call super::open;
uo_tanto.sle_input.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_seikyu		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_seikyu.ret	= i_para_reset

// DWにフィルタ適用 immediate_retrieveがfalseなので不要
//cbx_torihiki_teisi_kbn.event clicked( )
//cbx_syusoku_flg.event clicked( )

// inパラメータがあるかチェック
if i_mdl_seikyu.in_tanto_code <> 0 and not isnull( i_mdl_seikyu.in_tanto_code ) then
	uo_tanto.of_set_input( string( i_mdl_seikyu.in_tanto_code ) )	// 担当コードをsleにセット
	uo_tanto.event sle_input_check()								// sleに入った値をチェックする
end if
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_seikyu.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_seikyu.ret[l_index].tokui_code					= dw_list.object.tokui_code[l_row]
i_mdl_seikyu.ret[l_index].tokui_mei_full				= dw_list.object.tokui_mei_full[l_row]
i_mdl_seikyu.ret[l_index].tokui_mei						= dw_list.object.tokui_mei[l_row]
i_mdl_seikyu.ret[l_index].tokui_mei_syagai				= dw_list.object.tokui_mei_syagai[l_row]
i_mdl_seikyu.ret[l_index].tokui_mei_ryaku				= dw_list.object.tokui_mei_ryaku[l_row]
i_mdl_seikyu.ret[l_index].tokui_mei_kana				= dw_list.object.tokui_mei_kana[l_row]
i_mdl_seikyu.ret[l_index].tokui_kbn						= dw_list.object.tokui_kbn[l_row]
i_mdl_seikyu.ret[l_index].gyotai_kbn					= dw_list.object.gyotai_kbn[l_row]
i_mdl_seikyu.ret[l_index].syokuti_flg					= dw_list.object.syokuti_flg[l_row]
i_mdl_seikyu.ret[l_index].torihiki_code					= dw_list.object.torihiki_code[l_row]
i_mdl_seikyu.ret[l_index].jigyosya_code					= dw_list.object.jigyosya_code[l_row]
i_mdl_seikyu.ret[l_index].houjin_no						= dw_list.object.houjin_no[l_row]
i_mdl_seikyu.ret[l_index].bumon_code					= dw_list.object.bumon_code[l_row]
i_mdl_seikyu.ret[l_index].tanto_code					= dw_list.object.tanto_code[l_row]
i_mdl_seikyu.ret[l_index].tanto_code_new				= dw_list.object.tanto_code_new[l_row]
i_mdl_seikyu.ret[l_index].nayose_code					= dw_list.object.nayose_code[l_row]
i_mdl_seikyu.ret[l_index].nayose_eda					= dw_list.object.nayose_eda[l_row]
i_mdl_seikyu.ret[l_index].seikyu_code					= dw_list.object.seikyu_code[l_row]
i_mdl_seikyu.ret[l_index].seikyu_eda					= dw_list.object.seikyu_eda[l_row]
i_mdl_seikyu.ret[l_index].torihiki_jyoken_kbn			= dw_list.object.torihiki_jyoken_kbn[l_row]
i_mdl_seikyu.ret[l_index].yosin_gendo_gaku				= dw_list.object.yosin_gendo_gaku[l_row]
i_mdl_seikyu.ret[l_index].syohizei_kbn					= dw_list.object.syohizei_kbn[l_row]
i_mdl_seikyu.ret[l_index].zei_hasu_kbn					= dw_list.object.zei_hasu_kbn[l_row]
i_mdl_seikyu.ret[l_index].untin_kbn_fax					= dw_list.object.untin_kbn_fax[l_row]
i_mdl_seikyu.ret[l_index].untin_kbn_net					= dw_list.object.untin_kbn_net[l_row]
i_mdl_seikyu.ret[l_index].untin_kbn_edi					= dw_list.object.untin_kbn_edi[l_row]
i_mdl_seikyu.ret[l_index].untin_kbn						= dw_list.object.untin_kbn[l_row]
i_mdl_seikyu.ret[l_index].torihiki_teisi_kbn			= dw_list.object.torihiki_teisi_kbn[l_row]
i_mdl_seikyu.ret[l_index].torihiki_teisi_riyu			= dw_list.object.torihiki_teisi_riyu[l_row]
i_mdl_seikyu.ret[l_index].syusoku_flg					= dw_list.object.syusoku_flg[l_row]
i_mdl_seikyu.ret[l_index].kesikomi_flg					= dw_list.object.kesikomi_flg[l_row]
i_mdl_seikyu.ret[l_index].kaisyu_flg					= dw_list.object.kaisyu_flg[l_row]
i_mdl_seikyu.ret[l_index].kaisyu_keikoku_flg			= dw_list.object.kaisyu_keikoku_flg[l_row]
i_mdl_seikyu.ret[l_index].nohinsyo_kbn					= dw_list.object.nohinsyo_kbn[l_row]
i_mdl_seikyu.ret[l_index].nohinsyo_hakkou_kbn			= dw_list.object.nohinsyo_hakkou_kbn[l_row]
i_mdl_seikyu.ret[l_index].nohinsyo_kingaku_kbn			= dw_list.object.nohinsyo_kingaku_kbn[l_row]
i_mdl_seikyu.ret[l_index].nohinsyo_kousou_kbn			= dw_list.object.nohinsyo_kousou_kbn[l_row]
i_mdl_seikyu.ret[l_index].nohinsyo_kousou_jyun			= dw_list.object.nohinsyo_kousou_jyun[l_row]
i_mdl_seikyu.ret[l_index].seikyusyo_kbn					= dw_list.object.seikyusyo_kbn[l_row]
i_mdl_seikyu.ret[l_index].seikyu_meisai_kbn				= dw_list.object.seikyu_meisai_kbn[l_row]
i_mdl_seikyu.ret[l_index].seikyu_tanni_kbn				= dw_list.object.seikyu_tanni_kbn[l_row]
i_mdl_seikyu.ret[l_index].seikyu_denpyo_no_hyoji_kbn	= dw_list.object.seikyu_denpyo_no_hyoji_kbn[l_row]
i_mdl_seikyu.ret[l_index].seikyu_cd_hyoji_flg			= dw_list.object.seikyu_cd_hyoji_flg[l_row]
i_mdl_seikyu.ret[l_index].siharai_kijitu_hyoji_flg		= dw_list.object.siharai_kijitu_hyoji_flg[l_row]
i_mdl_seikyu.ret[l_index].jikai_siharai_hyoji_flg		= dw_list.object.jikai_siharai_hyoji_flg[l_row]
i_mdl_seikyu.ret[l_index].seikyu_data_kbn				= dw_list.object.seikyu_data_kbn[l_row]
i_mdl_seikyu.ret[l_index].kijyun_kingaku				= dw_list.object.kijyun_kingaku[l_row]
i_mdl_seikyu.ret[l_index].simebi_1						= dw_list.object.simebi_1[l_row]
i_mdl_seikyu.ret[l_index].nyukin_tuki_1					= dw_list.object.nyukin_tuki_1[l_row]
i_mdl_seikyu.ret[l_index].nyukin_date_1					= dw_list.object.nyukin_date_1[l_row]
i_mdl_seikyu.ret[l_index].nyukin_houhou_1				= dw_list.object.nyukin_houhou_1[l_row]
i_mdl_seikyu.ret[l_index].tegata_site_1					= dw_list.object.tegata_site_1[l_row]
i_mdl_seikyu.ret[l_index].nyukin_tuki_1m				= dw_list.object.nyukin_tuki_1m[l_row]
i_mdl_seikyu.ret[l_index].nyukin_date_1m				= dw_list.object.nyukin_date_1m[l_row]
i_mdl_seikyu.ret[l_index].nyukin_houhou_1m				= dw_list.object.nyukin_houhou_1m[l_row]
i_mdl_seikyu.ret[l_index].tegata_site_1m				= dw_list.object.tegata_site_1m[l_row]
i_mdl_seikyu.ret[l_index].simebi_2						= dw_list.object.simebi_2[l_row]
i_mdl_seikyu.ret[l_index].nyukin_tuki_2					= dw_list.object.nyukin_tuki_2[l_row]
i_mdl_seikyu.ret[l_index].nyukin_date_2					= dw_list.object.nyukin_date_2[l_row]
i_mdl_seikyu.ret[l_index].nyukin_houhou_2				= dw_list.object.nyukin_houhou_2[l_row]
i_mdl_seikyu.ret[l_index].tegata_site_2					= dw_list.object.tegata_site_2[l_row]
i_mdl_seikyu.ret[l_index].nyukin_tuki_2m				= dw_list.object.nyukin_tuki_2m[l_row]
i_mdl_seikyu.ret[l_index].nyukin_date_2m				= dw_list.object.nyukin_date_2m[l_row]
i_mdl_seikyu.ret[l_index].nyukin_houhou_2m				= dw_list.object.nyukin_houhou_2m[l_row]
i_mdl_seikyu.ret[l_index].tegata_site_2m				= dw_list.object.tegata_site_2m[l_row]
i_mdl_seikyu.ret[l_index].tanka_touroku_flg				= dw_list.object.tanka_touroku_flg[l_row]
i_mdl_seikyu.ret[l_index].unso_code						= dw_list.object.unso_code[l_row]
i_mdl_seikyu.ret[l_index].leadtime_flg					= dw_list.object.leadtime_flg[l_row]
i_mdl_seikyu.ret[l_index].saiken_doukou_flg				= dw_list.object.saiken_doukou_flg[l_row]
i_mdl_seikyu.ret[l_index].jyuten_kbn					= dw_list.object.jyuten_kbn[l_row]
i_mdl_seikyu.ret[l_index].reserve_hikiate_code			= dw_list.object.reserve_hikiate_code[l_row]
i_mdl_seikyu.ret[l_index].rank							= dw_list.object.rank[l_row]
i_mdl_seikyu.ret[l_index].syukka_yusen_jyun				= dw_list.object.syukka_yusen_jyun[l_row]
i_mdl_seikyu.ret[l_index].syukka_siji_kingaku			= dw_list.object.syukka_siji_kingaku[l_row]
i_mdl_seikyu.ret[l_index].todofuken_code				= dw_list.object.todofuken_code[l_row]
i_mdl_seikyu.ret[l_index].sikutyoson_code				= dw_list.object.sikutyoson_code[l_row]
i_mdl_seikyu.ret[l_index].yubin_no						= dw_list.object.yubin_no[l_row]
i_mdl_seikyu.ret[l_index].jyusyo						= dw_list.object.jyusyo[l_row]
i_mdl_seikyu.ret[l_index].tel_no						= dw_list.object.tel_no[l_row]
i_mdl_seikyu.ret[l_index].fax_no						= dw_list.object.fax_no[l_row]
i_mdl_seikyu.ret[l_index].url							= dw_list.object.url[l_row]
i_mdl_seikyu.ret[l_index].daihyo_yakusyoku				= dw_list.object.daihyo_yakusyoku[l_row]
i_mdl_seikyu.ret[l_index].daihyo_simei					= dw_list.object.daihyo_simei[l_row]
i_mdl_seikyu.ret[l_index].sogyo_kbn						= dw_list.object.sogyo_kbn[l_row]
i_mdl_seikyu.ret[l_index].sogyo_nen						= dw_list.object.sogyo_nen[l_row]
i_mdl_seikyu.ret[l_index].sogyo_tuki					= dw_list.object.sogyo_tuki[l_row]
i_mdl_seikyu.ret[l_index].kessan_tuki					= dw_list.object.kessan_tuki[l_row]
i_mdl_seikyu.ret[l_index].gyosyu						= dw_list.object.gyosyu[l_row]
i_mdl_seikyu.ret[l_index].sihonkin						= dw_list.object.sihonkin[l_row]
i_mdl_seikyu.ret[l_index].jyugyoin_su					= dw_list.object.jyugyoin_su[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_1				= dw_list.object.torihiki_ginkou_1[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_siten_1		= dw_list.object.torihiki_ginkou_siten_1[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_2				= dw_list.object.torihiki_ginkou_2[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_siten_2		= dw_list.object.torihiki_ginkou_siten_2[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_3				= dw_list.object.torihiki_ginkou_3[l_row]
i_mdl_seikyu.ret[l_index].torihiki_ginkou_siten_3		= dw_list.object.torihiki_ginkou_siten_3[l_row]
i_mdl_seikyu.ret[l_index].siten_su						= dw_list.object.siten_su[l_row]
i_mdl_seikyu.ret[l_index].kojyo_su						= dw_list.object.kojyo_su[l_row]
i_mdl_seikyu.ret[l_index].hanbai_saki					= dw_list.object.hanbai_saki[l_row]
i_mdl_seikyu.ret[l_index].siire_saki					= dw_list.object.siire_saki[l_row]
i_mdl_seikyu.ret[l_index].jigyo_naiyo					= dw_list.object.jigyo_naiyo[l_row]
i_mdl_seikyu.ret[l_index].gyokai_tii					= dw_list.object.gyokai_tii[l_row]
i_mdl_seikyu.ret[l_index].torihiki_keii					= dw_list.object.torihiki_keii[l_row]
i_mdl_seikyu.ret[l_index].torihiki_keii_bikou			= dw_list.object.torihiki_keii_bikou[l_row]
i_mdl_seikyu.ret[l_index].baibai_keiyaku_flg			= dw_list.object.baibai_keiyaku_flg[l_row]
i_mdl_seikyu.ret[l_index].hosyonin_umu					= dw_list.object.hosyonin_umu[l_row]
i_mdl_seikyu.ret[l_index].hosyonin_mei					= dw_list.object.hosyonin_mei[l_row]
i_mdl_seikyu.ret[l_index].hosyonin_kankei				= dw_list.object.hosyonin_kankei[l_row]
i_mdl_seikyu.ret[l_index].hosyokin						= dw_list.object.hosyokin[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_1						= dw_list.object.ryoritu_1[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_tani_1				= dw_list.object.ryoritu_tani_1[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_2						= dw_list.object.ryoritu_2[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_tani_2				= dw_list.object.ryoritu_tani_2[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_3						= dw_list.object.ryoritu_3[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_tani_3				= dw_list.object.ryoritu_tani_3[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_4						= dw_list.object.ryoritu_4[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_tani_4				= dw_list.object.ryoritu_tani_4[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_5						= dw_list.object.ryoritu_5[l_row]
i_mdl_seikyu.ret[l_index].ryoritu_tani_5				= dw_list.object.ryoritu_tani_5[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_1						= dw_list.object.tesuryo_1[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_tani_1				= dw_list.object.tesuryo_tani_1[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_2						= dw_list.object.tesuryo_2[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_tani_2				= dw_list.object.tesuryo_tani_2[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_3						= dw_list.object.tesuryo_3[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_tani_3				= dw_list.object.tesuryo_tani_3[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_4						= dw_list.object.tesuryo_4[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_tani_4				= dw_list.object.tesuryo_tani_4[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_5						= dw_list.object.tesuryo_5[l_row]
i_mdl_seikyu.ret[l_index].tesuryo_tani_5				= dw_list.object.tesuryo_tani_5[l_row]
i_mdl_seikyu.ret[l_index].memo							= dw_list.object.memo[l_row]
i_mdl_seikyu.ret[l_index].touroku_date					= dw_list.object.touroku_date[l_row]
i_mdl_seikyu.ret[l_index].touroku_user_id				= dw_list.object.touroku_user_id[l_row]
i_mdl_seikyu.ret[l_index].touroku_client_id				= dw_list.object.touroku_client_id[l_row]
i_mdl_seikyu.ret[l_index].touroku_pg_id					= dw_list.object.touroku_pg_id[l_row]
i_mdl_seikyu.ret[l_index].henkou_date					= dw_list.object.henkou_date[l_row]
i_mdl_seikyu.ret[l_index].henkou_user_id				= dw_list.object.henkou_user_id[l_row]
i_mdl_seikyu.ret[l_index].henkou_client_id				= dw_list.object.henkou_client_id[l_row]
i_mdl_seikyu.ret[l_index].henkou_pg_id					= dw_list.object.henkou_pg_id[l_row]
i_mdl_seikyu.ret[l_index].kousin_date					= dw_list.object.kousin_date[l_row]
i_mdl_seikyu.ret[l_index].kousin_user_id				= dw_list.object.kousin_user_id[l_row]
i_mdl_seikyu.ret[l_index].kousin_client_id				= dw_list.object.kousin_client_id[l_row]
i_mdl_seikyu.ret[l_index].kousin_pg_id					= dw_list.object.kousin_pg_id[l_row]
i_mdl_seikyu.ret[l_index].haita_flg						= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_seikyu )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_seikyu
end type

type st_date from iw_modal_window`st_date within wsm_seikyu
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_seikyu
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_seikyu
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_seikyu
end type

type st_title from iw_modal_window`st_title within wsm_seikyu
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_seikyu
end type

type st_upper from iw_modal_window`st_upper within wsm_seikyu
end type

type st_tail from iw_modal_window`st_tail within wsm_seikyu
integer y = 1138
end type

type cb_ok from iw_modal_window`cb_ok within wsm_seikyu
integer y = 1159
integer taborder = 60
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_seikyu
integer y = 1159
integer taborder = 70
end type

type dw_list from iw_modal_window`dw_list within wsm_seikyu
integer x = 304
integer y = 729
integer taborder = 50
string dataobject = "dsm_seikyu"
boolean hscrollbar = true
boolean vscrollbar = true
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
uo_tanto.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_seikyu
integer x = 2596
integer y = 427
integer taborder = 40
end type

type uo_tanto from cv_input_tanto within wsm_seikyu
integer x = 8
integer y = 174
integer width = 1804
integer taborder = 10
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

type st_seikyu_mei from ivo_statictext within wsm_seikyu
integer x = 16
integer y = 292
boolean bringtotop = true
string text = "請求先名"
alignment alignment = right!
end type

type sle_seikyu_mei from ivo_singlelineedit within wsm_seikyu
integer x = 348
integer y = 288
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "得意先名を入力してください"
end type

type st_seikyu_mei_kana from ivo_statictext within wsm_seikyu
integer x = 16
integer y = 416
boolean bringtotop = true
string text = "カナ名"
alignment alignment = right!
end type

type sle_seikyu_mei_kana from ivo_singlelineedit within wsm_seikyu
integer x = 348
integer y = 412
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "カナ名を入力してください"
end type

type st_and from ivo_statictext within wsm_seikyu
integer x = 1244
integer y = 292
integer width = 320
boolean bringtotop = true
string text = "※AND検索"
alignment alignment = right!
end type

type cbx_torihiki_teisi_kbn from ivo_checkbox within wsm_seikyu
integer x = 1844
integer y = 288
integer width = 728
string text = "取引停止先を含む"
end type

event clicked;call super::clicked;
// フィルターをかける
of_set_filter()
end event

type cbx_syusoku_flg from ivo_checkbox within wsm_seikyu
integer x = 1844
integer y = 398
integer width = 728
string text = "終息得意先を含む"
end type

event clicked;call super::clicked;
// フィルターをかける
of_set_filter()
end event
