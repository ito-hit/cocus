$PBExportHeader$w_test_pfkey_child2.srw
forward
global type w_test_pfkey_child2 from iw_main_window
end type
type sle_1 from ivo_singlelineedit within w_test_pfkey_child2
end type
type sle_2 from ivo_singlelineedit within w_test_pfkey_child2
end type
type dw_1 from ivo_datawindow within w_test_pfkey_child2
end type
end forward

global type w_test_pfkey_child2 from iw_main_window
string title = "PFキーサンプル（子）重複不可"
sle_1 sle_1
sle_2 sle_2
dw_1 dw_1
end type
global w_test_pfkey_child2 w_test_pfkey_child2

on w_test_pfkey_child2.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_test_pfkey_child2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.dw_1)
end on

event openquery;call super::openquery;
string	l_paras[],l_para[]

sle_1.text	= i_para

l_paras	= fnc.strg.of_split( i_para, "&" )

if upperbound( l_paras ) = 1 then
	sle_2.text	= fnc.strg.of_format( "パラメータは「{1}」です。", l_paras[1] )
else
	integer	l_idx, l_row
	string	l_pname, l_pvalue
	
	for l_idx = 1 to upperbound( l_paras )
		l_para	= fnc.strg.of_split( l_paras[l_idx], "=" )
		
		l_pname		= l_para[1]
		l_pvalue	= l_para[2]
		
		l_row		= dw_1.insertrow( 0 )
		
		dw_1.object.id[l_row]		= l_pname
		dw_1.object.value[l_row]	= l_pvalue
	next
	
end if

end event

type uo_signal from iw_main_window`uo_signal within w_test_pfkey_child2
end type

type st_date from iw_main_window`st_date within w_test_pfkey_child2
end type

type st_user_mei from iw_main_window`st_user_mei within w_test_pfkey_child2
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_test_pfkey_child2
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_test_pfkey_child2
end type

type st_title from iw_main_window`st_title within w_test_pfkey_child2
end type

type st_title_upper from iw_main_window`st_title_upper within w_test_pfkey_child2
end type

type st_upper from iw_main_window`st_upper within w_test_pfkey_child2
end type

type st_second_upper from iw_main_window`st_second_upper within w_test_pfkey_child2
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_test_pfkey_child2
end type

type sle_1 from ivo_singlelineedit within w_test_pfkey_child2
integer x = 60
integer y = 495
integer width = 1548
integer taborder = 20
boolean bringtotop = true
end type

type sle_2 from ivo_singlelineedit within w_test_pfkey_child2
integer x = 60
integer y = 590
integer width = 1548
integer taborder = 30
boolean bringtotop = true
end type

type dw_1 from ivo_datawindow within w_test_pfkey_child2
integer x = 64
integer y = 686
integer width = 1548
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_pfkey"
end type

