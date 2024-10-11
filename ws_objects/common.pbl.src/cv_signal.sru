$PBExportHeader$cv_signal.sru
$PBExportComments$「更新中」表示用カスタムオブジェクト
forward
global type cv_signal from ivo_userobject
end type
type st_signal from ivo_statictext within cv_signal
end type
end forward

global type cv_signal from ivo_userobject
integer width = 372
integer height = 96
boolean border = true
borderstyle borderstyle = stylelowered!
st_signal st_signal
end type
global cv_signal cv_signal

type variables
protected:
	string	i_signal

private:
	long	default_color
	long	on_color		= rgb( 255, 0, 0 )
	
	boolean	on_signal
	

end variables

forward prototypes
public subroutine of_on_signal (boolean p_enabled)
public function boolean of_get_status ()
end prototypes

public subroutine of_on_signal (boolean p_enabled);if p_enabled then
	this.backcolor		= on_color
	st_signal.backcolor	= on_color
else
	this.backcolor		= default_color
	st_signal.backcolor	= default_color
end if

on_signal	= p_enabled

end subroutine

public function boolean of_get_status ();return on_signal
end function

on cv_signal.create
int iCurrent
call super::create
this.st_signal=create st_signal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_signal
end on

on cv_signal.destroy
call super::destroy
destroy(this.st_signal)
end on

event constructor;call super::constructor;object_type	= "signal"

this.width	= 370
this.height	= 96

default_color	= this.backcolor


end event

type st_signal from ivo_statictext within cv_signal
integer x = 12
integer width = 344
integer height = 82
integer textsize = -13
integer weight = 700
long textcolor = 16777215
string text = "シグナル"
alignment alignment = center!
long bordercolor = 255
end type

event constructor;call super::constructor;this.text	= i_signal
end event

