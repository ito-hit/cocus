$PBExportHeader$wsm_kihon.srw
$PBExportComments$基本情報検索のモーダル
forward
global type wsm_kihon from iw_modal_window
end type
type st_kaisya_mei from ivo_statictext within wsm_kihon
end type
type sle_kaisya_mei from ivo_singlelineedit within wsm_kihon
end type
end forward

global type wsm_kihon from iw_modal_window
string title = "基本情報検索"
integer dw_height = 1382
integer dw_width = 1593
st_kaisya_mei st_kaisya_mei
sle_kaisya_mei sle_kaisya_mei
end type
global wsm_kihon wsm_kihon

type variables

public:
	str_mdlpara_mkihon	i_mdl_kihon		// 親ウインドウとの受け渡し用構造体

private:
	str_mkihon			i_para_reset[]	// i_mdl_kihon.retの初期化用
	string				i_kaisya_mei	// retrieveに使うパラメータ用
end variables

on wsm_kihon.create
int iCurrent
call super::create
this.st_kaisya_mei=create st_kaisya_mei
this.sle_kaisya_mei=create sle_kaisya_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_kaisya_mei
this.Control[iCurrent+2]=this.sle_kaisya_mei
end on

on wsm_kihon.destroy
call super::destroy
destroy(this.st_kaisya_mei)
destroy(this.sle_kaisya_mei)
end on

event open;call super::open;
sle_kaisya_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_kihon		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_kihon.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_kaisya_mei
sle_kaisya_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_kaisya_mei
st_kaisya_mei.y			= sle_kaisya_mei.y + sle_kaisya_mei.height / 2 - st_kaisya_mei.height / 2
st_kaisya_mei.x			= dw_list.x

sle_kaisya_mei.x		= st_kaisya_mei.x + st_kaisya_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_kaisya_mei.y

sle_kaisya_mei.width	= cb_retrieve.x - sle_kaisya_mei.x - code.MGN_ITEM_YOKO

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_kaisya_mei

l_kaisya_mei	= trim( sle_kaisya_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_kaisya_mei ) <> 0 then
	i_kaisya_mei	= l_kaisya_mei
else
	setnull( i_kaisya_mei )
end if

if dw_list.retrieve( i_kaisya_mei ) > 0 then
	dw_list.setfocus()
else
	sle_kaisya_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_kihon.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_kihon.ret[l_index].kanri_code					= dw_list.object.kanri_code[l_row]
i_mdl_kihon.ret[l_index].kaisya_mei					= dw_list.object.kaisya_mei[l_row]
i_mdl_kihon.ret[l_index].kaisya_mei_ryaku			= dw_list.object.kaisya_mei_ryaku[l_row]
i_mdl_kihon.ret[l_index].yubin_no					= dw_list.object.yubin_no[l_row]
i_mdl_kihon.ret[l_index].jyusyo						= dw_list.object.jyusyo[l_row]
i_mdl_kihon.ret[l_index].tel_no						= dw_list.object.tel_no[l_row]
i_mdl_kihon.ret[l_index].fax_no						= dw_list.object.fax_no[l_row]
i_mdl_kihon.ret[l_index].jigyosya_code				= dw_list.object.jigyosya_code[l_row]
i_mdl_kihon.ret[l_index].houjin_no					= dw_list.object.houjin_no[l_row]
i_mdl_kihon.ret[l_index].syori_date					= dw_list.object.syori_date[l_row]
i_mdl_kihon.ret[l_index].jigyo_nendo				= dw_list.object.jigyo_nendo[l_row]
i_mdl_kihon.ret[l_index].uriage_sime_date			= dw_list.object.uriage_sime_date[l_row]
i_mdl_kihon.ret[l_index].siire_sime_date			= dw_list.object.siire_sime_date[l_row]
i_mdl_kihon.ret[l_index].genka_sime_nengetu			= dw_list.object.genka_sime_nengetu[l_row]
i_mdl_kihon.ret[l_index].sime_jyotai_kbn			= dw_list.object.sime_jyotai_kbn[l_row]
i_mdl_kihon.ret[l_index].tougetu_str_date			= dw_list.object.tougetu_str_date[l_row]
i_mdl_kihon.ret[l_index].tougetu_end_date			= dw_list.object.tougetu_end_date[l_row]
i_mdl_kihon.ret[l_index].yokugetu_str_date			= dw_list.object.yokugetu_str_date[l_row]
i_mdl_kihon.ret[l_index].yokugetu_end_date			= dw_list.object.yokugetu_end_date[l_row]
i_mdl_kihon.ret[l_index].zeiritu_henpin_str_date	= dw_list.object.zeiritu_henpin_str_date[l_row]
i_mdl_kihon.ret[l_index].zeiritu_henpin_end_date	= dw_list.object.zeiritu_henpin_end_date[l_row]
i_mdl_kihon.ret[l_index].zei_hasuu_uriage			= dw_list.object.zei_hasuu_uriage[l_row]
i_mdl_kihon.ret[l_index].zei_hasuu_siire			= dw_list.object.zei_hasuu_siire[l_row]
i_mdl_kihon.ret[l_index].touroku_date				= dw_list.object.touroku_date[l_row]
i_mdl_kihon.ret[l_index].touroku_user_id			= dw_list.object.touroku_user_id[l_row]
i_mdl_kihon.ret[l_index].touroku_client_id			= dw_list.object.touroku_client_id[l_row]
i_mdl_kihon.ret[l_index].touroku_pg_id				= dw_list.object.touroku_pg_id[l_row]
i_mdl_kihon.ret[l_index].henkou_date				= dw_list.object.henkou_date[l_row]
i_mdl_kihon.ret[l_index].henkou_user_id				= dw_list.object.henkou_user_id[l_row]
i_mdl_kihon.ret[l_index].henkou_client_id			= dw_list.object.henkou_client_id[l_row]
i_mdl_kihon.ret[l_index].henkou_pg_id				= dw_list.object.henkou_pg_id[l_row]
i_mdl_kihon.ret[l_index].kousin_date				= dw_list.object.kousin_date[l_row]
i_mdl_kihon.ret[l_index].kousin_user_id				= dw_list.object.kousin_user_id[l_row]
i_mdl_kihon.ret[l_index].kousin_client_id			= dw_list.object.kousin_client_id[l_row]
i_mdl_kihon.ret[l_index].kousin_pg_id				= dw_list.object.kousin_pg_id[l_row]
i_mdl_kihon.ret[l_index].haita_flg					= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_kihon )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_kihon
end type

type st_date from iw_modal_window`st_date within wsm_kihon
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_kihon
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_kihon
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_kihon
end type

type st_title from iw_modal_window`st_title within wsm_kihon
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_kihon
end type

type st_upper from iw_modal_window`st_upper within wsm_kihon
end type

type st_tail from iw_modal_window`st_tail within wsm_kihon
end type

type cb_ok from iw_modal_window`cb_ok within wsm_kihon
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_kihon
end type

type dw_list from iw_modal_window`dw_list within wsm_kihon
integer x = 432
integer y = 327
integer width = 1656
string dataobject = "dsm_kihon"
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_kaisya_mei.setfocus()

return 0
end event

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_kihon
end type

type st_kaisya_mei from ivo_statictext within wsm_kihon
integer x = 56
integer y = 167
boolean bringtotop = true
string text = "会社名"
end type

type sle_kaisya_mei from ivo_singlelineedit within wsm_kihon
integer x = 496
integer y = 192
integer taborder = 20
boolean bringtotop = true
string text = ""
end type

