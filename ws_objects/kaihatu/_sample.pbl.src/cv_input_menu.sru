$PBExportHeader$cv_input_menu.sru
$PBExportComments$m_menuの入力フォーム
forward
global type cv_input_menu from cv_input
end type
end forward

global type cv_input_menu from cv_input
integer width = 1824
integer height = 92
string i_title = "メニューID"
long i_input_width = 768
boolean i_modal_visible = true
end type
global cv_input_menu cv_input_menu

type variables

private:
	graphicobject	i_control[]	// 親Windowのコントロールをセットする
end variables

on cv_input_menu.create
call super::create
end on

on cv_input_menu.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_menu"

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納
end event

event sle_input_check;call super::sle_input_check;
string	l_menu_id

l_menu_id	= trim( of_get_input( ) )

if len( l_menu_id ) <> 0 then
	i_dpara.multiple	= false	// 単一結果で返ってきてほしい
	i_dpara				= dta.of_get_menu( l_menu_id )	// データ取得

	if not i_dpara.ret then
		msg.of_error( "入力されたメニューIDはマスタに存在しません。" )
		of_reset()
		return false
	end if
else
	of_reset()
	return false
end if

return true

end event

event open_modal;call super::open_modal;
// モーダルを開く
i_dpara	= mdl.of_open_menu()

if i_dpara.ret then
	of_set_input( i_dpara.ds.object.menu_id[1] )
end if

sle_input.event modified()	// 親Windowのinput_tabへ得意先コードのセット
sle_input.setfocus()

return i_dpara.ret

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
boolean righttoleft = false
end type

event modified;call super::modified;
// 親Windowのcontrolを確認し、object_typeに"input_tab"があれば、得意先コードをそのオブジェクトのインスタンス変数にセットする

long			l_row
string			l_typeof
graphicobject	l_obj

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_tab"があれば、メニューIDをセットする
	if l_typeof = "input_tab" then
		l_obj.dynamic of_set_menu_id( trim( parent.of_get_input( ) ) )
	end if
next
end event

type st_title from cv_input`st_title within cv_input_menu
string text = "メニューID"
end type

