$PBExportHeader$sv_ddplb_syori.sru
$PBExportComments$処理区分のドロップダウンリストボックスオブジェクト（ドロップダウンピクチャリストボックスは見た目重視で）
forward
global type sv_ddplb_syori from ivo_dropdownpicturelistbox
end type
end forward

global type sv_ddplb_syori from ivo_dropdownpicturelistbox
integer width = 244
integer height = 363
long backcolor = 16777215
boolean sorted = false
string item[] = {"登録","","",""}
integer itempictureindex[] = {1,0,0,0}
long picturemaskcolor = 16777215
end type
global sv_ddplb_syori sv_ddplb_syori

type variables
public:
	boolean	visible_touroku	= true
	boolean	visible_henkou	= true
	boolean	visible_sakujyo	= true
	boolean	visible_syokai	= true

protected:
	string	init_disp
end variables

forward prototypes
public function boolean of_available (string p_window)
public subroutine of_set_readonly ()
end prototypes

public function boolean of_available (string p_window);return true
end function

public subroutine of_set_readonly ();integer	l_row

// 初期化
this.reset()

if visible_syokai then
	this.insertitem( "照会", upperbound( this.item ) + 1 )
	this.selectitem( "照会", 1 )
else
	this.enabled	= false
end if


end subroutine

on sv_ddplb_syori.create
call super::create
end on

on sv_ddplb_syori.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type				= "ddplb_syori_kbn" 

integer	l_row

// 初期化
this.reset( )

if visible_touroku then
	this.insertitem( "登録", upperbound( this.item ) + 1 )
end if

if visible_henkou then
	this.insertitem( "変更", upperbound( this.item ) + 1 )
end if

if visible_sakujyo then
	this.insertitem( "削除", upperbound( this.item ) + 1 )
end if
	
if visible_syokai then
	this.insertitem( "照会", upperbound( this.item ) + 1 )
end if
	
if len( init_disp ) <> 0 then
	i_idx	= this.selectitem( init_disp, 1 )
end if

end event

