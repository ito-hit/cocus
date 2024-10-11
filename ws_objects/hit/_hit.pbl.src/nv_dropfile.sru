$PBExportHeader$nv_dropfile.sru
$PBExportComments$ドロップファイル操作関数
forward
global type nv_dropfile from inv_object
end type
type lstr_filetime from structure within nv_dropfile
end type
type lstr_file from structure within nv_dropfile
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

global type nv_dropfile from inv_object autoinstantiate
end type

type prototypes

// dropfile用
Subroutine DragAcceptFiles(ULong hWnd,Boolean fAccept) Library "Shell32.dll"
Subroutine DragFinish(ULong hDrop) Library "Shell32.dll"
Function Int DragQueryFileA(Long hDrop,Int iFile,ref String lpszFile,Int cch) Library "Shell32.dll" alias for "DragQueryFileA;Ansi"
Function Int DragQueryFile(Long hDrop,Int iFile,ref String lpszFile,Int cch) Library "Shell32.dll" alias for "DragQueryFileW;Unicode"
Subroutine mouse_event(ulong dwFlags,ulong dx,ulong dy,ulong cButtons,ulong dwExtraInfo) LIBRARY "user32.dll"

end prototypes

type variables

end variables

forward prototypes
private subroutine set_read_mode ()
private subroutine set_write_mode (integer p_data_type)
public subroutine of_dragacceptfiles (long p_handle, boolean p_accept)
public subroutine of_mouseevent ()
public function long of_dragqueryfile (long p_handle, ref long p_filecnt, ref string p_file[])
end prototypes

private subroutine set_read_mode ();
end subroutine

private subroutine set_write_mode (integer p_data_type);
end subroutine

public subroutine of_dragacceptfiles (long p_handle, boolean p_accept);
DragAcceptFiles( p_handle, p_accept)

RETURN
end subroutine

public subroutine of_mouseevent ();
mouse_event(2,0,0,0,0)	// left mouse down
mouse_event(4,0,0,0,0)	// left mouse up

RETURN
end subroutine

public function long of_dragqueryfile (long p_handle, ref long p_filecnt, ref string p_file[]);
integer	l_size		// file buffer size
string	l_filename	// file name

string	l_null[]
long	l_cnt
long	l_filecnt

// reference format
p_filecnt = 0
p_file = l_null

l_size	= 256

l_filecnt = dragqueryfile(p_handle, -1, l_filename, 0)
p_filecnt = l_filecnt

for l_cnt = 1 to l_filecnt

	// make it's size enough
	l_filename = filla( ' ', l_size )

	if dragqueryfile( p_handle, l_cnt - 1, l_filename, l_size ) > 0 then 
		p_file[ l_cnt ] = l_filename
	end if

next

// handle destroy
dragfinish( p_handle )	

return 0
end function

on nv_dropfile.create
call super::create
end on

on nv_dropfile.destroy
call super::destroy
end on

