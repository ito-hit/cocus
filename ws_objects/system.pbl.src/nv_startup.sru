$PBExportHeader$nv_startup.sru
$PBExportComments$システム起動時のスクリプト
forward
global type nv_startup from inv_object
end type
end forward

global type nv_startup from inv_object
end type
global nv_startup nv_startup

type variables

// デフォルトプロパティ値
constant private integer	def_window_pixel_width	= 1280
constant private integer	def_window_pixel_height	= 900

constant private integer	log_alive				= 7


end variables

forward prototypes
public function boolean of_execute ()
private function boolean load_registory ()
private function boolean cleanup ()
private function boolean palette ()
private function boolean dbconnect (boolean p_test)
public function boolean multi_thread ()
private function string get_system_ver ()
private subroutine system_profile ()
public subroutine of_logon_start ()
private subroutine get_environment ()
private function boolean create_instance ()
end prototypes

public function boolean of_execute ();//boolean	l_test_mode

// ログファイルクリーンアップ
if not cleanup( ) then
	return false
end if

// パレット情報生成
if not palette( ) then
	return false
end if

// グローバルインスタンス生成
if not create_instance( ) then
	return false
end if

// マルチスレッド生成
if not multi_thread( ) then
	return false
end if

// データベース接続
// テストモードはコンストラクタ
if not dbconnect( test_mode ) then
	return false
end if

// ログオン //
of_logon_start( )

environment env

if GetEnvironment(env) <> 1 then
	messagebox( "","")
end if



return true


end function

private function boolean load_registory ();return false

end function

private function boolean cleanup ();// ローカルのログファイルクリア

integer	l_row1,l_row2
string	l_file_pattern[],l_files[]
string	l_extract

long	l_target,l_check

nv_file	l_file

l_file		= create nv_file
l_target	= long( string( relativedate( today(), log_alive * -1 ), "yyyymmdd" ) )

// ファイルパターンを配列に格納
l_file_pattern	= { fnc.strg.of_replace( txtlog.slog, "{1}", "*" ), fnc.strg.of_replace( txtlog.alog, "{1}", "*" ), fnc.strg.of_replace( txtlog.elog, "{1}", "*" ) }

try
	for l_row1 = 1 to upperbound( l_file_pattern )
		if l_file.of_get_files( l_file_pattern[l_row1], l_files ) <> 0 then
			for l_row2 = 1 to upperbound( l_files )
				l_extract	= fnc.strg.of_extract( l_files[l_row2], l_file_pattern[l_row1], "*" )
				
				if isnumber( l_extract ) then
					if l_target > long( l_extract ) then
						// ファイル削除
						if fileexists( l_files[l_row2] ) then
							filedelete( l_files[l_row2] )
						end if
					end if
				end if
			next 
		end if
	next
catch( runtimeerror err )
	txtlog.of_sys_alert_log( txtlog.TYPE_ALT, "cleanup", -999, "ローカルファイルのログクリアでエラー発生（" + err.text + "）")
	return false
end try

return true
end function

private function boolean palette ();palette.error_text			= rgb( 169, 68, 66 )
palette.error_text_dark		= rgb( 132, 53, 52 )
palette.error_back			= rgb( 242, 222, 222 )
palette.warning_text		= rgb( 138, 109, 59 )
palette.warning_text_dark	= rgb( 102, 81, 44 )
palette.warning_back		= rgb( 252, 248, 227 )
palette.info_text			= rgb( 49, 112, 143 )
palette.info_text_dark		= rgb( 36, 82, 105 )
palette.info_back			= rgb( 217, 237, 247 )
palette.success_text		= rgb( 60, 118, 61 )
palette.success_text_dark	= rgb( 43, 84, 44 )
palette.success_back		= rgb( 223, 240, 216 )

//palette.lattice_odd		= rgb( 255, 255, 255 )	// 奇数
palette.lattice_odd			= rgb( 255, 255, 245 )	// 奇数
palette.lattice_even		= rgb( 245, 245, 245 )	// 偶数
//palette.lattice_even		= rgb( 240, 240, 240 )	// 偶数


palette.main_background		= rgb( 240, 240, 240 )	// 3Dオブジェクト
palette.upper_background	= rgb( 192, 192, 192 )	// 銀
palette.dwlist_background	= rgb( 171, 171, 171 )	// アプリケーション作業領域

return true

end function

private function boolean dbconnect (boolean p_test);nv_database	l_db

l_db	= create nv_database

// 新基幹システムDB
if not l_db.of_connect( cocos, "kikan", p_test) then
	return false
end if


//// 本社物流システムDB
//if not l_db.of_connect( syukkadb, "buturyu", p_test ) then
//	return false
//end if
//
//// 生産管理システムDB
//if not l_db.of_connect( seisandb, "seisan", p_test ) then
//	return false
//end if
//
//// 販売分析システムDB
//if not l_db.of_connect( bunsekidb, "bunseki", p_test ) then
//	return false
//end if
//
//// CO-COS.netシステムDB
//if not l_db.of_connect( edidb, "ccsnet", p_test ) then
//	return false
//end if
//
//// FAX配信システムDB
//if not l_db.of_connect( faxdb, "fax", p_test ) then
//	return false
//end if
//
//// ホストシステムDB
//if not l_db.of_connect( host, "host", p_test ) then
//	return false
//end if
//
//// 情報システムDB
//if not l_db.of_connect( systemdb, "systemdb", p_test ) then
//	return false
//end if

destroy l_db

// 新基幹システムDB(ログ出力用) 設定情報のみ取得しログ出力時に接続する
//if not l_db.of_connect( logdb, "kikan", p_test ) then
logdb	= create inv_transaction
if not logdb.of_setup( "kikan", p_test ) then
	return false
end if


return true
end function

public function boolean multi_thread ();//choose case sharedobjectregister( "cv_loading", "loading" )
//	case Success!
//	case SharedObjectExistsError!
//		msg.of_error( "そのインスタンス名はすでに使用されています。" )
//		return false
//	case SharedObjectCreateInstanceError!
//		msg.of_error( "オブジェクトは作成できませんでした。" )
//		return false
//	case SharedObjectCreatePBSessionError!
//		msg.of_error( "共有オブジェクトセッションは作成できませんでした。" )
//		return false
//end choose

return true
end function

private function string get_system_ver ();// システム変更に関するバージョン情報を記載する

// バージョンについて（左から）
// メジャー		：実行プログラムの再生成が必要となる大規模な仕様変更に対するバージョン番号
// マイナー		：実行プログラムの再生成が必要となる小規模な仕様変更に対するバージョン番号
// ビルド		：実行プログラムの再生成が不要で部分的なビルドで対応できる小規模な仕様変更
// リビジョン	：実行プログラムの再生成が不要なバグ修正

return "1.0.0.0"	// 初期メジャーバージョン
end function

private subroutine system_profile ();application	l_app

l_app	= getapplication()

app.id		= l_app.classname()
app.name	= l_app.displayname
app.version	= get_system_ver( )

end subroutine

public subroutine of_logon_start ();// システム情報セット
system_profile( )

open( w_login )
//open( w_test )

end subroutine

private subroutine get_environment ();
end subroutine

private function boolean create_instance ();mdl	= create nv_modal

return true
end function

on nv_startup.create
call super::create
end on

on nv_startup.destroy
call super::destroy
end on

event constructor;call super::constructor;// テストサーバーへ接続する場合はTrueにする
test_mode	= true

end event

