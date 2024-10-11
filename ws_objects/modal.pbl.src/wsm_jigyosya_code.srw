$PBExportHeader$wsm_jigyosya_code.srw
$PBExportComments$事業者コード検索のモーダル
forward
global type wsm_jigyosya_code from iw_modal_window
end type
type sle_jigyosya_mei from ivo_singlelineedit within wsm_jigyosya_code
end type
type st_jigyosya_mei from ivo_statictext within wsm_jigyosya_code
end type
type cbx_haiban_flg from ivo_checkbox within wsm_jigyosya_code
end type
end forward

global type wsm_jigyosya_code from iw_modal_window
string title = "事業者コード検索"
integer dw_height = 1382
integer dw_width = 2569
sle_jigyosya_mei sle_jigyosya_mei
st_jigyosya_mei st_jigyosya_mei
cbx_haiban_flg cbx_haiban_flg
end type
global wsm_jigyosya_code wsm_jigyosya_code

type variables

public:
	str_mdlpara_mgtin_kanri	i_mdl_gtin_kanri	// 親ウインドウとの受け渡し用構造体

private:
	str_mgtin_kanri			i_para_reset[]		// i_mdl_gtin_kanri.retの初期化用
	string					i_jigyosya_mei		// retrieveに使うパラメータ用

end variables

on wsm_jigyosya_code.create
int iCurrent
call super::create
this.sle_jigyosya_mei=create sle_jigyosya_mei
this.st_jigyosya_mei=create st_jigyosya_mei
this.cbx_haiban_flg=create cbx_haiban_flg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_jigyosya_mei
this.Control[iCurrent+2]=this.st_jigyosya_mei
this.Control[iCurrent+3]=this.cbx_haiban_flg
end on

on wsm_jigyosya_code.destroy
call super::destroy
destroy(this.sle_jigyosya_mei)
destroy(this.st_jigyosya_mei)
destroy(this.cbx_haiban_flg)
end on

event open;call super::open;
sle_jigyosya_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_gtin_kanri		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_gtin_kanri.ret	= i_para_reset

// DWにフィルタ適用
cbx_haiban_flg.event clicked( )
end event

event resize;call super::resize;
// sle_jigyosya_mei
sle_jigyosya_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_jigyosya_mei
st_jigyosya_mei.y		= sle_jigyosya_mei.y + sle_jigyosya_mei.height / 2 - st_jigyosya_mei.height / 2
st_jigyosya_mei.x		= dw_list.x

sle_jigyosya_mei.x		= st_jigyosya_mei.x + st_jigyosya_mei.width + code.MGN_GROUP_YOKO

// cbx_haiban_flg
cbx_haiban_flg.y		= sle_jigyosya_mei.y + sle_jigyosya_mei.height / 2 - cbx_haiban_flg.height / 2
cbx_haiban_flg.x		= cb_retrieve.x + cb_retrieve.width - cbx_haiban_flg.width

sle_jigyosya_mei.width	= cbx_haiban_flg.x - sle_jigyosya_mei.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y			= sle_jigyosya_mei.y + sle_jigyosya_mei.height + code.MGN_TATE

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_jigyosya_mei

l_jigyosya_mei	= trim( sle_jigyosya_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_jigyosya_mei ) <> 0 then
	i_jigyosya_mei	= l_jigyosya_mei
else
	setnull( i_jigyosya_mei )
end if

if dw_list.retrieve( i_jigyosya_mei ) > 0 then
	dw_list.setfocus()
else
	sle_jigyosya_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_gtin_kanri.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_gtin_kanri.ret[l_index].jigyosya_code		= dw_list.object.jigyosya_code[l_row]
i_mdl_gtin_kanri.ret[l_index].jigyosya_mei		= dw_list.object.jigyosya_mei[l_row]
i_mdl_gtin_kanri.ret[l_index].jido_saiban_flg	= dw_list.object.jido_saiban_flg[l_row]
i_mdl_gtin_kanri.ret[l_index].item_code_str		= dw_list.object.item_code_str[l_row]
i_mdl_gtin_kanri.ret[l_index].item_code_end		= dw_list.object.item_code_end[l_row]
i_mdl_gtin_kanri.ret[l_index].item_code_gen		= dw_list.object.item_code_gen[l_row]
i_mdl_gtin_kanri.ret[l_index].rep_flg			= dw_list.object.rep_flg[l_row]
i_mdl_gtin_kanri.ret[l_index].haiban_flg		= dw_list.object.haiban_flg[l_row]
i_mdl_gtin_kanri.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_gtin_kanri.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_gtin_kanri.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_gtin_kanri.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_gtin_kanri.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_gtin_kanri.ret[l_index].henkou_user_id	= dw_list.object.henkou_user_id[l_row]
i_mdl_gtin_kanri.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_gtin_kanri.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_gtin_kanri.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_gtin_kanri.ret[l_index].kousin_user_id	= dw_list.object.kousin_user_id[l_row]
i_mdl_gtin_kanri.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_gtin_kanri.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_gtin_kanri.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_gtin_kanri )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_jigyosya_code
end type

type st_date from iw_modal_window`st_date within wsm_jigyosya_code
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_jigyosya_code
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_jigyosya_code
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_jigyosya_code
end type

type st_title from iw_modal_window`st_title within wsm_jigyosya_code
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_jigyosya_code
end type

type st_upper from iw_modal_window`st_upper within wsm_jigyosya_code
end type

type st_tail from iw_modal_window`st_tail within wsm_jigyosya_code
end type

type cb_ok from iw_modal_window`cb_ok within wsm_jigyosya_code
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_jigyosya_code
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_jigyosya_code
integer x = 412
integer y = 316
integer taborder = 30
string dataobject = "dsm_jigyosya_code"
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
sle_jigyosya_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_jigyosya_code
integer taborder = 20
end type

type sle_jigyosya_mei from ivo_singlelineedit within wsm_jigyosya_code
integer x = 396
integer y = 178
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

type st_jigyosya_mei from ivo_statictext within wsm_jigyosya_code
integer x = 52
integer y = 171
boolean bringtotop = true
string text = "事業者名"
alignment alignment = right!
end type

type cbx_haiban_flg from ivo_checkbox within wsm_jigyosya_code
integer x = 732
integer y = 171
integer width = 400
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

