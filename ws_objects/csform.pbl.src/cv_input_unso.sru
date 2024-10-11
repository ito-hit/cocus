﻿$PBExportHeader$cv_input_unso.sru
$PBExportComments$m_unsoの入力フォーム
forward
global type cv_input_unso from cv_input
end type
end forward

global type cv_input_unso from cv_input
string title_text = "運送便"
boolean bikou_visible = false
end type
global cv_input_unso cv_input_unso

type variables

public:
	str_munso	i_para_unso[]	// データの受け渡しをする構造体
	
protected:
	str_munso	i_para_reset[]	// i_para_unsoを初期化する用の変数

end variables

forward prototypes
public function string of_get_unso_mei ()
public function string of_get_unso_mei_ryaku ()
public function long of_get_unso_code ()
public function integer of_get_haiban_flg ()
end prototypes

public function string of_get_unso_mei ();
// 外部からこの関数を呼んで、運送便名をreturnする関数

if upperbound( i_para_unso ) = 0 then
	return ""
end if

return i_para_unso[1].unso_mei
end function

public function string of_get_unso_mei_ryaku ();
// 外部からこの関数を呼んで、運送便名(略称)をreturnする関数

if upperbound( i_para_unso ) = 0 then
	return ""
end if

return i_para_unso[1].unso_mei_ryaku
end function

public function long of_get_unso_code ();
// 外部からこの関数を呼んで、運送便コードをreturnする関数

string	l_input
long	l_unso_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_unso_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_unso ) = 0 then
	return l_unso_code
end if

return i_para_unso[1].unso_code
end function

public function integer of_get_haiban_flg ();
// 外部からこの関数を呼んで、廃番フラグをreturnする関数

if upperbound( i_para_unso ) = 0 then
	return 0
end if

return i_para_unso[1].haiban_flg
end function

on cv_input_unso.create
call super::create
end on

on cv_input_unso.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_unso"

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_unso_code

l_ret		= true
l_input		= trim( of_get_input( ) )
i_para_unso	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item		= "運送便コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_unso_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_unso_get( l_unso_code, i_para_unso ) > 0 then
				get	= true
				of_set_meisyo( of_get_unso_mei() )
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
			if mst.of_unso_check( l_unso_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_unso_code ), chk_required, l_item, "m_unso", "unso_code", l_msg ) then
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
	if chk_required then
		l_msg	= l_item + "は必須入力です。"
		l_ret	= false
	else
		of_reset( "meisyobikou" )
	end if
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
str_mdlpara_munso	l_mdl_unso

// モーダルを開く
l_mdl_unso	= mdl.of_open_modal( "wsm_unso", l_mdl_unso )

if upperbound( l_mdl_unso.ret ) > 0 then
	get											= true
	i_para_unso									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_unso[upperbound(i_para_unso) + 1]	= l_mdl_unso.ret[upperbound( l_mdl_unso.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_unso[1].unso_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_unso
end type

type st_meisyo from cv_input`st_meisyo within cv_input_unso
end type

type cb_modal from cv_input`cb_modal within cv_input_unso
end type

type sle_input from cv_input`sle_input within cv_input_unso
end type

type st_title from cv_input`st_title within cv_input_unso
string text = "運送便"
end type
