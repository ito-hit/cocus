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

on nv_message.create
call super::create
end on

on nv_message.destroy
call super::destroy
end on

