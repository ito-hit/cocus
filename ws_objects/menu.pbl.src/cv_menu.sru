$PBExportHeader$cv_menu.sru
$PBExportComments$メニューボタンを生成するカスタムオブジェクト
forward
global type cv_menu from ivo_userobject
end type
type dw_menu from ivo_datawindow within cv_menu
end type
type lstr_button from structure within cv_menu
end type
end forward

type lstr_button from structure
	integer		button_no
	string		window_id
	string		window_name
	string		param
	integer		kengen_kbn
	integer		readonly_flg
	integer		enabled_flg
	integer		duplicate_flg
	string		bikou
end type

global type cv_menu from ivo_userobject
integer width = 3716
integer height = 1892
boolean f5_key = true
dw_menu dw_menu
end type
global cv_menu cv_menu

type variables
private:
	string	user_id,menu_id,tab_id

	constant string c_mymenu		= "マイメニュー"

	constant string	c_menu_object	= "d_menu"
	constant string	c_mymenu_object	= "d_mymenu"

end variables

forward prototypes
public subroutine of_reload ()
private subroutine menu_clicked (lstr_button p_para)
end prototypes

public subroutine of_reload ();dw_menu.event constructor( )

end subroutine

private subroutine menu_clicked (lstr_button p_para);//window			l_win
//string			l_win_name
string			l_window_id
str_para_window	l_win_para

string			l_param
integer			l_kengen_kbn
boolean			l_reaadonly_flg
boolean			l_enabled_flg
boolean			l_duplicate_flg
string			l_bikou

l_window_id		= p_para.window_id
l_param			= p_para.param
l_kengen_kbn	= p_para.kengen_kbn
l_bikou			= p_para.bikou

if p_para.readonly_flg <> 0 then
	l_reaadonly_flg	= true
else
	l_reaadonly_flg	= false
end if

if p_para.enabled_flg <> 0 then
	l_enabled_flg	= true
else
	l_enabled_flg	= false
end if

if p_para.duplicate_flg <> 0 then
	l_duplicate_flg	= true
else
	l_duplicate_flg	= false
end if

//l_win_name				= l_window_id
l_win_para.window_id	= l_window_id
l_win_para.param		= l_param
l_win_para.readonly_flg	= l_reaadonly_flg

winctl.of_open( l_window_id, l_win_para )

end subroutine

on cv_menu.create
int iCurrent
call super::create
this.dw_menu=create dw_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_menu
end on

on cv_menu.destroy
call super::destroy
destroy(this.dw_menu)
end on

event resize;call super::resize;constant integer	c_btn_height		= 117
constant integer	c_btn_height_space	= 15
constant integer	c_btn_row			= 17


// dw_menu.object.datawindow.detail.height
// dw_menu.object.datawindow.header.height

dw_menu.x		= 0
dw_menu.y		= 0
dw_menu.width	= this.width
dw_menu.height	= this.height

// dw内のボタン横配置を変更
constant dec{2}	c_button_ratio	= 0.8	// 画面横幅に対するボタンが占める割合（ボタン3つ分）
constant dec{2}	c_space_ratio	= 0.4	// 画面横幅に対するボタンを差し引いたスペースに対し、画面横の隙間とボタン同士の間隔との割合（ボタン同士側）

integer	l_b_width
integer	l_s_width, l_s_left, l_s_right

// ボタン１つあたりの横幅を計算
l_b_width	= round( ( dw_menu.width * c_button_ratio ) / 3, 0 )

// ボタン同士の間隔幅を計算
l_s_width	= round( ( ( dw_menu.width - ( l_b_width * 3 ) ) * c_space_ratio ) / 2, 0 )

// 上記を差し引いた残りの幅を両サイドへ（余り分は右間隔へ）
l_s_left	= truncate( ( dw_menu.width - ( l_b_width * 3 ) - ( l_s_width * 2 ) ) / 2, 0 )
l_s_right	= dw_menu.width - ( l_b_width * 3 ) - ( l_s_width * 2 ) - l_s_left

dw_menu.object.button_1.width	= l_b_width
dw_menu.object.button_2.width	= l_b_width
dw_menu.object.button_3.width	= l_b_width

dw_menu.object.button_1.x		= l_s_left
dw_menu.object.button_2.x		= long( dw_menu.object.button_1.x ) + long( dw_menu.object.button_1.width ) + l_s_width
dw_menu.object.button_3.x		= long( dw_menu.object.button_2.x ) + long( dw_menu.object.button_2.width ) + l_s_width

// ボタンの位置が決まれば、ボタン№の位置を合わせる
constant integer	c_no_width	= 80
constant integer	c_no_height	= 53

dw_menu.object.button_no_1.width	= c_no_width
dw_menu.object.button_no_2.width	= c_no_width
dw_menu.object.button_no_3.width	= c_no_width

dw_menu.object.button_no_1.height	= c_no_height
dw_menu.object.button_no_2.height	= c_no_height
dw_menu.object.button_no_3.height	= c_no_height

dw_menu.object.button_no_1.y		= long( dw_menu.object.button_1.y ) + long( dw_menu.object.button_1.height ) - long( dw_menu.object.button_no_1.height )
dw_menu.object.button_no_2.y		= long( dw_menu.object.button_no_1.y )
dw_menu.object.button_no_3.y		= long( dw_menu.object.button_no_1.y )

dw_menu.object.button_no_1.x		= long( dw_menu.object.button_1.x ) - long( dw_menu.object.button_no_1.width ) - 8
dw_menu.object.button_no_2.x		= long( dw_menu.object.button_2.x ) - long( dw_menu.object.button_no_2.width ) - 8
dw_menu.object.button_no_3.x		= long( dw_menu.object.button_3.x ) - long( dw_menu.object.button_no_3.width ) - 8

// 照会のみ表示
constant integer	c_ro_width	= 180
constant integer	c_ro_height	= 43

dw_menu.object.readonly_1.width		= c_ro_width
dw_menu.object.readonly_2.width		= c_ro_width
dw_menu.object.readonly_3.width		= c_ro_width

dw_menu.object.readonly_1.height	= c_ro_height
dw_menu.object.readonly_2.height	= c_ro_height
dw_menu.object.readonly_3.height	= c_ro_height

dw_menu.object.readonly_1.y			= long( dw_menu.object.button_1.y ) + 20
dw_menu.object.readonly_2.y			= long( dw_menu.object.readonly_1.y ) 
dw_menu.object.readonly_3.y			= long( dw_menu.object.readonly_1.y ) 

dw_menu.object.readonly_1.x			= long( dw_menu.object.button_1.x ) + long( dw_menu.object.button_1.width ) - long( dw_menu.object.readonly_1.width ) - 24
dw_menu.object.readonly_2.x			= long( dw_menu.object.button_2.x ) + long( dw_menu.object.button_2.width ) - long( dw_menu.object.readonly_2.width ) - 24
dw_menu.object.readonly_3.x			= long( dw_menu.object.button_3.x ) + long( dw_menu.object.button_3.width ) - long( dw_menu.object.readonly_3.width ) - 24


end event

event constructor;call super::constructor;object_type	= "menu"

str_para_menu	l_para

l_para	= message.powerobjectparm

user_id	= user.user_id
menu_id	= l_para.menu_id
tab_id	= l_para.tab_id

this.text	= tab_id
end event

type dw_menu from ivo_datawindow within cv_menu
integer width = 3668
integer height = 1294
integer taborder = 10
string dataobject = "d_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean f5_key = true
end type

event constructor;call super::constructor;if tab_id <> c_mymenu then
	this.dataobject	= c_menu_object
else
	this.dataobject	= c_mymenu_object
end if

this.settransobject( cocos )

dw_menu.retrieve( user_id, menu_id, tab_id )

// 強引なやり方だが、Retrieve後に空白行を追加し、メニューグループを分ける
dw_menu.insertrow( 6 )
dw_menu.insertrow( 12 )
end event

event buttonclicked;call super::buttonclicked;lstr_button	l_para

if row > 0 then
	choose case dwo.name
		case "button_1"
			l_para.button_no		= this.object.button_no_1[row]
			l_para.window_id		= this.object.window_id_1[row]
			l_para.window_name		= this.object.window_name_1[row]
			l_para.param			= this.object.param_1[row]
			l_para.kengen_kbn		= this.object.kengen_kbn_1[row]
			l_para.readonly_flg		= this.object.readonly_flg_1[row]
			l_para.enabled_flg		= this.object.enabled_flg_1[row]
			l_para.duplicate_flg	= this.object.duplicate_flg_1[row]
			l_para.bikou			= this.object.bikou_1[row]
		case "button_2"
			l_para.button_no		= this.object.button_no_2[row]
			l_para.window_id		= this.object.window_id_2[row]
			l_para.window_name		= this.object.window_name_2[row]
			l_para.param			= this.object.param_2[row]
			l_para.kengen_kbn		= this.object.kengen_kbn_2[row]
			l_para.readonly_flg		= this.object.readonly_flg_2[row]
			l_para.enabled_flg		= this.object.enabled_flg_2[row]
			l_para.duplicate_flg	= this.object.duplicate_flg_2[row]
			l_para.bikou			= this.object.bikou_2[row]
		case "button_3"
			l_para.button_no		= this.object.button_no_3[row]
			l_para.window_id		= this.object.window_id_3[row]
			l_para.window_name		= this.object.window_name_3[row]
			l_para.param			= this.object.param_3[row]
			l_para.kengen_kbn		= this.object.kengen_kbn_3[row]
			l_para.readonly_flg		= this.object.readonly_flg_3[row]
			l_para.readonly_flg		= this.object.readonly_flg_3[row]
			l_para.enabled_flg		= this.object.enabled_flg_3[row]
			l_para.duplicate_flg	= this.object.duplicate_flg_3[row]
			l_para.bikou			= this.object.bikou_3[row]
		case else
			return
	end choose
	
	// 2024.09.17 kin 権限があるwindowなら照会のみのフラグは強制的に外す
	if l_para.kengen_kbn <> 0 then
		l_para.readonly_flg	= 0
	end if
	
	// 構造体パラメーター渡したいのでupdate_eventではなく独自関数へ
	menu_clicked( l_para )
end if




end event

