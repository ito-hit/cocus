$PBExportHeader$sv_st_meisyo.sru
$PBExportComments$処理区分のドロップダウンリストボックスオブジェクト（ドロップダウンピクチャリストボックスは見た目重視で）
forward
global type sv_st_meisyo from ivo_statictext
end type
end forward

global type sv_st_meisyo from ivo_statictext
integer height = 82
integer textsize = -12
long backcolor = 134217752
boolean border = true
long bordercolor = 10789024
end type
global sv_st_meisyo sv_st_meisyo

on sv_st_meisyo.create
call super::create
end on

on sv_st_meisyo.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "st_meisyo"


end event

