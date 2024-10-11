$PBExportHeader$cv_input_meisyo.sru
$PBExportComments$m_meisyoの入力フォーム
forward
global type cv_input_meisyo from cv_input
end type
end forward

global type cv_input_meisyo from cv_input
integer width = 1900
string title_text = "名称"
boolean bikou_visible = false
end type
global cv_input_meisyo cv_input_meisyo

type variables

public:
	str_mmeisyo	i_para_meisyo[]				// データの受け渡しをする構造体
	
	integer		meisyo_kbn		= 0			// 検索する名称区分
	
	boolean		meisyo_1_hyoji	= true		// チェックが入ったらst_meisyoにmeisyo_1を表示させる
	boolean		meisyo_2_hyoji				// チェックが入ったらst_meisyoにmeisyo_2を表示させる
	boolean		meisyo_3_hyoji				// チェックが入ったらst_meisyoにmeisyo_3を表示させる
	
protected:
	str_mmeisyo	i_para_reset[]	// i_para_meisyoを初期化する用の変数
end variables

forward prototypes
public function string of_get_meisyo_code ()
public function string of_get_meisyo_1 ()
public function long of_get_meisyo_kbn ()
public function string of_get_meisyo_2 ()
public function string of_get_meisyo_3 ()
public function string of_get_meisyo_mei ()
end prototypes

public function string of_get_meisyo_code ();
// 外部からこの関数を呼んで、名称コードをreturnする関数

string	l_meisyo_code

l_meisyo_code	= trim( of_get_input() )

// 入力値があるかどうか確認
if len( l_meisyo_code ) = 0 then
	return ""
end if

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_meisyo ) = 0 then
	return l_meisyo_code
end if

// 入力値をそのまま返す
return i_para_meisyo[1].meisyo_code
end function

public function string of_get_meisyo_1 ();
// 外部からこの関数を呼んで、名称1をreturnする関数

if upperbound( i_para_meisyo ) = 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_1
end function

public function long of_get_meisyo_kbn ();
// 外部からこの関数を呼んで、名称区分をreturnする関数
long	l_null

setnull( l_null )

if upperbound( i_para_meisyo ) = 0 then
	return l_null	// 0は値として存在するので返せない
end if

return i_para_meisyo[1].meisyo_kbn
end function

public function string of_get_meisyo_2 ();
// 外部からこの関数を呼んで、名称2をreturnする関数

if upperbound( i_para_meisyo ) = 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_2
end function

public function string of_get_meisyo_3 ();
// 外部からこの関数を呼んで、名称3をreturnする関数

if upperbound( i_para_meisyo ) = 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_3
end function

public function string of_get_meisyo_mei ();
// 外部からこの関数を呼んで、名称名をreturnする関数

if upperbound( i_para_meisyo ) = 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_mei
end function

on cv_input_meisyo.create
call super::create
end on

on cv_input_meisyo.destroy
call super::destroy
end on

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_meisyo_code

l_ret			= true
l_meisyo_code	= trim( of_get_input( ) )
i_para_meisyo	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

if len( l_meisyo_code ) > 0 then
	l_item	= trim( this.title_text )	// 入力されるコードの名前を取得する

	if pos( l_item, "コード" ) = 0 then
		l_item	= l_item + "コード"
	end if

	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_meisyo_get( meisyo_kbn, l_meisyo_code, i_para_meisyo ) > 0 then
				get	= true
				
				// meisyo_**にチェックがあればここが動く
				if meisyo_1_hyoji then
					of_set_meisyo( fnc.of_nvl( of_get_meisyo_1(), "???" ) )
				elseif meisyo_2_hyoji then
					of_set_meisyo( fnc.of_nvl( of_get_meisyo_2(), "???" ) )
				elseif meisyo_3_hyoji then
					of_set_meisyo( fnc.of_nvl( of_get_meisyo_3(), "???" ) )
				else
					// 何もしない
				end if
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。" 
					l_ret	=  false
				else
					of_reset( "meisyobikou" )
				end if
			end if
		case 2
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_meisyo_check( meisyo_kbn, l_meisyo_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( l_meisyo_code, chk_required, l_item, "m_meisyo", "meisyo_code", l_msg ) then
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

event constructor;call super::constructor;
object_type	= "input_meisyo"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mmeisyo	l_mdl_meisyo

// モーダルを開く
l_mdl_meisyo.in_meisyo_kbn	= meisyo_kbn
l_mdl_meisyo				= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )

if upperbound( l_mdl_meisyo.ret ) > 0 then
	get												= true
	i_para_meisyo									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_meisyo[upperbound( i_para_meisyo ) + 1]	= l_mdl_meisyo.ret[upperbound( l_mdl_meisyo.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_meisyo[1].meisyo_code )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true
end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_meisyo
integer x = 1500
integer y = 4
end type

event st_bikou::constructor;call super::constructor;st_bikou.visible	= true
end event

type st_meisyo from cv_input`st_meisyo within cv_input_meisyo
end type

type cb_modal from cv_input`cb_modal within cv_input_meisyo
end type

type sle_input from cv_input`sle_input within cv_input_meisyo
string tag = "名称コード"
end type

type st_title from cv_input`st_title within cv_input_meisyo
string text = "名称"
end type

