$PBExportHeader$nv_smtp.sru
$PBExportComments$メール送信関数
forward
global type nv_smtp from inv_object
end type
end forward

global type nv_smtp from inv_object autoinstantiate
end type

type variables
constant string		CRLF						= "~r~n"
constant string		DQUOTE						= "~""		// ダブルクォーテーション

// ログイン認証パラメーター
constant integer	AUTH_NONE					= 0
constant integer	AUTH_CRAM_MD5				= 1
constant integer	AUTH_LOGIN					= 2
constant integer	AUTH_PLAIN					= 3
constant integer	AUTH_NTLM					= 4
constant integer	AUTH_AUTO					= 5
constant integer	AUTH_XOAUTH2				= 6

// 接続方法パラメーター
constant integer	PLAIN_TEXT					= 0
constant integer	SSL_TLS						= 1
constant integer	STARTTLS					= 2
constant integer	AUTO_UPGRADE_TO_STARTTLS	= 3

// 優先度パラメーター
constant integer	NO_PRIORITY					= 0
constant integer	LOW_PRIORITY				= 1
constant integer	NORMAL_PRIORITY				= 2
constant integer	HIGH_PRIORITY				= 3

// 文字コードパラメーター
constant string		ARABIC_WINDOWS				= "windows-1256"	// windows-1256	Arabic (Windows)
constant string		BALTIC_WINDOWS				= "windows-1257"	// windows-1257	Baltic (Windows)
constant string		CENTRAL-EUROPEAN_ISO		= "iso-8859-2"		// iso-8859-2	Central European (ISO)
constant string		CENTRAL-EUROPEAN_WINDOWS	= "windows-1250"	// windows-1250	Central European (Windows)
constant string		CHINESE-SIMPLIFIED_GB2312	= "gb2312"			// gb2312		Chinese Simplified (GB2312)
constant string		CHINESE-SIMPLIFIED_HZ		= "hz-gb-2312"		// hz-gb-2312	Chinese Simplified (HZ)
constant string		CHINESE-TRADITIONAL_BIG5	= "big5"			// big5			Chinese Traditional (Big5)
constant string		CYRILIC_KOI8-R				= "koi8-r"			// koi8-r		Cyrilic (KOI8-R)
constant string		CYRILLIC_WINDOWS			= "windows-1251"	// windows-1251	Cyrillic (Windows)
constant string		GREEK_WINDOWS				= "windows-1253"	// windows-1253	Greek (Windows)
constant string		HEBREW_WINDOWS				= "windows-1255"	// windows-1255	Hebrew (Windows)
constant string		JAPANESE_JIS				= "iso-2022-jp"		// iso-2022-jp	Japanese (JIS)
constant string		KOREAN						= "ks_c_5601"		// ks_c_5601	Korean
constant string		KOREAN_EUC					= "euc-kr"			// euc-kr		Korean (EUC)
constant string		LATIN9_ISO					= "iso-8859-15"		// iso-8859-15	Latin 9 (ISO)
constant string		THAI_WINDOWS				= "windows-874"		// windows-874	Thai (Windows)
constant string		TURKISH_WINDOWS				= "windows-1254"	// windows-1254	Turkish (Windows)
constant string		UNICODE_UTF-7				= "utf-7"			// utf-7		Unicode (UTF-7)
constant string		UNICODE_UTF-8				= "utf-8"			// utf-8		Unicode (UTF-8)
constant string		VIETNAMESE_WINDOWS			= "windows-1258"	// windows-1258	Vietnamese (Windows)
constant string		WESTERN-EUROPEAN_ISO		= "iso-8859-1"		// iso-8859-1	Western European (ISO)
constant string		WESTERN-EUROPEAN_WINDOWS	= "windows-1252"	// windows-1252	Western European (Windows)

// 初期化用パラメーター
constant integer	RESET_FROM					= 11	// 送信元情報
constant integer	RESET_TO					= 12	// 送信先情報
constant integer	RESET_MAIL_TXT				= 21	// メール情報(件名、本文のみ)
constant integer	RESET_MAIL_ATTACH			= 22	// メール情報(添付ファイルのみ)
constant integer	RESET_MAIL_ALL				= 23	// メール情報(添付ファイル含めたすべて)
constant integer	RESET_SERVER				= 31	// サーバー情報(ログイン情報含む)
constant integer	RESET_ALL					= 91	// すべての情報

// 初期値保管用変数
private boolean		i_init_html, i_init_read_receipt
private string		i_init_smtp_server, i_init_charset
private integer		i_init_port, i_init_conn_type, i_init_auth, i_init_priority

// 初期値有変数
boolean	i_html			= false	// HTMLメール
boolean	i_read_receipt	= false	// 開封通知
integer	i_priority		= 0		// 優先度

string	i_smtp_server	= "smtp.alpha-prm.jp"
integer	i_port			= 587
integer	i_conn_type		= 0
integer	i_auth			= 2
string	i_charset		= UNICODE_UTF-8

string	i_userid
string	i_password

string	i_from_addr
string	i_from_name

string	i_to_addr[]
string	i_to_name[]
string	i_cc_addr[]
string	i_cc_name[]
string	i_bcc_addr[]
string	i_bcc_name[]

string	i_subject
string	i_body

string	i_attachment[]



end variables

forward prototypes
private function long parse (readonly string p_string, readonly string p_separator, ref string p_outarray[])
private function boolean validemail (string p_email, ref string p_errormsg)
public subroutine of_set_from (string p_from_addr, string p_from_name)
public subroutine of_set_from (string p_from_addr)
public function integer of_set_to (string p_to_addr, string p_to_name)
public function integer of_set_to (string p_to_addr)
private function any split (string p_text, string p_delimiter)
private function any split (string p_text)
public function integer of_set_cc (string p_cc_addr, string p_cc_name)
public function integer of_set_bcc (string p_bcc_addr, string p_bcc_name)
public function integer of_set_cc (string p_cc_addr)
public function integer of_set_bcc (string p_bcc_addr)
public subroutine of_set_body (string p_body, boolean p_html)
public subroutine of_set_body (string p_body)
public subroutine of_set_conn_type (integer p_type)
public subroutine of_set_port (integer p_port)
public subroutine of_login_auth (integer p_auth)
public subroutine of_set_charset (string p_charset)
public subroutine of_set_receipt (boolean p_enabled)
public subroutine of_set_login (string p_id, string p_pw)
public subroutine of_set_subject (string p_subject)
public function integer of_add_cc (string p_cc_addr, string p_cc_name)
private function integer set_address (string p_type, string p_addr, string p_name)
private function integer add_address (string p_type, string p_addr, string p_name)
public function integer of_add_to (string p_to_addr, string p_to_name)
public function integer of_add_bcc (string p_bcc_addr, string p_bcc_name)
public function integer of_add_to (string p_to_addr)
public function integer of_add_cc (string p_cc_addr)
public function integer of_add_bcc (string p_bcc_addr)
public subroutine of_reset (integer p_mode)
public subroutine of_set_server (string p_server, integer p_port, string p_id, string p_pw)
public subroutine of_set_server (string p_server, integer p_port)
public subroutine of_set_server (string p_server)
public function integer of_set_attachfile (string p_file)
public function integer of_add_attachfile (string p_file)
public function boolean of_entry_check ()
public subroutine of_set_priority (integer p_priority)
public function boolean of_sendmail ()
private function boolean sendmail ()
private function string join_addresses (string p_addr[], string p_name[])
private function string join_address (string p_addr, string p_name)
private subroutine join_attachment (ref string p_outputstring, string p_newstring)
public function boolean of_send_mail (string p_to_addr, string p_subject, string p_body)
public function boolean of_send_mail (string p_to_addr, string p_subject, string p_body, string p_attachment)
public subroutine of_init_settings (string p_userid, string p_password, string p_from_addr, string p_from_name)
private function integer split_address (ref string p_addr, ref string p_name)
end prototypes

private function long parse (readonly string p_string, readonly string p_separator, ref string p_outarray[]);long l_posend, l_posstart = 1, l_separatorlen, l_counter = 1

if upperbound( p_outarray ) > 0 then p_outarray = {""}

l_separatorlen	= len( p_separator )
l_posend	= pos( p_string, p_separator, 1 )

do while l_posend > 0
	p_outarray[l_counter]	= mid( p_string, l_posstart, l_posend - l_posstart )
	l_posstart				= l_posend + l_separatorlen
	l_posend				= pos( p_string, p_separator, l_posstart )
	l_counter				= l_counter + 1
loop

p_outarray[l_counter]	= right( p_string, len( p_string) - l_posstart + 1 )

return l_counter

end function

private function boolean validemail (string p_email, ref string p_errormsg);string l_localpart, l_domain, l_domainpart[]
integer l_pos, l_idx, l_max, l_asc

if len( p_email ) > 254 then
	p_errormsg	= "メールアドレスは254文字を超えることはできません。"
	return false
end if

l_pos	= pos( p_email, "@" )
if l_pos < 2 then
	p_errormsg	= "メールアドレスには「＠」が必要です。"
	return false
end if

if lastpos( p_email, "@" ) > pos( p_email, "@" ) Then
	p_errormsg	= "メールアドレスに複数の「＠」を含めることはできません。"
	return false
end if

l_pos	= pos( p_email, " " )
if l_pos > 0 then
	p_errormsg	= "メールアドレスにスペースを入れることはできません。"
	return false
end if

// split local & domain
l_pos		= pos( p_email, "@" )
l_localpart	= left( p_email, l_pos - 1 )
l_domain	= mid( p_email, l_pos + 1 )

if len( l_localpart ) > 64 then
	p_errormsg	= "メールアドレスの＠以前の部分は64文字を超えることはできません。"
	return false
end if

if len( l_domain ) > 253 then
	p_errormsg	= "メールアドレスの＠以下の部分は253文字を超えることはできません。"
	return false
end if

if left( l_localpart, 1 ) = "." then
	p_errormsg	= "メールアドレスの＠以前の部分はピリオドで始めることはできません。"
	return false
end if

if right( l_localpart, 1 ) = "." then
	p_errormsg	= "メールアドレスの＠以前の部分をピリオドで終わらせることはできません。"
	return false
end if

if pos( l_localpart, ".." ) > 0 then
	p_errormsg	= "メールアドレスの＠以前の部分は、連続して複数のピリオドを持つことはできません。"
	return false
end if

// check local for allowed characters
l_max	= len( l_localpart )
for l_idx = 1 to l_max
	l_asc	= asc( mid( l_localpart, l_idx, 1 ) )

	choose case l_asc
		case 65 to 90
			// lower case a-z
		case 97 to 122
			// upper case A-Z
		case 48 to 57
			// digits 0-9
		case 33, 35 to 39, 42, 43, 45, 47, 61, 63, 94 to 96, 123 to 126
			// characters !#$%&'*+-/=?^_`{|}~
		case 46
			// period
		case else
			p_errormsg	= "メールアドレスの＠以前の部分に無効な文字が含まれています。"
			return false
	end choose
next

if left( l_domain, 1 ) = "." then
	p_errormsg	= "メールアドレスの＠以下の部分はピリオドで始めることはできません。"
	return false
end if

if right( l_domain, 1 ) = "." then
	p_errormsg	= "メールアドレスの＠以下の部分をピリオドで終わらせることはできません。"
	return false
end if

l_pos	= pos( l_domain, "." )
if l_pos = 0 then
	p_errormsg	= "メールアドレスの＠以下の部分には、少なくとも1つのピリオドが必要です。"
	return false
end if

// check domain for allowed characters
l_max	= len( l_domain )

for l_idx = 1 to l_max
	l_asc	= asc( mid( l_domain, l_idx, 1 ) )

	choose case l_asc
		case 65 to 90
			// lower case a-z
		case 97 to 122
			// upper case A-Z
		case 48 to 57
			// digits 0-9
		case 45
			// hyphen
		case 46
			// period
		case else
			p_errormsg	= "メールアドレスの＠以下の部分に無効な文字が含まれています"
			return false
	end choose
next

// break domain into parts
l_max	= parse( l_domain, ".", l_domainpart )

if l_max > 127 then
	p_errormsg	= "メールアドレスの＠以下の部分に含まれるピリオドが多すぎます。"
	return false
end if

for l_idx = 1 to l_max
	if left( l_domainpart[l_idx], 1 ) = "-" then
		p_errormsg	= "メールアドレスの＠以下の部分でハイフンとピリオドを並べることはできません。"
		return false
	end if

	if right( l_domainpart[l_idx], 1 ) = "-" then
		p_errormsg	= "メールアドレスの＠以下の部分でハイフンとピリオドを並べることはできません。"
		return false
	end if
next

return true

end function

public subroutine of_set_from (string p_from_addr, string p_from_name);i_from_addr	= p_from_addr
i_from_name	= p_from_name


end subroutine

public subroutine of_set_from (string p_from_addr);of_set_from( p_from_addr, "" )
end subroutine

public function integer of_set_to (string p_to_addr, string p_to_name);return set_address( "to", p_to_addr, p_to_name )

end function

public function integer of_set_to (string p_to_addr);return of_set_to( p_to_addr, "" )
end function

private function any split (string p_text, string p_delimiter);string	l_string[]
any		l_any
string	l_midstr

int	l_idx, l_pos

l_idx	= 1

// 最初と最後に分割文字が存在する場合は削除 //
if pos( p_text, p_delimiter ) = 1 then
	p_text	= mid( p_text, len( p_delimiter ) + 1 )
end if
if right( p_text, len( p_delimiter ) ) = p_delimiter then
	p_text	= left( p_text, len( p_text ) - len( p_delimiter ) )
end if

setnull(l_pos)

do until l_pos = 0
	l_pos	= pos( p_text, p_delimiter )

	if l_pos <> 0 then
		l_midstr	= left( p_text, l_pos - 1 )
		p_text		= mid( p_text, l_pos + len( p_delimiter ) )
	else
		l_midstr	= p_text
	end if
	l_string[l_idx]	= trim( l_midstr )
	l_idx			= l_idx + 1
loop

l_any	= l_string

return l_any
end function

private function any split (string p_text);return split( p_text, "," )
end function

public function integer of_set_cc (string p_cc_addr, string p_cc_name);return set_address( "cc", p_cc_addr, p_cc_name )

end function

public function integer of_set_bcc (string p_bcc_addr, string p_bcc_name);return set_address( "bcc", p_bcc_addr, p_bcc_name )

end function

public function integer of_set_cc (string p_cc_addr);return of_set_cc( p_cc_addr, "" )
end function

public function integer of_set_bcc (string p_bcc_addr);return of_set_bcc( p_bcc_addr, "" )
end function

public subroutine of_set_body (string p_body, boolean p_html);i_body	= p_body
i_html	= p_html

end subroutine

public subroutine of_set_body (string p_body);of_set_body( p_body, i_html )
end subroutine

public subroutine of_set_conn_type (integer p_type);i_conn_type	= p_type
end subroutine

public subroutine of_set_port (integer p_port);i_port	= p_port
end subroutine

public subroutine of_login_auth (integer p_auth);i_auth	= p_auth
end subroutine

public subroutine of_set_charset (string p_charset);i_charset	= p_charset
end subroutine

public subroutine of_set_receipt (boolean p_enabled);i_read_receipt	= p_enabled
end subroutine

public subroutine of_set_login (string p_id, string p_pw);i_userid	= p_id
i_password	= p_pw
end subroutine

public subroutine of_set_subject (string p_subject);i_subject	= p_subject
end subroutine

public function integer of_add_cc (string p_cc_addr, string p_cc_name);return add_address( "cc", p_cc_addr, p_cc_name )
end function

private function integer set_address (string p_type, string p_addr, string p_name);integer	l_idx

string	l_addr[]
string	l_name[]

string	l_dummy[]
string	l_tmp_name[]


if len( p_addr ) > 0 then
	choose case lower( p_type )
		case "to"
			l_addr	= split( p_addr )
			l_name	= l_dummy
		case "cc"
			l_addr	= split( p_addr )
			l_name	= l_dummy
		case "bcc"
			l_addr	= split( p_addr )
			l_name	= l_dummy
		case else
	end choose

	l_tmp_name	= split( p_name )

	for l_idx = 1 to upperbound( l_addr )
		if upperbound( l_tmp_name ) >= l_idx then
			l_name[l_idx]	= l_tmp_name[l_idx]
		else
			l_name[l_idx]	= ""
		end if
	next	

	choose case lower( p_type )
		case "to"
			i_to_addr	= l_addr
			i_to_name	= l_name
		case "cc"
			i_cc_addr	= l_addr
			i_cc_name	= l_name
		case "bcc"
			i_bcc_addr	= l_addr
			i_bcc_name	= l_name
		case else
	end choose
end if

return l_idx

end function

private function integer add_address (string p_type, string p_addr, string p_name);integer	l_idx

string	l_addr[]
string	l_name[]

string	l_tmp_addr[]
string	l_tmp_name[]

choose case lower( p_type )
	case "to"
		l_addr	= i_to_addr
		l_name	= i_to_name
	case "cc"
		l_addr	= i_cc_addr
		l_name	= i_cc_name
	case "bcc"
		l_addr	= i_bcc_addr
		l_name	= i_bcc_name
	case else
end choose

l_tmp_addr	= split( p_addr )
l_tmp_name	= split( p_name )

for l_idx = 1 to upperbound( l_tmp_addr )
	l_addr[upperbound( l_addr ) + 1]	= l_tmp_addr[l_idx]
	
	if upperbound( l_tmp_name ) >= l_idx then
		l_name[upperbound( l_name ) + 1]	= l_tmp_name[l_idx]
	else
		l_name[upperbound( l_name ) + 1]	= ""
	end if
next

choose case lower( p_type )
	case "to"
		i_to_addr	= l_addr
		i_to_name	= l_name
	case "cc"
		i_cc_addr	= l_addr
		i_cc_name	= l_name
	case "bcc"
		i_bcc_addr	= l_addr
		i_bcc_name	= l_name
	case else
end choose

return l_idx

end function

public function integer of_add_to (string p_to_addr, string p_to_name);return add_address( "to", p_to_addr, p_to_name )
end function

public function integer of_add_bcc (string p_bcc_addr, string p_bcc_name);return add_address( "bcc", p_bcc_addr, p_bcc_name )
end function

public function integer of_add_to (string p_to_addr);return of_add_to( p_to_addr, "" )
end function

public function integer of_add_cc (string p_cc_addr);return of_add_cc( p_cc_addr, "" )
end function

public function integer of_add_bcc (string p_bcc_addr);return of_add_bcc( p_bcc_addr, "" )
end function

public subroutine of_reset (integer p_mode);string	l_dummy[]

choose case p_mode
	case RESET_FROM			// 送信元情報
		i_from_addr		= ""
		i_from_name		= ""

	case RESET_TO			// 送信先情報
		i_to_addr		= l_dummy
		i_to_name		= l_dummy
		i_cc_addr		= l_dummy
		i_cc_name		= l_dummy
		i_bcc_addr		= l_dummy
		i_bcc_name		= l_dummy

	case RESET_MAIL_TXT		// メール情報(件名、本文のみ)
		i_subject		= ""
		i_body			= ""

	case RESET_MAIL_ATTACH	// メール情報(添付ファイルのみ)
		i_attachment	= l_dummy

	case RESET_MAIL_ALL		// メール情報(添付ファイル含めたすべて)
		of_reset( RESET_MAIL_TXT )
		of_reset( RESET_MAIL_ATTACH )

	case RESET_SERVER		// サーバー情報(ログイン情報含む)
		i_html			= i_init_html
		i_read_receipt	= i_init_read_receipt
		i_priority		= i_init_priority
		i_smtp_server	= i_init_smtp_server
		i_port			= i_init_port
		i_conn_type		= i_init_conn_type
		i_auth			= i_init_auth
		i_charset		= i_init_charset
	
		i_userid		= ""
		i_password		= ""

	case RESET_ALL			// すべての情報
		of_reset( RESET_FROM )
		of_reset( RESET_TO )
		of_reset( RESET_MAIL_ALL )
		of_reset( RESET_SERVER )

	case else
end choose

end subroutine

public subroutine of_set_server (string p_server, integer p_port, string p_id, string p_pw);of_set_server( p_server, p_port )

i_userid		= p_id
i_password		= p_pw
end subroutine

public subroutine of_set_server (string p_server, integer p_port);of_set_server( p_server )

i_port			= p_port

end subroutine

public subroutine of_set_server (string p_server);i_smtp_server	= p_server
end subroutine

public function integer of_set_attachfile (string p_file);string	l_dummy[]

i_attachment	= l_dummy
i_attachment	= split( p_file )

return upperbound( i_attachment )
end function

public function integer of_add_attachfile (string p_file);integer	l_idx
string	l_attachment[]

l_attachment	= split( p_file )

for l_idx = 1 to upperbound( l_attachment )
	i_attachment[upperbound( i_attachment ) + 1]	= l_attachment[l_idx]
next

return upperbound( i_attachment )
end function

public function boolean of_entry_check ();if i_smtp_server = "" then
	messagebox("edit error", "SMTPサーバーに関する情報がありません。", stopsign!)
	return false
end if

//if fom_email.text = "" then
//	sle_sender_email.setfocus()
//	messagebox("edit error", "Fromアドレスに関する情報がありません。", stopsign!)
//	return
//end if
//
//if not smtp.validemail(fom_email.text, ls_errmsg) then
//	sle_sender_email.setfocus()
//	messagebox("from email format error", ls_errmsg, stopsign!)
//	return
//end if
//
//if to_email.text = "" then
//	sle_recip_email.setfocus()
//	messagebox("edit error", "Toアドレスに関する情報がありません。", stopsign!)
//	return
//end if
//
//if not smtp.validemail(to_email.text, ls_errmsg) then
//	sle_recip_email.setfocus()
//	messagebox("to email format error", ls_errmsg, stopsign!)
//	return
//end if

if i_subject = "" then
	messagebox("edit error", "件名が入力されていません。", stopsign!)
	return false
end if

if i_body = "" then
	messagebox("edit error", "本文が入力されていません。", stopsign!)
	return false
end if

return true
end function

public subroutine of_set_priority (integer p_priority);i_priority	= p_priority
end subroutine

public function boolean of_sendmail ();return sendmail( )
end function

private function boolean sendmail ();
n_cpp_smtp	smtp

integer	l_idx
string	l_attach
string	l_body
string	l_work
integer	l_ret
string	l_email_list

// SMTPオブジェクト生成
smtp	= create n_cpp_smtp

randomize( 0 )

// サーバー関連情報セット
smtp.setsmtpserver( i_smtp_server )
smtp.setusernamepassword( i_userid, i_password )
smtp.setport( i_port )
smtp.setauthmethod( i_auth )
smtp.setconnectiontype( i_conn_type )
smtp.setcharset( i_charset )

// 添付ファイルリスト生成
l_attach	= ""

for l_idx = 1 to upperbound( i_attachment )
	if len( l_attach ) <> 0 then
		fnc.strg.of_append_line( l_attach, ";", false )
	end if

	fnc.strg.of_append_line( l_attach, trim( i_attachment[l_idx] ), false )
next

// 本文生成
smtp.setsubject( i_subject )

if i_html then
	fnc.strg.of_append_line( l_body, "<html><body bgcolor='#ffffff' topmargin=8 leftmargin=8><h2>", false )
	fnc.strg.of_append_line( l_body, fnc.strg.of_replace( i_body, CRLF, "<br>") + "</h2>", false )

	for l_idx = 1 to upperbound( i_attachment )
		l_work	= i_attachment[l_idx]
		l_work	= mid( l_work, lastpos( l_work, "\" ) + 1 )

		fnc.strg.of_append_line( l_body, "<br><h2>" + l_work + "</h2><br>", false )
		fnc.strg.of_append_line( l_body, "<img src='cid:attachment" + string( l_idx ) + "'/>", false )
	next

//	ls_body += "</body></html>"
	fnc.strg.of_append_line( l_body, "</body></html>", false )
else
	l_body	= i_body
end if

// 送信元アドレスセット
smtp.setsenderemail( join_address( i_from_addr, i_from_name ) )

// Toアドレスを一つの文字列にまとめてからセット
smtp.setrecipientemail( join_addresses( i_to_addr, i_to_name ) )

// CCアドレスがあれば一つの文字列にまとめてからセット
if upperbound( i_cc_addr ) > 0 then
	smtp.setrecipientemail( join_addresses( i_cc_addr, i_cc_name ) )
end if

// BCCアドレスがあれば一つの文字列にまとめてからセット
if upperbound( i_bcc_addr ) > 0 then
	smtp.setrecipientemail( join_addresses( i_bcc_addr, i_bcc_name ) )
end if

// メッセージプロパティセット
smtp.setmessage( l_body, i_html )
smtp.setreadreceiptrequested( i_read_receipt )
smtp.setpriority( i_priority )

if l_attach <> "" then
	smtp.setattachment( l_attach )
end if
	
// メッセージIDセット
smtp.setheader( "Message-ID", "PowerBuilder-" + string( rand( 32767 ) ) )

// メール送信
l_ret = smtp.send()

destroy smtp

if l_ret = 1 then
	return true
else
	return false
end if

end function

private function string join_addresses (string p_addr[], string p_name[]);integer	l_idx
string	l_addresses

for l_idx = 1 to upperbound( p_addr )
	if len( l_addresses ) <> 0 then
		fnc.strg.of_append_line( l_addresses, ", ", false )
	end if

	fnc.strg.of_append_line( l_addresses, join_address( p_addr[l_idx], p_name[l_idx] ), false)

next

return l_addresses
end function

private function string join_address (string p_addr, string p_name);string	l_string

if trim( p_name ) = "" then
	l_string	= trim( p_addr )
else
	l_string	= DQUOTE + trim( p_name ) + DQUOTE + " <" + trim( p_addr ) + ">"
end if

return l_string
end function

private subroutine join_attachment (ref string p_outputstring, string p_newstring);if len( p_outputstring ) <> 0 then
	p_outputstring	= p_outputstring + ";" + trim( p_newstring )
else
	p_outputstring	= trim( p_newstring )
end if

end subroutine

public function boolean of_send_mail (string p_to_addr, string p_subject, string p_body);// Toアドレス、件名、本文

of_set_to( p_to_addr )
of_set_subject( p_subject )
of_set_body( p_body )

return sendmail( )
end function

public function boolean of_send_mail (string p_to_addr, string p_subject, string p_body, string p_attachment);// Toアドレス、件名、本文、添付ファイル
of_set_attachfile( p_attachment )

return of_send_mail( p_to_addr, p_subject, p_body )
end function

public subroutine of_init_settings (string p_userid, string p_password, string p_from_addr, string p_from_name);of_set_login( p_userid, p_password )
of_set_from( p_from_addr, p_from_name )
end subroutine

private function integer split_address (ref string p_addr, ref string p_name);return 0

end function

on nv_smtp.create
call super::create
end on

on nv_smtp.destroy
call super::destroy
end on

event constructor;call super::constructor;
// 初期値が設定されている変数を退避
i_init_html			= i_html
i_init_read_receipt	= i_read_receipt
i_init_priority		= i_priority
i_init_smtp_server	= i_smtp_server
i_init_port			= i_port
i_init_conn_type	= i_conn_type
i_init_auth			= i_auth
i_init_charset		= i_charset

end event

