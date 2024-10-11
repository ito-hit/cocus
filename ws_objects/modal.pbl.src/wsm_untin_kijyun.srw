$PBExportHeader$wsm_untin_kijyun.srw
$PBExportComments$運賃基準検索のモーダル
forward
global type wsm_untin_kijyun from iw_modal_window
end type
type sle_kijyun_mei from ivo_singlelineedit within wsm_untin_kijyun
end type
type st_kijyun_mei from ivo_statictext within wsm_untin_kijyun
end type
end forward

global type wsm_untin_kijyun from iw_modal_window
string title = "運賃基準検索"
integer dw_height = 1382
integer dw_width = 2793
sle_kijyun_mei sle_kijyun_mei
st_kijyun_mei st_kijyun_mei
end type
global wsm_untin_kijyun wsm_untin_kijyun

type variables

public:
	str_mdlpara_muntin_kijyun	i_mdl_untin_kijyun	// 親ウインドウとの受け渡し用構造体

private:
	str_muntin_kijyun			i_para_reset[]		// i_mdl_untin_kijyun.retの初期化用
	string						i_kijyun_mei		// retrieveに使うパラメータ用

end variables

on wsm_untin_kijyun.create
int iCurrent
call super::create
this.sle_kijyun_mei=create sle_kijyun_mei
this.st_kijyun_mei=create st_kijyun_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_kijyun_mei
this.Control[iCurrent+2]=this.st_kijyun_mei
end on

on wsm_untin_kijyun.destroy
call super::destroy
destroy(this.sle_kijyun_mei)
destroy(this.st_kijyun_mei)
end on

event open;call super::open;
sle_kijyun_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_untin_kijyun		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_untin_kijyun.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_kijyun_mei
sle_kijyun_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_kijyun_mei
st_kijyun_mei.y			= sle_kijyun_mei.y + sle_kijyun_mei.height / 2 - st_kijyun_mei.height / 2
st_kijyun_mei.x			= dw_list.x

sle_kijyun_mei.x		= st_kijyun_mei.x + st_kijyun_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_kijyun_mei.y

sle_kijyun_mei.width	= cb_retrieve.x - sle_kijyun_mei.x - code.MGN_ITEM_YOKO * 5

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_kijyun_mei

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 基準名
l_kijyun_mei	= trim( sle_kijyun_mei.text )

if len( l_kijyun_mei ) <> 0 then
	i_kijyun_mei	= l_kijyun_mei
else	
	setnull( i_kijyun_mei )
end if

if dw_list.retrieve( i_kijyun_mei ) > 0 then
	dw_list.setfocus()
else
	sle_kijyun_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_untin_kijyun.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_untin_kijyun.ret[l_index].kijyun_code			= dw_list.object.kijyun_code[l_row]
i_mdl_untin_kijyun.ret[l_index].kijyun_mei			= dw_list.object.kijyun_mei[l_row]
i_mdl_untin_kijyun.ret[l_index].kijyun_mei_ryaku	= dw_list.object.kijyun_mei_ryaku[l_row]
i_mdl_untin_kijyun.ret[l_index].seikyu_kbn			= dw_list.object.seikyu_kbn[l_row]
i_mdl_untin_kijyun.ret[l_index].keisan_kijyun		= dw_list.object.keisan_kijyun[l_row]
i_mdl_untin_kijyun.ret[l_index].keisan_kijyunti		= dw_list.object.keisan_kijyunti[l_row]
i_mdl_untin_kijyun.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_untin_kijyun.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_untin_kijyun.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_untin_kijyun.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_untin_kijyun.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_untin_kijyun.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_untin_kijyun.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_untin_kijyun.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_untin_kijyun.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_untin_kijyun.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_untin_kijyun.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_untin_kijyun.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_untin_kijyun.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_untin_kijyun )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_untin_kijyun
end type

type st_date from iw_modal_window`st_date within wsm_untin_kijyun
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_untin_kijyun
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_untin_kijyun
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_untin_kijyun
end type

type st_title from iw_modal_window`st_title within wsm_untin_kijyun
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_untin_kijyun
end type

type st_upper from iw_modal_window`st_upper within wsm_untin_kijyun
end type

type st_tail from iw_modal_window`st_tail within wsm_untin_kijyun
end type

type cb_ok from iw_modal_window`cb_ok within wsm_untin_kijyun
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_untin_kijyun
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_untin_kijyun
integer x = 68
integer y = 299
integer width = 2936
integer taborder = 30
string dataobject = "dsm_untin_kijyun"
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
sle_kijyun_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_untin_kijyun
integer taborder = 20
end type

type sle_kijyun_mei from ivo_singlelineedit within wsm_untin_kijyun
integer x = 448
integer y = 171
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

type st_kijyun_mei from ivo_statictext within wsm_untin_kijyun
integer x = 52
integer y = 178
boolean bringtotop = true
string text = "基準名"
alignment alignment = right!
end type

