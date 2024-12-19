$PBExportHeader$cv_input_teisu.sru
$PBExportComments$m_teisuの入力フォーム
forward
global type cv_input_teisu from cv_input
end type
end forward

global type cv_input_teisu from cv_input
integer width = 3276
string title_text = "定数区分"
long title_width = 330
long input_width = 140
long bikou_width = 984
end type
global cv_input_teisu cv_input_teisu

type variables

public:
	str_mteisu	i_para_teisu[]	// データの受け渡しをする構造体
	
protected:
	str_mteisu	i_para_reset[]	// i_para_teisuを初期化する用の変数
end variables

forward prototypes
public function string of_get_teisu_code ()
public function decimal of_get_teisu_1 ()
public function decimal of_get_teisu_2 ()
public function decimal of_get_teisu_3 ()
public function string of_get_teisu_mei ()
public function long of_get_teisu_kbn ()
end prototypes

public function string of_get_teisu_code ();
// 外部からこの関数を呼んで、定数コードをreturnする関数

if upperbound( i_para_teisu ) <= 0 then
	return ""
end if

return i_para_teisu[1].teisu_code
end function

public function decimal of_get_teisu_1 ();
// 外部からこの関数を呼んで、定数1をreturnする関数

if upperbound( i_para_teisu ) = 0 then
	return 0
end if

return i_para_teisu[1].teisu_1
end function

public function decimal of_get_teisu_2 ();
// 外部からこの関数を呼んで、定数2をreturnする関数

if upperbound( i_para_teisu ) = 0 then
	return 0
end if

return i_para_teisu[1].teisu_2
end function

public function decimal of_get_teisu_3 ();
// 外部からこの関数を呼んで、定数3をreturnする関数

if upperbound( i_para_teisu ) = 0 then
	return 0
end if

return i_para_teisu[1].teisu_3
end function

public function string of_get_teisu_mei ();
// 外部からこの関数を呼んで、定数名をreturnする関数

if upperbound( i_para_teisu ) = 0 then
	return ""
end if

return i_para_teisu[1].teisu_mei
end function

public function long of_get_teisu_kbn ();
// 外部からこの関数を呼んで、定数区分をreturnする関数

string	l_input
long	l_teisu_kbn
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_teisu_kbn	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_teisu ) = 0 then
	return l_teisu_kbn
end if

return i_para_teisu[1].teisu_kbn
end function

on cv_input_teisu.create
call super::create
end on

on cv_input_teisu.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_teisu"

// 初期化処理
of_reset( "inputmeisyo" )	// 備考は消さない

return 0
end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

event open_modal;call super::open_modal;
str_mdlpara_mteisu	l_mdl_teisu

// モーダルを開く
l_mdl_teisu	= mdl.of_open_modal( "wsm_teisu", l_mdl_teisu )

if upperbound( l_mdl_teisu.ret ) > 0 then
	get												= true
	i_para_teisu									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_teisu[upperbound( i_para_teisu ) + 1]	= l_mdl_teisu.ret[upperbound( l_mdl_teisu.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_teisu[1].teisu_code )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_teisu_kbn

l_ret			= true
l_teisu_kbn		= trim( of_get_input( ) )
i_para_teisu	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "定数区分"	// 入力されるコードの名前を取得する

if len( l_teisu_kbn ) > 0 then
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_teisu_get( 0, l_teisu_kbn, i_para_teisu ) > 0 then
				get	= true
				of_set_meisyo( of_get_teisu_mei() )
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。"
					l_ret	= false
				else
					of_reset( "teisu" )
				end if
			end if
		case 2
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_teisu_check( 0, l_teisu_kbn ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( l_teisu_kbn, chk_required, l_item, "m_teisu", "teisu_kbn", l_msg ) then
					of_reset( "teisu" )	// 備考は消さない
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
		of_reset( "teisu" )
	end if
end if

// falseの処理
if not l_ret then
	sle_input.of_msg_error( l_msg )
	of_reset( "teisu" )	// 備考は消さない
	sle_input.setfocus()
end if

return l_ret
end event

type st_bikou from cv_input`st_bikou within cv_input_teisu
integer x = 2180
integer width = 984
string text = "新区分登録時は定数区分=0を入力"
end type

type st_meisyo from cv_input`st_meisyo within cv_input_teisu
integer width = 1512
end type

type cb_modal from cv_input`cb_modal within cv_input_teisu
end type

type sle_input from cv_input`sle_input within cv_input_teisu
end type

type st_title from cv_input`st_title within cv_input_teisu
string text = "定数区分"
end type

