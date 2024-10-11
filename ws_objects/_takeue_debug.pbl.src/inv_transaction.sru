$PBExportHeader$inv_transaction.sru
$PBExportComments$トランザクションオブジェクトの先祖オブジェクト
forward
global type inv_transaction from asc_transaction
end type
type lstr_config from structure within inv_transaction
end type
type lstr_dbprofile from structure within inv_transaction
end type
end forward

type lstr_config from structure
	string		dbms
	string		server_name
	string		login_id
	string		password
	boolean		auto_commit
	string		dbparam
end type

type lstr_dbprofile from structure
	lstr_config		prod
	lstr_config		test
end type

global type inv_transaction from asc_transaction
end type
global inv_transaction inv_transaction

type prototypes

end prototypes

type variables
constant string	profile_xml	= "database.xml"

private string	profile_name
//private boolean	db_test_mode

private lstr_dbprofile	dbprof

long	last_sqlerrcode
string	last_sqlerrtext
string	last_sqlerrsyntax

end variables

forward prototypes
private function boolean load_profile ()
public function boolean of_setup (string p_name, boolean p_test)
public function boolean of_set_profile (boolean p_test)
end prototypes

private function boolean load_profile ();nv_xml			l_xml

if len( profile_name ) <> 0 then
	try
		l_xml	= create nv_xml
		
		l_xml.of_load( profile_xml )

		dbprof.prod.dbms		= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/dbms/", profile_name ) )
		dbprof.prod.server_name	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/servername/", profile_name ) )
		dbprof.prod.login_id	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/logid/", profile_name ) )
		dbprof.prod.password	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/logpassword/", profile_name ) )
		dbprof.prod.auto_commit	= fnc.of_decode( upper( l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/autocommit/", profile_name ) ) ), "TRUE", true, false )
		dbprof.prod.dbparam		= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/dbparm/", profile_name ) )
	
		dbprof.test.dbms		= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/test_mode/dbms/", profile_name ) )
		dbprof.test.server_name	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/test_mode/servername/", profile_name ) )
		dbprof.test.login_id	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/test_mode/logid/", profile_name ) )
		dbprof.test.password	= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/test_mode/logpassword/", profile_name ) )
		dbprof.test.auto_commit	= fnc.of_decode( upper( l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/prod_mode/autocommit/", profile_name ) ) ), "TRUE", true, false )
		dbprof.test.dbparam		= l_xml.of_getnodestring( fnc.strg.of_format( "/{1}/test_mode/dbparm/", profile_name ) )

		l_xml.of_unload( )

		destroy l_xml 
	catch( runtimeerror err )
		txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "load_profile", -999, "データベースの接続定義（" + profile_name +  "）の読み込みでエラー発生（" + err.text + "）")
		l_xml.of_unload( )
		destroy l_xml
		return false
	end try
	
	return true
end if

return false

end function

public function boolean of_setup (string p_name, boolean p_test);profile_name	= p_name
	
if not load_profile() then
	msg.of_error( fnc.strg.of_format( "トランザクション「{1}」のプロファイルの読み込みでエラーが発生しました。", profile_name ) )
	return false
end if

// RUNで実行している場合
/*
if handle( getapplication() ) = 0 then
	// テストモードでない場合
	if not p_test then
		// テストモードで実行されていないことの警告
		if not msg.of_warning_question( "IDE実行環境下で実行されていますが、テストモードが指定されていません。このまま処理を続行しますか？" ) then
			return false
		end if
	else
		choose case dbprof.test.server_name
			case "bbtest", "cstest", "seisantest", "syukkatest", "bunsekitest", "editest", "hanbaitest", "faxtest", "handytest"
			case else
				// サーバーの接続先が本番サーバーの可能性があることの警告
				if not msg.of_warning_question( "IDE実行環境下で実行されていますが、接続先DBがテスト環境のもの以外の可能性があります。（" + dbprof.test.server_name + "）このまま処理を続行しますか？" ) then
					return false
				end if
		end choose
	end if
end if
*/

if not of_set_profile( p_test ) then
	msg.of_error( fnc.strg.of_format( "トランザクション「{1}」のプロファイルのセットでエラーが発生しました。", profile_name ) )
	return false
end if

return true
end function

public function boolean of_set_profile (boolean p_test);if p_test then
	dbms		= dbprof.test.dbms
	servername	= dbprof.test.server_name
	logid		= dbprof.test.login_id
	logpass		= dbprof.test.password
	autocommit	= dbprof.test.auto_commit
	dbparm		= dbprof.test.dbparam
else
	dbms		= dbprof.prod.dbms
	servername	= dbprof.prod.server_name
	logid		= dbprof.prod.login_id
	logpass		= dbprof.prod.password
	autocommit	= dbprof.prod.auto_commit
	dbparm		= dbprof.prod.dbparam
end if

test_mode	= p_test

return true


end function

on inv_transaction.create
call super::create
end on

on inv_transaction.destroy
call super::destroy
end on

event dberror;call super::dberror;last_sqlerrcode		= code
last_sqlerrtext		= sqlerrortext
last_sqlerrsyntax	= sqlsyntax


end event

