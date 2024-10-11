$PBExportHeader$wse_calendar.srw
$PBExportComments$カレンダー登録削除
forward
global type wse_calendar from iw_modal_window
end type
type st_calendar_kbn from ivo_statictext within wse_calendar
end type
type ddplb_calendar_kbn from sv_ddplb_meisyo within wse_calendar
end type
type st_hizuke_from from ivo_statictext within wse_calendar
end type
type st_calendar_kbn_code from ivo_statictext within wse_calendar
end type
type ddplb_syori_kbn from sv_ddplb_syori within wse_calendar
end type
type st_syori_kbn from ivo_statictext within wse_calendar
end type
type st_5 from ivo_statictext within wse_calendar
end type
type st_6 from ivo_statictext within wse_calendar
end type
type st_tekiyo from ivo_statictext within wse_calendar
end type
type st_hizuke_to from ivo_statictext within wse_calendar
end type
type sle_hizuke_from from ivo_singlelineedit within wse_calendar
end type
type sle_hizuke_to from ivo_singlelineedit within wse_calendar
end type
type sle_tekiyo from ivo_singlelineedit within wse_calendar
end type
type sle_calendar_kbn_code from ivo_singlelineedit within wse_calendar
end type
type sle_kyoten_code from ivo_singlelineedit within wse_calendar
end type
type sle_kyoten_ryakumei from ivo_singlelineedit within wse_calendar
end type
type st_1 from ivo_statictext within wse_calendar
end type
end forward

global type wse_calendar from iw_modal_window
integer width = 2832
integer height = 1035
string title = "新規カレンダー"
st_calendar_kbn st_calendar_kbn
ddplb_calendar_kbn ddplb_calendar_kbn
st_hizuke_from st_hizuke_from
st_calendar_kbn_code st_calendar_kbn_code
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
st_5 st_5
st_6 st_6
st_tekiyo st_tekiyo
st_hizuke_to st_hizuke_to
sle_hizuke_from sle_hizuke_from
sle_hizuke_to sle_hizuke_to
sle_tekiyo sle_tekiyo
sle_calendar_kbn_code sle_calendar_kbn_code
sle_kyoten_code sle_kyoten_code
sle_kyoten_ryakumei sle_kyoten_ryakumei
st_1 st_1
end type
global wse_calendar wse_calendar

type variables

str_calendar	i_para
boolean			i_new

string i_syori_kbn, i_hizuke_from, i_hizuke_to, i_tekiyo
integer i_kyoten_code, i_calendar_kbn, i_taisyo_flg


end variables

forward prototypes
public function boolean of_db_insert ()
public function boolean of_db_delete ()
end prototypes

public function boolean of_db_insert ();
insert into m_calendar( 
    kyoten_code, 
    calendar_kbn, 
    hizuke, 
    nen, 
    tuki, 
    hi, 
    youbi, 
    taisyo_flg, 
    tekiyo
)
select
    :i_kyoten_code,
    :i_calendar_kbn,
    to_number( to_char( hizuke, 'yyyymmdd' ) ) hizuke,
    to_number( to_char( hizuke, 'yyyy' ) )	nen,
    to_number( to_char( hizuke, 'mm' ) )	tuki,
    to_number( to_char( hizuke, 'dd' ) )	hi,
    to_number( to_char( hizuke, 'd') )		youbi,
    :i_taisyo_flg,
    :i_tekiyo
from (	select to_date( :i_hizuke_from || '/01', 'yyyy/mm/dd') + level - 1 hizuke
		  from dual
		connect by level <= last_day(to_date( :i_hizuke_to, 'yyyy/mm')) - to_date( :i_hizuke_from || '/01', 'yyyy/mm/dd') + 1
    )calendar
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "カレンダーマスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true

end function

public function boolean of_db_delete ();
delete from m_calendar
 where kyoten_code	= :i_kyoten_code
   and calendar_kbn	= :i_calendar_kbn
   and hizuke >= to_number( to_char ( to_date( :i_hizuke_from || '/01'), 'yyyymmdd' ) ) 
   and hizuke <= to_number( to_char ( last_day( to_date( :i_hizuke_to || '/01')), 'yyyymmdd' ) )
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "カレンダーマスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

on wse_calendar.create
int iCurrent
call super::create
this.st_calendar_kbn=create st_calendar_kbn
this.ddplb_calendar_kbn=create ddplb_calendar_kbn
this.st_hizuke_from=create st_hizuke_from
this.st_calendar_kbn_code=create st_calendar_kbn_code
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.st_5=create st_5
this.st_6=create st_6
this.st_tekiyo=create st_tekiyo
this.st_hizuke_to=create st_hizuke_to
this.sle_hizuke_from=create sle_hizuke_from
this.sle_hizuke_to=create sle_hizuke_to
this.sle_tekiyo=create sle_tekiyo
this.sle_calendar_kbn_code=create sle_calendar_kbn_code
this.sle_kyoten_code=create sle_kyoten_code
this.sle_kyoten_ryakumei=create sle_kyoten_ryakumei
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_calendar_kbn
this.Control[iCurrent+2]=this.ddplb_calendar_kbn
this.Control[iCurrent+3]=this.st_hizuke_from
this.Control[iCurrent+4]=this.st_calendar_kbn_code
this.Control[iCurrent+5]=this.ddplb_syori_kbn
this.Control[iCurrent+6]=this.st_syori_kbn
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.st_tekiyo
this.Control[iCurrent+10]=this.st_hizuke_to
this.Control[iCurrent+11]=this.sle_hizuke_from
this.Control[iCurrent+12]=this.sle_hizuke_to
this.Control[iCurrent+13]=this.sle_tekiyo
this.Control[iCurrent+14]=this.sle_calendar_kbn_code
this.Control[iCurrent+15]=this.sle_kyoten_code
this.Control[iCurrent+16]=this.sle_kyoten_ryakumei
this.Control[iCurrent+17]=this.st_1
end on

on wse_calendar.destroy
call super::destroy
destroy(this.st_calendar_kbn)
destroy(this.ddplb_calendar_kbn)
destroy(this.st_hizuke_from)
destroy(this.st_calendar_kbn_code)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_tekiyo)
destroy(this.st_hizuke_to)
destroy(this.sle_hizuke_from)
destroy(this.sle_hizuke_to)
destroy(this.sle_tekiyo)
destroy(this.sle_calendar_kbn_code)
destroy(this.sle_kyoten_code)
destroy(this.sle_kyoten_ryakumei)
destroy(this.st_1)
end on

event open;call super::open;// インスタンス変数に構造体が定義してあるため使用する構造体に変更(変数名は変更しない)するのを忘れずに //

// 画面サイズ固定 //
this.width	= PixelsToUnits ( 375, XPixelsToUnits!  )
this.height	= PixelsToUnits ( 229, YPixelsToUnits! )

// プログラム(ここから) //

	
if isnull(i_para.answer) then
	i_new			= true
	i_para.answer	= false
	
	// 初期値をセット //
	sle_kyoten_code.text		= string( i_para.kyoten )
	sle_kyoten_ryakumei.text	= i_para.kyoten_mei_ryaku
else
	i_new			= false

end if

of_set_firstfocus( )
end event

event update_event;call super::update_event;
integer	l_row

choose case i_syori_kbn
	case "登録"
		if not of_db_insert( ) then
			return -1
		end if

	case "削除"
		if not of_db_delete( ) then
			return -1
		end if
end choose

i_para.answer 		= True
i_para.shori_kbn 	= i_syori_kbn
i_para.kbn 			= i_calendar_kbn

commit using cocos; // TODO：COMMITのタイミングはいつするか確認必要

event close( )
end event

event update_check;// update_eventの前に動作するイベント //
//integer	l_cnt
//integer	l_id,l_kubun

long l_cnt

if not ddplb_syori_kbn.event input_check( ) then
	return -1
end if

if not sle_kyoten_code.event input_check( ) then
	return -1
end if

if not ddplb_calendar_kbn.event input_check( ) then
	return -1
end if

if not sle_hizuke_from.event input_check( ) then
	return -1
end if

if not sle_hizuke_to.event input_check( ) then
	return -1
end if

if not sle_tekiyo.event input_check( ) then
	return -1
end if

// 画面の値をインスタンス変数に保存
i_syori_kbn		= ddplb_syori_kbn.text
i_kyoten_code	= long( sle_kyoten_code.text )
i_calendar_kbn	= ddplb_calendar_kbn.of_get_code_num( )
i_hizuke_from	= sle_hizuke_from.text
i_hizuke_to		= sle_hizuke_to.text
i_tekiyo		= sle_tekiyo.text


// 登録時データ存在すればエラー、削除時データが存在しなければエラー
select count('*')
  into :l_cnt
  from m_calendar
 where kyoten_code	= :i_kyoten_code
   and calendar_kbn	= :i_calendar_kbn
   and hizuke >= to_number( to_char ( to_date( :i_hizuke_from || '/01'), 'yyyymmdd' ) ) 
   and hizuke <= to_number( to_char ( last_day( to_date( :i_hizuke_to || '/01')), 'yyyymmdd' ) )
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "カレンダーマスタの登録チェック処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "update_check", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return -1
end if

choose case i_syori_kbn
	case "登録"
		if l_cnt > 0 then
			msg.of_error( "既にデータが存在しています。" )
			return -1
		end if

	case "削除"
		if l_cnt = 0 then
			msg.of_error( "データが存在しません。" )
			return -1
		end if
end choose

return 0
end event

event close;closewithreturn( this, i_para )

end event

event openquery;call super::openquery;
i_para	= message.powerobjectparm

end event

type uo_signal from iw_modal_window`uo_signal within wse_calendar
end type

type st_date from iw_modal_window`st_date within wse_calendar
end type

type st_user_mei from iw_modal_window`st_user_mei within wse_calendar
integer x = 8
integer y = 135
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wse_calendar
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wse_calendar
end type

type st_title from iw_modal_window`st_title within wse_calendar
integer x = 40
end type

type st_title_upper from iw_modal_window`st_title_upper within wse_calendar
end type

type st_upper from iw_modal_window`st_upper within wse_calendar
integer width = 3836
end type

type st_tail from iw_modal_window`st_tail within wse_calendar
integer x = 20
integer y = 711
integer width = 1456
end type

type cb_ok from iw_modal_window`cb_ok within wse_calendar
integer x = 548
integer y = 729
integer taborder = 90
fontcharset fontcharset = shiftjis!
end type

event execution;call super::execution;// 画面の値でデータ作成


end event

type cb_cancel from iw_modal_window`cb_cancel within wse_calendar
integer x = 1012
integer y = 729
integer taborder = 100
end type

type dw_list from iw_modal_window`dw_list within wse_calendar
integer width = 2672
integer height = 0
integer taborder = 0
end type

type cb_retrieve from iw_modal_window`cb_retrieve within wse_calendar
boolean visible = false
integer x = 992
integer taborder = 0
end type

type st_calendar_kbn from ivo_statictext within wse_calendar
integer x = 32
integer y = 366
integer width = 408
boolean bringtotop = true
string text = "区分"
alignment alignment = right!
end type

type ddplb_calendar_kbn from sv_ddplb_meisyo within wse_calendar
integer x = 460
integer y = 359
integer width = 348
integer taborder = 40
boolean bringtotop = true
boolean chk_required = true
integer meisyo_kbn = 145
integer meisyo_no = 1
end type

on ddplb_calendar_kbn.destroy
call sv_ddplb_meisyo::destroy
end on

event selectionchanged;call super::selectionchanged;sle_calendar_kbn_code.text = this.of_get_code( )
end event

event constructor;call super::constructor;this.event selectionchanged( this.i_idx )
end event

type st_hizuke_from from ivo_statictext within wse_calendar
integer x = 32
integer y = 466
integer width = 408
boolean bringtotop = true
string text = "範囲"
alignment alignment = right!
end type

type st_calendar_kbn_code from ivo_statictext within wse_calendar
integer x = 828
integer y = 366
integer width = 488
boolean bringtotop = true
string text = "摘要表示位置"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wse_calendar
integer x = 460
integer y = 160
integer taborder = 10
boolean bringtotop = true
boolean chk_required = true
boolean visible_henkou = false
boolean visible_syokai = false
string init_disp = "登録"
end type

event selectionchanged;call super::selectionchanged;
choose case this.text
	case "登録"
		sle_tekiyo.of_set_displayonly( false )
	case "削除"
		sle_tekiyo.of_set_displayonly( true )
end choose


end event

type st_syori_kbn from ivo_statictext within wse_calendar
integer x = 32
integer y = 167
integer width = 408
boolean bringtotop = true
string text = "処理区分"
alignment alignment = right!
end type

type st_5 from ivo_statictext within wse_calendar
integer x = 724
integer y = 167
integer width = 648
boolean bringtotop = true
string text = "※登録・削除のみ"
alignment alignment = right!
end type

type st_6 from ivo_statictext within wse_calendar
integer x = 1424
integer y = 466
integer width = 968
boolean bringtotop = true
string text = "※最大12ケ月まで指定可能"
alignment alignment = right!
end type

type st_tekiyo from ivo_statictext within wse_calendar
integer x = 32
integer y = 565
integer width = 408
boolean bringtotop = true
string text = "摘要初期値"
alignment alignment = right!
end type

type st_hizuke_to from ivo_statictext within wse_calendar
integer x = 888
integer y = 466
integer width = 88
boolean bringtotop = true
string text = "～"
alignment alignment = center!
end type

type sle_hizuke_from from ivo_singlelineedit within wse_calendar
string tag = "範囲（from）"
integer x = 460
integer y = 459
integer width = 408
integer taborder = 60
boolean bringtotop = true
string text = ""
boolean chk_required = true
boolean chk_type_yearmonth = true
end type

event input_check;call super::input_check;// TODO:年月チェック、大小チェック

return of_check()
end event

type sle_hizuke_to from ivo_singlelineedit within wse_calendar
string tag = "範囲（to）"
integer x = 996
integer y = 459
integer width = 408
integer taborder = 70
boolean bringtotop = true
string text = ""
boolean chk_required = true
boolean chk_type_yearmonth = true
end type

event input_check;call super::input_check;// TODO:年月チェック、大小チェック

return of_check()
end event

type sle_tekiyo from ivo_singlelineedit within wse_calendar
integer x = 460
integer y = 562
integer width = 1264
integer taborder = 80
boolean bringtotop = true
string text = ""
end type

type sle_calendar_kbn_code from ivo_singlelineedit within wse_calendar
integer x = 1368
integer y = 359
integer width = 88
integer taborder = 50
boolean bringtotop = true
long backcolor = 553648127
string text = ""
boolean displayonly = true
boolean righttoleft = true
end type

type sle_kyoten_code from ivo_singlelineedit within wse_calendar
string tag = "対処拠点"
integer x = 460
integer y = 260
integer width = 180
integer taborder = 20
boolean bringtotop = true
long backcolor = 67108864
string text = ""
boolean displayonly = true
boolean righttoleft = true
boolean chk_required = true
end type

type sle_kyoten_ryakumei from ivo_singlelineedit within wse_calendar
integer x = 680
integer y = 260
integer width = 408
integer taborder = 30
boolean bringtotop = true
long backcolor = 553648127
string text = ""
boolean displayonly = true
end type

type st_1 from ivo_statictext within wse_calendar
integer x = 32
integer y = 267
integer width = 408
boolean bringtotop = true
string text = "対処拠点"
alignment alignment = right!
end type

