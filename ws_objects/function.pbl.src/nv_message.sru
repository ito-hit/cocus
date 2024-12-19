$PBExportHeader$nv_message.sru
$PBExportComments$メッセージ関数
forward
global type nv_message from inv_object
end type
end forward

global type nv_message from inv_object autoinstantiate
end type

type prototypes

end prototypes

type variables
end variables

forward prototypes
public subroutine of_warning (string p_text)
public subroutine of_info (string p_text)
private function integer msg (icon p_icon, button p_button, string p_title, string p_message)
public function boolean of_question (string p_text)
public function boolean of_warning_question (string p_text)
public function boolean of_retry_question (string p_text)
public subroutine of_error (string p_text)
public subroutine of_error_db (string p_text, inv_transaction p_tran)
public subroutine of_error_dwo (dwobject p_dwo, string p_text)
public subroutine of_error_sle (singlelineedit p_sle, string p_text)
public subroutine of_error_dwo (datawindow p_dw, long p_row, dwobject p_dwo, string p_text)
end prototypes

public subroutine of_warning (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_warning
// Purpose:		警告メッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

msg( Exclamation!, OK!, "警告", p_text )

end subroutine

public subroutine of_info (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_info
// Purpose:		情報（お知らせ）メッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

msg( Information!, OK!, "情報", p_text )
end subroutine

private function integer msg (icon p_icon, button p_button, string p_title, string p_message);return messagebox( p_title, p_message, p_icon, p_button, 2 )

end function

public function boolean of_question (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_question
// Purpose:		確認メッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Return:     	boolean	確認メッセージの返答
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_ans

l_ans	= msg( Question!, YesNo!, "確認", p_text )

return fnc.of_decode( l_ans, 1,  true, false )
end function

public function boolean of_warning_question (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_warning_question
// Purpose:		確認警告メッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Return:     	boolean	確認メッセージの返答
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_ans

l_ans	= msg( Exclamation!, YesNo!, "警告", p_text )

return fnc.of_decode( l_ans, 1,  true, false )
end function

public function boolean of_retry_question (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_retry_question
// Purpose:		確認再試行メッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Return:     	boolean	確認メッセージの返答
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_ans

l_ans	= msg( Exclamation!, RetryCancel!, "警告", p_text )

return fnc.of_decode( l_ans, 1,  true, false )
end function

public subroutine of_error (string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_error
// Purpose:		エラーメッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

msg( StopSign!, OK!, "エラー", p_text )
end subroutine

public subroutine of_error_db (string p_text, inv_transaction p_tran);// --------------------------------------------------------------------------
// Script:		nv_func.of_error
// Purpose:		エラーメッセージを表示する
//
// Arguments:	p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_text

if p_tran.last_sqlerrcode <> 0 then
	l_text	= fnc.strg.of_format( "{1}{2}({3}:{4})", p_text, code.crlf, string( p_tran.last_sqlerrcode ), p_tran.last_sqlerrtext )
else
	l_text	= p_text
end if

msg( StopSign!, OK!, "エラー", l_text )
end subroutine

public subroutine of_error_dwo (dwobject p_dwo, string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_error_dwo
// Purpose:		エラーメッセージを表示する（データウインドウ用）
//
// Arguments:	p_dwo	- データウインドウオブジェクト
// 				p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

constant	string c_error_color		= string( RGB( 255 ,0, 0 ) )
constant	string c_back_error_color	= string( RGB( 248, 215, 218 ) )

string l_color,l_backcolor

l_color		= p_dwo.color
l_backcolor	= p_dwo.background.color

p_dwo.color				= c_error_color
p_dwo.background.color	= c_back_error_color

msg( StopSign!, OK!, "エラー", p_text )

p_dwo.color				= l_color
p_dwo.background.color	= l_backcolor

end subroutine

public subroutine of_error_sle (singlelineedit p_sle, string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_error_dwo
// Purpose:		エラーメッセージを表示する（シングルラインエディット用）
//
// Arguments:	p_sle	- シングルラインエディットコントロール
// 				p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

long	l_sle_textcolor
long	l_sle_backcolor

l_sle_backcolor	= p_sle.backcolor
l_sle_textcolor	= p_sle.textcolor

p_sle.backcolor	= RGB( 248, 215, 218 )
p_sle.textcolor	= RGB( 255, 0, 0 )

of_error( p_text )

p_sle.backcolor	= l_sle_backcolor
p_sle.textcolor	= l_sle_textcolor

p_sle.setfocus( )

end subroutine

public subroutine of_error_dwo (datawindow p_dw, long p_row, dwobject p_dwo, string p_text);// --------------------------------------------------------------------------
// Script:		nv_func.of_error_dwo
// Purpose:		エラーが発生したカラムにフォーカスし、エラーメッセージを表示する（データウインドウ用）
//
// Arguments:	p_dw	- データウインドウ
//				p_row	- エラーが発生した行
//				p_dwo	- データウインドウオブジェクト
// 				p_text	- メッセージボックスに表示する文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2024.11.11	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_dwo_x, l_dwo_width
long	l_dw_pos, l_dw_pos_after
integer	l_dw_width

long	l_row_first, l_row_last, l_row_after

l_dw_pos	= long( p_dw.object.datawindow.horizontalscrollposition )
l_dw_width	= p_dw.width
l_dwo_x		= long( p_dwo.x )
l_dwo_width	= long( p_dwo.width )

l_row_first	= long( p_dw.object.datawindow.firstrowonpage )
l_row_last	= long( p_dw.object.datawindow.lastrowonpage )

p_dw.setredraw( false )

// DW表示範囲内に入っていなければ縦スクロールを行う
if p_row >= l_row_first and p_row <= l_row_last then
	// 調整不要
	l_row_after	= l_row_first
else
	// 対象行へスクロール
	l_row_after	= p_row
end if


// DW表示範囲内に入っていなければ横スクロールを行う
if l_dwo_x >= l_dw_pos and l_dw_pos < ( l_dwo_x + l_dwo_width ) then	// dwo開始位置がdw範囲内にあるか
	if ( l_dwo_x + l_dwo_width ) <= ( l_dw_pos + l_dw_width ) then		// dwoの終了位置がdw範囲内にあるか
		// 調整不要
		l_dw_pos_after	= l_dw_pos
	else
		// 右へスクロール
		l_dw_pos_after	= ( l_dwo_x + l_dwo_width ) - l_dw_width + 100
	end if
else
	// 左へスクロール(スクロール量0でも表示しきれるなら0にする)
	if l_dw_width >= ( l_dwo_x + l_dwo_width ) then
		l_dw_pos_after	= 0
	else
		l_dw_pos_after	= l_dwo_x
	end if
end if

if l_dw_pos_after < 0 then
	l_dw_pos_after	= 0
end if

p_dw.scrolltorow( l_row_after )
p_dw.object.datawindow.horizontalscrollposition	= l_dw_pos_after

p_dw.setredraw( true )

of_error_dwo( p_dwo, p_text )


end subroutine

on nv_message.create
call super::create
end on

on nv_message.destroy
call super::destroy
end on

