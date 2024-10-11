$PBExportHeader$wsm_syohin_bunrui.srw
$PBExportComments$商品分類検索のモーダル
forward
global type wsm_syohin_bunrui from iw_modal_window
end type
type sle_bunrui_mei from ivo_singlelineedit within wsm_syohin_bunrui
end type
type st_bunrui_mei from ivo_statictext within wsm_syohin_bunrui
end type
end forward

global type wsm_syohin_bunrui from iw_modal_window
string title = "商品分類検索"
integer dw_height = 1442
integer dw_width = 3500
sle_bunrui_mei sle_bunrui_mei
st_bunrui_mei st_bunrui_mei
end type
global wsm_syohin_bunrui wsm_syohin_bunrui

type variables

public:
	str_mdlpara_mbunrui	i_mdl_bunrui	// 親ウインドウとの受け渡し用構造体

private:
	str_mbunrui			i_para_reset[]	// i_mdl_bunrui.retの初期化用
	long				i_tokui_code	// retrieveに使うパラメータ用
	string				i_bunrui_mei	// retrieveに使うパラメータ用
end variables

on wsm_syohin_bunrui.create
int iCurrent
call super::create
this.sle_bunrui_mei=create sle_bunrui_mei
this.st_bunrui_mei=create st_bunrui_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_bunrui_mei
this.Control[iCurrent+2]=this.st_bunrui_mei
end on

on wsm_syohin_bunrui.destroy
call super::destroy
destroy(this.sle_bunrui_mei)
destroy(this.st_bunrui_mei)
end on

event retrieve_event;call super::retrieve_event;
string l_bunrui_mei

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 分類名
l_bunrui_mei	= trim( sle_bunrui_mei.text )

if len( l_bunrui_mei ) <> 0 then
	i_bunrui_mei	= l_bunrui_mei
else	
	setnull( i_bunrui_mei )
end if

if dw_list.retrieve( i_bunrui_mei ) > 0 then
	dw_list.setfocus()
else
	sle_bunrui_mei.setfocus()
end if

return 0
end event

event open;call super::open;
sle_bunrui_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_bunrui		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_bunrui.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_bunrui_mei
sle_bunrui_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_bunrui_mei
st_bunrui_mei.y			= sle_bunrui_mei.y + sle_bunrui_mei.height / 2 - st_bunrui_mei.height / 2
st_bunrui_mei.x			= dw_list.x

sle_bunrui_mei.x		= st_bunrui_mei.x + st_bunrui_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_bunrui_mei.y

sle_bunrui_mei.width	= cb_retrieve.x - sle_bunrui_mei.x - code.MGN_ITEM_YOKO * 5

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_bunrui.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_bunrui.ret[l_index].daibunrui_code		= dw_list.object.daibunrui_code[l_row]
i_mdl_bunrui.ret[l_index].tyubunrui_code		= dw_list.object.tyubunrui_code[l_row]
i_mdl_bunrui.ret[l_index].syobunrui_code		= dw_list.object.syobunrui_code[l_row]
i_mdl_bunrui.ret[l_index].daibunrui_mei			= dw_list.object.daibunrui_mei[l_row]
i_mdl_bunrui.ret[l_index].tyubunrui_mei			= dw_list.object.tyubunrui_mei[l_row]
i_mdl_bunrui.ret[l_index].syobunrui_mei			= dw_list.object.syobunrui_mei[l_row]
i_mdl_bunrui.ret[l_index].zaiko_kanri_flg		= dw_list.object.zaiko_kanri_flg[l_row]
i_mdl_bunrui.ret[l_index].suryo_keisan_flg		= dw_list.object.suryo_keisan_flg[l_row]
i_mdl_bunrui.ret[l_index].kingaku_keisan_flg	= dw_list.object.kingaku_keisan_flg[l_row]
i_mdl_bunrui.ret[l_index].arari_keisan_flg		= dw_list.object.arari_keisan_flg[l_row]
i_mdl_bunrui.ret[l_index].hako_keisan_flg		= dw_list.object.hako_keisan_flg[l_row]
i_mdl_bunrui.ret[l_index].kenpin_taisyo_flg		= dw_list.object.kenpin_taisyo_flg[l_row]
i_mdl_bunrui.ret[l_index].muryo_kyoka_flg		= dw_list.object.muryo_kyoka_flg[l_row]
i_mdl_bunrui.ret[l_index].bhin_flg				= dw_list.object.bhin_flg[l_row]
i_mdl_bunrui.ret[l_index].group_code			= dw_list.object.group_code[l_row]
i_mdl_bunrui.ret[l_index].brand_code			= dw_list.object.brand_code[l_row]
i_mdl_bunrui.ret[l_index].bikou					= dw_list.object.bikou[l_row]
i_mdl_bunrui.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_bunrui.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_bunrui.ret[l_index].touroku_client_id		= dw_list.object.touroku_client_id[l_row]
i_mdl_bunrui.ret[l_index].touroku_pg_id			= dw_list.object.touroku_pg_id[l_row]
i_mdl_bunrui.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_bunrui.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_bunrui.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_bunrui.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_bunrui.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_bunrui.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_bunrui.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_bunrui.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_bunrui.ret[l_index].haita_flg				= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_bunrui )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_syohin_bunrui
end type

type st_date from iw_modal_window`st_date within wsm_syohin_bunrui
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_syohin_bunrui
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_syohin_bunrui
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_syohin_bunrui
end type

type st_title from iw_modal_window`st_title within wsm_syohin_bunrui
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_syohin_bunrui
end type

type st_upper from iw_modal_window`st_upper within wsm_syohin_bunrui
end type

type st_tail from iw_modal_window`st_tail within wsm_syohin_bunrui
end type

type cb_ok from iw_modal_window`cb_ok within wsm_syohin_bunrui
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_syohin_bunrui
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_syohin_bunrui
integer x = 372
integer y = 295
integer taborder = 30
string dataobject = "dsm_syohin_bunrui"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_bunrui_mei.setfocus()

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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_syohin_bunrui
integer taborder = 20
end type

type sle_bunrui_mei from ivo_singlelineedit within wsm_syohin_bunrui
integer x = 488
integer y = 164
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

type st_bunrui_mei from ivo_statictext within wsm_syohin_bunrui
integer x = 60
integer y = 167
boolean bringtotop = true
string text = "分類名"
alignment alignment = right!
end type

