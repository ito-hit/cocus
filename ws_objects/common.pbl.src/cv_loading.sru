$PBExportHeader$cv_loading.sru
$PBExportComments$「処理中」表示カスタムオブジェクト
forward
global type cv_loading from ivo_userobject
end type
type st_msg from ivo_statictext within cv_loading
end type
type p_loading from uo_p_loading within cv_loading
end type
type uo_timer from inv_timing within cv_loading
end type
end forward

global type cv_loading from ivo_userobject
boolean visible = false
integer width = 580
integer height = 146
long backcolor = 16777215
st_msg st_msg
p_loading p_loading
uo_timer uo_timer
end type
global cv_loading cv_loading

type variables
private:
	string 	preload_file[]
	integer	cnt
end variables

forward prototypes
public subroutine of_show ()
public subroutine of_hide ()
private subroutine preload ()
end prototypes

public subroutine of_show ();uo_timer.of_start()
this.post show()
end subroutine

public subroutine of_hide ();this.post hide()
uo_timer.of_stop()
end subroutine

private subroutine preload ();preload_file[1]		= "image\preload\preloader0000.png"
preload_file[2]		= "image\preload\preloader0001.png"
preload_file[3]		= "image\preload\preloader0002.png"
preload_file[4]		= "image\preload\preloader0003.png"
preload_file[5]		= "image\preload\preloader0004.png"
preload_file[6]		= "image\preload\preloader0005.png"
preload_file[7]		= "image\preload\preloader0006.png"
preload_file[8]		= "image\preload\preloader0007.png"
preload_file[9]		= "image\preload\preloader0008.png"
preload_file[10]	= "image\preload\preloader0009.png"
preload_file[11]	= "image\preload\preloader0010.png"
preload_file[12]	= "image\preload\preloader0011.png"
preload_file[13]	= "image\preload\preloader0012.png"
preload_file[14]	= "image\preload\preloader0013.png"
preload_file[15]	= "image\preload\preloader0014.png"
preload_file[16]	= "image\preload\preloader0015.png"
preload_file[17]	= "image\preload\preloader0016.png"
preload_file[18]	= "image\preload\preloader0017.png"
preload_file[19]	= "image\preload\preloader0018.png"
preload_file[20]	= "image\preload\preloader0019.png"
preload_file[21]	= "image\preload\preloader0020.png"
preload_file[22]	= "image\preload\preloader0021.png"
preload_file[23]	= "image\preload\preloader0022.png"
preload_file[24]	= "image\preload\preloader0023.png"
preload_file[25]	= "image\preload\preloader0024.png"
preload_file[26]	= "image\preload\preloader0025.png"
preload_file[27]	= "image\preload\preloader0026.png"
preload_file[28]	= "image\preload\preloader0027.png"
preload_file[29]	= "image\preload\preloader0028.png"
preload_file[30]	= "image\preload\preloader0029.png"
preload_file[31]	= "image\preload\preloader0030.png"
preload_file[32]	= "image\preload\preloader0031.png"
preload_file[33]	= "image\preload\preloader0032.png"
preload_file[34]	= "image\preload\preloader0033.png"
preload_file[35]	= "image\preload\preloader0034.png"
preload_file[36]	= "image\preload\preloader0035.png"
preload_file[37]	= "image\preload\preloader0036.png"
preload_file[38]	= "image\preload\preloader0037.png"
preload_file[39]	= "image\preload\preloader0038.png"
preload_file[40]	= "image\preload\preloader0039.png"
preload_file[41]	= "image\preload\preloader0040.png"
preload_file[42]	= "image\preload\preloader0041.png"
preload_file[43]	= "image\preload\preloader0042.png"
preload_file[44]	= "image\preload\preloader0043.png"
preload_file[45]	= "image\preload\preloader0044.png"
preload_file[46]	= "image\preload\preloader0045.png"
preload_file[47]	= "image\preload\preloader0046.png"
preload_file[48]	= "image\preload\preloader0047.png"
preload_file[49]	= "image\preload\preloader0048.png"
preload_file[50]	= "image\preload\preloader0049.png"
preload_file[51]	= "image\preload\preloader0050.png"
preload_file[52]	= "image\preload\preloader0051.png"
preload_file[53]	= "image\preload\preloader0052.png"
preload_file[54]	= "image\preload\preloader0053.png"
preload_file[55]	= "image\preload\preloader0054.png"
preload_file[56]	= "image\preload\preloader0055.png"
preload_file[57]	= "image\preload\preloader0056.png"

end subroutine

event resize;call super::resize;this.height	= p_loading.height
this.width	= st_msg.x + st_msg.width + 10
end event

on cv_loading.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.p_loading=create p_loading
this.uo_timer=create uo_timer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.p_loading
end on

on cv_loading.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.p_loading)
destroy(this.uo_timer)
end on

event constructor;call super::constructor;object_type	= "loading"


// 画像読み込み
preload()
end event

type st_msg from ivo_statictext within cv_loading
integer x = 144
integer y = 18
integer width = 360
integer height = 82
integer textsize = -13
long backcolor = 16777215
string text = "処理中です"
alignment alignment = center!
end type

type p_loading from uo_p_loading within cv_loading
boolean originalsize = false
end type

type uo_timer from inv_timing within cv_loading descriptor "pb_nvo" = "true" 
long interval_msec = 10
end type

on uo_timer.create
call super::create
end on

on uo_timer.destroy
call super::destroy
end on

event constructor;call super::constructor;cnt	= 1
end event

event timer_event;call super::timer_event;yield()
parent.p_loading.picturename	= preload_file[cnt]
yield()

if upperbound( preload_file ) = cnt then
	cnt	= 1
else
	cnt	= cnt + 1
end if

yield()
end event

