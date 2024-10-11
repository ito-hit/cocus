$PBExportHeader$w_log_sample.srw
$PBExportComments$ログ照会
forward
global type w_log_sample from iw_main_window
end type
type dw_list from ivo_datawindow within w_log_sample
end type
type st_syori_date from ivo_statictext within w_log_sample
end type
type sle_str_date from ivo_singlelineedit within w_log_sample
end type
type sle_str_time from ivo_singlelineedit within w_log_sample
end type
type st_between_date from ivo_statictext within w_log_sample
end type
type sle_end_date from ivo_singlelineedit within w_log_sample
end type
type sle_end_time from ivo_singlelineedit within w_log_sample
end type
type uo_user_id from cv_input_user_id within w_log_sample
end type
type st_log from ivo_statictext within w_log_sample
end type
type sle_start_log from ivo_singlelineedit within w_log_sample
end type
type st_between_log from ivo_statictext within w_log_sample
end type
type sle_end_log from ivo_singlelineedit within w_log_sample
end type
type cbx_info from ivo_checkbox within w_log_sample
end type
type cbx_alert from ivo_checkbox within w_log_sample
end type
type cbx_error from ivo_checkbox within w_log_sample
end type
type st_pg from ivo_statictext within w_log_sample
end type
type sle_pg from ivo_singlelineedit within w_log_sample
end type
type st_event from ivo_statictext within w_log_sample
end type
type sle_event from ivo_singlelineedit within w_log_sample
end type
type st_com from ivo_statictext within w_log_sample
end type
type sle_client from ivo_singlelineedit within w_log_sample
end type
type st_error from ivo_statictext within w_log_sample
end type
type sle_error from ivo_singlelineedit within w_log_sample
end type
type st_msg from ivo_statictext within w_log_sample
end type
type sle_msg from ivo_singlelineedit within w_log_sample
end type
type cb_back from ivo_commandbutton within w_log_sample
end type
type cb_move from ivo_commandbutton within w_log_sample
end type
type sle_filter from ivo_singlelineedit within w_log_sample
end type
type lstr_filter from structure within w_log_sample
end type
end forward

type lstr_filter from structure
	boolean		dblclk		descriptor "comment" = "検索枠"
	string		str_date		descriptor "comment" = "検索枠"
	string		str_time		descriptor "comment" = "検索枠"
	string		end_date		descriptor "comment" = "検索枠"
	string		end_time		descriptor "comment" = "検索枠"
	long		str_seq		descriptor "comment" = "検索枠"
	long		end_seq		descriptor "comment" = "検索枠"
	string		user_id		descriptor "comment" = "検索枠"
	boolean		chk_info		descriptor "comment" = "検索枠"
	boolean		chk_warm		descriptor "comment" = "検索枠"
	boolean		chk_error		descriptor "comment" = "検索枠"
	string		pg_id		descriptor "comment" = "検索枠"
	string		event_id		descriptor "comment" = "検索枠"
	string		client_id		descriptor "comment" = "検索枠"
	long		error_code		descriptor "comment" = "検索枠"
	string		msg		descriptor "comment" = "検索枠"
	string		dblclk_filter		descriptor "comment" = "ダブルクリックされた条件式"
	string		filter_string		descriptor "comment" = "DWにセットするフィルタ構文"
end type

global type w_log_sample from iw_main_window
string title = "ログ照会"
dw_list dw_list
st_syori_date st_syori_date
sle_str_date sle_str_date
sle_str_time sle_str_time
st_between_date st_between_date
sle_end_date sle_end_date
sle_end_time sle_end_time
uo_user_id uo_user_id
st_log st_log
sle_start_log sle_start_log
st_between_log st_between_log
sle_end_log sle_end_log
cbx_info cbx_info
cbx_alert cbx_alert
cbx_error cbx_error
st_pg st_pg
sle_pg sle_pg
st_event st_event
sle_event sle_event
st_com st_com
sle_client sle_client
st_error st_error
sle_error sle_error
st_msg st_msg
sle_msg sle_msg
cb_back cb_back
cb_move cb_move
sle_filter sle_filter
end type
global w_log_sample w_log_sample

type variables
private boolean	i_filter	// フィルターモードのフラグ
private	boolean	i_close		// closeイベントが走った時にlosefocusイベントが走らないようにするフラグ

private lstr_filter	i_filter_log[]
end variables

forward prototypes
public subroutine of_filter_add (boolean p_dblclked, string p_filter)
private function string of_filter_string (lstr_filter p_filter)
public function lstr_filter of_filter_create (boolean p_dblclked, string p_filter)
public subroutine of_filter_remove ()
end prototypes

public subroutine of_filter_add (boolean p_dblclked, string p_filter);integer		l_row,l_upper
lstr_filter	l_filters[]
lstr_filter	l_filter

if i_close then
	return
end if

if not i_filter then
	return
end if

// そもそも配列存在しないなら何もしなくていいじゃない
if upperbound( i_filter_log ) > 0 then
	// ダブルクリックじゃなかったらダブルクリック前のフィルタ条件まで巻き戻し
	if not p_dblclked then
		for l_row = upperbound( i_filter_log ) to 1 step -1
			if not i_filter_log[l_row].dblclk then
				l_upper	= l_row
				exit
			end if
		next
			
		if l_row > 0 then
			for l_row = 1 to l_upper
				l_filters[l_row]	= i_filter_log[l_row]
			next
		end if

		i_filter_log	= l_filters
	else
		if len( i_filter_log[upperbound( i_filter_log )].dblclk_filter ) > 0 then
			p_filter	= fnc.strg.of_format( "{1} and {2}", i_filter_log[upperbound( i_filter_log )].dblclk_filter, p_filter )
		end if
	end if
end if

l_filter	= of_filter_create( p_dblclked, p_filter )

// フィルタログの最終と内容が同じならフィルタも追加も実施しない
if upperbound( i_filter_log ) > 0 then
	if i_filter_log[upperbound( i_filter_log )].filter_string = l_filter.filter_string then
		return
	end if
end if

// フィルタ
dw_list.setfilter( l_filter.filter_string )
dw_list.filter()
		
// フィルタ配列の最終行に追加
i_filter_log[upperbound( i_filter_log ) + 1]	= l_filter

end subroutine

private function string of_filter_string (lstr_filter p_filter);string	l_filter

l_filter	= ""

if not isnull( p_filter.str_date ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} dates>={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), fnc.strg.of_replace( p_filter.str_date, "/", "" ) ),  false )
end if

if not isnull( p_filter.str_time ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} times>={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), fnc.strg.of_replace( p_filter.str_time, ":", "" ) ),  false )
end if

if not isnull( p_filter.end_date ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} dates<={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), fnc.strg.of_replace( p_filter.end_date, "/", "" ) ),  false )
end if

if not isnull( p_filter.end_time ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} times<={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), fnc.strg.of_replace( p_filter.end_time, ":", "" ) ),  false )
end if

if not isnull( p_filter.str_seq ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} seq_no>={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), string( p_filter.str_seq ) ), false )
end if

if not isnull( p_filter.end_seq ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} seq_no<={2}", 				fnc.of_decode( len( l_filter ), 0, "", "and" ), string( p_filter.end_seq ) ), false )
end if

if not isnull( p_filter.user_id ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} user_id='{2}'", 			fnc.of_decode( len( l_filter ), 0, "", "and" ), p_filter.user_id ), false )
end if

if not p_filter.chk_info then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} msg_lvl<>1", 				fnc.of_decode( len( l_filter ), 0, "", "and" ) ),  false )
end if

if not p_filter.chk_warm then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} msg_lvl<>3", 				fnc.of_decode( len( l_filter ), 0, "", "and" ) ), false )
end if

if not p_filter.chk_error then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} msg_lvl<>4", 				fnc.of_decode( len( l_filter ), 0, "", "and" ) ), false )
end if

if not isnull( p_filter.pg_id ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} pg_id like '%{2}%'", 		fnc.of_decode( len( l_filter ), 0, "", "and" ), p_filter.pg_id ), false )
end if

if not isnull( p_filter.event_id ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} event_id='{2}'", 			fnc.of_decode( len( l_filter ), 0, "", "and" ), p_filter.event_id ), false )
end if

if not isnull( p_filter.client_id ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} client_id like '%{2}%'", 	fnc.of_decode( len( l_filter ), 0, "", "and" ), p_filter.client_id ), false )
end if

if not isnull( p_filter.error_code ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} error_code={2}", 			fnc.of_decode( len( l_filter ), 0, "", "and" ), string( p_filter.error_code ) ),  false )
end if

if not isnull( p_filter.msg ) then
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1} msg like '%{2}%'", 			fnc.of_decode( len( l_filter ), 0, "", "and" ), p_filter.msg ), false )
end if

return l_filter
end function

public function lstr_filter of_filter_create (boolean p_dblclked, string p_filter);lstr_filter	l_str_filter

integer	l_int
string	l_str

setnull( l_int )
setnull( l_str )

if p_dblclked then
	l_str_filter.dblclk_filter	= p_filter
else
	setnull( l_str_filter.dblclk_filter )
end if

l_str_filter.dblclk	= p_dblclked

// 現在の値を構造体にセット
l_str_filter.str_date	= fnc.of_decode( len( sle_str_date.text ), 0, l_str, sle_str_date.text )
l_str_filter.str_time	= fnc.of_decode( len( sle_str_time.text ), 0, l_str, sle_str_time.text )
l_str_filter.end_date	= fnc.of_decode( len( sle_end_date.text ), 0, l_str, sle_end_date.text )
l_str_filter.end_time	= fnc.of_decode( len( sle_end_time.text ), 0, l_str, sle_end_time.text )
l_str_filter.str_seq	= fnc.of_decode( len( sle_start_log.text ), 0, l_int, long( sle_start_log.text ) )
l_str_filter.end_seq	= fnc.of_decode( len( sle_end_log.text ), 0, l_int, long( sle_end_log.text ) )
l_str_filter.user_id	= fnc.of_decode( len( uo_user_id.of_get_input() ), 0, l_str, uo_user_id.of_get_input() )
l_str_filter.chk_info	= cbx_info.checked
l_str_filter.chk_warm	= cbx_alert.checked
l_str_filter.chk_error	= cbx_error.checked
l_str_filter.pg_id		= fnc.of_decode( len( sle_pg.text ), 0, l_str, sle_pg.text )
l_str_filter.event_id	= fnc.of_decode( len( sle_event.text ), 0, l_str, sle_event.text )
l_str_filter.client_id	= fnc.of_decode( len( sle_client.text ), 0, l_str, sle_client.text )
l_str_filter.error_code	= fnc.of_decode( len( sle_error.text ), 0, l_int, long( sle_error.text ) )
l_str_filter.msg		= fnc.of_decode( len( sle_msg.text ), 0, l_str, sle_msg.text )

// フィルタ文字列生成
l_str_filter.filter_string	= of_filter_string( l_str_filter )

//msg.of_info( l_str_filter.filter_string )

return l_str_filter
end function

public subroutine of_filter_remove ();integer		l_row,l_upper
lstr_filter	l_filters[]
lstr_filter	l_filter

if i_close then
	return
end if

if not i_filter then
	return
end if

// そもそも配列存在しないなら何もしなくていいじゃない
if upperbound( i_filter_log ) > 0 then
	for l_row = 1 to upperbound( i_filter_log ) - 1
		l_filters[l_row]	= i_filter_log[l_row]
	next

	i_filter_log	= l_filters

	// フィルタ
	dw_list.setfilter( i_filter_log[upperbound( i_filter_log )].filter_string )
	dw_list.filter()
end if

end subroutine

on w_log_sample.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_syori_date=create st_syori_date
this.sle_str_date=create sle_str_date
this.sle_str_time=create sle_str_time
this.st_between_date=create st_between_date
this.sle_end_date=create sle_end_date
this.sle_end_time=create sle_end_time
this.uo_user_id=create uo_user_id
this.st_log=create st_log
this.sle_start_log=create sle_start_log
this.st_between_log=create st_between_log
this.sle_end_log=create sle_end_log
this.cbx_info=create cbx_info
this.cbx_alert=create cbx_alert
this.cbx_error=create cbx_error
this.st_pg=create st_pg
this.sle_pg=create sle_pg
this.st_event=create st_event
this.sle_event=create sle_event
this.st_com=create st_com
this.sle_client=create sle_client
this.st_error=create st_error
this.sle_error=create sle_error
this.st_msg=create st_msg
this.sle_msg=create sle_msg
this.cb_back=create cb_back
this.cb_move=create cb_move
this.sle_filter=create sle_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_syori_date
this.Control[iCurrent+3]=this.sle_str_date
this.Control[iCurrent+4]=this.sle_str_time
this.Control[iCurrent+5]=this.st_between_date
this.Control[iCurrent+6]=this.sle_end_date
this.Control[iCurrent+7]=this.sle_end_time
this.Control[iCurrent+8]=this.uo_user_id
this.Control[iCurrent+9]=this.st_log
this.Control[iCurrent+10]=this.sle_start_log
this.Control[iCurrent+11]=this.st_between_log
this.Control[iCurrent+12]=this.sle_end_log
this.Control[iCurrent+13]=this.cbx_info
this.Control[iCurrent+14]=this.cbx_alert
this.Control[iCurrent+15]=this.cbx_error
this.Control[iCurrent+16]=this.st_pg
this.Control[iCurrent+17]=this.sle_pg
this.Control[iCurrent+18]=this.st_event
this.Control[iCurrent+19]=this.sle_event
this.Control[iCurrent+20]=this.st_com
this.Control[iCurrent+21]=this.sle_client
this.Control[iCurrent+22]=this.st_error
this.Control[iCurrent+23]=this.sle_error
this.Control[iCurrent+24]=this.st_msg
this.Control[iCurrent+25]=this.sle_msg
this.Control[iCurrent+26]=this.cb_back
this.Control[iCurrent+27]=this.cb_move
this.Control[iCurrent+28]=this.sle_filter
end on

on w_log_sample.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.st_syori_date)
destroy(this.sle_str_date)
destroy(this.sle_str_time)
destroy(this.st_between_date)
destroy(this.sle_end_date)
destroy(this.sle_end_time)
destroy(this.uo_user_id)
destroy(this.st_log)
destroy(this.sle_start_log)
destroy(this.st_between_log)
destroy(this.sle_end_log)
destroy(this.cbx_info)
destroy(this.cbx_alert)
destroy(this.cbx_error)
destroy(this.st_pg)
destroy(this.sle_pg)
destroy(this.st_event)
destroy(this.sle_event)
destroy(this.st_com)
destroy(this.sle_client)
destroy(this.st_error)
destroy(this.sle_error)
destroy(this.st_msg)
destroy(this.sle_msg)
destroy(this.cb_back)
destroy(this.cb_move)
destroy(this.sle_filter)
end on

event resize;call super::resize;
st_second_upper.height	= 587
cb_retrieve.y			= 583
end event

event retrieve_event;call super::retrieve_event;string	l_str_date
string	l_str_time
string	l_end_date
string	l_end_time
string	l_str_seq
string	l_end_seq
string	l_user_id
string	l_pg_id
string	l_event_id
string	l_client_id
string	l_error_code
string	l_msg
lstr_filter	l_filter_log[]


i_filter		= false		// フィルタモードの解除
dw_list.reset()
dw_list.setfilter("")	// フィルタの解除
i_filter_log	= l_filter_log

// start_date
l_str_date		= trim( sle_str_date.text )

// start_time
l_str_time		= trim( sle_str_time.text )

// end_date
l_end_date		= trim( sle_end_date.text )

// end_time
l_end_time		= trim( sle_end_time.text )

// user_id
l_user_id		= uo_user_id.of_get_input( )

// pg_id
l_pg_id			= trim( sle_pg.text )

// event_id
l_event_id		= trim( sle_event.text )

// client_id
l_client_id		= trim( sle_client.text )

// error_code
l_error_code	= trim( sle_error.text )

// msg
l_msg			= trim( sle_msg.text )

dw_list.retrieve( l_str_date, l_end_date, l_str_time, l_end_time, l_str_seq, l_end_seq, l_user_id, l_pg_id, l_event_id, l_client_id, l_error_code, l_msg )

i_filter		= true		// フィルターモード開始
end event

event retrieve_check;call super::retrieve_check;
//if not uo_user_id.event sle_input_check() then // uo_user_idのチェック
//	uo_user_id.setfocus()
//	return -1
//end if

// cbx3個のclickイベントをコールする
end event

event closequery;call super::closequery;
i_close	= true
end event

type uo_signal from iw_main_window`uo_signal within w_log_sample
end type

type st_date from iw_main_window`st_date within w_log_sample
end type

type st_user_mei from iw_main_window`st_user_mei within w_log_sample
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_log_sample
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_log_sample
end type

type st_title from iw_main_window`st_title within w_log_sample
end type

type st_title_upper from iw_main_window`st_title_upper within w_log_sample
end type

type st_upper from iw_main_window`st_upper within w_log_sample
end type

type st_second_upper from iw_main_window`st_second_upper within w_log_sample
integer y = 142
integer height = 587
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_log_sample
integer x = 4360
integer y = 583
integer taborder = 130
end type

type dw_list from ivo_datawindow within w_log_sample
integer x = 36
integer y = 914
integer width = 4656
integer height = 1980
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_log"
boolean hscrollbar = true
boolean left_key = true
boolean right_key = true
end type

event constructor;call super::constructor;
dw_list.settransobject(cocos)
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	choose case dwo.name
		case "seq_no"
			of_filter_add( true, fnc.strg.of_format( "seq_no={1}", string( dw_list.object.seq_no[row] ) ) )
		case "lvl"
			of_filter_add( true, fnc.strg.of_format( "lvl='{1}'", string( dw_list.object.lvl[row] ) ) )
		case "syori_date"
			of_filter_add( true, fnc.strg.of_format( "syori_date='{1}'", string( dw_list.object.syori_date[row] ) ) )
		case "pg_id"
			of_filter_add( true, fnc.strg.of_format( "pg_id='{1}'", string( dw_list.object.pg_id[row] ) ) )
		case "event_id"
			of_filter_add( true, fnc.strg.of_format( "event_id='{1}'", string( dw_list.object.event_id[row] ) ) )
		case "client_id"
			of_filter_add( true, fnc.strg.of_format( "client_id='{1}'", string( dw_list.object.client_id[row] ) ) )
		case "user_id"
			of_filter_add( true, fnc.strg.of_format( "user_id='{1}'", string( dw_list.object.user_id[row] ) ) )
		case "user_mei"
			of_filter_add( true, fnc.strg.of_format( "user_mei='{1}'", string( dw_list.object.user_mei[row] ) ) )
		case "error_code"
			of_filter_add( true, fnc.strg.of_format( "error_code='{1}'", string( dw_list.object.error_code[row] ) ) )
		case "msg"
			of_filter_add( true, fnc.strg.of_format( "msg='{1}'", string( dw_list.object.msg[row] ) ) )
		case else
		// 何もしない
	end choose
end if

end event

event key_left;call super::key_left;
msg.of_info( "left" )

return 0
end event

event key_right;call super::key_right;
msg.of_info( "right" )

return 0
end event

type st_syori_date from ivo_statictext within w_log_sample
integer x = 4
integer y = 196
boolean bringtotop = true
long backcolor = 12632256
string text = "処理日時"
alignment alignment = right!
end type

type sle_str_date from ivo_singlelineedit within w_log_sample
integer x = 336
integer y = 188
integer width = 500
integer taborder = 10
boolean bringtotop = true
string text = ""
boolean chk_type_date = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type sle_str_time from ivo_singlelineedit within w_log_sample
integer x = 868
integer y = 188
integer width = 400
integer taborder = 20
boolean bringtotop = true
string text = ""
boolean chk_type_time = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type st_between_date from ivo_statictext within w_log_sample
integer x = 1300
integer y = 196
integer width = 100
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_end_date from ivo_singlelineedit within w_log_sample
integer x = 1432
integer y = 188
integer width = 500
integer taborder = 30
boolean bringtotop = true
string text = ""
boolean chk_type_date = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type sle_end_time from ivo_singlelineedit within w_log_sample
integer x = 1964
integer y = 188
integer width = 400
integer taborder = 40
boolean bringtotop = true
string text = ""
boolean chk_type_time = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type uo_user_id from cv_input_user_id within w_log_sample
integer x = 4
integer y = 313
integer taborder = 70
boolean bringtotop = true
end type

on uo_user_id.destroy
call cv_input_user_id::destroy
end on

event sle_input_check;call super::sle_input_check;of_filter_add( false, "" )

return true
end event

type st_log from ivo_statictext within w_log_sample
integer x = 2444
integer y = 196
boolean bringtotop = true
long backcolor = 12632256
string text = "ログNo."
alignment alignment = right!
end type

type sle_start_log from ivo_singlelineedit within w_log_sample
integer x = 2776
integer y = 188
integer width = 500
integer taborder = 50
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type st_between_log from ivo_statictext within w_log_sample
integer x = 3308
integer y = 196
integer width = 100
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_end_log from ivo_singlelineedit within w_log_sample
integer x = 3440
integer y = 188
integer width = 500
integer taborder = 60
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type cbx_info from ivo_checkbox within w_log_sample
integer x = 1832
integer y = 316
boolean bringtotop = true
long backcolor = 12632256
string text = "情報"
boolean checked = true
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then	// チェックされてたら「情報」は表示する
	dw_list.setfilter( "msg_lvl >= 0" )
else
	dw_list.setfilter( "msg_lvl <> 1" )
end if

dw_list.filter()
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end event

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type cbx_alert from ivo_checkbox within w_log_sample
integer x = 2216
integer y = 316
boolean bringtotop = true
long backcolor = 12632256
string text = "警告"
boolean checked = true
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then	// チェックされてたら「警告」は表示する
//	dw_list.setfilter( "msg_lvl >= 0" )
else
	dw_list.setfilter( "msg_lvl <> 3" )
end if

dw_list.filter()
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end event

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type cbx_error from ivo_checkbox within w_log_sample
integer x = 2600
integer y = 316
boolean bringtotop = true
long backcolor = 12632256
string text = "エラー"
boolean checked = true
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then	// チェックされてたら「エラー」は表示する
//	dw_list.setfilter( "msg_lvl >= 0" )
else
	dw_list.setfilter( "msg_lvl <> 4" )
end if

dw_list.filter()
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end event

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type st_pg from ivo_statictext within w_log_sample
integer x = 4
integer y = 448
boolean bringtotop = true
long backcolor = 12632256
string text = "プログラムID"
alignment alignment = right!
end type

type sle_pg from ivo_singlelineedit within w_log_sample
integer x = 344
integer y = 441
integer width = 1500
integer taborder = 80
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

event getfocus;call super::getfocus;

/* 備忘録

string	l_value

if i_filter then
//	if i_name = "pg_id" then
////		sle_str_time.text	= ""
//		return
//	end if

//	if i_name = "" then
////		sle_str_time.text	= ""
//		return
//	end if
	
	sle_pg_id.text		= "pg_id.getfocus = " + i_name
	i_pg				= sle_pg.text
	sle_filter.text		= of_filter_make( i_name )
end if


//if i_filter then
//	if i_column[upperbound( i_column )] = "pg_id" then
//		sle_str_time.text	= ""
//		return -1
//	end if
//	
//	if i_column[upperbound( i_column )] <> "" then
//		sle_str_time.text	= ""
//		return -1
//	end if
//	
//	sle_str_time.text	= "getfocus"
//else
//	if i_column then
//		sle_str_time.text	= "null"
//	end if
//end if


*/
end event

type st_event from ivo_statictext within w_log_sample
integer x = 1896
integer y = 448
boolean bringtotop = true
long backcolor = 12632256
string text = "イベントID"
alignment alignment = right!
end type

type sle_event from ivo_singlelineedit within w_log_sample
integer x = 2236
integer y = 441
integer width = 900
integer taborder = 90
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

event getfocus;call super::getfocus;


/* 備忘録

string	l_value

if i_filter then
//	if i_name = "event_id" then
////		sle_end_time.text	= ""
//		return
//	end if
//	
//	if i_name = "" then
////		sle_end_time.text	= ""
//		return
//	end if
	
	sle_event_id.text	= "event_id.getfocus = " + i_name
	i_event				= sle_event.text
	sle_filter.text	= of_filter_make( i_name )
end if

*/
end event

type st_com from ivo_statictext within w_log_sample
integer x = 3192
integer y = 448
integer width = 400
boolean bringtotop = true
long backcolor = 12632256
string text = "コンピューター名"
alignment alignment = right!
end type

type sle_client from ivo_singlelineedit within w_log_sample
integer x = 3632
integer y = 441
integer width = 1000
integer taborder = 100
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

event getfocus;call super::getfocus;


/* 備忘録

string	l_value

if i_filter then
//	if i_name = "client_id" then
////		sle_end_time.text	= ""
//		return
//	end if
//	
//	if i_name = "" then
////		sle_end_time.text	= ""
//		return
//	end if
	
	sle_com_id.text	= "client_id.getfocus = " + i_name
	i_com			= sle_com.text
	sle_filter.text	= of_filter_make( i_name )
end if

*/
end event

type st_error from ivo_statictext within w_log_sample
integer y = 587
boolean bringtotop = true
long backcolor = 12632256
string text = "エラーコード"
alignment alignment = right!
end type

type sle_error from ivo_singlelineedit within w_log_sample
integer x = 340
integer y = 580
integer taborder = 110
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type st_msg from ivo_statictext within w_log_sample
integer x = 796
integer y = 587
boolean bringtotop = true
long backcolor = 12632256
string text = "メッセージ"
alignment alignment = right!
end type

type sle_msg from ivo_singlelineedit within w_log_sample
integer x = 1136
integer y = 580
integer width = 3000
integer taborder = 120
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;of_filter_add( false, "" )
end event

type cb_back from ivo_commandbutton within w_log_sample
integer x = 3952
integer y = 764
integer taborder = 150
boolean bringtotop = true
string text = "戻る"
end type

event clicked;call super::clicked;of_filter_remove()
end event

type cb_move from ivo_commandbutton within w_log_sample
integer x = 4372
integer y = 764
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
string text = "進む"
end type

event clicked;call super::clicked;// 1つ後のフィルタ状態に進む

string	l_filter		// 最後にsetfilterするstring

//messagebox( "要素数 = " + string( upperbound( i_filter_log ) ), "i_count = " + string( i_count ) )
//if i_filter then
//	if upperbound( i_filter_log ) >= i_count then
//		dw_list.setredraw( false )
//		dw_list.setfilter( "" )
//		dw_list.filter( )		// 順番はバラバラだけど一番最初に戻せた
//		
////		of_count_plus( )
//		
//		l_filter	= i_filter_log[i_count]
//		
//		dw_list.setfilter( l_filter )
//		dw_list.filter( )
//		dw_list.setredraw( true )
//		
//		return i_count
//	end if
//end if

return 0
end event

type sle_filter from ivo_singlelineedit within w_log_sample
integer x = 60
integer y = 764
integer width = 3860
integer taborder = 160
boolean bringtotop = true
string text = ""
end type

