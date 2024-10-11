$PBExportHeader$juchu_no_serch.srw
forward
global type juchu_no_serch from iw_main_window
end type
type uo_tokui from cv_input_tokui within juchu_no_serch
end type
type st_touroku_date_from from ivo_statictext within juchu_no_serch
end type
type sle_touroku_date_from from ivo_singlelineedit within juchu_no_serch
end type
type st_touroku_date_to from ivo_statictext within juchu_no_serch
end type
type sle_touroku_date_to from ivo_singlelineedit within juchu_no_serch
end type
type cbx_kanryo_flg from ivo_checkbox within juchu_no_serch
end type
end forward

global type juchu_no_serch from iw_main_window
string title = "受注番号検索"
uo_tokui uo_tokui
st_touroku_date_from st_touroku_date_from
sle_touroku_date_from sle_touroku_date_from
st_touroku_date_to st_touroku_date_to
sle_touroku_date_to sle_touroku_date_to
cbx_kanryo_flg cbx_kanryo_flg
end type
global juchu_no_serch juchu_no_serch

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str

end variables
on juchu_no_serch.create
int iCurrent
call super::create
this.uo_tokui=create uo_tokui
this.st_touroku_date_from=create st_touroku_date_from
this.sle_touroku_date_from=create sle_touroku_date_from
this.st_touroku_date_to=create st_touroku_date_to
this.sle_touroku_date_to=create sle_touroku_date_to
this.cbx_kanryo_flg=create cbx_kanryo_flg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tokui
this.Control[iCurrent+2]=this.st_touroku_date_from
this.Control[iCurrent+3]=this.sle_touroku_date_from
this.Control[iCurrent+4]=this.st_touroku_date_to
this.Control[iCurrent+5]=this.sle_touroku_date_to
this.Control[iCurrent+6]=this.cbx_kanryo_flg
end on

on juchu_no_serch.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tokui)
destroy(this.st_touroku_date_from)
destroy(this.sle_touroku_date_from)
destroy(this.st_touroku_date_to)
destroy(this.sle_touroku_date_to)
destroy(this.cbx_kanryo_flg)
end on

event close;call super::close;destroy i_str
end event

type uo_signal from iw_main_window`uo_signal within juchu_no_serch
end type

type st_date from iw_main_window`st_date within juchu_no_serch
end type

type st_user_mei from iw_main_window`st_user_mei within juchu_no_serch
end type

type uo_test_mode from iw_main_window`uo_test_mode within juchu_no_serch
end type

type p_size_adjust from iw_main_window`p_size_adjust within juchu_no_serch
end type

type st_title from iw_main_window`st_title within juchu_no_serch
end type

type st_title_upper from iw_main_window`st_title_upper within juchu_no_serch
end type

type st_upper from iw_main_window`st_upper within juchu_no_serch
end type

type st_second_upper from iw_main_window`st_second_upper within juchu_no_serch
integer height = 551
end type

type cb_retrieve from iw_main_window`cb_retrieve within juchu_no_serch
integer y = 501
end type

type uo_tokui from cv_input_tokui within juchu_no_serch
integer x = 32
integer y = 167
integer width = 2464
integer taborder = 20
boolean bringtotop = true
boolean f4_key = false
long title_width = 248
long input_width = 248
long bikou_width = 168
boolean syusoku_hyoji = false
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

type st_touroku_date_from from ivo_statictext within juchu_no_serch
integer x = 104
integer y = 469
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "登録日"
alignment alignment = right!
end type

type sle_touroku_date_from from ivo_singlelineedit within juchu_no_serch
integer x = 376
integer y = 466
integer width = 408
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type st_touroku_date_to from ivo_statictext within juchu_no_serch
integer x = 800
integer y = 476
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type sle_touroku_date_to from ivo_singlelineedit within juchu_no_serch
integer x = 900
integer y = 466
integer width = 408
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = ""
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

event input_check;call super::input_check;string	l_date

if lena( trim( this.text ) ) > 0 then

	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if
	// 値セット
	this.text	= l_date

end if

return true
end event

type cbx_kanryo_flg from ivo_checkbox within juchu_no_serch
string tag = "完了済みを含む"
integer x = 1348
integer y = 466
integer width = 520
long backcolor = 553648127
string text = "完了済みを含む"
end type

event constructor;call super::constructor;this.checked	= false
end event

