$PBExportHeader$cv_input_meisyo_parent.sru
$PBExportComments$m_meisyo(parent)の入力フォーム
forward
global type cv_input_meisyo_parent from cv_input
end type
end forward

global type cv_input_meisyo_parent from cv_input
integer width = 3276
string title_text = "名称区分"
long bikou_width = 984
end type
global cv_input_meisyo_parent cv_input_meisyo_parent

type variables

public:
	str_mmeisyo	i_para_meisyo[]	// データの受け渡しをする構造体
	
protected:
	str_mmeisyo	i_para_reset[]	// i_para_meisyoを初期化する用の変数
end variables

forward prototypes
public function string of_get_meisyo_code ()
public function string of_get_meisyo_1 ()
public function string of_get_meisyo_2 ()
public function string of_get_meisyo_3 ()
public function string of_get_meisyo_mei ()
public function long of_get_meisyo_kbn ()
end prototypes

public function string of_get_meisyo_code ();
// 外部からこの関数を呼んで、名称コードをreturnする関数

if upperbound( i_para_meisyo ) <= 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_code
end function

public function string of_get_meisyo_1 ();
// 外部からこの関数を呼んで、名称1をreturnする関数

if upperbound( i_para_meisyo ) = 0 then
	return ""
end if

return i_para_meisyo[1].meisyo_1
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

public function long of_get_meisyo_kbn ();
// 外部からこの関数を呼んで、名称区分をreturnする関数

string	l_input
long	l_meisyo_kbn
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_meisyo_kbn	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_meisyo ) = 0 then
	return l_meisyo_kbn
end if

return i_para_meisyo[1].meisyo_kbn
end function

on cv_input_meisyo_parent.create
call super::create
end on

on cv_input_meisyo_parent.destroy
call super::destroy
end on

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_meisyo_kbn

l_ret			= true
l_meisyo_kbn	= trim( of_get_input( ) )
i_para_meisyo	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

if len( l_meisyo_kbn ) > 0 then
	l_item	= "名称区分"	// 入力されるコードの名前を取得する
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_meisyo_get( 0, l_meisyo_kbn, i_para_meisyo ) > 0 then
				get	= true
				of_set_meisyo( of_get_meisyo_mei() )
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
			if mst.of_meisyo_check( 0, l_meisyo_kbn ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( l_meisyo_kbn, chk_required, l_item, "m_meisyo", "meisyo_kbn", l_msg ) then
					of_reset( "meisyo" )	// 備考は消さない
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
	// 入力値が何もないなら何もしない 備考は消さない
	of_reset( "meisyo" )
end if

// falseの処理
if not l_ret then
	sle_input.of_msg_error( l_msg )
	of_reset( "meisyo" )	// 備考は消さない
	sle_input.setfocus()
end if

return l_ret
end event

event constructor;call super::constructor;
object_type	= "input_meisyo_parent"

// 初期化処理
of_reset( "inputmeisyo" )	// 備考は消さない

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mmeisyo	l_mdl_meisyo

// モーダルを開く
l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo_parent", l_mdl_meisyo )

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

type st_bikou from cv_input`st_bikou within cv_input_meisyo_parent
integer x = 2180
integer width = 984
string text = "※新区分登録時は名称区分＝0を入力"
end type

event st_bikou::constructor;call super::constructor;st_bikou.visible	= true
end event

type st_meisyo from cv_input`st_meisyo within cv_input_meisyo_parent
integer width = 1512
end type

type cb_modal from cv_input`cb_modal within cv_input_meisyo_parent
end type

type sle_input from cv_input`sle_input within cv_input_meisyo_parent
end type

type st_title from cv_input`st_title within cv_input_meisyo_parent
string text = "名称区分"
end type

