$PBExportHeader$nv_shutdown.sru
$PBExportComments$システム終了時のスクリプト
forward
global type nv_shutdown from inv_object
end type
end forward

global type nv_shutdown from inv_object
end type
global nv_shutdown nv_shutdown

forward prototypes
public function boolean of_execute ()
public function boolean multi_thread ()
private function boolean set_registry ()
private function boolean destroy_instance ()
end prototypes

public function boolean of_execute ();
// マルチスレッド解放
if not multi_thread( ) then
	return false
end if

if not set_registry( ) then
	return false
end if

// グローバルインスタンス破棄
if not destroy_instance( ) then
	return false
end if


return true
end function

public function boolean multi_thread ();//choose case sharedobjectunregister( "loading" )
//	case Success!
//	case SharedObjectNotExistsError!
//		msg.of_error( "そのインスタンス名は登録されていません。")
//		return false
//end choose

return true


end function

private function boolean set_registry ();// 終了時の状態をレジストリに記録する

return true
end function

private function boolean destroy_instance ();destroy mdl

return true
end function

on nv_shutdown.create
call super::create
end on

on nv_shutdown.destroy
call super::destroy
end on

