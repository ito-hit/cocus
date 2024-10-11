$PBExportHeader$wsm_niokurinin.srw
$PBExportComments$荷送人検索のモーダル
forward
global type wsm_niokurinin from iw_modal_window
end type
type st_niokurinin_mei from ivo_statictext within wsm_niokurinin
end type
type sle_niokurinin_mei from ivo_singlelineedit within wsm_niokurinin
end type
end forward

global type wsm_niokurinin from iw_modal_window
string title = "荷送人検索"
integer dw_height = 1442
integer dw_width = 2777
st_niokurinin_mei st_niokurinin_mei
sle_niokurinin_mei sle_niokurinin_mei
end type
global wsm_niokurinin wsm_niokurinin

type variables

public:
	str_mdlpara_mniokurinin	i_mdl_niokurinin	// 親ウインドウとの受け渡し用構造体

private:
	str_mniokurinin			i_para_reset[]		// i_mdl_niokurinin.retの初期化用
	string					i_niokurinin_mei	// retrieveに使うパラメータ用

end variables

on wsm_niokurinin.create
int iCurrent
call super::create
this.st_niokurinin_mei=create st_niokurinin_mei
this.sle_niokurinin_mei=create sle_niokurinin_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_niokurinin_mei
this.Control[iCurrent+2]=this.sle_niokurinin_mei
end on

on wsm_niokurinin.destroy
call super::destroy
destroy(this.st_niokurinin_mei)
destroy(this.sle_niokurinin_mei)
end on

event open;call super::open;
sle_niokurinin_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_niokurinin		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_niokurinin.ret	= i_para_reset
end event

event retrieve_event;call super::retrieve_event;
string l_niokurinin_mei

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 荷送人名
l_niokurinin_mei	= trim( sle_niokurinin_mei.text )

if len( l_niokurinin_mei ) <> 0 then
	i_niokurinin_mei	= l_niokurinin_mei
else	
	setnull( i_niokurinin_mei )
end if

if dw_list.retrieve( i_niokurinin_mei ) > 0 then
	dw_list.setfocus()
else
	sle_niokurinin_mei.setfocus()
end if

return 0
end event

event resize;call super::resize;
// sle_niokurinin_mei
sle_niokurinin_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_niokurinin_mei
st_niokurinin_mei.y			= sle_niokurinin_mei.y + sle_niokurinin_mei.height / 2 - st_niokurinin_mei.height / 2
st_niokurinin_mei.x			= dw_list.x

sle_niokurinin_mei.x		= st_niokurinin_mei.x + st_niokurinin_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y				= sle_niokurinin_mei.y

sle_niokurinin_mei.width	= cb_retrieve.x - sle_niokurinin_mei.x - code.MGN_ITEM_YOKO * 5

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_niokurinin.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_niokurinin.ret[l_index].niokurinin_code	= dw_list.object.niokurinin_code[l_row]
i_mdl_niokurinin.ret[l_index].kanri_mei			= dw_list.object.kanri_mei[l_row]
i_mdl_niokurinin.ret[l_index].yubin_no			= dw_list.object.yubin_no[l_row]
i_mdl_niokurinin.ret[l_index].jyusyo1			= dw_list.object.jyusyo1[l_row]
i_mdl_niokurinin.ret[l_index].jyusyo2			= dw_list.object.jyusyo2[l_row]
i_mdl_niokurinin.ret[l_index].niokurinin_mei	= dw_list.object.niokurinin_mei[l_row]
i_mdl_niokurinin.ret[l_index].tel_no			= dw_list.object.tel_no[l_row]
i_mdl_niokurinin.ret[l_index].memo				= dw_list.object.memo[l_row]
i_mdl_niokurinin.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_niokurinin.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_niokurinin.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_niokurinin.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_niokurinin.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_niokurinin.ret[l_index].henkou_user_id	= dw_list.object.henkou_user_id[l_row]
i_mdl_niokurinin.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_niokurinin.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_niokurinin.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_niokurinin.ret[l_index].kousin_user_id	= dw_list.object.kousin_user_id[l_row]
i_mdl_niokurinin.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_niokurinin.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_niokurinin.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_niokurinin )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_niokurinin
end type

type st_date from iw_modal_window`st_date within wsm_niokurinin
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_niokurinin
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_niokurinin
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_niokurinin
end type

type st_title from iw_modal_window`st_title within wsm_niokurinin
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_niokurinin
end type

type st_upper from iw_modal_window`st_upper within wsm_niokurinin
end type

type st_tail from iw_modal_window`st_tail within wsm_niokurinin
end type

type cb_ok from iw_modal_window`cb_ok within wsm_niokurinin
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_niokurinin
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_niokurinin
integer x = 52
integer y = 327
integer width = 2680
integer taborder = 30
string dataobject = "dsm_niokurinin"
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
sle_niokurinin_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_niokurinin
integer taborder = 20
end type

type st_niokurinin_mei from ivo_statictext within wsm_niokurinin
integer x = 52
integer y = 171
boolean bringtotop = true
string text = "荷送人名"
alignment alignment = right!
end type

type sle_niokurinin_mei from ivo_singlelineedit within wsm_niokurinin
integer x = 444
integer y = 164
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

