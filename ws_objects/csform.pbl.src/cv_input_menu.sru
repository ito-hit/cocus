$PBExportHeader$cv_input_menu.sru
$PBExportComments$m_menuの入力フォーム
forward
global type cv_input_menu from cv_input
end type
end forward

global type cv_input_menu from cv_input
integer width = 1824
integer height = 92
string title_text = "メニュー"
long input_width = 768
boolean meisyo_visible = false
boolean bikou_visible = false
end type
global cv_input_menu cv_input_menu

type variables

public:
	str_mmenu		i_para_menu[]	// データの受け渡しをする構造体
	
protected:
	str_mmenu		i_para_reset[]	// i_para_menuを初期化する用の変数
end variables

forward prototypes
public function string of_get_menu_id ()
public function string of_get_tab_id ()
public function string of_get_window_id ()
public function integer of_get_button_no ()
public function string of_get_param ()
public function integer of_get_siyo_kanou_flg ()
public function integer of_get_button_no (string p_tab_id)
public function string of_get_param (string p_tab_id)
public function integer of_get_siyo_kanou_flg (string p_tab_id)
public function string of_get_window_id (string p_tab_id)
end prototypes

public function string of_get_menu_id ();
// 外部からこの関数を呼んで、メニューIDをreturnする関数

string	l_menu_id

l_menu_id	= trim( of_get_input() )

// 入力値があるかどうか確認
if len( l_menu_id ) = 0 then
	return ""
end if

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_menu ) = 0 then
	return l_menu_id
end if

// 入力値をそのまま返す
return i_para_menu[1].menu_id
end function

public function string of_get_tab_id ();
// 外部からこの関数を呼んで、タブIDをreturnする関数

if upperbound( i_para_menu ) = 0 then
	return ""
end if

return i_para_menu[1].tab_id
end function

public function string of_get_window_id ();
// 外部からこの関数を呼んで、ウィンドウIDをreturnする関数

string	l_null

setnull( l_null )

return of_get_window_id( l_null )
end function

public function integer of_get_button_no ();
// 外部からこの関数を呼んで、ボタンNoをreturnする関数

string	l_null

setnull( l_null )

return of_get_button_no( l_null )
end function

public function string of_get_param ();
// 外部からこの関数を呼んで、引数をreturnする関数

string	l_null

setnull( l_null )

return of_get_param( l_null )
end function

public function integer of_get_siyo_kanou_flg ();
// 外部からこの関数を呼んで、使用可能フラグをreturnする関数

string	l_null

setnull( l_null )

return of_get_siyo_kanou_flg( l_null )
end function

public function integer of_get_button_no (string p_tab_id);
// 外部からこの関数を呼んで、ボタンNoをreturnする関数

string	l_tab_id
long	l_row_max, l_count

if upperbound( i_para_menu ) = 0 then
	return 0
end if

// p_tab_idがnullなら先頭のボタンNoを返す
l_tab_id	= trim( p_tab_id )

if len( l_tab_id ) = 0 or isnull( l_tab_id ) then
	return i_para_menu[1].button_no
end if

l_row_max	= upperbound( i_para_menu )

for l_count = 1 to l_row_max
	// タブIDを検索
	if i_para_menu[l_count].tab_id = l_tab_id then
		return i_para_menu[l_count].button_no
	end if
next

// 何も一致しなかったら
return 0

end function

public function string of_get_param (string p_tab_id);
// 外部からこの関数を呼んで、引数をreturnする関数

string	l_tab_id
long	l_row_max, l_count

if upperbound( i_para_menu ) = 0 then
	return ""
end if

// p_tab_idがnullなら先頭の引数を返す
l_tab_id	= trim( p_tab_id )

if len( l_tab_id ) = 0 or isnull( l_tab_id ) then
	return i_para_menu[1].param
end if

l_row_max	= upperbound( i_para_menu )

for l_count = 1 to l_row_max
	// タブIDを検索
	if i_para_menu[l_count].tab_id = l_tab_id then
		return i_para_menu[l_count].param
	end if
next

// 何も一致しなかったら
return ""
end function

public function integer of_get_siyo_kanou_flg (string p_tab_id);
// 外部からこの関数を呼んで、使用可能フラグをreturnする関数

string	l_tab_id
long	l_row_max, l_count

if upperbound( i_para_menu ) = 0 then
	return 0
end if

// p_tab_idがnullなら先頭の使用可能フラグを返す
l_tab_id	= trim( p_tab_id )

if len( l_tab_id ) = 0 or isnull( l_tab_id ) then
	return i_para_menu[1].siyo_kanou_flg
end if

l_row_max	= upperbound( i_para_menu )

for l_count = 1 to l_row_max
	// タブIDを検索
	if i_para_menu[l_count].tab_id = l_tab_id then
		return i_para_menu[l_count].siyo_kanou_flg
	end if
next

// 何も一致しなかったら
return 0

end function

public function string of_get_window_id (string p_tab_id);
// 外部からこの関数を呼んで、ウィンドウIDをreturnする関数

string	l_tab_id
long	l_row_max, l_count

if upperbound( i_para_menu ) = 0 then
	return ""
end if

// p_tab_idがnullなら先頭のウィンドウIDを返す
l_tab_id	= trim( p_tab_id )

if len( l_tab_id ) = 0 or isnull( l_tab_id ) then
	return i_para_menu[1].window_id
end if

l_row_max	= upperbound( i_para_menu )

for l_count = 1 to l_row_max
	// タブIDを検索
	if i_para_menu[l_count].tab_id = l_tab_id then
		return i_para_menu[l_count].window_id
	end if
next

// 何も一致しなかったら
return ""

end function

on cv_input_menu.create
call super::create
end on

on cv_input_menu.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_menu"

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_menu_id

l_ret		= true
l_menu_id	= trim( of_get_input( ) )
i_para_menu	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

if len( l_menu_id ) > 0 then
	l_item	= "メニューID"	// 入力されるコードの名前を取得する
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_menu_get( l_menu_id, i_para_menu ) > 0 then
				get	= true
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。"
					l_ret	= false
				end if
			end if
		case 2
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_menu_check( l_menu_id ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if not fnc.of_chk_column_info( l_menu_id, chk_required, l_item, "m_menu", "menu_id", l_msg ) then
					l_ret	= false
				end if
			else
				l_msg	= "入力された" + l_item + "はマスタに存在しています。"
				l_ret	= false
			end if
		case else
			// 何もしない
	end choose
end if

// falseの処理
if not l_ret then
	sle_input.of_msg_error( l_msg )
	sle_input.setfocus()
end if

return l_ret
end event

event open_modal;call super::open_modal;
str_mdlpara_mmenu	l_mdl_menu

// モーダルを開く
l_mdl_menu	= mdl.of_open_modal( "wsm_menu", l_mdl_menu )

if upperbound( l_mdl_menu.ret ) > 0 then
	get											= true
	i_para_menu									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_menu[upperbound(i_para_menu) + 1]	= l_mdl_menu.ret[upperbound( l_mdl_menu.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_menu[1].menu_id )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true
end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_menu
end type

type st_meisyo from cv_input`st_meisyo within cv_input_menu
integer x = 1232
integer width = 180
end type

type cb_modal from cv_input`cb_modal within cv_input_menu
integer x = 1108
end type

type sle_input from cv_input`sle_input within cv_input_menu
integer width = 768
end type

type st_title from cv_input`st_title within cv_input_menu
string text = "メニュー"
end type

