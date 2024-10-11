$PBExportHeader$cv_test_mode.sru
$PBExportComments$「テスト」表示用カスタムオブジェクト
forward
global type cv_test_mode from ivo_userobject
end type
type st_1 from ivo_statictext within cv_test_mode
end type
type r_1 from rectangle within cv_test_mode
end type
end forward

global type cv_test_mode from ivo_userobject
integer width = 372
integer height = 96
event click_event ( )
st_1 st_1
r_1 r_1
end type
global cv_test_mode cv_test_mode

on cv_test_mode.create
int iCurrent
call super::create
this.st_1=create st_1
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.r_1
end on

on cv_test_mode.destroy
call super::destroy
destroy(this.st_1)
destroy(this.r_1)
end on

event constructor;call super::constructor;object_type	= "test_mode"

this.width	= 370
this.height	= 96
end event

type st_1 from ivo_statictext within cv_test_mode
integer x = 12
integer y = 7
integer width = 344
integer textsize = -13
long textcolor = 255
string text = "テストモード"
alignment alignment = center!
long bordercolor = 255
end type

event clicked;call super::clicked;parent.event click_event()
end event

type r_1 from rectangle within cv_test_mode
event clicked pbm_bnclicked
long linecolor = 255
integer linethickness = 5
long fillcolor = 67108864
integer width = 372
integer height = 96
end type

event clicked;parent.event click_event()
end event

