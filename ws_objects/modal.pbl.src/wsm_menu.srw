$PBExportHeader$wsm_menu.srw
$PBExportComments$メニュー検索のモーダル
forward
global type wsm_menu from iw_modal_window
end type
type sle_menu_id from ivo_singlelineedit within wsm_menu
end type
type st_menu_id from ivo_statictext within wsm_menu
end type
end forward

global type wsm_menu from iw_modal_window
integer height = 1604
string title = "メニュー検索"
integer dw_height = 1382
integer dw_width = 1838
sle_menu_id sle_menu_id
st_menu_id st_menu_id
end type
global wsm_menu wsm_menu

type variables

public:
	str_mdlpara_mmenu	i_mdl_menu		// 親ウインドウとの受け渡し用構造体

private:
	str_mmenu			i_para_reset[]	// i_mdl_menu.retの初期化用
	string				i_menu_id		// retrieveに使うパラメータ用
end variables

on wsm_menu.create
int iCurrent
call super::create
this.sle_menu_id=create sle_menu_id
this.st_menu_id=create st_menu_id
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_menu_id
this.Control[iCurrent+2]=this.st_menu_id
end on

on wsm_menu.destroy
call super::destroy
destroy(this.sle_menu_id)
destroy(this.st_menu_id)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_menu.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_menu.ret[l_index].menu_id				= dw_list.object.menu_id[l_row]
i_mdl_menu.ret[l_index].tab_id				= dw_list.object.tab_id[l_row]
i_mdl_menu.ret[l_index].button_no			= dw_list.object.button_no[l_row]
i_mdl_menu.ret[l_index].window_id			= dw_list.object.window_id[l_row]
i_mdl_menu.ret[l_index].siyo_kanou_flg		= dw_list.object.siyo_kanou_flg[l_row]
i_mdl_menu.ret[l_index].param				= dw_list.object.param[l_row]
i_mdl_menu.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_menu.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_menu.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_menu.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_menu.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_menu.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_menu.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_menu.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_menu.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_menu.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_menu.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_menu.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_menu.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_menu )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_menu		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_menu.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_menu
sle_menu_id.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_menu
st_menu_id.y		= sle_menu_id.y + sle_menu_id.height / 2 - st_menu_id.height / 2
st_menu_id.x		= dw_list.x

sle_menu_id.x		= st_menu_id.x + st_menu_id.width + code.MGN_GROUP_YOKO

sle_menu_id.width	= cb_retrieve.x - sle_menu_id.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= sle_menu_id.y
end event

event open;call super::open;
sle_menu_id.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_menu_id

l_menu_id	= trim( sle_menu_id.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_menu_id ) <> 0 then
	i_menu_id	= l_menu_id
else
	setnull( i_menu_id )
end if

if dw_list.retrieve( i_menu_id ) > 0 then
	dw_list.setfocus()
else
	sle_menu_id.setfocus()
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_menu
end type

type st_date from iw_modal_window`st_date within wsm_menu
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_menu
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_menu
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_menu
end type

type st_title from iw_modal_window`st_title within wsm_menu
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_menu
end type

type st_upper from iw_modal_window`st_upper within wsm_menu
end type

type st_tail from iw_modal_window`st_tail within wsm_menu
integer y = 1412
end type

type cb_ok from iw_modal_window`cb_ok within wsm_menu
integer y = 1433
integer taborder = 40
end type

event clicked;call super::clicked;
//parent.i_tab_string	= i_menu_string
end event

type cb_cancel from iw_modal_window`cb_cancel within wsm_menu
integer y = 1433
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_menu
integer x = 12
integer y = 338
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_menu_id.setfocus()

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_menu
integer x = 1428
integer y = 164
integer taborder = 20
end type

type sle_menu_id from ivo_singlelineedit within wsm_menu
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "メニューIDを入力してください"
end type

type st_menu_id from ivo_statictext within wsm_menu
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "メニューID"
alignment alignment = right!
end type

