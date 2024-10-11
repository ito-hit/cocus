$PBExportHeader$nv_kengen.sru
$PBExportComments$権限に関するスクリプト
forward
global type nv_kengen from inv_object
end type
end forward

global type nv_kengen from inv_object autoinstantiate
end type

forward prototypes
public function boolean of_check_admin ()
public function boolean of_check (string p_window_id)
public function boolean of_check (integer p_kengen_kbn, string p_user_id)
public function boolean of_check (string p_window_id, string p_user_id)
public function boolean of_check_admin (string p_user_id)
public function boolean of_check (integer p_kengen_kbn)
end prototypes

public function boolean of_check_admin ();return of_check_admin( user.user_id )

end function

public function boolean of_check (string p_window_id);return of_check( p_window_id, user.user_id )

end function

public function boolean of_check (integer p_kengen_kbn, string p_user_id);integer	l_cnt
boolean	l_ret

l_ret	= false

if p_kengen_kbn <> 0 then
	select count(*)
	  into :l_cnt
	  from m_kengen
	 where kengen_kbn	= :p_kengen_kbn
	   and user_id		= :p_user_id
	 using cocos;

	if cocos.sqlcode <> 0 then
		//Oracleエラー
		msg.of_error( fnc.strg.of_format( "ユーザーの権限情報取得でエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
	else
		if l_cnt > 0 then
			l_ret	= true
		end if
	end if
else
	l_ret	= true
end if

return l_ret
end function

public function boolean of_check (string p_window_id, string p_user_id);integer	l_kengen

select kengen_kbn
  into :l_kengen
  from m_window
 where window_id	= :p_window_id
using cocos;

choose case cocos.sqlcode
	case 0
		return of_check( l_kengen, p_user_id )
	case 100
		return false
	case else
		//Oracleエラー
		msg.of_error( fnc.strg.of_format( "ユーザーの権限情報取得（Window情報の取得）でエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		return false
end choose


end function

public function boolean of_check_admin (string p_user_id);return of_check( kengen_admin, p_user_id )
end function

public function boolean of_check (integer p_kengen_kbn);return of_check( p_kengen_kbn, user.user_id )
end function

on nv_kengen.create
call super::create
end on

on nv_kengen.destroy
call super::destroy
end on

