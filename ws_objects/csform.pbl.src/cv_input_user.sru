$PBExportHeader$cv_input_user.sru
$PBExportComments$m_userの入力フォーム
forward
global type cv_input_user from cv_input
end type
end forward

global type cv_input_user from cv_input
string title_text = "ユーザー"
boolean bikou_visible = false
end type
global cv_input_user cv_input_user

type variables

public:
	str_muser	i_para_user[]	// データの受け渡しをする構造体
	
protected:
	str_muser	i_para_reset[]	// i_para_userを初期化する用の変数

end variables

forward prototypes
public function string of_get_user_id ()
public function string of_get_user_mei ()
public function string of_get_user_mei_ryaku ()
public function long of_get_kyoten_code ()
public function long of_get_kyoten_code_2 ()
public function long of_get_kyoten_group_code ()
public function integer of_get_login_kengen ()
end prototypes

public function string of_get_user_id ();
// 外部からこの関数を呼んで、ユーザーIDをreturnする関数

string	l_user_id

l_user_id	= trim( of_get_input() )

// 入力値があるかどうか確認
if len( l_user_id ) = 0 then
	return ""
end if

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_user ) = 0 then
	return l_user_id
end if

// 入力値をそのまま返す
return i_para_user[1].user_id
end function

public function string of_get_user_mei ();
// 外部からこの関数を呼んで、ユーザー名をreturnする関数

if upperbound( i_para_user ) = 0 then
	return ""
end if

return i_para_user[1].user_mei
end function

public function string of_get_user_mei_ryaku ();
// 外部からこの関数を呼んで、ユーザー名(略称)をreturnする関数

if upperbound( i_para_user ) = 0 then
	return ""
end if

return i_para_user[1].user_mei_ryaku
end function

public function long of_get_kyoten_code ();
// 外部からこの関数を呼んで、拠点コードをreturnする関数

if upperbound( i_para_user ) = 0 then
	return 0
end if

return i_para_user[1].kyoten_code
end function

public function long of_get_kyoten_code_2 ();
// 外部からこの関数を呼んで、拠点コード2をreturnする関数

if upperbound( i_para_user ) = 0 then
	return 0
end if

return i_para_user[1].kyoten_code_2
end function

public function long of_get_kyoten_group_code ();
// 外部からこの関数を呼んで、拠点グループコードをreturnする関数

if upperbound( i_para_user ) = 0 then
	return 0
end if

return i_para_user[1].kyoten_group_code
end function

public function integer of_get_login_kengen ();
// 外部からこの関数を呼んで、ログイン権限をreturnする関数

if upperbound( i_para_user ) = 0 then
	return 0
end if

return i_para_user[1].login_kengen
end function

on cv_input_user.create
call super::create
end on

on cv_input_user.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_user"

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_user_id

l_ret		= true
l_user_id	= trim( of_get_input( ) )
i_para_user	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

if len( l_user_id ) > 0 then
	l_item	= "ユーザーID"
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_user_get( l_user_id, i_para_user ) > 0 then
				get	= true
				of_set_meisyo( of_get_user_mei() )
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。"
					l_ret	= false
				else
					of_reset( "meisyobikou" )
				end if
			end if
		case 2
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_user_check( l_user_id ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( l_user_id, chk_required, l_item, "m_user", "user_id", l_msg ) then
					of_reset( "meisyobikou" )
				else
					l_ret	= false
				end if
			else
				l_msg	= "入力された" + l_item + "はマスタに存在しています。"
				l_ret	= false
			end if
		case else
			// 何もしない
	end choose
else
	// 入力値が何もないなら何もしない
	of_reset( "meisyobikou" )
end if

// falseの処理
if not l_ret then
	sle_input.of_msg_error( l_msg )
	of_reset( "meisyobikou" )
	sle_input.setfocus()
end if

return l_ret
end event

event open_modal;call super::open_modal;
str_mdlpara_muser	l_mdl_user

// モーダルを開く
l_mdl_user	= mdl.of_open_modal( "wsm_user", l_mdl_user )

if upperbound( l_mdl_user.ret ) > 0 then
	get											= true
	i_para_user									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_user[upperbound(i_para_user) + 1]	= l_mdl_user.ret[upperbound( l_mdl_user.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_user[1].user_id )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_user
end type

type st_meisyo from cv_input`st_meisyo within cv_input_user
end type

type cb_modal from cv_input`cb_modal within cv_input_user
end type

type sle_input from cv_input`sle_input within cv_input_user
end type

type st_title from cv_input`st_title within cv_input_user
string text = "ユーザー"
end type

