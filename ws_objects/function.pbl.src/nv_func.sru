$PBExportHeader$nv_func.sru
$PBExportComments$共通ユーザー関数
forward
global type nv_func from inv_object
end type
type db from nv_dbfunc within nv_func
end type
type strg from nv_string within nv_func
end type
end forward

global type nv_func from inv_object autoinstantiate
db db
strg strg
end type

type prototypes
function	boolean	getcomputername( ref string cpname,ref ulong bfsize ) 													library "kernel32.dll" 	alias for "GetComputerNameA;ansi"

end prototypes

type variables
string	i_pgid
end variables

forward prototypes
public function string of_get_computer_name ()
public function boolean of_string2boolean (string p_boolean)
public function string of_get_filter (datawindow p_dw)
public function string of_get_number (string p_string)
public function string of_get_sort (datawindow p_dw)
public function string of_cnv_tilde (string p_text)
public subroutine of_set_filter (datawindow p_dw, string p_filter, boolean p_replace)
public function boolean of_chk_input_digit (string p_item_name, string p_text, integer p_byte_length, boolean p_empty, ref long p_answer, ref string p_message)
public function boolean of_chk_hankaku (string p_text)
public function boolean of_cnv_int2bool (integer p_boolean)
public function integer of_cnv_bool2int (boolean p_boolean)
public function long of_cnv_wareki (long p_date)
public subroutine of_set_sort (datawindow p_dw, string p_sort)
public function any of_decode (any p_value, any p_search, any p_true, any p_false)
public function any of_nvl (any p_value, any p_true)
public function boolean of_chk_column_info (string p_value, boolean p_nullable, string p_item_name, string p_table_name, string p_column_name, ref string p_message)
public function boolean of_chk_column_info (string p_value, string p_item_name, string p_table_name, string p_column_name, ref string p_messsage)
public function long of_power (integer p_value, integer p_index)
end prototypes

public function string of_get_computer_name ();// --------------------------------------------------------------------------
// Script:		nv_func.of_get_computer_name
// Purpose:		コンピュータ名を取得する
//
// Arguments:  
//
// Return:		string	自端末のコンピュータ名
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

ulong	l_bfsize	= 25
string	l_name		= space( l_bfsize + 1 )

if getcomputername( l_name, l_bfsize ) then
	l_name	= left( l_name, l_bfsize )
else
	l_name	= ""
end if

return l_name
end function

public function boolean of_string2boolean (string p_boolean);// --------------------------------------------------------------------------
// Script:     	nv_func.of_string2boolean
// Purpose:    	文字列の値をBoolean型に置き換える
//
// Arguments:  	p_boolean		- 文字列型の値
//
// Return:     	boolean
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

choose case upper(p_boolean)
	case "TRUE"
		return true
	case "FALSE"
		return false
	case else
		return false
end choose
end function

public function string of_get_filter (datawindow p_dw);// --------------------------------------------------------------------------
// Script:		nv_func.of_get_filter
// Purpose:		データウィンドウに設定されたフィルタ情報を取得する
//
// Arguments:	p_dw	- データウィンドウ名
// Return:		string	- 設定されたフィルタ情報
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_filter

l_filter	= p_dw.describe( "DataWindow.Table.filter" )

// フィルター条件未指定の場合は「?」が戻り値
if l_filter	= "?" then
	l_filter	= ""
end if

return l_filter

end function

public function string of_get_number (string p_string);// --------------------------------------------------------------------------
// Script:		nv_func.of_get_number
// Purpose:		文字列の中の数字のみ取り出す
//
// Arguments:	p_string	- 数字を取り出したい文字列
// Return:		string		- 取り出した数字 / "":失敗
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2012.08.20	Kin		Initial coding
// --------------------------------------------------------------------------

integer	i

string	l_string
string	l_char

l_string	= ""

for i = 1 to len( p_string )
	l_char	= mid( p_string, i, 1 )

	if isnumber( l_char ) then
		l_string	= l_string + l_char
	end if
next

if isnumber( l_string ) then
	return l_string
else
	return ""
end if
end function

public function string of_get_sort (datawindow p_dw);// --------------------------------------------------------------------------
// Script:		nv_func.of_get_sort
// Purpose:		データウィンドウに設定されたソート情報を取得する
//
// Arguments:	p_dw	- データウィンドウ名
// Return:		string	- 設定されたソート情報
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_sort

l_sort	= p_dw.describe( "DataWindow.Table.sort" )

// ソート条件未指定の場合は「?」が戻り値
if l_sort	= "?" then
	l_sort	= ""
end if

return l_sort

end function

public function string of_cnv_tilde (string p_text);// --------------------------------------------------------------------------
// Script:     	nv_func.of_conv_tilde
// Purpose:    	SJISからUNICODE変換時のチルダ(～)での誤変換を
//                正しいものに置き換える(PB10がUNICODEで扱うため姑息措置)
//
// Arguments:  	p_text		- 変換前文字列
//
// Return:     	string		- 変換後文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2012.04.25	Kin		Initial coding
// --------------------------------------------------------------------------

return strg.of_replace( p_text, char( 12316 ), char( -162 ) )
end function

public subroutine of_set_filter (datawindow p_dw, string p_filter, boolean p_replace);// --------------------------------------------------------------------------
// Script:		nv_func.of_set_filter
// Purpose:		データウィンドウにフィルタ情報をセットする
//
// Arguments:	p_dw	- データウィンドウ名
//        		p_filter	- フィルタ条件
//        		p_replace	- True:フィルタ条件を上書き / False:フィルタ条件を追記
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2018.01.26	kin		 Initial coding
// --------------------------------------------------------------------------

string	l_filter

if not p_replace then
	l_filter	= of_get_filter( p_dw )
	l_filter	= l_filter + p_filter
end if

p_dw.setfilter( p_filter )
p_dw.filter()
end subroutine

public function boolean of_chk_input_digit (string p_item_name, string p_text, integer p_byte_length, boolean p_empty, ref long p_answer, ref string p_message);// --------------------------------------------------------------------------
// Script:		nv_func.of_chk_input_digit
// Purpose:		入力された文字列が桁あふれしていないかチェックする
//
// Arguments:	p_item_name		- エラーがあった場合に表示する項目名（不要ならnullをセット）
// 				p_text			- チェックする文字列
// 				p_byte_length	- 入力可能桁数
// 				p_empty			- 未入力を許容するか否か（true:許容する）
// 				p_answer		- 文字列を数値に変換したもの
// 				p_messsage		- エラーの場合のメッセージ
//
// Return:		boolean
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.08.04	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_answer
string	l_error_msg
boolean	l_ret

p_text	= trim( p_text )

if lena( p_text ) > 0 then
	if isnumber( p_text ) then
		if lena( p_text ) <= p_byte_length then
			l_answer	= long( p_text )
			l_ret		= true
		else
			if not isnull( p_item_name ) then
				p_message	= p_item_name + "は、" + string( p_byte_length ) + "桁入力可能です。（入力値：" + string( lena( p_text ) ) + "桁）"
			else
				p_message	= string( p_byte_length ) + "桁入力可能です。（入力値：" + string( lena( p_text ) ) + "桁）"
			end if
			l_ret	= false
		end if
	else
		if not isnull( p_item_name ) then
			p_message	= p_item_name + "は、数値のみ入力可能です。"
		else
			p_message	= "数値のみ入力可能です。"
		end if
		l_ret	= false
	end if
else
	if not p_empty then
		if not isnull( p_item_name ) then
			p_message	= p_item_name + "は、値が入力されていません。"
		else
			p_message	= "値が入力されていません。"
		end if
		l_ret	= false
	else
		setnull( l_answer )
		l_ret	= true
	end if
end if

if l_ret then
	p_answer	= l_answer
end if

return l_ret

end function

public function boolean of_chk_hankaku (string p_text);
integer	l_len
integer	l_lena

l_len	= len( p_text )
l_lena	= lena( p_text )

if l_len <> l_lena then
	return false
end if

return true

end function

public function boolean of_cnv_int2bool (integer p_boolean);// --------------------------------------------------------------------------
// Script:     	nv_func.of_cnv_int2bool
// Purpose:    	数値の値をBoolean型に置き換える
//
// Arguments:  	p_boolean		- 数値型の値(0:False 0以外:True)
//
// Return:     	boolean
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.11.17	Kin		Initial coding
// --------------------------------------------------------------------------

if p_boolean = 0 then
	return False
else
	return True
end if

end function

public function integer of_cnv_bool2int (boolean p_boolean);// --------------------------------------------------------------------------
// Script:     	nv_func.of_boolean2integer
// Purpose:    	Boolean型の値を数値の値に置き換える
//
// Arguments:  	p_boolean		- Boolean型の値
//
// Return:     	integer(0:False 0以外:True)
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.11.17	Kin		Initial coding
// --------------------------------------------------------------------------

if p_boolean then
	return 1
else
	return 0
end if

end function

public function long of_cnv_wareki (long p_date);// --------------------------------------------------------------------------
// Script:		nv_func.of_cnv_wareki
// Purpose:		指定された文字列を和暦に変換する
//
// Arguments:	p_date	- 変換したい西暦日付
// Return:		long	- 和暦日付
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

long	l_date
long	l_nentuki,l_nen,l_tukihi

choose case len( string( p_date ) )
	case 4
	case else
end choose

l_nentuki	= truncate( p_date / 100, 0 )
l_nen		= truncate( p_date / 10000, 0 )
l_tukihi	= p_date - truncate( p_date / 10000, 0 ) * 10000

choose case p_date
	case is >= 20190501	// 令和
		l_nen	= l_nen - 2018
	case is >= 19890108	// 平成
		l_nen	= l_nen - 1988
	case is >= 19261225	// 昭和
		l_nen	= l_nen - 1925
	case else
		l_nen	= l_nen - truncate( l_nen / 100, 0 ) * 100
end choose

l_date	= l_nen * 10000 + l_tukihi

return l_date

end function

public subroutine of_set_sort (datawindow p_dw, string p_sort);// --------------------------------------------------------------------------
// Script:		nv_func.of_set_sort
// Purpose:		データウィンドウのソート情報をセットする
//
// Arguments:	p_dw	- データウィンドウ名
//         		p_sort	- ソート情報
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2018.01.26	kin		 Initial coding
// --------------------------------------------------------------------------

p_dw.setsort( p_sort )
p_dw.sort()

end subroutine

public function any of_decode (any p_value, any p_search, any p_true, any p_false);if p_value = p_search then
	return p_true
else
	return p_false
end if

end function

public function any of_nvl (any p_value, any p_true);if isnull( p_value ) then
	return p_true
else
	return p_value
end if

end function

public function boolean of_chk_column_info (string p_value, boolean p_nullable, string p_item_name, string p_table_name, string p_column_name, ref string p_message);
// --------------------------------------------------------------------------
// Script:		nv_func.of_chk_column_info
// Purpose:		入力された値がテーブルに対して適正かどうかのチェックを行う
//				エラー時のメッセージ作成も行う
//
// Arguments:	p_value					- チェックする値
// 				p_nullable				- True：未入力(null)を許容する　False：未入力(null)を許容しない
//				p_item_name				- エラーがあった場合に表示する項目名（不要ならnullをセット）
// 				p_table_name			- チェックする対象のテーブル名
// 				p_column_name			- チェックする対象のカラム名
// 				(ref) p_messsage		- エラーの場合のメッセージ
//
// Return:		boolean					- True：チェック問題なし　False：チェックに失敗
//
// Date			Prog/ID		Description of Change / Reason
// ----------	----------	-------------------------------------------------
// 2024.07.05	H.Yamamoto	Initial coding
// --------------------------------------------------------------------------

string	l_value, l_item_name
string	l_column_type
decimal	l_column_length

l_value		= trim( p_value )
l_item_name	= trim( p_item_name )

// nullの許容チェック
if not p_nullable then
	if isnull( l_value ) or len( l_value ) = 0 then
		if isnull( l_item_name ) or len( l_item_name ) = 0 then
			p_message	= "値が入力されていません。"
		else
			p_message	= l_item_name + "が、入力されていません。"
		end if
		
		return false
	end if
else
	// 値が未入力の場合は何もせずにreturnする
	if lena( l_value ) <= 0 then
		// 一応メッセージは作成する
		if isnull( l_item_name ) or len( l_item_name ) = 0 then
			p_message	= "値が入力されていません。"
		else
			p_message	= l_item_name + "が、入力されていません。"
		end if
		
		return true
	end if
end if

// 型チェックと桁数チェックを行うため、カラム情報を取得
if not fnc.db.of_get_column_info( p_table_name, p_column_name, l_column_type, l_column_length ) then
	if isnull( l_item_name ) or len( l_item_name ) = 0 then
		p_message	= "値のカラム情報が取得できません。"
	else
		p_message	= l_item_name + "のカラム情報を取得できません。"
	end if
	
	return false
end if

// 型チェック
// ※一旦は数値チェックのみの簡易的なチェックとする 必要になったら追加する
choose case l_column_type
	case "NUMBER"
		if not isnumber( l_value ) then
			if isnull( l_item_name ) or len( l_item_name ) = 0 then
				p_message	= "値が数値ではありません。"
			else
				p_message	= l_item_name + "は、数値ではありません。"
			end if
			
			return false
		end if
		
		// 小数点のチェックは一旦なし 必要になったら追加する
	case else
		// 何もしない
end choose

// 桁数チェック
choose case l_column_type
	case "NUMBER"
		integer	l_idx
		string	l_part[]
		long	l_power
		string	l_bkvalue

		l_bkvalue	= l_value

		// l_column_lengthを小数点で分割して配列に格納
		l_part		= fnc.strg.of_split( string( l_column_length ), "." )

		if upperbound( l_part ) > 1 then
			// 小数部があるなら詳細チェック
			l_power	= fnc.of_power( 10, long( l_part[2] ) )
			l_value	= string( truncate( round( dec( l_value ) * l_power, 0 ) / l_power, 0 ) )
		end if
		
		// 配列の１番目（整数部）桁数と値の長さをチェック
		if lena( l_value ) > long( l_part[1] ) then
			if isnull( l_item_name ) or len( l_item_name ) = 0 then
				p_message	= "値は" + string( l_column_length ) + "桁入力可能です。（入力値：" + l_bkvalue + "）"
			else
				p_message	= l_item_name + "は、" + string( l_column_length ) + "桁入力可能です。（入力値：" + l_bkvalue + "）"
			end if
			
			return false
		end if
	case else
		if lena( l_value ) > l_column_length then
			if isnull( l_item_name ) or len( l_item_name ) = 0 then
				p_message	= "値は" + string( l_column_length ) + "桁入力可能です。（入力値：" + string( lena( l_value ) ) + "桁）"
			else
				p_message	= l_item_name + "は、" + string( l_column_length ) + "桁入力可能です。（入力値：" + string( lena( l_value ) ) + "桁）"
			end if
			
			return false
		end if
end choose

return true
end function

public function boolean of_chk_column_info (string p_value, string p_item_name, string p_table_name, string p_column_name, ref string p_messsage);
// --------------------------------------------------------------------------
// Script:		nv_func.of_chk_column_info
// Purpose:		入力された値がテーブルに対して適正かどうかのチェックを行う(nullを許容しない)
//				エラー時のメッセージ作成も行う
//
// Arguments:	p_value					- チェックする値
//				p_item_name				- エラーがあった場合に表示する項目名（不要ならnullをセット）
// 				p_table_name			- チェックする対象のテーブル名
// 				p_column_name			- チェックする対象のカラム名
// 				(ref) p_messsage		- エラーの場合のメッセージ
//
// Return:		boolean					- True：チェック問題なし　False：チェックに失敗
//
// Date			Prog/ID		Description of Change / Reason
// ----------	----------	-------------------------------------------------
// 2024.07.05	H.Yamamoto	Initial coding
// --------------------------------------------------------------------------

return of_chk_column_info( p_value, false, p_item_name, p_table_name, p_column_name, p_messsage )
end function

public function long of_power (integer p_value, integer p_index);
long	l_value
integer	l_cnt

l_value	= p_value

for l_cnt = 2 to p_index
	l_value	= l_value * p_value
next

return l_value

end function

on nv_func.create
call super::create
this.db=create db
this.strg=create strg
end on

on nv_func.destroy
call super::destroy
destroy(this.db)
destroy(this.strg)
end on

type db from nv_dbfunc within nv_func descriptor "pb_nvo" = "true" 
end type

on db.create
call super::create
end on

on db.destroy
call super::destroy
end on

type strg from nv_string within nv_func descriptor "pb_nvo" = "true" 
event create ( )
event destroy ( )
end type

on strg.create
call super::create
end on

on strg.destroy
call super::destroy
end on

