$PBExportHeader$wsm_tyakuten.srw
$PBExportComments$着店検索のモーダル
forward
global type wsm_tyakuten from iw_modal_window
end type
type st_mise from ivo_statictext within wsm_tyakuten
end type
type st_unso from ivo_statictext within wsm_tyakuten
end type
type st_yubin from ivo_statictext within wsm_tyakuten
end type
type st_mise_code from sv_st_meisyo within wsm_tyakuten
end type
type st_mise_mei from sv_st_meisyo within wsm_tyakuten
end type
type st_unso_mei from sv_st_meisyo within wsm_tyakuten
end type
type st_yubin_no from sv_st_meisyo within wsm_tyakuten
end type
end forward

global type wsm_tyakuten from iw_modal_window
integer height = 1490
string title = "着店選択"
integer dw_height = 1382
integer dw_width = 2873
st_mise st_mise
st_unso st_unso
st_yubin st_yubin
st_mise_code st_mise_code
st_mise_mei st_mise_mei
st_unso_mei st_unso_mei
st_yubin_no st_yubin_no
end type
global wsm_tyakuten wsm_tyakuten

type variables

public:
	str_mdlpara_mtyakuten	i_mdl_tyakuten	// 親ウインドウとの受け渡し用構造体

private:
	str_mtyakuten			i_para_reset[]	// i_mdl_tyakuten.retの初期化用
end variables

on wsm_tyakuten.create
int iCurrent
call super::create
this.st_mise=create st_mise
this.st_unso=create st_unso
this.st_yubin=create st_yubin
this.st_mise_code=create st_mise_code
this.st_mise_mei=create st_mise_mei
this.st_unso_mei=create st_unso_mei
this.st_yubin_no=create st_yubin_no
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_mise
this.Control[iCurrent+2]=this.st_unso
this.Control[iCurrent+3]=this.st_yubin
this.Control[iCurrent+4]=this.st_mise_code
this.Control[iCurrent+5]=this.st_mise_mei
this.Control[iCurrent+6]=this.st_unso_mei
this.Control[iCurrent+7]=this.st_yubin_no
end on

on wsm_tyakuten.destroy
call super::destroy
destroy(this.st_mise)
destroy(this.st_unso)
destroy(this.st_yubin)
destroy(this.st_mise_code)
destroy(this.st_mise_mei)
destroy(this.st_unso_mei)
destroy(this.st_yubin_no)
end on

event retrieve_event;call super::retrieve_event;
integer	l_unso_code
string	l_yubin_no

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
// 運送便コード
l_unso_code	= i_mdl_tyakuten.in_unso_code

// 郵便番号
l_yubin_no	= trim( i_mdl_tyakuten.in_yubin_no )

dw_list.retrieve( l_unso_code, l_yubin_no )
dw_list.setfocus()

return 0
end event

event openquery;call super::openquery;
long		l_tokui_code, l_mise_code
integer		l_unso_code
string		l_yubin_no
nv_master	mst
str_mmise	l_mise[]
str_munso	l_unso[]

// 親ウインドウからのパラメータを変数に格納
i_mdl_tyakuten		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_tyakuten.ret	= i_para_reset

// inパラメータは必ずセットされる
l_tokui_code	= i_mdl_tyakuten.in_tokui_code
l_mise_code		= i_mdl_tyakuten.in_mise_code
l_unso_code		= i_mdl_tyakuten.in_unso_code
l_yubin_no		= trim( i_mdl_tyakuten.in_yubin_no )

// 店情報の取得と名称のセット
if mst.of_mise_get( l_tokui_code, l_mise_code, l_mise ) > 0 then
	st_mise_code.text	= string( l_mise[1].mise_code )
	st_mise_mei.text	= l_mise[1].mise_mei
end if

// 運送便情報の取得と名称のセット
if mst.of_unso_get( l_unso_code, l_unso ) > 0 then
	st_unso_mei.text	= l_unso[1].unso_mei
end if

st_yubin_no.text	= trim( l_yubin_no )
end event

event resize;call super::resize;
/*---1段目--------------------------------------------------------------------------------------*/
// st_mise
st_mise.y	= st_upper.y + st_upper.height + code.MGN_TATE
st_mise.x	= dw_list.x

// st_mise_code
st_mise_code.y	= st_mise.y
st_mise_code.x	= st_mise.x + st_mise.width + code.MGN_GROUP_YOKO

// st_mise_mei
st_mise_mei.y	= st_mise.y
st_mise_mei.x	= st_mise_code.x + st_mise_code.width + code.MGN_GROUP_YOKO

/*---2段目--------------------------------------------------------------------------------------*/
// st_unso
st_unso.y	= st_mise.y + st_mise.height + code.MGN_TATE
st_unso.x	= dw_list.x

// st_unso_mei
st_unso_mei.y	= st_unso.y
st_unso_mei.x	= st_unso.x + st_unso.width + code.MGN_GROUP_YOKO

/*---3段目--------------------------------------------------------------------------------------*/
// st_yubin
st_yubin.y	= st_unso.y + st_unso.height + code.MGN_TATE
st_yubin.x	= dw_list.x

// st_yubin_no
st_yubin_no.y	= st_yubin.y
st_yubin_no.x	= st_yubin.x + st_yubin.width + code.MGN_GROUP_YOKO

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_tyakuten.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_tyakuten.ret[l_index].data_kbn			= dw_list.object.data_kbn[l_row]
i_mdl_tyakuten.ret[l_index].unso_code			= dw_list.object.unso_code[l_row]
i_mdl_tyakuten.ret[l_index].yubin_no			= dw_list.object.yubin_no[l_row]
i_mdl_tyakuten.ret[l_index].jyusyo				= dw_list.object.jyusyo[l_row]
i_mdl_tyakuten.ret[l_index].tyakuten_code		= dw_list.object.tyakuten_code[l_row]
i_mdl_tyakuten.ret[l_index].tyakuten_code_tome	= dw_list.object.tyakuten_code_tome[l_row]
i_mdl_tyakuten.ret[l_index].hanyo_col_1			= dw_list.object.hanyo_col_1[l_row]
i_mdl_tyakuten.ret[l_index].hanyo_col_2			= dw_list.object.hanyo_col_2[l_row]
i_mdl_tyakuten.ret[l_index].hanyo_col_3			= dw_list.object.hanyo_col_3[l_row]
i_mdl_tyakuten.ret[l_index].hanyo_col_4			= dw_list.object.hanyo_col_4[l_row]
i_mdl_tyakuten.ret[l_index].hanyo_col_5			= dw_list.object.hanyo_col_5[l_row]
i_mdl_tyakuten.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_tyakuten.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_tyakuten.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_tyakuten.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_tyakuten.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_tyakuten.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_tyakuten.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_tyakuten.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_tyakuten.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_tyakuten.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_tyakuten.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_tyakuten.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_tyakuten.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_tyakuten )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_tyakuten
end type

type st_date from iw_modal_window`st_date within wsm_tyakuten
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_tyakuten
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_tyakuten
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_tyakuten
end type

type st_title from iw_modal_window`st_title within wsm_tyakuten
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_tyakuten
end type

type st_upper from iw_modal_window`st_upper within wsm_tyakuten
end type

type st_tail from iw_modal_window`st_tail within wsm_tyakuten
integer y = 1298
end type

type cb_ok from iw_modal_window`cb_ok within wsm_tyakuten
integer y = 1305
integer taborder = 20
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_tyakuten
integer y = 1305
integer taborder = 30
end type

type dw_list from iw_modal_window`dw_list within wsm_tyakuten
integer x = 284
integer y = 793
integer taborder = 10
string dataobject = "dsm_tyakuten"
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

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_tyakuten
boolean visible = false
integer x = 1148
integer y = 153
integer taborder = 0
boolean enabled = false
end type

type st_mise from ivo_statictext within wsm_tyakuten
integer x = 168
integer y = 356
boolean bringtotop = true
string text = "店"
alignment alignment = right!
end type

type st_unso from ivo_statictext within wsm_tyakuten
integer x = 168
integer y = 505
boolean bringtotop = true
string text = "運送便名"
alignment alignment = right!
end type

type st_yubin from ivo_statictext within wsm_tyakuten
integer x = 168
integer y = 640
boolean bringtotop = true
string text = "郵便番号"
alignment alignment = right!
end type

type st_mise_code from sv_st_meisyo within wsm_tyakuten
integer x = 536
integer y = 348
boolean bringtotop = true
string text = ""
alignment alignment = right!
end type

type st_mise_mei from sv_st_meisyo within wsm_tyakuten
integer x = 924
integer y = 356
integer width = 1600
boolean bringtotop = true
string text = ""
end type

type st_unso_mei from sv_st_meisyo within wsm_tyakuten
integer x = 568
integer y = 491
integer width = 900
boolean bringtotop = true
string text = ""
end type

type st_yubin_no from sv_st_meisyo within wsm_tyakuten
integer x = 588
integer y = 629
integer width = 332
boolean bringtotop = true
string text = ""
end type

