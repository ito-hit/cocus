$PBExportHeader$w_hit_menu.srw
$PBExportComments$テスト用メニュー
forward
global type w_hit_menu from iw_menu_window
end type
type cb_1 from ivo_commandbutton within w_hit_menu
end type
type cb_2 from ivo_commandbutton within w_hit_menu
end type
type cb_3 from ivo_commandbutton within w_hit_menu
end type
type cb_4 from ivo_commandbutton within w_hit_menu
end type
type cb_5 from ivo_commandbutton within w_hit_menu
end type
type cb_6 from ivo_commandbutton within w_hit_menu
end type
type cb_7 from ivo_commandbutton within w_hit_menu
end type
type cb_8 from ivo_commandbutton within w_hit_menu
end type
type cb_9 from ivo_commandbutton within w_hit_menu
end type
type cb_10 from ivo_commandbutton within w_hit_menu
end type
type cb_11 from ivo_commandbutton within w_hit_menu
end type
type cb_12 from ivo_commandbutton within w_hit_menu
end type
type cb_13 from ivo_commandbutton within w_hit_menu
end type
type cb_14 from ivo_commandbutton within w_hit_menu
end type
type cb_15 from ivo_commandbutton within w_hit_menu
end type
type cb_16 from ivo_commandbutton within w_hit_menu
end type
type cb_17 from ivo_commandbutton within w_hit_menu
end type
type cb_18 from ivo_commandbutton within w_hit_menu
end type
type cb_19 from ivo_commandbutton within w_hit_menu
end type
type cb_20 from ivo_commandbutton within w_hit_menu
end type
type cb_21 from ivo_commandbutton within w_hit_menu
end type
type cb_22 from ivo_commandbutton within w_hit_menu
end type
type cb_23 from ivo_commandbutton within w_hit_menu
end type
type cb_24 from ivo_commandbutton within w_hit_menu
end type
type cb_25 from ivo_commandbutton within w_hit_menu
end type
type cb_26 from ivo_commandbutton within w_hit_menu
end type
type cb_27 from ivo_commandbutton within w_hit_menu
end type
type cb_28 from ivo_commandbutton within w_hit_menu
end type
type cb_29 from ivo_commandbutton within w_hit_menu
end type
type cb_30 from ivo_commandbutton within w_hit_menu
end type
type cb_31 from ivo_commandbutton within w_hit_menu
end type
type cb_32 from ivo_commandbutton within w_hit_menu
end type
type cb_33 from ivo_commandbutton within w_hit_menu
end type
type cb_34 from ivo_commandbutton within w_hit_menu
end type
type cb_35 from ivo_commandbutton within w_hit_menu
end type
type cb_36 from ivo_commandbutton within w_hit_menu
end type
type cb_37 from ivo_commandbutton within w_hit_menu
end type
type cb_38 from ivo_commandbutton within w_hit_menu
end type
type cb_39 from ivo_commandbutton within w_hit_menu
end type
type cb_40 from ivo_commandbutton within w_hit_menu
end type
type cb_41 from ivo_commandbutton within w_hit_menu
end type
type cb_42 from ivo_commandbutton within w_hit_menu
end type
type cb_43 from ivo_commandbutton within w_hit_menu
end type
type cb_44 from ivo_commandbutton within w_hit_menu
end type
type cb_45 from ivo_commandbutton within w_hit_menu
end type
type cb_46 from ivo_commandbutton within w_hit_menu
end type
type cb_47 from ivo_commandbutton within w_hit_menu
end type
type cb_48 from ivo_commandbutton within w_hit_menu
end type
type cb_49 from ivo_commandbutton within w_hit_menu
end type
type cb_50 from ivo_commandbutton within w_hit_menu
end type
type cb_51 from ivo_commandbutton within w_hit_menu
end type
type cb_52 from ivo_commandbutton within w_hit_menu
end type
type cb_53 from ivo_commandbutton within w_hit_menu
end type
type cb_54 from ivo_commandbutton within w_hit_menu
end type
type cb_55 from ivo_commandbutton within w_hit_menu
end type
type cb_56 from ivo_commandbutton within w_hit_menu
end type
type cb_57 from ivo_commandbutton within w_hit_menu
end type
type cb_58 from ivo_commandbutton within w_hit_menu
end type
type cb_59 from ivo_commandbutton within w_hit_menu
end type
type cb_60 from ivo_commandbutton within w_hit_menu
end type
type cb_61 from ivo_commandbutton within w_hit_menu
end type
type cb_62 from ivo_commandbutton within w_hit_menu
end type
type cb_63 from ivo_commandbutton within w_hit_menu
end type
end forward

global type w_hit_menu from iw_menu_window
string title = "テストメニュー"
boolean auto_generate_menu = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
cb_15 cb_15
cb_16 cb_16
cb_17 cb_17
cb_18 cb_18
cb_19 cb_19
cb_20 cb_20
cb_21 cb_21
cb_22 cb_22
cb_23 cb_23
cb_24 cb_24
cb_25 cb_25
cb_26 cb_26
cb_27 cb_27
cb_28 cb_28
cb_29 cb_29
cb_30 cb_30
cb_31 cb_31
cb_32 cb_32
cb_33 cb_33
cb_34 cb_34
cb_35 cb_35
cb_36 cb_36
cb_37 cb_37
cb_38 cb_38
cb_39 cb_39
cb_40 cb_40
cb_41 cb_41
cb_42 cb_42
cb_43 cb_43
cb_44 cb_44
cb_45 cb_45
cb_46 cb_46
cb_47 cb_47
cb_48 cb_48
cb_49 cb_49
cb_50 cb_50
cb_51 cb_51
cb_52 cb_52
cb_53 cb_53
cb_54 cb_54
cb_55 cb_55
cb_56 cb_56
cb_57 cb_57
cb_58 cb_58
cb_59 cb_59
cb_60 cb_60
cb_61 cb_61
cb_62 cb_62
cb_63 cb_63
end type
global w_hit_menu w_hit_menu

on w_hit_menu.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_15=create cb_15
this.cb_16=create cb_16
this.cb_17=create cb_17
this.cb_18=create cb_18
this.cb_19=create cb_19
this.cb_20=create cb_20
this.cb_21=create cb_21
this.cb_22=create cb_22
this.cb_23=create cb_23
this.cb_24=create cb_24
this.cb_25=create cb_25
this.cb_26=create cb_26
this.cb_27=create cb_27
this.cb_28=create cb_28
this.cb_29=create cb_29
this.cb_30=create cb_30
this.cb_31=create cb_31
this.cb_32=create cb_32
this.cb_33=create cb_33
this.cb_34=create cb_34
this.cb_35=create cb_35
this.cb_36=create cb_36
this.cb_37=create cb_37
this.cb_38=create cb_38
this.cb_39=create cb_39
this.cb_40=create cb_40
this.cb_41=create cb_41
this.cb_42=create cb_42
this.cb_43=create cb_43
this.cb_44=create cb_44
this.cb_45=create cb_45
this.cb_46=create cb_46
this.cb_47=create cb_47
this.cb_48=create cb_48
this.cb_49=create cb_49
this.cb_50=create cb_50
this.cb_51=create cb_51
this.cb_52=create cb_52
this.cb_53=create cb_53
this.cb_54=create cb_54
this.cb_55=create cb_55
this.cb_56=create cb_56
this.cb_57=create cb_57
this.cb_58=create cb_58
this.cb_59=create cb_59
this.cb_60=create cb_60
this.cb_61=create cb_61
this.cb_62=create cb_62
this.cb_63=create cb_63
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_6
this.Control[iCurrent+7]=this.cb_7
this.Control[iCurrent+8]=this.cb_8
this.Control[iCurrent+9]=this.cb_9
this.Control[iCurrent+10]=this.cb_10
this.Control[iCurrent+11]=this.cb_11
this.Control[iCurrent+12]=this.cb_12
this.Control[iCurrent+13]=this.cb_13
this.Control[iCurrent+14]=this.cb_14
this.Control[iCurrent+15]=this.cb_15
this.Control[iCurrent+16]=this.cb_16
this.Control[iCurrent+17]=this.cb_17
this.Control[iCurrent+18]=this.cb_18
this.Control[iCurrent+19]=this.cb_19
this.Control[iCurrent+20]=this.cb_20
this.Control[iCurrent+21]=this.cb_21
this.Control[iCurrent+22]=this.cb_22
this.Control[iCurrent+23]=this.cb_23
this.Control[iCurrent+24]=this.cb_24
this.Control[iCurrent+25]=this.cb_25
this.Control[iCurrent+26]=this.cb_26
this.Control[iCurrent+27]=this.cb_27
this.Control[iCurrent+28]=this.cb_28
this.Control[iCurrent+29]=this.cb_29
this.Control[iCurrent+30]=this.cb_30
this.Control[iCurrent+31]=this.cb_31
this.Control[iCurrent+32]=this.cb_32
this.Control[iCurrent+33]=this.cb_33
this.Control[iCurrent+34]=this.cb_34
this.Control[iCurrent+35]=this.cb_35
this.Control[iCurrent+36]=this.cb_36
this.Control[iCurrent+37]=this.cb_37
this.Control[iCurrent+38]=this.cb_38
this.Control[iCurrent+39]=this.cb_39
this.Control[iCurrent+40]=this.cb_40
this.Control[iCurrent+41]=this.cb_41
this.Control[iCurrent+42]=this.cb_42
this.Control[iCurrent+43]=this.cb_43
this.Control[iCurrent+44]=this.cb_44
this.Control[iCurrent+45]=this.cb_45
this.Control[iCurrent+46]=this.cb_46
this.Control[iCurrent+47]=this.cb_47
this.Control[iCurrent+48]=this.cb_48
this.Control[iCurrent+49]=this.cb_49
this.Control[iCurrent+50]=this.cb_50
this.Control[iCurrent+51]=this.cb_51
this.Control[iCurrent+52]=this.cb_52
this.Control[iCurrent+53]=this.cb_53
this.Control[iCurrent+54]=this.cb_54
this.Control[iCurrent+55]=this.cb_55
this.Control[iCurrent+56]=this.cb_56
this.Control[iCurrent+57]=this.cb_57
this.Control[iCurrent+58]=this.cb_58
this.Control[iCurrent+59]=this.cb_59
this.Control[iCurrent+60]=this.cb_60
this.Control[iCurrent+61]=this.cb_61
this.Control[iCurrent+62]=this.cb_62
this.Control[iCurrent+63]=this.cb_63
end on

on w_hit_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_15)
destroy(this.cb_16)
destroy(this.cb_17)
destroy(this.cb_18)
destroy(this.cb_19)
destroy(this.cb_20)
destroy(this.cb_21)
destroy(this.cb_22)
destroy(this.cb_23)
destroy(this.cb_24)
destroy(this.cb_25)
destroy(this.cb_26)
destroy(this.cb_27)
destroy(this.cb_28)
destroy(this.cb_29)
destroy(this.cb_30)
destroy(this.cb_31)
destroy(this.cb_32)
destroy(this.cb_33)
destroy(this.cb_34)
destroy(this.cb_35)
destroy(this.cb_36)
destroy(this.cb_37)
destroy(this.cb_38)
destroy(this.cb_39)
destroy(this.cb_40)
destroy(this.cb_41)
destroy(this.cb_42)
destroy(this.cb_43)
destroy(this.cb_44)
destroy(this.cb_45)
destroy(this.cb_46)
destroy(this.cb_47)
destroy(this.cb_48)
destroy(this.cb_49)
destroy(this.cb_50)
destroy(this.cb_51)
destroy(this.cb_52)
destroy(this.cb_53)
destroy(this.cb_54)
destroy(this.cb_55)
destroy(this.cb_56)
destroy(this.cb_57)
destroy(this.cb_58)
destroy(this.cb_59)
destroy(this.cb_60)
destroy(this.cb_61)
destroy(this.cb_62)
destroy(this.cb_63)
end on

type uo_signal from iw_menu_window`uo_signal within w_hit_menu
end type

type st_date from iw_menu_window`st_date within w_hit_menu
end type

type st_user_mei from iw_menu_window`st_user_mei within w_hit_menu
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_hit_menu
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_hit_menu
end type

type st_title from iw_menu_window`st_title within w_hit_menu
end type

type st_title_upper from iw_menu_window`st_title_upper within w_hit_menu
end type

type st_upper from iw_menu_window`st_upper within w_hit_menu
end type

type tab_menu from iw_menu_window`tab_menu within w_hit_menu
boolean visible = false
integer x = 12
integer y = 146
integer width = 96
integer height = 78
end type

type pb_exit from iw_menu_window`pb_exit within w_hit_menu
integer x = 4240
integer y = 2112
integer taborder = 110
end type

type pb_logoff from iw_menu_window`pb_logoff within w_hit_menu
integer x = 3572
integer y = 2116
integer taborder = 100
end type

type shl_notifi from iw_menu_window`shl_notifi within w_hit_menu
end type

type uo_band_message from iw_menu_window`uo_band_message within w_hit_menu
end type

type cb_1 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 192
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "メニュー登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_menu" )
end event

type cb_2 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 288
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "マイメニュー登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_mymenu" )
end event

type cb_3 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 384
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "基本情報登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open_readonly( "wmm_kihon" )
end event

type cb_4 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 480
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "消費税率登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohizei" )
end event

type cb_5 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 576
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "拠点登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_kyoten" )
end event

type cb_6 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 672
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "拠点グループ登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_kyoten_group" )
end event

type cb_7 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 768
integer width = 700
integer taborder = 120
boolean bringtotop = true
string text = "営業担当者登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tanto" )
end event

type cb_8 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 864
integer width = 700
integer taborder = 80
boolean bringtotop = true
string text = "営業担当者所属登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tanto_syozoku" )
end event

type cb_9 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 960
integer width = 700
integer taborder = 90
boolean bringtotop = true
string text = "得意先登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tokui" )
end event

type cb_10 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1056
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "得意先担当者登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tokui_tanto" )
end event

type cb_11 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1152
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "得意先宛先登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tokui_atesaki" )
end event

type cb_12 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1248
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "取引停止設定"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_torihiki_teisi" )
end event

type cb_13 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1344
integer width = 700
integer taborder = 80
boolean bringtotop = true
string text = "取引停止仮解除設定"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_torihiki_karikaizyo" )
end event

type cb_14 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1440
integer width = 700
integer taborder = 90
boolean bringtotop = true
string text = "得意先担当者一斉変更"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_tokui_tanto" )
end event

type cb_15 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1536
integer width = 700
integer taborder = 100
boolean bringtotop = true
string text = "得意先月別目標設定"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_tokui_mokuhyo" )
end event

type cb_16 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1632
integer width = 700
integer taborder = 110
boolean bringtotop = true
string text = "店登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_mise" )
end event

type cb_17 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1728
integer width = 700
integer taborder = 120
boolean bringtotop = true
string text = "店一括変更"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_mise" )
end event

type cb_18 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1824
integer width = 700
integer taborder = 130
boolean bringtotop = true
string text = "店一括複写登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_mise_copy" )
end event

type cb_19 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 1920
integer width = 700
integer taborder = 140
boolean bringtotop = true
string text = "商品登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohin" )
end event

type cb_20 from ivo_commandbutton within w_hit_menu
integer x = 48
integer y = 2016
integer width = 700
integer taborder = 150
boolean bringtotop = true
string text = "商品登録（色別）"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohiniro" )
end event

type cb_21 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 192
integer width = 700
integer taborder = 160
boolean bringtotop = true
string text = "商品寸法登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohin_sunpo" )
end event

type cb_22 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 288
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "GTIN管理登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_gtin" )
end event

type cb_23 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 384
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "JAN登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_jan" )
end event

type cb_24 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 480
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "ITF登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_itf" )
end event

type cb_25 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 576
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "商品空きコード検索"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "ws_syohin_aki_code" )
end event

type cb_26 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 672
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "商品分類登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohin_bunrui" )
end event

type cb_27 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 768
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "ブランド登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_brand" )
end event

type cb_28 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 864
integer width = 700
integer taborder = 40
boolean bringtotop = true
string text = "商品グループ登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_syohin_group" )
end event

type cb_29 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 960
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "単価登録(単品)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tanka" )
end event

type cb_30 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1056
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "単価登録(一覧)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tanka_multi" )
end event

type cb_31 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1152
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "単価アップロード登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_tanka" )
end event

type cb_32 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1248
integer width = 700
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string text = "単価一括登録(1得意先全商品)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_tanka_tokui" )
end event

type cb_33 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1344
integer width = 700
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = shiftjis!
string text = "単価一括登録(1商品全得意先)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_tanka_syohin" )
end event

type cb_34 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1440
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "単価一括複写"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_tanka_copy" )
end event

type cb_35 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1536
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "原価売価登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_genka_baika" )
end event

type cb_36 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1632
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "原価売価登録(一覧)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_genka_baika_multi" )
end event

type cb_37 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1728
integer width = 700
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = shiftjis!
string text = "原価売価アップロード登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_genka_baika" )
end event

type cb_38 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1824
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "運送便登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_unso" )
end event

type cb_39 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 1920
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "運賃登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_untin" )
end event

type cb_40 from ivo_commandbutton within w_hit_menu
integer x = 832
integer y = 2016
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "運賃基準登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_untin_kijyun" )
end event

type cb_41 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 192
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "特定得意先商品登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_syohin_tokutei" )
end event

type cb_42 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 288
integer width = 704
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = shiftjis!
string text = "特定得意先商品登録(得意先別)"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wm_syohin_tokutei_tokui" )
end event

type cb_43 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 384
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "カレンダー登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_calendar" )
end event

type cb_44 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 480
integer width = 700
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string text = "カレンダー登録削除"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wse_calender" )
end event

type cb_45 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 576
integer width = 700
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string text = "カレンダー編集"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wse_calender_edit" )
end event

type cb_46 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 672
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "物件登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_bukken" )
end event

type cb_47 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 768
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "郵便番号登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_yubin" )
end event

type cb_48 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 864
integer width = 700
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = shiftjis!
string text = "郵便番号アップロード登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_yubin" )
end event

type cb_49 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 960
integer width = 700
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = shiftjis!
string text = "運送便着店情報アップロード登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wld_tyakuten" )
end event

type cb_50 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1056
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "帳票プリンター登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tyohyo_printer" )
end event

type cb_51 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1152
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "通知管理登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tuuti" )
end event

type cb_52 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1248
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "通知フィルター登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_tuuti_filter" )
end event

type cb_53 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1344
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "専伝管理登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_senden_kanri" )
end event

type cb_54 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1440
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "専伝帳票登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_senden_tyohyo" )
end event

type cb_55 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1536
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "商品一覧照会"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "ws_syohin" )
end event

type cb_56 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1632
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "店一覧照会"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "ws_mise" )
end event

type cb_57 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1728
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "得意先＆店検索"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "ws_tokui_mise" )
end event

type cb_58 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1824
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "荷送人登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_niokurinin" )
end event

type cb_59 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 1920
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "入力支援設定"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_support_jyutyu" )
end event

type cb_60 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 2016
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "流通加工登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_ryutu_kako" )
end event

type cb_61 from ivo_commandbutton within w_hit_menu
integer x = 2400
integer y = 192
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "勘定科目登録"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wmm_kanjyo_kamoku" )
end event

type cb_62 from ivo_commandbutton within w_hit_menu
integer x = 1616
integer y = 2112
integer width = 700
integer taborder = 70
boolean bringtotop = true
string text = "得意先一覧照会"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "ws_tokui" )
end event

type cb_63 from ivo_commandbutton within w_hit_menu
integer x = 2404
integer y = 299
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "受注番号検索"
boolean enter2tab = false
end type

event execution;call super::execution;
winctl.of_open( "wsm_jyutyu_number" )
end event

