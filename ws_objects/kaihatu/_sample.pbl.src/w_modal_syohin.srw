$PBExportHeader$w_modal_syohin.srw
$PBExportComments$商品検索のモーダル
forward
global type w_modal_syohin from iw_modal_window
end type
type cbx_out_haiban from ivo_checkbox within w_modal_syohin
end type
type sle_hin_ban from ivo_singlelineedit within w_modal_syohin
end type
type st_hin_ban from ivo_statictext within w_modal_syohin
end type
type st_hin_mei from ivo_statictext within w_modal_syohin
end type
type sle_hin_mei from ivo_singlelineedit within w_modal_syohin
end type
type cbx_out_bettyu from ivo_checkbox within w_modal_syohin
end type
type st_jan_code from ivo_statictext within w_modal_syohin
end type
type sle_jan_code from ivo_singlelineedit within w_modal_syohin
end type
end forward

global type w_modal_syohin from iw_modal_window
integer width = 3672
integer height = 2322
string title = "商品検索"
boolean immediate_retrieve = false
integer dw_height = 1435
integer dw_width = 4774
cbx_out_haiban cbx_out_haiban
sle_hin_ban sle_hin_ban
st_hin_ban st_hin_ban
st_hin_mei st_hin_mei
sle_hin_mei sle_hin_mei
cbx_out_bettyu cbx_out_bettyu
st_jan_code st_jan_code
sle_jan_code sle_jan_code
end type
global w_modal_syohin w_modal_syohin

type variables
// 親ウインドウとの受け渡し用構造体
str_mdlpara_syohin	i_param

private string	i_hin_ban_string
private string	i_hin_mei_string
private string	i_jan_code_string

end variables

forward prototypes
private subroutine make_filter ()
end prototypes

private subroutine make_filter ();
// チェックボックスの状態を見てフィルタをかける関数

string	l_filter
integer	l_row

l_row	= dw_list.getrow()
dw_list.setredraw( false )

if not cbx_out_haiban.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and " + "haiban_kbn = 0"
	else
		l_filter	= "haiban_kbn = 0"
	end if
end if

if not cbx_out_bettyu.checked then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and " + "bettyu_flg = 0"
	else
		l_filter	= "bettyu_flg = 0"
	end if
end if

// フィルタセット
dw_list.setfilter( l_filter )
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )














//
//integer	l_row
//
//l_row	= dw_list.getrow()
//
//dw_list.setredraw( false )
//
//if this.checked then
//	dw_list.setfilter( "" )
//else
//	dw_list.setfilter( "riyou_kikan_flg = 1 and login_kengen = 1" )
//end if
//
//// フィルタセット
//dw_list.filter()
//
//// 選択行にスクロール
//dw_list.scrolltorow( l_row )
//
//dw_list.setredraw( true )
//
end subroutine

on w_modal_syohin.create
int iCurrent
call super::create
this.cbx_out_haiban=create cbx_out_haiban
this.sle_hin_ban=create sle_hin_ban
this.st_hin_ban=create st_hin_ban
this.st_hin_mei=create st_hin_mei
this.sle_hin_mei=create sle_hin_mei
this.cbx_out_bettyu=create cbx_out_bettyu
this.st_jan_code=create st_jan_code
this.sle_jan_code=create sle_jan_code
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_out_haiban
this.Control[iCurrent+2]=this.sle_hin_ban
this.Control[iCurrent+3]=this.st_hin_ban
this.Control[iCurrent+4]=this.st_hin_mei
this.Control[iCurrent+5]=this.sle_hin_mei
this.Control[iCurrent+6]=this.cbx_out_bettyu
this.Control[iCurrent+7]=this.st_jan_code
this.Control[iCurrent+8]=this.sle_jan_code
end on

on w_modal_syohin.destroy
call super::destroy
destroy(this.cbx_out_haiban)
destroy(this.sle_hin_ban)
destroy(this.st_hin_ban)
destroy(this.st_hin_mei)
destroy(this.sle_hin_mei)
destroy(this.cbx_out_bettyu)
destroy(this.st_jan_code)
destroy(this.sle_jan_code)
end on

event update_event;call super::update_event;long	l_row

l_row							= dw_list.getrow()
i_param.out_syohin_code			= dw_list.object.syohin_code[l_row]
i_param.out_iro_no				= dw_list.object.iro_no[l_row]
i_param.out_size_mei			= dw_list.object.size_mei[l_row]

// 追加
i_param.out_size_code			= dw_list.object.size_code[l_row]
i_param.out_sku_code			= dw_list.object.sku_code[l_row]
i_param.out_hin_ban				= dw_list.object.hin_ban[l_row]
i_param.out_hin_mei				= dw_list.object.hin_mei[l_row]
i_param.out_iro_mei				= dw_list.object.iro_mei[l_row]
i_param.out_hi_toriatukai_flg	= dw_list.object.hi_toriatukai_flg[l_row]
i_param.out_bumon_code			= dw_list.object.bumon_code[l_row]
i_param.out_kyoyo_kbn			= dw_list.object.kyoyo_kbn[l_row]
i_param.out_brand_code			= dw_list.object.brand_code[l_row]
i_param.out_subbrand_code		= dw_list.object.subbrand_code[l_row]
i_param.out_season_code			= dw_list.object.season_code[l_row]
i_param.out_daibunrui_code		= dw_list.object.daibunrui_code[l_row]
i_param.out_tyubunrui_code		= dw_list.object.tyubunrui_code[l_row]
i_param.out_syobunrui_code		= dw_list.object.syobunrui_code[l_row]
i_param.out_group_code			= dw_list.object.group_code[l_row]
i_param.out_seriese_code		= dw_list.object.seriese_code[l_row]
i_param.out_iro_keitou_code		= dw_list.object.iro_keitou_code[l_row]
i_param.out_zaiko_kanri_flg		= dw_list.object.zaiko_kanri_flg[l_row]
i_param.out_bhin_flg			= dw_list.object.bhin_flg[l_row]

closewithreturn( this, i_param )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_param	= i_msgparm.powerobjectparm

// DWにフィルタ適用
make_filter( )

end event

event resize;call super::resize;
/*---上の段--------------------------------------------------------------------------------------*/
// sle_hin_ban
sle_hin_ban.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_hin_ban
st_hin_ban.y		= sle_hin_ban.y + sle_hin_ban.height / 2 - st_hin_ban.height / 2
st_hin_ban.x		= dw_list.x

sle_hin_ban.x		= st_hin_ban.x + st_hin_ban.width + code.MGN_GROUP_YOKO

// cbx_out_haiban
cbx_out_haiban.y	= sle_hin_ban.y + sle_hin_ban.height / 2 - cbx_out_haiban.height / 2
cbx_out_haiban.x	= cb_retrieve.x + cb_retrieve.width - cbx_out_haiban.width

//sle_hin_ban.width	= cbx_out_haiban.x - sle_hin_ban.x - code.MGN_ITEM_YOKO
sle_hin_ban.width	= this.width * 0.1

/*---真ん中の段----------------------------------------------------------------------------------*/
// sle_hin_mei
sle_hin_mei.y		= sle_hin_ban.y + sle_hin_ban.height + code.MGN_TATE

// st_hin_mei
st_hin_mei.y		= sle_hin_mei.y + sle_hin_mei.height / 2 - st_hin_mei.height / 2
st_hin_mei.x		= dw_list.x

sle_hin_mei.x		= st_hin_mei.x + st_hin_mei.width + code.MGN_GROUP_YOKO

// cbx_out_bettyu
cbx_out_bettyu.y	= sle_hin_mei.y + sle_hin_mei.height / 2 - cbx_out_bettyu.height / 2
cbx_out_bettyu.x	= cb_retrieve.x + cb_retrieve.width - cbx_out_bettyu.width

//sle_hin_mei.width	= cbx_out_bettyu.x - sle_hin_mei.x - code.MGN_ITEM_YOKO
sle_hin_mei.width	= this.width * 0.3

/*---下の段--------------------------------------------------------------------------------------*/
// sle_jan_code
sle_jan_code.y		= sle_hin_mei.y + sle_hin_mei.height + code.MGN_TATE

// st_jan_code
st_jan_code.y		= sle_jan_code.y + sle_jan_code.height / 2 - st_jan_code.height / 2
st_jan_code.x		= dw_list.x

sle_jan_code.x		= st_jan_code.x + st_jan_code.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_jan_code.y

//sle_jan_code.width	= cb_retrieve.x - sle_jan_code.x - code.MGN_ITEM_YOKO
sle_jan_code.width	= this.width * 0.1
end event

event open;call super::open;
sle_hin_ban.setfocus()
end event

event retrieve_event;call super::retrieve_event;
if dw_list.retrieve( i_hin_ban_string, i_hin_mei_string, i_jan_code_string ) > 0 then
	dw_list.setfocus()
else
	sle_hin_ban.setfocus()
end if
end event

event retrieve_check;call super::retrieve_check;string	l_hin_ban
string	l_hin_mei
string	l_jan_code
boolean	l_ret

l_ret	= false

// 品番
l_hin_ban	= trim( sle_hin_ban.text )

if len( l_hin_ban ) <> 0 then
	i_hin_ban_string	= l_hin_ban
	l_ret				= true
else
	setnull( i_hin_ban_string )
end if

// 品名
l_hin_mei	= trim( sle_hin_mei.text )

if len( l_hin_mei ) <> 0 then
	i_hin_mei_string	= l_hin_mei
	l_ret				= true
else
	setnull( i_hin_mei_string )
end if

// JANコード
l_jan_code	= trim( sle_jan_code.text )

if len( l_jan_code ) <> 0 then
	i_jan_code_string	= l_jan_code
	l_ret				= true
else
	setnull( i_jan_code_string )
end if

if not l_ret then	// 入力項目に何も入力がなかったら
	msg.of_error( "値を入力してください。" )
	return -1
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within w_modal_syohin
end type

type st_date from iw_modal_window`st_date within w_modal_syohin
end type

type st_user_mei from iw_modal_window`st_user_mei within w_modal_syohin
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_modal_syohin
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_modal_syohin
end type

type st_title from iw_modal_window`st_title within w_modal_syohin
end type

type st_title_upper from iw_modal_window`st_title_upper within w_modal_syohin
end type

type st_upper from iw_modal_window`st_upper within w_modal_syohin
end type

type st_tail from iw_modal_window`st_tail within w_modal_syohin
integer x = 56
integer y = 2009
integer width = 2204
end type

type cb_ok from iw_modal_window`cb_ok within w_modal_syohin
integer x = 1540
integer y = 2030
integer taborder = 60
end type

type cb_cancel from iw_modal_window`cb_cancel within w_modal_syohin
integer x = 1888
integer y = 2030
integer taborder = 70
end type

type dw_list from iw_modal_window`dw_list within w_modal_syohin
integer x = 32
integer y = 807
integer width = 2260
integer height = 1127
integer taborder = 50
string dataobject = "d_modal_syohin"
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
sle_hin_ban.setfocus()
return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_modal_syohin
integer x = 1900
integer y = 555
integer taborder = 40
end type

type cbx_out_haiban from ivo_checkbox within w_modal_syohin
integer x = 1844
integer y = 153
integer width = 488
boolean bringtotop = true
string text = "廃番を含む"
end type

event clicked;call super::clicked;
make_filter( )
end event

type sle_hin_ban from ivo_singlelineedit within w_modal_syohin
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "品番を入力"
end type

type st_hin_ban from ivo_statictext within w_modal_syohin
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "品番"
alignment alignment = right!
end type

type st_hin_mei from ivo_statictext within w_modal_syohin
integer x = 32
integer y = 284
boolean bringtotop = true
string text = "品名"
alignment alignment = right!
end type

type sle_hin_mei from ivo_singlelineedit within w_modal_syohin
integer x = 364
integer y = 281
integer width = 744
integer taborder = 20
boolean bringtotop = true
string text = ""
string placeholder = "品名を入力"
end type

type cbx_out_bettyu from ivo_checkbox within w_modal_syohin
integer x = 1844
integer y = 277
integer width = 488
boolean bringtotop = true
string text = "別注を含む"
boolean checked = true
end type

event clicked;call super::clicked;
make_filter( )
end event

type st_jan_code from ivo_statictext within w_modal_syohin
integer x = 32
integer y = 430
boolean bringtotop = true
string text = "JANコード"
alignment alignment = right!
end type

type sle_jan_code from ivo_singlelineedit within w_modal_syohin
integer x = 364
integer y = 427
integer width = 744
integer taborder = 30
boolean bringtotop = true
string text = ""
string placeholder = "JANコードを入力"
end type

