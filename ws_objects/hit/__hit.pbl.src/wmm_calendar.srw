$PBExportHeader$wmm_calendar.srw
$PBExportComments$カレンダー登録
forward
global type wmm_calendar from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_calendar
end type
type cb_zengetu from ivo_commandbutton within wmm_calendar
end type
type cb_jigetu from ivo_commandbutton within wmm_calendar
end type
type uo_cal from uo_calendar within wmm_calendar
end type
type cb_touroku from ivo_commandbutton within wmm_calendar
end type
type cb_kyo from ivo_commandbutton within wmm_calendar
end type
type st_nengetu from ivo_statictext within wmm_calendar
end type
type uo_kyoten from cv_input_kyoten within wmm_calendar
end type
end forward

global type wmm_calendar from iw_main_window
integer width = 6660
integer height = 3339
string title = "カレンダー登録"
boolean resizable = false
windowanimationstyle closeanimation = rightroll!
dw_list dw_list
cb_zengetu cb_zengetu
cb_jigetu cb_jigetu
uo_cal uo_cal
cb_touroku cb_touroku
cb_kyo cb_kyo
st_nengetu st_nengetu
uo_kyoten uo_kyoten
end type
global wmm_calendar wmm_calendar

type variables
long	i_nen,i_tuki,i_kyoten

str_calendar	i_cal



end variables

forward prototypes
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_init ()
end prototypes

public subroutine of_dsp_reset ();
uo_kyoten.event constructor( )
of_init()
end subroutine

public subroutine of_dsp_back ();
of_init( )
end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		uo_kyoten.enabled	= p_enabled
		cb_retrieve.enabled	= p_enabled

	case "dw_entry"
		dw_list.enabled		= p_enabled
		cb_zengetu.enabled	= p_enabled
		cb_kyo.enabled		= p_enabled
		cb_jigetu.enabled	= p_enabled
		cb_touroku.enabled	= p_enabled
		uo_cal.enabled		= p_enabled
end choose

end subroutine

public subroutine of_init ();
pointer	old_pointer

// システム日付を基に初期表示 //
select to_char(sysdate,'yyyy'),to_char(sysdate,'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

setnull( i_kyoten )

old_pointer = setpointer( HourGlass! )

of_loading( true )

dw_list.setredraw( false )
uo_cal.setredraw( false )

dw_list.event constructor( )
uo_cal.event constructor( )

uo_cal.of_retrieve( i_kyoten, i_nen, i_tuki )

st_nengetu.text	= string( i_nen ) + "年" + string( i_tuki, '00' ) + "月"

of_loading( false )
setpointer( old_pointer )

dw_list.setredraw( true )
uo_cal.setredraw( true )

of_dsp_edit( "callsection", true )
of_dsp_edit( "dw_entry", false )

// TODO：cv_inputにフォーカスが入らない
of_set_firstfocus( )

end subroutine

on wmm_calendar.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.cb_zengetu=create cb_zengetu
this.cb_jigetu=create cb_jigetu
this.uo_cal=create uo_cal
this.cb_touroku=create cb_touroku
this.cb_kyo=create cb_kyo
this.st_nengetu=create st_nengetu
this.uo_kyoten=create uo_kyoten
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_zengetu
this.Control[iCurrent+3]=this.cb_jigetu
this.Control[iCurrent+4]=this.uo_cal
this.Control[iCurrent+5]=this.cb_touroku
this.Control[iCurrent+6]=this.cb_kyo
this.Control[iCurrent+7]=this.st_nengetu
this.Control[iCurrent+8]=this.uo_kyoten
end on

on wmm_calendar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.cb_zengetu)
destroy(this.cb_jigetu)
destroy(this.uo_cal)
destroy(this.cb_touroku)
destroy(this.cb_kyo)
destroy(this.st_nengetu)
destroy(this.uo_kyoten)
end on

event resize;call super::resize;// データウインドウサイズにウインドウサイズを調整する
// get_dw_positionは上段部で一番下方にあるオブジェクトを特定してDWの位置を決める
//dw_list.y	= st_upper.y + st_upper.height + code.MGN_TATE
//// st_upper
//st_upper.x		= 0
//st_upper.y		= 4
//st_upper.height	= 140
//
//// st_title_upper
//st_title_upper.height	= 96
//st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
//st_title_upper.y		= st_upper.height / 2 - st_title_upper.height / 2 + st_upper.y
//
//// st_title
//st_title.height	= 82
//st_title.x		= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
//st_title.y		= st_title_upper.height / 2 - st_title.height / 2 + st_title_upper.y
//
//// uo_test_mode
//uo_test_mode.x	= st_title_upper.x + st_title_upper.width + 8
//uo_test_mode.y	= st_upper.height / 2 - uo_test_mode.height / 2 + st_upper.y
//
//// p_size_adjust
//p_size_adjust.y	= st_upper.height / 2 - p_size_adjust.height / 2 + st_upper.y
//p_size_adjust.x	= st_title_upper.x - p_size_adjust.width - 8
//
//// st_user_mei
//st_user_mei.x	= 24
//st_user_mei.y	= st_upper.height / 2 - st_user_mei.height / 2 + st_upper.y
//
//// st_date
//st_date.x		= st_upper.x + st_upper.width - st_date.width - 24
//st_date.y		= st_upper.height / 2 - st_date.height / 2 + st_upper.y
//
//// uo_signal
//uo_signal.x		= st_date.x - uo_signal.width  - 24
//uo_signal.y		= st_upper.height / 2 - uo_signal.height / 2 + st_upper.y
//
//
//dw_list.width	= dw_width
//dw_list.height	= dw_height

long	l_row_1_y
long	l_button_y


// 呼出部
// 1行目
l_row_1_y			= st_second_upper.y + code.MGN_UPPER_TATE	// 1行目「MGN_UPPER_TATE:21」
uo_kyoten.y	= l_row_1_y

// st_second_upper高さ
st_second_upper.height	= l_row_1_y + uo_kyoten.height + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO

l_button_y		= dw_list.y + dw_list.height - 89
cb_zengetu.y	= l_button_y
st_nengetu.y	= l_button_y
cb_kyo.y		= l_button_y
cb_jigetu.y		= l_button_y
cb_touroku.y	= l_button_y

// uo_cal
uo_cal.y		= dw_list.y + dw_list.height + code.MGN_TATE
uo_cal.width	= 4480
uo_cal.height	= 1845

uo_cal.x	= dw_list.x

this.width		= ( uo_cal.x * 2 ) + uo_cal.width + 70

// st_upper
//st_upper.width	= this.width - 60
//st_title_upper.width	= st_upper.width * 0.4
//st_title.width			= st_title_upper.width * 0.9

// window( ログイン画面は中身でWindowsサイズを決めるため再設定 )
//st_title_upper.width	= st_upper.width * 0.8
//st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
//st_title.width			= st_title_upper.width * 0.9
//st_title.x				= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
//
//dw_list.y	= st_upper.y + st_upper.height + 32
//uo_cal.y	= dw_list.y + dw_list.height + 32

// st_tail
//st_tail.width	= st_upper.width
//st_tail.y		= uo_cal.y + uo_cal.height - 100
//st_tail.y		= uo_cal.y + uo_cal.height

// cb_cancel
//cb_cancel.width		= 340
//cb_cancel.y			= st_tail.height / 2 - cb_cancel.height / 2 + st_tail.y
//cb_cancel.x			= st_tail.width - cb_cancel.width - code.MGN_YOKO

//this.height		= st_tail.y + st_tail.height + 130	// 100はおまじない
this.height		= uo_cal.y + uo_cal.height + 128 + 130	// 100はおまじない

//setredraw( true )

end event

event retrieve_event;call super::retrieve_event;
// プログラム(ここから) //
i_kyoten		= uo_kyoten.of_get_kyoten_code( )

dw_list.setredraw( false )
uo_cal.setredraw( false )

dw_list.retrieve( i_kyoten, i_nen, i_tuki )
uo_cal.of_retrieve( i_kyoten, i_nen, i_tuki )

st_nengetu.text	= string( i_nen ) + "年" + string( i_tuki, '00' ) + "月"

dw_list.setredraw( true )
uo_cal.setredraw( true )

of_dsp_edit( "callsection", false )
of_dsp_edit( "dw_entry", true )

end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event open;call super::open;
// 初期表示
of_init( )
end event

event key_f06;call super::key_f06;// 戻り
of_dsp_back()

return 0
end event

event retrieve_check;call super::retrieve_check;
// TODO：必須チェックの方法
if not uo_kyoten.event sle_input_check( ) then
	return -1
end if

if uo_kyoten.sle_input.text = "" then
	return -1
end if

return 0

end event

type uo_signal from iw_main_window`uo_signal within wmm_calendar
end type

type st_date from iw_main_window`st_date within wmm_calendar
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_calendar
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_calendar
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_calendar
end type

type st_title from iw_main_window`st_title within wmm_calendar
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_calendar
end type

type st_upper from iw_main_window`st_upper within wmm_calendar
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_calendar
integer height = 156
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_calendar
integer x = 4124
integer y = 164
integer taborder = 20
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

type dw_list from ivo_datawindow within wmm_calendar
integer x = 20
integer y = 334
integer width = 1008
integer height = 626
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_calendar_list"
boolean vscrollbar = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.reset()
this.settransobject(cocos)
end event

event buttonclicked;call super::buttonclicked;
choose case dwo.name
	case "b_edit"
		i_cal.answer		= False
		i_cal.kbn			= this.object.cal_kbn[row]
		i_cal.kbn_mei		= this.object.cal_mei[row]
		i_cal.kyoten		= uo_kyoten.of_get_kyoten_code( )
		i_cal.kyoten_mei_ryaku	= uo_kyoten.of_get_kyoten_mei_ryaku( )

		openwithparm( wse_calendar_edit, i_cal )

		i_cal	= message.powerobjectparm
		
		if not i_cal.answer then	// キャンセルが押下された //
			rollback using cocos;
			return -1
		else
			cb_retrieve.event clicked( )
		end if
end choose
end event

type cb_zengetu from ivo_commandbutton within wmm_calendar
integer x = 1368
integer y = 871
integer taborder = 40
boolean bringtotop = true
string text = "< 前月"
end type

event clicked;call super::clicked;string	l_date

l_date	= string( i_nen ) + string( i_tuki, '00' ) + "01"

select to_char(add_months(to_date(:l_date, 'yyyymmdd'),-1),'yyyy'),to_char(add_months(to_date(:l_date, 'yyyymmdd'),-1),'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
//event retrieve_event( 0, 0 )

cb_retrieve.event clicked( )
end event

type cb_jigetu from ivo_commandbutton within wmm_calendar
integer x = 3000
integer y = 871
integer taborder = 60
boolean bringtotop = true
string text = "次月 >"
end type

event clicked;call super::clicked;string	l_date

l_date	= string( i_nen ) + string( i_tuki, '00' ) + "01"

select to_char(add_months(to_date(:l_date, 'yyyymmdd'),1),'yyyy'),
		to_char(add_months(to_date(:l_date, 'yyyymmdd'),1),'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
//event retrieve_event( 0, 0 )

cb_retrieve.event clicked( )
end event

type uo_cal from uo_calendar within wmm_calendar
integer x = 24
integer y = 1017
integer taborder = 80
boolean bringtotop = true
end type

on uo_cal.destroy
call uo_calendar::destroy
end on

type cb_touroku from ivo_commandbutton within wmm_calendar
integer x = 3936
integer y = 871
integer width = 568
integer taborder = 70
boolean bringtotop = true
string text = "登録・削除"
end type

event clicked;call super::clicked;
setnull( i_cal.answer )
setnull( i_cal.kbn )
i_cal.kyoten			= uo_kyoten.of_get_kyoten_code( )
i_cal.kyoten_mei_ryaku	= uo_kyoten.of_get_kyoten_mei_ryaku( )


// カレンダー登録削除を開く
openwithparm( wse_calendar, i_cal )

// カレンダー登録削除からパラメーターを取得
i_cal	= message.powerobjectparm

// カレンダー登録削除でキャンセルが押下された場合
// TODO：ここでrollbackする？
if not i_cal.answer then
	rollback using cocos;
	return -1
else
	choose case i_cal.shori_kbn
		case "登録"
			// カレンダー編集を開く
			openwithparm( wse_calendar_edit, i_cal )
		
			// カレンダー編集からパラメーターを取得
			i_cal	= message.powerobjectparm
		
			// カレンダー編集でキャンセルが押下された場合
			// TODO：ここでrollbackする？
			if not i_cal.answer then
				rollback using cocos;
				return -1
			else
				cb_retrieve.event clicked( )
			end if

		case "削除"
			cb_retrieve.event clicked( )
	end choose

end if

end event

event constructor;call super::constructor;//if kengen_2 = 0 then
//	this.enabled = False
//end if

end event

type cb_kyo from ivo_commandbutton within wmm_calendar
integer x = 2620
integer y = 871
integer taborder = 50
boolean bringtotop = true
string text = "今日"
end type

event clicked;call super::clicked;//string	l_date
//
//l_date	= i_nen + i_tuki + "01"

select to_char(sysdate,'yyyy'),to_char(sysdate,'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
//event retrieve_event( 0, 0 )

cb_retrieve.event clicked( )
end event

type st_nengetu from ivo_statictext within wmm_calendar
integer x = 1748
integer y = 871
integer width = 832
integer height = 89
boolean bringtotop = true
integer textsize = -14
string text = "2011年11月"
alignment alignment = center!
boolean border = true
end type

type uo_kyoten from cv_input_kyoten within wmm_calendar
integer x = 32
integer y = 164
integer width = 2240
integer taborder = 10
boolean bringtotop = true
boolean chk_required = true
string title_text = "対象拠点"
long title_width = 328
long input_width = 128
long bikou_width = 0
end type

on uo_kyoten.destroy
call cv_input_kyoten::destroy
end on

