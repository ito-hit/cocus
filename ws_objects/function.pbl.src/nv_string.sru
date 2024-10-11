$PBExportHeader$nv_string.sru
$PBExportComments$文字列操作関数
forward
global type nv_string from inv_object
end type
end forward

global type nv_string from inv_object
end type
global nv_string nv_string

type prototypes
function	boolean	getcomputername( ref string cpname,ref ulong bfsize ) 													library "kernel32.dll" 	alias for "GetComputerNameA;ansi"

end prototypes

type variables

end variables

forward prototypes
public function any of_split (string p_text, string p_mark)
public function string of_replace (string p_reptext, string p_repold, string p_repnew)
public function string of_join (string p_array[], string p_mark, boolean p_trim)
public function string of_substr (string p_text, string p_start, string p_end)
public function integer of_append_line (ref string p_parent, string p_text)
public function integer of_append_line (ref string p_parent, string p_text, boolean p_crlf)
public function string of_extract (string p_text, string p_pattern, string p_target)
public function string of_format (string p_text, string p_replace)
public function string of_format (string p_text, string p_replace[])
public function string of_format (string p_text, string p_replace1, string p_replace2)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6, string p_replace7)
public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6, string p_replace7, string p_replace8)
public function string of_join (string p_array[], string p_mark)
end prototypes

public function any of_split (string p_text, string p_mark);// --------------------------------------------------------------------------
// Script:		of_split
// Purpose:		文字列の内容を配列に分割する
//
// Arguments:	p_text	- 分割する文字列
//				p_mark	- 文字列の内容を分割する際の連結文字列
//
// Return:		any	文字列型の配列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_string[]
any		l_any
string	l_midstr

int	i,l_pos

i = 1

// 最初と最後に分割文字が存在する場合は削除 //
if pos( p_text, p_mark ) = 1 then
	p_text	= mid( p_text, len( p_mark ) + 1 )
end if
if right( p_text, len( p_mark ) ) = p_mark then
	p_text	= left( p_text, len( p_text ) - len( p_mark ) )
end if

setnull( l_pos )

do until l_pos = 0
	l_pos	= pos( p_text, p_mark )
	if l_pos <> 0 then
		l_midstr	= left( p_text, l_pos - 1 )
		p_text		= mid( p_text, l_pos + len( p_mark ) )
	else
		l_midstr	= p_text
	end if
	l_string[i]	= l_midstr
	i++
loop

l_any	= l_string

return l_any

end function

public function string of_replace (string p_reptext, string p_repold, string p_repnew);// --------------------------------------------------------------------------
// Script:     	of_replace
// Purpose:    	指定した文字列に置換する
//
// Arguments:  	p_reptext	- 置換を行う文字列
//			   	p_repold		- 置換前文字列
//			   	p_repnew		- 置換後文字列
//
// Return:     	string	置換した結果の文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

long	l_repstartpos
string	l_reptext,l_repold,l_repnew

l_reptext		= p_reptext
l_repnew		= p_repnew
l_repold		= p_repold

l_repstartpos	= 1
l_repstartpos	= pos( l_reptext, l_repold )

do while l_repstartpos > 0
    l_reptext 		= replace( l_reptext, l_repstartpos, len( l_repold ), l_repnew )
    l_repstartpos	= pos( l_reptext, l_repold, l_repstartpos + len( l_repnew ) )
loop

return( l_reptext )

end function

public function string of_join (string p_array[], string p_mark, boolean p_trim);// --------------------------------------------------------------------------
// Script:		of_join
// Purpose:		配列の内容をとして結合する
//
// Arguments:	p_array[]	- 文字列型の配列
//			   	p_mark		- 配列の内容を結合する際の連結文字列
//			   	p_trim		- 配列内の文字の空白削除実行
//
// Return:     	string		- 結合文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_array[]
string	l_string
int		i

l_array	= p_array[]

// p_trim = "True" の場合各配列内の値にトリムをする //
if p_trim then
	for i = 1 to upperbound(l_array)
		l_array[i]	= trim(l_array[i])
	next
end if

for i = 1 to upperbound(l_array)
	l_string	= l_string + l_array[i] + p_mark
next

l_string	= mid( l_string, 1, len( l_string ) - len( p_mark ) )

return l_string

end function

public function string of_substr (string p_text, string p_start, string p_end);// --------------------------------------------------------------------------
// Script:     	nv_string.of_substr
// Purpose:    	指定された文字列間の値を取得する
//
// Arguments:  	p_text			- 値を得る元データ
//			   	p_start			- 開始文字列
//			   	p_end			- 終了文字列
//
// Return:     	string	取得文字列
// 				※文字列が片方しか設定されていない場合
//				　p_startのみの場合、文字列の最初からp_startの最後の文字までを返す。
//				　p_endのみの場合、p_endの最初の文字から文字列の最後までを返す。
//				　両方入力されていない場合は渡された元データをそのまま返す
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_string

int	l_s_pos

if isnull(p_start) or p_start = "" then
	if isnull(p_end) or p_end = "" then
		// 両方未入力の場合 //
		l_string	= p_text
	else
		// p_endのみ入力された場合 //
		l_s_pos	= pos( p_text, p_end )

		if l_s_pos	<> 0 then
			l_string	= mid( p_text, l_s_pos )
		else
			l_string	= ""
		end if
	end if
else
	if isnull(p_end) or p_end = "" then
		// p_startのみ入力された場合 //
		l_s_pos	= pos( p_text, p_start )

		if l_s_pos	<> 0 then
			l_string	= left( p_text, l_s_pos + len( p_start ) - 1 )
		else
			l_string	= p_text
		end if
	else
		// 両方入力された場合 //
		l_s_pos	= pos( p_text, p_start )

		if l_s_pos <> 0 then
			l_string	= mid( p_text, l_s_pos + len( p_start ) )
		end if

		l_string	= left( l_string, pos( l_string, p_end ) - 1 )
	end if
end if

return l_string

end function

public function integer of_append_line (ref string p_parent, string p_text);// --------------------------------------------------------------------------
// Script:     	of_append_line
// Purpose:    	文字列を連結する
//
// Arguments:  	p_parent(ref)	- 元の文字列
//			   	p_text			- 元の文字列に連結したい文字列
//
// Return:     	integer	連結後の文字数
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

return of_append_line( p_parent, p_text, true )

end function

public function integer of_append_line (ref string p_parent, string p_text, boolean p_crlf);// --------------------------------------------------------------------------
// Script:     	of_append_line
// Purpose:    	文字列を連結する
//
// Arguments:  	p_parent(ref)	- 元の文字列
//			   	p_text			- 元の文字列に連結したい文字列
//			   	p_crlf			- True:連結部に改行コード入れる / False:入れない
//
// Return:     	integer	連結後の文字数
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

constant string	l_crlf	= "~r~n"

if p_crlf then
	p_parent	= p_parent + l_crlf
end if

p_parent	= p_parent + p_text

return len( p_parent )

end function

public function string of_extract (string p_text, string p_pattern, string p_target);// --------------------------------------------------------------------------
// Script:     	of_extract
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		：ベースの文字列
// 				p_pattern	：抽出したい部分が含まれるパターン
// 				p_target	：パターンに含まれる抽出部の文字列
//
// Return:     	string	抽出された文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2021.11.23	Kin		Initial coding
// --------------------------------------------------------------------------
// 
// 
string	l_text
string	l_patterns[]
integer	l_start_pos,l_end_pos

l_patterns	= of_split( p_pattern, p_target )

if upperbound( l_patterns ) > 0 then
	if pos( p_pattern, p_target ) = 1 then
		l_end_pos	= pos( p_text, l_patterns[1] ) - 1
	else
		l_start_pos	= pos( p_text, l_patterns[1] ) + len( l_patterns[1] )
	
	
		if upperbound( l_patterns ) > 1 then
			l_end_pos	= pos( p_text, l_patterns[2] ) - l_start_pos
		else
			l_end_pos	= len( p_text ) 
		end if
	end if
end if

l_text	= mid( p_text, l_start_pos, l_end_pos )


return l_text
end function

public function string of_format (string p_text, string p_replace);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace	- {1}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace[]);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace	- {1}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

integer	l_row
string	l_text

l_text	= p_text

for l_row = 1 to upperbound( p_replace )
 	l_text	= of_replace( l_text, "{" + string( l_row ) + "}", p_replace[l_row] )
next

return l_text

end function

public function string of_format (string p_text, string p_replace1, string p_replace2);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列		
//	
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列		
//			   	p_replace3	- {3}に埋込みたい文字列
//	
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列
//			   	p_replace3	- {3}に埋込みたい文字列
//			   	p_replace4	- {4}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3
l_replace[4]	= p_replace4

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列
//			   	p_replace3	- {3}に埋込みたい文字列
//			   	p_replace4	- {4}に埋込みたい文字列
//			   	p_replace5	- {5}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3
l_replace[4]	= p_replace4
l_replace[5]	= p_replace5

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列
//			   	p_replace3	- {3}に埋込みたい文字列
//			   	p_replace4	- {4}に埋込みたい文字列
//			   	p_replace5	- {5}に埋込みたい文字列
//			   	p_replace6	- {6}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3
l_replace[4]	= p_replace4
l_replace[5]	= p_replace5
l_replace[6]	= p_replace6

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6, string p_replace7);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列
//			   	p_replace3	- {3}に埋込みたい文字列
//			   	p_replace4	- {4}に埋込みたい文字列
//			   	p_replace5	- {5}に埋込みたい文字列
//			   	p_replace6	- {6}に埋込みたい文字列
//			   	p_replace7	- {7}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3
l_replace[4]	= p_replace4
l_replace[5]	= p_replace5
l_replace[6]	= p_replace6
l_replace[7]	= p_replace7

return of_format( p_text, l_replace )

end function

public function string of_format (string p_text, string p_replace1, string p_replace2, string p_replace3, string p_replace4, string p_replace5, string p_replace6, string p_replace7, string p_replace8);// --------------------------------------------------------------------------
// Script:     	of_format
// Purpose:    	文字列を指定箇所に埋込む
//
// Arguments:  	p_text		- 元の文字列
//			   	p_replace1	- {1}に埋込みたい文字列
//			   	p_replace2	- {2}に埋込みたい文字列
//			   	p_replace3	- {3}に埋込みたい文字列
//			   	p_replace4	- {4}に埋込みたい文字列
//			   	p_replace5	- {5}に埋込みたい文字列
//			   	p_replace6	- {6}に埋込みたい文字列
//			   	p_replace7	- {7}に埋込みたい文字列
//			   	p_replace8	- {8}に埋込みたい文字列
//
// Return:     	string	埋込ができた文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

string	l_replace[]

l_replace[1]	= p_replace1
l_replace[2]	= p_replace2
l_replace[3]	= p_replace3
l_replace[4]	= p_replace4
l_replace[5]	= p_replace5
l_replace[6]	= p_replace6
l_replace[7]	= p_replace7
l_replace[8]	= p_replace8

return of_format( p_text, l_replace )

end function

public function string of_join (string p_array[], string p_mark);
return of_join( p_array, p_mark, false )
end function

on nv_string.create
call super::create
end on

on nv_string.destroy
call super::destroy
end on

