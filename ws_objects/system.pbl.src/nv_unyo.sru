$PBExportHeader$nv_unyo.sru
$PBExportComments$運用管理に関するスクリプト
forward
global type nv_unyo from inv_object
end type
end forward

global type nv_unyo from inv_object autoinstantiate
end type

forward prototypes
public function boolean of_get_operation ()
public function boolean of_get_unyo_range (ref long p_start_date, ref long p_end_date)
end prototypes

public function boolean of_get_operation ();// true:運用中 false:停止中

integer	l_ret

declare orafunc procedure for mng.operation using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return false
end if

if l_ret <> 0 then
	return true
else
	return false
end if
end function

public function boolean of_get_unyo_range (ref long p_start_date, ref long p_end_date);// true:運用時間内 false:運用時間外

integer	l_ret

declare orafunc procedure for mng.get_unyo_range2 using cocos;
execute orafunc;
fetch orafunc into :l_ret, :p_start_date, :p_end_date;
close orafunc;

if cocos.sqlcode <> 0 then
	return false
end if

if l_ret <> 0 then
	return true
else
	return false
end if
end function

on nv_unyo.create
call super::create
end on

on nv_unyo.destroy
call super::destroy
end on

