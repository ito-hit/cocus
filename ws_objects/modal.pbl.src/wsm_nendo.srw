$PBExportHeader$wsm_nendo.srw
$PBExportComments$事業年度検索のモーダル
forward
global type wsm_nendo from iw_modal_window
end type
type st_nendo_mei from ivo_statictext within wsm_nendo
end type
type sle_nendo_mei from ivo_singlelineedit within wsm_nendo
end type
end forward

global type wsm_nendo from iw_modal_window
string title = "事業年度検索"
integer dw_height = 1382
integer dw_width = 1361
st_nendo_mei st_nendo_mei
sle_nendo_mei sle_nendo_mei
end type
global wsm_nendo wsm_nendo

type variables

public:
	str_mdlpara_mnendo	i_mdl_nendo		// 親ウインドウとの受け渡し用構造体

private:
	str_mnendo			i_para_reset[]	// i_mdl_nendo.retの初期化用
	string				i_nendo_mei		// retrieveに使うパラメータ用
end variables

on wsm_nendo.create
int iCurrent
call super::create
this.st_nendo_mei=create st_nendo_mei
this.sle_nendo_mei=create sle_nendo_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nendo_mei
this.Control[iCurrent+2]=this.sle_nendo_mei
end on

on wsm_nendo.destroy
call super::destroy
destroy(this.st_nendo_mei)
destroy(this.sle_nendo_mei)
end on

event open;call super::open;
sle_nendo_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_nendo		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_nendo.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_nendo_mei
sle_nendo_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_nendo_mei
st_nendo_mei.y		= sle_nendo_mei.y + sle_nendo_mei.height / 2 - st_nendo_mei.height / 2
st_nendo_mei.x		= dw_list.x

sle_nendo_mei.x		= st_nendo_mei.x + st_nendo_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_nendo_mei.y

sle_nendo_mei.width	= cb_retrieve.x - sle_nendo_mei.x - code.MGN_ITEM_YOKO

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_nendo_mei

l_nendo_mei	= trim( sle_nendo_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_nendo_mei ) <> 0 then
	i_nendo_mei	= l_nendo_mei
else
	setnull( i_nendo_mei )
end if

if dw_list.retrieve( i_nendo_mei ) > 0 then
	dw_list.setfocus()
else
	sle_nendo_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_nendo.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_nendo.ret[l_index].nendo_code			= dw_list.object.nendo_code[l_row]
i_mdl_nendo.ret[l_index].nendo_mei			= dw_list.object.nendo_mei[l_row]
i_mdl_nendo.ret[l_index].kisyo_nengetu		= dw_list.object.kisyo_nengetu[l_row]
i_mdl_nendo.ret[l_index].kimatu_nengetu		= dw_list.object.kimatu_nengetu[l_row]
i_mdl_nendo.ret[l_index].kisyo_date			= dw_list.object.kisyo_date[l_row]
i_mdl_nendo.ret[l_index].kimatu_date		= dw_list.object.kimatu_date[l_row]
i_mdl_nendo.ret[l_index].tuki_1q			= dw_list.object.tuki_1q[l_row]
i_mdl_nendo.ret[l_index].tuki_2q			= dw_list.object.tuki_2q[l_row]
i_mdl_nendo.ret[l_index].tuki_3q			= dw_list.object.tuki_3q[l_row]
i_mdl_nendo.ret[l_index].tuki_4q			= dw_list.object.tuki_4q[l_row]
i_mdl_nendo.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_nendo.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_nendo.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_nendo.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_nendo.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_nendo.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_nendo.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_nendo.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_nendo.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_nendo.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_nendo.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_nendo.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_nendo.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_nendo )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_nendo
end type

type st_date from iw_modal_window`st_date within wsm_nendo
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_nendo
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_nendo
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_nendo
end type

type st_title from iw_modal_window`st_title within wsm_nendo
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_nendo
end type

type st_upper from iw_modal_window`st_upper within wsm_nendo
end type

type st_tail from iw_modal_window`st_tail within wsm_nendo
end type

type cb_ok from iw_modal_window`cb_ok within wsm_nendo
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_nendo
end type

type dw_list from iw_modal_window`dw_list within wsm_nendo
integer x = 508
integer y = 316
integer width = 1560
string dataobject = "dsm_nendo"
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_nendo_mei.setfocus()

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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_nendo
end type

type st_nendo_mei from ivo_statictext within wsm_nendo
integer x = 72
integer y = 181
boolean bringtotop = true
string text = "年度名"
end type

type sle_nendo_mei from ivo_singlelineedit within wsm_nendo
integer x = 536
integer y = 210
integer taborder = 20
boolean bringtotop = true
string text = ""
end type

