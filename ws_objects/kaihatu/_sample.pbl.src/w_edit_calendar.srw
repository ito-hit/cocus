$PBExportHeader$w_edit_calendar.srw
$PBExportComments$カレンダーマスタメンテナンス（編集）
forward
global type w_edit_calendar from iw_modal_window
end type
type gb_1 from ivo_groupbox within w_edit_calendar
end type
type dw_calendar from ivo_datawindow within w_edit_calendar
end type
type st_calendar_mei from ivo_statictext within w_edit_calendar
end type
end forward

global type w_edit_calendar from iw_modal_window
integer width = 2648
integer height = 1838
string title = "カレンダー編集"
gb_1 gb_1
dw_calendar dw_calendar
st_calendar_mei st_calendar_mei
end type
global w_edit_calendar w_edit_calendar

type variables
str_calendar	i_para
string			i_calendar_mei

end variables

on w_edit_calendar.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_calendar=create dw_calendar
this.st_calendar_mei=create st_calendar_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_calendar
this.Control[iCurrent+3]=this.st_calendar_mei
end on

on w_edit_calendar.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_calendar)
destroy(this.st_calendar_mei)
end on

event open;call super::open;// インスタンス変数に構造体が定義してあるため使用する構造体に変更(変数名は変更しない)するのを忘れずに //

// 画面サイズ固定 //
this.width	= PixelsToUnits ( 661, XPixelsToUnits! )
this.height	= PixelsToUnits ( 493, YPixelsToUnits! )

string	l_meisyo

// プログラム(ここから) //

select distinct 
       '[' || mid.meisyo_1 || ']' || decode( holiday_flg, 1,'(休日)','') || mkm.meisyo_1 calendar_mei,
	   mkm.meisyo_1
  into :l_meisyo,
       :i_calendar_mei
  from m_edi_calendar cal,
       m_meisyo mid,
       m_meisyo mkm
 where cal.kanri_id 		= :i_para.id
   and cal.calendar_kbn		= :i_para.kbn
   and mid.meisyo_kbn(+)	= 340
   and mid.meisyo_code(+)	= cal.kanri_id
   and mkm.meisyo_kbn(+)	= 350
   and mkm.meisyo_code		= cal.calendar_kbn
using cocos;

if cocos.sqlcode = 100 then
	select distinct mkm.meisyo_1
      into :i_calendar_mei
      from m_meisyo mid,
           m_meisyo mkm
     where mid.meisyo_kbn(+)	= 340
       and mid.meisyo_code(+)	= :i_para.id
       and mkm.meisyo_kbn(+)	= 350
       and mkm.meisyo_code		= :i_para.kbn
	using cocos;
end if	

st_calendar_mei.text	= l_meisyo

// プログラム(ここまで) //

// ↓ロジックの一番最後に設置すること //
//if open_retrieve then
	this.event retrieve_event( 0, 0 )
//end if
end event

event update_event;call super::update_event;// updatecheck_eventからの戻り値取得 //
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

// プログラム(ここから) //
dw_calendar.retrieve( i_para.nen, i_para.tuki, i_para.id, i_para.kbn )
dw_list.retrieve( i_para.id, i_para.kbn )
// プログラム(ここまで) //

// コミットの記述(サンプル) //
//commit using kbn;

// retrieve //
//dw_ichiran.retrieve()

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

end event

event retrieve_check;call super::retrieve_check;// retrieve_eventの前に動作するイベント //
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

event resize;//
// st_upper
st_upper.x		= 0
st_upper.y		= 4
st_upper.width	= newwidth
st_upper.height	= 140

// st_title_upper
st_title_upper.height	= 96
st_title_upper.width	= st_upper.width * 0.4
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title_upper.y		= st_upper.height / 2 - st_title_upper.height / 2 + st_upper.y

// st_title
st_title.height	= 82
st_title.width	= st_title_upper.width * 0.9
st_title.x		= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
st_title.y		= st_title_upper.height / 2 - st_title.height / 2 + st_title_upper.y


// st_upper
st_upper.width	= this.width - 20

// window( ログイン画面は中身でWindowsサイズを決めるため再設定 )
st_title_upper.width	= st_upper.width * 0.8
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title.width			= st_title_upper.width * 0.9
st_title.x				= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x

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


this.height		= st_tail.y + st_tail.height + 100	// 100はおまじない

uo_test_mode.visible	= false
end event

type uo_signal from iw_modal_window`uo_signal within w_edit_calendar
end type

type st_date from iw_modal_window`st_date within w_edit_calendar
end type

type st_user_mei from iw_modal_window`st_user_mei within w_edit_calendar
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_edit_calendar
boolean visible = false
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_edit_calendar
end type

type st_title from iw_modal_window`st_title within w_edit_calendar
end type

type st_title_upper from iw_modal_window`st_title_upper within w_edit_calendar
end type

type st_upper from iw_modal_window`st_upper within w_edit_calendar
integer width = 2608
end type

type st_tail from iw_modal_window`st_tail within w_edit_calendar
integer y = 1522
integer width = 2608
end type

type cb_ok from iw_modal_window`cb_ok within w_edit_calendar
integer x = 1680
integer y = 1536
end type

type cb_cancel from iw_modal_window`cb_cancel within w_edit_calendar
integer x = 2144
integer y = 1536
end type

type dw_list from iw_modal_window`dw_list within w_edit_calendar
integer x = 1264
integer y = 156
integer width = 1328
integer height = 1351
integer taborder = 70
string dataobject = "d_edit_calendar_list"
boolean vscrollbar = true
boolean row_focus_ind = false
end type

event constructor;call super::constructor;this.settransobject(cocos)
end event

event itemchanged;call super::itemchanged;
string	l_column_type
integer	l_column_length

if isnull( trim(data) ) or len(trim(data)) = 0 then
	this.object.bikou_flg[row]	= 0
	data	= " "
else
	if not fnc.db.of_get_column_info( "M_EDI_CALENDAR", "BIKOU", l_column_type, l_column_length ) then
		msg.of_error_dwo( dwo, "カラム情報が取得できません。" )
		return 1
	else
		if l_column_length < lena(data) then
			msg.of_error_dwo( dwo, "備考欄の入力可能数をオーバーしています。~r~n( 入力値：" + string( lena( trim( fo_nvl( data, "" ) ) ) ) + " / 最大値：" + string( l_column_length ) + " )" )
			return 1
		end if
		this.setitemstatus( row, 0, Primary!, DataModified! )
		this.object.bikou_flg[row]	= 1
	end if
end if

end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_edit_calendar
boolean visible = false
integer x = 304
integer y = 18
end type

type gb_1 from ivo_groupbox within w_edit_calendar
integer x = 16
integer y = 171
integer width = 1216
integer height = 171
integer taborder = 90
string text = "カレンダーの種類"
end type

type dw_calendar from ivo_datawindow within w_edit_calendar
integer x = 16
integer y = 356
integer width = 1232
integer height = 1152
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_edit_calendar"
boolean resizable = true
boolean livescroll = false
end type

event rowfocuschanged;//
end event

event buttonclicked;call super::buttonclicked;integer l_nen,l_tuki
string	l_date_string

l_nen	= this.object.nen[row]
l_tuki	= this.object.tuki[row]

l_date_string	= string( l_nen * 10000 + l_tuki * 100 + 1 )

choose case dwo.name
	case "b_next"
		select extract( year  from add_months(to_date(:l_date_string, 'yyyymmdd'), 1 ) ),
			   extract( month from add_months(to_date(:l_date_string, 'yyyymmdd'), 1 ) )
		  into :l_nen,:l_tuki
		  from dual
		using cocos;
	case "b_prior"
		select extract( year  from add_months(to_date(:l_date_string, 'yyyymmdd'), -1 ) ),
			   extract( month from add_months(to_date(:l_date_string, 'yyyymmdd'), -1 ) )
		  into :l_nen,:l_tuki
		  from dual
		using cocos;
end choose

i_para.nen	= l_nen
i_para.tuki	= l_tuki

this.retrieve( l_nen, l_tuki, i_para.id, i_para.kbn )
end event

event clicked;call super::clicked;integer	l_day
boolean	l_enabled

string	l_rowid

if left( dwo.name, pos(dwo.name,"_") - 1 ) = "day" then
	l_day	= this.getitemnumber( row, string( dwo.name ) )

	// 日付が入ってないのは無視 //
	if l_day = 0 then
		return 0
	end if
	
	if this.getitemnumber( row, "enabled" + mid( dwo.name, pos(dwo.name,"_") ) ) = 1 then
		this.setitem( row, "enabled" + mid( dwo.name, pos(dwo.name,"_") ), 0 )
		l_enabled	= False
	else
		this.setitem( row, "enabled" + mid( dwo.name, pos(dwo.name,"_") ), 1 )
		l_enabled	= True
	end if
	
	dw_list.setredraw( False )
	// DB更新及びリスト更新 //
	if l_enabled then
		insert into m_edi_calendar( kanri_id,calendar_kbn,
		                        holiday_flg,edit_flg,
								calendar_year,calendar_month,calendar_day,
								enabled,
								bikou_flg,bikou,
								touroku_user_id,touroku_client_id,touroku_pg_id,touroku_date,
								kousin_user_id,kousin_client_id,kousin_pg_id,kousin_date
		                      )
					    values( :i_para.id, :i_para.kbn,
						        :i_para.holiday_flg, 1,
								:i_para.nen, :i_para.tuki, :l_day,
								1,
								1,:i_calendar_mei,
								:user.user_id,:device.name,:i_pg_id,sysdate,
								:user.user_id,:device.name,:i_pg_id,sysdate
							  )
		using cocos;

		if cocos.sqlcode <> 0 then
			messagebox("エラー","カレンダー情報の更新に失敗しました。~r~n" + cocos.sqlerrtext )
			return -1
		end if
		
		// リスト情報を更新 //
		integer	l_row
		integer		l_holiday_flg,l_edit_flg,l_bikou_flg,l_touroku_user_id,l_kousin_user_id
		string		l_bikou,l_touroku_client_id,l_touroku_pg_id,l_kousin_client_id,l_kousin_pg_id
		datetime	l_touroku_date,l_kousin_date

		l_row	= dw_list.insertrow(0)

		select holiday_flg,edit_flg,
			   bikou_flg,bikou,
			   touroku_user_id,touroku_client_id,touroku_pg_id,touroku_date,
			   kousin_user_id,kousin_client_id,kousin_pg_id,kousin_date,
			   rowid
		  into :l_holiday_flg,:l_edit_flg,
		       :l_bikou_flg,:l_bikou,
			   :l_touroku_user_id,:l_touroku_client_id,:l_touroku_pg_id,:l_touroku_date,
			   :l_kousin_user_id,:l_kousin_client_id,:l_kousin_pg_id,:l_kousin_date,
			   :l_rowid
		  from m_edi_calendar
		 where kanri_id			= :i_para.id
		   and calendar_kbn		= :i_para.kbn
		   and calendar_year	= :i_para.nen
		   and calendar_month	= :i_para.tuki
		   and calendar_day		= :l_day
		using cocos;

		dw_list.object.kanri_id[l_row]			= i_para.id
		dw_list.object.calendar_kbn[l_row]		= i_para.kbn
		dw_list.object.holiday_flg[l_row]		= l_holiday_flg
		dw_list.object.edit_flg[l_row]			= l_edit_flg
		dw_list.object.calendar_year[l_row]		= i_para.nen
		dw_list.object.calendar_month[l_row]	= i_para.tuki
		dw_list.object.calendar_day[l_row]		= l_day
		dw_list.object.enabled[l_row]			= fnc.of_cnv_bool2int( l_enabled )
		dw_list.object.bikou_flg[l_row]			= l_bikou_flg
		dw_list.object.bikou[l_row]				= l_bikou
		dw_list.object.touroku_user_id[l_row]	= l_touroku_user_id
		dw_list.object.touroku_client_id[l_row]	= l_touroku_client_id
		dw_list.object.touroku_pg_id[l_row]		= l_touroku_pg_id
		dw_list.object.touroku_date[l_row]		= l_touroku_date
		dw_list.object.kousin_user_id[l_row]	= l_kousin_user_id
		dw_list.object.kousin_client_id[l_row]	= l_kousin_client_id
		dw_list.object.kousin_pg_id[l_row]		= l_kousin_pg_id
		dw_list.object.kousin_date[l_row]		= l_kousin_date
		dw_list.object.rowid[l_row]				= l_rowid
		
		dw_list.setitemstatus( l_row, 0, Primary!, NotModified! )
	else
		select rowid
		  into :l_rowid
		  from m_edi_calendar
		 where kanri_id			= :i_para.id
		   and calendar_kbn		= :i_para.kbn
		   and calendar_year	= :i_para.nen
		   and calendar_month	= :i_para.tuki
		   and calendar_day		= :l_day
		using cocos;
	
		if cocos.sqlcode <> 0 then
			messagebox("エラー","カレンダー情報の取得に失敗しました。~r~n" + cocos.sqlerrtext )
			return -1
		else
//			delete from m_edi_calendar where rowid = :l_rowid using cocos;

//			if cocos.sqlcode <> 0 then
//				messagebox("エラー","カレンダー情報の更新に失敗しました。~r~n" + cocos.sqlerrtext )
//				return -1
//			end if
			
			// リスト情報を更新 //
			l_row = dw_list.find( "calendar_year=" + string(i_para.nen) + " and calendar_month=" + string(i_para.tuki) + " and calendar_day = " + string(l_day), 1, dw_list.rowcount() )
			dw_list.deleterow(l_row)
		end if
	end if
end if

dw_list.setsort("calendar_year,calendar_month,calendar_day")
dw_list.sort( )
dw_list.setredraw( True )

end event

event itemchanged;call super::itemchanged;string	l_column_type
integer	l_column_length

if isnull( trim(data) ) or len(trim(data)) = 0 then
	this.object.bikou_flg[row]	= 0
	data	= " "
else
	
	if not fnc.db.of_get_column_info( "M_EDI_CALENDAR", "BIKOU", l_column_type, l_column_length ) then
		msg.of_error_dwo( dwo, "カラム情報が取得できません。" )
		return 1
	else
		if l_column_length < lena(data) then
			msg.of_error_dwo( dwo, "備考欄の入力可能数をオーバーしています。~r~n( 入力値：" + string( lena( trim( fo_nvl( data, "" ) ) ) ) + " / 最大値：" + string( l_column_length ) + " )" )
			return 1
		end if
		this.setitemstatus( row, 0, Primary!, DataModified! )
		this.object.bikou_flg[row]	= 1
	end if
end if

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

type st_calendar_mei from ivo_statictext within w_edit_calendar
integer x = 48
integer y = 242
integer width = 1152
boolean bringtotop = true
string text = "[本社]稼働日"
end type

