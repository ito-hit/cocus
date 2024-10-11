$PBExportHeader$cv_hprogressbar_pct.sru
$PBExportComments$進捗表示付き水平プログレスバーコントロールの始祖オブジェクト
forward
global type cv_hprogressbar_pct from asv_userobject
end type
type st_percent from statictext within cv_hprogressbar_pct
end type
type hpb_bar from asv_hprogressbar within cv_hprogressbar_pct
end type
end forward

global type cv_hprogressbar_pct from asv_userobject
integer width = 1436
integer height = 78
st_percent st_percent
hpb_bar hpb_bar
end type
global cv_hprogressbar_pct cv_hprogressbar_pct

type variables
public:
	// プログレスバープロパティ
	int		i_min, i_max, i_now, i_step

end variables

forward prototypes
public function boolean of_get_key_enabled (keycode p_key)
public subroutine of_up (integer p_step)
public subroutine of_down (integer p_step)
public subroutine of_down ()
public subroutine of_up ()
public subroutine of_init (integer p_min, integer p_max, integer p_now, integer p_step)
protected subroutine rate ()
end prototypes

public function boolean of_get_key_enabled (keycode p_key);choose case p_key
	case KeyF1!
		return f1_key
	case KeyF2!
		return f2_key
	case KeyF3!
		return f3_key
	case KeyF4!
		return f4_key
	case KeyF5!
		return f5_key
	case KeyF6!
		return f6_key
	case KeyF7!
		return f7_key
	case KeyF8!
		return f8_key
	case KeyF9!
		return f9_key
	case KeyF10!
		return f10_key
	case KeyF11!
		return f11_key
	case KeyF12!
		return f12_key
	case KeyEnter!
		return enter_key
	case KeyLeftArrow!
		return left_key
	case KeyRightArrow!
		return right_key
	case KeyUpArrow!
		return up_key
	case KeyDownArrow!
		return down_key
	case KeyPageUp!
		return pgup_key
	case KeyPageDown!
		return pgdown_key
	case KeyEnd!
		return end_key
	case KeyHome!
		return home_key
	case KeyInsert!
		return ins_key
	case KeyDelete!
		return del_key
	case KeyPause!
		return pause_key
	case KeyBack!
		return bs_key
	case KeySpaceBar!
		return space_key
	case KeyEscape!
		return esc_key
end choose

return false
end function

public subroutine of_up (integer p_step);hpb_bar.of_up( p_step )
rate()
end subroutine

public subroutine of_down (integer p_step);hpb_bar.of_down( p_step )
rate()
end subroutine

public subroutine of_down ();of_down( i_step )
end subroutine

public subroutine of_up ();of_up( i_step )
end subroutine

public subroutine of_init (integer p_min, integer p_max, integer p_now, integer p_step);hpb_bar.i_min	= p_min
hpb_bar.i_max	= p_max
hpb_bar.i_now	= p_now
hpb_bar.i_step	= p_step

event constructor( )
end subroutine

protected subroutine rate ();if hpb_bar.position = 0 and hpb_bar.maxposition = 0 then
	return
end if

st_percent.text	= string( round( ( hpb_bar.position / hpb_bar.maxposition ) * 100, 0 ) ) + "%"
end subroutine

on cv_hprogressbar_pct.create
int iCurrent
call super::create
this.st_percent=create st_percent
this.hpb_bar=create hpb_bar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_percent
this.Control[iCurrent+2]=this.hpb_bar
end on

on cv_hprogressbar_pct.destroy
call super::destroy
destroy(this.st_percent)
destroy(this.hpb_bar)
end on

event constructor;// コンストラクタ //
object_type	= "hprogressbar_pct"

st_percent.x	= this.width / 2 - st_percent.width / 2

hpb_bar.i_min	= i_min
hpb_bar.i_max	= i_max
hpb_bar.i_step	= i_step
hpb_bar.i_now	= i_now

hpb_bar.event constructor( )

this.rate( )

end event

event destructor;call super::destructor;// デストラクタ //
end event

type st_percent from statictext within cv_hprogressbar_pct
integer x = 348
integer y = 4
integer width = 300
integer height = 53
integer textsize = -9
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI Semilight"
long textcolor = 33554432
long backcolor = 33554431
string text = "0%"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.backcolor=536870912

end event

type hpb_bar from asv_hprogressbar within cv_hprogressbar_pct
integer width = 1412
end type

event constructor;call super::constructor;hpb_bar.maxposition	= i_max
hpb_bar.minposition	= i_min
hpb_bar.setstep		= i_step
hpb_bar.position	= i_now
end event

