$PBExportHeader$nv_database.sru
$PBExportComments$データベースへの接続に関するスクリプト
forward
global type nv_database from inv_object
end type
end forward

global type nv_database from inv_object
end type
global nv_database nv_database

forward prototypes
private function boolean dbconnect (ref inv_transaction p_tran, string p_name, boolean p_test)
public function boolean of_connect (ref inv_transaction p_tran, string p_name, boolean p_test)
public function boolean of_disconnect (ref inv_transaction p_tran)
private function boolean dbdisconnect (ref inv_transaction p_tran)
end prototypes

private function boolean dbconnect (ref inv_transaction p_tran, string p_name, boolean p_test);if isvalid( p_tran ) then
	destroy p_tran 
end if	
	
p_tran	= create inv_transaction

if p_tran.of_setup( p_name, p_test ) then
	connect using p_tran;
	
	if p_tran.sqlcode <> 0 then
		txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "dbconnect", -999, "DB切断（" + p_tran.dbms + "）でエラー発生（" + string( p_tran.sqldbcode ) + "：" + fnc.strg.of_replace( p_tran.sqlerrtext, "~r~n", "" ) + "）")
		return false
	end if
	
	return true
end if

return false

end function

public function boolean of_connect (ref inv_transaction p_tran, string p_name, boolean p_test);if not dbconnect( p_tran, p_name, p_test ) then
	msg.of_error( "データベース（" + p_name + "）への接続でエラーが発生しました。" + code.crlf + string( p_tran.sqldbcode ) + "：" + p_tran.sqlerrtext )
	return false
end if

return true
end function

public function boolean of_disconnect (ref inv_transaction p_tran);if not dbdisconnect( p_tran ) then
	msg.of_error( "データベース（" + p_tran.servername + "）への切断でエラーが発生しました。" + code.crlf + string( p_tran.sqldbcode ) + "：" + p_tran.sqlerrtext )
	return false
end if

return true

end function

private function boolean dbdisconnect (ref inv_transaction p_tran);if isvalid( p_tran ) then
	rollback using p_tran;
	
	disconnect using p_tran;
	
	if p_tran.sqlcode <> 0 then
		txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "dbdisconnect", -999, "DB切断（" + p_tran.dbms + "）でエラー発生（" + string( p_tran.sqldbcode ) + "：" + fnc.strg.of_replace( p_tran.sqlerrtext, "~r~n", "" ) + "）")
		return false
	end if
	
	destroy p_tran
end if	


return true
end function

on nv_database.create
call super::create
end on

on nv_database.destroy
call super::destroy
end on

