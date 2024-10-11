$PBExportHeader$ws_tokui.srw
$PBExportComments$得意先一覧照会
forward
global type ws_tokui from iw_main_window
end type
type st_touroku_date_from from ivo_statictext within ws_tokui
end type
type sle_touroku_date_from from ivo_singlelineedit within ws_tokui
end type
type st_touroku_date_to from ivo_statictext within ws_tokui
end type
type sle_touroku_date_to from ivo_singlelineedit within ws_tokui
end type
type cbx_syusoku_flg from ivo_checkbox within ws_tokui
end type
type dw_list from ivo_datawindow within ws_tokui
end type
type uo_nayose from cv_input_tokui within ws_tokui
end type
type uo_bumon from cv_input_meisyo within ws_tokui
end type
type uo_eigyo from cv_input_meisyo within ws_tokui
end type
type uo_ka from cv_input_meisyo within ws_tokui
end type
type cbx_syokuti_flg from ivo_checkbox within ws_tokui
end type
type st_hyoji_komoku from ivo_statictext within ws_tokui
end type
type st_torihiki_teisi_kbn from ivo_statictext within ws_tokui
end type
type uo_seikyu from cv_input_tokui within ws_tokui
end type
type st_gyotai_kbn from ivo_statictext within ws_tokui
end type
type ddplb_gyotai_kbn from sv_ddplb_meisyo within ws_tokui
end type
type ddplb_tokui_kbn from sv_ddplb_meisyo within ws_tokui
end type
type ddplb_torihiki_jyoken_kbn from sv_ddplb_meisyo within ws_tokui
end type
type ddplb_syohizei_kbn from sv_ddplb_meisyo within ws_tokui
end type
type st_tokui_kbn from ivo_statictext within ws_tokui
end type
type st_torihiki_jyoken_kbn from ivo_statictext within ws_tokui
end type
type st_syohizei_kbn from ivo_statictext within ws_tokui
end type
type uo_tanto from cv_input_tanto within ws_tokui
end type
type rb_zen_komoku from ivo_radiobutton within ws_tokui
end type
type rb_tujyo_komoku from ivo_radiobutton within ws_tokui
end type
type cbx_torihiki_teisi_kbn_2 from ivo_checkbox within ws_tokui
end type
type cbx_torihiki_teisi_kbn_3 from ivo_checkbox within ws_tokui
end type
type cbx_torihiki_teisi_kbn_1 from ivo_checkbox within ws_tokui
end type
type cbx_torihiki_teisi_kbn_9 from ivo_checkbox within ws_tokui
end type
end forward

global type ws_tokui from iw_main_window
integer width = 6684
string title = "得意先一覧照会"
st_touroku_date_from st_touroku_date_from
sle_touroku_date_from sle_touroku_date_from
st_touroku_date_to st_touroku_date_to
sle_touroku_date_to sle_touroku_date_to
cbx_syusoku_flg cbx_syusoku_flg
dw_list dw_list
uo_nayose uo_nayose
uo_bumon uo_bumon
uo_eigyo uo_eigyo
uo_ka uo_ka
cbx_syokuti_flg cbx_syokuti_flg
st_hyoji_komoku st_hyoji_komoku
st_torihiki_teisi_kbn st_torihiki_teisi_kbn
uo_seikyu uo_seikyu
st_gyotai_kbn st_gyotai_kbn
ddplb_gyotai_kbn ddplb_gyotai_kbn
ddplb_tokui_kbn ddplb_tokui_kbn
ddplb_torihiki_jyoken_kbn ddplb_torihiki_jyoken_kbn
ddplb_syohizei_kbn ddplb_syohizei_kbn
st_tokui_kbn st_tokui_kbn
st_torihiki_jyoken_kbn st_torihiki_jyoken_kbn
st_syohizei_kbn st_syohizei_kbn
uo_tanto uo_tanto
rb_zen_komoku rb_zen_komoku
rb_tujyo_komoku rb_tujyo_komoku
cbx_torihiki_teisi_kbn_2 cbx_torihiki_teisi_kbn_2
cbx_torihiki_teisi_kbn_3 cbx_torihiki_teisi_kbn_3
cbx_torihiki_teisi_kbn_1 cbx_torihiki_teisi_kbn_1
cbx_torihiki_teisi_kbn_9 cbx_torihiki_teisi_kbn_9
end type
global ws_tokui ws_tokui

type variables
////private:
	// ユーザーオブジェクト
	nv_string	i_str

end variables

forward prototypes
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_reset ();// constructorで各コントロールリセット

rb_tujyo_komoku.event constructor( )
rb_zen_komoku.event constructor( )
sle_touroku_date_from.event constructor( )
sle_touroku_date_to.event constructor( )
cbx_torihiki_teisi_kbn_1.event constructor( )
cbx_torihiki_teisi_kbn_2.event constructor( )
cbx_torihiki_teisi_kbn_9.event constructor( )
cbx_torihiki_teisi_kbn_3.event constructor( )

uo_bumon.event constructor( )
uo_eigyo.event constructor( )
uo_ka.event constructor( )

uo_nayose.event constructor( )
uo_seikyu.event constructor( )
ddplb_gyotai_kbn.event constructor( )
ddplb_tokui_kbn.event constructor( )
ddplb_torihiki_jyoken_kbn.event constructor( )
ddplb_syohizei_kbn.event constructor( )

uo_tanto.event constructor( )
cbx_syusoku_flg.event constructor( )
cbx_syokuti_flg.event constructor( )

dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_dsp_back ();dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

on ws_tokui.create
int iCurrent
call super::create
this.st_touroku_date_from=create st_touroku_date_from
this.sle_touroku_date_from=create sle_touroku_date_from
this.st_touroku_date_to=create st_touroku_date_to
this.sle_touroku_date_to=create sle_touroku_date_to
this.cbx_syusoku_flg=create cbx_syusoku_flg
this.dw_list=create dw_list
this.uo_nayose=create uo_nayose
this.uo_bumon=create uo_bumon
this.uo_eigyo=create uo_eigyo
this.uo_ka=create uo_ka
this.cbx_syokuti_flg=create cbx_syokuti_flg
this.st_hyoji_komoku=create st_hyoji_komoku
this.st_torihiki_teisi_kbn=create st_torihiki_teisi_kbn
this.uo_seikyu=create uo_seikyu
this.st_gyotai_kbn=create st_gyotai_kbn
this.ddplb_gyotai_kbn=create ddplb_gyotai_kbn
this.ddplb_tokui_kbn=create ddplb_tokui_kbn
this.ddplb_torihiki_jyoken_kbn=create ddplb_torihiki_jyoken_kbn
this.ddplb_syohizei_kbn=create ddplb_syohizei_kbn
this.st_tokui_kbn=create st_tokui_kbn
this.st_torihiki_jyoken_kbn=create st_torihiki_jyoken_kbn
this.st_syohizei_kbn=create st_syohizei_kbn
this.uo_tanto=create uo_tanto
this.rb_zen_komoku=create rb_zen_komoku
this.rb_tujyo_komoku=create rb_tujyo_komoku
this.cbx_torihiki_teisi_kbn_2=create cbx_torihiki_teisi_kbn_2
this.cbx_torihiki_teisi_kbn_3=create cbx_torihiki_teisi_kbn_3
this.cbx_torihiki_teisi_kbn_1=create cbx_torihiki_teisi_kbn_1
this.cbx_torihiki_teisi_kbn_9=create cbx_torihiki_teisi_kbn_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_touroku_date_from
this.Control[iCurrent+2]=this.sle_touroku_date_from
this.Control[iCurrent+3]=this.st_touroku_date_to
this.Control[iCurrent+4]=this.sle_touroku_date_to
this.Control[iCurrent+5]=this.cbx_syusoku_flg
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.uo_nayose
this.Control[iCurrent+8]=this.uo_bumon
this.Control[iCurrent+9]=this.uo_eigyo
this.Control[iCurrent+10]=this.uo_ka
this.Control[iCurrent+11]=this.cbx_syokuti_flg
this.Control[iCurrent+12]=this.st_hyoji_komoku
this.Control[iCurrent+13]=this.st_torihiki_teisi_kbn
this.Control[iCurrent+14]=this.uo_seikyu
this.Control[iCurrent+15]=this.st_gyotai_kbn
this.Control[iCurrent+16]=this.ddplb_gyotai_kbn
this.Control[iCurrent+17]=this.ddplb_tokui_kbn
this.Control[iCurrent+18]=this.ddplb_torihiki_jyoken_kbn
this.Control[iCurrent+19]=this.ddplb_syohizei_kbn
this.Control[iCurrent+20]=this.st_tokui_kbn
this.Control[iCurrent+21]=this.st_torihiki_jyoken_kbn
this.Control[iCurrent+22]=this.st_syohizei_kbn
this.Control[iCurrent+23]=this.uo_tanto
this.Control[iCurrent+24]=this.rb_zen_komoku
this.Control[iCurrent+25]=this.rb_tujyo_komoku
this.Control[iCurrent+26]=this.cbx_torihiki_teisi_kbn_2
this.Control[iCurrent+27]=this.cbx_torihiki_teisi_kbn_3
this.Control[iCurrent+28]=this.cbx_torihiki_teisi_kbn_1
this.Control[iCurrent+29]=this.cbx_torihiki_teisi_kbn_9
end on

on ws_tokui.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_touroku_date_from)
destroy(this.sle_touroku_date_from)
destroy(this.st_touroku_date_to)
destroy(this.sle_touroku_date_to)
destroy(this.cbx_syusoku_flg)
destroy(this.dw_list)
destroy(this.uo_nayose)
destroy(this.uo_bumon)
destroy(this.uo_eigyo)
destroy(this.uo_ka)
destroy(this.cbx_syokuti_flg)
destroy(this.st_hyoji_komoku)
destroy(this.st_torihiki_teisi_kbn)
destroy(this.uo_seikyu)
destroy(this.st_gyotai_kbn)
destroy(this.ddplb_gyotai_kbn)
destroy(this.ddplb_tokui_kbn)
destroy(this.ddplb_torihiki_jyoken_kbn)
destroy(this.ddplb_syohizei_kbn)
destroy(this.st_tokui_kbn)
destroy(this.st_torihiki_jyoken_kbn)
destroy(this.st_syohizei_kbn)
destroy(this.uo_tanto)
destroy(this.rb_zen_komoku)
destroy(this.rb_tujyo_komoku)
destroy(this.cbx_torihiki_teisi_kbn_2)
destroy(this.cbx_torihiki_teisi_kbn_3)
destroy(this.cbx_torihiki_teisi_kbn_1)
destroy(this.cbx_torihiki_teisi_kbn_9)
end on

event resize;call super::resize;// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y
long l_row_4_y
long l_row_5_y

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」

st_hyoji_komoku.y		= l_row_1_y + 7
rb_tujyo_komoku.y		= l_row_1_y
rb_zen_komoku.y			= l_row_1_y

st_touroku_date_from.y	= l_row_1_y + 7
sle_touroku_date_from.y	= l_row_1_y
st_touroku_date_to.y	= l_row_1_y + 7
sle_touroku_date_to.y	= l_row_1_y

st_torihiki_teisi_kbn.y		= l_row_1_y + 7
cbx_torihiki_teisi_kbn_1.y	= l_row_1_y
cbx_torihiki_teisi_kbn_2.y	= l_row_1_y
cbx_torihiki_teisi_kbn_9.y	= l_row_1_y
cbx_torihiki_teisi_kbn_3.y	= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + rb_tujyo_komoku.height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_bumon.y	= l_row_2_y
uo_nayose.y	= l_row_2_y

// 3行目
l_row_3_y	= l_row_2_y + uo_bumon.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
uo_eigyo.y	= l_row_3_y
uo_seikyu.y	= l_row_3_y

// 4行目
l_row_4_y	= l_row_3_y + uo_eigyo.height + code.MGN_UPPER_TATE_GAP
uo_ka.y		= l_row_4_y

st_gyotai_kbn.y				= l_row_4_y + 7
st_tokui_kbn.y				= l_row_4_y + 7
st_torihiki_jyoken_kbn.y	= l_row_4_y + 7
st_syohizei_kbn.y			= l_row_4_y + 7

ddplb_gyotai_kbn.y			= l_row_4_y
ddplb_tokui_kbn.y			= l_row_4_y
ddplb_torihiki_jyoken_kbn.y	= l_row_4_y
ddplb_syohizei_kbn.y		= l_row_4_y

// 5行目
l_row_5_y			= l_row_4_y + uo_ka.height + code.MGN_UPPER_TATE_GAP
uo_tanto.y			= l_row_5_y
cbx_syusoku_flg.y	= l_row_5_y
cbx_syokuti_flg.y	= l_row_5_y

// st_second_upper高さ
st_second_upper.height	= l_row_5_y + uo_tanto.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y

end event

event openquery;call super::openquery;i_str	= create nv_string
end event

event close;call super::close;destroy i_str

end event

event retrieve_event;call super::retrieve_event;string	l_sql_old, l_sql_new, l_sql_where, l_torihiki_teisi_kbn

long	l_touroku_date_from, l_touroku_date_to
long	l_bumon_code, l_eigyo_code, l_ka_code, l_tanto_code, l_nayose_code, l_seikyu_code
long	l_gyotai_kbn, l_tokui_kbn, l_torihiki_jyoken_kbn, l_syohizei_kbn

boolean	l_tujyo_komoku, l_zen_komoku
boolean	l_torihiki_teisi_kbn_1, l_torihiki_teisi_kbn_2, l_torihiki_teisi_kbn_9, l_torihiki_teisi_kbn_3
boolean	l_syusoku_flg, l_syokuti_flg


// 検索条件に入力された内容をローカル変数に保持

if sle_touroku_date_from.text <> "" then
	l_touroku_date_from		= long( i_str.of_replace( sle_touroku_date_from.text, "/", "" ) )
else
	l_touroku_date_from		= 0
end if

if sle_touroku_date_to.text <> "" then
	l_touroku_date_to		= long( i_str.of_replace( sle_touroku_date_to.text, "/", "" ) )
else
	l_touroku_date_to		= 0
end if

l_torihiki_teisi_kbn_1	= cbx_torihiki_teisi_kbn_1.checked
l_torihiki_teisi_kbn_2	= cbx_torihiki_teisi_kbn_2.checked
l_torihiki_teisi_kbn_9	= cbx_torihiki_teisi_kbn_9.checked
l_torihiki_teisi_kbn_3	= cbx_torihiki_teisi_kbn_3.checked

l_bumon_code	= long( uo_bumon.of_get_meisyo_code( ) )
l_eigyo_code	= long( uo_eigyo.of_get_meisyo_code( ) )
l_ka_code		= long( uo_ka.of_get_meisyo_code( ) )

l_nayose_code	= uo_nayose.of_get_tokui_code( )
l_seikyu_code	= uo_seikyu.of_get_tokui_code( )
l_tanto_code	= uo_tanto.of_get_tanto_code( )

l_gyotai_kbn			= ddplb_gyotai_kbn.of_get_code_num( )
l_tokui_kbn				= ddplb_tokui_kbn.of_get_code_num( )
l_torihiki_jyoken_kbn	= ddplb_torihiki_jyoken_kbn.of_get_code_num( )
l_syohizei_kbn			= ddplb_syohizei_kbn.of_get_code_num( )

l_syokuti_flg		= cbx_syokuti_flg.checked
l_syusoku_flg		= cbx_syusoku_flg.checked

// dwを切り替え
if rb_tujyo_komoku.checked then
	dw_list.dataobject	= "ds_tokui_tujyo"
elseif rb_zen_komoku.checked then
	dw_list.dataobject	= "ds_tokui_zen"
end if

dw_list.event constructor( )

// 元のSQLを取得
l_sql_old	= dw_list.getsqlselect( )


// ## 条件作成 ## //

// 登録日(開始)
if l_touroku_date_from <> 0 then
	l_sql_where	+= "   and trunc( tokui.touroku_date )          >= '" + fnc.db.of_date_format( string( l_touroku_date_from ) ) + "'" + code.crlf
end if

// 登録日(終了日)
if l_touroku_date_to <> 0 then
	l_sql_where	+= "   and trunc( tokui.touroku_date )          <= '" + fnc.db.of_date_format( string( l_touroku_date_to ) ) + "'" + code.crlf
end if

// 取引停止区分
if l_torihiki_teisi_kbn_1 then
	l_torihiki_teisi_kbn += "1,"
end if

if l_torihiki_teisi_kbn_2 then
	l_torihiki_teisi_kbn += "2,"
end if

if l_torihiki_teisi_kbn_9 then
	l_torihiki_teisi_kbn += "9,"
end if

if l_torihiki_teisi_kbn_3 then
	l_torihiki_teisi_kbn += "3,"
end if

// 最後のカンマを除去してwhere句を追加
if l_torihiki_teisi_kbn <> "" then
	l_sql_where	+= "   and tokui.torihiki_teisi_kbn          in ( " + left( l_torihiki_teisi_kbn, lena( l_torihiki_teisi_kbn ) - 1) + " )" +code.crlf
end if

// 部門
if l_bumon_code <> 0 then
	l_sql_where	+= "   and tanto.bumon_code          = " + string( l_bumon_code ) + code.crlf
end if

// 営業所
if l_eigyo_code <> 0 then
	l_sql_where	+= "   and tanto.eigyosyo_code          = " + string( l_eigyo_code ) + code.crlf
end if

// 課
if l_ka_code <> 0 then
	l_sql_where	+= "   and tanto.ka_code          = " + string( l_ka_code ) + code.crlf
end if

// 担当者
if l_tanto_code <> -1 then
	l_sql_where	+= "   and tokui.tanto_code          = " + string( l_tanto_code ) + code.crlf
end if

// 名寄せ先
if l_nayose_code <> -1 then
	l_sql_where	+= "   and tokui.nayose_code          = " + string( l_nayose_code ) + code.crlf
end if

// 請求先
if l_seikyu_code <> -1 then
	l_sql_where	+= "   and tokui.seikyu_code          = " + string( l_seikyu_code ) + code.crlf
end if


// 業態
//if ddplb_gyotai_kbn.text <> "" then
if not isnull( l_gyotai_kbn ) then
	l_sql_where	+= "   and tokui.gyotai_kbn          = " + string( l_gyotai_kbn ) + code.crlf
end if

// 得意先区分
//if ddplb_tokui_kbn.text <> "" then
if not isnull( l_tokui_kbn ) then
	l_sql_where	+= "   and tokui.tokui_kbn          = " + string( l_tokui_kbn ) + code.crlf
end if

// 取引区分
//if ddplb_torihiki_jyoken_kbn.text <> "" then
if not isnull( l_torihiki_jyoken_kbn ) then
	l_sql_where	+= "   and tokui.torihiki_jyoken_kbn          = " + string( l_torihiki_jyoken_kbn ) + code.crlf
end if

// 税区分
//if ddplb_syohizei_kbn.text <> "" then
if not isnull( l_syohizei_kbn ) then
	l_sql_where	+= "   and tokui.syohizei_kbn          = " + string( l_syohizei_kbn ) + code.crlf
end if

// 諸口得意先を含む
if not l_syokuti_flg then
	l_sql_where	+= "   and tokui.syokuti_flg     <> 1 " + code.crlf
end if

// 終息得意先を含む
if not l_syusoku_flg then
	l_sql_where	+= "   and tokui.syusoku_flg           <> 1" + code.crlf
end if

// 最後に出現する"order by"の前にWhere句を追加する
l_sql_new	= Mid( l_sql_old, 1, LastPos( l_sql_old, "order by" ) - 1 ) + code.crlf + l_sql_where + Mid( l_sql_old, LastPos( l_sql_old, "order by" ) )

dw_list.reset( )


// 組み立てたSQLをセットする
dw_list.setsqlselect( l_sql_new )

// 検索
if dw_list.retrieve( ) = 0 then
	// SQLを元に戻す
	dw_list.setsqlselect( l_sql_old )
	
	msg.of_error( "検索されたデータはありません。" )
	return -1
end if

// SQLを元に戻す
dw_list.setsqlselect( l_sql_old )

dw_list.setfocus( )

end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event open;call super::open;// 初期表示
of_set_firstfocus( )

end event

event key_f06;call super::key_f06;// 戻り
of_dsp_back()

return 0
end event

event retrieve_check;call super::retrieve_check;// Retrieve前の事前チェック

// 登録日(開始)
if not sle_touroku_date_from.event input_check( ) then
	return -1
end if

// 登録日(終了)
if not sle_touroku_date_to.event input_check( ) then
	return -1
end if

// 部門
// 空の場合falseが返ってくるので空以外の場合だけチェックする
if uo_bumon.of_get_input( ) <> "" AND not uo_bumon.event sle_input_check( ) then
	return -1
end if

// 営業所
if uo_eigyo.of_get_input( ) <> "" AND not uo_eigyo.event sle_input_check( ) then
	return -1
end if

// 課
if uo_ka.of_get_input( ) <> "" AND not uo_ka.event sle_input_check( ) then
	return -1
end if

// 担当者
if uo_tanto.of_get_input( ) <> "" AND not uo_tanto.event sle_input_check( ) then
	return -1
end if

// 名寄せ先
if uo_nayose.of_get_input( ) <> "" AND not uo_nayose.event sle_input_check( ) then
	return -1
end if

// 請求先
if uo_seikyu.of_get_input( ) <> "" AND not uo_seikyu.event sle_input_check( ) then
	return -1
end if

// 業態
if not ddplb_gyotai_kbn.event input_check( ) then
	return -1
end if

// 得意先区分
if not ddplb_tokui_kbn.event input_check( ) then
	return -1
end if

// 取引条件
if not ddplb_torihiki_jyoken_kbn.event input_check( ) then
	return -1
end if

// 税区分
if not ddplb_syohizei_kbn.event input_check( ) then
	return -1
end if

end event

type uo_signal from iw_main_window`uo_signal within ws_tokui
end type

type st_date from iw_main_window`st_date within ws_tokui
end type

type st_user_mei from iw_main_window`st_user_mei within ws_tokui
end type

type uo_test_mode from iw_main_window`uo_test_mode within ws_tokui
end type

type p_size_adjust from iw_main_window`p_size_adjust within ws_tokui
end type

type st_title from iw_main_window`st_title within ws_tokui
end type

type st_title_upper from iw_main_window`st_title_upper within ws_tokui
end type

type st_upper from iw_main_window`st_upper within ws_tokui
end type

type st_second_upper from iw_main_window`st_second_upper within ws_tokui
integer y = 139
integer height = 587
end type

type cb_retrieve from iw_main_window`cb_retrieve within ws_tokui
integer x = 4272
integer y = 604
integer taborder = 130
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type st_touroku_date_from from ivo_statictext within ws_tokui
integer x = 1160
integer y = 171
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "登録日"
alignment alignment = right!
end type

type sle_touroku_date_from from ivo_singlelineedit within ws_tokui
integer x = 1424
integer y = 164
integer width = 408
integer taborder = 10
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type st_touroku_date_to from ivo_statictext within ws_tokui
integer x = 1848
integer y = 164
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_touroku_date_to from ivo_singlelineedit within ws_tokui
integer x = 1952
integer y = 164
integer width = 408
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type cbx_syusoku_flg from ivo_checkbox within ws_tokui
integer x = 2272
integer y = 604
integer width = 648
long backcolor = 553648127
string text = "終息得意先を含む"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked	= false

end event

type dw_list from ivo_datawindow within ws_tokui
integer y = 743
integer width = 5100
integer height = 1703
integer taborder = 140
boolean bringtotop = true
string dataobject = "ds_tokui_tujyo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }
this.i_sfunction_name	= { "登録詳細", "", "", "", "", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)
end event

event key_f05;call super::key_f05;// Excel出力
string	l_file

// フルパスで入れれば保存先フォルダが指定可能

l_file	= fnc.strg.of_format( "得意先一覧照会_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event getfocus;call super::getfocus;if this.rowcount() > 0 then
	sf1_key	= true
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	sf1_key	= false
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

end event

event clicked;call super::clicked;string	l_columnname

choose case right( dwo.name, 2 )
	case "_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
end choose

end event

event key_f01;call super::key_f01;// 登録詳細
long	l_tokui_code,l_mise_code

if keyflags = 1 then
	l_tokui_code	= this.object.tokui_code[this.getrow()]
//	l_mise_code	= this.object.mise_code[this.getrow()]
	
	msg.of_info( "得意先登録画面遷移機能は未実装です。" )
end if
/*
long	l_syohin_code, l_iro_no

if keyflags = 1 then
	l_syohin_code	= this.object.syohin_code[this.getrow()]
	l_iro_no		= this.object.iro_no[this.getrow()]
	
	msg.of_info( "商品登録詳細画面は未実装です。" )
end if
*/

return 0
end event

type uo_nayose from cv_input_tokui within ws_tokui
integer x = 1424
integer y = 274
integer width = 2360
integer taborder = 70
boolean bringtotop = true
boolean f4_key = false
string title_text = "名寄せ先"
long title_width = 328
long input_width = 248
long bikou_width = 0
boolean bikou_visible = false
boolean syusoku_hyoji = false
end type

on uo_nayose.destroy
call cv_input_tokui::destroy
end on

type uo_bumon from cv_input_meisyo within ws_tokui
string tag = "部門"
integer x = 32
integer y = 274
integer width = 1360
integer taborder = 30
boolean bringtotop = true
string title_text = "部門"
long title_width = 328
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 21
end type

on uo_bumon.destroy
call cv_input_meisyo::destroy
end on

type uo_eigyo from cv_input_meisyo within ws_tokui
string tag = "営業所"
integer x = 32
integer y = 384
integer width = 1360
integer taborder = 40
boolean bringtotop = true
string title_text = "営業所"
long title_width = 328
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 22
end type

on uo_eigyo.destroy
call cv_input_meisyo::destroy
end on

type uo_ka from cv_input_meisyo within ws_tokui
string tag = "課"
integer x = 32
integer y = 491
integer width = 1360
integer taborder = 50
boolean bringtotop = true
string title_text = "課"
long title_width = 328
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 23
end type

on uo_ka.destroy
call cv_input_meisyo::destroy
end on

type cbx_syokuti_flg from ivo_checkbox within ws_tokui
integer x = 1608
integer y = 604
integer width = 648
long backcolor = 553648127
string text = "諸口得意先を含む"
end type

event constructor;call super::constructor;this.checked	= false
end event

type st_hyoji_komoku from ivo_statictext within ws_tokui
integer x = 32
integer y = 171
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "表示項目"
alignment alignment = right!
end type

type st_torihiki_teisi_kbn from ivo_statictext within ws_tokui
integer x = 2392
integer y = 171
integer width = 488
boolean bringtotop = true
long backcolor = 12632256
string text = "取引停止区分"
alignment alignment = right!
end type

type uo_seikyu from cv_input_tokui within ws_tokui
integer x = 1424
integer y = 384
integer width = 2360
integer taborder = 80
boolean bringtotop = true
boolean f4_key = false
string title_text = "請求先"
long title_width = 328
long input_width = 248
long bikou_width = 0
boolean bikou_visible = false
boolean syusoku_hyoji = false
end type

on uo_seikyu.destroy
call cv_input_tokui::destroy
end on

type st_gyotai_kbn from ivo_statictext within ws_tokui
integer x = 1424
integer y = 498
integer width = 168
boolean bringtotop = true
long backcolor = 553648127
string text = "業態"
alignment alignment = right!
end type

type ddplb_gyotai_kbn from sv_ddplb_meisyo within ws_tokui
integer x = 1608
integer y = 491
integer width = 668
integer taborder = 90
boolean bringtotop = true
boolean selecttext = false
integer meisyo_kbn = 103
boolean enabled_null = true
end type

type ddplb_tokui_kbn from sv_ddplb_meisyo within ws_tokui
integer x = 2732
integer y = 491
integer width = 428
integer taborder = 100
boolean bringtotop = true
boolean selecttext = false
integer meisyo_kbn = 101
boolean enabled_null = true
end type

type ddplb_torihiki_jyoken_kbn from sv_ddplb_meisyo within ws_tokui
integer x = 3536
integer y = 491
integer width = 348
integer taborder = 110
boolean bringtotop = true
boolean selecttext = false
integer meisyo_kbn = 105
boolean enabled_null = true
end type

type ddplb_syohizei_kbn from sv_ddplb_meisyo within ws_tokui
integer x = 4180
integer y = 491
integer width = 428
integer taborder = 120
boolean bringtotop = true
boolean selecttext = false
integer meisyo_kbn = 104
boolean enabled_null = true
end type

type st_tokui_kbn from ivo_statictext within ws_tokui
integer x = 2308
integer y = 498
integer width = 408
boolean bringtotop = true
long backcolor = 553648127
string text = "得意先区分"
alignment alignment = right!
end type

type st_torihiki_jyoken_kbn from ivo_statictext within ws_tokui
integer x = 3192
integer y = 498
integer width = 328
boolean bringtotop = true
long backcolor = 553648127
string text = "取引条件"
alignment alignment = right!
end type

type st_syohizei_kbn from ivo_statictext within ws_tokui
integer x = 3916
integer y = 498
integer width = 248
boolean bringtotop = true
long backcolor = 553648127
string text = "税区分"
alignment alignment = right!
end type

type uo_tanto from cv_input_tanto within ws_tokui
integer x = 32
integer y = 604
integer width = 1440
integer taborder = 60
boolean bringtotop = true
long title_width = 328
long input_width = 128
long bikou_width = 0
boolean bikou_visible = false
end type

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

type rb_zen_komoku from ivo_radiobutton within ws_tokui
integer x = 760
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "全項目"
end type

type rb_tujyo_komoku from ivo_radiobutton within ws_tokui
integer x = 376
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "通常項目"
end type

event constructor;call super::constructor;this.checked	= true
end event

event clicked;call super::clicked;//dw_list.dataobject	= "ds_tokui_tujyo"
//dw_list.event constructor( )
end event

type cbx_torihiki_teisi_kbn_2 from ivo_checkbox within ws_tokui
integer x = 3280
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "一時停止"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked = true
end event

type cbx_torihiki_teisi_kbn_3 from ivo_checkbox within ws_tokui
integer x = 4048
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "完全停止"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked = false
end event

type cbx_torihiki_teisi_kbn_1 from ivo_checkbox within ws_tokui
integer x = 2896
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "取引中"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked = true
end event

type cbx_torihiki_teisi_kbn_9 from ivo_checkbox within ws_tokui
integer x = 3664
integer y = 164
integer width = 368
long backcolor = 553648127
string text = "仮解除"
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.checked = true
end event

