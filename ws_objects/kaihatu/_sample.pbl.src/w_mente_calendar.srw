$PBExportHeader$w_mente_calendar.srw
$PBExportComments$カレンダーマスタメンテナンス
forward
global type w_mente_calendar from iw_modal_window
end type
type cb_1 from ivo_commandbutton within w_mente_calendar
end type
type cb_2 from ivo_commandbutton within w_mente_calendar
end type
type uo_cal from uo_calendar within w_mente_calendar
end type
type cb_3 from ivo_commandbutton within w_mente_calendar
end type
type cb_4 from ivo_commandbutton within w_mente_calendar
end type
type st_nengetu from ivo_statictext within w_mente_calendar
end type
type st_1 from ivo_statictext within w_mente_calendar
end type
end forward

global type w_mente_calendar from iw_modal_window
integer width = 4764
integer height = 3406
string title = "カレンダーマスタメンテナンス"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
boolean immediate_retrieve = false
cb_1 cb_1
cb_2 cb_2
uo_cal uo_cal
cb_3 cb_3
cb_4 cb_4
st_nengetu st_nengetu
st_1 st_1
end type
global w_mente_calendar w_mente_calendar

type variables
string	i_nen,i_tuki

str_calendar	i_cal
end variables

on w_mente_calendar.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_cal=create uo_cal
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_nengetu=create st_nengetu
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.uo_cal
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.st_nengetu
this.Control[iCurrent+7]=this.st_1
end on

on w_mente_calendar.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_cal)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_nengetu)
destroy(this.st_1)
end on

event update_event;call super::update_event;// updatecheck_eventからの戻り値取得 //
if AncestorReturnValue = -1 then
// ロールバックの記述(サンプル) //
//  rollback using edidb;	
//	close(popup_process)
	return -1
end if

// プログラム(ここから) //
// プログラム(ここまで) //

// コミットの記述(サンプル) //
//commit using edidb;

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

end event

event retrieve_event;call super::retrieve_event;// retrievecheck_event先祖からの戻り値取得 //
if AncestorReturnValue = -1 then
// ロールバックの記述(サンプル) //
//  rollback using edidb;	
//	close(popup_process)
	return -1
end if

// プログラム(ここから) //

st_nengetu.text	= i_nen + "年" + i_tuki + "月"

uo_cal.setredraw( False)
uo_cal.of_retrieve( i_nen, i_tuki )
uo_cal.setredraw( True)

// プログラム(ここまで) //

// コミットの記述(サンプル) //
//commit using edidb;

// retrieve //
//dw_ichiran.retrieve()

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

end event

event open;call super::open;
// システム日付を基に初期表示 //
select to_char(sysdate,'yyyy'),to_char(sysdate,'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

event retrieve_event( 0,0 )

end event

event resize;// データウインドウサイズにウインドウサイズを調整する
// get_dw_positionは上段部で一番下方にあるオブジェクトを特定してDWの位置を決める
//dw_list.y	= st_upper.y + st_upper.height + code.MGN_TATE
// st_upper
st_upper.x		= 0
st_upper.y		= 4
st_upper.height	= 140

// st_title_upper
st_title_upper.height	= 96
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title_upper.y		= st_upper.height / 2 - st_title_upper.height / 2 + st_upper.y

// st_title
st_title.height	= 82
st_title.x		= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
st_title.y		= st_title_upper.height / 2 - st_title.height / 2 + st_title_upper.y

// uo_test_mode
uo_test_mode.x	= st_title_upper.x + st_title_upper.width + 8
uo_test_mode.y	= st_upper.height / 2 - uo_test_mode.height / 2 + st_upper.y

// p_size_adjust
p_size_adjust.y	= st_upper.height / 2 - p_size_adjust.height / 2 + st_upper.y
p_size_adjust.x	= st_title_upper.x - p_size_adjust.width - 8

// st_user_mei
st_user_mei.x	= 24
st_user_mei.y	= st_upper.height / 2 - st_user_mei.height / 2 + st_upper.y

// st_date
st_date.x		= st_upper.x + st_upper.width - st_date.width - 24
st_date.y		= st_upper.height / 2 - st_date.height / 2 + st_upper.y

// uo_signal
uo_signal.x		= st_date.x - uo_signal.width  - 24
uo_signal.y		= st_upper.height / 2 - uo_signal.height / 2 + st_upper.y


dw_list.width	= dw_width
dw_list.height	= dw_height

uo_cal.width	= 4480
uo_cal.height	= 1845

uo_cal.x	= dw_list.x

this.width		= ( uo_cal.x * 2 ) + uo_cal.width + 70

// st_upper
st_upper.width	= this.width - 60
st_title_upper.width	= st_upper.width * 0.4
st_title.width			= st_title_upper.width * 0.9

// window( ログイン画面は中身でWindowsサイズを決めるため再設定 )
st_title_upper.width	= st_upper.width * 0.8
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title.width			= st_title_upper.width * 0.9
st_title.x				= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x

dw_list.y	= st_upper.y + st_upper.height + 32
uo_cal.y	= dw_list.y + dw_list.height + 32

// st_tail
st_tail.width	= st_upper.width
//st_tail.y		= uo_cal.y + uo_cal.height - 100
st_tail.y		= uo_cal.y + uo_cal.height

// cb_cancel
cb_cancel.width		= 340
cb_cancel.y			= st_tail.height / 2 - cb_cancel.height / 2 + st_tail.y
cb_cancel.x			= st_tail.width - cb_cancel.width - code.MGN_YOKO

this.height		= st_tail.y + st_tail.height + 130	// 100はおまじない

//setredraw( true )

end event

type uo_signal from iw_modal_window`uo_signal within w_mente_calendar
end type

type st_date from iw_modal_window`st_date within w_mente_calendar
end type

type st_user_mei from iw_modal_window`st_user_mei within w_mente_calendar
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_mente_calendar
boolean visible = false
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_mente_calendar
boolean visible = false
end type

type st_title from iw_modal_window`st_title within w_mente_calendar
end type

type st_title_upper from iw_modal_window`st_title_upper within w_mente_calendar
end type

type st_upper from iw_modal_window`st_upper within w_mente_calendar
end type

type st_tail from iw_modal_window`st_tail within w_mente_calendar
integer y = 2752
integer taborder = 50
end type

type cb_ok from iw_modal_window`cb_ok within w_mente_calendar
boolean visible = false
integer y = 2773
integer taborder = 60
end type

type cb_cancel from iw_modal_window`cb_cancel within w_mente_calendar
integer y = 2773
integer taborder = 20
string text = "終 了"
end type

type dw_list from iw_modal_window`dw_list within w_mente_calendar
integer x = 32
integer y = 171
integer width = 1008
integer height = 626
integer taborder = 100
string dataobject = "d_mente_calendar_list"
boolean vscrollbar = true
boolean row_focus_ind = false
end type

event constructor;call super::constructor;this.settransobject( cocos )
this.retrieve()
end event

event rowfocuschanged;//

end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case "b_edit"
		i_cal.answer		= False
		i_cal.nen			= long( i_nen )
		i_cal.tuki			= long( i_tuki )
		i_cal.id			= this.object.id[row]
		i_cal.kbn			= this.object.cal_kbn[row]
		i_cal.holiday_flg	= fnc.of_cnv_int2bool( this.object.holiday_flg[row] )
		
		openwithparm( w_edit_calendar, i_cal )

		i_cal	= message.powerobjectparm
		
		if not i_cal.answer then	// キャンセルが押下された //
			rollback using cocos;
			return -1
		else
			this.retrieve( )
			uo_cal.of_retrieve( i_nen, i_tuki)
		end if
end choose
end event

event retrieveend;call super::retrieveend;integer i

//if kengen_2 = 0 then
//	for i = 1 to this.rowcount( )
//		this.object.edit_flg[i]	= 0
//	next
//end if
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_mente_calendar
boolean visible = false
end type

type cb_1 from ivo_commandbutton within w_mente_calendar
integer x = 1104
integer y = 708
integer taborder = 20
boolean bringtotop = true
string text = "< 前月"
end type

event clicked;call super::clicked;string	l_date

l_date	= i_nen + i_tuki + "01"

select to_char(add_months(to_date(:l_date, 'yyyymmdd'),-1),'yyyy'),to_char(add_months(to_date(:l_date, 'yyyymmdd'),-1),'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
event retrieve_event( 0, 0 )


end event

type cb_2 from ivo_commandbutton within w_mente_calendar
integer x = 3048
integer y = 708
integer taborder = 30
boolean bringtotop = true
string text = "次月 >"
end type

event clicked;call super::clicked;string	l_date

l_date	= i_nen + i_tuki + "01"

select to_char(add_months(to_date(:l_date, 'yyyymmdd'),1),'yyyy'),to_char(add_months(to_date(:l_date, 'yyyymmdd'),1),'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
event retrieve_event( 0, 0 )

end event

type uo_cal from uo_calendar within w_mente_calendar
integer x = 48
integer y = 839
integer taborder = 120
end type

on uo_cal.destroy
call uo_calendar::destroy
end on

type cb_3 from ivo_commandbutton within w_mente_calendar
integer x = 3960
integer y = 708
integer width = 568
integer taborder = 30
boolean bringtotop = true
string text = "新規カレンダー"
end type

event clicked;call super::clicked;setnull( i_cal.answer )
setnull( i_cal.id )
setnull( i_cal.kbn )
setnull( i_cal.holiday_flg )

openwithparm( w_sub_calendar_option, i_cal )

i_cal	= message.powerobjectparm

if not i_cal.answer then	// キャンセルが押下された //
	rollback using cocos;
	return -1
else
	i_cal.nen	= long( i_nen )
	i_cal.tuki	= long( i_tuki )
	openwithparm( w_edit_calendar, i_cal )

	i_cal	= message.powerobjectparm
		
	if not i_cal.answer then	// キャンセルが押下された //
		rollback using cocos;
		return -1
	else
		dw_list.retrieve( )
		uo_cal.of_retrieve( i_nen, i_tuki)
	end if
end if


end event

event constructor;call super::constructor;//if kengen_2 = 0 then
//	this.enabled = False
//end if

end event

type cb_4 from ivo_commandbutton within w_mente_calendar
integer x = 2560
integer y = 708
integer taborder = 30
boolean bringtotop = true
string text = "今日"
end type

event clicked;call super::clicked;string	l_date

l_date	= i_nen + i_tuki + "01"

select to_char(sysdate,'yyyy'),to_char(sysdate,'mm')
  into :i_nen,:i_tuki
  from dual
using cocos;

//of_set_calendar( )
event retrieve_event( 0, 0 )

end event

type st_nengetu from ivo_statictext within w_mente_calendar
integer x = 1648
integer y = 704
integer width = 832
integer height = 92
boolean bringtotop = true
integer textsize = -16
integer weight = 700
string text = "2011年11月"
alignment alignment = center!
end type

type st_1 from ivo_statictext within w_mente_calendar
integer x = 1568
integer y = 690
integer width = 1456
integer height = 128
string text = ""
boolean border = true
end type

