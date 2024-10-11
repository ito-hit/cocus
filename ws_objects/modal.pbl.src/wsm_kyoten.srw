$PBExportHeader$wsm_kyoten.srw
$PBExportComments$拠点検索のモーダル
forward
global type wsm_kyoten from iw_modal_window
end type
type st_kyoten_mei from ivo_statictext within wsm_kyoten
end type
type sle_kyoten_mei from ivo_singlelineedit within wsm_kyoten
end type
end forward

global type wsm_kyoten from iw_modal_window
string title = "拠点検索"
integer dw_height = 1382
integer dw_width = 1825
st_kyoten_mei st_kyoten_mei
sle_kyoten_mei sle_kyoten_mei
end type
global wsm_kyoten wsm_kyoten

type variables

public:
	str_mdlpara_mkyoten	i_mdl_kyoten	// 親ウインドウとの受け渡し用構造体

private:
	str_mkyoten			i_para_reset[]	// i_mdl_kyoten.retの初期化用
	string				i_kyoten_mei	// retrieveに使うパラメータ用
end variables

on wsm_kyoten.create
int iCurrent
call super::create
this.st_kyoten_mei=create st_kyoten_mei
this.sle_kyoten_mei=create sle_kyoten_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_kyoten_mei
this.Control[iCurrent+2]=this.sle_kyoten_mei
end on

on wsm_kyoten.destroy
call super::destroy
destroy(this.st_kyoten_mei)
destroy(this.sle_kyoten_mei)
end on

event resize;call super::resize;
// sle_kyoten_mei
sle_kyoten_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_kyoten_mei
st_kyoten_mei.y			= sle_kyoten_mei.y + sle_kyoten_mei.height / 2 - st_kyoten_mei.height / 2
st_kyoten_mei.x			= dw_list.x

sle_kyoten_mei.x		= st_kyoten_mei.x + st_kyoten_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_kyoten_mei.y

sle_kyoten_mei.width	= cb_retrieve.x - sle_kyoten_mei.x - code.MGN_ITEM_YOKO

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_kyoten		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_kyoten.ret	= i_para_reset
end event

event open;call super::open;
sle_kyoten_mei.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_kyoten_mei

l_kyoten_mei	= trim( sle_kyoten_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_kyoten_mei ) <> 0 then
	i_kyoten_mei	= l_kyoten_mei
else
	setnull( i_kyoten_mei )
end if

if dw_list.retrieve( i_kyoten_mei ) > 0 then
	dw_list.setfocus()
else
	sle_kyoten_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_kyoten.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_kyoten.ret[l_index].kyoten_code			= dw_list.object.kyoten_code[l_row]
i_mdl_kyoten.ret[l_index].kyoten_mei			= dw_list.object.kyoten_mei[l_row]
i_mdl_kyoten.ret[l_index].kyoten_mei_ryaku		= dw_list.object.kyoten_mei_ryaku[l_row]
i_mdl_kyoten.ret[l_index].kyoten_kbn			= dw_list.object.kyoten_kbn[l_row]
i_mdl_kyoten.ret[l_index].kensaku_seq			= dw_list.object.kensaku_seq[l_row]
i_mdl_kyoten.ret[l_index].yubin_no				= dw_list.object.yubin_no[l_row]
i_mdl_kyoten.ret[l_index].jyusyo				= dw_list.object.jyusyo[l_row]
i_mdl_kyoten.ret[l_index].tel_no				= dw_list.object.tel_no[l_row]
i_mdl_kyoten.ret[l_index].fax_no				= dw_list.object.fax_no[l_row]
i_mdl_kyoten.ret[l_index].unso_code				= dw_list.object.unso_code[l_row]
i_mdl_kyoten.ret[l_index].zaiko_kanri_flg		= dw_list.object.zaiko_kanri_flg[l_row]
i_mdl_kyoten.ret[l_index].wms_kadou_kbn			= dw_list.object.wms_kadou_kbn[l_row]
i_mdl_kyoten.ret[l_index].wms_nouhinsyo_flg		= dw_list.object.wms_nouhinsyo_flg[l_row]
i_mdl_kyoten.ret[l_index].syukka_date			= dw_list.object.syukka_date[l_row]
i_mdl_kyoten.ret[l_index].yoku_syukka_date		= dw_list.object.yoku_syukka_date[l_row]
i_mdl_kyoten.ret[l_index].jyutyu_sime_jikoku1	= dw_list.object.jyutyu_sime_jikoku1[l_row]
i_mdl_kyoten.ret[l_index].jyutyu_sime_jikoku2	= dw_list.object.jyutyu_sime_jikoku2[l_row]
i_mdl_kyoten.ret[l_index].jyutyu_sime_jikoku3	= dw_list.object.jyutyu_sime_jikoku3[l_row]
i_mdl_kyoten.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_kyoten.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_kyoten.ret[l_index].touroku_client_id		= dw_list.object.touroku_client_id[l_row]
i_mdl_kyoten.ret[l_index].touroku_pg_id			= dw_list.object.touroku_pg_id[l_row]
i_mdl_kyoten.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_kyoten.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_kyoten.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_kyoten.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_kyoten.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_kyoten.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_kyoten.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_kyoten.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_kyoten.ret[l_index].haita_flg				= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_kyoten )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_kyoten
end type

type st_date from iw_modal_window`st_date within wsm_kyoten
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_kyoten
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_kyoten
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_kyoten
end type

type st_title from iw_modal_window`st_title within wsm_kyoten
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_kyoten
end type

type st_upper from iw_modal_window`st_upper within wsm_kyoten
end type

type st_tail from iw_modal_window`st_tail within wsm_kyoten
end type

type cb_ok from iw_modal_window`cb_ok within wsm_kyoten
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_kyoten
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_kyoten
integer x = 460
integer y = 299
integer width = 1856
integer taborder = 30
string dataobject = "dsm_kyoten"
boolean vscrollbar = true
boolean f6_key = true
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
sle_kyoten_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_kyoten
integer taborder = 20
end type

type st_kyoten_mei from ivo_statictext within wsm_kyoten
integer x = 36
integer y = 174
boolean bringtotop = true
string text = "拠点名"
end type

type sle_kyoten_mei from ivo_singlelineedit within wsm_kyoten
integer x = 436
integer y = 164
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

