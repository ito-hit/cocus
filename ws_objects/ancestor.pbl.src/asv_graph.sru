$PBExportHeader$asv_graph.sru
$PBExportComments$グラフコントロールの始祖オブジェクト
forward
global type asv_graph from graph
end type
end forward

global type asv_graph from graph
integer width = 880
integer height = 640
boolean border = true
grgraphtype graphtype = colgraph!
long textcolor = 33554432
integer spacing = 100
string title = "(なし)"
integer elevation = 20
integer rotation = -20
integer perspective = 2
integer depth = 100
grlegendtype legend = atbottom!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
grsorttype seriessort = ascending!
grsorttype categorysort = ascending!
event syskeydown pbm_keydown
event type long key_f01 ( keycode key,  unsignedlong keyflags )
event type long key_f02 ( keycode key,  unsignedlong keyflags )
event type long key_f03 ( keycode key,  unsignedlong keyflags )
event type long key_f04 ( keycode key,  unsignedlong keyflags )
event type long key_f05 ( keycode key,  unsignedlong keyflags )
event type long key_f06 ( keycode key,  unsignedlong keyflags )
event type long key_f07 ( keycode key,  unsignedlong keyflags )
event type long key_f08 ( keycode key,  unsignedlong keyflags )
event type long key_f09 ( keycode key,  unsignedlong keyflags )
event type long key_f10 ( keycode key,  unsignedlong keyflags )
event type long key_f11 ( keycode key,  unsignedlong keyflags )
event type long key_f12 ( keycode key,  unsignedlong keyflags )
event type long key_enter ( keycode key,  unsignedlong keyflags )
event type long key_left ( keycode key,  unsignedlong keyflags )
event type long key_right ( keycode key,  unsignedlong keyflags )
event type long key_up ( keycode key,  unsignedlong keyflags )
event type long key_down ( keycode key,  unsignedlong keyflags )
event type long key_pgup ( keycode key,  unsignedlong keyflags )
event type long key_pgdown ( keycode key,  unsignedlong keyflags )
event type long key_end ( keycode key,  unsignedlong keyflags )
event type long key_home ( keycode key,  unsignedlong keyflags )
event type long key_ins ( keycode key,  unsignedlong keyflags )
event type long key_del ( keycode key,  unsignedlong keyflags )
event type long key_pause ( keycode key,  unsignedlong keyflags )
event type long key_bs ( keycode key,  unsignedlong keyflags )
event type long key_space ( keycode key,  unsignedlong keyflags )
event type long key_esc ( keycode key,  unsignedlong keyflags )
event lbuttondown pbm_lbuttondown
event type long fnkeyevent ( keycode p_keycode,  integer p_control,  integer p_shift )
event syskeyup pbm_keyup
end type
global asv_graph asv_graph

type variables
public:
	string			object_type
	graphicobject	thisobj
	
	// ファンクションキー(有効/無効)
	boolean	f1_key,f2_key,f3_key,f4_key,f5_key,f6_key,f7_key,f8_key,f9_key,f10_key,f11_key,f12_key
	boolean	sf1_key,sf2_key,sf3_key,sf4_key,sf5_key,sf6_key,sf7_key,sf8_key,sf9_key,sf10_key,sf11_key,sf12_key
	
	// Enterキー(有効/無効)
	boolean	enter_key	= true
	
	// その他キー(有効/無効)
	boolean	left_key,right_key,up_key,down_key
	boolean	pgup_key,pgdown_key
	boolean	end_key,home_key,ins_key,del_key
	boolean	pause_key,bs_key,space_key,esc_key
	
	// Enterキー操作でタブ移動(有効/無効)
	boolean	enter2tab	= true
	
	// ファンクションキー名(通常/Shift)
	string	i_function_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }
	string	i_sfunction_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }



end variables

forward prototypes
public function boolean of_get_selfevent_status (keycode p_keycode)
public function string of_typeof ()
public function boolean of_get_fnkey_visibled ()
public function boolean of_get_key_enabled (keycode p_key, unsignedlong p_keyflags)
end prototypes

event syskeydown;// keyflags
// 1:Shift 2:Ctrl 3:Shift+Ctrl

if of_get_key_enabled( key, keyflags ) then
	choose case key
		case KeyEnter!
			long	l_ret

			try
				l_ret	= event key_enter( key, keyflags )

				// フォーカス移動のためTABキーをWindowsに送信
				if l_ret = 0 or isnull( l_ret ) then
					if enter2tab then
						send( handle( this ), 256, 9, long( 0, 0 ) )
					end if
				end if

				return l_ret
			catch ( nullobjecterror exp )
			end try
			//return event key_enter( key, keyflags )
		case KeyLeftArrow!
			return event key_left( key, keyflags )
		case KeyRightArrow!
			return event key_right( key, keyflags )
		case KeyUpArrow!
			return event key_up( key, keyflags )
		case KeyDownArrow!
			return event key_down( key, keyflags )
		case KeyPageUp!
			return event key_pgup( key, keyflags )
		case KeyPageDown!
			return event key_pgdown( key, keyflags )
		case KeyEnd!
			return event key_end( key, keyflags )
		case KeyHome!
			return event key_home( key, keyflags )
		case KeyInsert!
			return event key_ins( key, keyflags )
		case KeyDelete!
			return event key_del( key, keyflags )
		case KeyPause!
			return event key_pause( key, keyflags )
		case KeyBack!
			return event key_bs( key, keyflags )
		case KeySpaceBar!
			return event key_space( key, keyflags )
		case KeyEscape!
			return event key_esc( key, keyflags )
	
	// イベント拾えないのでコメント化
	//	case KeyCapsLock!
	//		return event key_caps( key, keyflags )
	//	case KeyTab!
	//		return event key_tab( key, keyflags )
	//	case KeyPrintScreen!
	//		return event key_prtsc( key, keyflags )
		case else
			return
	end choose
end if

end event

event type long  key_f01(keycode key, unsignedlong keyflags);// f1が押された時の処理 //
return 0
end event

event type long  key_f02(keycode key, unsignedlong keyflags);// f2が押された時の処理 //
return 0
end event

event type long  key_f03(keycode key, unsignedlong keyflags);// f3が押された時の処理 //
return 0
end event

event type long  key_f04(keycode key, unsignedlong keyflags);// f4が押された時の処理 //
return 0
end event

event type long  key_f05(keycode key, unsignedlong keyflags);// f5が押された時の処理 //
return 0
end event

event type long  key_f06(keycode key, unsignedlong keyflags);// f6が押された時の処理 //
return 0
end event

event type long  key_f07(keycode key, unsignedlong keyflags);// f7が押された時の処理 //
return 0
end event

event type long  key_f08(keycode key, unsignedlong keyflags);// f8が押された時の処理 //
return 0
end event

event type long  key_f09(keycode key, unsignedlong keyflags);// f9が押された時の処理 //
return 0
end event

event type long  key_f10(keycode key, unsignedlong keyflags);// f10が押された時の処理 //
return 0
end event

event type long  key_f11(keycode key, unsignedlong keyflags);// f11が押された時の処理 //
return 0
end event

event type long  key_f12(keycode key, unsignedlong keyflags);// f12が押された時の処理 //
return 0
end event

event type long  key_enter(keycode key, unsignedlong keyflags);// enterが押された時の処理 //
return 0
end event

event type long  key_left(keycode key, unsignedlong keyflags);// ←が押された時の処理 //
return 0
end event

event type long  key_right(keycode key, unsignedlong keyflags);// →が押された時の処理 //
return 0
end event

event type long  key_up(keycode key, unsignedlong keyflags);// ↑が押された時の処理 //
return 0
end event

event type long  key_down(keycode key, unsignedlong keyflags);// ↓が押された時の処理 //
return 0
end event

event type long  key_pgup(keycode key, unsignedlong keyflags);// pageupが押された時の処理 //
return 0
end event

event type long  key_pgdown(keycode key, unsignedlong keyflags);// pagedownが押された時の処理 //
return 0
end event

event type long key_end(keycode key, unsignedlong keyflags);// endが押された時の処理 //
return 0
end event

event type long  key_home(keycode key, unsignedlong keyflags);// homeが押された時の処理 //
return 0
end event

event type long  key_ins(keycode key, unsignedlong keyflags);// insertが押された時の処理 //
return 0
end event

event type long key_del(keycode key, unsignedlong keyflags);// deleteが押された時の処理 //
return 0
end event

event type long  key_pause(keycode key, unsignedlong keyflags);// pauseが押された時の処理 //
return 0
end event

event type long key_bs(keycode key, unsignedlong keyflags);// backspaceが押された時の処理 //
return 0
end event

event type long  key_space(keycode key, unsignedlong keyflags);// spaceが押された時の処理 //
return 0
end event

event type long  key_esc(keycode key, unsignedlong keyflags);// escが押された時の処理 //
return 0
end event

event type long fnkeyevent(keycode p_keycode, integer p_control, integer p_shift);integer	l_keyflags

if p_control = 1 then
	l_keyflags = l_keyflags + 2
end if

if p_shift = 1 then
	l_keyflags = l_keyflags + 1
end if

if of_get_key_enabled( p_keycode, l_keyflags ) then
	choose case p_keycode
		case KeyF1!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f01( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f01( p_keycode, l_keyflags )
			end if
		case KeyF2!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f02( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f02( p_keycode, l_keyflags )
			end if
		case KeyF3!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f03( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f03( p_keycode, l_keyflags )
			end if
		case KeyF4!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f04( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f04( p_keycode, l_keyflags )
			end if
		case KeyF5!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f05( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f05( p_keycode, l_keyflags )
			end if
		case KeyF6!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f06( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f06( p_keycode, l_keyflags )
			end if
		case KeyF7!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f07( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f07( p_keycode, l_keyflags )
			end if
		case KeyF8!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f08( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f08( p_keycode, l_keyflags )
			end if
		case KeyF9!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f09( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f09( p_keycode, l_keyflags )
			end if
		case KeyF10!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f10( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f10( p_keycode, l_keyflags )
			end if
		case KeyF11!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f11( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f11( p_keycode, l_keyflags )
			end if
		case KeyF12!
			if of_get_selfevent_status( p_keycode ) then
				return event key_f12( p_keycode, l_keyflags )
//			else
//				return parent.dynamic event key_f12( p_keycode, l_keyflags )
			end if
		case else
			return 0
	end choose

	return parent.dynamic event fnkeyevent( p_keycode, p_control, p_shift )
end if

return 0
end event

event syskeyup;
// keyflags
// 1:Shift 2:Ctrl 3:Shift+Ctrl
// keyupはCrrlとShiftの動作のみ検知する（keycodeは無視がベター）

return 0

end event

public function boolean of_get_selfevent_status (keycode p_keycode);integer	l_col

choose case p_keycode
	case KeyF1!
		l_col	= 1
	case KeyF2!
		l_col	= 2
	case KeyF3!
		l_col	= 3
	case KeyF4!
		l_col	= 4
	case KeyF5!
		l_col	= 5
	case KeyF6!
		l_col	= 6
	case KeyF7!
		l_col	= 7
	case KeyF8!
		l_col	= 8
	case KeyF9!
		l_col	= 9
	case KeyF10!
		l_col	= 10
	case KeyF11!
		l_col	= 11
	case KeyF12!
		l_col	= 12
	case else
		return false
end choose

if of_get_fnkey_visibled( ) then
	if len( i_function_name[l_col] ) > 0 then
		return true
	else
		return false
	end if
end if

return true

end function

public function string of_typeof ();return object_type
end function

public function boolean of_get_fnkey_visibled ();return parent.dynamic of_get_fnkey_visibled()

end function

public function boolean of_get_key_enabled (keycode p_key, unsignedlong p_keyflags);
// ファンクションキー
if p_keyflags = 0 then
	choose case p_key
		case KeyF1!
			return f1_key
		case KeyF2!
			return f2_key
		case KeyF3!
			return f3_key
		case KeyF4!
			return f4_key
		case KeyF5!
			return f5_key
		case KeyF6!
			return f6_key
		case KeyF7!
			return f7_key
		case KeyF8!
			return f8_key
		case KeyF9!
			return f9_key
		case KeyF10!
			return f10_key
		case KeyF11!
			return f11_key
		case KeyF12!
			return f12_key
	end choose
else
	choose case p_key
		case KeyF1!
			return sf1_key
		case KeyF2!
			return sf2_key
		case KeyF3!
			return sf3_key
		case KeyF4!
			return sf4_key
		case KeyF5!
			return sf5_key
		case KeyF6!
			return sf6_key
		case KeyF7!
			return sf7_key
		case KeyF8!
			return sf8_key
		case KeyF9!
			return sf9_key
		case KeyF10!
			return sf10_key
		case KeyF11!
			return sf11_key
		case KeyF12!
			return sf12_key
	end choose
end if

// その他のキー
choose case p_key
	case KeyEnter!
		return enter_key
	case KeyLeftArrow!
		return left_key
	case KeyRightArrow!
		return right_key
	case KeyUpArrow!
		return up_key
	case KeyDownArrow!
		return down_key
	case KeyPageUp!
		return pgup_key
	case KeyPageDown!
		return pgdown_key
	case KeyEnd!
		return end_key
	case KeyHome!
		return home_key
	case KeyInsert!
		return ins_key
	case KeyDelete!
		return del_key
	case KeyPause!
		return pause_key
	case KeyBack!
		return bs_key
	case KeySpaceBar!
		return space_key
	case KeyEscape!
		return esc_key
end choose

return false
end function

on asv_graph.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="MS UI Gothic"
TitleDispAttr.FontCharSet=ShiftJIS!
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="(なし)"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="MS UI Gothic"
Category.DispAttr.FontCharSet=ShiftJIS!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="MS UI Gothic"
Category.LabelDispAttr.FontCharSet=ShiftJIS!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="(なし)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="MS UI Gothic"
Values.DispAttr.FontCharSet=ShiftJIS!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="MS UI Gothic"
Values.LabelDispAttr.FontCharSet=ShiftJIS!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(なし)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="MS UI Gothic"
Series.DispAttr.FontCharSet=ShiftJIS!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="MS UI Gothic"
Series.LabelDispAttr.FontCharSet=ShiftJIS!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="MS UI Gothic"
LegendDispAttr.FontCharSet=ShiftJIS!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="MS UI Gothic"
PieDispAttr.FontCharSet=ShiftJIS!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on asv_graph.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

event constructor;// コンストラクタ //
end event

event destructor;// デストラクタ //
end event

event getfocus;thisobj	= getfocus()

end event

event dragdrop;// ドロップされたときのイベント
choose case source.classname()
	case "p_drag_size_adjust"
		w_size_adjust.event callback( "graph", this )
end choose
end event

