$PBExportHeader$w_modal_meisyo.srw
$PBExportComments$名称検索のモーダル
forward
global type w_modal_meisyo from iw_modal_window
end type
type sle_meisyo from ivo_singlelineedit within w_modal_meisyo
end type
type st_meisyo from ivo_statictext within w_modal_meisyo
end type
end forward

global type w_modal_meisyo from iw_modal_window
integer height = 1941
string title = "未設定"
integer dw_height = 1328
integer dw_width = 2758
sle_meisyo sle_meisyo
st_meisyo st_meisyo
end type
global w_modal_meisyo w_modal_meisyo

type variables
// 親ウインドウとの受け渡し用構造体
str_mdlpara_meisyo	i_param

private string	i_meisyo_string	// retrieveに使うパラメータ用
end variables

on w_modal_meisyo.create
int iCurrent
call super::create
this.sle_meisyo=create sle_meisyo
this.st_meisyo=create st_meisyo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_meisyo
this.Control[iCurrent+2]=this.st_meisyo
end on

on w_modal_meisyo.destroy
call super::destroy
destroy(this.sle_meisyo)
destroy(this.st_meisyo)
end on

event update_event;call super::update_event;long	l_row

l_row						= dw_list.getrow()
i_param.out_meisyo_code		= dw_list.object.meisyo_code[l_row]
i_param.out_meisyo_1		= dw_list.object.meisyo_1[l_row]
i_param.out_meisyo_2		= dw_list.object.meisyo_2[l_row]
i_param.out_meisyo_3		= dw_list.object.meisyo_3[l_row]

// 追加
i_param.out_meisyo_mei		= dw_list.object.meisyo_mei[l_row]
i_param.out_setsumei		= dw_list.object.setsumei[l_row]
i_param.out_kousin_kengen	= dw_list.object.kousin_kengen[l_row]

closewithreturn( this, i_param )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_param	= i_msgparm.powerobjectparm
end event

event resize;call super::resize;
// sle_meisyo
sle_meisyo.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_meisyo
st_meisyo.y			= sle_meisyo.y + sle_meisyo.height / 2 - st_meisyo.height / 2
st_meisyo.x			= dw_list.x

sle_meisyo.x		= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y		= sle_meisyo.y// + sle_meisyo.height + code.MGN_TATE

sle_meisyo.width	= cb_retrieve.x - sle_meisyo.x - code.MGN_ITEM_YOKO
end event

event open;call super::open;
long	l_row	// タイトル表示用

sle_meisyo.setfocus()

l_row			= dw_list.getrow()
st_title.text	= dw_list.object.meisyo_mei[l_row] + "検索"
end event

event retrieve_check;call super::retrieve_check;string l_text

l_text	= trim( sle_meisyo.text )

if len( l_text ) <> 0 then
	i_meisyo_string	= l_text
else
	setnull( i_meisyo_string )
end if
end event

event retrieve_event;call super::retrieve_event;
if dw_list.retrieve( i_param.in_meisyo_kbn, i_meisyo_string ) > 0 then
	dw_list.setfocus()
else
	sle_meisyo.setfocus()
end if
end event

type uo_signal from iw_modal_window`uo_signal within w_modal_meisyo
end type

type st_date from iw_modal_window`st_date within w_modal_meisyo
end type

type st_user_mei from iw_modal_window`st_user_mei within w_modal_meisyo
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_modal_meisyo
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_modal_meisyo
end type

type st_title from iw_modal_window`st_title within w_modal_meisyo
end type

type st_title_upper from iw_modal_window`st_title_upper within w_modal_meisyo
end type

type st_upper from iw_modal_window`st_upper within w_modal_meisyo
end type

type st_tail from iw_modal_window`st_tail within w_modal_meisyo
integer y = 1739
end type

type cb_ok from iw_modal_window`cb_ok within w_modal_meisyo
integer y = 1760
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within w_modal_meisyo
integer y = 1760
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within w_modal_meisyo
integer x = 12
integer y = 277
integer width = 2696
integer height = 1127
integer taborder = 30
string dataobject = "d_modal_meisyo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
end type

event constructor;call super::constructor;
// トランザクション
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }
end event

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_meisyo.setfocus()
return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_modal_meisyo
integer y = 156
integer taborder = 20
end type

type sle_meisyo from ivo_singlelineedit within w_modal_meisyo
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "名称を入力してください"
end type

type st_meisyo from ivo_statictext within w_modal_meisyo
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "名称"
alignment alignment = right!
end type

