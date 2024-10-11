$PBExportHeader$w_modal_tokui.srw
$PBExportComments$得意先検索のモーダル
forward
global type w_modal_tokui from iw_modal_window
end type
type cbx_out_torihiki from ivo_checkbox within w_modal_tokui
end type
type sle_tokui_mei from ivo_singlelineedit within w_modal_tokui
end type
type st_tokui_mei from ivo_statictext within w_modal_tokui
end type
type st_tokui_kana from ivo_statictext within w_modal_tokui
end type
type sle_tokui_kana from ivo_singlelineedit within w_modal_tokui
end type
type st_jyusyo from ivo_statictext within w_modal_tokui
end type
type sle_jyusyo from ivo_singlelineedit within w_modal_tokui
end type
type st_no from ivo_statictext within w_modal_tokui
end type
type sle_no from ivo_singlelineedit within w_modal_tokui
end type
end forward

global type w_modal_tokui from iw_modal_window
integer width = 3672
integer height = 2322
string title = "得意先検索"
boolean immediate_retrieve = false
integer dw_height = 1442
integer dw_width = 3929
cbx_out_torihiki cbx_out_torihiki
sle_tokui_mei sle_tokui_mei
st_tokui_mei st_tokui_mei
st_tokui_kana st_tokui_kana
sle_tokui_kana sle_tokui_kana
st_jyusyo st_jyusyo
sle_jyusyo sle_jyusyo
st_no st_no
sle_no sle_no
end type
global w_modal_tokui w_modal_tokui

type variables
// 親ウインドウとの受け渡し用構造体
str_mdlpara_tokui	i_param

private string	i_tokui_mei_string
private string	i_tokui_kana_string
private string	i_jyusyo_string
private string	i_no_string

end variables

on w_modal_tokui.create
int iCurrent
call super::create
this.cbx_out_torihiki=create cbx_out_torihiki
this.sle_tokui_mei=create sle_tokui_mei
this.st_tokui_mei=create st_tokui_mei
this.st_tokui_kana=create st_tokui_kana
this.sle_tokui_kana=create sle_tokui_kana
this.st_jyusyo=create st_jyusyo
this.sle_jyusyo=create sle_jyusyo
this.st_no=create st_no
this.sle_no=create sle_no
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_out_torihiki
this.Control[iCurrent+2]=this.sle_tokui_mei
this.Control[iCurrent+3]=this.st_tokui_mei
this.Control[iCurrent+4]=this.st_tokui_kana
this.Control[iCurrent+5]=this.sle_tokui_kana
this.Control[iCurrent+6]=this.st_jyusyo
this.Control[iCurrent+7]=this.sle_jyusyo
this.Control[iCurrent+8]=this.st_no
this.Control[iCurrent+9]=this.sle_no
end on

on w_modal_tokui.destroy
call super::destroy
destroy(this.cbx_out_torihiki)
destroy(this.sle_tokui_mei)
destroy(this.st_tokui_mei)
destroy(this.st_tokui_kana)
destroy(this.sle_tokui_kana)
destroy(this.st_jyusyo)
destroy(this.sle_jyusyo)
destroy(this.st_no)
destroy(this.sle_no)
end on

event update_event;call super::update_event;long	l_row

l_row						= dw_list.getrow()
i_param.out_tokui_code		= dw_list.object.m_tokui_tokui_code[l_row]

// 追加
i_param.out_tokui_mei_full	= dw_list.object.m_tokui_tokui_mei_full[l_row]
i_param.out_tokui_mei		= dw_list.object.m_tokui_tokui_mei[l_row]
i_param.out_tokui_mei_ryaku	= dw_list.object.m_tokui_tokui_mei_ryaku[l_row]
i_param.out_tokui_mei_kana	= dw_list.object.m_tokui_tokui_mei_kana[l_row]
i_param.out_tokui_kbn		= dw_list.object.m_tokui_tokui_kbn[l_row]
i_param.out_gyotai_kbn		= dw_list.object.m_tokui_gyotai_kbn[l_row]
i_param.out_syokuti_flg		= dw_list.object.m_tokui_syokuti_flg[l_row]
i_param.out_torihiki_code	= dw_list.object.m_tokui_torihiki_code[l_row]
i_param.out_jigyosya_code	= dw_list.object.m_tokui_jigyosya_code[l_row]
i_param.out_houjin_no		= dw_list.object.m_tokui_houjin_no[l_row]
i_param.out_bumon_code		= dw_list.object.m_tokui_bumon_code[l_row]
i_param.out_tanto_code		= dw_list.object.m_tokui_tanto_code[l_row]
i_param.out_nayose_code		= dw_list.object.m_tokui_nayose_code[l_row]
i_param.out_nayose_eda		= dw_list.object.m_tokui_nayose_eda[l_row]
i_param.out_todofuken_code	= dw_list.object.m_tokui_todofuken_code[l_row]
i_param.out_sikutyoson_code	= dw_list.object.m_tokui_sikutyoson_code[l_row]
i_param.out_yubin_no		= dw_list.object.m_tokui_yubin_no[l_row]
i_param.out_jyusyo			= dw_list.object.m_tokui_jyusyo[l_row]
i_param.out_tel_no			= dw_list.object.m_tokui_tel_no[l_row]
i_param.out_fax_no			= dw_list.object.m_tokui_fax_no[l_row]

closewithreturn( this, i_param )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_param	= i_msgparm.powerobjectparm

// DWにフィルタ適用
cbx_out_torihiki.event clicked( )

end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// sle_tokui_mei
sle_tokui_mei.y			= st_upper.y + st_upper.height + code.MGN_TATE

// st_tokui_mei
st_tokui_mei.y			= sle_tokui_mei.y + sle_tokui_mei.height / 2 - st_tokui_mei.height / 2
st_tokui_mei.x			= dw_list.x

sle_tokui_mei.x			= st_tokui_mei.x + st_tokui_mei.width + code.MGN_GROUP_YOKO

// cbx_out_torihiki
cbx_out_torihiki.y		= sle_tokui_mei.y + sle_tokui_mei.height / 2 - st_tokui_mei.height / 2
cbx_out_torihiki.x		= cb_retrieve.x + cb_retrieve.width - cbx_out_torihiki.width


/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_tokui_kana
sle_tokui_kana.y		= sle_tokui_mei.y + sle_tokui_mei.height + code.MGN_TATE

// st_tokui_kana
st_tokui_kana.y			= sle_tokui_kana.y + sle_tokui_kana.height / 2 - st_tokui_kana.height / 2
st_tokui_kana.x			= dw_list.x

sle_tokui_kana.x		= st_tokui_kana.x + st_tokui_kana.width + code.MGN_GROUP_YOKO


///*---下の段--------------------------------------------------------------------------------------*/
// sle_jyusyo
sle_jyusyo.y			= sle_tokui_kana.y + sle_tokui_kana.height + code.MGN_TATE

// st_jyusyo
st_jyusyo.y				= sle_jyusyo.y + sle_jyusyo.height / 2 - st_jyusyo.height / 2
st_jyusyo.x				= dw_list.x

sle_jyusyo.x			= st_jyusyo.x + st_jyusyo.width + code.MGN_GROUP_YOKO

// sle_no
sle_no.width			= this.width * 0.2
sle_no.y				= sle_tokui_kana.y + sle_tokui_kana.height + code.MGN_TATE
sle_no.x				= cb_retrieve.x - sle_no.width - code.MGN_ITEM_YOKO

// st_no
st_no.y					= sle_no.y + sle_no.height / 2 - st_no.height / 2
st_no.x					= sle_no.x - st_no.width - code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_jyusyo.y

// 最後にwidthを合わせる
sle_jyusyo.width		= st_no.x - sle_jyusyo.x - code.MGN_ITEM_YOKO
sle_tokui_mei.width		= st_no.x - sle_jyusyo.x - code.MGN_ITEM_YOKO
sle_tokui_kana.width	= st_no.x - sle_jyusyo.x - code.MGN_ITEM_YOKO
end event

event open;call super::open;
sle_tokui_mei.setfocus()
end event

event retrieve_event;call super::retrieve_event;
if dw_list.retrieve( i_tokui_mei_string, i_tokui_kana_string, i_jyusyo_string, i_no_string ) > 0 then
	dw_list.setfocus()
else
	sle_tokui_mei.setfocus()
end if

end event

event retrieve_check;call super::retrieve_check;string	l_tokui_mei
string	l_tokui_kana
string	l_jyusyo
string	l_no
boolean	l_ret

l_ret	= false

// 得意先名
l_tokui_mei	= trim( sle_tokui_mei.text )

if len( l_tokui_mei ) <> 0 then
	i_tokui_mei_string	= l_tokui_mei
	l_ret				= true
else
	setnull( i_tokui_mei_string )
end if

// カナ名
l_tokui_kana	= trim( sle_tokui_kana.text )

if len( l_tokui_kana ) <> 0 then
	i_tokui_kana_string	= l_tokui_kana
	l_ret				= true
else
	setnull( i_tokui_kana_string )
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
// とりあえずそのまま表示する
//l_no	= trim( strg.of_replace( sle_no.text, "-", "" ) )
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

type uo_signal from iw_modal_window`uo_signal within w_modal_tokui
end type

type st_date from iw_modal_window`st_date within w_modal_tokui
end type

type st_user_mei from iw_modal_window`st_user_mei within w_modal_tokui
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_modal_tokui
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_modal_tokui
end type

type st_title from iw_modal_window`st_title within w_modal_tokui
end type

type st_title_upper from iw_modal_window`st_title_upper within w_modal_tokui
end type

type st_upper from iw_modal_window`st_upper within w_modal_tokui
end type

type st_tail from iw_modal_window`st_tail within w_modal_tokui
integer x = 56
integer y = 2009
integer width = 2204
end type

type cb_ok from iw_modal_window`cb_ok within w_modal_tokui
integer x = 1540
integer y = 2030
integer taborder = 70
end type

type cb_cancel from iw_modal_window`cb_cancel within w_modal_tokui
integer x = 1888
integer y = 2030
integer taborder = 80
end type

type dw_list from iw_modal_window`dw_list within w_modal_tokui
integer x = 32
integer y = 807
integer width = 2260
integer height = 1127
integer taborder = 60
string dataobject = "d_modal_tokui"
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
sle_tokui_mei.setfocus()
return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_modal_tokui
integer x = 2376
integer y = 412
integer taborder = 50
end type

type cbx_out_torihiki from ivo_checkbox within w_modal_tokui
integer x = 2164
integer y = 160
integer width = 548
boolean bringtotop = true
string text = "取引停止先を含む"
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	dw_list.setfilter( "m_tokui_torihiki_teisi_kbn <> 2" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

end event

type sle_tokui_mei from ivo_singlelineedit within w_modal_tokui
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "得意先名を入力してください"
end type

type st_tokui_mei from ivo_statictext within w_modal_tokui
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "得意先名"
alignment alignment = right!
end type

type st_tokui_kana from ivo_statictext within w_modal_tokui
integer x = 32
integer y = 284
boolean bringtotop = true
string text = "カナ名"
alignment alignment = right!
end type

type sle_tokui_kana from ivo_singlelineedit within w_modal_tokui
integer x = 364
integer y = 281
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "カナ名を入力してください"
end type

type st_jyusyo from ivo_statictext within w_modal_tokui
integer x = 32
integer y = 430
boolean bringtotop = true
string text = "住所"
alignment alignment = right!
end type

type sle_jyusyo from ivo_singlelineedit within w_modal_tokui
integer x = 364
integer y = 427
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "住所を入力してください"
end type

type st_no from ivo_statictext within w_modal_tokui
integer x = 1176
integer y = 430
boolean bringtotop = true
string text = "電話FAX"
alignment alignment = right!
end type

type sle_no from ivo_singlelineedit within w_modal_tokui
integer x = 1508
integer y = 427
integer width = 744
integer taborder = 40
boolean bringtotop = true
string text = ""
string placeholder = "番号を入力してください"
end type

