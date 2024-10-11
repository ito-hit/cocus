$PBExportHeader$nv_fmodal.sru
$PBExportComments$ファイル開閉モーダル関数
forward
global type nv_fmodal from inv_object
end type
type lstr_filetime from structure within nv_fmodal
end type
type lstr_file from structure within nv_fmodal
end type
end forward

type lstr_filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type lstr_file from structure
	unsignedlong		dwfileattributes
	lstr_filetime		ftcreationtime
	lstr_filetime		ftlastaccesstime
	lstr_filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

global type nv_fmodal from inv_object
end type
global nv_fmodal nv_fmodal

type prototypes
function long		findfirstfile( ref string filename, ref lstr_file findfiledata )	library "kernel32.dll"	alias for "FindFirstFileW"
function boolean	findnextfile( ulong handle, ref lstr_file findfiledata )			library "kernel32.dll"	alias for "FindNextFileW"
function boolean	findclose( ulong handle )											library "kernel32.dll"	alias for "FindClose"
	
end prototypes

type variables
private string		i_init_open_dir		// 初期オープンフォルダ（未指定の既定） ※constructorで
private string		i_file_filter		// ファイル拡張子文字列

// ファイル拡張子指定
private constant string		C_FILE_EXT_GRAPH		= "画像ファイル(*.bmp;*.emf;*.gif;*.jpg;*.png;*.tif;*.wmf), *.bmp;*.emf;*.gif;*.jpg;*.png;*.tif;*.wmf"
private constant string		C_FILE_EXT_PDF			= "PDFファイル(*.pdf), *.pdf"
private constant string		C_FILE_EXT_PPOINT		= "PowerPointファイル(*.ppt;*.pptm;*.pptx), *.ppt;*.pptm;*.pptx"
private constant string		C_FILE_EXT_EXCEL		= "Excelファイル(*.xlsx;*.xlsm;*.xls), *.xlsx;*.xlsm;*.xls"
private constant string		C_FILE_EXT_WORD			= "Wordファイル(*.doc;*.docm;*.docx), *.doc;*.docm;*.docx"
private constant string		C_FILE_EXT_TEXT			= "テキストファイル (*.txt;*.csv), *.txt;*.csv"
private constant string		C_FILE_EXT_ALL			= "すべてのファイル(*.*), *.*"

// GetFile～関数のフラグオプション
private constant long		C_OFN_CREATEPROMPT		= 1		// 指定されたファイルが存在しない場合、ファイルを作成するかどうかを確認するメッセージを表示します。
private constant long		C_OFN_EXPLORER			= 2		// エクスプローラ形式のダイアログボックスを使用します。
private constant long		C_OFN_NOTESTFILECREATE	= 2048	// ダイアログボックスが閉じられるまでファイルを作成しません。
private constant long		C_OFN_OVERWRITEPROMPT	= 8192	// 名前を付けて保存ダイアログボックスで使用します。
private constant long		C_OFN_READONLY			= 32768	// 保存ダイアログボックスが作成されたときに［読み取り専用］チェックボックスをオンにします。

// フラグオプションの有効／無効設定（外部から変更可）
boolean	i_ofn_createprompt			= false
boolean	i_ofn_explorer				= true
boolean	i_ofn_notestfilecreate		= true
boolean	i_ofn_overwriteprompt		= true
boolean	i_ofn_readonly				= false

// 拡張子パターン
private constant integer	C_EXT_PTTN_GRAPH		= 1	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_PDF			= 2	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_PPOINT		= 3	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_SPDSHEET		= 4	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_EXCEL		= 5	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_WORD			= 6	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_TEXT			= 7	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_ALL			= 8	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない
private constant integer	C_EXT_PTTN_SPECIAL		= 9	// 拡張子を識別するためのコード（set_ext_patternで使用）※順番ではない

// saveasタイプ
constant saveastype	C_SAT_TEXT		= text!
constant saveastype	C_SAT_CSV		= csv!
constant saveastype	C_SAT_SQL		= sqlinsert!
constant saveastype	C_SAT_XML		= xml!
constant saveastype	C_SAT_PDF		= pdf!
constant saveastype	C_SAT_XLSX		= xlsx!
constant saveastype	C_SAT_XLS		= excel8!

end variables

forward prototypes
public subroutine of_set_extension (integer p_graph, integer p_pdf, integer p_ppoint, integer p_excel, integer p_word, integer p_text, integer p_all)
private function unsignedlong get_modal_attribute ()
public function boolean of_open_load_file (ref string p_path, ref string p_file)
public function boolean of_open_load_excel (ref string p_path, ref string p_file)
public function boolean of_open_load_pdf (ref string p_path, ref string p_file)
public function boolean of_open_load_spreadsheet (ref string p_path, ref string p_file)
public function boolean of_open_load_text (ref string p_path, ref string p_file)
public function boolean of_open_load_files (ref string p_path, ref string p_files[])
public function boolean of_open_load_excels (ref string p_path, ref string p_files[])
public function boolean of_open_load_graph (ref string p_path, ref string p_file)
public function boolean of_open_load_graphs (ref string p_path, ref string p_files[])
public function boolean of_open_load_pdfs (ref string p_path, ref string p_files[])
public function boolean of_open_load_spreadsheets (ref string p_path, ref string p_files[])
public function boolean of_open_load_texts (ref string p_path, ref string p_files[])
public function boolean of_open_save_datawindow (ref string p_path, ref string p_file, ref saveastype p_type)
public function boolean of_open_save_file (ref string p_path, ref string p_file, ref string p_extension)
private subroutine set_ext_pattern (integer p_pattern)
end prototypes

public subroutine of_set_extension (integer p_graph, integer p_pdf, integer p_ppoint, integer p_excel, integer p_word, integer p_text, integer p_all);
// 0:拡張子を表示しない 0以外:表示順
integer	l_row
string	l_extensions[]

i_file_filter	= ""

if p_graph <> 0 then
	l_extensions[p_graph]	= C_FILE_EXT_GRAPH
end if

if p_pdf <> 0 then
	l_extensions[p_pdf]		= C_FILE_EXT_PDF
end if

if p_ppoint <> 0 then
	l_extensions[p_ppoint]	= C_FILE_EXT_PPOINT
end if

if p_excel <> 0 then
	l_extensions[p_excel]	= C_FILE_EXT_EXCEL
end if

if p_word <> 0 then
	l_extensions[p_word]	= C_FILE_EXT_WORD
end if

if p_text <> 0 then
	l_extensions[p_text]	= C_FILE_EXT_TEXT
end if

if p_all <> 0 then
	l_extensions[p_all]		= C_FILE_EXT_ALL
end if

for l_row = 1 to upperbound( l_extensions )
	if len( l_extensions[l_row] ) > 0 then
		// 既に文字列がセット済みなら仕切り文字（カンマ）をセットする
		if len( i_file_filter ) > 0 then
			i_file_filter	= fnc.strg.of_format( "{1}{2}", i_file_filter, "," )
		end if
		
		//拡張子情報をセット
		i_file_filter	= fnc.strg.of_format( "{1}{2}", i_file_filter, l_extensions[l_row] )
	end if
next

end subroutine

private function unsignedlong get_modal_attribute ();unsignedlong	l_attr

l_attr	= 0

if i_ofn_createprompt then
	l_attr	= l_attr + C_OFN_CREATEPROMPT
end if

if i_ofn_explorer then
	l_attr	= l_attr + C_OFN_EXPLORER
end if

if i_ofn_notestfilecreate then
	l_attr	= l_attr + C_OFN_NOTESTFILECREATE
end if

if i_ofn_overwriteprompt then
	l_attr	= l_attr + C_OFN_OVERWRITEPROMPT
end if

if i_ofn_readonly then
	l_attr	= l_attr + C_OFN_READONLY
end if

return l_attr
end function

public function boolean of_open_load_file (ref string p_path, ref string p_file);
/*
	p_path : in	→初期オープンフォルダ（中身がなければ既定フォルダ）
	         out→開いたフォルダ
*/
integer	l_ret
string	l_def_path, l_path, l_file

if len( p_path ) > 0 then
	l_def_path	= p_path
else
	l_def_path	= i_init_open_dir
end if

if getfileopenname( "ファイルの選択", l_path, l_file, "", i_file_filter, l_def_path, get_modal_attribute() ) <> 1 then
	return false
end if

p_file	= mid( l_path, lastpos( l_path, "\" ) + 1 )
p_path	= left( l_path, pos( l_path, p_file ) - 2 )

return true
end function

public function boolean of_open_load_excel (ref string p_path, ref string p_file);// 「Excelファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_EXCEL )

return of_open_load_file( p_path, p_file )

end function

public function boolean of_open_load_pdf (ref string p_path, ref string p_file);// 「PDFファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_PDF )

return of_open_load_file( p_path, p_file )

end function

public function boolean of_open_load_spreadsheet (ref string p_path, ref string p_file);// 「Excelファイル」「テキストファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_SPDSHEET )

return of_open_load_file( p_path, p_file )

end function

public function boolean of_open_load_text (ref string p_path, ref string p_file);// 「テキストファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_TEXT )

return of_open_load_file( p_path, p_file )

end function

public function boolean of_open_load_files (ref string p_path, ref string p_files[]);/*
	p_path : in	→初期オープンフォルダ（中身がなければ既定フォルダ）
	         out→開いたフォルダ
*/

string	l_def_path

if len( p_path ) > 0 then
	l_def_path	= p_path
else
	l_def_path	= i_init_open_dir
end if

if getfileopenname( "ファイルの選択【複数】", p_path, p_files, "", i_file_filter, l_def_path, get_modal_attribute() ) <> 1 then
	return false
end if

return true
end function

public function boolean of_open_load_excels (ref string p_path, ref string p_files[]);// 「Excelファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_EXCEL )

return of_open_load_files( p_path, p_files[] )

end function

public function boolean of_open_load_graph (ref string p_path, ref string p_file);// 「画像ファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_GRAPH )

return of_open_load_file( p_path, p_file )

end function

public function boolean of_open_load_graphs (ref string p_path, ref string p_files[]);// 「画像ファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_GRAPH )

return of_open_load_files( p_path, p_files[] )

end function

public function boolean of_open_load_pdfs (ref string p_path, ref string p_files[]);// 「PDFファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_PDF )

return of_open_load_files( p_path, p_files )
end function

public function boolean of_open_load_spreadsheets (ref string p_path, ref string p_files[]);// 「Excelファイル」「テキストファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_SPDSHEET )

return of_open_load_files( p_path, p_files[] )

end function

public function boolean of_open_load_texts (ref string p_path, ref string p_files[]);// 「テキストファイル」「すべてのファイル」の順で表示
set_ext_pattern( C_EXT_PTTN_TEXT )

return of_open_load_files( p_path, p_files[] )

end function

public function boolean of_open_save_datawindow (ref string p_path, ref string p_file, ref saveastype p_type);
// ファイルタイプ
constant string	C_DWSA_TEXT	= "テキストファイル(*.txt), *.txt"
constant string	C_DWSA_CSV	= "CSVファイル(*.csv), *.csv"
constant string	C_DWSA_SQL	= "SQLファイル(*.sql), *.sql"
constant string	C_DWSA_XML	= "XMLファイル(*.xml), *.xml"
constant string	C_DWSA_PDF	= "PDFファイル(*.pdf), *.pdf"
constant string	C_DWSA_XLSX	= "Excelファイル(*.xlsx), *.xlsx"
constant string	C_DWSA_XLS	= "旧Excelファイル(*.xls), *.xls"
constant string	C_DWSA_ALL	= "すべてのファイル(*.*), *.*"
//constant string	C_DWSA_CLP	= "クリップボード (*.*),*.*"

// ファイル拡張子
constant string	C_EXT_TXT	= "txt"
constant string	C_EXT_CSV	= "csv"
constant string	C_EXT_SQL	= "sql"
constant string	C_EXT_XML	= "xml"
constant string	C_EXT_PDF	= "pdf"
constant string	C_EXT_XLSX	= "xlsx"
constant string	C_EXT_XLS	= "xls"
//constant string	C_EXT_CLP	= ""


boolean	l_assign
string	l_filter
string	l_extension
string	l_dummy

string	l_def_path, l_path, l_file

if len( p_path ) > 0 then
	l_def_path	= p_path
else
	l_def_path	= i_init_open_dir
end if

if isnull( p_type ) then
	// 未指定ならこちら側で形式を選択させる
	l_assign	= false
	
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", "", C_DWSA_TEXT ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_CSV ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_SQL ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_XML ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_PDF ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_XLSX ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_XLS ), false )
//	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_CLP ), false )
	fnc.strg.of_append_line( l_filter, fnc.strg.of_format( "{1}{2}", ",", C_DWSA_ALL ), false )
else
	// 指定があるならその形式のみで
	l_assign	= true

	choose case p_type
		case text!		// text
			l_filter	= C_DWSA_TEXT
			l_extension	= C_EXT_TXT
		case csv!		// csv
			l_filter	= C_DWSA_CSV
			l_extension	= C_EXT_CSV
		case sqlinsert!	// sql
			l_filter	= C_DWSA_SQL
			l_extension	= C_EXT_SQL
		case xml!		// xml
			l_filter	= C_DWSA_XML
			l_extension	= C_EXT_XML
		case pdf!		// pdf
			l_filter	= C_DWSA_PDF
			l_extension	= C_EXT_PDF
		case xlsx!		// excel
			l_filter	= C_DWSA_XLSX
			l_extension	= C_EXT_XLSX
		case excel8!	// 旧excel
			l_filter	= C_DWSA_XLS
			l_extension	= C_EXT_XLS
//		case clipboard!	// clipboard
//			l_filter	= C_DWSA_CLP
//			l_extension	= C_EXT_CLP
		case else
			l_filter	= C_DWSA_ALL
			l_extension	= ""
	end choose
end if

// p_fileに値があればファイル名の初期設定として表示できるようにする
if len( p_file ) > 0 then
	p_path		= fnc.strg.of_format( "{1}\{2}", p_path, p_file )
end if


// ファイル選択
if getfilesavename( "ファイルの選択", p_path, p_file, l_extension, l_filter, l_def_path, get_modal_attribute() ) <> 1 Then
	return false
end if

if not l_assign then
	choose case lower( mid( p_path, lastpos( p_path, "." ) + 1 ) )
		case "txt"
			p_type	= text!
		case "csv"
			p_type	= csv!
		case "sql"
			p_type	= sqlinsert!
		case "xml"
			p_type	= xml!
		case "pdf"
			p_type	= pdf!
		case "xlsx"
			p_type	= xlsx!
		case "xls"
			p_type	= excel8!
		case else
			// よくわからんのはテキストに
			p_type	= text!
	end choose
end if

p_file	= mid( p_path, lastpos( p_path, "\" ) + 1 )
p_path	= left( p_path, pos( p_path, p_file ) - 2 )

return true

end function

public function boolean of_open_save_file (ref string p_path, ref string p_file, ref string p_extension);
/*
	p_path : in	→初期オープンフォルダ（中身がなければ既定フォルダ）
	         out→開いたフォルダ
	p_file : in →初期のファイル名を入れておけば拡張子で絞り込み
*/
integer	l_ret
string	l_def_path, l_path, l_file

if len( p_path ) > 0 then
	l_def_path	= p_path
else
	l_def_path	= i_init_open_dir
end if

// 渡されたファイル名で拡張子を探る
if len( p_file ) > 0 then
	p_extension	= lower( mid( p_file, lastpos( p_file, "." ) + 1 ) )
	p_path		= fnc.strg.of_format( "{1}\{2}", p_path, p_file )
else
	p_extension	= lower( mid( p_path, lastpos( p_path, "." ) + 1 ) )
end if

choose case p_extension
	case "bmp", "emf", "gif", "jpg", "png", "tif", "wmf"
		set_ext_pattern( C_EXT_PTTN_GRAPH )
	case "pdf"
		set_ext_pattern( C_EXT_PTTN_PDF )
	case "ppt", "pptm", "pptx"
		set_ext_pattern( C_EXT_PTTN_PPOINT  )
	case "xlsx", "xlsm", "xls"
		set_ext_pattern( C_EXT_PTTN_EXCEL )
	case "doc", "docm", "docx"
		set_ext_pattern( C_EXT_PTTN_WORD )
	case "txt", "csv"
		set_ext_pattern( C_EXT_PTTN_TEXT )
	case else
		set_ext_pattern( C_EXT_PTTN_ALL )
end choose

// ファイル選択
if getfilesavename( "ファイルの選択", p_path, p_file, p_extension, i_file_filter, l_def_path, get_modal_attribute() ) <> 1 Then
	return false
end if

p_file	= mid( l_path, lastpos( l_path, "\" ) + 1 )
p_path	= left( l_path, pos( l_path, p_file ) - 2 )

return true

end function

private subroutine set_ext_pattern (integer p_pattern);
choose case p_pattern
	case C_EXT_PTTN_GRAPH
		// 「画像ファイル」「すべてのファイル」の順で表示
		of_set_extension( 1, 0, 0, 0, 0, 0, 2 )
	case C_EXT_PTTN_PDF
		// 「PDFファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 1, 0, 0, 0, 0, 2 )
	case C_EXT_PTTN_PPOINT
		// 「PowerPointファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 1, 0, 0, 0, 2 )
	case C_EXT_PTTN_SPDSHEET
		// 「Excelファイル」「テキストファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 0, 1, 0, 2, 3 )
	case C_EXT_PTTN_EXCEL
		// 「Excelファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 0, 1, 0, 0, 2 )
	case C_EXT_PTTN_WORD
		// 「PowerPointファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 0, 0, 1, 0, 2 )
	case C_EXT_PTTN_TEXT
		// 「テキストファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 0, 0, 0, 1, 2 )
	case C_EXT_PTTN_ALL
		// 「テキストファイル」「すべてのファイル」の順で表示
		of_set_extension( 0, 0, 0, 0, 0, 0, 1 )
	case else	// C_EXT_PTTN_SPECIAL
		// 全部入りで既定順で表示
		of_set_extension( 1, 2, 3, 4, 5, 6, 7 )
end choose 

end subroutine

on nv_fmodal.create
call super::create
end on

on nv_fmodal.destroy
call super::destroy
end on

event constructor;call super::constructor;i_init_open_dir	= device.folder.desktop
end event

