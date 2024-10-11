$PBExportHeader$acc_txtlog.sru
$PBExportComments$テキストログ出力用の始祖オブジェクト
forward
global type acc_txtlog from nonvisualobject
end type
type lstr_logfile from structure within acc_txtlog
end type
end forward

type lstr_logfile from structure
	string		date
	string		time
	string		client
	string		user
	integer		info
	string		object
	string		name
	integer		code
	string		msg
end type

global type acc_txtlog from nonvisualobject
end type
global acc_txtlog acc_txtlog

type variables
boolean	on_alert_msg, on_alert_log, on_debug

constant string	alog	= "alog{1}.log"	// アクセスログ
constant string	elog	= "elog{1}.log"	// エラーログ
constant string	slog	= "slog{1}.log"	// システムログ

// メッセージ用
constant integer	TYPE_INFO	= 0	// Information!(情報)
constant integer	TYPE_WARN	= 1	// Exclamation!(警告)
constant integer	TYPE_ERR	= 2	// StopSign!(エラー)
constant integer	TYPE_QUES	= 3 // Question!(質問)

// ログ用
constant integer	TYPE_SYS	= 10 // システムログ
constant integer	TYPE_ACS	= 11 // アクセスログ
constant integer	TYPE_ALT	= 12 // アラートログ

end variables

forward prototypes
private function string str2csv (any p_str, string p_deli)
private subroutine sys_alert (integer p_type, string p_name, integer p_code, string p_msg, boolean p_enabled_msg, boolean p_enabled_log)
public subroutine of_sys_alert (integer p_type, string p_name, integer p_code, string p_msg)
public subroutine of_sys_alert_msg (integer p_type, string p_name, integer p_code, string p_msg)
public subroutine of_sys_alert_log (integer p_type, string p_name, integer p_code, string p_msg)
public subroutine of_debug (string p_text)
private subroutine sys_alert_log (integer p_type, lstr_logfile p_rec)
private subroutine sys_alert_msg (lstr_logfile p_rec)
end prototypes

private function string str2csv (any p_str, string p_deli);string			l_string
lstr_logfile	l_str

// 先祖オブジェクトではログファイルをタブ区切りすることに使用する
choose case classname( p_str )
	case "s_logfile"
		l_str	= p_str

		return l_str.date + p_deli + l_str.time + p_deli + l_str.object + p_deli + l_str.name + p_deli + string( l_str.info ) + p_deli + string( l_str.code ) + p_deli + l_str.msg
end choose

return ""
end function

private subroutine sys_alert (integer p_type, string p_name, integer p_code, string p_msg, boolean p_enabled_msg, boolean p_enabled_log);// システムエラーのみ対応するので通常のメッセージはここでは対応しない
lstr_logfile	l_rec

l_rec.date		= string( today(), "yyyy.mm.dd" )
l_rec.time		= string( now(), "hh:mm:ss:fff" )
l_rec.client	= device.name
l_rec.user		= user.user_id
l_rec.info		= p_type
l_rec.object	= this.classname()
l_rec.name		= p_name
l_rec.code		= p_code
l_rec.msg		= p_msg

if p_enabled_msg then
	sys_alert_msg( l_rec )
end if

if p_type = TYPE_WARN or p_type	= TYPE_ERR then
	p_enabled_log	= true
end if

if p_enabled_log then
	integer		l_type
	
	choose case p_type
		case TYPE_INFO
			l_type	= TYPE_SYS
		case TYPE_WARN
			l_type	= TYPE_ALT
		case TYPE_ERR
			l_type	= TYPE_ALT
		case TYPE_QUES
			l_type	= TYPE_SYS
		case else
			l_type	= TYPE_SYS
	end choose

	sys_alert_log( l_type, l_rec )
end if


end subroutine

public subroutine of_sys_alert (integer p_type, string p_name, integer p_code, string p_msg);sys_alert( p_type, p_name, p_code, p_msg, on_alert_msg, on_alert_log )

end subroutine

public subroutine of_sys_alert_msg (integer p_type, string p_name, integer p_code, string p_msg);sys_alert( p_type, p_name, p_code, p_msg, true, false )

end subroutine

public subroutine of_sys_alert_log (integer p_type, string p_name, integer p_code, string p_msg);sys_alert( p_type, p_name, p_code, p_msg, false, true )

end subroutine

public subroutine of_debug (string p_text);// --------------------------------------------------------------------------
// Script:     	of_debug
// Purpose:    	デバッグモードが有効な場合、ログファイルを出力する
//
// Arguments:  	p_text			- ログに出力したい文字列
//
// Return:     	integer	連結後の文字数
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_dir,l_file
integer	l_no

if on_debug then
	l_dir	= getcurrentdirectory()
	l_file	= string( today(), "yyyymmdd" ) + ".log"
	l_no	= fileopen( l_dir + "\" + l_file, LineMode!, Write!, LockRead!, Append! )
	
	filewrite( l_no, p_text )
	fileclose( l_no )
end if

end subroutine

private subroutine sys_alert_log (integer p_type, lstr_logfile p_rec);constant string	l_emb	= "{1}"

string	l_file_name
integer	l_file
string	l_log

choose case p_type
	case TYPE_SYS	// システムログ
		l_file_name	= "slog{1}.log"	// システムログ
	case TYPE_ACS	// アクセスログ
		l_file_name	= "alog{1}.log"	// アクセスログ
	case TYPE_ALT	// アラートログ
		l_file_name	= "elog{1}.log"	// エラーログ
	case else
		l_file_name	= "slog{1}.log"	// システムログ
end choose

// ファイル名取得及び出力データをコンバート
l_file_name	= left( l_file_name, pos( l_file_name, l_emb ) - 1 ) + string( today(), "yyyymmdd" ) + mid( l_file_name, lastpos( l_file_name, l_emb ) + len( l_emb ) )
l_log		= str2csv( p_rec, code.TAB )

l_file		= fileopen( l_file_name,linemode!, write!, shared!, append!, encodingansi! )

filewriteex( l_file, l_log )

fileclose( l_file )


end subroutine

private subroutine sys_alert_msg (lstr_logfile p_rec);icon	l_icon
button	l_button

string	l_title,l_msg

l_button	= OK!

choose case p_rec.info
	case TYPE_INFO
		l_icon		= Information!
		l_title		= "情報"
	case TYPE_WARN
		l_icon		= Exclamation!
		l_title		= "警告"
	case TYPE_ERR
		l_icon		= StopSign!
		l_title		= "エラー"
	case TYPE_QUES
		l_icon		= Question!
		l_title		= "確認"
	case else
		l_icon		= Information!
		l_title		= "情報"
end choose

l_msg	= "date：" + p_rec.date + " " + p_rec.time + code.crlf + "obj：" + p_rec.object + "  name：" + p_rec.name + code.crlf + "code：" +string(  p_rec.code ) + code.crlf + "msg：" + p_rec.msg

messagebox ( l_title, l_msg, l_icon, l_button )

end subroutine

on acc_txtlog.create
call super::create
TriggerEvent( this, "constructor" )
end on

on acc_txtlog.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// コンストラクタ
end event

event destructor;// デストラクタ
end event

