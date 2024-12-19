$PBExportHeader$wp_keep_warning.srw
$PBExportComments$キープ期限警告リスト発行
forward
global type wp_keep_warning from iw_print_window
end type
type sle_tekiyo_start_date_from_t from ivo_statictext within wp_keep_warning
end type
type sle_tekiyo_start_date_from from ivo_singlelineedit within wp_keep_warning
end type
type sle_tekiyo_start_date_to_t from ivo_statictext within wp_keep_warning
end type
type sle_tekiyo_start_date_to from ivo_singlelineedit within wp_keep_warning
end type
type uo_tokui from cv_input_tokui within wp_keep_warning
end type
type st_syohin_cd_from from ivo_statictext within wp_keep_warning
end type
type sle_syohin_cd_from from ivo_singlelineedit within wp_keep_warning
end type
type st_haisinmeisai from ivo_statictext within wp_keep_warning
end type
type ddplb_haisinmeisai from sv_ddplb_meisyo within wp_keep_warning
end type
type uo_tanto from cv_input_tanto within wp_keep_warning
end type
type uo_user from cv_input_user within wp_keep_warning
end type
type cb_dw from commandbutton within wp_keep_warning
end type
end forward

global type wp_keep_warning from iw_print_window
string title = "キープ期限警告リスト発行"
sle_tekiyo_start_date_from_t sle_tekiyo_start_date_from_t
sle_tekiyo_start_date_from sle_tekiyo_start_date_from
sle_tekiyo_start_date_to_t sle_tekiyo_start_date_to_t
sle_tekiyo_start_date_to sle_tekiyo_start_date_to
uo_tokui uo_tokui
st_syohin_cd_from st_syohin_cd_from
sle_syohin_cd_from sle_syohin_cd_from
st_haisinmeisai st_haisinmeisai
ddplb_haisinmeisai ddplb_haisinmeisai
uo_tanto uo_tanto
uo_user uo_user
cb_dw cb_dw
end type
global wp_keep_warning wp_keep_warning

on wp_keep_warning.create
int iCurrent
call super::create
this.sle_tekiyo_start_date_from_t=create sle_tekiyo_start_date_from_t
this.sle_tekiyo_start_date_from=create sle_tekiyo_start_date_from
this.sle_tekiyo_start_date_to_t=create sle_tekiyo_start_date_to_t
this.sle_tekiyo_start_date_to=create sle_tekiyo_start_date_to
this.uo_tokui=create uo_tokui
this.st_syohin_cd_from=create st_syohin_cd_from
this.sle_syohin_cd_from=create sle_syohin_cd_from
this.st_haisinmeisai=create st_haisinmeisai
this.ddplb_haisinmeisai=create ddplb_haisinmeisai
this.uo_tanto=create uo_tanto
this.uo_user=create uo_user
this.cb_dw=create cb_dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_tekiyo_start_date_from_t
this.Control[iCurrent+2]=this.sle_tekiyo_start_date_from
this.Control[iCurrent+3]=this.sle_tekiyo_start_date_to_t
this.Control[iCurrent+4]=this.sle_tekiyo_start_date_to
this.Control[iCurrent+5]=this.uo_tokui
this.Control[iCurrent+6]=this.st_syohin_cd_from
this.Control[iCurrent+7]=this.sle_syohin_cd_from
this.Control[iCurrent+8]=this.st_haisinmeisai
this.Control[iCurrent+9]=this.ddplb_haisinmeisai
this.Control[iCurrent+10]=this.uo_tanto
this.Control[iCurrent+11]=this.uo_user
this.Control[iCurrent+12]=this.cb_dw
end on

on wp_keep_warning.destroy
call super::destroy
destroy(this.sle_tekiyo_start_date_from_t)
destroy(this.sle_tekiyo_start_date_from)
destroy(this.sle_tekiyo_start_date_to_t)
destroy(this.sle_tekiyo_start_date_to)
destroy(this.uo_tokui)
destroy(this.st_syohin_cd_from)
destroy(this.sle_syohin_cd_from)
destroy(this.st_haisinmeisai)
destroy(this.ddplb_haisinmeisai)
destroy(this.uo_tanto)
destroy(this.uo_user)
destroy(this.cb_dw)
end on

type uo_signal from iw_print_window`uo_signal within wp_keep_warning
end type

type st_date from iw_print_window`st_date within wp_keep_warning
end type

type st_user_mei from iw_print_window`st_user_mei within wp_keep_warning
end type

type uo_test_mode from iw_print_window`uo_test_mode within wp_keep_warning
end type

type p_size_adjust from iw_print_window`p_size_adjust within wp_keep_warning
end type

type st_title from iw_print_window`st_title within wp_keep_warning
end type

type st_title_upper from iw_print_window`st_title_upper within wp_keep_warning
string tag = "キープ期限警告リスト発行"
end type

type st_upper from iw_print_window`st_upper within wp_keep_warning
end type

type ddplb_printer from iw_print_window`ddplb_printer within wp_keep_warning
end type

type st_bottom from iw_print_window`st_bottom within wp_keep_warning
end type

type cb_preview from iw_print_window`cb_preview within wp_keep_warning
end type

type cb_print from iw_print_window`cb_print within wp_keep_warning
end type

type cb_cancel from iw_print_window`cb_cancel within wp_keep_warning
end type

type st_printer from iw_print_window`st_printer within wp_keep_warning
end type

type st_busu from iw_print_window`st_busu within wp_keep_warning
end type

type sle_busu from iw_print_window`sle_busu within wp_keep_warning
end type

type cb_test from iw_print_window`cb_test within wp_keep_warning
end type

type sle_tekiyo_start_date_from_t from ivo_statictext within wp_keep_warning
integer x = 1116
integer y = 594
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "期限日"
alignment alignment = right!
end type

type sle_tekiyo_start_date_from from ivo_singlelineedit within wp_keep_warning
string tag = "発売日(開始日)"
integer x = 1528
integer y = 594
integer width = 404
integer taborder = 90
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
end event

event input_check;call super::input_check;
/*
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then
	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) or not isdate( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_tekiyo_start_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			msg.of_error_sle( this, "適用日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

	if this.text > string(fnc.db.of_get_date()) then 
		st_bikou3.text = '予約登録'
	else
		st_bikou3.text = ''
	end if
else
	msg.of_error_sle( this, "適用日(開始日)が入力されていません" )
	return false
end if

return true
*/
return true
end event

type sle_tekiyo_start_date_to_t from ivo_statictext within wp_keep_warning
integer x = 1952
integer y = 594
integer width = 88
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_tekiyo_start_date_to from ivo_singlelineedit within wp_keep_warning
string tag = "発売日(終了日)"
integer x = 2060
integer y = 594
integer width = 404
integer taborder = 100
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

end event

event input_check;call super::input_check;
/*
string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	/*
	if  this.text = "9999/99/99" or  this.text = "99999999" or this.text = "9" then
		l_date = "9999/99/99"
	else
		l_date = fnc.db.of_date_format( this.text )
		if isnull( l_date ) then
			msg.of_error_sle( this, "不正な日付です。" )
			return false
		end if
	end if
*/
	l_date = fnc.db.of_date_format( this.text )
	if isnull( l_date ) or ( not isdate( l_date) and l_date <> "9999/99/99") then
		msg.of_error_sle( this, "不正な日付です。" )
		return false	
	end if

	// 日付大小チェック
	l_date_from	= sle_tekiyo_start_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date_from > l_date then
			msg.of_error_sle( this, "適用日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date
else
	msg.of_error_sle( this, "適用日(終了日)が入力されていません" )
	return false
end if
*/
return true

end event

type uo_tokui from cv_input_tokui within wp_keep_warning
event destroy ( )
integer x = 1116
integer y = 480
integer width = 2464
integer taborder = 30
boolean bringtotop = true
boolean f4_key = false
long bikou_width = 272
boolean syusoku_hyoji = false
boolean syohizei_hyoji = true
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;/*
string l_aite_hinban
long ll_tokui_code, li_ret, ll_syohizei_kbn, ll_syohizei_code
dec ld_syohizei_ritu, l_syohizei_ritu
str_mtokui lstr_tokui[]
str_mtanto lstr_tanto[]
str_mzeiritu lstr_zei[]

if uo_tokui.sle_input.text = "" then
	msg.of_error_sle(this.sle_input, "得意先コードが未入力です。")
	return false
end if

ll_tokui_code = long(uo_tokui.sle_input.text)

// of_tokui_get関数を呼び出す
li_ret = mst.of_tokui_get(ll_tokui_code,lstr_tokui)

// 結果を確認
if li_ret > 0 then
	i_syohizei_kbn = lstr_tokui[1].syohizei_kbn 
else
end if

li_ret = mst.of_zeiritu_get(1,i_syohizei_kbn,lstr_zei)

// 結果を確認
if li_ret > 0 then
	ld_syohizei_ritu = lstr_zei[1].syohizei_ritu
else
end if

select mz.syohizei_ritu,
		mz.zeiritu_str_date,
		mz.zeiritu_end_date
into :l_syohizei_ritu,
		:i_zeiritu_str_date,
		:i_zeiritu_end_date
from m_zeiritu mz
where mz.torihiki_kbn = 1
and mz.zeiritu_kbn = 1
order by mz.zeiritu_str_date desc
using cocos;

sle_zeiritu.text = string(l_syohizei_ritu)

ddplb_zei_kbn.selectitem( i_syohizei_kbn)

if this.sle_input.text <> '' then
	ll_tokui_code = long(this.sle_input.text)
	select min(ma.aite_hinban)
	into :l_aite_hinban
	from m_aite_hinban ma
	where ma.tokui_code = :ll_tokui_code
	using cocos;
	
	st_aite_hinban.text = l_aite_hinban
end if
*/
return true
end event

type st_syohin_cd_from from ivo_statictext within wp_keep_warning
integer x = 1116
integer y = 718
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "受注番号"
alignment alignment = right!
end type

type sle_syohin_cd_from from ivo_singlelineedit within wp_keep_warning
string tag = "商品CD"
integer x = 1528
integer y = 718
integer width = 316
integer taborder = 120
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999999"
integer limit = 7
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_digits = true
integer i_limit = 7
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event key_f08;call super::key_f08;str_mdlpara_msyohin	l_syohin

l_syohin = mdl.of_open_modal( "wsm_syohin", l_syohin )

if upperbound(l_syohin.ret) > 0 then
	this.text	= string( l_syohin.ret[1].syohin_code )
end if

return 0

end event

event input_check;call super::input_check;string	l_code
long		l_code_from
long		l_code_to

this.text	= trim( this.text )
l_code		= this.text

// 空の場合
if l_code = "" then
	if chk_required then
		of_msg_error( this.tag + "は必須入力です。" )
		this.setfocus()
		return false
	end if
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_code_from	= long( l_code )
//l_code_to		= long( sle_syohin_cd_to.text )

//前後関係チェック
//if l_code_to > 0 then
	//if l_code_from > l_code_to then
		//this.of_msg_error( "商品コードの前後関係が不正です。" )
//		return false
	//end if
//end if

return true

end event

type st_haisinmeisai from ivo_statictext within wp_keep_warning
string tag = "印刷順"
integer x = 1172
integer y = 839
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "印刷順"
alignment alignment = right!
end type

type ddplb_haisinmeisai from sv_ddplb_meisyo within wp_keep_warning
string tag = "印刷順"
integer x = 1528
integer y = 843
integer width = 548
integer taborder = 150
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 777
string init_code = "1"
end type

type uo_tanto from cv_input_tanto within wp_keep_warning
integer x = 1144
integer y = 370
integer width = 1440
integer taborder = 80
boolean bringtotop = true
long title_width = 328
long input_width = 128
long bikou_width = 0
boolean bikou_visible = false
end type

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

type uo_user from cv_input_user within wp_keep_warning
string tag = "ユーザー"
integer x = 1112
integer y = 267
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

type cb_dw from commandbutton within wp_keep_warning
integer x = 2912
integer y = 761
integer width = 844
integer height = 89
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI"
string text = "引数を渡してデータウィンドウを開きます"
end type

event clicked;
//dw_1.DataObject = "dm_syohin_tokutei"  // データウィンドウオブジェクト名を指定
// ここでデータウィンドウを開く
//open(w_newwindow)

openwithparm( wp_keep_warning_tyohyo, 1)


//winctl.of_open( "wp_keep_warning_tyohyo" )
end event

