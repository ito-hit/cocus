$PBExportHeader$nv_file.sru
$PBExportComments$ファイル操作関数
forward
global type nv_file from inv_object
end type
type lstr_filetime from structure within nv_file
end type
type lstr_file from structure within nv_file
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

global type nv_file from inv_object
end type
global nv_file nv_file

type prototypes
function long		findfirstfile( ref string filename, ref lstr_file findfiledata )	library "kernel32.dll"	alias for "FindFirstFileW"
function boolean	findnextfile( ulong handle, ref lstr_file findfiledata )			library "kernel32.dll"	alias for "FindNextFileW"
function boolean	findclose( ulong handle )											library "kernel32.dll"	alias for "FindClose"
	
end prototypes

type variables
integer	i_file

integer	i_filemode,i_fileaccess,i_filelock,i_writemode,i_encoding

private filemode	i_ctlg_filemode
private fileaccess	i_ctlg_fileaccess
private filelock	i_ctlg_filelock
private writemode	i_ctlg_writemode
private encoding	i_ctlg_encoding

// ファイルオープンモード
constant	integer	C_FILEMODE_TEXT_LINE	= 0	// テキストCRLFごとモード（デフォルト）
constant	integer	C_FILEMODE_BINARY		= 1	// バイナリモード（一括読み込みモード）
constant	integer	C_FILEMODE_FULL			= 2	// テキスト一括読み込みモード

// ファイルアクセスモード
constant integer	C_FILEACCESS_READ		= 0	// 読み込みモード
constant integer	C_FILEACCESS_WRITE		= 1	// 書込みモード

// ファイルロックモード
constant integer	C_FILELOCK_FULL			= 0	// 完全ロックモード
constant integer	C_FILELOCK_WRITE		= 1	// 書込みのみロックモード
constant integer	C_FILELOCK_SHARED		= 2	// アンロック（ロックしない）

// ファイル書込みモード
constant integer	C_FILEWRITE_APPEND		= 0	// 追記モード
constant integer	C_FILEWRITE_REPLACE		= 1	// 上書きモード

// ファイルエンコード
constant integer	C_FILEENC_SJIS			= 0	// SJIS（デフォルト）
constant integer	C_FILEENC_UTF			= 1 // UTF-8

end variables

forward prototypes
private subroutine set_read_mode ()
private subroutine set_write_mode (integer p_data_type)
private subroutine set_mode_encoding (integer p_encoding)
private subroutine set_mode_fileaccess (integer p_fileaccess)
private subroutine set_mode_filelock (integer p_filelock)
private subroutine set_mode_filemode (integer p_filemode)
private subroutine set_mode_writemode (integer p_writemode)
private function integer get_files (string p_path, ref string p_files[])
public function integer of_get_files (string p_path, ref string p_files[])
public function integer of_open_file (string p_file_name)
public function integer of_open_file (string p_file_name, boolean p_write_mode)
end prototypes

private subroutine set_read_mode ();
end subroutine

private subroutine set_write_mode (integer p_data_type);
end subroutine

private subroutine set_mode_encoding (integer p_encoding);choose case i_encoding
	case c_fileenc_sjis
		i_ctlg_encoding		= EncodingANSI!
	case c_fileenc_utf
		i_ctlg_encoding		= EncodingUTF8!
	case else
		i_ctlg_encoding		= EncodingANSI!
end choose

end subroutine

private subroutine set_mode_fileaccess (integer p_fileaccess);choose case i_fileaccess
	case c_fileaccess_read
		i_ctlg_fileaccess	= Read!
	case c_fileaccess_write
		i_ctlg_fileaccess	= Write!
	case else
		i_ctlg_fileaccess	= Read!
end choose

end subroutine

private subroutine set_mode_filelock (integer p_filelock);choose case i_filelock
	case c_filelock_full
		i_ctlg_filelock		= LockReadWrite!
	case c_filelock_write
		i_ctlg_filelock		= LockWrite!
	case c_filelock_shared
		i_ctlg_filelock		= Shared!
	case else
		i_ctlg_filelock		= LockReadWrite!
end choose

end subroutine

private subroutine set_mode_filemode (integer p_filemode);choose case i_filemode
	case c_filemode_text_line
		i_ctlg_filemode		= LineMode!
	case c_filemode_binary
		i_ctlg_filemode		= StreamMode!
	case c_filemode_full
		i_ctlg_filemode		= TextMode!
	case else
		i_ctlg_filemode		= LineMode!
end choose

end subroutine

private subroutine set_mode_writemode (integer p_writemode);choose case i_writemode
	case c_filewrite_append
		i_ctlg_writemode	= Append!
	case c_filewrite_replace
		i_ctlg_writemode	= Replace!
	case else
		i_ctlg_writemode	= Append!
end choose

end subroutine

private function integer get_files (string p_path, ref string p_files[]);long	l_handle
boolean	l_found	= true
integer	l_cnt	= 1

string	l_dmy_string[]

lstr_file	l_file_attr

if right( p_path, 1 ) = "\" then
	p_path += "*.*"
end if

l_handle	= findfirstfile( p_path, l_file_attr )

if l_handle > 0 then
	do until not l_found
		p_files[l_cnt]	= string( l_file_attr.cfilename )
		l_cnt			= l_cnt + 1
	
		l_found = findnextfile( l_handle, l_file_attr )
	loop

	findclose( l_handle )
else
	l_cnt	= 0
	p_files	= l_dmy_string
end if

return l_cnt

end function

public function integer of_get_files (string p_path, ref string p_files[]);return get_files( p_path, p_files )
end function

public function integer of_open_file (string p_file_name);return 0
end function

public function integer of_open_file (string p_file_name, boolean p_write_mode);return 0
end function

on nv_file.create
call super::create
end on

on nv_file.destroy
call super::destroy
end on

