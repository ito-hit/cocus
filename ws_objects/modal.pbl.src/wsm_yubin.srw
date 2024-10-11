$PBExportHeader$wsm_yubin.srw
$PBExportComments$郵便番号検索のモーダル
forward
global type wsm_yubin from iw_modal_window
end type
type st_kensaku from ivo_statictext within wsm_yubin
end type
type sle_kensaku from ivo_singlelineedit within wsm_yubin
end type
end forward

global type wsm_yubin from iw_modal_window
string title = "郵便番号検索"
integer dw_height = 1442
integer dw_width = 2500
st_kensaku st_kensaku
sle_kensaku sle_kensaku
end type
global wsm_yubin wsm_yubin

type variables

public:
	str_mdlpara_myubin	i_mdl_yubin		// 親ウインドウとの受け渡し用構造体

private:
	str_myubin			i_para_reset[]	// i_mdl_yubin.retの初期化用
	string				i_kensaku		// retrieveに使うパラメータ用
end variables

on wsm_yubin.create
int iCurrent
call super::create
this.st_kensaku=create st_kensaku
this.sle_kensaku=create sle_kensaku
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_kensaku
this.Control[iCurrent+2]=this.sle_kensaku
end on

on wsm_yubin.destroy
call super::destroy
destroy(this.st_kensaku)
destroy(this.sle_kensaku)
end on

event open;call super::open;
sle_kensaku.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_yubin		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_yubin.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_kensaku
sle_kensaku.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_kensaku
st_kensaku.y		= sle_kensaku.y + sle_kensaku.height / 2 - st_kensaku.height / 2
st_kensaku.x		= dw_list.x

sle_kensaku.x		= st_kensaku.x + st_kensaku.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_kensaku.y

sle_kensaku.width	= cb_retrieve.x - sle_kensaku.x - code.MGN_ITEM_YOKO

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_kensaku

l_kensaku	= trim( sle_kensaku.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_kensaku ) <> 0 then
	i_kensaku	= l_kensaku
else
	setnull( i_kensaku )
end if

if dw_list.retrieve( i_kensaku ) > 0 then
	dw_list.setfocus()
else
	sle_kensaku.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_yubin.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_yubin.ret[l_index].data_kbn			= dw_list.object.data_kbn[l_row]
i_mdl_yubin.ret[l_index].jis_code			= dw_list.object.jis_code[l_row]
i_mdl_yubin.ret[l_index].yubin_no_old		= dw_list.object.yubin_no_old[l_row]
i_mdl_yubin.ret[l_index].yubin_no			= dw_list.object.yubin_no[l_row]
i_mdl_yubin.ret[l_index].todofu_kana		= dw_list.object.todofu_kana[l_row]
i_mdl_yubin.ret[l_index].sikutyo_kana		= dw_list.object.sikutyo_kana[l_row]
i_mdl_yubin.ret[l_index].tyoiki_kana		= dw_list.object.tyoiki_kana[l_row]
i_mdl_yubin.ret[l_index].todofu_mei			= dw_list.object.todofu_mei[l_row]
i_mdl_yubin.ret[l_index].sikutyo_mei		= dw_list.object.sikutyo_mei[l_row]
i_mdl_yubin.ret[l_index].tyoiki_mei			= dw_list.object.tyoiki_mei[l_row]
i_mdl_yubin.ret[l_index].tyome				= dw_list.object.tyome[l_row]
i_mdl_yubin.ret[l_index].jigyosyo_mei		= dw_list.object.jigyosyo_mei[l_row]
i_mdl_yubin.ret[l_index].full_mei			= dw_list.object.full_mei[l_row]
i_mdl_yubin.ret[l_index].kbn_1				= dw_list.object.kbn_1[l_row]
i_mdl_yubin.ret[l_index].kbn_2				= dw_list.object.kbn_2[l_row]
i_mdl_yubin.ret[l_index].kbn_3				= dw_list.object.kbn_3[l_row]
i_mdl_yubin.ret[l_index].kbn_4				= dw_list.object.kbn_4[l_row]
i_mdl_yubin.ret[l_index].kbn_5				= dw_list.object.kbn_5[l_row]
i_mdl_yubin.ret[l_index].kbn_6				= dw_list.object.kbn_6[l_row]
i_mdl_yubin.ret[l_index].kbn_7				= dw_list.object.kbn_7[l_row]
i_mdl_yubin.ret[l_index].kbn_8				= dw_list.object.kbn_8[l_row]
i_mdl_yubin.ret[l_index].kbn_9				= dw_list.object.kbn_9[l_row]
i_mdl_yubin.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_yubin.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_yubin.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_yubin.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_yubin.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_yubin.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_yubin.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_yubin.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_yubin.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_yubin.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_yubin.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_yubin.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_yubin.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_yubin )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_yubin
end type

type st_date from iw_modal_window`st_date within wsm_yubin
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_yubin
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_yubin
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_yubin
end type

type st_title from iw_modal_window`st_title within wsm_yubin
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_yubin
end type

type st_upper from iw_modal_window`st_upper within wsm_yubin
end type

type st_tail from iw_modal_window`st_tail within wsm_yubin
end type

type cb_ok from iw_modal_window`cb_ok within wsm_yubin
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_yubin
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_yubin
integer x = 516
integer y = 316
integer width = 2552
integer taborder = 30
string dataobject = "dsm_yubin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_kensaku.setfocus()

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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_yubin
integer taborder = 20
end type

type st_kensaku from ivo_statictext within wsm_yubin
integer x = 72
integer y = 160
boolean bringtotop = true
string text = "住所等"
end type

type sle_kensaku from ivo_singlelineedit within wsm_yubin
integer x = 472
integer y = 171
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

