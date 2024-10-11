$PBExportHeader$nv_dbfunc.sru
$PBExportComments$DBが絡むユーザー関数
forward
global type nv_dbfunc from inv_object
end type
end forward

global type nv_dbfunc from inv_object
end type
global nv_dbfunc nv_dbfunc

forward prototypes
public function string of_cnv_multi_byte_full (string p_string)
private function boolean get_user_mei (integer p_user_code, boolean p_ryaku, ref string p_name)
public function boolean of_get_user_mei (integer p_user_code, ref string p_name)
public function boolean of_get_user_mei_ryaku (integer p_user_code, ref string p_name)
public subroutine of_add_log (string p_pg_id, integer p_error_code, string p_text)
public subroutine of_add_log (string p_pg_id, string p_text)
public subroutine of_add_log (string p_pg_id, string p_event_id, long p_error_code, string p_text)
public function long of_get_numdate (datetime p_datetime)
public function long of_get_numtime (datetime p_datetime)
public function longlong of_get_numdatetime (datetime p_datetime)
public function long of_get_numsystime ()
public function longlong of_get_numsysdatetime ()
public function long of_get_numsysdate ()
public function string of_cnv_date_sei2wa ()
public function string of_cnv_date_sei2wa ( datetime p_date )
public function string of_cnv_date_sei2wa ( long p_nen, integer p_tuki, integer p_hi)
public function string of_cnv_date_sei2wa_jp ()
public function string of_cnv_date_sei2wa_jp ( datetime p_date )
public function string of_cnv_date_sei2wa_jp ( long p_nen, integer p_tuki, integer p_hi)
public function long of_cnv_date_wa2sei ( string p_wareki )
public function long of_cnv_date_wa2sei ( string p_wanen, integer p_tuki, integer p_hi )
public function boolean of_get_column_info (string p_table_name, string p_column_name, ref string p_column_type, ref decimal p_column_length)
public function string of_date_format (string p_date)
end prototypes

public function string of_cnv_multi_byte_full (string p_string);
// --------------------------------------------------------------------------
// Script:     	to_multi_byte_full
// Purpose:    	半角文字→全角文字変換
//
// Arguments:  	p_string	- 半角文字が含まれた文字列
//
// Return:     	string		全角に変換された文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2012.10.02	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_multi_byte

select fnc.to_multi_byte_full( :p_string )
  into :l_multi_byte
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	return ""
else
	return l_multi_byte
end if

end function

private function boolean get_user_mei (integer p_user_code, boolean p_ryaku, ref string p_name);
string	l_name,l_name_ryaku

setnull( l_name )
setnull( l_name_ryaku )

select user_mei,user_mei_ryaku
  into :l_name,:l_name_ryaku
  from m_user
 where user_id	= :p_user_code
using cocos;

choose case cocos.sqlcode
	case 0
		// 成功
		if p_ryaku then
			p_name	= l_name_ryaku
		else
			p_name	= l_name
		end if

		return true
	case 100
		// データなし
		if p_ryaku then
			p_name	= "？？？"
		else
			p_name	= "？？？？"
		end if

		return false
	case else
		//Oracleエラー
		msg.of_error( fnc.strg.of_format( "ユーザー名の取得でエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )

		return false
end choose


end function

public function boolean of_get_user_mei (integer p_user_code, ref string p_name);
return	get_user_mei( p_user_code, false, p_name )


end function

public function boolean of_get_user_mei_ryaku (integer p_user_code, ref string p_name);
return	get_user_mei( p_user_code, true, p_name )

end function

public subroutine of_add_log (string p_pg_id, integer p_error_code, string p_text);
of_add_log( p_pg_id, "", p_error_code, p_text )

end subroutine

public subroutine of_add_log (string p_pg_id, string p_text);
of_add_log( p_pg_id, "", 0, p_text )
end subroutine

public subroutine of_add_log (string p_pg_id, string p_event_id, long p_error_code, string p_text);
string	l_pg_id

try
	connect using logdb;

	l_pg_id	= parent.classname()

	insert into d_log(
		user_id,
		client_id,
		pg_id,
		event_id,
		error_code,
		msg
	) values (
		:user.user_id,
		:device.name,
		:p_pg_id,
		:p_event_id,
		:p_error_code,
		:p_text
	) using logdb;

	if logdb.sqlcode <> 0 then
		txtlog.of_sys_alert_log( txtlog.TYPE_ALT, l_pg_id, logdb.last_sqlerrcode, logdb.last_sqlerrtext )
	end if

	commit using logdb;

	if p_error_code <> 0 then
		txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "of_add_log", p_error_code, p_text )
	end if

	disconnect using logdb;
catch( runtimeerror exp )
	txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "of_add_log", exp.number, exp.text )
end try

end subroutine

public function long of_get_numdate (datetime p_datetime);
long	l_date

declare orafunc procedure for fnc.get_num_date( :p_datetime ) using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function long of_get_numtime (datetime p_datetime);
long	l_date

declare orafunc procedure for fnc.get_num_time( :p_datetime ) using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function longlong of_get_numdatetime (datetime p_datetime);
longlong	l_date

declare orafunc procedure for fnc.get_num_datetime( :p_datetime ) using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function long of_get_numsystime ();
long	l_date

declare orafunc procedure for fnc.get_num_time using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function longlong of_get_numsysdatetime ();
longlong	l_date

declare orafunc procedure for fnc.get_num_datetime using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function long of_get_numsysdate ();
long	l_date

declare orafunc procedure for fnc.get_num_date using cocos;
execute orafunc;
fetch orafunc into :l_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return 0
end if

return l_date
end function

public function string of_cnv_date_sei2wa ();
string	l_date

select fnc.cnv_date_sei2wa()
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function string of_cnv_date_sei2wa ( datetime p_date );
string	l_date

select fnc.cnv_date_sei2wa( :p_date )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function string of_cnv_date_sei2wa ( long p_nen, integer p_tuki, integer p_hi);
string	l_date

select fnc.cnv_date_sei2wa( :p_nen, :p_tuki, :p_hi )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function string of_cnv_date_sei2wa_jp ();
string	l_date

select fnc.cnv_date_sei2wa_jp()
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function string of_cnv_date_sei2wa_jp ( datetime p_date );
string	l_date

select fnc.cnv_date_sei2wa_jp( :p_date )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function string of_cnv_date_sei2wa_jp ( long p_nen, integer p_tuki, integer p_hi);
string	l_date

select fnc.cnv_date_sei2wa_jp( :p_nen, :p_tuki, :p_hi )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function long of_cnv_date_wa2sei ( string p_wareki );
long	l_date

select fnc.cnv_date_wa2sei( :p_wareki )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function long of_cnv_date_wa2sei ( string p_wanen, integer p_tuki, integer p_hi );
long	l_date

select fnc.cnv_date_wa2sei( :p_wanen, :p_tuki, :p_hi )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date

end function

public function boolean of_get_column_info (string p_table_name, string p_column_name, ref string p_column_type, ref decimal p_column_length);
integer	ret
string	l_table_name,l_column_name,l_column_type
decimal	l_column_length


declare orafunc procedure for fnc.get_column_info( :p_table_name, :p_column_name ) using cocos;
execute orafunc;
fetch orafunc into :ret, :l_column_type, :l_column_length;
close orafunc;

if cocos.sqlcode <> 0 then
	return false
end if

if ret <> 0 then
	return false
end if

p_column_type	= trim( l_column_type )
p_column_length	= l_column_length

return true
end function

public function string of_date_format (string p_date);
// --------------------------------------------------------------------------
// Script:		of_date_format
// Purpose:		指定された文字列を日付形式文字列に変換する
//
// Arguments:	p_date		- 変換したい文字列
// Return:		string		- 日付形式文字列
//
// Date			Prog/ID		Description of Change / Reason
// ----------	----------	--------------------------------------------------
// 2024.07.11	Yamamoto	Initial coding
// ---------------------------------------------------------------------------

string	l_date

select fnc.date_format( :p_date )
  into :l_date
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	setnull( l_date )
end if

return l_date
end function

on nv_dbfunc.create
call super::create
end on

on nv_dbfunc.destroy
call super::destroy
end on

