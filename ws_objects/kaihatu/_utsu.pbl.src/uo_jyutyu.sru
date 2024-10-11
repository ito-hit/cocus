$PBExportHeader$uo_jyutyu.sru
$PBExportComments$受注入力 受注明細用ユーザーオブジェクト
forward
global type uo_jyutyu from ivo_tab
end type
type tabpage_1 from uo_jyutyu_meisai within uo_jyutyu
end type
type tabpage_1 from uo_jyutyu_meisai within uo_jyutyu
end type
type tabpage_2 from userobject within uo_jyutyu
end type
type tabpage_2 from userobject within uo_jyutyu
end type
end forward

global type uo_jyutyu from ivo_tab
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global uo_jyutyu uo_jyutyu

on uo_jyutyu.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on uo_jyutyu.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from uo_jyutyu_meisai within uo_jyutyu
integer x = 16
integer y = 114
integer width = 1984
integer height = 811
string text = "受注明細"
end type

type tabpage_2 from userobject within uo_jyutyu
integer x = 16
integer y = 114
integer width = 1984
integer height = 811
long backcolor = 67108864
string text = "発送方法"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

