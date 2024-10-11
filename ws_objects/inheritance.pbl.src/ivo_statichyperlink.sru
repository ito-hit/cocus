﻿$PBExportHeader$ivo_statichyperlink.sru
$PBExportComments$スタディックハイパーリンクコントロールの先祖オブジェクト
forward
global type ivo_statichyperlink from asv_statichyperlink
end type
end forward

global type ivo_statichyperlink from asv_statichyperlink
integer height = 75
integer textsize = -11
string facename = "Yu Gothic UI Semilight"
end type
global ivo_statichyperlink ivo_statichyperlink

type variables
public:
	// リンク(有効/無効)
	boolean	i_link
	
	// 有効時のカラー(初期値のまま)
	long	i_on_color

protected:
	// ファンクションキー初期有効/無効補完(初回constructorでセット)
	boolean	init_fnkey[], init_sfnkey[]

private:
	constant long	c_off_color			= rgb( 128, 128, 128 )	// 灰色
	constant long	c_disabled_color	= rgb( 192, 192, 192 )	// 銀

	boolean on_keyshift, on_keyctrl, on_keyctrlshift	// True:keydown状態 False:keyup状態

end variables

forward prototypes
public subroutine of_set_on ()
public subroutine of_set_off ()
private subroutine fnkey_setting (unsignedlong p_keyflags)
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
end prototypes

public subroutine of_set_on ();
if this.enabled then
	if not i_link then
		this.textcolor	= c_off_color
		this.pointer	= "icon!"
	else
		this.textcolor	= i_on_color
		this.pointer	= "hyperlink!"
	end if
else
	this.textcolor	= c_disabled_color
	this.pointer	= "icon!"
end if

end subroutine

public subroutine of_set_off ();
if this.enabled then
	this.textcolor	= c_off_color
else
	this.textcolor	= c_disabled_color
end if

this.pointer	= "icon!"

end subroutine

private subroutine fnkey_setting (unsignedlong p_keyflags);
string			l_function_name[]
boolean			l_function_enabled[]
unsignedlong	l_keyflags

if of_get_fnkey_visibled( ) then
	// フォーカス取得時にShiftキーが押されていればファンクション切替
	choose case p_keyflags
		case 0
			on_keyshift			= false
			l_function_name		= i_function_name
			l_function_enabled	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }
		case 1
			on_keyshift			= true
			l_function_name		= i_sfunction_name
			l_function_enabled	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }
	end choose
	
	// 無効化されている場合は下部のファンクションキーもすべて無効化する
	if not this.enabled then
		l_function_enabled	= { false, false, false, false, false, false, false, false, false, false, false, false }
	end if
	
	parent.dynamic of_fnkey_setting( thisobj, l_function_name, l_function_enabled, p_keyflags )
end if


end subroutine

public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled);
unsignedlong	l_keyflags

choose case p_keycode
	case keyf1!
		f1_key	= p_enabled
	case keyf2!
		f2_key	= p_enabled
	case keyf3!
		f3_key	= p_enabled
	case keyf4!
		f4_key	= p_enabled
	case keyf5!
		f5_key	= p_enabled
	case keyf6!
		f6_key	= p_enabled
	case keyf7!
		f7_key	= p_enabled
	case keyf8!
		f8_key	= p_enabled
	case keyf9!
		f9_key	= p_enabled
	case keyf10!
		f10_key	= p_enabled
	case keyf11!
		f11_key	= p_enabled
	case keyf12!
		f12_key	= p_enabled
	case else
end choose

// ファンクションキーセット
if keydown( keyshift! ) then
	l_keyflags			= 1
else
	l_keyflags			= 0
end if
	
fnkey_setting( l_keyflags )

end subroutine

on ivo_statichyperlink.create
call super::create
end on

on ivo_statichyperlink.destroy
call super::destroy
end on

event getfocus;call super::getfocus;
unsignedlong	l_keyflags

// ファンクションキーセット
if keydown( keyshift! ) then
	l_keyflags			= 1
else
	l_keyflags			= 0
end if

fnkey_setting( l_keyflags )



end event

event constructor;call super::constructor;object_type	= "statichyperlink"

// i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
// i_sfunction_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

// ファンクションキー有効／無効初期値退避
if upperbound( init_fnkey ) = 0 then
	init_fnkey	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }
	init_sfnkey	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }
else
	// 初期のファンクションキー状態をセット
	f1_key		= init_fnkey[1]
	f2_key		= init_fnkey[2]
	f3_key		= init_fnkey[3]
	f4_key		= init_fnkey[4]
	f5_key		= init_fnkey[5]
	f6_key		= init_fnkey[6]
	f7_key		= init_fnkey[7]
	f8_key		= init_fnkey[8]
	f9_key		= init_fnkey[9]
	f10_key		= init_fnkey[10]
	f11_key		= init_fnkey[11]
	f12_key		= init_fnkey[12]
	sf1_key		= init_sfnkey[1]
	sf2_key		= init_sfnkey[2]
	sf3_key		= init_sfnkey[3]
	sf4_key		= init_sfnkey[4]
	sf5_key		= init_sfnkey[5]
	sf6_key		= init_sfnkey[6]
	sf7_key		= init_sfnkey[7]
	sf8_key		= init_sfnkey[8]
	sf9_key		= init_sfnkey[9]
	sf10_key	= init_sfnkey[10]
	sf11_key	= init_sfnkey[11]
	sf12_key	= init_sfnkey[12]
end if

i_on_color	= this.textcolor

if this.enabled then
	if not i_link then
		this.textcolor	= c_off_color
		this.pointer	= "icon!"
	else
		this.textcolor	= i_on_color
		this.pointer	= "hyperlink!"
	end if
else
	this.textcolor	= c_disabled_color
	this.pointer	= "icon!"
end if

end event

event syskeydown;call super::syskeydown;
choose case keyflags
	case 1
		try
			// ファンクションキーセット
			if not on_keyshift then
				fnkey_setting( keyflags )
			end if
		catch( nullobjecterror ne )
		end try
end choose
end event

event syskeyup;call super::syskeyup;
boolean			l_shift
unsignedlong	l_keyflags

// upしたキーがShitキーか
if key = keyshift! then
	l_shift	= true
end if

// keyflagsでShiftキーが押されていないか
choose case keyflags
	case 1, 3
	case else
		l_shift	= true
end choose

if l_shift then
	try
		// ファンクションキーセット
		l_keyflags	= 0		// 解除なので0

		fnkey_setting( l_keyflags )
	catch( nullobjecterror ne )
	end try
end if
end event
