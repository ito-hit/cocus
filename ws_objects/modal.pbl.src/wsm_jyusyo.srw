$PBExportHeader$wsm_jyusyo.srw
$PBExportComments$住所選択のモーダル
forward
global type wsm_jyusyo from iw_modal_window
end type
end forward

global type wsm_jyusyo from iw_modal_window
string title = "住所選択"
integer dw_height = 1442
integer dw_width = 3000
end type
global wsm_jyusyo wsm_jyusyo

type variables

public:
	str_mdlpara_myubin	i_mdl_jyusyo	// 親ウインドウとの受け渡し用構造体

private:
	str_myubin			i_para_reset[]	// i_mdl_jyusyo.retの初期化用
end variables
on wsm_jyusyo.create
int iCurrent
call super::create
end on

on wsm_jyusyo.destroy
call super::destroy
end on

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_jyusyo		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_jyusyo.ret	= i_para_reset
end event

event retrieve_event;call super::retrieve_event;
string	l_yubin_no

// 必ずinパラメータが渡される
l_yubin_no	= i_mdl_jyusyo.in_yubin_no

dw_list.retrieve( l_yubin_no )
dw_list.setfocus()
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_jyusyo.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_jyusyo.ret[l_index].data_kbn			= dw_list.object.data_kbn[l_row]
i_mdl_jyusyo.ret[l_index].jis_code			= dw_list.object.jis_code[l_row]
i_mdl_jyusyo.ret[l_index].yubin_no_old		= dw_list.object.yubin_no_old[l_row]
i_mdl_jyusyo.ret[l_index].yubin_no			= dw_list.object.yubin_no[l_row]
i_mdl_jyusyo.ret[l_index].todofu_kana		= dw_list.object.todofu_kana[l_row]
i_mdl_jyusyo.ret[l_index].sikutyo_kana		= dw_list.object.sikutyo_kana[l_row]
i_mdl_jyusyo.ret[l_index].tyoiki_kana		= dw_list.object.tyoiki_kana[l_row]
i_mdl_jyusyo.ret[l_index].todofu_mei		= dw_list.object.todofu_mei[l_row]
i_mdl_jyusyo.ret[l_index].sikutyo_mei		= dw_list.object.sikutyo_mei[l_row]
i_mdl_jyusyo.ret[l_index].tyoiki_mei		= dw_list.object.tyoiki_mei[l_row]
i_mdl_jyusyo.ret[l_index].tyome				= dw_list.object.tyome[l_row]
i_mdl_jyusyo.ret[l_index].jigyosyo_mei		= dw_list.object.jigyosyo_mei[l_row]
i_mdl_jyusyo.ret[l_index].full_mei			= dw_list.object.full_mei[l_row]
i_mdl_jyusyo.ret[l_index].kbn_1				= dw_list.object.kbn_1[l_row]
i_mdl_jyusyo.ret[l_index].kbn_2				= dw_list.object.kbn_2[l_row]
i_mdl_jyusyo.ret[l_index].kbn_3				= dw_list.object.kbn_3[l_row]
i_mdl_jyusyo.ret[l_index].kbn_4				= dw_list.object.kbn_4[l_row]
i_mdl_jyusyo.ret[l_index].kbn_5				= dw_list.object.kbn_5[l_row]
i_mdl_jyusyo.ret[l_index].kbn_6				= dw_list.object.kbn_6[l_row]
i_mdl_jyusyo.ret[l_index].kbn_7				= dw_list.object.kbn_7[l_row]
i_mdl_jyusyo.ret[l_index].kbn_8				= dw_list.object.kbn_8[l_row]
i_mdl_jyusyo.ret[l_index].kbn_9				= dw_list.object.kbn_9[l_row]
i_mdl_jyusyo.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_jyusyo.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_jyusyo.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_jyusyo.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_jyusyo.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_jyusyo.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_jyusyo.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_jyusyo.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_jyusyo.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_jyusyo.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_jyusyo.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_jyusyo.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_jyusyo.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_jyusyo )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_jyusyo
end type

type st_date from iw_modal_window`st_date within wsm_jyusyo
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_jyusyo
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_jyusyo
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_jyusyo
end type

type st_title from iw_modal_window`st_title within wsm_jyusyo
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_jyusyo
end type

type st_upper from iw_modal_window`st_upper within wsm_jyusyo
end type

type st_tail from iw_modal_window`st_tail within wsm_jyusyo
end type

type cb_ok from iw_modal_window`cb_ok within wsm_jyusyo
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_jyusyo
end type

type dw_list from iw_modal_window`dw_list within wsm_jyusyo
integer x = 484
integer y = 277
string dataobject = "dsm_jyusyo"
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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_jyusyo
boolean visible = false
boolean enabled = false
end type

