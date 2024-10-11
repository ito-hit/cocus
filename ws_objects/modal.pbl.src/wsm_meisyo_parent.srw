$PBExportHeader$wsm_meisyo_parent.srw
$PBExportComments$名称区分検索のモーダル
forward
global type wsm_meisyo_parent from iw_modal_window
end type
type sle_meisyo_mei from ivo_singlelineedit within wsm_meisyo_parent
end type
type st_meisyo_1 from ivo_statictext within wsm_meisyo_parent
end type
end forward

global type wsm_meisyo_parent from iw_modal_window
integer height = 1941
string title = "名称区分検索"
integer dw_height = 1382
integer dw_width = 1415
sle_meisyo_mei sle_meisyo_mei
st_meisyo_1 st_meisyo_1
end type
global wsm_meisyo_parent wsm_meisyo_parent

type variables

public:
	str_mdlpara_mmeisyo	i_mdl_meisyo	// 親ウインドウとの受け渡し用構造体

private:
	str_mmeisyo			i_para_reset[]	// i_mdl_meisyo.retの初期化用
	string				i_meisyo_mei	// retrieveに使うパラメータ用
end variables

on wsm_meisyo_parent.create
int iCurrent
call super::create
this.sle_meisyo_mei=create sle_meisyo_mei
this.st_meisyo_1=create st_meisyo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_meisyo_mei
this.Control[iCurrent+2]=this.st_meisyo_1
end on

on wsm_meisyo_parent.destroy
call super::destroy
destroy(this.sle_meisyo_mei)
destroy(this.st_meisyo_1)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_meisyo.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_meisyo.ret[l_index].meisyo_kbn		= dw_list.object.meisyo_kbn[l_row]
i_mdl_meisyo.ret[l_index].meisyo_mei		= dw_list.object.meisyo_mei[l_row]
i_mdl_meisyo.ret[l_index].meisyo_code		= dw_list.object.meisyo_code[l_row]
i_mdl_meisyo.ret[l_index].meisyo_1			= dw_list.object.meisyo_1[l_row]
i_mdl_meisyo.ret[l_index].meisyo_2			= dw_list.object.meisyo_2[l_row]
i_mdl_meisyo.ret[l_index].meisyo_3			= dw_list.object.meisyo_3[l_row]
i_mdl_meisyo.ret[l_index].setumei			= dw_list.object.setumei[l_row]
i_mdl_meisyo.ret[l_index].code_ketasu		= dw_list.object.code_ketasu[l_row]
i_mdl_meisyo.ret[l_index].code_zokusei_flg	= dw_list.object.code_zokusei_flg[l_row]
i_mdl_meisyo.ret[l_index].kousin_kengen		= dw_list.object.kousin_kengen[l_row]
i_mdl_meisyo.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_meisyo.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_meisyo.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_meisyo.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_meisyo.ret[l_index].henkou_user_id	= dw_list.object.henkou_user_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_meisyo.ret[l_index].kousin_user_id	= dw_list.object.kousin_user_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_meisyo.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_meisyo )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_meisyo		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_meisyo.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_meisyo_mei
sle_meisyo_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_meisyo_1
st_meisyo_1.y			= sle_meisyo_mei.y + sle_meisyo_mei.height / 2 - st_meisyo_1.height / 2
st_meisyo_1.x			= dw_list.x

sle_meisyo_mei.x		= st_meisyo_1.x + st_meisyo_1.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_meisyo_mei.y// + sle_meisyo_mei.height + code.MGN_TATE

sle_meisyo_mei.width	= cb_retrieve.x - sle_meisyo_mei.x - code.MGN_ITEM_YOKO

return 0
end event

event open;call super::open;
sle_meisyo_mei.setfocus()
//cb_ok.enabled	= false

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_meisyo_mei

l_meisyo_mei	= trim( sle_meisyo_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_meisyo_mei ) <> 0 then
	i_meisyo_mei	= l_meisyo_mei
else
	setnull( i_meisyo_mei )
end if

if dw_list.retrieve( i_meisyo_mei ) > 0 then
	dw_list.setfocus()
else
	sle_meisyo_mei.setfocus()
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_meisyo_parent
end type

type st_date from iw_modal_window`st_date within wsm_meisyo_parent
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_meisyo_parent
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_meisyo_parent
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_meisyo_parent
end type

type st_title from iw_modal_window`st_title within wsm_meisyo_parent
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_meisyo_parent
end type

type st_upper from iw_modal_window`st_upper within wsm_meisyo_parent
end type

type st_tail from iw_modal_window`st_tail within wsm_meisyo_parent
integer y = 1739
end type

type cb_ok from iw_modal_window`cb_ok within wsm_meisyo_parent
integer y = 1760
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_meisyo_parent
integer y = 1760
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_meisyo_parent
integer x = 12
integer y = 277
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_meisyo_parent"
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
sle_meisyo_mei.setfocus()

return 0
end event

event getfocus;call super::getfocus;
//cb_ok.enabled	= true
end event

event losefocus;call super::losefocus;
//cb_ok.enabled	= false
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_meisyo_parent
integer y = 156
integer taborder = 20
end type

type sle_meisyo_mei from ivo_singlelineedit within wsm_meisyo_parent
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "名称を入力してください"
end type

type st_meisyo_1 from ivo_statictext within wsm_meisyo_parent
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "名称"
alignment alignment = right!
end type

