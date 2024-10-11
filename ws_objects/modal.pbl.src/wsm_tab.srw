$PBExportHeader$wsm_tab.srw
$PBExportComments$タブ検索のモーダル
forward
global type wsm_tab from iw_modal_window
end type
type uo_menu from cv_input_menu within wsm_tab
end type
end forward

global type wsm_tab from iw_modal_window
integer height = 1604
string title = "タブ検索"
boolean immediate_retrieve = false
integer dw_height = 1382
integer dw_width = 1846
uo_menu uo_menu
end type
global wsm_tab wsm_tab

type variables

public:
	str_mdlpara_mmenu	i_mdl_tab		// 親ウインドウとの受け渡し用構造体

private:
	str_mmenu			i_para_reset[]	// i_mdl_tab.retの初期化用
	string				i_menu_id		// retrieveに使うパラメータ用
end variables

on wsm_tab.create
int iCurrent
call super::create
this.uo_menu=create uo_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_menu
end on

on wsm_tab.destroy
call super::destroy
destroy(this.uo_menu)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_tab.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_tab.ret[l_index].menu_id				= dw_list.object.menu_id[l_row]
i_mdl_tab.ret[l_index].tab_id				= dw_list.object.tab_id[l_row]
i_mdl_tab.ret[l_index].button_no			= dw_list.object.button_no[l_row]
i_mdl_tab.ret[l_index].window_id			= dw_list.object.window_id[l_row]
i_mdl_tab.ret[l_index].siyo_kanou_flg		= dw_list.object.siyo_kanou_flg[l_row]
i_mdl_tab.ret[l_index].param				= dw_list.object.param[l_row]
i_mdl_tab.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_tab.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_tab.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_tab.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_tab.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_tab.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_tab.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_tab.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_tab.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_tab.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_tab.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_tab.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_tab.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_tab )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_tab		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_tab.ret	= i_para_reset

// inパラメータがあるかチェック  immediate_retrieveがtrueのときはopenqueryに書かないと値がセットされない
if len( trim( i_mdl_tab.in_menu_id ) ) > 0 then
	immediate_retrieve	= true						// メニューIDがセットされているときだけ自動検索する
	
	uo_menu.of_set_input( i_mdl_tab.in_menu_id )	// メニューIDをsleにセット
	uo_menu.event sle_input_check()					// sleに入った値をチェックする
end if
end event

event resize;call super::resize;
// uo_menu
uo_menu.y		= st_upper.y + st_upper.height + code.MGN_TATE
uo_menu.x		= dw_list.x

uo_menu.width	= cb_retrieve.x - uo_menu.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= uo_menu.y


end event

event open;call super::open;
uo_menu.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_menu_id

l_menu_id	= trim( uo_menu.of_get_input() )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// メニューIDは未入力でも構わない
if len( l_menu_id ) <> 0 then
	i_menu_id	= l_menu_id
else
	setnull( i_menu_id )
end if

if dw_list.retrieve( i_menu_id ) > 0 then
	dw_list.setfocus()
else
	uo_menu.setfocus()
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_tab
end type

type st_date from iw_modal_window`st_date within wsm_tab
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_tab
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_tab
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_tab
end type

type st_title from iw_modal_window`st_title within wsm_tab
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_tab
end type

type st_upper from iw_modal_window`st_upper within wsm_tab
end type

type st_tail from iw_modal_window`st_tail within wsm_tab
integer y = 1412
end type

type cb_ok from iw_modal_window`cb_ok within wsm_tab
integer y = 1433
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_tab
integer y = 1433
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_tab
integer x = 12
integer y = 338
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_tab"
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
uo_menu.setfocus()

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_tab
integer x = 1724
integer y = 181
integer taborder = 20
end type

type uo_menu from cv_input_menu within wsm_tab
event destroy ( )
integer x = 16
integer y = 171
integer width = 1616
integer taborder = 30
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_menu.destroy
call cv_input_menu::destroy
end on

