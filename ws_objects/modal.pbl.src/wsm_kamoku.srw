$PBExportHeader$wsm_kamoku.srw
$PBExportComments$勘定科目検索のモーダル
forward
global type wsm_kamoku from iw_modal_window
end type
type st_kamoku_code from ivo_statictext within wsm_kamoku
end type
type st_kamoku_mei from ivo_statictext within wsm_kamoku
end type
type sle_kamoku_code from ivo_singlelineedit within wsm_kamoku
end type
type sle_kamoku_mei from ivo_singlelineedit within wsm_kamoku
end type
type st_kamoku_code_mei from sv_st_meisyo within wsm_kamoku
end type
end forward

global type wsm_kamoku from iw_modal_window
integer height = 1404
string title = "勘定科目検索"
integer dw_height = 1442
integer dw_width = 2137
st_kamoku_code st_kamoku_code
st_kamoku_mei st_kamoku_mei
sle_kamoku_code sle_kamoku_code
sle_kamoku_mei sle_kamoku_mei
st_kamoku_code_mei st_kamoku_code_mei
end type
global wsm_kamoku wsm_kamoku

type variables

public:
	str_mdlpara_mkamoku	i_mdl_kamoku	// 親ウインドウとの受け渡し用構造体

private:
	str_mkamoku			i_para_reset[]	// i_mdl_kamoku.retの初期化用
	
	long				i_kamoku_code	// retrieveに使うパラメータ用
	string				i_kamoku_mei	// retrieveに使うパラメータ用

end variables

on wsm_kamoku.create
int iCurrent
call super::create
this.st_kamoku_code=create st_kamoku_code
this.st_kamoku_mei=create st_kamoku_mei
this.sle_kamoku_code=create sle_kamoku_code
this.sle_kamoku_mei=create sle_kamoku_mei
this.st_kamoku_code_mei=create st_kamoku_code_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_kamoku_code
this.Control[iCurrent+2]=this.st_kamoku_mei
this.Control[iCurrent+3]=this.sle_kamoku_code
this.Control[iCurrent+4]=this.sle_kamoku_mei
this.Control[iCurrent+5]=this.st_kamoku_code_mei
end on

on wsm_kamoku.destroy
call super::destroy
destroy(this.st_kamoku_code)
destroy(this.st_kamoku_mei)
destroy(this.sle_kamoku_code)
destroy(this.sle_kamoku_mei)
destroy(this.st_kamoku_code_mei)
end on

event open;call super::open;
sle_kamoku_code.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_kamoku		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_kamoku.ret	= i_para_reset

// inパラメータがあるかチェック
if i_mdl_kamoku.in_kamoku_code <> 0 and not isnull( i_mdl_kamoku.in_kamoku_code ) then
	sle_kamoku_code.text	= string( i_mdl_kamoku.in_kamoku_code )	// 勘定科目コードをsleにセット
	sle_kamoku_code.event input_check()								// sleに入った値をチェックする
end if
end event

event retrieve_event;call super::retrieve_event;
string l_kamoku_code, l_kamoku_mei

l_kamoku_code	= trim( sle_kamoku_code.text )
l_kamoku_mei	= trim( sle_kamoku_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 勘定科目コード
if len( l_kamoku_code ) <> 0 then
	i_kamoku_code	= long( l_kamoku_code )
else
	setnull( i_kamoku_code )
end if

// 科目名
if len( l_kamoku_mei ) <> 0 then
	i_kamoku_mei	= l_kamoku_mei
else
	setnull( i_kamoku_mei )
end if

if dw_list.retrieve( i_kamoku_code, i_kamoku_mei ) > 0 then
	dw_list.setfocus()
else
	sle_kamoku_code.setfocus()
end if

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_kamoku.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_kamoku.ret[l_index].kamoku_code			= dw_list.object.kamoku_code[l_row]
i_mdl_kamoku.ret[l_index].hojyo_kamoku_code		= dw_list.object.hojyo_kamoku_code[l_row]
i_mdl_kamoku.ret[l_index].kamoku_mei			= dw_list.object.kamoku_mei[l_row]
i_mdl_kamoku.ret[l_index].hojyo_kamoku_mei		= dw_list.object.hojyo_kamoku_mei[l_row]
i_mdl_kamoku.ret[l_index].zei_kbn				= dw_list.object.zei_kbn[l_row]
i_mdl_kamoku.ret[l_index].zei_keisan_kbn		= dw_list.object.zei_keisan_kbn[l_row]
i_mdl_kamoku.ret[l_index].tegata_nyuryoku_flg	= dw_list.object.tegata_nyuryoku_flg[l_row]
i_mdl_kamoku.ret[l_index].bumon_nyuryoku_flg	= dw_list.object.bumon_nyuryoku_flg[l_row]
i_mdl_kamoku.ret[l_index].siyo_kinsi_flg		= dw_list.object.siyo_kinsi_flg[l_row]
i_mdl_kamoku.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_kamoku.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_kamoku.ret[l_index].touroku_client_id		= dw_list.object.touroku_client_id[l_row]
i_mdl_kamoku.ret[l_index].touroku_pg_id			= dw_list.object.touroku_pg_id[l_row]
i_mdl_kamoku.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_kamoku.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_kamoku.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_kamoku.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_kamoku.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_kamoku.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_kamoku.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_kamoku.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_kamoku.ret[l_index].haita_flg				= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_kamoku )
end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// sle_kamoku_code
sle_kamoku_code.y			= st_upper.y + st_upper.height + code.MGN_TATE

// st_kamoku_code
st_kamoku_code.y			= sle_kamoku_code.y + sle_kamoku_code.height / 2 - st_kamoku_code.height / 2
st_kamoku_code.x			= dw_list.x

sle_kamoku_code.x			= st_kamoku_code.x + st_kamoku_code.width + code.MGN_GROUP_YOKO

// st_kamoku_code_mei
st_kamoku_code_mei.y		= sle_kamoku_code.y + sle_kamoku_code.height / 2 - st_kamoku_code_mei.height / 2
st_kamoku_code_mei.x		= sle_kamoku_code.x + sle_kamoku_code.width + code.MGN_GROUP_YOKO

/*---下の段--------------------------------------------------------------------------------------*/
// sle_kamoku_mei
sle_kamoku_mei.y			= st_kamoku_code.y + st_kamoku_code.height + code.MGN_TATE

// st_kamoku_mei
st_kamoku_mei.y				= sle_kamoku_mei.y + sle_kamoku_mei.height / 2 - st_kamoku_mei.height / 2
st_kamoku_mei.x				= dw_list.x

sle_kamoku_mei.x			= st_kamoku_mei.x + st_kamoku_mei.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y				= sle_kamoku_mei.y

sle_kamoku_mei.width		= cb_retrieve.x - sle_kamoku_mei.x - code.MGN_ITEM_YOKO * 5
st_kamoku_code_mei.width	= cb_retrieve.x + cb_retrieve.width - st_kamoku_code_mei.x

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_kamoku
end type

type st_date from iw_modal_window`st_date within wsm_kamoku
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_kamoku
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_kamoku
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_kamoku
end type

type st_title from iw_modal_window`st_title within wsm_kamoku
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_kamoku
end type

type st_upper from iw_modal_window`st_upper within wsm_kamoku
end type

type st_tail from iw_modal_window`st_tail within wsm_kamoku
integer y = 1188
end type

type cb_ok from iw_modal_window`cb_ok within wsm_kamoku
integer y = 1216
integer taborder = 50
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_kamoku
integer y = 1216
integer taborder = 60
end type

type dw_list from iw_modal_window`dw_list within wsm_kamoku
integer x = 344
integer y = 636
integer taborder = 40
string dataobject = "dsm_kamoku"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_kamoku_code.setfocus()

return 0
end event

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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_kamoku
integer y = 345
integer taborder = 30
end type

type st_kamoku_code from ivo_statictext within wsm_kamoku
integer x = 60
integer y = 181
boolean bringtotop = true
string text = "勘定科目"
alignment alignment = right!
end type

type st_kamoku_mei from ivo_statictext within wsm_kamoku
integer x = 64
integer y = 284
boolean bringtotop = true
string text = "科目名"
alignment alignment = right!
end type

type sle_kamoku_code from ivo_singlelineedit within wsm_kamoku
integer x = 460
integer y = 167
integer width = 180
integer taborder = 10
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event input_check;call super::input_check;
string		l_input
long		l_kamoku_code
nv_master	mst
str_mkamoku	l_kamoku[]

l_input	= trim( this.text )

if len( l_input ) > 0 then
	l_kamoku_code	= long( l_input )
	
	// DBアクセス後、データがあるなら名称セット
	if mst.of_kamoku_get( l_kamoku_code, l_kamoku ) > 0 then
		st_kamoku_code_mei.text	= l_kamoku[1].kamoku_mei
	else
		st_kamoku_code_mei.text	= ""
	end if
else
	st_kamoku_code_mei.text	= ""
end if

return true
end event

type sle_kamoku_mei from ivo_singlelineedit within wsm_kamoku
integer x = 492
integer y = 338
integer taborder = 20
boolean bringtotop = true
string text = ""
end type

type st_kamoku_code_mei from sv_st_meisyo within wsm_kamoku
integer x = 824
integer y = 178
boolean bringtotop = true
string text = ""
end type

