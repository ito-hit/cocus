$PBExportHeader$w_kin_variable_columns.srw
$PBExportComments$金藤さんメニュー
forward
global type w_kin_variable_columns from iw_menu_window
end type
type dw_custom1 from ivo_datawindow within w_kin_variable_columns
end type
type cb_18 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_19 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_20 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_21 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_22 from ivo_commandbutton within w_kin_variable_columns
end type
type dw_normal from ivo_datawindow within w_kin_variable_columns
end type
type cb_1 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_2 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_3 from ivo_commandbutton within w_kin_variable_columns
end type
type cb_4 from ivo_commandbutton within w_kin_variable_columns
end type
type dw_custom2 from ivo_datawindow within w_kin_variable_columns
end type
type st_1 from ivo_statictext within w_kin_variable_columns
end type
type st_2 from ivo_statictext within w_kin_variable_columns
end type
type st_3 from ivo_statictext within w_kin_variable_columns
end type
end forward

global type w_kin_variable_columns from iw_menu_window
string title = "金藤さんメニュー"
boolean auto_generate_menu = false
dw_custom1 dw_custom1
cb_18 cb_18
cb_19 cb_19
cb_20 cb_20
cb_21 cb_21
cb_22 cb_22
dw_normal dw_normal
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_custom2 dw_custom2
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_kin_variable_columns w_kin_variable_columns

type variables

public:


protected:


private:
	integer	i_column_cnt
end variables

forward prototypes
public function boolean of_exists_syohin (long p_syohin_code)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
end prototypes

public function boolean of_exists_syohin (long p_syohin_code);long	l_cnt

select count(*)
  into :l_cnt
  from m_syohin
 where syohin_code	= :p_syohin_code
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true

end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);
select hin_ban,hin_mei,iro_mei
  into :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
   and size_code	= :p_size_code
using cocos;

if cocos.sqlcode <> 0 then
	return false
end if

return true
end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);long	l_cnt

select count(*),
       max( hin_ban ),max( hin_mei ),max( iro_mei )
  into :l_cnt,
       :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true


end function

on w_kin_variable_columns.create
int iCurrent
call super::create
this.dw_custom1=create dw_custom1
this.cb_18=create cb_18
this.cb_19=create cb_19
this.cb_20=create cb_20
this.cb_21=create cb_21
this.cb_22=create cb_22
this.dw_normal=create dw_normal
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_custom2=create dw_custom2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_custom1
this.Control[iCurrent+2]=this.cb_18
this.Control[iCurrent+3]=this.cb_19
this.Control[iCurrent+4]=this.cb_20
this.Control[iCurrent+5]=this.cb_21
this.Control[iCurrent+6]=this.cb_22
this.Control[iCurrent+7]=this.dw_normal
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.dw_custom2
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
end on

on w_kin_variable_columns.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_custom1)
destroy(this.cb_18)
destroy(this.cb_19)
destroy(this.cb_20)
destroy(this.cb_21)
destroy(this.cb_22)
destroy(this.dw_normal)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_custom2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event resize;call super::resize;
dw_normal.x			= 20
dw_normal.width		= newwidth - dw_normal.x * 2
dw_custom1.x		= 20
dw_custom2.x		= 20
dw_custom1.width	= dw_normal.width
dw_custom2.width	= dw_normal.width

cb_21.y			= uo_band_message.y + uo_band_message.height + 8
cb_22.y			= cb_21.y
st_1.y			= cb_21.y + cb_21.height / 2 - st_1.height / 2
dw_normal.y		= cb_21.y + cb_21.height + 4

st_1.x			= dw_normal.x
cb_21.x			= st_1.x + st_1.width + 8
cb_22.x			= cb_21.x + cb_21.width + 4

cb_1.y			= dw_normal.y + dw_normal.height + 16
cb_2.y			= cb_1.y
st_2.y			= cb_1.y + cb_1.height / 2 - st_2.height / 2
dw_custom1.y	= cb_1.y + cb_1.height + 4

st_2.x			= st_1.x
cb_1.x			= cb_21.x
cb_2.x			= cb_22.x

cb_3.y			= dw_custom1.y + dw_custom1.height + 16
cb_4.y			= cb_3.y
st_3.y			= cb_3.y + cb_3.height / 2 - st_3.height / 2
dw_custom2.y	= cb_3.y + cb_3.height + 4

st_3.x			= st_1.x
cb_3.x			= cb_21.x
cb_4.x			= cb_22.x

end event

type uo_signal from iw_menu_window`uo_signal within w_kin_variable_columns
end type

type st_date from iw_menu_window`st_date within w_kin_variable_columns
end type

type st_user_mei from iw_menu_window`st_user_mei within w_kin_variable_columns
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_kin_variable_columns
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_kin_variable_columns
end type

type st_title from iw_menu_window`st_title within w_kin_variable_columns
end type

type st_title_upper from iw_menu_window`st_title_upper within w_kin_variable_columns
end type

type st_upper from iw_menu_window`st_upper within w_kin_variable_columns
end type

type tab_menu from iw_menu_window`tab_menu within w_kin_variable_columns
boolean visible = false
integer x = 20
integer y = 149
integer width = 52
integer height = 50
boolean enabled = false
end type

type pb_exit from iw_menu_window`pb_exit within w_kin_variable_columns
integer x = 3664
integer y = 2919
end type

type pb_logoff from iw_menu_window`pb_logoff within w_kin_variable_columns
integer x = 2996
integer y = 2923
end type

type shl_notifi from iw_menu_window`shl_notifi within w_kin_variable_columns
end type

type uo_band_message from iw_menu_window`uo_band_message within w_kin_variable_columns
end type

type dw_custom1 from ivo_datawindow within w_kin_variable_columns
integer x = 20
integer y = 1308
integer width = 4220
integer height = 700
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_zaiko_base2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;this.settransobject( cocos )

end event

event retrieveend;call super::retrieveend;
integer	l_row
integer	l_size_iti

for l_row = 1 to 30
	l_size_iti	= this.getitemnumber( 1, "size_iti_" + string( l_row ) )
		
	if l_size_iti > 0 then
		this.modify( "zaiko_su_" + string( l_row ) + ".tag='" + this.getitemstring( 1, "size_code_" + string( l_row ) ) + "'" )
	end if
next
end event

type cb_18 from ivo_commandbutton within w_kin_variable_columns
integer x = 556
integer y = 146
integer width = 540
integer taborder = 40
boolean bringtotop = true
string text = "Excel保存(非表示)"
end type

event clicked;call super::clicked;
dw_custom1.of_saveas_excel( "nonvisual.xlsx" )
end event

type cb_19 from ivo_commandbutton within w_kin_variable_columns
integer x = 1104
integer y = 146
integer width = 540
integer taborder = 50
boolean bringtotop = true
string text = "Excel保存(可変)"
end type

event clicked;call super::clicked;
dw_custom2.of_saveas_excel( "variable.xlsx" )
end event

type cb_20 from ivo_commandbutton within w_kin_variable_columns
integer x = 8
integer y = 146
integer width = 540
integer taborder = 50
boolean bringtotop = true
string text = "Excel保存(通常)"
end type

event clicked;call super::clicked;
dw_normal.of_saveas_excel( "normal.xlsx" )
end event

type cb_21 from ivo_commandbutton within w_kin_variable_columns
integer x = 356
integer y = 370
integer width = 440
integer taborder = 50
boolean bringtotop = true
string text = "4490-6"
end type

event clicked;call super::clicked;
dw_normal.retrieve( 4490, 6 )
end event

type cb_22 from ivo_commandbutton within w_kin_variable_columns
integer x = 796
integer y = 370
integer width = 440
integer taborder = 60
boolean bringtotop = true
string text = "4493-6"
end type

event clicked;call super::clicked;
dw_normal.retrieve( 4493, 6 )
end event

type dw_normal from ivo_datawindow within w_kin_variable_columns
integer x = 20
integer y = 466
integer width = 4220
integer height = 700
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_zaiko_base2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;this.settransobject( cocos )


end event

event retrieveend;call super::retrieveend;
integer	l_row
integer	l_size_iti

for l_row = 1 to 30
	l_size_iti	= this.getitemnumber( 1, "size_iti_" + string( l_row ) )
		
	if l_size_iti > 0 then
		this.modify( "zaiko_su_" + string( l_row ) + ".tag='" + this.getitemstring( 1, "size_code_" + string( l_row ) ) + "'" )
	end if
next
end event

type cb_1 from ivo_commandbutton within w_kin_variable_columns
integer x = 516
integer y = 1195
integer width = 440
integer taborder = 60
boolean bringtotop = true
string text = "4490-6"
end type

event clicked;call super::clicked;
integer	l_row
integer	l_size_iti

dw_custom1.retrieve( 4490, 6 )

for l_row = 1 to 30
	l_size_iti	= dw_custom1.getitemnumber( 1, "size_iti_" + string( l_row ) )
	
	if l_size_iti = 0 then
		dw_custom1.modify( "zaiko_su_" + string( l_row ) + ".visible='0'" )
	end if
next
end event

type cb_2 from ivo_commandbutton within w_kin_variable_columns
integer x = 956
integer y = 1195
integer width = 440
integer taborder = 60
boolean bringtotop = true
string text = "4493-6"
end type

event clicked;call super::clicked;
integer	l_row
integer	l_size_iti

dw_custom1.retrieve( 4493, 6 )

for l_row = 1 to 30
	l_size_iti	= dw_custom1.getitemnumber( 1, "size_iti_" + string( l_row ) )
	
	if l_size_iti = 0 then
		dw_custom1.modify( "zaiko_su_" + string( l_row ) + ".visible='0'" )
	end if
next
end event

type cb_3 from ivo_commandbutton within w_kin_variable_columns
integer x = 268
integer y = 2012
integer width = 440
integer taborder = 70
boolean bringtotop = true
string text = "4490-6"
end type

event clicked;call super::clicked;
nv_variable_column	l_vc
string				l_finds[]
string				l_syntax,l_err
long				l_syohin_code,l_iro_ban
integer				l_column_cnt

l_syohin_code	= 4490
l_iro_ban		= 6

l_vc	= create nv_variable_column

l_finds	= { "size_iti_", "zaiko_su_", "sku_code_", "size_code_" }

l_vc.of_init( "d_zaiko_base2", l_finds )

l_syntax	= l_vc.of_get_custom_syntax( l_syohin_code, l_iro_ban, l_column_cnt )

i_column_cnt	= l_column_cnt

dw_custom2.dataobject	= ""
dw_custom2.create( l_syntax )
dw_custom2.settransobject( cocos )
dw_custom2.retrieve( l_syohin_code, l_iro_ban )

destroy nv_variable_column

end event

type cb_4 from ivo_commandbutton within w_kin_variable_columns
integer x = 708
integer y = 2012
integer width = 440
integer taborder = 70
boolean bringtotop = true
string text = "4493-6"
end type

event clicked;call super::clicked;
nv_variable_column	l_vc
string				l_finds[]
string				l_syntax,l_err
long				l_syohin_code,l_iro_ban
integer				l_column_cnt

l_syohin_code	= 4493
l_iro_ban		= 6

l_vc	= create nv_variable_column
l_finds	= { "size_iti_", "zaiko_su_", "sku_code_", "size_code_" }

l_vc.of_init( "d_zaiko_base2", l_finds )

l_syntax	= l_vc.of_get_custom_syntax( l_syohin_code, l_iro_ban, l_column_cnt )

i_column_cnt	= l_column_cnt

dw_custom2.dataobject	= ""
dw_custom2.create( l_syntax )
dw_custom2.settransobject( cocos )
dw_custom2.retrieve( l_syohin_code, l_iro_ban )

destroy nv_variable_column

end event

type dw_custom2 from ivo_datawindow within w_kin_variable_columns
integer x = 20
integer y = 2108
integer width = 4220
integer height = 700
integer taborder = 130
string dataobject = "d_zaiko_base2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;
integer	l_row
integer	l_size_iti

for l_row = 1 to i_column_cnt
	l_size_iti	= this.getitemnumber( 1, "size_iti_" + string( l_row ) )
		
	if l_size_iti > 0 then
		this.modify( "zaiko_su_" + string( l_row ) + ".tag='" + this.getitemstring( 1, "size_code_" + string( l_row ) ) + "'" )
	end if
next
end event

type st_1 from ivo_statictext within w_kin_variable_columns
integer x = 36
integer y = 380
boolean bringtotop = true
string text = "通常"
end type

type st_2 from ivo_statictext within w_kin_variable_columns
integer x = 48
integer y = 1191
boolean bringtotop = true
string text = "非表示"
end type

type st_3 from ivo_statictext within w_kin_variable_columns
integer x = 56
integer y = 2020
boolean bringtotop = true
string text = "可変"
end type

