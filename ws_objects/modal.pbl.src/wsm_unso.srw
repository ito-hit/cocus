$PBExportHeader$wsm_unso.srw
$PBExportComments$運送便検索のモーダル
forward
global type wsm_unso from iw_modal_window
end type
type st_unso_mei from ivo_statictext within wsm_unso
end type
type sle_unso_mei from ivo_singlelineedit within wsm_unso
end type
end forward

global type wsm_unso from iw_modal_window
string title = "運送便検索"
integer dw_height = 1442
integer dw_width = 2165
st_unso_mei st_unso_mei
sle_unso_mei sle_unso_mei
end type
global wsm_unso wsm_unso

type variables

public:
	str_mdlpara_munso	i_mdl_unso			// 親ウインドウとの受け渡し用構造体

private:
	str_munso			i_para_reset[]		// i_mdl_unso.retの初期化用
	
	long				i_tokui_code		// retrieveに使うパラメータ用
	long				i_todofuken_code	// retrieveに使うパラメータ用
	string				i_unso_mei			// retrieveに使うパラメータ用

end variables

on wsm_unso.create
int iCurrent
call super::create
this.st_unso_mei=create st_unso_mei
this.sle_unso_mei=create sle_unso_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_unso_mei
this.Control[iCurrent+2]=this.sle_unso_mei
end on

on wsm_unso.destroy
call super::destroy
destroy(this.st_unso_mei)
destroy(this.sle_unso_mei)
end on

event open;call super::open;
sle_unso_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_unso	= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_unso.ret	= i_para_reset
end event

event resize;call super::resize;
// sle_unso_mei
sle_unso_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_unso_mei
st_unso_mei.y		= sle_unso_mei.y + sle_unso_mei.height / 2 - st_unso_mei.height / 2
st_unso_mei.x		= dw_list.x

sle_unso_mei.x		= st_unso_mei.x + st_unso_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_unso_mei.y

sle_unso_mei.width	= cb_retrieve.x - sle_unso_mei.x - code.MGN_ITEM_YOKO

return 0
end event

event retrieve_event;call super::retrieve_event;
string l_unso_mei

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
i_tokui_code		= i_mdl_unso.in_tokui_code
i_todofuken_code	= i_mdl_unso.in_todofuken_code

l_unso_mei			= trim( sle_unso_mei.text )

if len( l_unso_mei ) <> 0 then
	i_unso_mei	= l_unso_mei
else
	setnull( i_unso_mei )
end if

if dw_list.retrieve( i_tokui_code, i_todofuken_code, i_unso_mei ) > 0 then
	dw_list.setfocus()
else
	sle_unso_mei.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_unso.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_unso.ret[l_index].unso_code				= dw_list.object.unso_code[l_row]
i_mdl_unso.ret[l_index].unso_mei				= dw_list.object.unso_mei[l_row]
i_mdl_unso.ret[l_index].unso_mei_ryaku			= dw_list.object.unso_mei_ryaku[l_row]
i_mdl_unso.ret[l_index].air_flg					= dw_list.object.air_flg[l_row]
i_mdl_unso.ret[l_index].untin_flg				= dw_list.object.untin_flg[l_row]
i_mdl_unso.ret[l_index].keisan_code				= dw_list.object.keisan_code[l_row]
i_mdl_unso.ret[l_index].okurijyo_flg			= dw_list.object.okurijyo_flg[l_row]
i_mdl_unso.ret[l_index].okurijyo_code			= dw_list.object.okurijyo_code[l_row]
i_mdl_unso.ret[l_index].tyakubarai_furikae_flg	= dw_list.object.tyakubarai_furikae_flg[l_row]
i_mdl_unso.ret[l_index].tyakubarai_unso_code	= dw_list.object.tyakubarai_unso_code[l_row]
i_mdl_unso.ret[l_index].haiban_flg				= dw_list.object.haiban_flg[l_row]
i_mdl_unso.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_unso.ret[l_index].touroku_user_id			= dw_list.object.touroku_user_id[l_row]
i_mdl_unso.ret[l_index].touroku_client_id		= dw_list.object.touroku_client_id[l_row]
i_mdl_unso.ret[l_index].touroku_pg_id			= dw_list.object.touroku_pg_id[l_row]
i_mdl_unso.ret[l_index].henkou_date				= dw_list.object.henkou_date[l_row]
i_mdl_unso.ret[l_index].henkou_user_id			= dw_list.object.henkou_user_id[l_row]
i_mdl_unso.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_unso.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_unso.ret[l_index].kousin_date				= dw_list.object.kousin_date[l_row]
i_mdl_unso.ret[l_index].kousin_user_id			= dw_list.object.kousin_user_id[l_row]
i_mdl_unso.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_unso.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_unso.ret[l_index].haita_flg				= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_unso )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_unso
end type

type st_date from iw_modal_window`st_date within wsm_unso
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_unso
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_unso
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_unso
end type

type st_title from iw_modal_window`st_title within wsm_unso
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_unso
end type

type st_upper from iw_modal_window`st_upper within wsm_unso
end type

type st_tail from iw_modal_window`st_tail within wsm_unso
end type

type cb_ok from iw_modal_window`cb_ok within wsm_unso
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_unso
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_unso
integer x = 280
integer y = 316
integer width = 2156
integer taborder = 30
string dataobject = "dsm_unso"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

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

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_unso_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_unso
integer taborder = 20
end type

type st_unso_mei from ivo_statictext within wsm_unso
integer x = 68
integer y = 185
boolean bringtotop = true
string text = "運送便名"
end type

type sle_unso_mei from ivo_singlelineedit within wsm_unso
integer x = 492
integer y = 181
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

