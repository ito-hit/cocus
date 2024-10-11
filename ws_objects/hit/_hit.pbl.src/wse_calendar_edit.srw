$PBExportHeader$wse_calendar_edit.srw
$PBExportComments$カレンダー編集
forward
global type wse_calendar_edit from iw_modal_window
end type
type gb_1 from ivo_groupbox within wse_calendar_edit
end type
type dw_calendar from ivo_datawindow within wse_calendar_edit
end type
type st_calendar_mei from ivo_statictext within wse_calendar_edit
end type
type cb_ikkatu_copy from ivo_commandbutton within wse_calendar_edit
end type
type cb_zengyo_copy from ivo_commandbutton within wse_calendar_edit
end type
end forward

global type wse_calendar_edit from iw_modal_window
integer width = 2648
integer height = 1838
string title = "カレンダー編集"
gb_1 gb_1
dw_calendar dw_calendar
st_calendar_mei st_calendar_mei
cb_ikkatu_copy cb_ikkatu_copy
cb_zengyo_copy cb_zengyo_copy
end type
global wse_calendar_edit wse_calendar_edit

type variables
str_calendar	i_para
string			i_filter_ini = "taisyo_flg = 1"
integer			i_nen, i_tuki
end variables
on wse_calendar_edit.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_calendar=create dw_calendar
this.st_calendar_mei=create st_calendar_mei
this.cb_ikkatu_copy=create cb_ikkatu_copy
this.cb_zengyo_copy=create cb_zengyo_copy
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_calendar
this.Control[iCurrent+3]=this.st_calendar_mei
this.Control[iCurrent+4]=this.cb_ikkatu_copy
this.Control[iCurrent+5]=this.cb_zengyo_copy
end on

on wse_calendar_edit.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_calendar)
destroy(this.st_calendar_mei)
destroy(this.cb_ikkatu_copy)
destroy(this.cb_zengyo_copy)
end on

event open;call super::open;// インスタンス変数に構造体が定義してあるため使用する構造体に変更(変数名は変更しない)するのを忘れずに //

// 画面サイズ固定 //
this.width	= PixelsToUnits ( 661, XPixelsToUnits! )
this.height	= PixelsToUnits ( 493, YPixelsToUnits! )

string	l_meisyo

// データが無い場合は存在するMAX年月のデータを表示する

// 拠点名＋カレンダー区分名を設定する
l_meisyo = "[" + i_para.kyoten_mei_ryaku + "]" + i_para.kbn_mei

st_calendar_mei.text	= l_meisyo

this.event retrieve_event( 0, 0 )

end event

event update_event;call super::update_event;
// updatecheck_eventからの戻り値取得 //
if AncestorReturnValue = -1 then
// ロールバックの記述(サンプル) //
//  rollback using kbn;	
//	close(popup_process)
	return -1
end if

// プログラム(ここから) //

dw_list.update()

// プログラム(ここまで) //

// コミットの記述(サンプル) //
commit using cocos;

i_para.answer	= True

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

event close( )
end event

event retrieve_event;call super::retrieve_event;// retrievecheck_event先祖からの戻り値取得 //
if AncestorReturnValue = -1 then
// ロールバックの記述(サンプル) //
//  rollback using kbn;	
//	close(popup_process)
	return -1
end if

// カレンダー枠（左側D/W）の初期表示は、当月１ケ月分とする。当月分が未登録の場合は、当該カレンダー区分に登録済みの最後の月を表示する。
select coalesce( max( case when hizuke = to_char( sysdate, 'yyyymmdd' ) then nen end ), max( nen ) )	nen,
  	   coalesce( max( case when hizuke = to_char( sysdate, 'yyyymmdd' ) then tuki end ), max( tuki ) )	tuki
  into :i_nen,
  	   :i_tuki
  from m_calendar
 where kyoten_code	= :i_para.kyoten
   and calendar_kbn	= :i_para.kbn
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "カレンダー編集の検索処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "retrieve_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
end if

if isnull( i_nen ) or isnull( i_tuki ) then
	return -1
end if

dw_calendar.retrieve( i_para.kyoten, i_para.kbn, i_nen, i_tuki )
dw_list.retrieve( i_para.kyoten, i_para.kbn, i_nen )


end event

event update_check;// update_eventの前に動作するイベント //
if dw_list.accepttext( ) <> 1 then
	return -1
end if

end event

event close;closewithreturn( this, i_para )

end event

event openquery;call super::openquery;
i_para	= message.powerobjectparm

end event

event resize;// st_upper
st_upper.width	= this.width - 20

// st_tail
st_tail.width	= st_upper.width
st_tail.y		= dw_list.y + dw_list.height + code.MGN_TATE

// cb_cancel
cb_cancel.width		= 340
cb_cancel.y			= st_tail.height / 2 - cb_cancel.height / 2 + st_tail.y
cb_cancel.x			= st_tail.width - cb_cancel.width - code.MGN_YOKO

// cb_ok
cb_ok.width		= 340
cb_ok.y			= st_tail.height / 2 - cb_ok.height / 2 + st_tail.y
cb_ok.x			= cb_cancel.x - cb_ok.width - code.MGN_GROUP_YOKO

// cb_ikkatu_copy
cb_ikkatu_copy.width	= 340
cb_ikkatu_copy.y		= st_tail.height / 2 - cb_ikkatu_copy.height / 2 + st_tail.y
cb_ikkatu_copy.x		= cb_ok.x - cb_ikkatu_copy.width - code.MGN_GROUP_YOKO

// cb_zengyo_copy
cb_zengyo_copy.width	= 340
cb_zengyo_copy.y		= st_tail.height / 2 - cb_zengyo_copy.height / 2 + st_tail.y
cb_zengyo_copy.x		= cb_ikkatu_copy.x - cb_zengyo_copy.width - code.MGN_GROUP_YOKO


this.height		= st_tail.y + st_tail.height + 100	// 100はおまじない

uo_test_mode.visible	= false
end event

type uo_signal from iw_modal_window`uo_signal within wse_calendar_edit
end type

type st_date from iw_modal_window`st_date within wse_calendar_edit
end type

type st_user_mei from iw_modal_window`st_user_mei within wse_calendar_edit
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wse_calendar_edit
boolean visible = false
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wse_calendar_edit
end type

type st_title from iw_modal_window`st_title within wse_calendar_edit
end type

type st_title_upper from iw_modal_window`st_title_upper within wse_calendar_edit
end type

type st_upper from iw_modal_window`st_upper within wse_calendar_edit
integer width = 2608
end type

type st_tail from iw_modal_window`st_tail within wse_calendar_edit
integer y = 1522
integer width = 2608
end type

type cb_ok from iw_modal_window`cb_ok within wse_calendar_edit
integer x = 1680
integer y = 1536
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wse_calendar_edit
integer x = 2144
integer y = 1536
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wse_calendar_edit
integer x = 1264
integer y = 156
integer width = 1328
integer height = 1351
integer taborder = 10
string dataobject = "dse_calendar_edit_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean row_focus_ind = false
end type

event constructor;call super::constructor;this.settransobject(cocos)

this.setfilter( i_filter_ini )
this.filter( )
end event

event doubleclicked;call super::doubleclicked;
choose case dwo.name
	case "tekiyo"
		parent.cb_ikkatu_copy.event clicked( )
end choose
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wse_calendar_edit
boolean visible = false
integer x = 304
integer y = 18
integer taborder = 60
end type

type gb_1 from ivo_groupbox within wse_calendar_edit
integer x = 16
integer y = 171
integer width = 1216
integer height = 171
string text = "カレンダーの種類"
end type

type dw_calendar from ivo_datawindow within wse_calendar_edit
integer x = 16
integer y = 356
integer width = 1232
integer height = 1152
boolean bringtotop = true
string dataobject = "dse_calendar_edit_entry"
boolean resizable = true
boolean livescroll = false
end type

event rowfocuschanged;//
end event

event buttonclicked;call super::buttonclicked;integer l_nen_moto
string	l_date_string, l_column_name

long l_row, l_colcnt

l_nen_moto	= this.object.nen[row]
i_nen		= this.object.nen[row]
i_tuki		= this.object.tuki[row]

l_date_string	= string( i_nen * 10000 + i_tuki * 100 + 1 )

choose case dwo.name
	case "b_next"
		select extract( year  from add_months(to_date(:l_date_string, 'yyyymmdd'), 1 ) ),
			   extract( month from add_months(to_date(:l_date_string, 'yyyymmdd'), 1 ) )
		  into :i_nen,:i_tuki
		  from dual
		using cocos;
	case "b_prior"
		select extract( year  from add_months(to_date(:l_date_string, 'yyyymmdd'), -1 ) ),
			   extract( month from add_months(to_date(:l_date_string, 'yyyymmdd'), -1 ) )
		  into :i_nen,:i_tuki
		  from dual
		using cocos;
end choose

parent.setredraw( false )

this.retrieve( i_para.kyoten, i_para.kbn, i_nen, i_tuki )

if l_nen_moto <> i_nen then
	// 年が変わる場合、リストを検索する
	dw_list.retrieve( i_para.kyoten, i_para.kbn, i_nen )
else

	// 年が同じ場合、カレンダー検索後、リストのtaisyo_flgをカレンダーのtaisyo_flgにセットする
	dw_list.setfilter( "calendar_month = " + string( i_tuki ) )
	dw_list.filter( )
	
	for l_row = 1 to dw_list.rowcount( )
	
		for l_colcnt = 1 to long( this.describe( "datawindow.column.count" ) )
	
			l_column_name = this.describe( "#" + string( l_colcnt ) + ".name" )
	
			if match( l_column_name, "^day_" ) then
				if this.getitemnumber( 1, l_column_name ) = dw_list.object.calendar_day[l_row] then
					this.setitem( 1, replace( l_column_name, 1, 3, "taisyo_flg" ), dw_list.object.taisyo_flg[l_row] )    
				end if
			end if
		next
	next

end if

dw_list.setfilter( i_filter_ini )
dw_list.filter( )

parent.setredraw( true )



end event

event clicked;call super::clicked;integer	l_day, l_row, l_taisyo_flg
string	l_rowid, l_hizuke, l_renban

if left( dwo.name, pos(dwo.name,"_") - 1 ) = "day" then
	l_day	= this.getitemnumber( row, string( dwo.name ) )

	// 日付が入ってないのは無視 //
	if l_day = 0 then
		return 0
	end if

	dw_list.setredraw( False )

	dw_list.setfilter( "" )
	dw_list.filter( )

	l_hizuke	= string( i_nen ) + string( i_tuki, "00" ) + string( l_day, "00" )
	l_row		= dw_list.find( "hizuke = " + l_hizuke, 1, dw_list.rowcount( ) )

	if l_row > 0 then

		// カラム名から連番部分を取得
		l_renban		= mid( dwo.name, pos( dwo.name,"_" ) )

		// 対象フラグを反転させた値を取得
		l_taisyo_flg	= 1 - this.getitemnumber( row, "taisyo_flg" + l_renban )

		// カレンダーに対象フラグをセット
		this.setitem( row, "taisyo_flg" + l_renban, l_taisyo_flg )

		// リストに対象フラグをセット
		dw_list.object.taisyo_flg[l_row] = l_taisyo_flg

	end if

end if

dw_list.setfilter( i_filter_ini )
dw_list.filter( )

dw_list.setsort("calendar_year,calendar_month,calendar_day")
dw_list.sort( )
dw_list.setredraw( True )

end event

event sqlpreview;call super::sqlpreview;string	l_old,l_new
string	l_insert,l_update
string	l_set,l_into,l_values,l_where

l_old	= sqlsyntax

choose case sqltype
	case PreviewInsert!
		return 2
	case PreviewDelete!
		return 2
	case PreviewUpdate!
		l_update	= mid( l_old, 1, pos( l_old, "WHERE" ) - 1 )
		l_where		= mid( l_old, pos( l_old, "WHERE" ), len( l_old ) - pos( l_old, "WHERE" ) )
		l_set 		= ",kousin_user_id = " + string( user.user_id ) + ",kousin_client_id = '" + device.name + "',kousin_pg_id = '" + i_pg_id + "',kousin_date = sysdate "
		l_new		= l_update + l_set + l_where
	case else
		l_new	= l_old
end choose

this.setsqlpreview(l_new)

end event

event constructor;call super::constructor;this.settransobject(cocos)
end event

type st_calendar_mei from ivo_statictext within wse_calendar_edit
integer x = 48
integer y = 242
integer width = 1152
boolean bringtotop = true
string text = "[本社]稼働日"
end type

type cb_ikkatu_copy from ivo_commandbutton within wse_calendar_edit
integer x = 1268
integer y = 1536
integer taborder = 30
boolean bringtotop = true
string text = "一括複写"
end type

event execution;call super::execution;
// 一括複写
// フォーカス行の値を次行以降へ一括複写、ただし既に値が入っている行が現れた場合はその前行まで貼り付ける仕様とする
long l_row
string l_tekiyo

if dw_list.accepttext( ) = -1 then
	return -1
end if

l_tekiyo	= dw_list.object.tekiyo[ dw_list.getrow( ) ]

for l_row = dw_list.getrow( ) + 1 to dw_list.rowcount( )
	
	if dw_list.object.tekiyo[ l_row ] <> "" and not isnull( dw_list.object.tekiyo[ l_row ] ) then
		exit
	end if
	
	dw_list.object.tekiyo[ l_row ] = l_tekiyo

next

dw_list.setfocus( )

return 0
end event

type cb_zengyo_copy from ivo_commandbutton within wse_calendar_edit
integer x = 848
integer y = 1536
integer taborder = 20
boolean bringtotop = true
string text = "前行複写"
end type

event execution;call super::execution;
// 前行複写
long l_row

l_row	= dw_list.getrow( )

if l_row <= 1 then
	return 0
end if

dw_list.object.tekiyo[ l_row ]	= dw_list.object.tekiyo[ l_row - 1 ]
dw_list.setfocus( )
end event

