$PBExportHeader$wsm_jyutyu_number.srw
forward
global type wsm_jyutyu_number from iw_main_window
end type
type sle_jyutyu_date_from_t from ivo_statictext within wsm_jyutyu_number
end type
type sle_jyutyu_date_from from ivo_singlelineedit within wsm_jyutyu_number
end type
type sle_jyutyu_date_to_t from ivo_statictext within wsm_jyutyu_number
end type
type sle_jyutyu_date_to from ivo_singlelineedit within wsm_jyutyu_number
end type
type cbx_kanryo_flg from ivo_checkbox within wsm_jyutyu_number
end type
type uo_tokui from cv_input_tokui within wsm_jyutyu_number
end type
type uo_mise from cv_input_mise within wsm_jyutyu_number
end type
type uo_user from cv_input_user within wsm_jyutyu_number
end type
type st_aite_no from ivo_statictext within wsm_jyutyu_number
end type
type sle_aite_no from ivo_singlelineedit within wsm_jyutyu_number
end type
type st_jyutyu_hoho from ivo_statictext within wsm_jyutyu_number
end type
type ddplb_jyutyu_hoho_kbn from sv_ddplb_meisyo within wsm_jyutyu_number
end type
type dw_list from ivo_datawindow within wsm_jyutyu_number
end type
end forward

global type wsm_jyutyu_number from iw_main_window
string title = "受注番号検索"
sle_jyutyu_date_from_t sle_jyutyu_date_from_t
sle_jyutyu_date_from sle_jyutyu_date_from
sle_jyutyu_date_to_t sle_jyutyu_date_to_t
sle_jyutyu_date_to sle_jyutyu_date_to
cbx_kanryo_flg cbx_kanryo_flg
uo_tokui uo_tokui
uo_mise uo_mise
uo_user uo_user
st_aite_no st_aite_no
sle_aite_no sle_aite_no
st_jyutyu_hoho st_jyutyu_hoho
ddplb_jyutyu_hoho_kbn ddplb_jyutyu_hoho_kbn
dw_list dw_list
end type
global wsm_jyutyu_number wsm_jyutyu_number

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str

	// 呼出し部の情報を保管
	long	i_jyutyu_date_from
	long	i_jyutyu_date_to
	string i_syori_kbn
end variables

on wsm_jyutyu_number.create
int iCurrent
call super::create
this.sle_jyutyu_date_from_t=create sle_jyutyu_date_from_t
this.sle_jyutyu_date_from=create sle_jyutyu_date_from
this.sle_jyutyu_date_to_t=create sle_jyutyu_date_to_t
this.sle_jyutyu_date_to=create sle_jyutyu_date_to
this.cbx_kanryo_flg=create cbx_kanryo_flg
this.uo_tokui=create uo_tokui
this.uo_mise=create uo_mise
this.uo_user=create uo_user
this.st_aite_no=create st_aite_no
this.sle_aite_no=create sle_aite_no
this.st_jyutyu_hoho=create st_jyutyu_hoho
this.ddplb_jyutyu_hoho_kbn=create ddplb_jyutyu_hoho_kbn
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_jyutyu_date_from_t
this.Control[iCurrent+2]=this.sle_jyutyu_date_from
this.Control[iCurrent+3]=this.sle_jyutyu_date_to_t
this.Control[iCurrent+4]=this.sle_jyutyu_date_to
this.Control[iCurrent+5]=this.cbx_kanryo_flg
this.Control[iCurrent+6]=this.uo_tokui
this.Control[iCurrent+7]=this.uo_mise
this.Control[iCurrent+8]=this.uo_user
this.Control[iCurrent+9]=this.st_aite_no
this.Control[iCurrent+10]=this.sle_aite_no
this.Control[iCurrent+11]=this.st_jyutyu_hoho
this.Control[iCurrent+12]=this.ddplb_jyutyu_hoho_kbn
this.Control[iCurrent+13]=this.dw_list
end on

on wsm_jyutyu_number.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_jyutyu_date_from_t)
destroy(this.sle_jyutyu_date_from)
destroy(this.sle_jyutyu_date_to_t)
destroy(this.sle_jyutyu_date_to)
destroy(this.cbx_kanryo_flg)
destroy(this.uo_tokui)
destroy(this.uo_mise)
destroy(this.uo_user)
destroy(this.st_aite_no)
destroy(this.sle_aite_no)
destroy(this.st_jyutyu_hoho)
destroy(this.ddplb_jyutyu_hoho_kbn)
destroy(this.dw_list)
end on

event resize;call super::resize;// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

//st_second_upper.height	= 821
//cb_retrieve.y			= 836

st_second_upper.height	= 470


// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y
long l_row_4_y

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
uo_tokui.y				= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + uo_tokui.height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_mise.y			= l_row_2_y

// 3行目
l_row_3_y	= l_row_2_y + uo_mise.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_jyutyu_hoho.y		= l_row_3_y
ddplb_jyutyu_hoho_kbn.y		= l_row_3_y
uo_user.y		= l_row_3_y
st_aite_no.y		= l_row_3_y
sle_aite_no.y		= l_row_3_y

// 4行目
l_row_4_y	= l_row_3_y + sle_jyutyu_date_from.height + code.MGN_UPPER_TATE_GAP	// 4行目「MGN_UPPER_TATE_GAP:11」
sle_jyutyu_date_from_t.y		= l_row_4_y + 7
sle_jyutyu_date_from.y		= l_row_4_y
sle_jyutyu_date_to_t.y		= l_row_4_y + 7
sle_jyutyu_date_to.y		= l_row_4_y
cbx_kanryo_flg.y		= l_row_4_y

// st_second_upper高さ
//st_second_upper.height	= l_row_4_y + sle_jyutyu_date_from.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
//dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
//dw_list.x				= code.MGN_YOKO
//dw_list.width			= newwidth - code.MGN_YOKO * 2
//dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event retrieve_event;call super::retrieve_event;string  l_sql_old, l_sql_new, l_sql_where

long    l_tokui_code

// 検索条件の取得
l_tokui_code = uo_tokui.of_get_tokui_code()

// 元のSQLを取得
l_sql_old = dw_list.getsqlselect()

// 条件の初期化
l_sql_where = ""

// 得意先コードの条件を作成
if l_tokui_code <> -1 then
    l_sql_where += "d_jyutyu.tokui_code = " + string( l_tokui_code )
end if

// 元のSQLに"where"が存在するか確認
boolean lb_has_where
lb_has_where = Pos( Lower( l_sql_old ), " where " ) > 0

// 条件の接続詞を設定
if l_sql_where <> "" then
    if lb_has_where then
        l_sql_where = " and " + l_sql_where
    else
        l_sql_where = " where " + l_sql_where
    end if
end if

// 元のSQLに"order by"が存在するか確認
long ll_order_by_pos
ll_order_by_pos = LastPos( Lower( l_sql_old ), " order by " )

// 新しいSQLを構築
if ll_order_by_pos > 0 then
    // "order by"が存在する場合
    l_sql_new = Mid( l_sql_old, 1, ll_order_by_pos - 1 ) + l_sql_where + code.crlf + Mid( l_sql_old, ll_order_by_pos )
else
    // "order by"が存在しない場合
    l_sql_new = l_sql_old + l_sql_where
end if

// デバッグ用メッセージボックス
MessageBox("Debug: 新しいSQL", l_sql_new)

// データウィンドウの設定と検索
dw_list.reset()
dw_list.setsqlselect( l_sql_new )

if dw_list.retrieve() = 0 then
    // 検索結果がない場合、元のSQLに戻す
    dw_list.setsqlselect( l_sql_old )
    msg.of_error( "検索されたデータはありません。" )
    return -1
end if

// 検索後、元のSQLに戻す
dw_list.setsqlselect( l_sql_old )
dw_list.setfocus()

end event

event retrieve_check;call super::retrieve_check;// Retrieve前の事前チェック

// 得意先
// 空の場合falseが返ってくるので空の場合だけチェックする
if uo_tokui.of_get_input( ) <> "" AND not uo_tokui.event sle_input_check( ) then
	return -1
end if
end event

type uo_signal from iw_main_window`uo_signal within wsm_jyutyu_number
end type

type st_date from iw_main_window`st_date within wsm_jyutyu_number
end type

type st_user_mei from iw_main_window`st_user_mei within wsm_jyutyu_number
end type

type uo_test_mode from iw_main_window`uo_test_mode within wsm_jyutyu_number
end type

type p_size_adjust from iw_main_window`p_size_adjust within wsm_jyutyu_number
end type

type st_title from iw_main_window`st_title within wsm_jyutyu_number
end type

type st_title_upper from iw_main_window`st_title_upper within wsm_jyutyu_number
end type

type st_upper from iw_main_window`st_upper within wsm_jyutyu_number
end type

type st_second_upper from iw_main_window`st_second_upper within wsm_jyutyu_number
integer height = 469
borderstyle borderstyle = stylelowered!
end type

type cb_retrieve from iw_main_window`cb_retrieve within wsm_jyutyu_number
integer x = 4644
integer y = 448
end type

event constructor;call super::constructor;this.enabled	= true
end event

type sle_jyutyu_date_from_t from ivo_statictext within wsm_jyutyu_number
integer x = 16
integer y = 480
boolean bringtotop = true
long backcolor = 12632256
string text = "受注日"
alignment alignment = right!
end type

type sle_jyutyu_date_from from ivo_singlelineedit within wsm_jyutyu_number
string tag = "受注日(開始日)"
integer x = 332
integer y = 480
integer width = 404
integer taborder = 10
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

i_jyutyu_date_from		= 0
end event

event input_check;call super::input_check;
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_jyutyu_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			this.of_msg_error( "発売日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type sle_jyutyu_date_to_t from ivo_statictext within wsm_jyutyu_number
integer x = 740
integer y = 480
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_jyutyu_date_to from ivo_singlelineedit within wsm_jyutyu_number
string tag = "受注日(終了日)"
integer x = 832
integer y = 480
integer width = 404
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

i_jyutyu_date_to		= 0

end event

event input_check;call super::input_check;
string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_from	= sle_jyutyu_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date_from > l_date then
			this.of_msg_error( "発売日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type cbx_kanryo_flg from ivo_checkbox within wsm_jyutyu_number
string tag = "完了済みを含む"
integer x = 1300
integer y = 480
integer width = 520
long backcolor = 553648127
string text = "完了済みを含む"
end type

event constructor;call super::constructor;this.checked	= false
end event

type uo_tokui from cv_input_tokui within wsm_jyutyu_number
integer x = 68
integer y = 149
integer width = 2464
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = styleshadowbox!
boolean f4_key = false
long title_width = 248
long input_width = 248
long bikou_width = 168
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

type uo_mise from cv_input_mise within wsm_jyutyu_number
integer x = 16
integer y = 260
integer width = 2464
integer taborder = 40
boolean bringtotop = true
end type

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue then
	// インスタンスに格納できているかのチェックのために、input_checkを呼び出し
//	sle_ins_tokui.event	input_check()
//	msg.of_info( string( this.i_tokui_code ) )
	msg.of_info( string( of_get_mise_code() ) )
end if

return ancestorreturnvalue
end event

on uo_mise.destroy
call cv_input_mise::destroy
end on

type uo_user from cv_input_user within wsm_jyutyu_number
string tag = "入力者"
integer x = 600
integer y = 370
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;
this.enabled = true
end event

event sle_input_check;call super::sle_input_check;

string	l_code

l_code		=string( uo_user.of_get_input( ) )


// 必須チェック
if len( l_code ) = 0 then
	msg.of_error(fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ))
	this.setfocus()
	return false
end if

return true


end event

on uo_user.destroy
call cv_input_user::destroy
end on

type st_aite_no from ivo_statictext within wsm_jyutyu_number
integer x = 2452
integer y = 370
integer width = 256
integer height = 89
boolean bringtotop = true
long backcolor = 553648127
string text = "相手番号"
alignment alignment = right!
end type

type sle_aite_no from ivo_singlelineedit within wsm_jyutyu_number
integer x = 2752
integer y = 370
integer width = 920
integer taborder = 80
boolean bringtotop = true
integer init_imemode = 1
string text = ""
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_jyutyu_hoho from ivo_statictext within wsm_jyutyu_number
integer x = 16
integer y = 370
boolean bringtotop = true
long backcolor = 12632256
string text = "受注方法"
alignment alignment = right!
end type

type ddplb_jyutyu_hoho_kbn from sv_ddplb_meisyo within wsm_jyutyu_number
integer x = 332
integer y = 373
integer width = 232
integer taborder = 30
boolean bringtotop = true
integer meisyo_kbn = 205
end type

type dw_list from ivo_datawindow within wsm_jyutyu_number
integer y = 612
integer width = 5100
integer height = 1703
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_jyutyu_number"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

