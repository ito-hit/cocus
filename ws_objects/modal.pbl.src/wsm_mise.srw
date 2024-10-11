$PBExportHeader$wsm_mise.srw
$PBExportComments$店検索のモーダル
forward
global type wsm_mise from iw_modal_window
end type
type cbx_heiten_flg from ivo_checkbox within wsm_mise
end type
type sle_mise_mei from ivo_singlelineedit within wsm_mise
end type
type st_mise_mei from ivo_statictext within wsm_mise
end type
type st_mise_mei_kana from ivo_statictext within wsm_mise
end type
type sle_mise_mei_kana from ivo_singlelineedit within wsm_mise
end type
type st_jyusyo from ivo_statictext within wsm_mise
end type
type sle_jyusyo from ivo_singlelineedit within wsm_mise
end type
type st_number from ivo_statictext within wsm_mise
end type
type sle_number from ivo_singlelineedit within wsm_mise
end type
type uo_tokui from cv_input_tokui within wsm_mise
end type
type st_and from ivo_statictext within wsm_mise
end type
end forward

global type wsm_mise from iw_modal_window
integer width = 3672
integer height = 2322
string title = "店検索"
boolean immediate_retrieve = false
integer dw_height = 1442
integer dw_width = 3641
cbx_heiten_flg cbx_heiten_flg
sle_mise_mei sle_mise_mei
st_mise_mei st_mise_mei
st_mise_mei_kana st_mise_mei_kana
sle_mise_mei_kana sle_mise_mei_kana
st_jyusyo st_jyusyo
sle_jyusyo sle_jyusyo
st_number st_number
sle_number sle_number
uo_tokui uo_tokui
st_and st_and
end type
global wsm_mise wsm_mise

type variables

public:
	str_mdlpara_mmise	i_mdl_mise	// 親ウインドウとの受け渡し用構造体
	
private:
	str_mmise			i_para_reset[]	// i_mdl_mise.retの初期化用
	
	long				i_tokui_code	// retrieveに使うパラメータ用
	string				i_mise_mei		// retrieveに使うパラメータ用
	string				i_mise_mei_kana	// retrieveに使うパラメータ用
	string				i_jyusyo		// retrieveに使うパラメータ用
	string				i_number		// retrieveに使うパラメータ用
end variables

on wsm_mise.create
int iCurrent
call super::create
this.cbx_heiten_flg=create cbx_heiten_flg
this.sle_mise_mei=create sle_mise_mei
this.st_mise_mei=create st_mise_mei
this.st_mise_mei_kana=create st_mise_mei_kana
this.sle_mise_mei_kana=create sle_mise_mei_kana
this.st_jyusyo=create st_jyusyo
this.sle_jyusyo=create sle_jyusyo
this.st_number=create st_number
this.sle_number=create sle_number
this.uo_tokui=create uo_tokui
this.st_and=create st_and
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_heiten_flg
this.Control[iCurrent+2]=this.sle_mise_mei
this.Control[iCurrent+3]=this.st_mise_mei
this.Control[iCurrent+4]=this.st_mise_mei_kana
this.Control[iCurrent+5]=this.sle_mise_mei_kana
this.Control[iCurrent+6]=this.st_jyusyo
this.Control[iCurrent+7]=this.sle_jyusyo
this.Control[iCurrent+8]=this.st_number
this.Control[iCurrent+9]=this.sle_number
this.Control[iCurrent+10]=this.uo_tokui
this.Control[iCurrent+11]=this.st_and
end on

on wsm_mise.destroy
call super::destroy
destroy(this.cbx_heiten_flg)
destroy(this.sle_mise_mei)
destroy(this.st_mise_mei)
destroy(this.st_mise_mei_kana)
destroy(this.sle_mise_mei_kana)
destroy(this.st_jyusyo)
destroy(this.sle_jyusyo)
destroy(this.st_number)
destroy(this.sle_number)
destroy(this.uo_tokui)
destroy(this.st_and)
end on

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_mise.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_mise.ret[l_index].tokui_code				= dw_list.object.tokui_code[l_row]
i_mdl_mise.ret[l_index].mise_code				= dw_list.object.mise_code[l_row]
i_mdl_mise.ret[l_index].mise_kbn				= dw_list.object.mise_kbn[l_row]
i_mdl_mise.ret[l_index].mise_mei_full			= dw_list.object.mise_mei_full[l_row]
i_mdl_mise.ret[l_index].mise_mei				= dw_list.object.mise_mei[l_row]
i_mdl_mise.ret[l_index].mise_mei_ryaku			= dw_list.object.mise_mei_ryaku[l_row]
i_mdl_mise.ret[l_index].mise_mei_label			= dw_list.object.mise_mei_label[l_row]
i_mdl_mise.ret[l_index].mise_mei_kana			= dw_list.object.mise_mei_kana[l_row]
i_mdl_mise.ret[l_index].heiten_flg				= dw_list.object.heiten_flg[l_row]
i_mdl_mise.ret[l_index].syusoku_flg				= dw_list.object.syusoku_flg[l_row]
i_mdl_mise.ret[l_index].todofuken_code			= dw_list.object.todofuken_code[l_row]
i_mdl_mise.ret[l_index].sikutyoson_code			= dw_list.object.sikutyoson_code[l_row]
i_mdl_mise.ret[l_index].yubin_no				= dw_list.object.yubin_no[l_row]
i_mdl_mise.ret[l_index].jyusyo1					= dw_list.object.jyusyo1[l_row]
i_mdl_mise.ret[l_index].jyusyo2					= dw_list.object.jyusyo2[l_row]
i_mdl_mise.ret[l_index].jyusyo3					= dw_list.object.jyusyo3[l_row]
i_mdl_mise.ret[l_index].okuri_mei1				= dw_list.object.okuri_mei1[l_row]
i_mdl_mise.ret[l_index].okuri_mei2				= dw_list.object.okuri_mei2[l_row]
i_mdl_mise.ret[l_index].tel_no					= dw_list.object.tel_no[l_row]
i_mdl_mise.ret[l_index].fax_no					= dw_list.object.fax_no[l_row]
i_mdl_mise.ret[l_index].hensin_flg				= dw_list.object.hensin_flg[l_row]
i_mdl_mise.ret[l_index].meisai_kbn				= dw_list.object.meisai_kbn[l_row]
i_mdl_mise.ret[l_index].layout_kbn				= dw_list.object.layout_kbn[l_row]
i_mdl_mise.ret[l_index].haisin_houhou			= dw_list.object.haisin_houhou[l_row]
i_mdl_mise.ret[l_index].hensin_fax_no			= dw_list.object.hensin_fax_no[l_row]
i_mdl_mise.ret[l_index].hensin_address			= dw_list.object.hensin_address[l_row]
i_mdl_mise.ret[l_index].hensin_mise_code		= dw_list.object.hensin_mise_code[l_row]
i_mdl_mise.ret[l_index].nohinsyo_hakkou_kbn		= dw_list.object.nohinsyo_hakkou_kbn[l_row]
i_mdl_mise.ret[l_index].nohinsyo_kingaku_flg	= dw_list.object.nohinsyo_kingaku_flg[l_row]
i_mdl_mise.ret[l_index].nohinsyo_kousou_kbn		= dw_list.object.nohinsyo_kousou_kbn[l_row]
i_mdl_mise.ret[l_index].iraimoto_flg			= dw_list.object.iraimoto_flg[l_row]
i_mdl_mise.ret[l_index].iraimoto_mei			= dw_list.object.iraimoto_mei[l_row]
i_mdl_mise.ret[l_index].aite_kaisya_code		= dw_list.object.aite_kaisya_code[l_row]
i_mdl_mise.ret[l_index].aite_mise_code			= dw_list.object.aite_mise_code[l_row]
i_mdl_mise.ret[l_index].okuri_tokui_code		= dw_list.object.okuri_tokui_code[l_row]
i_mdl_mise.ret[l_index].okuri_mise_code			= dw_list.object.okuri_mise_code[l_row]
i_mdl_mise.ret[l_index].okuri_center_code		= dw_list.object.okuri_center_code[l_row]
i_mdl_mise.ret[l_index].syukka_kyoten_sitei_kbn	= dw_list.object.syukka_kyoten_sitei_kbn[l_row]
i_mdl_mise.ret[l_index].syukka_kyoten_code		= dw_list.object.syukka_kyoten_code[l_row]
i_mdl_mise.ret[l_index].unso_code				= dw_list.object.unso_code[l_row]
i_mdl_mise.ret[l_index].tyakuten_code			= dw_list.object.tyakuten_code[l_row]
i_mdl_mise.ret[l_index].tyakuten_tome_flg		= dw_list.object.tyakuten_tome_flg[l_row]
i_mdl_mise.ret[l_index].kobetu_haiso_flg		= dw_list.object.kobetu_haiso_flg[l_row]
i_mdl_mise.ret[l_index].leadtime_kbn			= dw_list.object.leadtime_kbn[l_row]
i_mdl_mise.ret[l_index].leadtime_keisan_kbn		= dw_list.object.leadtime_keisan_kbn[l_row]
i_mdl_mise.ret[l_index].nouhinbi_hyoji_flg		= dw_list.object.nouhinbi_hyoji_flg[l_row]
i_mdl_mise.ret[l_index].haitatu_sitei_flg		= dw_list.object.haitatu_sitei_flg[l_row]
i_mdl_mise.ret[l_index].haitatu_sitei_jikoku	= dw_list.object.haitatu_sitei_jikoku[l_row]
i_mdl_mise.ret[l_index].nifuda_bikou			= dw_list.object.nifuda_bikou[l_row]
i_mdl_mise.ret[l_index].niokurinin_code			= dw_list.object.niokurinin_code[l_row]
i_mdl_mise.ret[l_index].untin_seikyu_flg		= dw_list.object.untin_seikyu_flg[l_row]
i_mdl_mise.ret[l_index].touroku_date			= dw_list.object.touroku_date[l_row]
i_mdl_mise.ret[l_index].touroku_user_id			= dw_list.object.touroku_user_id[l_row]
i_mdl_mise.ret[l_index].touroku_client_id		= dw_list.object.touroku_client_id[l_row]
i_mdl_mise.ret[l_index].touroku_pg_id			= dw_list.object.touroku_pg_id[l_row]
i_mdl_mise.ret[l_index].henkou_date				= dw_list.object.henkou_date[l_row]
i_mdl_mise.ret[l_index].henkou_user_id			= dw_list.object.henkou_user_id[l_row]
i_mdl_mise.ret[l_index].henkou_client_id		= dw_list.object.henkou_client_id[l_row]
i_mdl_mise.ret[l_index].henkou_pg_id			= dw_list.object.henkou_pg_id[l_row]
i_mdl_mise.ret[l_index].kousin_date				= dw_list.object.kousin_date[l_row]
i_mdl_mise.ret[l_index].kousin_user_id			= dw_list.object.kousin_user_id[l_row]
i_mdl_mise.ret[l_index].kousin_client_id		= dw_list.object.kousin_client_id[l_row]
i_mdl_mise.ret[l_index].kousin_pg_id			= dw_list.object.kousin_pg_id[l_row]
i_mdl_mise.ret[l_index].haita_flg				= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_mise )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_mise	= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_mise.ret	= i_para_reset

// DWにフィルタ適用 immediate_retrieveがfalseなので不要
//cbx_heiten_flg.event clicked( )

// inパラメータがあるかチェック
if i_mdl_mise.in_tokui_code <> 0 and not isnull( i_mdl_mise.in_tokui_code ) then
	uo_tokui.of_set_input( string( i_mdl_mise.in_tokui_code ) )	// 得意先コードをsleにセット
	uo_tokui.event sle_input_check()							// sleに入った値をチェックする
end if
end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// uo_tokui
uo_tokui.y				= st_upper.y + st_upper.height + code.MGN_TATE
uo_tokui.x				= dw_list.x

// cbx_heiten_flg
cbx_heiten_flg.y		= uo_tokui.y + uo_tokui.height / 2 - cbx_heiten_flg.height / 2
cbx_heiten_flg.x		= cb_retrieve.x + cb_retrieve.width - cbx_heiten_flg.width

// st_and
st_and.y				= uo_tokui.y + uo_tokui.height / 2 - st_and.height / 2
st_and.x				= cbx_heiten_flg.x - st_and.width - code.MGN_ITEM_YOKO

uo_tokui.width			= st_and.x - uo_tokui.x - code.MGN_ITEM_YOKO
//uo_tokui.width			= this.width * 0.6


/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_mise_mei
sle_mise_mei.y			= uo_tokui.y + uo_tokui.height + code.MGN_TATE

// st_mise_mei
st_mise_mei.y			= sle_mise_mei.y + sle_mise_mei.height / 2 - st_mise_mei.height / 2
st_mise_mei.x			= dw_list.x

sle_mise_mei.x			= st_mise_mei.x + st_mise_mei.width + code.MGN_GROUP_YOKO

// sle_jyusyo
sle_jyusyo.width		= this.width * 0.3	// 可変にできる？
sle_jyusyo.y			= uo_tokui.y + uo_tokui.height + code.MGN_TATE
sle_jyusyo.x			= cb_retrieve.x - sle_jyusyo.width - code.MGN_ITEM_YOKO

// st_jyusyo
st_jyusyo.y				= sle_jyusyo.y + sle_jyusyo.height / 2 - st_jyusyo.height / 2
st_jyusyo.x				= sle_jyusyo.x - st_jyusyo.width - code.MGN_GROUP_YOKO

sle_mise_mei.width		= st_jyusyo.x - sle_mise_mei.x - code.MGN_ITEM_YOKO


/*---下の段--------------------------------------------------------------------------------------*/
// sle_mise_mei_kana
sle_mise_mei_kana.y		= sle_mise_mei.y + sle_mise_mei.height + code.MGN_TATE

// st_mise_mei_kana
st_mise_mei_kana.y		= sle_mise_mei_kana.y + sle_mise_mei_kana.height / 2 - st_mise_mei.height / 2
st_mise_mei_kana.x		= dw_list.x

sle_mise_mei_kana.x		= st_mise_mei_kana.x + st_mise_mei_kana.width + code.MGN_GROUP_YOKO

// sle_number
sle_number.width		= this.width * 0.2	// 可変にできる？
sle_number.y			= sle_mise_mei.y + sle_mise_mei.height + code.MGN_TATE
sle_number.x			= cb_retrieve.x - sle_jyusyo.width - code.MGN_ITEM_YOKO

// st_number
st_number.y				= sle_number.y + sle_number.height / 2 - st_number.height / 2
st_number.x				= sle_number.x - st_number.width - code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_mise_mei_kana.y

sle_mise_mei_kana.width	= st_number.x - sle_mise_mei_kana.x - code.MGN_ITEM_YOKO

return 0
end event

event open;call super::open;
uo_tokui.sle_input.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
string	l_mise_mei, l_mise_mei_kana, l_jyusyo, l_number

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 得意先コードは存在するものがセットされる
i_tokui_code	= long( trim( uo_tokui.of_get_input( ) ) )

// 店名
l_mise_mei	= trim( sle_mise_mei.text )

if len( l_mise_mei ) <> 0 then
	i_mise_mei	= l_mise_mei
else
	setnull( i_mise_mei )
end if

// カナ名
l_mise_mei_kana	= trim( sle_mise_mei_kana.text )

if len( l_mise_mei_kana ) <> 0 then
	i_mise_mei_kana	= l_mise_mei_kana
else
	setnull( i_mise_mei_kana )
end if

// 住所
l_jyusyo	= trim( sle_jyusyo.text )

if len( l_jyusyo ) <> 0 then
	i_jyusyo	= l_jyusyo
else
	setnull( i_jyusyo )
end if

// 電話FAX
l_number	= trim( fnc.strg.of_replace( sle_number.text, "-", "" ) )

if len( l_number ) <> 0 then
	i_number	= l_number
else
	setnull( i_number )
end if

if dw_list.retrieve( i_tokui_code, i_mise_mei, i_mise_mei_kana, i_jyusyo, i_number ) > 0 then
	dw_list.setfocus()
else
	uo_tokui.setfocus()
end if

// DWにフィルタ適用
cbx_heiten_flg.event clicked( )

dw_list.setfocus()

return 0
end event

event retrieve_check;call super::retrieve_check;
// 得意先は必須
if not uo_tokui.event sle_input_check() then
	msg.of_error( "得意先コードを入力してください。" )
	return -1
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_mise
end type

type st_date from iw_modal_window`st_date within wsm_mise
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_mise
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_mise
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_mise
end type

type st_title from iw_modal_window`st_title within wsm_mise
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_mise
end type

type st_upper from iw_modal_window`st_upper within wsm_mise
end type

type st_tail from iw_modal_window`st_tail within wsm_mise
integer y = 2009
integer width = 2204
end type

type cb_ok from iw_modal_window`cb_ok within wsm_mise
integer x = 1540
integer y = 2030
integer taborder = 80
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_mise
integer x = 1888
integer y = 2030
integer taborder = 90
end type

type dw_list from iw_modal_window`dw_list within wsm_mise
integer x = 32
integer y = 807
integer width = 2260
integer height = 1127
integer taborder = 70
string dataobject = "dsm_mise"
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
uo_tokui.setfocus()

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_mise
integer x = 2372
integer y = 548
integer taborder = 60
end type

type cbx_heiten_flg from ivo_checkbox within wsm_mise
integer x = 2988
integer y = 196
integer width = 548
string text = "閉店を含む"
end type

event clicked;call super::clicked;
integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	// 閉店フラグが1のもの以外表示
	dw_list.setfilter( "heiten_flg <> 1" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end event

type sle_mise_mei from ivo_singlelineedit within wsm_mise
integer x = 368
integer y = 430
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "店名を入力してください"
end type

type st_mise_mei from ivo_statictext within wsm_mise
integer x = 36
integer y = 434
boolean bringtotop = true
string text = "店名"
alignment alignment = right!
end type

type st_mise_mei_kana from ivo_statictext within wsm_mise
integer x = 24
integer y = 569
boolean bringtotop = true
string text = "カナ名"
alignment alignment = right!
end type

type sle_mise_mei_kana from ivo_singlelineedit within wsm_mise
integer x = 356
integer y = 565
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "カナ名を入力してください"
end type

type st_jyusyo from ivo_statictext within wsm_mise
integer x = 1208
integer y = 427
boolean bringtotop = true
string text = "住所"
alignment alignment = right!
end type

type sle_jyusyo from ivo_singlelineedit within wsm_mise
integer x = 1540
integer y = 423
integer width = 744
integer taborder = 40
boolean bringtotop = true
string text = ""
string placeholder = "住所を入力してください"
end type

type st_number from ivo_statictext within wsm_mise
integer x = 1172
integer y = 565
boolean bringtotop = true
string text = "電話FAX"
alignment alignment = right!
end type

type sle_number from ivo_singlelineedit within wsm_mise
integer x = 1504
integer y = 562
integer width = 744
integer taborder = 50
boolean bringtotop = true
string text = ""
string placeholder = "番号を入力してください"
end type

type uo_tokui from cv_input_tokui within wsm_mise
integer x = 28
integer y = 196
integer taborder = 10
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;
integer	l_syusoku_flg

if ancestorreturnvalue then
	l_syusoku_flg	= uo_tokui.of_get_syusoku_flg()
	
	if l_syusoku_flg <> 0 then
		uo_tokui.of_set_bikou( "終息" )
	end if
end if

return ancestorreturnvalue
end event

type st_and from ivo_statictext within wsm_mise
integer x = 2360
integer y = 206
integer width = 544
boolean bringtotop = true
string text = "※各項目をAND検索"
alignment alignment = right!
end type

