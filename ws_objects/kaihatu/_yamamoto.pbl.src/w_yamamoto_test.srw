$PBExportHeader$w_yamamoto_test.srw
$PBExportComments$テスト画面
forward
global type w_yamamoto_test from iw_main_window
end type
type dw_test_scroll from ivo_datawindow within w_yamamoto_test
end type
type cb_plus from ivo_commandbutton within w_yamamoto_test
end type
type cb_minus from ivo_commandbutton within w_yamamoto_test
end type
type mc_1 from monthcalendar within w_yamamoto_test
end type
type st_day from sv_st_meisyo within w_yamamoto_test
end type
type st_start from sv_st_meisyo within w_yamamoto_test
end type
type st_end from sv_st_meisyo within w_yamamoto_test
end type
type dp_date_picker from datepicker within w_yamamoto_test
end type
type st_picker from sv_st_meisyo within w_yamamoto_test
end type
type dw_custom2 from ivo_datawindow within w_yamamoto_test
end type
type cb_kensaku from ivo_commandbutton within w_yamamoto_test
end type
type sle_syohin_code from ivo_singlelineedit within w_yamamoto_test
end type
type sle_iro_ban from ivo_singlelineedit within w_yamamoto_test
end type
type cb_modal from ivo_commandbutton within w_yamamoto_test
end type
type cb_column_info from ivo_commandbutton within w_yamamoto_test
end type
type sle_column_info from ivo_singlelineedit within w_yamamoto_test
end type
type st_syohin_cpde from ivo_statictext within w_yamamoto_test
end type
type st_wreki_fnuc from ivo_statictext within w_yamamoto_test
end type
type sle_wareki_func from ivo_singlelineedit within w_yamamoto_test
end type
type st_date_format from ivo_statictext within w_yamamoto_test
end type
type sle_date_format from ivo_singlelineedit within w_yamamoto_test
end type
type st_date_format_output from ivo_statictext within w_yamamoto_test
end type
type sle_date_format_output from ivo_singlelineedit within w_yamamoto_test
end type
type st_lock from ivo_statictext within w_yamamoto_test
end type
type sle_lock from ivo_singlelineedit within w_yamamoto_test
end type
type st_mgn20 from ivo_statictext within w_yamamoto_test
end type
type st_mgn16 from ivo_statictext within w_yamamoto_test
end type
type dw_mgn from ivo_datawindow within w_yamamoto_test
end type
type sle_mgn16 from ivo_singlelineedit within w_yamamoto_test
end type
type sle_mgn20 from ivo_singlelineedit within w_yamamoto_test
end type
type cb_unlock from ivo_commandbutton within w_yamamoto_test
end type
type ddplb_syori from sv_ddplb_syori within w_yamamoto_test
end type
type cb_required from ivo_commandbutton within w_yamamoto_test
end type
type uo_1 from cv_input_syohin within w_yamamoto_test
end type
type gb_niokurinin from ivo_groupbox within w_yamamoto_test
end type
end forward

global type w_yamamoto_test from iw_main_window
string title = "テスト画面"
dw_test_scroll dw_test_scroll
cb_plus cb_plus
cb_minus cb_minus
mc_1 mc_1
st_day st_day
st_start st_start
st_end st_end
dp_date_picker dp_date_picker
st_picker st_picker
dw_custom2 dw_custom2
cb_kensaku cb_kensaku
sle_syohin_code sle_syohin_code
sle_iro_ban sle_iro_ban
cb_modal cb_modal
cb_column_info cb_column_info
sle_column_info sle_column_info
st_syohin_cpde st_syohin_cpde
st_wreki_fnuc st_wreki_fnuc
sle_wareki_func sle_wareki_func
st_date_format st_date_format
sle_date_format sle_date_format
st_date_format_output st_date_format_output
sle_date_format_output sle_date_format_output
st_lock st_lock
sle_lock sle_lock
st_mgn20 st_mgn20
st_mgn16 st_mgn16
dw_mgn dw_mgn
sle_mgn16 sle_mgn16
sle_mgn20 sle_mgn20
cb_unlock cb_unlock
ddplb_syori ddplb_syori
cb_required cb_required
uo_1 uo_1
gb_niokurinin gb_niokurinin
end type
global w_yamamoto_test w_yamamoto_test

type variables

public:


protected:


private:
	integer		i_column_cnt
	long		i_new_width
	
	str_dpara	i_dpara
end variables

on w_yamamoto_test.create
int iCurrent
call super::create
this.dw_test_scroll=create dw_test_scroll
this.cb_plus=create cb_plus
this.cb_minus=create cb_minus
this.mc_1=create mc_1
this.st_day=create st_day
this.st_start=create st_start
this.st_end=create st_end
this.dp_date_picker=create dp_date_picker
this.st_picker=create st_picker
this.dw_custom2=create dw_custom2
this.cb_kensaku=create cb_kensaku
this.sle_syohin_code=create sle_syohin_code
this.sle_iro_ban=create sle_iro_ban
this.cb_modal=create cb_modal
this.cb_column_info=create cb_column_info
this.sle_column_info=create sle_column_info
this.st_syohin_cpde=create st_syohin_cpde
this.st_wreki_fnuc=create st_wreki_fnuc
this.sle_wareki_func=create sle_wareki_func
this.st_date_format=create st_date_format
this.sle_date_format=create sle_date_format
this.st_date_format_output=create st_date_format_output
this.sle_date_format_output=create sle_date_format_output
this.st_lock=create st_lock
this.sle_lock=create sle_lock
this.st_mgn20=create st_mgn20
this.st_mgn16=create st_mgn16
this.dw_mgn=create dw_mgn
this.sle_mgn16=create sle_mgn16
this.sle_mgn20=create sle_mgn20
this.cb_unlock=create cb_unlock
this.ddplb_syori=create ddplb_syori
this.cb_required=create cb_required
this.uo_1=create uo_1
this.gb_niokurinin=create gb_niokurinin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_test_scroll
this.Control[iCurrent+2]=this.cb_plus
this.Control[iCurrent+3]=this.cb_minus
this.Control[iCurrent+4]=this.mc_1
this.Control[iCurrent+5]=this.st_day
this.Control[iCurrent+6]=this.st_start
this.Control[iCurrent+7]=this.st_end
this.Control[iCurrent+8]=this.dp_date_picker
this.Control[iCurrent+9]=this.st_picker
this.Control[iCurrent+10]=this.dw_custom2
this.Control[iCurrent+11]=this.cb_kensaku
this.Control[iCurrent+12]=this.sle_syohin_code
this.Control[iCurrent+13]=this.sle_iro_ban
this.Control[iCurrent+14]=this.cb_modal
this.Control[iCurrent+15]=this.cb_column_info
this.Control[iCurrent+16]=this.sle_column_info
this.Control[iCurrent+17]=this.st_syohin_cpde
this.Control[iCurrent+18]=this.st_wreki_fnuc
this.Control[iCurrent+19]=this.sle_wareki_func
this.Control[iCurrent+20]=this.st_date_format
this.Control[iCurrent+21]=this.sle_date_format
this.Control[iCurrent+22]=this.st_date_format_output
this.Control[iCurrent+23]=this.sle_date_format_output
this.Control[iCurrent+24]=this.st_lock
this.Control[iCurrent+25]=this.sle_lock
this.Control[iCurrent+26]=this.st_mgn20
this.Control[iCurrent+27]=this.st_mgn16
this.Control[iCurrent+28]=this.dw_mgn
this.Control[iCurrent+29]=this.sle_mgn16
this.Control[iCurrent+30]=this.sle_mgn20
this.Control[iCurrent+31]=this.cb_unlock
this.Control[iCurrent+32]=this.ddplb_syori
this.Control[iCurrent+33]=this.cb_required
this.Control[iCurrent+34]=this.uo_1
this.Control[iCurrent+35]=this.gb_niokurinin
end on

on w_yamamoto_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_test_scroll)
destroy(this.cb_plus)
destroy(this.cb_minus)
destroy(this.mc_1)
destroy(this.st_day)
destroy(this.st_start)
destroy(this.st_end)
destroy(this.dp_date_picker)
destroy(this.st_picker)
destroy(this.dw_custom2)
destroy(this.cb_kensaku)
destroy(this.sle_syohin_code)
destroy(this.sle_iro_ban)
destroy(this.cb_modal)
destroy(this.cb_column_info)
destroy(this.sle_column_info)
destroy(this.st_syohin_cpde)
destroy(this.st_wreki_fnuc)
destroy(this.sle_wareki_func)
destroy(this.st_date_format)
destroy(this.sle_date_format)
destroy(this.st_date_format_output)
destroy(this.sle_date_format_output)
destroy(this.st_lock)
destroy(this.sle_lock)
destroy(this.st_mgn20)
destroy(this.st_mgn16)
destroy(this.dw_mgn)
destroy(this.sle_mgn16)
destroy(this.sle_mgn20)
destroy(this.cb_unlock)
destroy(this.ddplb_syori)
destroy(this.cb_required)
destroy(this.uo_1)
destroy(this.gb_niokurinin)
end on

event key_f10;call super::key_f10;winctl.post of_close( this.classname(), false )

return 0
end event

event open;call super::open;
dw_mgn.settransobject( cocos )
dw_mgn.retrieve()
end event

event resize;call super::resize;

sle_mgn20.x	= st_mgn20.x + st_mgn20.width + 20

sle_mgn16.x	= st_mgn16.x + st_mgn16.width + 16
end event

type uo_signal from iw_main_window`uo_signal within w_yamamoto_test
end type

type st_date from iw_main_window`st_date within w_yamamoto_test
end type

type st_user_mei from iw_main_window`st_user_mei within w_yamamoto_test
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_yamamoto_test
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_yamamoto_test
end type

type st_title from iw_main_window`st_title within w_yamamoto_test
end type

type st_title_upper from iw_main_window`st_title_upper within w_yamamoto_test
end type

type st_upper from iw_main_window`st_upper within w_yamamoto_test
end type

type st_second_upper from iw_main_window`st_second_upper within w_yamamoto_test
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_yamamoto_test
integer taborder = 20
end type

type dw_test_scroll from ivo_datawindow within w_yamamoto_test
integer y = 1177
integer width = 5120
integer height = 288
boolean bringtotop = true
string dataobject = "d_test_scroll"
end type

event constructor;call super::constructor;dw_test_scroll.settransobject( cocos )	// cocosに接続
dw_test_scroll.retrieve()
end event

type cb_plus from ivo_commandbutton within w_yamamoto_test
integer x = 4056
integer y = 1550
boolean bringtotop = true
string text = "+ボタン"
end type

event clicked;call super::clicked;// 変数の定義
string	l_maxpos, l_modify

// 水平スクロールの最大値を取得する
l_maxpos	= dw_test_scroll.Object.DataWindow.HorizontalScrollMaximum

i_new_width	= i_new_width + 100

// HorizontalScrollPosition プロパティを設定する文字列を作成
l_modify	= "DataWindow.HorizontalScrollPosition=" + String( i_new_width )

// プロパティを設定する
dw_test_scroll.Modify( l_modify )
end event

type cb_minus from ivo_commandbutton within w_yamamoto_test
integer x = 3624
integer y = 1554
boolean bringtotop = true
string text = "-ボタン"
end type

event clicked;call super::clicked;// 変数の定義
string	l_maxpos, l_modify

// 水平スクロールの最大値を取得する
l_maxpos	= dw_test_scroll.Object.DataWindow.HorizontalScrollMaximum

i_new_width	= i_new_width - 100

// HorizontalScrollPosition プロパティを設定する文字列を作成
l_modify	= "DataWindow.HorizontalScrollPosition=" + String( i_new_width )

// プロパティを設定する
dw_test_scroll.Modify( l_modify )
end event

type mc_1 from monthcalendar within w_yamamoto_test
integer x = 60
integer y = 398
integer width = 916
integer height = 722
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "MS UI Gothic"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
weekday firstdayofweek = sunday!
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//date	l_date
//
//mc_1.getselecteddate( l_date )
//msg.of_info( string( l_date ) )
//
//st_day.text	= string( l_date )
end event

event dateselected;date	l_date
date	l_start
date	l_end

//mc_1.getselectedrange( l_start, l_end )
//msg.of_info( string( l_start ) )
//msg.of_info( string( l_end ) )
//
//st_start.text	= string( l_start )
//st_end.text	= string( l_end )


// doubleclickedに書いてた
//date	l_date
//
//mc_1.getselecteddate( l_date )
//msg.of_info( string( l_date ) )
//
//st_day.text	= string( l_date )

if mc_1.getselecteddate( l_date ) = 0 then	
	st_day.text	= string( l_date )
end if

if mc_1.getselectedrange( l_start, l_end ) = 0 then
	st_start.text	= string( l_start )
	st_end.text	= string( l_end )
end if
end event

type st_day from sv_st_meisyo within w_yamamoto_test
integer x = 1032
integer y = 444
integer width = 412
boolean bringtotop = true
end type

type st_start from sv_st_meisyo within w_yamamoto_test
integer x = 1028
integer y = 555
integer width = 412
boolean bringtotop = true
end type

type st_end from sv_st_meisyo within w_yamamoto_test
integer x = 1488
integer y = 555
integer width = 412
boolean bringtotop = true
end type

type dp_date_picker from datepicker within w_yamamoto_test
integer x = 2284
integer y = 391
integer width = 680
integer height = 149
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-09-10"), Time("15:28:14.000000"))
integer textsize = -11
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI Semilight"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event closeup;date	l_date

l_date	= dp_date_picker.datevalue

st_picker.text	= string( l_date )

end event

type st_picker from sv_st_meisyo within w_yamamoto_test
integer x = 3024
integer y = 420
integer width = 504
boolean bringtotop = true
end type

type dw_custom2 from ivo_datawindow within w_yamamoto_test
integer x = 20
integer y = 1760
integer width = 5104
integer height = 533
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_zaiko_base2"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;// Excel出力時にタグ値をヘッダとして利用するため、、タグ値にカラム名をセットしてやる

integer	l_row
integer	l_size_iti

// 連番に1桁があるとき size_code_1など
for l_row = 1 to i_column_cnt
	l_size_iti	= this.getitemnumber( 1, "size_iti_" + string( l_row ) )
		
	if l_size_iti > 0 then
		this.modify( "zaiko_su_" + string( l_row ) + ".tag='" + this.getitemstring( 1, "size_code_" + string( l_row ) ) + "'" )
	end if
next

// 連番がすべて2桁のとき size_code_01など
//for l_row = 1 to i_column_cnt
//	l_size_iti	= this.getitemnumber( 1, "size_iti_" + string( l_row, "00" ) )
//		
//	if l_size_iti > 0 then
//		this.modify( "zaiko_su_" + string( l_row, "00" ) + ".tag='" + this.getitemstring( 1, "size_code_" + string( l_row, "00" ) ) + "'" )
//	end if
//next
end event

type cb_kensaku from ivo_commandbutton within w_yamamoto_test
integer x = 880
integer y = 1643
integer taborder = 80
boolean bringtotop = true
string text = "検索"
end type

event execution;call super::execution;// 商品コード、色番のサイズに応じて、項目数を可変させる

nv_variable_column	l_vc			// 可変列DWの関数をまとめたnv
string				l_finds[]		// 可変させたい"カラム"の文字列配列 →サイズ名だけでなくサイズ位置や在庫数も
string				l_syntax		// 可変させた編集済みのソース(ソース編集で見れるコード)を格納する
long				l_syohin_code,l_iro_ban
integer				l_column_cnt	// Excel出力時のヘッダにいれるタグ値をセットするときの、繰り返し回数(可変させたカラム数)


// ここから

l_syohin_code	= long( sle_syohin_code.text )
l_iro_ban		= long( sle_iro_ban.text )

l_vc			= create nv_variable_column	// nvをl_vcで使用可能にする

l_finds			= { "size_iti_", "zaiko_su_", "sku_code_", "size_code_" }	// 可変させたいカラム名をセット

l_vc.of_init( "d_zaiko_base2", l_finds )	// l_vc内に"d_zaiko_base2"のソースと可変させたいカラム名がセットされる
//l_vc.of_init( "d_zaiko_base", l_finds )	// l_vc内に"d_zaiko_base2"のソースと可変させたいカラム名がセットされる

l_syntax		= l_vc.of_get_custom_syntax( l_syohin_code, l_iro_ban, l_column_cnt )	// syohin_codeとiro_banが存在するレコードがカーソルで検索されて、ソースへ追加される

i_column_cnt	= l_column_cnt	// of_get_custom_syntaxで追加されたレコード数がl_column_cntへrefされている

dw_custom2.dataobject	= ""	// dwoを初期化する
dw_custom2.create( l_syntax )	// 編集したソースでdw_custom2を生成しなおす

dw_custom2.settransobject( cocos )
dw_custom2.retrieve( l_syohin_code, l_iro_ban )

destroy nv_variable_column

// ここまでの一連の流れが必要
end event

type sle_syohin_code from ivo_singlelineedit within w_yamamoto_test
integer x = 52
integer y = 1643
integer width = 396
integer taborder = 60
boolean bringtotop = true
string text = "4490"
end type

type sle_iro_ban from ivo_singlelineedit within w_yamamoto_test
integer x = 468
integer y = 1643
integer taborder = 70
boolean bringtotop = true
string text = "6"
end type

type cb_modal from ivo_commandbutton within w_yamamoto_test
integer x = 1372
integer y = 185
integer taborder = 10
boolean bringtotop = true
string text = "モーダル"
end type

event execution;call super::execution;
str_mdlpara_mtyakuten	l_mdl_tyakuten

// inパラメータがある場合はここでセットする
l_mdl_tyakuten.in_tokui_code	= 4112
l_mdl_tyakuten.in_mise_code		= 999
l_mdl_tyakuten.in_unso_code		= 2
l_mdl_tyakuten.in_yubin_no		= '206-0000'

// モーダルを開く
l_mdl_tyakuten	= mdl.of_open_modal( "wsm_tyakuten", l_mdl_tyakuten )

// 後は好きに使う
if upperbound( l_mdl_tyakuten.ret ) > 0 then
	msg.of_info( string( l_mdl_tyakuten.ret[1].tyakuten_code_tome ) )
end if

return 0
end event

type cb_column_info from ivo_commandbutton within w_yamamoto_test
integer x = 120
integer y = 153
integer width = 444
boolean bringtotop = true
string text = "カラム情報テスト"
end type

event execution;call super::execution;
string	l_column_type
decimal	l_column_length

if not fnc.db.of_get_column_info( "m_syohin", "yoki_kami", l_column_type, l_column_length ) then
	msg.of_error( "カラム情報が取得できません。" )
	return 1
end if

msg.of_info( "カラムの型：" + l_column_type )
msg.of_info( "カラムの桁数：" + string(l_column_length ) )
//msg.of_info( string( integer( 3.2 ) ) )
end event

type sle_column_info from ivo_singlelineedit within w_yamamoto_test
integer x = 572
integer y = 256
integer width = 600
boolean bringtotop = true
string text = ""
end type

event input_check;call super::input_check;
string	l_input, l_msg, l_null
string	l_column_type
decimal	l_column_length

long	l_syohin_code

setnull( l_null )

l_input	= trim( this.text )

// 入力値が適正かどうか、型・桁数・nullのチェック
if fnc.of_chk_column_info( l_input, false, "商品コード", "m_syohin", "syohin_code", l_msg ) then
	// 入力値のチェック後、存在チェックしていく？
	select distinct syohin_code
	  into :l_syohin_code
	  from m_syohin
	 where syohin_code	= :l_input
	using cocos;
	
	if cocos.sqlcode <> 0 then
		msg.of_error( "入力された商品コードは存在しません。" )
		this.setfocus( )
		return false
	end if
else
	msg.of_error( l_msg )
	this.setfocus( )
	return false
end if

if fnc.of_chk_column_info( l_input, "", "m_tokui_atesaki", "note", l_msg ) then
	msg.of_info( "1" )
end if

return true






/* 従来のコード

if len( l_input ) > 0 then
	// 入力値が適正かどうか、型・桁数・nullのチェック
	if not fnc.of_chk_column_info( l_input, "", "m_syohin", "syohin_code", l_msg ) then
		msg.of_error( l_msg )
		return false
	end if
	
	// 入力値のチェック後、存在チェックしていく？
	select syohin_code
	  into :l_syohin_code
	  from m_syohin
	 where syohin_code	= :l_input
	using cocos;
	
	if cocos.sqlcode <> 0 then
		msg.of_error( "入力された商品コードは存在しません。" )
		return false
	end if
end if

*/
end event

type st_syohin_cpde from ivo_statictext within w_yamamoto_test
integer x = 120
integer y = 263
boolean bringtotop = true
long backcolor = 12632256
string text = "商品CD"
alignment alignment = right!
end type

type st_wreki_fnuc from ivo_statictext within w_yamamoto_test
integer x = 1028
integer y = 740
integer width = 420
boolean bringtotop = true
string text = "和暦関数チェック"
alignment alignment = right!
end type

type sle_wareki_func from ivo_singlelineedit within w_yamamoto_test
integer x = 1508
integer y = 740
integer width = 600
integer taborder = 30
boolean bringtotop = true
string text = ""
end type

event input_check;call super::input_check;
datetime	l_datetime

l_datetime	= datetime( "2019/7/23 13:25:59" )
/*
msg.of_info( string( fnc.db.of_cnv_date_sei2wa() ) )					// R06/07/08
msg.of_info( string( fnc.db.of_cnv_date_sei2wa( l_datetime ) ) )		// R01/07/23
msg.of_info( string( fnc.db.of_cnv_date_sei2wa( 1996, 12, 31 ) ) )		// H08/12/31
msg.of_info( string( fnc.db.of_cnv_date_sei2wa( 1972, 12, 31 ) ) )		// S47/12/31

msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp() ) )					// 令和06年07月08日
msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp( l_datetime ) ) )		// 令和01年07月23日
msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp( 1996, 12, 31 ) ) )	// 平成08年12月31日
msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp( 1972, 12, 31 ) ) )	// 昭和47年12月31日

msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "H08", 7, 8 ) ) )		// 19960708
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "H08/1/25" ) ) )		// 19960125
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "平成08年1月25日" ) ) )	// 19960125

msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "S08", 7, 8 ) ) )		// 19330708
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "S08/1/25" ) ) )		// 19330125
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "昭和08年1月25日" ) ) )	// 19330125
*/
// 意地悪チェック
l_datetime	= datetime( "1924/7/23 13:25:59" )

//msg.of_info( string( l_datetime ) )
/*
msg.of_info( string( fnc.db.of_cnv_date_sei2wa( l_datetime ) ) )		// M56/07/23
msg.of_info( string( fnc.db.of_cnv_date_sei2wa( 1924, 12, 31 ) ) )		// M56/12/31

msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp( l_datetime ) ) )		// 明治56年07月23日
msg.of_info( string( fnc.db.of_cnv_date_sei2wa_jp( 1924, 12, 31 ) ) )	// 明治56年12月31日

msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "T01/1/25" ) ) )		// 125
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "大正1年1月25日" ) ) )	// 125
msg.of_info( string( fnc.db.of_cnv_date_wa2sei( "明治1年1月25日" ) ) )	// 125
*/


string	l_text

l_text	= trim( this.text )

if len( l_text ) = 0 then
	msg.of_error( "未入力！" )
	return false
end if

this.text	= string( fnc.db.of_cnv_date_wa2sei( l_text ) )

return true
end event

type st_date_format from ivo_statictext within w_yamamoto_test
integer x = 1028
integer y = 892
integer width = 616
boolean bringtotop = true
string text = "日付変換チェック 入力："
alignment alignment = right!
end type

type sle_date_format from ivo_singlelineedit within w_yamamoto_test
integer x = 1692
integer y = 882
integer width = 600
integer taborder = 40
boolean bringtotop = true
string text = ""
end type

event input_check;call super::input_check;
string	l_text

l_text	= trim( this.text )

if len( l_text ) = 0 then
	msg.of_error( "未入力！" )
	return false
end if

//this.text					= of_date_format( l_text )
sle_date_format_output.text	= fnc.db.of_date_format( l_text )

return true
end event

type st_date_format_output from ivo_statictext within w_yamamoto_test
integer x = 1224
integer y = 1013
integer width = 400
boolean bringtotop = true
string text = "出力："
alignment alignment = right!
end type

type sle_date_format_output from ivo_singlelineedit within w_yamamoto_test
integer x = 1692
integer y = 1006
integer width = 600
integer taborder = 50
boolean bringtotop = true
string text = ""
end type

event input_check;call super::input_check;
string	l_text

l_text	= trim( this.text )

if len( l_text ) = 0 then
	msg.of_error( "未入力！" )
	return false
end if

//sle_date_format.text	= of_date_format( l_text )
//this.text				= of_date_format( l_text, true )

return true
end event

type st_lock from ivo_statictext within w_yamamoto_test
integer x = 2036
integer y = 224
boolean bringtotop = true
long backcolor = 12632256
string text = "悲観ロック"
alignment alignment = right!
end type

type sle_lock from ivo_singlelineedit within w_yamamoto_test
integer x = 2368
integer y = 217
integer width = 600
integer taborder = 20
boolean bringtotop = true
string text = ""
end type

event input_check;call super::input_check;
string	l_input
long	l_null	

l_input	= trim( this.text )
setnull( l_null )

if not lck.of_tanto_lock( user.user_id, parent.classname( ), long( l_input ) ) then
	msg.of_error_db( "データを更新できません。", cocos )
	rollback using cocos;	// 関数内でrollbackしているけど、一応書いておく
	return false
else
	msg.of_info( "排他のロック成功" )
	commit using cocos;		// 排他ロックに成功したら、関数の呼び出し後にcommitが必ず必要
end if

return true
end event

type st_mgn20 from ivo_statictext within w_yamamoto_test
integer x = 16
integer y = 2389
integer width = 640
boolean bringtotop = true
string text = "幅20"
alignment alignment = center!
boolean border = true
end type

type st_mgn16 from ivo_statictext within w_yamamoto_test
integer x = 16
integer y = 2514
integer width = 640
boolean bringtotop = true
string text = "幅16"
alignment alignment = center!
boolean border = true
end type

type dw_mgn from ivo_datawindow within w_yamamoto_test
integer x = 16
integer y = 2638
integer width = 2672
integer height = 263
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mgn_test"
end type

type sle_mgn16 from ivo_singlelineedit within w_yamamoto_test
integer x = 672
integer y = 2507
integer width = 640
integer taborder = 50
boolean bringtotop = true
end type

type sle_mgn20 from ivo_singlelineedit within w_yamamoto_test
integer x = 676
integer y = 2382
integer width = 640
integer taborder = 40
boolean bringtotop = true
end type

type cb_unlock from ivo_commandbutton within w_yamamoto_test
integer x = 3004
integer y = 210
integer width = 468
integer taborder = 20
boolean bringtotop = true
string text = "悲観ロック解除"
end type

event clicked;call super::clicked;
string	l_input
long	l_null

l_input	= trim( sle_lock.text )
setnull( l_null )

if lck.of_tanto_lock( user.user_id, parent.classname( ), long( l_input ), false ) then
	msg.of_info( "ロック解除成功" )
	commit using cocos;
else
	msg.of_error_db( "ロック解除失敗", cocos )
	rollback using cocos;	// 関数内でrollbackしているけど、一応書いておく
end if

return 0
end event

type ddplb_syori from sv_ddplb_syori within w_yamamoto_test
integer x = 2456
integer y = 779
integer taborder = 30
boolean bringtotop = true
string init_disp = "登録"
end type

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_1.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_1.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose
end event

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

type cb_required from ivo_commandbutton within w_yamamoto_test
integer x = 2724
integer y = 661
integer taborder = 20
boolean bringtotop = true
string text = "必須"
end type

event execution;call super::execution;
boolean	l_required

l_required	= uo_1.chk_required

if l_required then
	uo_1.chk_required	= false
else
	uo_1.chk_required	= true
end if

uo_1.event constructor()

return 0
end event

type uo_1 from cv_input_syohin within w_yamamoto_test
integer x = 2736
integer y = 782
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call cv_input_syohin::destroy
end on

type gb_niokurinin from ivo_groupbox within w_yamamoto_test
integer x = 2384
integer y = 612
integer width = 2456
integer height = 324
integer taborder = 60
boolean bringtotop = false
string text = "荷送人"
end type

