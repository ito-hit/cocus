$PBExportHeader$nv_kin_test.sru
$PBExportComments$nv系テスト実行用
forward
global type nv_kin_test from nonvisualobject
end type
end forward

global type nv_kin_test from nonvisualobject
end type
global nv_kin_test nv_kin_test

forward prototypes
public subroutine of_start ()
public subroutine of_test_dbfunc ()
end prototypes

public subroutine of_start ();
// dbfuncテスト
of_test_dbfunc()
end subroutine

public subroutine of_test_dbfunc ();
msg.of_info( "[1]:" + fnc.db.of_cnv_date_sei2wa() )

datetime	l_date
l_date	= datetime( today(), now() )
msg.of_info( "[2]:" + fnc.db.of_cnv_date_sei2wa( l_date ) )

msg.of_info( "[3]:" + fnc.db.of_cnv_date_sei2wa( 1976, 8, 28 ) )

msg.of_info( "[4]:" + fnc.db.of_cnv_date_sei2wa_jp() )
msg.of_info( "[5]:" + fnc.db.of_cnv_date_sei2wa_jp( l_date ) )
msg.of_info( "[6]:" + fnc.db.of_cnv_date_sei2wa_jp( 1976, 8, 28 ) )
msg.of_info( "[7-1]:" + string( fnc.db.of_cnv_date_wa2sei( "S51/08/28" ) ) )
msg.of_info( "[7-2]:" + string( fnc.db.of_cnv_date_wa2sei( "昭和51年8月28日" ) ) )
msg.of_info( "[8-1]:" + string( fnc.db.of_cnv_date_wa2sei( "S51", 8, 28 ) ) ) 
msg.of_info( "[8-2]:" + string( fnc.db.of_cnv_date_wa2sei( "昭和51", 8, 28 ) ) )

end subroutine

on nv_kin_test.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_kin_test.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

