$PBExportHeader$w_utsumi_test.srw
forward
global type w_utsumi_test from iw_main_window
end type
type dw_test from ivo_datawindow within w_utsumi_test
end type
type cb_kensaku from ivo_commandbutton within w_utsumi_test
end type
type cb_1 from ivo_commandbutton within w_utsumi_test
end type
type cb_mailtest from ivo_commandbutton within w_utsumi_test
end type
type uo_band_message from cv_band_message within w_utsumi_test
end type
type cb_2 from ivo_commandbutton within w_utsumi_test
end type
end forward

global type w_utsumi_test from iw_main_window
string title = "内海の実験用"
dw_test dw_test
cb_kensaku cb_kensaku
cb_1 cb_1
cb_mailtest cb_mailtest
uo_band_message uo_band_message
cb_2 cb_2
end type
global w_utsumi_test w_utsumi_test

on w_utsumi_test.create
int iCurrent
call super::create
this.dw_test=create dw_test
this.cb_kensaku=create cb_kensaku
this.cb_1=create cb_1
this.cb_mailtest=create cb_mailtest
this.uo_band_message=create uo_band_message
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_test
this.Control[iCurrent+2]=this.cb_kensaku
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_mailtest
this.Control[iCurrent+5]=this.uo_band_message
this.Control[iCurrent+6]=this.cb_2
end on

on w_utsumi_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_test)
destroy(this.cb_kensaku)
destroy(this.cb_1)
destroy(this.cb_mailtest)
destroy(this.uo_band_message)
destroy(this.cb_2)
end on

type uo_signal from iw_main_window`uo_signal within w_utsumi_test
end type

type st_date from iw_main_window`st_date within w_utsumi_test
end type

type st_user_mei from iw_main_window`st_user_mei within w_utsumi_test
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_utsumi_test
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_utsumi_test
end type

type st_title from iw_main_window`st_title within w_utsumi_test
end type

type st_title_upper from iw_main_window`st_title_upper within w_utsumi_test
end type

type st_upper from iw_main_window`st_upper within w_utsumi_test
end type

type st_second_upper from iw_main_window`st_second_upper within w_utsumi_test
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_utsumi_test
end type

type dw_test from ivo_datawindow within w_utsumi_test
integer x = 72
integer y = 565
integer width = 2364
integer height = 551
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_utsumi_test"
boolean f5_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean row_focus_ind = true
end type

event constructor;call super::constructor;this.settransobject( cocos )
end event

type cb_kensaku from ivo_commandbutton within w_utsumi_test
integer x = 2100
integer y = 466
integer taborder = 20
boolean bringtotop = true
string text = "検索"
end type

event clicked;call super::clicked;dw_test.retrieve()
end event

type cb_1 from ivo_commandbutton within w_utsumi_test
integer x = 248
integer y = 1212
integer taborder = 30
boolean bringtotop = true
string text = "関数テスト"
end type

event clicked;call super::clicked;//nv_file l_test
//string	l_array[]
//string	l_string
//
//l_test	= create nv_file
//
//l_test.of_get_files( "C:\work\up\", l_array )
//
//l_string	= ""
//
//destroy l_test

nv_xml l_xml
string l_node[]
string l_nodestring

l_xml	= create nv_xml

if not l_xml.of_load("C:\プログラムソース\新基幹システム\10.プログラム\PowerBuilder2019\database.xml") then
	messagebox("エラー", "XMLファイルのロード中にエラーが発生しました。")
	return -1
end if

//l_node	= l_xml.of_getnodearray("buturyu/test_mode/dbparm")
l_nodestring	= l_xml.of_getnodestring("buturyu/test_mode/dbparm")
//l_nodestring	= l_xml.of_getnodestring("buturyu/test_mode/dbparm", "、")

l_xml.of_save("c:\work\test.txt")

destroy l_xml
end event

type cb_mailtest from ivo_commandbutton within w_utsumi_test
integer x = 252
integer y = 1348
integer taborder = 40
boolean bringtotop = true
string text = "メールテスト"
end type

event clicked;call super::clicked;nv_smtp l_smtp

string l_id, l_pw
string l_to, l_subject, l_body

l_id	= "h-utsumi@co-cos.co.jp"
l_pw	= ""

l_to		= "hiroki.utsumi@jn-utsumi.com"
l_subject	= "これはテストメールです。"
l_body		= "body"


end event

type uo_band_message from cv_band_message within w_utsumi_test
integer x = 1268
integer y = 1223
integer taborder = 40
boolean bringtotop = true
end type

on uo_band_message.destroy
call cv_band_message::destroy
end on

type cb_2 from ivo_commandbutton within w_utsumi_test
integer x = 644
integer y = 1216
integer width = 548
integer taborder = 50
boolean bringtotop = true
string text = "バンドメッセージテスト"
end type

event clicked;call super::clicked;//uo_band_message.of_show_warning("そろそろシステム終了時刻となります。まだ作業中の場合は早めに作業を終えて終了してください。")

//uo_band_message.of_set_text("テストメッセージ")
//uo_band_message.of_hide( )
//uo_band_message.of_show( )

uo_band_message.of_show_success("やったね")
end event

