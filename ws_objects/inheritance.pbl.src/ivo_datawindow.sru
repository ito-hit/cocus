$PBExportHeader$ivo_datawindow.sru
$PBExportComments$データウインドウコントロールの先祖オブジェクト
forward
global type ivo_datawindow from asv_datawindow
end type
type uo_keyup_timer from inv_timing within ivo_datawindow
end type
end forward

global type ivo_datawindow from asv_datawindow
boolean save_excel = true
event rbuttonmenuclick ( string p_click_menu )
event type long itemlosefocuschanged ( long row,  dwobject dwo )
uo_keyup_timer uo_keyup_timer
end type
global ivo_datawindow ivo_datawindow

type variables
public:

protected:
	// 行の反転表示(有効/無効)
	boolean	row_focus_ind
	
	// 右クリックメニュー表示(有効/無効)
	boolean	rbutton_menu

	// 右クリックメニューで表示されるメニューオブジェクト
	im_menu_rb_selectdw	i_rmenu
	
	// 複数行選択開始行
	long shift_start
	
	// 動的ソート関連(ソートカラム/並び順)
	string	i_sort_column[]
	string	i_sort_order[]

	// ファンクションキー初期有効/無効補完(初回constructorでセット)
	boolean	init_fnkey[], init_sfnkey[]

	// 無効／編集不可などの場合の背景色
	long	input_ena_backcolor, input_dis_backcolor
private:
	// 矩形選択時に元の行反転表示状態の退避
	boolean	row_focus_ind_bak
	
	// 初期ソート条件保管
	string	default_sort
	
	// フォーカスがあるカラムIDと一つ前のカラムID
	string		focus_column, losefocus_column
	long		focus_row, losefocus_row
	dwobject	focus_dwobj, losefocus_dwobj

	boolean on_keyshift, on_keyctrl, on_keyctrlshift	// True:keydown状態 False:keyup状態

end variables

forward prototypes
public function string of_get_sort ()
public subroutine of_set_sort (string p_sort)
public subroutine of_set_dynamic_sort (string p_column)
private function boolean set_tag2dbname (ref datastore p_ds)
private subroutine fnkey_setting (unsignedlong p_keyflags)
public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled)
public subroutine of_set_filter (string p_filter)
public subroutine of_reset_filter ()
public subroutine of_reset_sort ()
public function string of_get_filter ()
public subroutine of_reset ()
public function boolean of_saveas_excel (ref string p_file, boolean p_selected)
public function boolean of_saveas_excel (string p_file)
public function boolean of_source_set (string p_source)
public function string of_source_get ()
public function integer of_chk_variation (dwobject p_dwo, string p_data)
end prototypes

event rbuttonmenuclick(string p_click_menu);choose case p_click_menu
	case "copy"
		if this.object.datawindow.selected.mouse = "no" then
			integer		l_row
			datastore	l_ds
			
			l_ds			= create datastore
			l_ds.dataobject	= this.dataobject
	
			for l_row = 1 to this.rowcount()
				if this.isselected( l_row ) then
					this.rowscopy( l_row, l_row, Primary!, l_ds, l_ds.rowcount() + 1, Primary! )
				end if
			next
	
			l_ds.saveas( "", clipboard!, false )
			
			destroy l_ds
		else
			::clipboard( this.describe( "datawindow.selected.data" ) )
			event rbuttonmenuclick( "rectangleoff" )
		end if
	case "rectangleon"
		this.object.datawindow.selected.mouse	= "yes"

		if row_focus_ind then
			this.selectrow( 0, False )
			row_focus_ind_bak	= row_focus_ind
			row_focus_ind		= false
		end if
	case "rectangleoff"
		this.object.datawindow.selected.mouse	= "no"

		if row_focus_ind_bak then
			row_focus_ind		= row_focus_ind_bak
			row_focus_ind_bak	= false
		end if
end choose
end event

event type long itemlosefocuschanged(long row, dwobject dwo);
return 0
end event

public function string of_get_sort ();string	l_sort

l_sort	= this.describe( "datawindow.table.sort" )

return fnc.strg.of_replace( l_sort, "?", "" )

end function

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

this.setredraw( false )

of_set_sort( l_sort )

i_sort_column	= l_sort_column
i_sort_order	= l_sort_order

this.setredraw( true )

end subroutine

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

private subroutine fnkey_setting (unsignedlong p_keyflags);string			l_function_name[]
boolean			l_function_enabled[]
unsignedlong	l_keyflags

if of_get_fnkey_visibled( ) then
	// フォーカス取得時にShiftキーが押されていればファンクション切替
	choose case p_keyflags
		case 0
			on_keyshift			= false
			l_function_name		= i_function_name
			l_function_enabled	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }
		case 1
			on_keyshift			= true
			l_function_name		= i_sfunction_name
			l_function_enabled	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }
	end choose
	
	// 無効化されている場合は下部のファンクションキーもすべて無効化する
	if not this.enabled then
		l_function_enabled	= { false, false, false, false, false, false, false, false, false, false, false, false }
	end if
	
	parent.dynamic of_fnkey_setting( thisobj, l_function_name, l_function_enabled, p_keyflags )
end if


end subroutine

public subroutine of_set_fnkey (keycode p_keycode, boolean p_enabled);
unsignedlong	l_keyflags

choose case p_keycode
	case keyf1!
		f1_key	= p_enabled
	case keyf2!
		f2_key	= p_enabled
	case keyf3!
		f3_key	= p_enabled
	case keyf4!
		f4_key	= p_enabled
	case keyf5!
		f5_key	= p_enabled
	case keyf6!
		f6_key	= p_enabled
	case keyf7!
		f7_key	= p_enabled
	case keyf8!
		f8_key	= p_enabled
	case keyf9!
		f9_key	= p_enabled
	case keyf10!
		f10_key	= p_enabled
	case keyf11!
		f11_key	= p_enabled
	case keyf12!
		f12_key	= p_enabled
	case else
end choose

// ファンクションキーセット
if keydown( keyshift! ) then
	l_keyflags			= 1
else
	l_keyflags			= 0
end if
	
fnkey_setting( l_keyflags )

end subroutine

public subroutine of_set_filter (string p_filter);
this.setfilter( p_filter )
this.filter()
this.groupcalc()
end subroutine

public subroutine of_reset_filter ();
of_set_filter( "" )
end subroutine

public subroutine of_reset_sort ();
of_set_sort( "" )
end subroutine

public function string of_get_filter ();
string	l_filter

l_filter	= this.describe( "datawindow.table.filter" )

return fnc.strg.of_replace( l_filter, "?", "" )

end function

public subroutine of_reset ();
of_reset_filter( )
of_reset_sort( )

reset()

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
return of_saveas_excel( p_file, row_multi_select )
end function

public function boolean of_source_set (string p_source);
this.dataobject	= ""

if this.create( p_source ) <> 1 then
	return false
else
	this.settransobject( cocos )
end if

return true

end function

public function string of_source_get ();
return this.object.datawindow.syntax
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

on ivo_datawindow.create
call super::create
this.uo_keyup_timer=create uo_keyup_timer
end on

on ivo_datawindow.destroy
call super::destroy
destroy(this.uo_keyup_timer)
end on

event constructor;call super::constructor;object_type	= "datawindow"

// Excel保存が有効なら
if save_excel then
	i_function_name	= { "", "", "", "", "Excel保存", "", "", "", "", "", "", "" }
end if

// i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
// i_sfunction_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

// 無効／編集不可などの場合の背景色
input_ena_backcolor	= rgb( 255, 255, 255 )
input_dis_backcolor	= palette.main_background

// ファンクションキー有効／無効初期値退避
if upperbound( init_fnkey ) = 0 then
	init_fnkey	= { f1_key, f2_key, f3_key, f4_key, f5_key, f6_key, f7_key, f8_key, f9_key, f10_key, f11_key, f12_key }
	init_sfnkey	= { sf1_key, sf2_key, sf3_key, sf4_key, sf5_key, sf6_key, sf7_key, sf8_key, sf9_key, sf10_key, sf11_key, sf12_key }
else
	// 初期のファンクションキー状態をセット
	f1_key		= init_fnkey[1]
	f2_key		= init_fnkey[2]
	f3_key		= init_fnkey[3]
	f4_key		= init_fnkey[4]
	f5_key		= init_fnkey[5]
	f6_key		= init_fnkey[6]
	f7_key		= init_fnkey[7]
	f8_key		= init_fnkey[8]
	f9_key		= init_fnkey[9]
	f10_key		= init_fnkey[10]
	f11_key		= init_fnkey[11]
	f12_key		= init_fnkey[12]
	sf1_key		= init_sfnkey[1]
	sf2_key		= init_sfnkey[2]
	sf3_key		= init_sfnkey[3]
	sf4_key		= init_sfnkey[4]
	sf5_key		= init_sfnkey[5]
	sf6_key		= init_sfnkey[6]
	sf7_key		= init_sfnkey[7]
	sf8_key		= init_sfnkey[8]
	sf9_key		= init_sfnkey[9]
	sf10_key	= init_sfnkey[10]
	sf11_key	= init_sfnkey[11]
	sf12_key	= init_sfnkey[12]
end if

// 右クリックメニュー準備
if rbutton_menu then
	this.event rbuttonmenuclick( "rectangleoff" )

	i_rmenu	= create im_menu_rb_selectdw
	i_rmenu.of_set_object( this )
end if

// 初期ソート条件退避
default_sort	= of_get_sort()

end event

event itemfocuschanged;call super::itemfocuschanged;unsignedlong	l_keyflags

// ファンクションキーセット
if keydown( keyshift! ) then
	l_keyflags			= 1
else
	l_keyflags			= 0
end if

fnkey_setting( l_keyflags )

// 前回フォーカスがあったカラム情報を退避
losefocus_row		= focus_row
losefocus_dwobj		= focus_dwobj

// フォーカスがあるカラム情報をセット
focus_column		= dwo.name
focus_dwobj			= dwo
focus_row			= row

// itemfocusのlosefocus版を呼出し
if event itemlosefocuschanged( losefocus_row, losefocus_dwobj ) <> 0 then
	this.setrow( losefocus_row )
	this.setcolumn( string( losefocus_dwobj.name ) )
	return -1
end if

this.selecttext(1,len(this.gettext( )))
end event

event getfocus;call super::getfocus;
// getcolumnは入力フォームとして有効、getrowとfocus_indのコンビはリスト表示に対するアクション

unsignedlong	l_keyflags

// 全部プロテクト状態だとフォーカス来ないのでいったんgetcolumnとかの条件は廃止
//if this.getcolumn() > 0 or ( this.getrow() > 0 and row_focus_ind ) then
	
	// ファンクションキーセット
	if keydown( keyshift! ) then
		l_keyflags			= 1
	else
		l_keyflags			= 0
	end if
	
	fnkey_setting( l_keyflags )
// end if
end event

event rowfocuschanging;call super::rowfocuschanging;long l_row, l_start, l_end

if row_focus_ind then
	if not keydown( keycontrol! ) then
		this.selectrow( 0, False )
	else
		if not row_multi_select then
			this.selectrow( 0, False )
		end if
	end if
	
	if keydown( keyshift! ) then
		if row_multi_select then
			if shift_start = 0 then
				shift_start	= currentrow
			end if

			l_start	= min( shift_start, newrow )

			if l_start <> shift_start then
				l_end	= shift_start
			else
				l_end	= newrow
			end if
			
			for l_row = l_start to l_end
				this.selectrow( l_row, true )
			next
			
			return
		end if
	end if

	shift_start	= 0
	this.selectrow( newrow, true )
end if
end event

event destructor;call super::destructor;if rbutton_menu then
	destroy	i_rmenu
end if

end event

event rbuttondown;call super::rbuttondown;if rbutton_menu then
	if row <> 0 then
		i_rmenu.popmenu( parent.dynamic pointerx(), parent.dynamic pointery() )
	end if
end if
end event

event itemerror;call super::itemerror;
integer	l_ret

// 入力されたデータとカラムの型の整合性チェック
l_ret	= this.of_chk_variation( dwo, data )

choose case l_ret
	case 0
		// そのまま通す itemerrorイベントで値を受け付ける際の戻り値は2 itemerrorは入力規則に反した場合に実行されるので、ここを通ることはほぼないかも
		l_ret	= 2
	case 1
		// 不許可 このイベントで止める
		msg.of_error_dwo( dwo, fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", data ) )
	case 2
		// スペースなどが入力されたとき
	case else

end choose

this.selecttext( 1, len( this.gettext() ) )

return l_ret

end event

event sqlpreview;call super::sqlpreview;string	l_old, l_new
string	l_insert, l_update
string	l_set, l_into, l_values, l_where
string	l_pgid

integer	l_pos_v, l_pos_w

l_old	= sqlsyntax

l_pos_v	= pos( lower( l_old ), ") values" )
l_pos_w	= pos( lower( l_old ), "where" )

l_pgid	= of_get_pg_id( )

choose case sqltype
	case PreviewInsert!
		l_insert	= mid( l_old, 1, l_pos_v - 1 )
		l_values	= mid( l_old, l_pos_v, len( l_old ) - l_pos_v )
		// 2024.09.17 kin 登録～以外に更新～もセットするように修正
//		l_into		= ",touroku_user_id,touroku_client_id,touroku_pg_id"
//		l_values 	= fnc.strg.of_format( "{1},{2},'{3}','{4}' )", l_values, string( user.user_id ), device.name, l_pgid )
		l_into		= ",touroku_user_id,touroku_client_id,touroku_pg_id,kousin_user_id,kousin_client_id,kousin_pg_id"
		l_values 	= fnc.strg.of_format( "{1},'{2}','{3}','{4}','{2}','{3}','{4}' )", l_values, string( user.user_id ), device.name, l_pgid )
		l_new		= l_insert + l_into + l_values

	case PreviewUpdate!
		l_update	= mid( l_old, 1, l_pos_w - 1 )
		l_where		= mid( l_old, l_pos_w, len( l_old ) - l_pos_w )
		// 2024.09.17 kin 更新～変更～が逆になっていたので修正するとともにupdate時どちらもセットするように修正
//		l_set 		= fnc.strg.of_format( ",kousin_user_id = {1}, kousin_client_id = '{2}', kousin_pg_id = '{3}',kousin_date = sysdate, henkou_date = sysdate  ", string( user.user_id ), device.name, l_pgid )
		l_set 		= fnc.strg.of_format( ",kousin_user_id = '{1}',kousin_client_id = '{2}',kousin_pg_id = '{3}',kousin_date = sysdate,henkou_user_id = '{1}',henkou_client_id = '{2}',henkou_pg_id = '{3}',henkou_date = sysdate ", string( user.user_id ), device.name, l_pgid )
		l_new		= l_update + l_set + l_where
	case else
		l_new		= l_old

end choose

this.setsqlpreview( l_new )


end event

event retrieveend;call super::retrieveend;if rowcount > 0 then
	if row_focus_ind then
		this.selectrow( 0, false )
		this.selectrow( 1, true )
	end if
end if
end event

event clicked;call super::clicked;if row > 0 then
	this.setrow( row )
end if
end event

event syskeydown;call super::syskeydown;
choose case keyflags
	case 1
		try
			// ファンクションキーセット
			if not on_keyshift then
				fnkey_setting( keyflags )
				
				// カラムIDが入っているならShiftキーを離してもkeyupイベントが動かないのでタイマで監視を開始
				if len( focus_column ) > 0 then
					uo_keyup_timer.of_start()
				end if
			end if
		catch( nullobjecterror ne )
		end try
end choose
end event

event syskeyup;call super::syskeyup;
boolean			l_shift
unsignedlong	l_keyflags

// upしたキーがShitキーか
if key = keyshift! then
	l_shift	= true
end if

// keyflagsでShiftキーが押されていないか
choose case keyflags
	case 1, 3
	case else
		l_shift	= true
end choose

if l_shift then
	try
		// ファンクションキーセット
		l_keyflags	= 0		// 解除なので0

		fnkey_setting( l_keyflags )
	catch( nullobjecterror ne )
	end try
end if
end event

type uo_keyup_timer from inv_timing within ivo_datawindow descriptor "pb_nvo" = "true" 
long interval_msec = 50
end type

on uo_keyup_timer.create
call super::create
end on

on uo_keyup_timer.destroy
call super::destroy
end on

event timer_event;call super::timer_event;if not keydown( keyshift! ) then
	parent.event syskeyup( keyshift!, 0 )
	of_stop()
end if


end event

