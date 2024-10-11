$PBExportHeader$w_modal_mise.srw
$PBExportComments$店検索のモーダル
forward
global type w_modal_mise from iw_modal_window
end type
type cbx_out_heiten from ivo_checkbox within w_modal_mise
end type
type sle_mise_mei from ivo_singlelineedit within w_modal_mise
end type
type st_mise_mei from ivo_statictext within w_modal_mise
end type
type st_mise_kana from ivo_statictext within w_modal_mise
end type
type sle_mise_kana from ivo_singlelineedit within w_modal_mise
end type
type st_jyusyo from ivo_statictext within w_modal_mise
end type
type sle_jyusyo from ivo_singlelineedit within w_modal_mise
end type
type st_no from ivo_statictext within w_modal_mise
end type
type sle_no from ivo_singlelineedit within w_modal_mise
end type
type uo_tokui from cv_input_tokui within w_modal_mise
end type
end forward

global type w_modal_mise from iw_modal_window
integer width = 3672
integer height = 2322
string title = "店検索"
boolean immediate_retrieve = false
integer dw_height = 1442
integer dw_width = 3641
cbx_out_heiten cbx_out_heiten
sle_mise_mei sle_mise_mei
st_mise_mei st_mise_mei
st_mise_kana st_mise_kana
sle_mise_kana sle_mise_kana
st_jyusyo st_jyusyo
sle_jyusyo sle_jyusyo
st_no st_no
sle_no sle_no
uo_tokui uo_tokui
end type
global w_modal_mise w_modal_mise

type variables
// 親ウインドウとの受け渡し用構造体
str_mdlpara_mise	i_param

private string	i_tokui_code_string
private string	i_mise_mei_string
private string	i_mise_kana_string
private string	i_jyusyo_string
private string	i_no_string

end variables

on w_modal_mise.create
int iCurrent
call super::create
this.cbx_out_heiten=create cbx_out_heiten
this.sle_mise_mei=create sle_mise_mei
this.st_mise_mei=create st_mise_mei
this.st_mise_kana=create st_mise_kana
this.sle_mise_kana=create sle_mise_kana
this.st_jyusyo=create st_jyusyo
this.sle_jyusyo=create sle_jyusyo
this.st_no=create st_no
this.sle_no=create sle_no
this.uo_tokui=create uo_tokui
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_out_heiten
this.Control[iCurrent+2]=this.sle_mise_mei
this.Control[iCurrent+3]=this.st_mise_mei
this.Control[iCurrent+4]=this.st_mise_kana
this.Control[iCurrent+5]=this.sle_mise_kana
this.Control[iCurrent+6]=this.st_jyusyo
this.Control[iCurrent+7]=this.sle_jyusyo
this.Control[iCurrent+8]=this.st_no
this.Control[iCurrent+9]=this.sle_no
this.Control[iCurrent+10]=this.uo_tokui
end on

on w_modal_mise.destroy
call super::destroy
destroy(this.cbx_out_heiten)
destroy(this.sle_mise_mei)
destroy(this.st_mise_mei)
destroy(this.st_mise_kana)
destroy(this.sle_mise_kana)
destroy(this.st_jyusyo)
destroy(this.sle_jyusyo)
destroy(this.st_no)
destroy(this.sle_no)
destroy(this.uo_tokui)
end on

event update_event;call super::update_event;long	l_row

l_row							= dw_list.getrow()
i_param.out_tokui_code			= dw_list.object.tokui_code[l_row]
i_param.out_mise_code			= dw_list.object.mise_code[l_row]

// 追加
i_param.out_mise_mei_full		= dw_list.object.mise_mei_full[l_row]
i_param.out_mise_mei			= dw_list.object.mise_mei[l_row]
i_param.out_mise_mei_ryaku		= dw_list.object.mise_mei_ryaku[l_row]
i_param.out_heiten_flg			= dw_list.object.heiten_flg[l_row]
i_param.out_todofuken_code		= dw_list.object.todofuken_code[l_row]
i_param.out_sikutyoson_code		= dw_list.object.sikutyoson_code[l_row]
i_param.out_yubin_no			= dw_list.object.yubin_no[l_row]
i_param.out_jyusyo1				= dw_list.object.jyusyo1[l_row]
i_param.out_jyusyo2				= dw_list.object.jyusyo2[l_row]
i_param.out_jyusyo3				= dw_list.object.jyusyo3[l_row]
i_param.out_okuri_mei1			= dw_list.object.okuri_mei1[l_row]
i_param.out_okuri_mei2			= dw_list.object.okuri_mei2[l_row]
i_param.out_tel_no				= dw_list.object.tel_no[l_row]
i_param.out_fax_no				= dw_list.object.fax_no[l_row]
i_param.out_hensin_flg			= dw_list.object.hensin_flg[l_row]
i_param.out_unso_code			= dw_list.object.unso_code[l_row]
i_param.out_tyakuten_code		= dw_list.object.tyakuten_code[l_row]
i_param.out_tyakuten_tome_flg	= dw_list.object.tyakuten_tome_flg[l_row]
i_param.out_kobetu_haiso_flg	= dw_list.object.kobetu_haiso_flg[l_row]

closewithreturn( this, i_param )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_param	= i_msgparm.powerobjectparm

// DWにフィルタ適用
cbx_out_heiten.event clicked( )

end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// uo_tokui
uo_tokui.y	= st_upper.y + st_upper.height + code.MGN_TATE
uo_tokui.x	= dw_list.x

// cbx_out_heiten
cbx_out_heiten.y	= uo_tokui.y + uo_tokui.height / 2 - cbx_out_heiten.height / 2
cbx_out_heiten.x	= cb_retrieve.x + cb_retrieve.width - cbx_out_heiten.width

//uo_tokui.width	= cbx_out_heiten.x - uo_tokui.x - code.MGN_ITEM_YOKO
uo_tokui.width	= this.width * 0.5


/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_mise_mei
sle_mise_mei.y	= uo_tokui.y + uo_tokui.height + code.MGN_TATE

// st_mise_mei
st_mise_mei.y	= sle_mise_mei.y + sle_mise_mei.height / 2 - st_mise_mei.height / 2
st_mise_mei.x	= dw_list.x

sle_mise_mei.x	= st_mise_mei.x + st_mise_mei.width + code.MGN_GROUP_YOKO

// sle_jyusyo
sle_jyusyo.width	= this.width * 0.3	// 可変にできる？
sle_jyusyo.y	= uo_tokui.y + uo_tokui.height + code.MGN_TATE
sle_jyusyo.x	= cb_retrieve.x - sle_jyusyo.width - code.MGN_ITEM_YOKO

// st_jyusyo
st_jyusyo.y	= sle_jyusyo.y + sle_jyusyo.height / 2 - st_jyusyo.height / 2
st_jyusyo.x	= sle_jyusyo.x - st_jyusyo.width - code.MGN_GROUP_YOKO

sle_mise_mei.width	= st_jyusyo.x - sle_mise_mei.x - code.MGN_ITEM_YOKO


///*---下の段--------------------------------------------------------------------------------------*/
// sle_mise_kana
sle_mise_kana.y	= sle_mise_mei.y + sle_mise_mei.height + code.MGN_TATE

// st_mise_kana
st_mise_kana.y	= sle_mise_kana.y + sle_mise_kana.height / 2 - st_mise_mei.height / 2
st_mise_kana.x	= dw_list.x

sle_mise_kana.x	= st_mise_kana.x + st_mise_kana.width + code.MGN_GROUP_YOKO

// sle_no
sle_no.width	= this.width * 0.2	// 可変にできる？
sle_no.y	= sle_mise_mei.y + sle_mise_mei.height + code.MGN_TATE
sle_no.x	= cb_retrieve.x - sle_jyusyo.width - code.MGN_ITEM_YOKO

// st_no
st_no.y	= sle_no.y + sle_no.height / 2 - st_no.height / 2
st_no.x	= sle_no.x - st_no.width - code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y	= sle_mise_kana.y

sle_mise_kana.width	= st_no.x - sle_mise_kana.x - code.MGN_ITEM_YOKO
end event

event open;call super::open;
if len( trim( string( i_param.in_tokui_code ) ) ) > 0 then
	if i_param.in_tokui_code <> 0 then
		// ここのuo_tokuiは入力フォーム
		uo_tokui.of_set_input( string( i_param.in_tokui_code ) )
		uo_tokui.event sle_input_check()	// sleに入った値をチェックする
	else
		uo_tokui.of_set_input( "" )	// i_param.in_tokui_code = 0のときは空白を表示
	end if
end if

uo_tokui.sle_input.setfocus()
end event

event retrieve_event;call super::retrieve_event;
if dw_list.retrieve( i_tokui_code_string, i_mise_mei_string, i_mise_kana_string, i_jyusyo_string, i_no_string ) > 0 then
	dw_list.setfocus()
else
	uo_tokui.setfocus()
end if

end event

event retrieve_check;call super::retrieve_check;string	l_tokui_code
string	l_mise_mei
string	l_mise_kana
string	l_jyusyo
string	l_no
boolean	l_ret

l_ret	= false

// 得意先
l_tokui_code	= trim( uo_tokui.of_get_input( ) )

if len( l_tokui_code ) <> 0 then
	i_tokui_code_string	= l_tokui_code
	l_ret				= true
else
	setnull( i_tokui_code_string )
end if

// 店名
l_mise_mei	= trim( sle_mise_mei.text )

if len( l_mise_mei ) <> 0 then
	i_mise_mei_string	= l_mise_mei
	l_ret				= true
else
	setnull( i_mise_mei_string )
end if

// カナ名
l_mise_kana	= trim( sle_mise_kana.text )

if len( l_mise_kana ) <> 0 then
	i_mise_kana_string	= l_mise_kana
	l_ret				= true
else
	setnull( i_mise_kana_string )
end if

// 住所
l_jyusyo	= trim( sle_jyusyo.text )

if len( l_jyusyo ) <> 0 then
	i_jyusyo_string	= l_jyusyo
	l_ret			= true
else
	setnull( i_jyusyo_string )
end if

// 電話FAX
l_no	= trim( sle_no.text )
//l_no	= trim( nv_string.of_replace( sle_no.text, "-", "" ) )
//msg.of_info( l_no )

if len( l_no ) <> 0 then
	i_no_string	= l_no
	l_ret		= true
else
	setnull( i_no_string )
end if

if not l_ret then	// 入力項目に何も入力がなかったら
	msg.of_error( "値を入力してください。" )
	return -1
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within w_modal_mise
end type

type st_date from iw_modal_window`st_date within w_modal_mise
end type

type st_user_mei from iw_modal_window`st_user_mei within w_modal_mise
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_modal_mise
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_modal_mise
end type

type st_title from iw_modal_window`st_title within w_modal_mise
end type

type st_title_upper from iw_modal_window`st_title_upper within w_modal_mise
end type

type st_upper from iw_modal_window`st_upper within w_modal_mise
end type

type st_tail from iw_modal_window`st_tail within w_modal_mise
integer x = 56
integer y = 2009
integer width = 2204
end type

type cb_ok from iw_modal_window`cb_ok within w_modal_mise
integer x = 1540
integer y = 2030
integer taborder = 80
end type

type cb_cancel from iw_modal_window`cb_cancel within w_modal_mise
integer x = 1888
integer y = 2030
integer taborder = 90
end type

type dw_list from iw_modal_window`dw_list within w_modal_mise
integer x = 32
integer y = 807
integer width = 2260
integer height = 1127
integer taborder = 70
string dataobject = "d_modal_mise"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
end type

event constructor;call super::constructor;
// トランザクション
this.settransobject( cocos )


end event

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
uo_tokui.setfocus()
return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_modal_mise
integer x = 2372
integer y = 548
integer taborder = 60
end type

type cbx_out_heiten from ivo_checkbox within w_modal_mise
integer x = 2404
integer y = 206
integer width = 548
boolean bringtotop = true
string text = "閉店を含む"
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	dw_list.setfilter( "heiten_flg <> 1" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

end event

type sle_mise_mei from ivo_singlelineedit within w_modal_mise
integer x = 368
integer y = 430
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "店名を入力してください"
end type

type st_mise_mei from ivo_statictext within w_modal_mise
integer x = 36
integer y = 434
boolean bringtotop = true
string text = "店名"
alignment alignment = right!
end type

type st_mise_kana from ivo_statictext within w_modal_mise
integer x = 24
integer y = 569
boolean bringtotop = true
string text = "カナ名"
alignment alignment = right!
end type

type sle_mise_kana from ivo_singlelineedit within w_modal_mise
integer x = 356
integer y = 565
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "カナ名を入力してください"
end type

type st_jyusyo from ivo_statictext within w_modal_mise
integer x = 1208
integer y = 427
boolean bringtotop = true
string text = "住所"
alignment alignment = right!
end type

type sle_jyusyo from ivo_singlelineedit within w_modal_mise
integer x = 1540
integer y = 423
integer width = 744
integer taborder = 40
boolean bringtotop = true
string text = ""
string placeholder = "住所を入力してください"
end type

type st_no from ivo_statictext within w_modal_mise
integer x = 1172
integer y = 565
boolean bringtotop = true
string text = "電話FAX"
alignment alignment = right!
end type

type sle_no from ivo_singlelineedit within w_modal_mise
integer x = 1504
integer y = 562
integer width = 744
integer taborder = 50
boolean bringtotop = true
string text = ""
string placeholder = "番号を入力してください"
end type

type uo_tokui from cv_input_tokui within w_modal_mise
integer x = 28
integer y = 196
integer taborder = 10
boolean bringtotop = true
long backcolor = 67108864
boolean bikou_visible = false
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

