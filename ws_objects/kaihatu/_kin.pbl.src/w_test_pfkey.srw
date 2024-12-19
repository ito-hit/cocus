$PBExportHeader$w_test_pfkey.srw
forward
global type w_test_pfkey from iw_main_window
end type
type sle_1 from ivo_singlelineedit within w_test_pfkey
end type
type sle_2 from ivo_singlelineedit within w_test_pfkey
end type
end forward

global type w_test_pfkey from iw_main_window
string title = "PFキーサンプル（親）"
boolean sf10_key = true
sle_1 sle_1
sle_2 sle_2
end type
global w_test_pfkey w_test_pfkey

on w_test_pfkey.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
end on

on w_test_pfkey.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_1)
destroy(this.sle_2)
end on

event key_f01;call super::key_f01;
choose case keyflags
	case 0
		msg.of_info( "F1キーが押された" )
	case 1	// Shift
		msg.of_info( "Shift+F1キーが押された" )
	case 2	// Ctrl
		msg.of_info( "Ctrl+F1キーが押された" )
	case 3	// Shift + Ctrl
		msg.of_info( "Shift+Ctrl+F1キーが押された" )
	case else
		msg.of_info( "F1キーが押された？" )
end choose

return 0
end event

type uo_signal from iw_main_window`uo_signal within w_test_pfkey
end type

type st_date from iw_main_window`st_date within w_test_pfkey
end type

type st_user_mei from iw_main_window`st_user_mei within w_test_pfkey
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_test_pfkey
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_test_pfkey
end type

type st_title from iw_main_window`st_title within w_test_pfkey
end type

type st_title_upper from iw_main_window`st_title_upper within w_test_pfkey
end type

type st_upper from iw_main_window`st_upper within w_test_pfkey
end type

type st_second_upper from iw_main_window`st_second_upper within w_test_pfkey
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_test_pfkey
boolean f1_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf10_key = true
end type

type sle_1 from ivo_singlelineedit within w_test_pfkey
integer x = 56
integer y = 174
integer taborder = 10
boolean bringtotop = true
boolean f1_key = true
boolean sf1_key = true
boolean sf9_key = true
boolean sf10_key = true
end type

type sle_2 from ivo_singlelineedit within w_test_pfkey
integer x = 376
integer y = 174
integer taborder = 10
boolean bringtotop = true
boolean f1_key = true
boolean f2_key = true
boolean f3_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean sf3_key = true
boolean sf9_key = true
boolean sf10_key = true
end type

event constructor;call super::constructor;
i_function_name		= { "F1", "MDW", "重複", "", "", "", "", "", "", "", "", "" }
i_sfunction_name	= { "SF1", "W", "単一", "", "", "", "", "", "", "", "", "" }

end event

event key_f01;call super::key_f01;
choose case keyflags
	case 0
		msg.of_info( "sle_2のF1キーが押された" )
	case 1	// Shift
		msg.of_info( "sle_2のShift+F1キーが押された" )
	case 2	// Ctrl
		msg.of_info( "sle_2のCtrl+F1キーが押された" )
	case 3	// Shift + Ctrl
		msg.of_info( "sle_2のShift+Ctrl+F1キーが押された" )
	case else
		msg.of_info( "sle_2のF1キーが押された？" )
end choose

return 0
end event

event key_f02;call super::key_f02;
choose case keyflags
	case 0	// F2キー
		msg.of_info( "sle_2:F2" )
		str_mdlpara_mmise	l_pmse
		
		l_pmse.in_tokui_code	= 7277

		 mdl.of_open_modal( "wsm_mise", l_pmse )

	case 1	// Shift+F2キー
		msg.of_info( "sle_2:Shift+F2" )
		str_para_window	l_pwin
		
		l_pwin.param	= "test"
		
		winctl.of_open( "w_test_pfkey_child1", l_pwin )		
	case else
end choose


return 0




end event

event key_f03;call super::key_f03;str_para_window	l_pwin

choose case keyflags
	case 0	// F3キー
		msg.of_info( "sle_2:F3" )
		
		l_pwin.param	= "para1=test&para2=test2"
		
		winctl.of_open( "w_test_pfkey_child1", l_pwin )		

	case 1	// Shift+F3キー
		msg.of_info( "sle_2:Shift+F3" )
		
		l_pwin.param	= "para1=test3&para2=test4"
		
		winctl.of_open( "w_test_pfkey_child2", l_pwin )		
	case else
end choose


return 0




end event

