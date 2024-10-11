$PBExportHeader$w_jyutyu_nyuryoku.srw
$PBExportComments$受注入力モックメイン画面
forward
global type w_jyutyu_nyuryoku from iw_main_window
end type
type st_syori_kbn from ivo_statictext within w_jyutyu_nyuryoku
end type
type ddplb_syori_kbn from sv_ddplb_syori within w_jyutyu_nyuryoku
end type
type st_jyutyu_no from ivo_statictext within w_jyutyu_nyuryoku
end type
type sle_search_jyutyu_no from ivo_singlelineedit within w_jyutyu_nyuryoku
end type
type cb_jyutyu_no from ivo_commandbutton within w_jyutyu_nyuryoku
end type
type st_jyutyu_houhou from ivo_statictext within w_jyutyu_nyuryoku
end type
type sle_jyutyu_houhou from ivo_singlelineedit within w_jyutyu_nyuryoku
end type
type st_touroku_date from ivo_statictext within w_jyutyu_nyuryoku
end type
type st_kousin_date from ivo_statictext within w_jyutyu_nyuryoku
end type
type cb_prev from ivo_commandbutton within w_jyutyu_nyuryoku
end type
type cb_next from ivo_commandbutton within w_jyutyu_nyuryoku
end type
type tab_meisai from uo_jyutyu within w_jyutyu_nyuryoku
end type
type tab_meisai from uo_jyutyu within w_jyutyu_nyuryoku
end type
end forward

global type w_jyutyu_nyuryoku from iw_main_window
string title = "受注入力"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
st_jyutyu_no st_jyutyu_no
sle_search_jyutyu_no sle_search_jyutyu_no
cb_jyutyu_no cb_jyutyu_no
st_jyutyu_houhou st_jyutyu_houhou
sle_jyutyu_houhou sle_jyutyu_houhou
st_touroku_date st_touroku_date
st_kousin_date st_kousin_date
cb_prev cb_prev
cb_next cb_next
tab_meisai tab_meisai
end type
global w_jyutyu_nyuryoku w_jyutyu_nyuryoku

type variables
private integer	i_permission	// 0：全ユーザー、1：システム管理者
private	boolean	i_admin			// ユーザーの管理者権限保有

private string	i_syori_kbn
end variables

on w_jyutyu_nyuryoku.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_jyutyu_no=create st_jyutyu_no
this.sle_search_jyutyu_no=create sle_search_jyutyu_no
this.cb_jyutyu_no=create cb_jyutyu_no
this.st_jyutyu_houhou=create st_jyutyu_houhou
this.sle_jyutyu_houhou=create sle_jyutyu_houhou
this.st_touroku_date=create st_touroku_date
this.st_kousin_date=create st_kousin_date
this.cb_prev=create cb_prev
this.cb_next=create cb_next
this.tab_meisai=create tab_meisai
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.st_jyutyu_no
this.Control[iCurrent+4]=this.sle_search_jyutyu_no
this.Control[iCurrent+5]=this.cb_jyutyu_no
this.Control[iCurrent+6]=this.st_jyutyu_houhou
this.Control[iCurrent+7]=this.sle_jyutyu_houhou
this.Control[iCurrent+8]=this.st_touroku_date
this.Control[iCurrent+9]=this.st_kousin_date
this.Control[iCurrent+10]=this.cb_prev
this.Control[iCurrent+11]=this.cb_next
this.Control[iCurrent+12]=this.tab_meisai
end on

on w_jyutyu_nyuryoku.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.st_jyutyu_no)
destroy(this.sle_search_jyutyu_no)
destroy(this.cb_jyutyu_no)
destroy(this.st_jyutyu_houhou)
destroy(this.sle_jyutyu_houhou)
destroy(this.st_touroku_date)
destroy(this.st_kousin_date)
destroy(this.cb_prev)
destroy(this.cb_next)
destroy(this.tab_meisai)
end on

event open;call super::open;ddplb_syori_kbn.text			= ""
sle_search_jyutyu_no.enabled	= false
cb_jyutyu_no.enabled			= false

ddplb_syori_kbn.setfocus( )
end event

event openquery;call super::openquery;// システム管理者区分
constant integer	c_admin	= 1

i_admin	= kengen.of_check( c_admin )
end event

event retrieve_event;call super::retrieve_event;// 検索

if ddplb_syori_kbn.text = "登録" then
	
end if

choose case ddplb_syori_kbn.text
	case "登録"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()
		tab_meisai.tabpage_1.dw_jyutyu_meisai.insertrow(0)
		
	case "変更"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()
		tab_meisai.tabpage_1.dw_jyutyu_meisai.retrieve( )
		
	case "削除"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()
		tab_meisai.tabpage_1.dw_jyutyu_meisai.retrieve( )
		
	case "照会"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()
		tab_meisai.tabpage_1.dw_jyutyu_meisai.retrieve( )

	case "複写"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()
		
		
	case "加工から出荷"
		tab_meisai.tabpage_1.dw_jyutyu_meisai.reset()


	case else
end choose

end event

event resize;call super::resize;cb_retrieve.y		= 164
cb_retrieve.width	= 380
cb_retrieve.height	= 85
cb_retrieve.x		= this.width - cb_retrieve.width - 560

//st_second_upper.width	= st_upper.width
//st_second_upper.x		= st_upper.x
st_second_upper.height	= 135
//st_second_upper.y		= st_upper.y + st_upper.height
end event

type uo_signal from iw_main_window`uo_signal within w_jyutyu_nyuryoku
end type

type st_date from iw_main_window`st_date within w_jyutyu_nyuryoku
end type

type st_user_mei from iw_main_window`st_user_mei within w_jyutyu_nyuryoku
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_jyutyu_nyuryoku
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_jyutyu_nyuryoku
end type

type st_title from iw_main_window`st_title within w_jyutyu_nyuryoku
end type

type st_title_upper from iw_main_window`st_title_upper within w_jyutyu_nyuryoku
end type

type st_upper from iw_main_window`st_upper within w_jyutyu_nyuryoku
end type

type st_second_upper from iw_main_window`st_second_upper within w_jyutyu_nyuryoku
integer height = 149
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_jyutyu_nyuryoku
integer y = 164
integer height = 85
end type

event constructor;call super::constructor;this.enabled	= true
end event

type st_syori_kbn from ivo_statictext within w_jyutyu_nyuryoku
integer x = 96
integer y = 171
integer width = 252
boolean bringtotop = true
long backcolor = 553648127
string text = "処理区分"
alignment alignment = center!
end type

type ddplb_syori_kbn from sv_ddplb_syori within w_jyutyu_nyuryoku
integer x = 356
integer y = 167
integer width = 500
integer height = 565
integer taborder = 10
boolean bringtotop = true
boolean vscrollbar = true
string init_disp = "登録"
end type

event constructor;call super::constructor;long	l_cnt

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

l_cnt	= this.insertitem( "複写", upperbound( this.item ) + 1 )
this.insertitem( "加工から出荷", l_cnt + 1 )

setnull( i_syori_kbn )
end event

event selectionchanged;call super::selectionchanged;choose case this.text
	case "登録"
		sle_search_jyutyu_no.enabled	= false
		cb_jyutyu_no.enabled			= false
	case else
		sle_search_jyutyu_no.enabled	= true
		cb_jyutyu_no.enabled			= true
end choose
end event

type st_jyutyu_no from ivo_statictext within w_jyutyu_nyuryoku
integer x = 916
integer y = 171
integer width = 252
boolean bringtotop = true
long backcolor = 553648127
string text = "受注番号"
alignment alignment = center!
end type

type sle_search_jyutyu_no from ivo_singlelineedit within w_jyutyu_nyuryoku
integer x = 1172
integer y = 167
integer width = 352
integer taborder = 20
boolean bringtotop = true
string text = ""
end type

type cb_jyutyu_no from ivo_commandbutton within w_jyutyu_nyuryoku
integer x = 1528
integer y = 167
integer width = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "・・・"
end type

type st_jyutyu_houhou from ivo_statictext within w_jyutyu_nyuryoku
integer x = 1684
integer y = 171
integer width = 256
boolean bringtotop = true
long backcolor = 553648127
string text = "受注方法"
alignment alignment = center!
end type

type sle_jyutyu_houhou from ivo_singlelineedit within w_jyutyu_nyuryoku
integer x = 1948
integer y = 167
integer width = 132
integer taborder = 20
boolean bringtotop = true
long backcolor = 134217752
string text = ""
boolean displayonly = true
end type

type st_touroku_date from ivo_statictext within w_jyutyu_nyuryoku
integer x = 2216
integer y = 171
integer width = 776
boolean bringtotop = true
long backcolor = 553648127
string text = "登録日：2022/04/01 12:00:00"
alignment alignment = center!
end type

type st_kousin_date from ivo_statictext within w_jyutyu_nyuryoku
integer x = 3108
integer y = 171
integer width = 776
boolean bringtotop = true
long backcolor = 553648127
string text = "更新日：2022/04/01 12:00:00"
alignment alignment = center!
end type

type cb_prev from ivo_commandbutton within w_jyutyu_nyuryoku
integer x = 4584
integer y = 164
integer width = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "◀"
end type

type cb_next from ivo_commandbutton within w_jyutyu_nyuryoku
integer x = 4700
integer y = 164
integer width = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "▶"
end type

type tab_meisai from uo_jyutyu within w_jyutyu_nyuryoku
integer x = 28
integer y = 1209
integer width = 4988
integer height = 1611
integer taborder = 20
boolean bringtotop = true
end type

