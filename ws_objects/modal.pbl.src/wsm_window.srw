$PBExportHeader$wsm_window.srw
$PBExportComments$ウィンドウ検索のモーダル
forward
global type wsm_window from iw_modal_window
end type
type st_window_name from ivo_statictext within wsm_window
end type
type sle_window_name from ivo_singlelineedit within wsm_window
end type
end forward

global type wsm_window from iw_modal_window
integer height = 2076
string title = "ウィンドウ検索"
integer dw_height = 1382
integer dw_width = 2200
st_window_name st_window_name
sle_window_name sle_window_name
end type
global wsm_window wsm_window

type variables

public:
	str_mdlpara_mwindow	i_mdl_window	// 親ウインドウとの受け渡し用構造体

private:
	str_mwindow			i_para_reset[]	// i_mdl_window.retの初期化用
	string				i_window_name	// retrieveに使うパラメータ用
end variables

on wsm_window.create
int iCurrent
call super::create
this.st_window_name=create st_window_name
this.sle_window_name=create sle_window_name
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_window_name
this.Control[iCurrent+2]=this.sle_window_name
end on

on wsm_window.destroy
call super::destroy
destroy(this.st_window_name)
destroy(this.sle_window_name)
end on

event open;call super::open;
sle_window_name.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_window		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_window.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_window_name
sle_window_name.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_window_name
st_window_name.y		= sle_window_name.y + sle_window_name.height / 2 - st_window_name.height / 2
st_window_name.x		= dw_list.x

sle_window_name.x		= st_window_name.x + st_window_name.width + code.MGN_GROUP_YOKO

sle_window_name.width	= cb_retrieve.x - sle_window_name.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y			= sle_window_name.y

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_window_name

l_window_name	= trim( sle_window_name.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_window_name ) <> 0 then
	i_window_name	= l_window_name
else
	setnull( i_window_name )
end if

if dw_list.retrieve( i_window_name ) > 0 then
	dw_list.setfocus()
else
	sle_window_name.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_window.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_window.ret[l_index].window_id			= dw_list.object.window_id[l_row]
i_mdl_window.ret[l_index].window_name		= dw_list.object.window_name[l_row]
i_mdl_window.ret[l_index].kengen_kbn		= dw_list.object.kengen_kbn[l_row]
i_mdl_window.ret[l_index].syokai_flg		= dw_list.object.syokai_flg[l_row]
i_mdl_window.ret[l_index].siyo_kinsi_flg	= dw_list.object.siyo_kinsi_flg[l_row]
i_mdl_window.ret[l_index].fukusu_kinsi_flg	= dw_list.object.fukusu_kinsi_flg[l_row]
i_mdl_window.ret[l_index].bikou				= dw_list.object.bikou[l_row]
i_mdl_window.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_window.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_window.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_window.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_window.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_window.ret[l_index].henkou_user_id	= dw_list.object.henkou_user_id[l_row]
i_mdl_window.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_window.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_window.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_window.ret[l_index].kousin_user_id	= dw_list.object.kousin_user_id[l_row]
i_mdl_window.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_window.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_window.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_window )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_window
end type

type st_date from iw_modal_window`st_date within wsm_window
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_window
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_window
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_window
end type

type st_title from iw_modal_window`st_title within wsm_window
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_window
end type

type st_upper from iw_modal_window`st_upper within wsm_window
end type

type st_tail from iw_modal_window`st_tail within wsm_window
integer y = 1796
end type

type cb_ok from iw_modal_window`cb_ok within wsm_window
integer x = 1064
integer y = 1817
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_window
integer x = 1412
integer y = 1817
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_window
integer x = 100
integer y = 523
integer width = 2200
integer height = 1127
integer taborder = 30
string dataobject = "dsm_window"
boolean vscrollbar = true
boolean save_excel = false
end type

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_window_name.setfocus()

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_window
integer taborder = 20
end type

type st_window_name from ivo_statictext within wsm_window
integer x = 44
integer y = 206
boolean bringtotop = true
string text = "ウィンドウ名"
end type

type sle_window_name from ivo_singlelineedit within wsm_window
integer x = 496
integer y = 256
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "ウィンドウ名を入力してください"
end type

