$PBExportHeader$inv_datastore.sru
$PBExportComments$データストアの先祖オブジェクト
forward
global type inv_datastore from acc_datastore
end type
end forward

global type inv_datastore from acc_datastore
end type
global inv_datastore inv_datastore

type variables

public:

protected:
	// 動的ソート関連(ソートカラム/並び順)
	string	i_sort_column[]
	string	i_sort_order[]

private:
	// 初期ソート条件保管
	string	default_sort
	

end variables

forward prototypes
private function boolean set_tag2dbname (ref datastore p_ds)
public function string of_get_filter ()
public function string of_get_sort ()
public subroutine of_reset ()
public subroutine of_reset_filter ()
public subroutine of_reset_sort ()
public subroutine of_set_filter (string p_filter)
public subroutine of_set_sort (string p_sort)
public subroutine of_set_dynamic_sort (string p_column)
public function boolean of_saveas_excel (ref string p_file, boolean p_selected)
public function boolean of_saveas_excel (string p_file)
public function integer of_chk_variation (dwobject p_dwo, string p_data)
end prototypes

private function boolean set_tag2dbname (ref datastore p_ds);
integer	l_row
string	l_col[],l_tag

for l_row = 1 to long( p_ds.object.datawindow.column.count )
	l_col[l_row]	= this.describe( "#" + string( l_row ) + ".dbname" )
	l_tag			= this.describe( "#" + string( l_row ) + ".tag" )
		
	if l_tag <> "?" then
		p_ds.modify( fnc.strg.of_format( "#{1}.dbname='{2}'", string( l_row ), l_tag ) )
	end if
next

return true

end function

public function string of_get_filter ();
string	l_filter

l_filter	= this.describe( "datawindow.table.filter" )

return fnc.strg.of_replace( l_filter, "?", "" )

end function

public function string of_get_sort ();string	l_sort

l_sort	= this.describe( "datawindow.table.sort" )

return fnc.strg.of_replace( l_sort, "?", "" )

end function

public subroutine of_reset ();
of_reset_filter( )
of_reset_sort( )

reset()

end subroutine

public subroutine of_reset_filter ();
of_set_filter( "" )
end subroutine

public subroutine of_reset_sort ();
of_set_sort( "" )
end subroutine

public subroutine of_set_filter (string p_filter);
this.setfilter( p_filter )
this.filter()
this.groupcalc()
end subroutine

public subroutine of_set_sort (string p_sort);
this.setsort( p_sort )
this.sort()
this.groupcalc()
end subroutine

public subroutine of_set_dynamic_sort (string p_column);
string	l_sort_column[], l_sort_order[]
integer	l_row,l_row2
string	l_sort

l_row2	= 1

if upperbound( i_sort_column ) <> 0 then
	for l_row = 1 to upperbound( i_sort_column )
		if i_sort_column[l_row] = p_column then
			l_sort_column[l_row2]	= p_column
	
			if i_sort_order[l_row] <> "asc" then
				l_sort_order[l_row2]	= "asc"
			else
				l_sort_order[l_row2]	= "desc"
			end if
			
			exit
		end if
	next
end if

if upperbound( l_sort_column ) = 0 then
	l_sort_column[l_row2]	= p_column
	l_sort_order[l_row2]	= "asc"
end if

for l_row = 1 to upperbound( l_sort_column )
	if l_row <> 1 then
		l_sort	= fnc.strg.of_format( "{1},{2} {3}", l_sort, l_sort_column[l_row], l_sort_order[l_row] )
	else
		l_sort	= fnc.strg.of_format( "{1} {2}", l_sort_column[l_row], l_sort_order[l_row] )
	end if
next

of_set_sort( l_sort )

i_sort_column	= l_sort_column
i_sort_order	= l_sort_order


end subroutine

public function boolean of_saveas_excel (ref string p_file, boolean p_selected);boolean		l_ret
boolean		l_save
string		l_save_path
string		l_path, l_file
saveastype	l_sat

// Excel出力
datastore	l_ds
long		l_row
long		l_init_row

l_ds			= create datastore

if len( this.dataobject ) > 0 then
	l_ds.dataobject	= this.dataobject
else
	l_ds.create( this.object.datawindow.syntax )
end if

l_init_row		= long( this.object.datawindow.firstrowonpage )


// 出力対象データを抽出
if p_selected then
	for l_row = l_init_row to this.rowcount()
		if this.isselected( l_row ) then
			this.rowscopy( l_row, l_row, Primary!, l_ds, l_ds.rowcount() + 1, Primary! )
		end if
	next
else
	this.rowscopy( l_init_row, this.rowcount(), Primary!, l_ds, l_ds.rowcount() + 1, Primary! )
end if

if set_tag2dbname( l_ds ) then
	nv_fmodal	l_fmo
		
	l_fmo	= create nv_fmodal
	
	l_ret	= true
	l_sat	= l_fmo.c_sat_xlsx
	
	// フルパスできてたらパスとファイル名を分ける
	l_file	= mid( p_file, lastpos( p_file, "\" ) + 1 )
	l_path	= left( p_file, pos( p_file, l_file ) - 2 )
	
	saveretry:
	if l_fmo.of_open_save_datawindow( l_path, l_file, l_sat ) then
		if l_ds.saveas( fnc.strg.of_format( "{1}\{2}", l_path, l_file ), l_sat, true, EncodingANSI! ) > 0 then
			msg.of_info( fnc.strg.of_format( "保存しました。{1}ファイル名：{2}", code.crlf, l_file ) )
		else
			if msg.of_retry_question( "ファイルの保存に失敗しました。" ) then
				goto saveretry	
			end if
	
			l_ret	= false
		end if
	end if
	
	destroy l_fmo
else
	msg.of_error( "ヘッダ情報の置換でエラーが発生しました。" )
	l_ret	= false
end if

destroy l_ds

return l_ret	
	
	// 保存用ファイル名（初期値）
	//l_file	= fnc.of_string_format( "名称マスタ{1}", string( today(), "yyyymmdd" ) )
	
//	// ファイル保存
//	if getfilesavename( "ファイルの選択", p_file_name, l_save_path, "xlsx", "すべてのファイル (*.*),*.*", device.folder.desktop, 32770 ) = 1 Then
//		if fileexists( p_file_name ) then
//			if not msg.of_question( "すでにファイルが存在します。上書きしますか？" ) then
//				l_save	= false
//			end if
//		end if
//	
//		if l_save then
//saveretry:
//			if l_ds.saveas( l_save_path, XLSX!, true, EncodingANSI! ) > 0 then
//				msg.of_info( fnc.strg.of_format( "保存しました。{1}ファイル名：{2}", code.crlf, p_file_name ) )
//			else
//				if msg.of_retry_question( "ファイルの保存に失敗しました。" ) then
//					goto saveretry	
//				end if
//				l_ret	= false
//			end if
//		end if
//	end if
//else
//	msg.of_error( "ヘッダ情報の置換でエラーが発生しました。" )
//	l_ret	= false
//end if
//
//destroy l_ds
//
//return l_ret
//
end function

public function boolean of_saveas_excel (string p_file);
return of_saveas_excel( p_file, false )
end function

public function integer of_chk_variation (dwobject p_dwo, string p_data);
// 入力されたデータの型とカラムの型の整合性チェックを行う
// 【戻り値】※itemchangedイベントの戻り値に合わせた
// 0:データ値を受け付ける
// 1:データ値を却下する 処理の続行は許可しない
// 2:データ値は却下するが、処理の続行は可能

string	l_type, l_data

l_type	= p_dwo.coltype
l_type	= mid( l_type, 1, pos( l_type, "(" ) - 1 )	// 「char(10)」という形で受け取るので、型名だけ取り出す

choose case l_type
	case "decimal", "number", "integer", "long", "double"
		// 数値型に文字列が入力されたときのチェック
		l_data	= trim( p_data )
		
		// 数値チェック
		if not isnumber( l_data ) then
			// 空白(スペース)のチェック
			if len( l_data ) <> 0 then
				return 1
			else
				return 2
			end if
		end if
	case else
		
end choose

return 0

end function

on inv_datastore.create
call super::create
end on

on inv_datastore.destroy
call super::destroy
end on

event constructor;call super::constructor;
// 初期ソート条件退避
default_sort	= of_get_sort()

end event

