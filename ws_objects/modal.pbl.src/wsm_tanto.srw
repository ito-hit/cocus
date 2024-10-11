$PBExportHeader$wsm_tanto.srw
$PBExportComments$営業担当者検索のモーダル
forward
global type wsm_tanto from iw_modal_window
end type
type st_tanto_mei from ivo_statictext within wsm_tanto
end type
type sle_tanto_mei from ivo_singlelineedit within wsm_tanto
end type
type cbx_haiban_flg from ivo_checkbox within wsm_tanto
end type
end forward

global type wsm_tanto from iw_modal_window
integer height = 2297
string title = "営業担当者検索"
integer dw_height = 1382
integer dw_width = 3440
st_tanto_mei st_tanto_mei
sle_tanto_mei sle_tanto_mei
cbx_haiban_flg cbx_haiban_flg
end type
global wsm_tanto wsm_tanto

type variables

public:
	str_mdlpara_mtanto	i_mdl_tanto		// 親ウインドウとの受け渡し用構造体

private:
	str_mtanto			i_para_reset[]	// i_mdl_tanto.retの初期化用
	string				i_tanto_mei		// retrieveに使うパラメータ用

end variables

on wsm_tanto.create
int iCurrent
call super::create
this.st_tanto_mei=create st_tanto_mei
this.sle_tanto_mei=create sle_tanto_mei
this.cbx_haiban_flg=create cbx_haiban_flg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tanto_mei
this.Control[iCurrent+2]=this.sle_tanto_mei
this.Control[iCurrent+3]=this.cbx_haiban_flg
end on

on wsm_tanto.destroy
call super::destroy
destroy(this.st_tanto_mei)
destroy(this.sle_tanto_mei)
destroy(this.cbx_haiban_flg)
end on

event resize;call super::resize;
// sle_tanto_mei
sle_tanto_mei.y	= st_upper.y + st_upper.height + code.MGN_TATE

// st_tanto_mei
st_tanto_mei.y	= sle_tanto_mei.y + sle_tanto_mei.height / 2 - st_tanto_mei.height / 2
st_tanto_mei.x	= dw_list.x

sle_tanto_mei.x	= st_tanto_mei.x + st_tanto_mei.width + code.MGN_GROUP_YOKO

// cbx_haiban_flg
cbx_haiban_flg.y	= sle_tanto_mei.y + sle_tanto_mei.height / 2 - cbx_haiban_flg.height / 2
cbx_haiban_flg.x	= cb_retrieve.x + cb_retrieve.width - cbx_haiban_flg.width

sle_tanto_mei.width	= cbx_haiban_flg.x - sle_tanto_mei.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= sle_tanto_mei.y + sle_tanto_mei.height + code.MGN_TATE

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_tanto_mei

l_tanto_mei	= trim( sle_tanto_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_tanto_mei ) <> 0 then
	i_tanto_mei	= l_tanto_mei
else
	setnull( i_tanto_mei )
end if

if dw_list.retrieve( i_tanto_mei ) > 0 then
	dw_list.setfocus()
else
	sle_tanto_mei.setfocus()
end if

return 0
end event

event open;call super::open;
sle_tanto_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_tanto		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_tanto.ret	= i_para_reset

// DWにフィルタ適用
cbx_haiban_flg.event clicked( )
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_tanto.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_tanto.ret[l_index].tanto_code			= dw_list.object.tanto_code[l_row]
i_mdl_tanto.ret[l_index].tanto_mei			= dw_list.object.tanto_mei[l_row]
i_mdl_tanto.ret[l_index].tanto_mei_ryaku	= dw_list.object.tanto_mei_ryaku[l_row]
i_mdl_tanto.ret[l_index].nayose_code		= dw_list.object.nayose_code[l_row]
i_mdl_tanto.ret[l_index].bumon_code			= dw_list.object.bumon_code[l_row]
i_mdl_tanto.ret[l_index].eigyosyo_code		= dw_list.object.eigyosyo_code[l_row]
i_mdl_tanto.ret[l_index].ka_code			= dw_list.object.ka_code[l_row]
i_mdl_tanto.ret[l_index].user_id			= dw_list.object.user_id[l_row]
i_mdl_tanto.ret[l_index].haiban_flg			= dw_list.object.haiban_flg[l_row]
i_mdl_tanto.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_tanto.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_tanto.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_tanto.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_tanto.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_tanto.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_tanto.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_tanto.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_tanto.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_tanto.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_tanto.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_tanto.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_tanto.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_tanto )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_tanto
end type

type st_date from iw_modal_window`st_date within wsm_tanto
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_tanto
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_tanto
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_tanto
end type

type st_title from iw_modal_window`st_title within wsm_tanto
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_tanto
end type

type st_upper from iw_modal_window`st_upper within wsm_tanto
end type

type st_tail from iw_modal_window`st_tail within wsm_tanto
integer y = 2055
end type

type cb_ok from iw_modal_window`cb_ok within wsm_tanto
integer y = 2076
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_tanto
integer y = 2076
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_tanto
integer x = 40
integer y = 423
integer width = 3440
integer height = 1127
integer taborder = 30
string dataobject = "dsm_tanto"
boolean hscrollbar = true
boolean vscrollbar = true
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
sle_tanto_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_tanto
integer x = 1180
integer y = 316
integer taborder = 20
end type

type st_tanto_mei from ivo_statictext within wsm_tanto
integer x = 108
integer y = 188
integer width = 256
boolean bringtotop = true
string text = "担当者名"
end type

type sle_tanto_mei from ivo_singlelineedit within wsm_tanto
integer x = 504
integer y = 213
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "担当者名を入力してください"
end type

type cbx_haiban_flg from ivo_checkbox within wsm_tanto
integer x = 912
integer y = 224
integer width = 368
string text = "廃番を含む"
end type

event clicked;call super::clicked;
integer	l_row

l_row	= dw_list.getrow()
dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	// 廃番フラグが1のもの以外表示
	dw_list.setfilter( "haiban_flg <> 1" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

return 0
end event

