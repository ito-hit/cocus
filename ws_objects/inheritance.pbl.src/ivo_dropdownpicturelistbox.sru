$PBExportHeader$ivo_dropdownpicturelistbox.sru
$PBExportComments$ドロップダウンピクチャリストボックスコントロールの先祖オブジェクト
forward
global type ivo_dropdownpicturelistbox from asv_dropdownpicturelistbox
end type
end forward

global type ivo_dropdownpicturelistbox from asv_dropdownpicturelistbox
integer textsize = -12
fontcharset fontcharset = defaultcharset!
string facename = "Yu Gothic UI Semilight"
end type
global ivo_dropdownpicturelistbox ivo_dropdownpicturelistbox

type variables
public:
	// フォーカス取得時に入力文字の選択(有効/無効)
	boolean	selecttext	= true

protected:
	integer	i_idx

	// ファンクションキー初期有効/無効補完(初回constructorでセット)
	boolean	init_fnkey[], init_sfnkey[]

	// 無効／編集不可などの場合の背景色
	long	input_ena_backcolor, input_dis_backcolor

private:
	boolean on_keyshift, on_keyctrl, on_keyctrlshift	// True:keydown状態 False:keyup状態

end variables

forward prototypes
private subroutine fnkey_setting (unsignedlong p_keyflags)
public subroutine of_msg_error (string p_text)
private function boolean check_digits (boolean p_msg)
private function boolean check_requied (boolean p_msg)
private function boolean check_type (boolean p_msg)
public function boolean of_isna ()
public function boolean of_check ()
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
end prototypes

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

public subroutine of_msg_error (string p_text);
long	l_ddpl_textcolor
long	l_ddpl_backcolor

l_ddpl_backcolor	= this.backcolor
l_ddpl_textcolor	= this.textcolor

this.backcolor	= rgb( 248, 215, 218 )
this.textcolor	= rgb( 255, 0, 0 )

msg.of_error( p_text )

this.backcolor	= l_ddpl_backcolor
this.textcolor	= l_ddpl_textcolor

this.setfocus( )

end subroutine

private function boolean check_digits (boolean p_msg);
// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

if len( this.text ) > i_limit then
	if p_msg then
		of_msg_error( this, fnc.strg.of_format( "入力可能な範囲を超えています。（入力：{1}文字／最大：{2}文字）", string( len(this.text ) ), string( i_limit ) ) )
	end if

	return false
end if

return true

end function

private function boolean check_requied (boolean p_msg);
if len( this.text ) = 0 or isnull( this.text ) then
	if p_msg then
		of_msg_error( this, this.tag + "は必須入力です。" )
	end if


	return false
end if

return true

end function

private function boolean check_type (boolean p_msg);
// 未入力はスキップ
if len( this.text ) = 0 or isnull( this.text ) then
	return true
end if

choose case true
	case chk_type_num
		if not isnumber( trim( this.text ) ) then
			if p_msg then
				of_msg_error( this, fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", trim( this.text ) ) )
			end if

			return false
		end if
	case chk_type_date
	case chk_type_yearmonth
	case chk_type_time
	case else
end choose

return true
end function

public function boolean of_isna ();
return not check_requied( false )
end function

public function boolean of_check ();
// 未入力チェック
if chk_required then
	if not check_requied( true ) then
		this.setfocus()
		return false
	end if
end if

// 入力された内容のチェック //
this.setfocus()
this.text	= fnc.of_cnv_tilde( this.text )

// 型チェック
if chk_type_num or chk_type_date or chk_type_time or chk_type_yearmonth then
	if not check_type( true ) then
		this.setfocus()
		return false
	end if
end if

// 桁数チェック
if chk_digits then
	if not check_digits( true ) then
		this.setfocus()
		return false
	end if
end if

return true

end function

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

on ivo_dropdownpicturelistbox.create
call super::create
end on

on ivo_dropdownpicturelistbox.destroy
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

// 入力文字選択
if allowedit then
	if selecttext then
		this.selecttext( 1, len( this.text ) )
	end if
end if

end event

event constructor;call super::constructor;object_type	= "dropdownpicturelistbox" 

// i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
// i_sfunction_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

// 無効／編集不可などの場合の背景色
input_ena_backcolor	= rgb( 255, 255, 255 )
input_dis_backcolor	= palette.main_background

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

// 強制的に１つ目を選択状態にする
if upperbound( this.item ) > 0 then
	i_idx	= 1
	this.selectitem( i_idx )
end if

end event

event key_enter;call super::key_enter;
return 0
end event

event selectionchanged;call super::selectionchanged;
i_idx	= index

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

