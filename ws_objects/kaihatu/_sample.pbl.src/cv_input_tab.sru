$PBExportHeader$cv_input_tab.sru
$PBExportComments$m_menuのタブの入力フォーム
forward
global type cv_input_tab from cv_input
end type
end forward

global type cv_input_tab from cv_input
integer width = 1824
string i_title = "タブ"
long i_input_width = 768
boolean i_modal_visible = true
end type
global cv_input_tab cv_input_tab

type variables

private:
	string	i_menu_id	// cv_input_menuからセットされる
end variables

forward prototypes
public subroutine of_set_menu_id (string p_menu_id)
end prototypes

public subroutine of_set_menu_id (string p_menu_id);
i_menu_id	= trim( p_menu_id )
end subroutine

on cv_input_tab.create
call super::create
end on

on cv_input_tab.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_tab"
end event

event sle_input_check;call super::sle_input_check;
string	l_tab_id

// メニューIDが入力されているか確認する
if isnull( i_menu_id ) or i_menu_id = "" then
	msg.of_error( "メニューIDが入力されていません。" )
	of_reset()
	return false
end if

l_tab_id	= trim( of_get_input( ) )

if l_tab_id <> "" then
	i_dpara.multiple	= false	// 単一結果で返ってきてほしい
	i_dpara				= dta.of_get_tab( i_menu_id, l_tab_id )	// データ取得
	
	if not i_dpara.ret then
		msg.of_error( "入力されたタブIDはマスタに存在しません。" )
		of_reset()
		return false
	end if

	of_set_meisyo( i_dpara.ds.object.tab_id[1] )
else
	of_reset()
	return false
end if

return true
end event

event open_modal;call super::open_modal;
// メニューIDが入っているかはモーダル側へ任せる
i_dpara	= mdl.of_open_tab( i_menu_id )

if i_dpara.ret then
	of_set_input( string( i_dpara.ds.object.tab_id[1] ) )
end if

sle_input.setfocus()

return i_dpara.ret
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
boolean righttoleft = false
end type

type st_title from cv_input`st_title within cv_input_tab
string text = "タブ"
end type

