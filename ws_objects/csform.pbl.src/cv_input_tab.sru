$PBExportHeader$cv_input_tab.sru
$PBExportComments$m_menuのタブの入力フォーム
forward
global type cv_input_tab from cv_input
end type
end forward

global type cv_input_tab from cv_input
integer width = 1824
string title_text = "タブ"
long input_width = 768
boolean meisyo_visible = false
boolean bikou_visible = false
end type
global cv_input_tab cv_input_tab

type variables

public:
	str_mmenu		i_para_tab[]		// データの受け渡しをする構造体
	
protected:
	str_mmenu		i_para_reset[]		// i_para_tabを初期化する用の変数
	string			i_menu_id			// メニューの入力フォームからセットするメニューID
	
private:
	graphicobject	i_control[]			// 親Windowのコントロールをセットする
end variables

forward prototypes
public function string of_get_menu_id ()
public function string of_get_tab_id ()
public function string of_get_window_id ()
public function integer of_get_button_no ()
public function string of_get_param ()
public function integer of_get_siyo_kanou_flg ()
public function boolean of_set_menu_id ()
end prototypes

public function string of_get_menu_id ();
// 外部からこの関数を呼んで、メニューIDをreturnする関数

if upperbound( i_para_tab ) = 0 then
	return ""
end if

return i_para_tab[1].menu_id

end function

public function string of_get_tab_id ();
// 外部からこの関数を呼んで、タブIDをreturnする関数

string	l_tab_id

l_tab_id	= trim( of_get_input() )

// 入力値があるかどうか確認
if len( l_tab_id ) = 0 then
	return ""
end if

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_tab ) = 0 then
	return l_tab_id
end if

// 入力値をそのまま返す
return i_para_tab[1].tab_id
end function

public function string of_get_window_id ();
// 外部からこの関数を呼んで、ウィンドウIDをreturnする関数

if upperbound( i_para_tab ) = 0 then
	return ""
end if

return i_para_tab[1].window_id
end function

public function integer of_get_button_no ();
// 外部からこの関数を呼んで、ボタンNoをreturnする関数

if upperbound( i_para_tab ) = 0 then
	return 0
end if

return i_para_tab[1].button_no
end function

public function string of_get_param ();
// 外部からこの関数を呼んで、引数をreturnする関数

if upperbound( i_para_tab ) = 0 then
	return ""
end if

return i_para_tab[1].param
end function

public function integer of_get_siyo_kanou_flg ();
// 外部からこの関数を呼んで、使用可能フラグをreturnする関数

if upperbound( i_para_tab ) = 0 then
	return 0
end if

return i_para_tab[1].siyo_kanou_flg
end function

public function boolean of_set_menu_id ();
// cv_input_menuを探してメニューIDをインスタンス変数にセットする

boolean			l_ret
string			l_null
long			l_row
graphicobject	l_obj
string			l_typeof

l_ret	= false
setnull( l_null )

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_menu"があれば、メニューIDをセットする
	if l_typeof = "input_menu" then
		i_menu_id	= l_obj.dynamic of_get_menu_id()
		l_ret		= true
		exit
	end if
next

if not l_ret then
	i_menu_id	= l_null
end if

return l_ret
end function

on cv_input_tab.create
call super::create
end on

on cv_input_tab.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_tab"

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_tab_id

l_ret		= true
l_tab_id	= trim( of_get_input( ) )
i_para_tab	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

// 入力チェック
if len( l_tab_id ) > 0 and l_ret then
	l_item	= "タブID"
	
	// メニューIDをセットする
	if not of_set_menu_id() then
		// 今は特になし
	end if
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_menu_get( i_menu_id, l_tab_id, i_para_tab ) > 0 then
				get	= true
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。"
					l_ret	= false
				end if
			end if
		case 2
			// 重複チェック時はメニューIDの入力は必要
			if len( trim( i_menu_id ) ) = 0 then
				sle_input.of_msg_error( "メニューIDが入力されていません。" )
				sle_input.setfocus()
				return false
			end if
			
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_menu_check( i_menu_id, l_tab_id ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if not fnc.of_chk_column_info( l_tab_id, chk_required, l_item, "m_menu", "tab_id", l_msg ) then
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
str_mdlpara_mmenu	l_mdl_tab

// メニューIDをセットする
if not of_set_menu_id() then
	// 今は特になし
end if

// モーダルを開く
l_mdl_tab.in_menu_id	= i_menu_id	// nullかどうかはモーダルに任せる
l_mdl_tab				= mdl.of_open_modal( "wsm_tab", l_mdl_tab )

if upperbound( l_mdl_tab.ret ) > 0 then
	get										= true
	i_para_tab								= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_tab[upperbound(i_para_tab) + 1]	= l_mdl_tab.ret[upperbound( l_mdl_tab.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_tab[1].tab_id )
	
//	// i_menu_idがセットされていない場合があるのでここでセットしてやるか？
//	if isnull( i_menu_id ) or len( trim( i_menu_id ) ) <= 0 then
//		this.of_set_menu_id( i_para_tab[upperbound(i_para_tab)].menu_id )
//	end if
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true
end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_tab
end type

type st_meisyo from cv_input`st_meisyo within cv_input_tab
integer x = 1240
integer width = 152
end type

type cb_modal from cv_input`cb_modal within cv_input_tab
integer x = 1116
end type

type sle_input from cv_input`sle_input within cv_input_tab
integer width = 768
integer init_imemode = 0
end type

type st_title from cv_input`st_title within cv_input_tab
string text = "タブ"
end type

