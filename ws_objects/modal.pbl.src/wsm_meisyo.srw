$PBExportHeader$wsm_meisyo.srw
$PBExportComments$名称検索のモーダル
forward
global type wsm_meisyo from iw_modal_window
end type
type sle_meisyo from ivo_singlelineedit within wsm_meisyo
end type
type st_meisyo from ivo_statictext within wsm_meisyo
end type
end forward

global type wsm_meisyo from iw_modal_window
integer width = 3668
integer height = 1913
string title = ""
integer dw_height = 1382
integer dw_width = 2929
sle_meisyo sle_meisyo
st_meisyo st_meisyo
end type
global wsm_meisyo wsm_meisyo

type variables

public:
	str_mdlpara_mmeisyo	i_mdl_meisyo	// 親ウインドウとの受け渡し用構造体

private:
	str_mmeisyo			i_para_reset[]	// i_mdl_meisyo.retの初期化用
	
	integer				i_meisyo_kbn	// retrieveに使うパラメータ用
	string				i_meisyo		// retrieveに使うパラメータ用
end variables

on wsm_meisyo.create
int iCurrent
call super::create
this.sle_meisyo=create sle_meisyo
this.st_meisyo=create st_meisyo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_meisyo
this.Control[iCurrent+2]=this.st_meisyo
end on

on wsm_meisyo.destroy
call super::destroy
destroy(this.sle_meisyo)
destroy(this.st_meisyo)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_meisyo.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_meisyo.ret[l_index].meisyo_kbn		= dw_list.object.meisyo_kbn[l_row]
i_mdl_meisyo.ret[l_index].meisyo_mei		= dw_list.object.meisyo_mei[l_row]
i_mdl_meisyo.ret[l_index].meisyo_code		= dw_list.object.meisyo_code[l_row]
i_mdl_meisyo.ret[l_index].meisyo_1			= dw_list.object.meisyo_1[l_row]
i_mdl_meisyo.ret[l_index].meisyo_2			= dw_list.object.meisyo_2[l_row]
i_mdl_meisyo.ret[l_index].meisyo_3			= dw_list.object.meisyo_3[l_row]
i_mdl_meisyo.ret[l_index].setumei			= dw_list.object.setumei[l_row]
i_mdl_meisyo.ret[l_index].code_ketasu		= dw_list.object.code_ketasu[l_row]
i_mdl_meisyo.ret[l_index].code_zokusei_flg	= dw_list.object.code_zokusei_flg[l_row]
i_mdl_meisyo.ret[l_index].kousin_kengen		= dw_list.object.kousin_kengen[l_row]
i_mdl_meisyo.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_meisyo.ret[l_index].touroku_user_id	= dw_list.object.touroku_user_id[l_row]
i_mdl_meisyo.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_meisyo.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_date		= dw_list.object.henkou_date[l_row]
i_mdl_meisyo.ret[l_index].henkou_user_id	= dw_list.object.henkou_user_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_meisyo.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_date		= dw_list.object.kousin_date[l_row]
i_mdl_meisyo.ret[l_index].kousin_user_id	= dw_list.object.kousin_user_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_meisyo.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_meisyo.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_meisyo )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_meisyo		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_meisyo.ret	= i_para_reset

// inパラメータがあるかチェック  immediate_retrieveがtrueのときはopenqueryに書かないと値がセットされない
if not isnull( i_mdl_meisyo.in_meisyo_kbn ) then
	immediate_retrieve	= true						// メニューIDがセットされているときだけ自動検索する
	i_meisyo_kbn		= i_mdl_meisyo.in_meisyo_kbn
end if

end event

event resize;call super::resize;
// --- DWの名称1～3の幅を自動調整 ---------------------------------
//constant long	l_width		= 70
//constant long	l_scroll	= 121
//long			l_row
//
//if dw_list.dataobject = "dsm_meisyo02" then
//	l_row	= dw_list.getrow()
//	
//	if l_row > 0 then
//		dw_list.object.meisyo_1.width	= long( dw_list.object.length[l_row] * l_width )
//		dw_list.object.meisyo_2.width	= long( dw_list.object.length[l_row] * l_width )
//		dw_list.object.meisyo_3.width	= long( dw_list.object.length[l_row] * l_width )
//		
//		// DWのサイズとウィンドウのサイズを更新する
//		dw_width	= long( dw_list.object.meisyo_code.width ) + long( dw_list.object.meisyo_1.width ) + long( dw_list.object.meisyo_2.width ) + long( dw_list.object.meisyo_3.width ) + l_scroll
//		this.width	= dw_list.x + dw_list.width + code.MGN_YOKO + 20
//	end if
//end if
// ----------------------------------------------------------------

// sle_meisyo
sle_meisyo.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_meisyo
st_meisyo.y			= sle_meisyo.y + sle_meisyo.height / 2 - st_meisyo.height / 2
st_meisyo.x			= dw_list.x

sle_meisyo.x		= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_meisyo.y// + sle_meisyo.height + code.MGN_TATE

sle_meisyo.width	= cb_retrieve.x - sle_meisyo.x - code.MGN_ITEM_YOKO

return 0
end event

event open;call super::open;
long	l_row

sle_meisyo.setfocus()

// タイトルを設定
l_row			= dw_list.getrow()
st_title.text	= dw_list.object.meisyo_mei[l_row] + "検索"

// DWのサイズ可変テスト
//this.event resize( 1, 1, 1 )

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_meisyo

l_meisyo	= trim( sle_meisyo.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_meisyo ) <> 0 then
	i_meisyo	= l_meisyo
else
	setnull( i_meisyo )
end if

if dw_list.retrieve( i_meisyo_kbn, i_meisyo ) > 0 then
	dw_list.setfocus()
else
	sle_meisyo.setfocus()
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_meisyo
end type

type st_date from iw_modal_window`st_date within wsm_meisyo
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_meisyo
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_meisyo
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_meisyo
end type

type st_title from iw_modal_window`st_title within wsm_meisyo
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_meisyo
end type

type st_upper from iw_modal_window`st_upper within wsm_meisyo
end type

type st_tail from iw_modal_window`st_tail within wsm_meisyo
integer y = 1739
end type

type cb_ok from iw_modal_window`cb_ok within wsm_meisyo
integer y = 1760
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_meisyo
integer y = 1760
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_meisyo
integer x = 12
integer y = 277
integer width = 2808
integer height = 1127
integer taborder = 30
string dataobject = "dsm_meisyo"
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
sle_meisyo.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_meisyo
integer y = 156
integer taborder = 20
end type

type sle_meisyo from ivo_singlelineedit within wsm_meisyo
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "名称を入力してください"
end type

type st_meisyo from ivo_statictext within wsm_meisyo
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "名称"
alignment alignment = right!
end type

