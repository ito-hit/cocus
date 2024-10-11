$PBExportHeader$cv_input_mise.sru
$PBExportComments$m_miseの入力フォーム
forward
global type cv_input_mise from cv_input
end type
end forward

global type cv_input_mise from cv_input
integer width = 2260
string title_text = "店コード"
end type
global cv_input_mise cv_input_mise

type variables

public:
	str_mmise		i_para_mise[]	// 呼び出し元とデータの受け渡しをする構造体
	
protected:
	str_mmise		i_para_reset[]	// i_para_miseを初期化する用の変数
	long			i_tokui_code	// 得意先の入力フォームからセットする得意先コード
	
private:
	graphicobject	i_control[]		// 親Windowのコントロールをセットする
end variables

forward prototypes
public function long of_get_tokui_code ()
public function long of_get_mise_code ()
public function integer of_get_mise_kbn ()
public function integer of_get_heiten_flg ()
public function integer of_get_syusoku_flg ()
public function integer of_get_todofuken_code ()
public function long of_get_sikutyoson_code ()
public function long of_get_okuri_tokui_code ()
public function long of_get_okuri_mise_code ()
public function long of_get_okuri_center_code ()
public function string of_get_mise_mei_full ()
public function string of_get_mise_mei ()
public function string of_get_mise_mei_ryaku ()
public function string of_get_yubin_no ()
public function string of_get_jyusyo1 ()
public function string of_get_jyusyo2 ()
public function string of_get_jyusyo3 ()
public function string of_get_okuri_mei1 ()
public function string of_get_okuri_mei2 ()
public function string of_get_tel_no ()
public function string of_get_fax_no ()
public function boolean of_set_tokui_code ()
end prototypes

public function long of_get_tokui_code ();
// 外部からこの関数を呼んで、得意先コードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].tokui_code

end function

public function long of_get_mise_code ();
// 外部からこの関数を呼んで、店コードをreturnする関数

string	l_input
long	l_mise_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_mise_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_mise ) = 0 then
	return l_mise_code
end if

return i_para_mise[1].mise_code
end function

public function integer of_get_mise_kbn ();
// 外部からこの関数を呼んで、店区分をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].mise_kbn
end function

public function integer of_get_heiten_flg ();
// 外部からこの関数を呼んで、閉店フラグをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].heiten_flg
end function

public function integer of_get_syusoku_flg ();
// 外部からこの関数を呼んで、終息フラグをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].syusoku_flg
end function

public function integer of_get_todofuken_code ();
// 外部からこの関数を呼んで、都道府県コードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].todofuken_code
end function

public function long of_get_sikutyoson_code ();
// 外部からこの関数を呼んで、市区町村コードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].sikutyoson_code
end function

public function long of_get_okuri_tokui_code ();
// 外部からこの関数を呼んで、送り得意先コードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].okuri_tokui_code
end function

public function long of_get_okuri_mise_code ();
// 外部からこの関数を呼んで、送り店コードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].okuri_mise_code
end function

public function long of_get_okuri_center_code ();
// 外部からこの関数を呼んで、送りセンターコードをreturnする関数

if upperbound( i_para_mise ) = 0 then
	return 0
end if

return i_para_mise[1].okuri_center_code
end function

public function string of_get_mise_mei_full ();
// 外部からこの関数を呼んで、店名をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].mise_mei_full
end function

public function string of_get_mise_mei ();
// 外部からこの関数を呼んで、店名(社内表示名)をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].mise_mei
end function

public function string of_get_mise_mei_ryaku ();
// 外部からこの関数を呼んで、店名(略称)をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].mise_mei_ryaku
end function

public function string of_get_yubin_no ();
// 外部からこの関数を呼んで、郵便番号をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].yubin_no
end function

public function string of_get_jyusyo1 ();
// 外部からこの関数を呼んで、住所1をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].jyusyo1
end function

public function string of_get_jyusyo2 ();
// 外部からこの関数を呼んで、住所2をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].jyusyo2
end function

public function string of_get_jyusyo3 ();
// 外部からこの関数を呼んで、住所3をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].jyusyo3
end function

public function string of_get_okuri_mei1 ();
// 外部からこの関数を呼んで、送り先名1をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].okuri_mei1
end function

public function string of_get_okuri_mei2 ();
// 外部からこの関数を呼んで、送り先名2をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].okuri_mei2
end function

public function string of_get_tel_no ();
// 外部からこの関数を呼んで、電話番号をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].tel_no
end function

public function string of_get_fax_no ();
// 外部からこの関数を呼んで、FAX番号をreturnする関数

if upperbound( i_para_mise ) = 0 then
	return ""
end if

return i_para_mise[1].fax_no
end function

public function boolean of_set_tokui_code ();
// cv_input_tokuiを探して得意先コードをインスタンス変数にセットする

boolean			l_ret
long			l_null
long			l_row
graphicobject	l_obj
string			l_typeof

l_ret	= false
setnull( l_null )

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_tokui"があれば、得意先コードをセットする
	if l_typeof = "input_tokui" then
		i_tokui_code	= l_obj.dynamic of_get_tokui_code()
		l_ret			= true
		exit
	end if
next

if not l_ret then
	i_tokui_code	= l_null
end if

return l_ret
end function

on cv_input_mise.create
call super::create
end on

on cv_input_mise.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_mise"

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_mise_code
integer	l_heiten_flg

l_ret		= true
l_input		= trim( of_get_input( ) )
i_para_mise	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item		= "店コード"

// 入力チェック
if len( l_input ) > 0 and l_ret then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_mise_code	= long( l_input )
	
	// 得意先コードをセットする
	if not of_set_tokui_code() then
		// 今は特になし
	end if

	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_mise_get( i_tokui_code, l_mise_code, i_para_mise ) > 0 then
				get	= true
				of_set_meisyo( of_get_mise_mei() )
				
				// 備考が表示されているなら
				if bikou_visible then
					// 備考(閉店)の反映
					l_heiten_flg	= of_get_heiten_flg()
					
					if l_heiten_flg <> 1 then
						of_reset( "bikou" )
					else
						of_set_bikou( "閉店" )
					end if
				end if
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
			// 重複チェック時は得意先コードの入力は必要
			if i_tokui_code = 0 or isnull( i_tokui_code ) then
				sle_input.of_msg_error( "得意先コードが入力されていません。" )
				sle_input.setfocus()
				return false
			end if
			
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_mise_check( i_tokui_code, l_mise_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_mise_code ), chk_required, l_item, "m_mise", "mise_code", l_msg ) then
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
str_mdlpara_mmise	l_mdl_mise

// 得意先コードをセットする
if not of_set_tokui_code() then
	// 今は特になし
end if

// モーダルを開く
l_mdl_mise.in_tokui_code	= i_tokui_code	// nullかどうかはモーダルに任せる
l_mdl_mise					= mdl.of_open_modal( "wsm_mise", l_mdl_mise )

if upperbound( l_mdl_mise.ret ) > 0 then
	get											= true
	i_para_mise									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_mise[upperbound(i_para_mise) + 1]	= l_mdl_mise.ret[upperbound( l_mdl_mise.ret )]
	
//	// i_tokui_codeがセットされていない場合があるのでここでセットしてやるか？
//	if i_tokui_code = 0 or isnull( i_tokui_code ) then
//		this.of_set_tokui_code( i_para_mise[upperbound(i_para_mise)].tokui_code )
//	end if

	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_mise[1].mise_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_mise
integer x = 1920
end type

type st_meisyo from cv_input`st_meisyo within cv_input_mise
integer x = 704
integer width = 1200
end type

type cb_modal from cv_input`cb_modal within cv_input_mise
integer x = 580
end type

type sle_input from cv_input`sle_input within cv_input_mise
integer width = 232
end type

type st_title from cv_input`st_title within cv_input_mise
string text = "店コード"
end type

