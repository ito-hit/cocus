$PBExportHeader$uo_day.sru
$PBExportComments$カレンダー登録（日付表示用UO）
forward
global type uo_day from userobject
end type
type st_text from ivo_statictext within uo_day
end type
type dw_event from ivo_datawindow within uo_day
end type
type st_day from ivo_statictext within uo_day
end type
end forward

global type uo_day from userobject
integer width = 640
integer height = 284
long backcolor = 67108864
string text = "未設定"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_text st_text
dw_event dw_event
st_day st_day
end type
global uo_day uo_day

type variables
integer	nen,tuki,hi,kyoten
string	youbi,holiday_bikou
boolean	holiday_enabled

long	default_color	// 3Dオブジェクト //
end variables

forward prototypes
public function boolean of_filter (string p_id, string p_kubun)
public subroutine of_init ()
public subroutine of_reset ()
public subroutine of_visible (string p_group, boolean p_visible)
public subroutine of_setredraw (boolean p_enabled)
public function string of_get_pg_id ()
public function boolean of_get_fnkey_visibled ()
end prototypes

public function boolean of_filter (string p_id, string p_kubun);return false

end function

public subroutine of_init ();string	l_tekiyo

if hi	<> 0 then
	// 当月 //
	st_day.text		= string( hi )

	this.backcolor		= st_text.backcolor	// とりあえず3Dオブジェクトカラー //
	of_visible( "ALL", True )
	
	st_day.text			= string( hi )
	st_text.text		= ""

	// 通常日 //
	choose case youbi
		case "土"	// 青 //
			st_day.textcolor					= rgb( 0, 0, 255 )
			st_text.textcolor					= rgb( 0, 0, 255 )

			st_day.backcolor					= rgb( 220,229,255 )
			st_text.backcolor					= rgb( 220,229,255 )
			dw_event.object.datawindow.color	= rgb( 220,229,255 )
			this.backcolor						= rgb( 220,229,255 )
		case "日"	// 赤 //
			st_day.textcolor					= rgb( 255, 0, 0 )
			st_text.textcolor					= rgb( 255, 0, 0 )

			st_day.backcolor					= rgb( 255,224,224 )
			st_text.backcolor					= rgb( 255,224,224 )
			dw_event.object.datawindow.color	= rgb( 255,224,224 )
			this.backcolor						= rgb( 255,224,224 )
		case else	// 黒 //
			st_day.textcolor					= rgb( 0, 0, 0 )
			st_text.textcolor					= rgb( 0, 0, 0 )
			
			st_day.backcolor					= default_color
			st_text.backcolor					= default_color
			dw_event.object.datawindow.color	= default_color
			this.backcolor						= default_color
	end choose

	// カレンダー1行目を設定
	select 	cal.tekiyo
	into	:l_tekiyo
	  from m_calendar cal
	 where cal.kyoten_code	= :kyoten
	   and cal.calendar_kbn	= 1
	   and cal.taisyo_flg	= 1
	   and cal.nen			= :nen
	   and cal.tuki			= :tuki
	   and cal.hi			= :hi
	using cocos;

	choose case cocos.sqlcode
		case 0
			// 休日 //
			st_day.textcolor	= rgb( 255, 0, 0 )
			st_text.textcolor	= rgb( 255, 0, 0 )
			st_text.text		= l_tekiyo
			
		case 100
			//msg.of_error( "対象レコードが見つかりません。" )
			//return false
		case else
			msg.of_error( fnc.strg.of_format( "休日取得処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			//of_add_db_log( "of_init", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	end choose


//	if holiday_enabled then
//		// 休日 //
//		st_day.textcolor	= rgb( 255, 0, 0 )
//		st_text.textcolor	= rgb( 255, 0, 0 )
//		st_text.text		= holiday_bikou
//		st_text.text		= l_tekiyo
//	end if

	// カレンダー2～5行目を設定
	dw_event.reset()
	if not isnull( kyoten ) then
		dw_event.retrieve( kyoten, nen, tuki, hi )
	end if
else
	// 当月以外 //
	this.backcolor		= rgb( 192, 192, 192 )
	of_visible( " ", False )
end if
end subroutine

public subroutine of_reset ();nen				= 0
tuki			= 0
hi				= 0
youbi			= ""
holiday_bikou	= ""
holiday_enabled	= False


end subroutine

public subroutine of_visible (string p_group, boolean p_visible);choose case p_group 
	case "ALL"
		this.visible	= p_visible
		of_visible(" ",p_visible)
	case else
		st_day.visible		= p_visible
		st_text.visible		= p_visible
		dw_event.visible	= p_visible
		
end choose
end subroutine

public subroutine of_setredraw (boolean p_enabled);this.setredraw( p_enabled )
st_day.setredraw( p_enabled )
st_text.setredraw( p_enabled )
dw_event.setredraw( p_enabled )
end subroutine

public function string of_get_pg_id ();return parent.dynamic of_get_pg_id()
end function

public function boolean of_get_fnkey_visibled ();return false
end function

on uo_day.create
this.st_text=create st_text
this.dw_event=create dw_event
this.st_day=create st_day
this.Control[]={this.st_text,&
this.dw_event,&
this.st_day}
end on

on uo_day.destroy
destroy(this.st_text)
destroy(this.dw_event)
destroy(this.st_day)
end on

event constructor;default_color	= this.backcolor

end event

type st_text from ivo_statictext within uo_day
integer x = 144
integer y = 14
integer width = 496
integer height = 85
boolean bringtotop = true
integer textsize = -10
string text = "99"
end type

type dw_event from ivo_datawindow within uo_day
integer y = 71
integer width = 640
integer height = 213
integer taborder = 10
boolean bringtotop = true
string dataobject = "dmm_calendar_day"
boolean vscrollbar = true
boolean border = false
end type

event rowfocuschanged;//
end event

event constructor;call super::constructor;this.settransobject( cocos )

end event

type st_day from ivo_statictext within uo_day
integer width = 128
integer height = 100
boolean bringtotop = true
integer textsize = -14
string text = "99"
alignment alignment = center!
end type

