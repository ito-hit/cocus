$PBExportHeader$w_log.srw
$PBExportComments$ログ照会
forward
global type w_log from iw_main_window
end type
type dw_list from ivo_datawindow within w_log
end type
type st_syori_date from ivo_statictext within w_log
end type
type sle_str_date from ivo_singlelineedit within w_log
end type
type sle_str_time from ivo_singlelineedit within w_log
end type
type st_between_date from ivo_statictext within w_log
end type
type sle_end_date from ivo_singlelineedit within w_log
end type
type sle_end_time from ivo_singlelineedit within w_log
end type
type uo_user_id from cv_input_user_id within w_log
end type
type st_log from ivo_statictext within w_log
end type
type sle_str_seq from ivo_singlelineedit within w_log
end type
type st_between_log from ivo_statictext within w_log
end type
type sle_end_seq from ivo_singlelineedit within w_log
end type
type cbx_info from ivo_checkbox within w_log
end type
type cbx_alert from ivo_checkbox within w_log
end type
type cbx_filter from ivo_checkbox within w_log
end type
type st_pg from ivo_statictext within w_log
end type
type sle_pg from ivo_singlelineedit within w_log
end type
type st_event from ivo_statictext within w_log
end type
type sle_event from ivo_singlelineedit within w_log
end type
type st_client from ivo_statictext within w_log
end type
type sle_client from ivo_singlelineedit within w_log
end type
type st_error from ivo_statictext within w_log
end type
type sle_error from ivo_singlelineedit within w_log
end type
type st_msg from ivo_statictext within w_log
end type
type sle_msg from ivo_singlelineedit within w_log
end type
type cb_back from ivo_commandbutton within w_log
end type
type cb_move from ivo_commandbutton within w_log
end type
type sle_filter from ivo_singlelineedit within w_log
end type
type cbx_error from ivo_checkbox within w_log
end type
type cbx_care from ivo_checkbox within w_log
end type
type str_filter_log from structure within w_log
end type
end forward

type str_filter_log from structure
	boolean		p_double
	long		p_str_date
	long		p_str_time
	long		p_end_date
	long		p_end_time
	long		p_str_seq
	long		p_end_seq
	string		p_user_id
	long		p_lvl_info
	long		p_lvl_care
	long		p_lvl_alert
	long		p_lvl_error
	string		p_pg_id
	string		p_event_id
	string		p_client_id
	long		p_error_code
	string		p_msg
	string		p_double_filter
end type

global type w_log from iw_main_window
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
sle_str_seq sle_str_seq
st_between_log st_between_log
sle_end_seq sle_end_seq
cbx_info cbx_info
cbx_alert cbx_alert
cbx_filter cbx_filter
st_pg st_pg
sle_pg sle_pg
st_event st_event
sle_event sle_event
st_client st_client
sle_client sle_client
st_error st_error
sle_error sle_error
st_msg st_msg
sle_msg sle_msg
cb_back cb_back
cb_move cb_move
sle_filter sle_filter
cbx_error cbx_error
cbx_care cbx_care
end type
global w_log w_log

type variables
private boolean			i_filter		// フィルターモードのフラグ
private	boolean			i_close	= false	// closeイベントが走った時にlosefocusイベントが走らないようにするフラグ

private str_filter_log	i_str_filter[]	// ローカル構造体の配列インスタンス化
private	long			i_count	= 1		// フィルターモード時の配列の要素数に対しての、戻る進むを行った現在の要素位置
end variables

forward prototypes
private function integer of_count_minus ()
private function integer of_count_plus ()
private subroutine of_filter_reset ()
private function string of_filter_create (any p_str_filter)
private function boolean of_filter (boolean p_double, string p_double_filter)
private function string of_time_format (string p_time)
end prototypes

private function integer of_count_minus ();
if i_count > 1 then
	i_count	= i_count - 1
else				// i_countが-1になるのを防ぐ
	i_count	= 0
end if

return i_count
end function

private function integer of_count_plus ();
if upperbound( i_str_filter ) <> i_count then
	i_count	= i_count + 1
end if

return i_count

end function

private subroutine of_filter_reset ();str_filter_log	l_reset[ ]

i_str_filter	= l_reset
i_count			= 1
end subroutine

private function string of_filter_create (any p_str_filter);/*--- 引数の構造体から、フィルタをかけるためのstringを作成し、returnする -----*/

str_filter_log	l_str_filter			// 引数の構造体を受けとる
string			l_filter_string	= ""	// 作成したフィルタ用のstringを最後に返す変数
string			l_date					// dateの値部分を受ける
string			l_lvl					// msg_lvlのフィルタ部分を受ける
long			l_nulll					// nullのチェック用

l_str_filter	= p_str_filter
setnull( l_nulll )

// ダブルクリック
if l_str_filter.p_double then
	l_filter_string	= fnc.of_decode( l_filter_string, "",l_str_filter.p_double_filter, l_filter_string + " and " + l_str_filter.p_double_filter )
//else
//	// 履歴用
//	if not isnull( l_str_filter.p_double_filter ) then
//		l_filter_string	= fnc.of_decode( l_filter_string, "",l_str_filter.p_double_filter, l_filter_string + " and " + l_str_filter.p_double_filter )
//	end if
end if

if not isnull( l_str_filter.p_str_date ) then
	l_date			= string( l_str_filter.p_str_date ) + fnc.of_decode( l_str_filter.p_str_time, l_nulll, "000000", string( l_str_filter.p_str_time ) )
	l_filter_string	= fnc.of_decode( l_filter_string, "", "datetimes >= " + l_date, l_filter_string + " and datetimes >= " + l_date )
else
	if not isnull( l_str_filter.p_str_time ) then
		l_filter_string	= fnc.of_decode( l_filter_string, "", "times >= " + string( l_str_filter.p_str_time ), l_filter_string + " and times >= " + string( l_str_filter.p_str_time ) )
	end if
end if

if not isnull( l_str_filter.p_end_date ) then
	l_date			= string( l_str_filter.p_end_date ) + fnc.of_decode( l_str_filter.p_end_time, l_nulll, "235959", string( l_str_filter.p_end_time ) )
	l_filter_string	= fnc.of_decode( l_filter_string, "", "datetimes <= " + l_date, l_filter_string + " and datetimes <= " + l_date )
else
	if not isnull( l_str_filter.p_end_time ) then
		l_filter_string	= fnc.of_decode( l_filter_string, "", "times <= " + string( l_str_filter.p_end_time ), l_filter_string + " and times <= " + string( l_str_filter.p_end_time ) )
	end if
end if

if not isnull( l_str_filter.p_str_seq ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "seq_no >= " + string( l_str_filter.p_str_seq ), l_filter_string + " and seq_no >= " + string( l_str_filter.p_str_seq ) )
end if

if not isnull( l_str_filter.p_end_seq ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "seq_no <= " + string( l_str_filter.p_end_seq ), l_filter_string + " and seq_no <= " + string( l_str_filter.p_end_seq ) )
end if

if not isnull( l_str_filter.p_user_id ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "user_id = '" + string( l_str_filter.p_user_id ) + "'" , l_filter_string + " and user_id = '" + l_str_filter.p_user_id + "'" )
end if

// チェックボックス部分
l_lvl			= fnc.strg.of_format( "msg_lvl in ( {1}, {2}, {3}, {4} )", string( l_str_filter.p_lvl_info ), string( l_str_filter.p_lvl_care ), string( l_str_filter.p_lvl_alert ),&
				  string( l_str_filter.p_lvl_error ) )
l_filter_string	= fnc.of_decode( l_filter_string, "", l_lvl, l_filter_string + " and " + l_lvl )

if not isnull( l_str_filter.p_pg_id ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "pg_id = '" + l_str_filter.p_pg_id + "'" , l_filter_string + " and pg_id = '" + l_str_filter.p_pg_id + "'" )
end if

if not isnull( l_str_filter.p_event_id ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "event_id = '" + l_str_filter.p_event_id + "'" , l_filter_string + " and event_id = '" + l_str_filter.p_event_id + "'" )
end if

if not isnull( l_str_filter.p_client_id ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "client_id = '" + l_str_filter.p_client_id + "'" , l_filter_string + " and client_id = '" + l_str_filter.p_client_id + "'" )
end if

if not isnull( l_str_filter.p_error_code ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "error_code = " + string( l_str_filter.p_error_code ), l_filter_string + " and error_code = " + string( l_str_filter.p_error_code ) )
end if

if not isnull( l_str_filter.p_msg ) then
	l_filter_string	= fnc.of_decode( l_filter_string, "", "msg like '%" + l_str_filter.p_msg + "%'", l_filter_string + " and msg like '%" + l_str_filter.p_msg + "%'" )
end if

return l_filter_string

end function

private function boolean of_filter (boolean p_double, string p_double_filter);/*--- 今シングルラインエディットに入力されているフィルターをかける関数 -----*/

str_filter_log	l_str_filter	// 今回のsleの値を格納する構造体
str_filter_log	l_str_branch[]	// 履歴がブランチするときのバックアップ用構造体配列
string			l_filter_string	// 今回のsleの値をフィルタ用のstringにして格納する変数
string			l_filter_before	// 前回のフィルタのstringを格納する変数
string			l_array[2]		// ダブルクリックのsplit格納用
string			l_nulls
long			l_nulll
long			l_i
boolean			l_ret	= false

setnull( l_nulls )
setnull( l_nulll )

dw_list.setredraw( false )
// フィルターをリセット
dw_list.setfilter( "" )

// ダブルクリックかどうか判定
if p_double then
	l_str_filter.p_double			= p_double
	if pos( p_double_filter, "," ) > 0 then
		l_array	= fnc.strg.of_split( p_double_filter, "," )
	else
		l_str_filter.p_double_filter	= p_double_filter
	end if
//else
//	if upperbound( i_str_filter ) > 0 then
//		l_str_filter.p_double_filter	= fnc.of_decode( i_str_filter[upperbound( i_str_filter )].p_double_filter, l_nulls, l_nulls, i_str_filter[upperbound( i_str_filter )].p_double_filter )
//	else
//		// ここ通るのたぶん最初だけ
//		l_str_filter.p_double_filter	= l_nulls
//	end if
end if

// 各sleの値を格納していく
l_str_filter.p_str_date		= fnc.of_decode( sle_str_date.text, "", l_nulll, long( fnc.strg.of_replace( trim( sle_str_date.text ), "/", "" ) ) )
l_str_filter.p_str_time		= fnc.of_decode( sle_str_time.text, "", l_nulll, long( fnc.strg.of_replace( trim( sle_str_time.text ), ":", "" ) ) )
l_str_filter.p_end_date		= fnc.of_decode( sle_end_date.text, "", l_nulll, long( fnc.strg.of_replace( trim( sle_end_date.text ), "/", "" ) ) )
l_str_filter.p_end_time		= fnc.of_decode( sle_end_time.text, "", l_nulll, long( fnc.strg.of_replace( trim( sle_end_time.text ), ":", "" ) ) )
l_str_filter.p_str_seq		= fnc.of_decode( sle_str_seq.text, "", l_nulll, long( trim( sle_str_seq.text ) ) )
l_str_filter.p_end_seq		= fnc.of_decode( sle_end_seq.text, "", l_nulll, long( trim( sle_end_seq.text ) ) )
l_str_filter.p_user_id		= fnc.of_decode( l_array[1], "user_id", l_array[2], fnc.of_decode( uo_user_id.of_get_input( ), "", l_nulls, trim( uo_user_id.of_get_input( ) ) ) )
l_str_filter.p_lvl_info		= fnc.of_decode( cbx_info.checked, true, 1, 0 )
l_str_filter.p_lvl_care		= fnc.of_decode( cbx_care.checked, true, 2, 0 )
l_str_filter.p_lvl_alert	= fnc.of_decode( cbx_alert.checked, true, 3, 0 )
l_str_filter.p_lvl_error	= fnc.of_decode( cbx_error.checked, true, 4, 0 )
l_str_filter.p_pg_id		= fnc.of_decode( l_array[1], "pg_id", l_array[2], fnc.of_decode( sle_pg.text, "", l_nulls, trim( sle_pg.text ) ) )
l_str_filter.p_event_id		= fnc.of_decode( l_array[1], "event_id", l_array[2], fnc.of_decode( sle_event.text, "", l_nulls, trim( sle_event.text ) ) )
l_str_filter.p_client_id	= fnc.of_decode( l_array[1], "client_id", l_array[2], fnc.of_decode( sle_client.text, "", l_nulls, trim( sle_client.text ) ) )
l_str_filter.p_error_code	= fnc.of_decode( l_array[1], "error_code", l_array[2], fnc.of_decode( sle_error.text, "", l_nulll, long( trim( sle_error.text ) ) ) )
l_str_filter.p_msg			= fnc.of_decode( l_array[1], "msg", l_array[2], fnc.of_decode( sle_msg.text, "", l_nulls, trim( sle_msg.text ) ) )

// フィルタ用のstringを作成
l_filter_string	= of_filter_create( l_str_filter )

// stringが前回と同値か比較する
if upperbound( i_str_filter ) > 0 then
	l_filter_before	= of_filter_create( i_str_filter[upperbound( i_str_filter )] )
end if

if l_filter_string <> l_filter_before then
	// i_countがupperbound(i_str_filter)より小さいときにフィルタをかけるなら、i_str_filterから先の履歴を破棄する
	if i_count < upperbound(i_str_filter) then
		if i_count > 1 then
			for l_i = 1 to i_count
				l_str_branch[l_i]	= i_str_filter[l_i]
			next
		else	// i_countが1のとき
			l_str_branch[i_count]	= i_str_filter[i_count]
		end if
	
		i_str_filter	= l_str_branch
	end if

	// フィルタをかける
	sle_filter.text	= l_filter_string // 最後に消す
	dw_list.setfilter( l_filter_string )
	dw_list.filter()
	
	i_str_filter[upperbound( i_str_filter ) + 1]	= l_str_filter
	i_count	= upperbound( i_str_filter )
	
	l_ret	= true
end if

// フィルタがかからなかったらfalseで返したい
dw_list.setredraw( true )

return l_ret
end function

private function string of_time_format (string p_time);/*--- of_date_formatの時間バージョン -------------------------*/

string	l_time

l_time	= trim( p_time )

choose case len( l_time )
	case 6
		if pos( l_time, ":" ) = 0 then
			l_time	= mid( l_time, 1, 2 ) + ":" + mid( l_time , 3, 2 ) + ":"+ mid( l_time, 5, 2 )
		else
			l_time	= "999999" // エラー
		end if
	case 7
		choose case pos( l_time, ":" )
			case 3, 5
				l_time	= fnc.strg.of_replace( l_time, ":", "" )
				l_time	= mid( l_time, 1, 2 ) + ":" + mid( l_time , 3, 2 ) + ":"+ mid( l_time, 5, 2 )
			case else
				l_time	= "999999" // エラー
		end choose
	case 8
		if pos( l_time, ":" ) <> 3 then
			l_time	= "999999" // エラー
			return l_time
		end if
		
		if pos( l_time, ":", 4 ) <> 6 then
			l_time	= "999999" // エラー
			return l_time
		end if
	case else
		l_time	= "999999" // エラー
end choose

return l_time
end function

on w_log.create
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
this.sle_str_seq=create sle_str_seq
this.st_between_log=create st_between_log
this.sle_end_seq=create sle_end_seq
this.cbx_info=create cbx_info
this.cbx_alert=create cbx_alert
this.cbx_filter=create cbx_filter
this.st_pg=create st_pg
this.sle_pg=create sle_pg
this.st_event=create st_event
this.sle_event=create sle_event
this.st_client=create st_client
this.sle_client=create sle_client
this.st_error=create st_error
this.sle_error=create sle_error
this.st_msg=create st_msg
this.sle_msg=create sle_msg
this.cb_back=create cb_back
this.cb_move=create cb_move
this.sle_filter=create sle_filter
this.cbx_error=create cbx_error
this.cbx_care=create cbx_care
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
this.Control[iCurrent+10]=this.sle_str_seq
this.Control[iCurrent+11]=this.st_between_log
this.Control[iCurrent+12]=this.sle_end_seq
this.Control[iCurrent+13]=this.cbx_info
this.Control[iCurrent+14]=this.cbx_alert
this.Control[iCurrent+15]=this.cbx_filter
this.Control[iCurrent+16]=this.st_pg
this.Control[iCurrent+17]=this.sle_pg
this.Control[iCurrent+18]=this.st_event
this.Control[iCurrent+19]=this.sle_event
this.Control[iCurrent+20]=this.st_client
this.Control[iCurrent+21]=this.sle_client
this.Control[iCurrent+22]=this.st_error
this.Control[iCurrent+23]=this.sle_error
this.Control[iCurrent+24]=this.st_msg
this.Control[iCurrent+25]=this.sle_msg
this.Control[iCurrent+26]=this.cb_back
this.Control[iCurrent+27]=this.cb_move
this.Control[iCurrent+28]=this.sle_filter
this.Control[iCurrent+29]=this.cbx_error
this.Control[iCurrent+30]=this.cbx_care
end on

on w_log.destroy
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
destroy(this.sle_str_seq)
destroy(this.st_between_log)
destroy(this.sle_end_seq)
destroy(this.cbx_info)
destroy(this.cbx_alert)
destroy(this.cbx_filter)
destroy(this.st_pg)
destroy(this.sle_pg)
destroy(this.st_event)
destroy(this.sle_event)
destroy(this.st_client)
destroy(this.sle_client)
destroy(this.st_error)
destroy(this.sle_error)
destroy(this.st_msg)
destroy(this.sle_msg)
destroy(this.cb_back)
destroy(this.cb_move)
destroy(this.sle_filter)
destroy(this.cbx_error)
destroy(this.cbx_care)
end on

event resize;call super::resize;long	l_msg

// 1段目
sle_str_date.y				= st_second_upper.y + code.MGN_TATE

st_syori_date.x				= 36
st_syori_date.y				= sle_str_date.y + sle_str_date.height / 2 - st_syori_date.height / 2

sle_str_date.x				= st_syori_date.x + st_syori_date.width + code.MGN_GROUP_YOKO

sle_str_time.y				= sle_str_date.y
sle_str_time.x				= sle_str_date.x + sle_str_date.width + code.MGN_GROUP_YOKO

st_between_date.y			= sle_str_date.y + sle_str_date.height / 2 - st_between_date.height / 2
st_between_date.x			= sle_str_time.x + sle_str_time.width + code.MGN_GROUP_YOKO

sle_end_date.y				= sle_str_date.y
sle_end_date.x				= st_between_date.x + st_between_date.width + code.MGN_GROUP_YOKO

sle_end_time.y				= sle_str_date.y
sle_end_time.x				= sle_end_date.x + sle_end_date.width + code.MGN_GROUP_YOKO

st_log.y					= sle_str_date.y + sle_str_date.height / 2 - st_log.height / 2
st_log.x					= sle_end_time.x + sle_end_time.width + code.MGN_ITEM_YOKO

sle_str_seq.y				= sle_str_date.y
sle_str_seq.x				= st_log.x + st_log.width + code.MGN_GROUP_YOKO

st_between_log.y			= sle_str_date.y + sle_str_date.height / 2 - st_between_log.height / 2
st_between_log.x			= sle_str_seq.x + sle_str_seq.width + code.MGN_GROUP_YOKO

sle_end_seq.y				= sle_str_date.y
sle_end_seq.x				= st_between_log.x + st_between_log.width + code.MGN_GROUP_YOKO

// 2段目
uo_user_id.y				= sle_str_date.y + sle_str_date.height + code.MGN_TATE
uo_user_id.x				= st_syori_date.x

cbx_info.y					= uo_user_id.y + uo_user_id.height / 2 - cbx_info.height / 2
cbx_info.x					= uo_user_id.x + uo_user_id.width + code.MGN_ITEM_YOKO

cbx_care.y					= uo_user_id.y + uo_user_id.height / 2 - cbx_care.height / 2
cbx_care.x					= cbx_info.x + cbx_info.width + code.MGN_GROUP_YOKO

cbx_alert.y					= uo_user_id.y + uo_user_id.height / 2 - cbx_alert.height / 2
cbx_alert.x					= cbx_care.x + cbx_care.width + code.MGN_GROUP_YOKO

cbx_error.y					= uo_user_id.y + uo_user_id.height / 2 - cbx_error.height / 2
cbx_error.x					= cbx_alert.x + cbx_alert.width + code.MGN_GROUP_YOKO

// 3段目
sle_pg.y					= uo_user_id.y + uo_user_id.height + code.MGN_TATE

st_pg.y						= sle_pg.y + sle_pg.height / 2 - st_pg.height / 2
st_pg.x						= st_syori_date.x

sle_pg.x					= st_pg.x + st_pg.width + code.MGN_GROUP_YOKO

st_event.y					= sle_pg.y + sle_pg.height / 2 - st_event.height / 2
st_event.x					= sle_pg.x + sle_pg.width + code.MGN_ITEM_YOKO

sle_event.y					= sle_pg.y
sle_event.x					= st_event.x + st_event.width + code.MGN_GROUP_YOKO

st_client.y					= sle_pg.y + sle_pg.height / 2 - st_client.height / 2
st_client.x					= sle_event.x + sle_event.width + code.MGN_ITEM_YOKO

sle_client.y				= sle_pg.y
sle_client.x				= st_client.x + st_client.width + code.MGN_GROUP_YOKO

// 4段目
sle_error.y					= sle_pg.y + sle_pg.height + code.MGN_TATE

st_error.y					= sle_error.y + sle_error.height / 2 - st_error.height / 2
st_error.x					= st_syori_date.x

sle_error.x					= st_error.x + st_error.width + code.MGN_GROUP_YOKO

st_msg.y					= sle_error.y + sle_error.height / 2 - st_msg.height / 2
st_msg.x					= sle_error.x + sle_error.width + code.MGN_ITEM_YOKO

sle_msg.y					= sle_error.y
sle_msg.x					= st_msg.x + st_msg.width + code.MGN_GROUP_YOKO
sle_msg.width				= cb_retrieve.x - sle_msg.x - code.MGN_ITEM_YOKO

cb_retrieve.y				= sle_error.y

// st_second_upper
st_second_upper.height		= sle_error.y + sle_error.height + code.MGN_TATE - st_upper.y - st_upper.height

// dw_list
dw_list.y					= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x					= code.MGN_YOKO
dw_list.width				= this.width - code.MGN_YOKO - code.MGN_YOKO * 3
dw_list.height				= key_fnc.y - dw_list.y - code.MGN_TATE

// dw_listのmsgカラムのwidth
l_msg						= dw_list.width - ( long( dw_list.object.seq_no.width ) + long( dw_list.object.lvl.width ) + long( dw_list.object.syori_date.width ) + long( dw_list.object.pg_id.width ) +&
							  long( dw_list.object.event_id.width ) + long( dw_list.object.client_id.width ) + long( dw_list.object.user_id.width ) + long( dw_list.object.user_mei.width ) +&
							  long( dw_list.object.error_code.width ) ) - 204 // 垂直バーの分 要調整
if l_msg > 1700 then
	dw_list.object.msg.width	= l_msg
else
	dw_list.object.msg.width	= 1700
end if
end event

event retrieve_event;call super::retrieve_event;long	l_str_date
long	l_str_time
long	l_end_date
long	l_end_time
long	l_str_seq
long	l_end_seq
long	l_lvl_info
long	l_lvl_care
long	l_lvl_alert
long	l_lvl_error
long	l_error_code
long	l_nulll
string	l_user_id
string	l_pg_id
string	l_event_id
string	l_client_id
string	l_msg

setnull( l_nulll )

i_filter			= false		// フィルタモードの解除
cbx_filter.checked	= i_filter

dw_list.reset()
dw_list.setfilter("")	// フィルタのリセット
of_filter_reset( )

// 値の格納
l_str_date		= fnc.of_decode( sle_str_date.text, "", l_nulll, long( trim( sle_str_date.text ) ) )
l_str_time		= fnc.of_decode( sle_str_time.text, "", l_nulll, long( trim( sle_str_time.text ) ) )
l_end_date		= fnc.of_decode( sle_end_date.text, "", l_nulll, long( trim( sle_end_date.text ) ) )
l_end_time		= fnc.of_decode( sle_end_time.text, "", l_nulll, long( trim( sle_end_time.text ) ) )
l_str_seq		= fnc.of_decode( sle_str_seq.text, "", l_nulll, long( trim( sle_str_seq.text ) ) )
l_end_seq		= fnc.of_decode( sle_end_seq.text, "", l_nulll, long( trim( sle_end_seq.text ) ) )

l_user_id		= trim( uo_user_id.of_get_input( ) )
l_lvl_info		= fnc.of_decode( cbx_info.checked, true, 1, 0 )
l_lvl_care		= fnc.of_decode( cbx_care.checked, true, 2, 0 )
l_lvl_alert		= fnc.of_decode( cbx_alert.checked, true, 3, 0 )
l_lvl_error		= fnc.of_decode( cbx_error.checked, true, 4, 0 )

l_pg_id			= trim( sle_pg.text )
l_event_id		= trim( sle_event.text )
l_client_id		= trim( sle_client.text )
l_error_code	= fnc.of_decode( sle_error.text, "", l_nulll, long( trim( sle_error.text ) ) )
l_msg			= trim( sle_msg.text )

dw_list.retrieve( l_str_date, l_end_date, l_str_time, l_end_time, l_str_seq, l_end_seq, l_user_id, l_lvl_info, l_lvl_care, l_lvl_alert, l_lvl_error, l_pg_id, l_event_id, l_client_id, l_error_code, l_msg )

i_filter			= true		// フィルターモード開始
cbx_filter.checked	= i_filter
end event

event retrieve_check;call super::retrieve_check;
if not sle_str_date.event input_check() then
	sle_str_date.setfocus()
	return -1
end if

if not sle_str_time.event input_check() then
	sle_str_time.setfocus()
	return -1
end if

if not sle_end_date.event input_check() then
	sle_end_date.setfocus()
	return -1
end if

if not sle_end_time.event input_check() then
	sle_end_time.setfocus()
	return -1
end if

if not sle_str_seq.event input_check() then
	sle_str_seq.setfocus()
	return -1
end if

if not sle_end_seq.event input_check() then
	sle_end_seq.setfocus()
	return -1
end if

if not uo_user_id.event sle_input_check() then
	uo_user_id.setfocus()
	return -1
end if

if not sle_pg.event input_check() then
	sle_pg.setfocus()
	return -1
end if

if not sle_event.event input_check() then
	sle_event.setfocus()
	return -1
end if

if not sle_client.event input_check() then
	sle_client.setfocus()
	return -1
end if

if not sle_error.event input_check() then
	sle_error.setfocus()
	return -1
end if

if not sle_msg.event input_check() then
	sle_msg.setfocus()
	return -1
end if
end event

event close;call super::close;
i_close	= true
end event

type uo_signal from iw_main_window`uo_signal within w_log
end type

type st_date from iw_main_window`st_date within w_log
end type

type st_user_mei from iw_main_window`st_user_mei within w_log
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_log
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_log
end type

type st_title from iw_main_window`st_title within w_log
end type

type st_title_upper from iw_main_window`st_title_upper within w_log
end type

type st_upper from iw_main_window`st_upper within w_log
end type

type st_second_upper from iw_main_window`st_second_upper within w_log
integer y = 142
integer height = 587
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_log
integer x = 4360
integer y = 583
integer taborder = 130
end type

type dw_list from ivo_datawindow within w_log
integer x = 72
integer y = 764
integer width = 4656
integer height = 1799
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

event doubleclicked;call super::doubleclicked;
if row > 0 then
	choose case dwo.name
		case "seq_no"
			of_filter( true, "seq_no = " + string( dw_list.object.seq_no[row] ) )
		case "lvl"
			of_filter( true, "lvl = '" + string( dw_list.object.lvl[row] ) + "'" )
		case "syori_date"
			of_filter( true, "syori_date = '" + string( dw_list.object.syori_date[row] ) + "'" )
		case "pg_id"
			of_filter( true, "pg_id," + string( dw_list.object.pg_id[row] ) )
		case "event_id"
			of_filter( true, "event_id," + string( dw_list.object.event_id[row] ) )
		case "client_id"
			of_filter( true, "client_id," + string( dw_list.object.client_id[row] ) )
		case "user_id"
			of_filter( true, "user_id," + string( dw_list.object.user_id[row] ) )
		case "user_mei"
			of_filter( true, "user_mei = '" + string( dw_list.object.user_mei[row] ) + "'" )
		case "error_code"
			of_filter( true, "error_code," + string( dw_list.object.error_code[row] ) )
		case "msg"
			of_filter( true, "msg," + string( dw_list.object.msg[row] ) )
		case else
		// 何もしない
	end choose

	dw_list.scrolltorow( row )
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

event clicked;call super::clicked;/*--- 選択した値でフィルターをかけなおす -----------------------------------*/

string	l_filter

if row > 0 then
//	dw_list.setredraw( false )
//	dw_list.setfilter( "" )
//	of_filter_reset( )	// 配列や履歴をリセット
//	
//	choose case dwo.name
//		case "seq_no"
//			l_filter	= "seq_no = " + string( dw_list.object.seq_no[row] )
//		case "lvl"
//			l_filter	= "lvl = '" + string( dw_list.object.lvl[row] ) + "'"
//		case "syori_date"
//			l_filter	= "syori_date = '" + string( dw_list.object.syori_date[row] ) + "'"
//		case "pg_id"
//			l_filter	= "pg_id = '" + string( dw_list.object.pg_id[row] ) + "'"
//		case "event_id"
//			l_filter	= "event_id = '" + string( dw_list.object.event_id[row] ) + "'"
//		case "client_id"
//			l_filter	= "client_id = '" + string( dw_list.object.client_id[row] ) + "'"
//		case "user_id"
//			l_filter	= "user_id = '" + string( dw_list.object.user_id[row] ) + "'"
//		case "user_mei"
//			l_filter	= "user_mei = '" + string( dw_list.object.user_mei[row] ) + "'"
//		case "error_code"
//			l_filter	= "error_code = " + string( dw_list.object.error_code[row] )
//		case "msg"
//			l_filter	= "msg = '" + string( dw_list.object.msg[row] ) + "'"
//		case else
//		// 何もしない
//	end choose
//	
//	sle_filter.text	= l_filter // 最後に消す
//	dw_list.setfilter( l_filter )
//	dw_list.filter()
//	dw_list.setredraw( true )	
end if

end event

type st_syori_date from ivo_statictext within w_log
integer x = 36
integer y = 196
boolean bringtotop = true
long backcolor = 12632256
string text = "処理日時"
alignment alignment = right!
end type

type sle_str_date from ivo_singlelineedit within w_log
integer x = 384
integer y = 188
integer width = 500
integer taborder = 10
boolean bringtotop = true
string text = ""
boolean chk_type_date = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;string	l_date

// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

if ( this.text <> "0" ) and ( this.text <> "9999/99/99" ) then
	l_date	= fnc.of_date_format( trim( this.text ) )
	
	if not isdate( l_date ) then
		of_msg_error( this, fnc.strg.of_format( "日付以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
		return false
	end if
	
	this.text	= l_date
else
	of_msg_error( this, fnc.strg.of_format( "日付以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true

end event

type sle_str_time from ivo_singlelineedit within w_log
integer x = 916
integer y = 188
integer width = 400
integer taborder = 20
boolean bringtotop = true
string text = ""
boolean chk_type_time = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;string	l_time

// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

if ( this.text <> "999999" ) then
	l_time	= of_time_format( trim( this.text ) )

	if not istime( l_time ) then
		of_msg_error( this, fnc.strg.of_format( "時刻以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
		return false
	end if

	this.text	= l_time
else
	of_msg_error( this, fnc.strg.of_format( "時刻以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true

end event

type st_between_date from ivo_statictext within w_log
integer x = 1348
integer y = 196
integer width = 100
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_end_date from ivo_singlelineedit within w_log
integer x = 1480
integer y = 188
integer width = 500
integer taborder = 30
boolean bringtotop = true
string text = ""
boolean chk_type_date = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;string	l_date

// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

if ( this.text <> "0" ) and ( this.text <> "9999/99/99" ) then
	l_date	= fnc.of_date_format( trim( this.text ) )
	
	if not isdate( l_date ) then
		of_msg_error( this, fnc.strg.of_format( "日付以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
		return false
	end if
	
	this.text	= l_date
else
	of_msg_error( this, fnc.strg.of_format( "日付以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true
end event

type sle_end_time from ivo_singlelineedit within w_log
integer x = 2012
integer y = 188
integer width = 400
integer taborder = 40
boolean bringtotop = true
string text = ""
boolean chk_type_time = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;string	l_time

// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

if ( this.text <> "999999" ) then
	l_time	= of_time_format( trim( this.text ) )
	
	if not istime( l_time ) then
		of_msg_error( this, fnc.strg.of_format( "時刻以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
		return false
	end if

	this.text	= l_time
else
	of_msg_error( this, fnc.strg.of_format( "時刻以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true

end event

type uo_user_id from cv_input_user_id within w_log
integer x = 36
integer y = 313
integer taborder = 70
boolean bringtotop = true
end type

on uo_user_id.destroy
call cv_input_user_id::destroy
end on

event losefocuses;call super::losefocuses;
if p_name = "sle" then
	if not i_close then
		if i_filter then 
			of_filter( false, "" )
		end if
	end if
end if

return 0
end event

type st_log from ivo_statictext within w_log
integer x = 2492
integer y = 196
boolean bringtotop = true
long backcolor = 12632256
string text = "ログNo."
alignment alignment = right!
end type

type sle_str_seq from ivo_singlelineedit within w_log
integer x = 2824
integer y = 188
integer width = 500
integer taborder = 50
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type st_between_log from ivo_statictext within w_log
integer x = 3356
integer y = 196
integer width = 100
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_end_seq from ivo_singlelineedit within w_log
integer x = 3488
integer y = 188
integer width = 500
integer taborder = 60
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type cbx_info from ivo_checkbox within w_log
integer x = 1956
integer y = 320
boolean bringtotop = true
long backcolor = 12632256
string text = "情報"
boolean checked = true
end type

event clicked;call super::clicked;//integer	l_row
//
//l_row	= dw_list.getrow()
//
//dw_list.setredraw( false )
//
//if this.checked then	// チェックされてたら「情報」は表示する
////	dw_list.setfilter( "msg_lvl >= 0" )
//else
//	dw_list.setfilter( "msg_lvl <> 1" )
//end if
//
//dw_list.filter()
//dw_list.scrolltorow( l_row )
//
//dw_list.setredraw( true )



if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type cbx_alert from ivo_checkbox within w_log
integer x = 2676
integer y = 320
boolean bringtotop = true
long backcolor = 12632256
string text = "警告"
boolean checked = true
end type

event clicked;call super::clicked;//integer	l_row
//
//l_row	= dw_list.getrow()
//
//dw_list.setredraw( false )
//
//if this.checked then	// チェックされてたら「警告」は表示する
////	dw_list.setfilter( "msg_lvl >= 0" )
//else
//	dw_list.setfilter( "msg_lvl <> 3" )
//end if
//
//dw_list.filter()
//dw_list.scrolltorow( l_row )
//
//dw_list.setredraw( true )


if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type cbx_filter from ivo_checkbox within w_log
integer x = 4688
integer y = 2610
boolean bringtotop = true
string text = "フィルタ"
boolean checked = true
end type

event clicked;call super::clicked;
if cbx_filter.checked then
	i_filter	= true
else	
	i_filter	= false
end if
end event

type st_pg from ivo_statictext within w_log
integer x = 36
integer y = 448
boolean bringtotop = true
long backcolor = 12632256
string text = "プログラムID"
alignment alignment = right!
end type

type sle_pg from ivo_singlelineedit within w_log
integer x = 468
integer y = 441
integer width = 1500
integer taborder = 80
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;
if not fnc.of_chk_hankaku( trim( this.text ) ) then
	of_msg_error( this, fnc.strg.of_format( "半角英数以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true
end event

type st_event from ivo_statictext within w_log
integer x = 2020
integer y = 448
boolean bringtotop = true
long backcolor = 12632256
string text = "イベントID"
alignment alignment = right!
end type

type sle_event from ivo_singlelineedit within w_log
integer x = 2360
integer y = 441
integer width = 900
integer taborder = 90
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;
if not fnc.of_chk_hankaku( trim( this.text ) ) then
	of_msg_error( this, fnc.strg.of_format( "半角英数以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true
end event

type st_client from ivo_statictext within w_log
integer x = 3316
integer y = 448
integer width = 400
boolean bringtotop = true
long backcolor = 12632256
string text = "コンピューター名"
alignment alignment = right!
end type

type sle_client from ivo_singlelineedit within w_log
integer x = 3756
integer y = 441
integer width = 1000
integer taborder = 100
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

event input_check;call super::input_check;
if not fnc.of_chk_hankaku( trim( this.text ) ) then
	of_msg_error( this, fnc.strg.of_format( "半角英数以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
	return false
end if

return true
end event

type st_error from ivo_statictext within w_log
integer x = 36
integer y = 587
boolean bringtotop = true
long backcolor = 12632256
string text = "エラーコード"
alignment alignment = right!
end type

type sle_error from ivo_singlelineedit within w_log
integer x = 464
integer y = 580
integer taborder = 110
boolean bringtotop = true
string text = ""
boolean chk_type_num = true
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type st_msg from ivo_statictext within w_log
integer x = 920
integer y = 587
boolean bringtotop = true
long backcolor = 12632256
string text = "メッセージ"
alignment alignment = right!
end type

type sle_msg from ivo_singlelineedit within w_log
integer x = 1260
integer y = 580
integer width = 3000
integer taborder = 120
boolean bringtotop = true
string text = ""
end type

event losefocus;call super::losefocus;
if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type cb_back from ivo_commandbutton within w_log
integer x = 3944
integer y = 2610
integer taborder = 150
boolean bringtotop = true
string text = "戻る"
end type

event clicked;call super::clicked;// 1つ前のフィルタ状態に戻る

string	l_filter			// 最後にsetfilterするstring

if i_filter then
	if upperbound( i_str_filter ) >= i_count then
		dw_list.setredraw( false )
		dw_list.setfilter( "" )
		dw_list.filter( )			// 順番はバラバラだけど一番最初に戻せた
		
		of_count_minus( )				// i_countをマイナスする
		
		if i_count >= 1 then
			l_filter	= of_filter_create( i_str_filter[i_count] )
		else
			l_filter	= ""
		end if
		
		sle_filter.text	= l_filter // 最後に消す
		dw_list.setfilter( l_filter )
		dw_list.filter( )
		dw_list.setredraw( true )
		
		return i_count	// 要素の現在位置
	end if
end if

return 0
end event

type cb_move from ivo_commandbutton within w_log
integer x = 4316
integer y = 2610
integer taborder = 160
boolean bringtotop = true
string text = "進む"
end type

event clicked;call super::clicked;// 1つ後のフィルタ状態に進む

string	l_filter		// 最後にsetfilterするstring

if i_filter then
	if upperbound( i_str_filter ) >= i_count then
		dw_list.setredraw( false )
		dw_list.setfilter( "" )
		dw_list.filter( )		// 順番はバラバラだけど一番最初に戻せた
		
		of_count_plus( )
		
		l_filter	= of_filter_create( i_str_filter[i_count] )
		
		sle_filter.text	= l_filter // 最後に消す
		dw_list.setfilter( l_filter )
		dw_list.filter( )
		dw_list.setredraw( true )
		
		return i_count
	end if
end if

return 0
end event

type sle_filter from ivo_singlelineedit within w_log
integer x = 52
integer y = 2610
integer width = 3860
integer taborder = 160
boolean bringtotop = true
string text = ""
end type

type cbx_error from ivo_checkbox within w_log
integer x = 3052
integer y = 320
boolean bringtotop = true
long backcolor = 12632256
string text = "エラー"
boolean checked = true
end type

event clicked;call super::clicked;//integer	l_row
//
//l_row	= dw_list.getrow()
//
//dw_list.setredraw( false )
//
//if this.checked then	// チェックされてたら「エラー」は表示する
////	dw_list.setfilter( "msg_lvl >= 0" )
//else
//	dw_list.setfilter( "msg_lvl <> 4" )
//end if
//
//dw_list.filter()
//dw_list.scrolltorow( l_row )
//
//dw_list.setredraw( true )


if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

type cbx_care from ivo_checkbox within w_log
integer x = 2252
integer y = 324
boolean bringtotop = true
long backcolor = 12632256
string text = "要注意"
boolean checked = true
end type

event clicked;call super::clicked;//integer	l_row
//
//l_row	= dw_list.getrow()
//
//dw_list.setredraw( false )
//
//if this.checked then	// チェックされてたら「情報」は表示する
////	dw_list.setfilter( "msg_lvl >= 0" )
//else
//	dw_list.setfilter( "msg_lvl <> 2" )
//end if
//
//dw_list.filter()
//dw_list.scrolltorow( l_row )
//
//dw_list.setredraw( true )


if not i_close then
	if i_filter then 
		of_filter( false, "" )
	end if
end if
end event

