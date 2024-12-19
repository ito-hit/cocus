$PBExportHeader$wsm_kojyo.srw
$PBExportComments$工場仕入先検索のモーダル
forward
global type wsm_kojyo from iw_modal_window
end type
type st_kojyo_mei from ivo_statictext within wsm_kojyo
end type
type sle_kojyo_mei from ivo_singlelineedit within wsm_kojyo
end type
end forward

global type wsm_kojyo from iw_modal_window
string title = "工場仕入先検索"
integer dw_height = 1445
integer dw_width = 2161
st_kojyo_mei st_kojyo_mei
sle_kojyo_mei sle_kojyo_mei
end type
global wsm_kojyo wsm_kojyo

type variables

public:
	str_mdlpara_mkojyo	i_mdl_kojyo		// 親ウインドウとの受け渡し用構造体

private:
	str_mkojyo			i_para_reset[]	// i_mdl_kojyo.retの初期化用
	string				i_kojyo_mei		// retrieveに使うパラメータ用

end variables
on wsm_kojyo.create
int iCurrent
call super::create
this.st_kojyo_mei=create st_kojyo_mei
this.sle_kojyo_mei=create sle_kojyo_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_kojyo_mei
this.Control[iCurrent+2]=this.sle_kojyo_mei
end on

on wsm_kojyo.destroy
call super::destroy
destroy(this.st_kojyo_mei)
destroy(this.sle_kojyo_mei)
end on

event open;call super::open;
of_set_firstfocus( )

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_kojyo		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_kojyo.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_kojyo_mei
sle_kojyo_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_kojyo_mei
st_kojyo_mei.y		= sle_kojyo_mei.y + sle_kojyo_mei.height / 2 - st_kojyo_mei.height / 2
st_kojyo_mei.x		= dw_list.x

sle_kojyo_mei.x		= st_kojyo_mei.x + st_kojyo_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_kojyo_mei.y

sle_kojyo_mei.width	= cb_retrieve.x - sle_kojyo_mei.x - code.MGN_ITEM_YOKO * 5

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_kojyo_mei

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 工場名
l_kojyo_mei	= trim( sle_kojyo_mei.text )

if len( l_kojyo_mei ) <> 0 then
	i_kojyo_mei	= l_kojyo_mei
else	
	setnull( i_kojyo_mei )
end if

if dw_list.retrieve( i_kojyo_mei ) > 0 then
	dw_list.setfocus()
else
	sle_kojyo_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_kojyo.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_kojyo.ret[l_index].kojyo_code						= dw_list.object.kojyo_code[l_row]
i_mdl_kojyo.ret[l_index].bumon_code						= dw_list.object.bumon_code[l_row]
i_mdl_kojyo.ret[l_index].aiueo_code						= dw_list.object.aiueo_code[l_row]
i_mdl_kojyo.ret[l_index].kojyo_mei						= dw_list.object.kojyo_mei[l_row]
i_mdl_kojyo.ret[l_index].kojyo_mei_ryaku				= dw_list.object.kojyo_mei_ryaku[l_row]
i_mdl_kojyo.ret[l_index].kojyo_kbn						= dw_list.object.kojyo_kbn[l_row]
i_mdl_kojyo.ret[l_index].yubin_bango					= dw_list.object.yubin_bango[l_row]
i_mdl_kojyo.ret[l_index].jyusyo_1						= dw_list.object.jyusyo_1[l_row]
i_mdl_kojyo.ret[l_index].jyusyo_2						= dw_list.object.jyusyo_2[l_row]
i_mdl_kojyo.ret[l_index].denwa_bango					= dw_list.object.denwa_bango[l_row]
i_mdl_kojyo.ret[l_index].fax_no							= dw_list.object.fax_no[l_row]
i_mdl_kojyo.ret[l_index].atena							= dw_list.object.atena[l_row]
i_mdl_kojyo.ret[l_index].group_code						= dw_list.object.group_code[l_row]
i_mdl_kojyo.ret[l_index].tuka_code						= dw_list.object.tuka_code[l_row]
i_mdl_kojyo.ret[l_index].sime_hi						= dw_list.object.sime_hi[l_row]
i_mdl_kojyo.ret[l_index].siharai_hi						= dw_list.object.siharai_hi[l_row]
i_mdl_kojyo.ret[l_index].siharai_meisai_flg				= dw_list.object.siharai_meisai_flg[l_row]
i_mdl_kojyo.ret[l_index].siharai_saki_kojyo_code		= dw_list.object.siharai_saki_kojyo_code[l_row]
i_mdl_kojyo.ret[l_index].siharai_houhou					= dw_list.object.siharai_houhou[l_row]
i_mdl_kojyo.ret[l_index].siharai_tuki					= dw_list.object.siharai_tuki[l_row]
i_mdl_kojyo.ret[l_index].syohizei_keisan_kbn			= dw_list.object.syohizei_keisan_kbn[l_row]
i_mdl_kojyo.ret[l_index].syohizei_marume_kbn			= dw_list.object.syohizei_marume_kbn[l_row]
i_mdl_kojyo.ret[l_index].nuiito_tanka					= dw_list.object.nuiito_tanka[l_row]
i_mdl_kojyo.ret[l_index].keiyaku_bubiki_ritu			= dw_list.object.keiyaku_bubiki_ritu[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_kingaku_zen		= dw_list.object.sime_siharai_kingaku_zen[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_kingaku_2tuki		= dw_list.object.sime_siharai_kingaku_2tuki[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_kingaku_3tuki		= dw_list.object.sime_siharai_kingaku_3tuki[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_zan_kingaku_zen	= dw_list.object.sime_siharai_zan_kingaku_zen[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_zan_kingaku_2tuki	= dw_list.object.sime_siharai_zan_kingaku_2tuki[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_zan_kingaku_3tuki	= dw_list.object.sime_siharai_zan_kingaku_3tuki[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_tan_su				= dw_list.object.sime_siire_tan_su[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_su					= dw_list.object.sime_siire_su[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_henpin_tan_su		= dw_list.object.sime_siire_henpin_tan_su[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_henpin_su			= dw_list.object.sime_siire_henpin_su[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_kingaku				= dw_list.object.sime_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_henpin_kingaku		= dw_list.object.sime_siire_henpin_kingaku[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_nebiki_kingaku		= dw_list.object.sime_siire_nebiki_kingaku[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_ta_siire_kingaku	= dw_list.object.sime_siire_ta_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_syohizei			= dw_list.object.sime_siire_syohizei[l_row]
i_mdl_kojyo.ret[l_index].sime_siire_horyu_kingaku		= dw_list.object.sime_siire_horyu_kingaku[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_genkin			= dw_list.object.sime_siharai_genkin[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_kogitte			= dw_list.object.sime_siharai_kogitte[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_tegata			= dw_list.object.sime_siharai_tegata[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_furikomi			= dw_list.object.sime_siharai_furikomi[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_sousai			= dw_list.object.sime_siharai_sousai[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_waribiki			= dw_list.object.sime_siharai_waribiki[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_kawase_sai		= dw_list.object.sime_siharai_kawase_sai[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_ta				= dw_list.object.sime_siharai_ta[l_row]
i_mdl_kojyo.ret[l_index].sime_siharai_tyosei			= dw_list.object.sime_siharai_tyosei[l_row]
i_mdl_kojyo.ret[l_index].zen_getu_kaikake_zan			= dw_list.object.zen_getu_kaikake_zan[l_row]
i_mdl_kojyo.ret[l_index].zen_getu_kaikake_zan_2tuki		= dw_list.object.zen_getu_kaikake_zan_2tuki[l_row]
i_mdl_kojyo.ret[l_index].zen_getu_kaikake_zan_3tuki		= dw_list.object.zen_getu_kaikake_zan_3tuki[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_tan_su			= dw_list.object.tukikei_siire_tan_su[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_su				= dw_list.object.tukikei_siire_su[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_henpin_tan_su	= dw_list.object.tukikei_siire_henpin_tan_su[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_henpin_su		= dw_list.object.tukikei_siire_henpin_su[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_kingaku			= dw_list.object.tukikei_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_henpin_kingaku	= dw_list.object.tukikei_siire_henpin_kingaku[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_nebiki_kingaku	= dw_list.object.tukikei_siire_nebiki_kingaku[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_ta_siire_kingaku	= dw_list.object.tukikei_siire_ta_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siire_syohizei			= dw_list.object.tukikei_siire_syohizei[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_genkin			= dw_list.object.tukikei_siharai_genkin[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_kogitte		= dw_list.object.tukikei_siharai_kogitte[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_tegata			= dw_list.object.tukikei_siharai_tegata[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_furikomi		= dw_list.object.tukikei_siharai_furikomi[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_sousai			= dw_list.object.tukikei_siharai_sousai[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_waribiki		= dw_list.object.tukikei_siharai_waribiki[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_kawase_sai		= dw_list.object.tukikei_siharai_kawase_sai[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_ta				= dw_list.object.tukikei_siharai_ta[l_row]
i_mdl_kojyo.ret[l_index].tukikei_siharai_tyosei			= dw_list.object.tukikei_siharai_tyosei[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_tan_su			= dw_list.object.nenkei_siire_tan_su[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_su				= dw_list.object.nenkei_siire_su[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_henpin_tan_su		= dw_list.object.nenkei_siire_henpin_tan_su[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_henpin_su			= dw_list.object.nenkei_siire_henpin_su[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_kingaku			= dw_list.object.nenkei_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_henpin_kingaku	= dw_list.object.nenkei_siire_henpin_kingaku[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_nebiki_kingaku	= dw_list.object.nenkei_siire_nebiki_kingaku[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_ta_siire_kingaku	= dw_list.object.nenkei_siire_ta_siire_kingaku[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siire_syohizei			= dw_list.object.nenkei_siire_syohizei[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_genkin			= dw_list.object.nenkei_siharai_genkin[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_kogitte			= dw_list.object.nenkei_siharai_kogitte[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_tegata			= dw_list.object.nenkei_siharai_tegata[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_furikomi		= dw_list.object.nenkei_siharai_furikomi[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_sousai			= dw_list.object.nenkei_siharai_sousai[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_waribiki		= dw_list.object.nenkei_siharai_waribiki[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_kawase_sai		= dw_list.object.nenkei_siharai_kawase_sai[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_ta				= dw_list.object.nenkei_siharai_ta[l_row]
i_mdl_kojyo.ret[l_index].nenkei_siharai_tyosei			= dw_list.object.nenkei_siharai_tyosei[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_4				= dw_list.object.touki_siire_su_4[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_5				= dw_list.object.touki_siire_su_5[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_6				= dw_list.object.touki_siire_su_6[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_7				= dw_list.object.touki_siire_su_7[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_8				= dw_list.object.touki_siire_su_8[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_9				= dw_list.object.touki_siire_su_9[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_10				= dw_list.object.touki_siire_su_10[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_11				= dw_list.object.touki_siire_su_11[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_12				= dw_list.object.touki_siire_su_12[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_1				= dw_list.object.touki_siire_su_1[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_2				= dw_list.object.touki_siire_su_2[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_su_3				= dw_list.object.touki_siire_su_3[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_4			= dw_list.object.touki_siire_kingaku_4[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_5			= dw_list.object.touki_siire_kingaku_5[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_6			= dw_list.object.touki_siire_kingaku_6[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_7			= dw_list.object.touki_siire_kingaku_7[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_8			= dw_list.object.touki_siire_kingaku_8[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_9			= dw_list.object.touki_siire_kingaku_9[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_10			= dw_list.object.touki_siire_kingaku_10[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_11			= dw_list.object.touki_siire_kingaku_11[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_12			= dw_list.object.touki_siire_kingaku_12[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_1			= dw_list.object.touki_siire_kingaku_1[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_2			= dw_list.object.touki_siire_kingaku_2[l_row]
i_mdl_kojyo.ret[l_index].touki_siire_kingaku_3			= dw_list.object.touki_siire_kingaku_3[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_4				= dw_list.object.zenki_siire_su_4[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_5				= dw_list.object.zenki_siire_su_5[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_6				= dw_list.object.zenki_siire_su_6[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_7				= dw_list.object.zenki_siire_su_7[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_8				= dw_list.object.zenki_siire_su_8[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_9				= dw_list.object.zenki_siire_su_9[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_10				= dw_list.object.zenki_siire_su_10[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_11				= dw_list.object.zenki_siire_su_11[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_12				= dw_list.object.zenki_siire_su_12[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_1				= dw_list.object.zenki_siire_su_1[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_2				= dw_list.object.zenki_siire_su_2[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_su_3				= dw_list.object.zenki_siire_su_3[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_4			= dw_list.object.zenki_siire_kingaku_4[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_5			= dw_list.object.zenki_siire_kingaku_5[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_6			= dw_list.object.zenki_siire_kingaku_6[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_7			= dw_list.object.zenki_siire_kingaku_7[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_8			= dw_list.object.zenki_siire_kingaku_8[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_9			= dw_list.object.zenki_siire_kingaku_9[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_10			= dw_list.object.zenki_siire_kingaku_10[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_11			= dw_list.object.zenki_siire_kingaku_11[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_12			= dw_list.object.zenki_siire_kingaku_12[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_1			= dw_list.object.zenki_siire_kingaku_1[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_2			= dw_list.object.zenki_siire_kingaku_2[l_row]
i_mdl_kojyo.ret[l_index].zenki_siire_kingaku_3			= dw_list.object.zenki_siire_kingaku_3[l_row]
i_mdl_kojyo.ret[l_index].daihyo_yaku					= dw_list.object.daihyo_yaku[l_row]
i_mdl_kojyo.ret[l_index].daihyo_mei						= dw_list.object.daihyo_mei[l_row]
i_mdl_kojyo.ret[l_index].torihiki_tanto_busyo			= dw_list.object.torihiki_tanto_busyo[l_row]
i_mdl_kojyo.ret[l_index].torihiki_tanto_yaku			= dw_list.object.torihiki_tanto_yaku[l_row]
i_mdl_kojyo.ret[l_index].torihiki_tanto_mei				= dw_list.object.torihiki_tanto_mei[l_row]
i_mdl_kojyo.ret[l_index].torihiki_mail_address			= dw_list.object.torihiki_mail_address[l_row]
i_mdl_kojyo.ret[l_index].kankei_yaku_1					= dw_list.object.kankei_yaku_1[l_row]
i_mdl_kojyo.ret[l_index].kankei_yaku_2					= dw_list.object.kankei_yaku_2[l_row]
i_mdl_kojyo.ret[l_index].kankei_yaku_3					= dw_list.object.kankei_yaku_3[l_row]
i_mdl_kojyo.ret[l_index].kankei_mei_1					= dw_list.object.kankei_mei_1[l_row]
i_mdl_kojyo.ret[l_index].kankei_mei_2					= dw_list.object.kankei_mei_2[l_row]
i_mdl_kojyo.ret[l_index].kankei_mei_3					= dw_list.object.kankei_mei_3[l_row]
i_mdl_kojyo.ret[l_index].kankei_mail_address_1			= dw_list.object.kankei_mail_address_1[l_row]
i_mdl_kojyo.ret[l_index].kankei_mail_address_2			= dw_list.object.kankei_mail_address_2[l_row]
i_mdl_kojyo.ret[l_index].kankei_mail_address_3			= dw_list.object.kankei_mail_address_3[l_row]
i_mdl_kojyo.ret[l_index].seturitu						= dw_list.object.seturitu[l_row]
i_mdl_kojyo.ret[l_index].sihonkin						= dw_list.object.sihonkin[l_row]
i_mdl_kojyo.ret[l_index].nenga_flg						= dw_list.object.nenga_flg[l_row]
i_mdl_kojyo.ret[l_index].busyo_code						= dw_list.object.busyo_code[l_row]
i_mdl_kojyo.ret[l_index].user_code						= dw_list.object.user_code[l_row]
i_mdl_kojyo.ret[l_index].bikou							= dw_list.object.bikou[l_row]
i_mdl_kojyo.ret[l_index].url							= dw_list.object.url[l_row]
i_mdl_kojyo.ret[l_index].kousin_user_id					= dw_list.object.kousin_user_id[l_row]
i_mdl_kojyo.ret[l_index].kousin_client_id				= dw_list.object.kousin_client_id[l_row]
i_mdl_kojyo.ret[l_index].kousin_pg_id					= dw_list.object.kousin_pg_id[l_row]
i_mdl_kojyo.ret[l_index].touroku_date					= dw_list.object.touroku_date[l_row]
i_mdl_kojyo.ret[l_index].kousin_date					= dw_list.object.kousin_date[l_row]
i_mdl_kojyo.ret[l_index].haita_flg						= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_kojyo )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_kojyo
end type

type st_date from iw_modal_window`st_date within wsm_kojyo
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_kojyo
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_kojyo
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_kojyo
end type

type st_title from iw_modal_window`st_title within wsm_kojyo
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_kojyo
end type

type st_upper from iw_modal_window`st_upper within wsm_kojyo
end type

type st_tail from iw_modal_window`st_tail within wsm_kojyo
end type

type cb_ok from iw_modal_window`cb_ok within wsm_kojyo
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_kojyo
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_kojyo
integer x = 724
integer y = 292
integer taborder = 30
string dataobject = "dsm_kojyo"
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
sle_kojyo_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_kojyo
integer taborder = 20
end type

type st_kojyo_mei from ivo_statictext within wsm_kojyo
integer x = 52
integer y = 167
boolean bringtotop = true
string text = "工場名"
alignment alignment = right!
end type

type sle_kojyo_mei from ivo_singlelineedit within wsm_kojyo
integer x = 400
integer y = 156
integer taborder = 10
boolean bringtotop = true
string placeholder = "工場名を入力してください"
end type

