$PBExportHeader$cv_input_kojyo.sru
$PBExportComments$sy_m_kojyoの入力フォーム
forward
global type cv_input_kojyo from cv_input
end type
end forward

global type cv_input_kojyo from cv_input
integer width = 1936
string title_text = "工場仕入先"
long title_width = 390
long input_width = 228
boolean bikou_visible = false
end type
global cv_input_kojyo cv_input_kojyo

type variables

public:
	str_mkojyo	i_para_kojyo[]	// データの受け渡しをする構造体
	
protected:
	str_mkojyo	i_para_reset[]	// i_para_kojyoを初期化する用の変数
end variables
forward prototypes
public function integer of_get_bumon_code ()
public function string of_get_kojyo_mei ()
public function string of_get_kojyo_mei_ryaku ()
public function string of_get_tuka_code ()
public function integer of_get_kojyo_kbn ()
public function long of_get_kojyo_code ()
end prototypes

public function integer of_get_bumon_code ();
// 外部からこの関数を呼んで、部門コードをreturnする関数

if upperbound( i_para_kojyo ) = 0 then
	return 0
end if

return i_para_kojyo[1].bumon_code
end function

public function string of_get_kojyo_mei ();
// 外部からこの関数を呼んで、工場名をreturnする関数

if upperbound( i_para_kojyo ) = 0 then
	return ""
end if

return i_para_kojyo[1].kojyo_mei
end function

public function string of_get_kojyo_mei_ryaku ();
// 外部からこの関数を呼んで、工場名(略称)をreturnする関数

if upperbound( i_para_kojyo ) = 0 then
	return ""
end if

return i_para_kojyo[1].kojyo_mei_ryaku
end function

public function string of_get_tuka_code ();
// 外部からこの関数を呼んで、通貨コードをreturnする関数

if upperbound( i_para_kojyo ) = 0 then
	return ""
end if

return i_para_kojyo[1].tuka_code
end function

public function integer of_get_kojyo_kbn ();
// 外部からこの関数を呼んで、工場区分をreturnする関数

if upperbound( i_para_kojyo ) = 0 then
	return 0
end if

return i_para_kojyo[1].kojyo_kbn
end function

public function long of_get_kojyo_code ();
// 外部からこの関数を呼んで、工場コードをreturnする関数

string	l_input
long	l_kojyo_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_kojyo_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_kojyo ) = 0 then
	return l_kojyo_code
end if

return i_para_kojyo[1].kojyo_code
end function

on cv_input_kojyo.create
call super::create
end on

on cv_input_kojyo.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_kojyo"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mkojyo	l_mdl_kojyo

// モーダルを開く
l_mdl_kojyo	= mdl.of_open_modal( "wsm_kojyo", l_mdl_kojyo )

if upperbound( l_mdl_kojyo.ret ) > 0 then
	i_para_kojyo								= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_kojyo[upperbound(i_para_kojyo) + 1]	= l_mdl_kojyo.ret[upperbound( l_mdl_kojyo.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_kojyo[1].kojyo_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_kojyo_code

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_kojyo	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "工場コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_kojyo_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_kojyo_get( l_kojyo_code, i_para_kojyo ) > 0 then
				get	= true
				of_set_meisyo( of_get_kojyo_mei() )
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
			// 重複チェックをする 販売システムでは登録はしないため重複チェックのみ 重複しなければtrue
			if mst.of_kojyo_check( l_kojyo_code ) <> 0 then
				// 重複していないのでOK
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

type st_bikou from cv_input`st_bikou within cv_input_kojyo
integer x = 1600
end type

type st_meisyo from cv_input`st_meisyo within cv_input_kojyo
integer x = 784
end type

type cb_modal from cv_input`cb_modal within cv_input_kojyo
integer x = 660
end type

type sle_input from cv_input`sle_input within cv_input_kojyo
integer x = 344
integer width = 300
end type

type st_title from cv_input`st_title within cv_input_kojyo
integer x = 12
string text = "工場仕入先"
end type

