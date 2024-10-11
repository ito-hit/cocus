$PBExportHeader$cv_input_kyoten.sru
$PBExportComments$m_kyotenの入力フォーム
forward
global type cv_input_kyoten from cv_input
end type
end forward

global type cv_input_kyoten from cv_input
string title_text = "コード"
boolean bikou_visible = false
end type
global cv_input_kyoten cv_input_kyoten

type variables

public:
	str_mkyoten	i_para_kyoten[]	// データの受け渡しをする構造体
	
protected:
	str_mkyoten	i_para_reset[]	// i_para_kyotenを初期化する用の変数

end variables

forward prototypes
public function long of_get_kyoten_code ()
public function string of_get_kyoten_mei ()
public function string of_get_kyoten_mei_ryaku ()
public function integer of_get_kyoten_kbn ()
end prototypes

public function long of_get_kyoten_code ();
// 外部からこの関数を呼んで、拠点コードをreturnする関数

string	l_input
long	l_kyoten_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_kyoten_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_kyoten ) = 0 then
	return l_kyoten_code
end if

return i_para_kyoten[1].kyoten_code
end function

public function string of_get_kyoten_mei ();
// 外部からこの関数を呼んで、拠点名をreturnする関数

if upperbound( i_para_kyoten ) = 0 then
	return ""
end if

return i_para_kyoten[1].kyoten_mei
end function

public function string of_get_kyoten_mei_ryaku ();
// 外部からこの関数を呼んで、拠点名(略称)をreturnする関数

if upperbound( i_para_kyoten ) = 0 then
	return ""
end if

return i_para_kyoten[1].kyoten_mei_ryaku
end function

public function integer of_get_kyoten_kbn ();
// 外部からこの関数を呼んで、拠点区分をreturnする関数

if upperbound( i_para_kyoten ) = 0 then
	return 0
end if

return i_para_kyoten[1].kyoten_kbn
end function

on cv_input_kyoten.create
call super::create
end on

on cv_input_kyoten.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_kyoten"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mkyoten	l_mdl_kyoten

// モーダルを開く
l_mdl_kyoten	= mdl.of_open_modal( "wsm_kyoten", l_mdl_kyoten )

if upperbound( l_mdl_kyoten.ret ) > 0 then
	get												= true
	i_para_kyoten									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_kyoten[upperbound(i_para_kyoten) + 1]	= l_mdl_kyoten.ret[upperbound( l_mdl_kyoten.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_kyoten[1].kyoten_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_kyoten_code

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_kyoten	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "拠点コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_kyoten_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_kyoten_get( l_kyoten_code, i_para_kyoten ) > 0 then
				get	= true
				of_set_meisyo( of_get_kyoten_mei() )
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
			if mst.of_kyoten_check( l_kyoten_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_kyoten_code ), chk_required, l_item, "m_kyoten", "kyoten_code", l_msg ) then
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

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_kyoten
end type

type st_meisyo from cv_input`st_meisyo within cv_input_kyoten
end type

type cb_modal from cv_input`cb_modal within cv_input_kyoten
end type

type sle_input from cv_input`sle_input within cv_input_kyoten
end type

type st_title from cv_input`st_title within cv_input_kyoten
string text = "コード"
end type

