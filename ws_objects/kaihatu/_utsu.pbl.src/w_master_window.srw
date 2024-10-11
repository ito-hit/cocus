$PBExportHeader$w_master_window.srw
$PBExportComments$ウィンドウ登録
forward
global type w_master_window from iw_main_window
end type
type ddplb_syori from sv_ddplb_syori within w_master_window
end type
type sle_search_string from ivo_singlelineedit within w_master_window
end type
type st_1 from ivo_statictext within w_master_window
end type
type st_2 from ivo_statictext within w_master_window
end type
type st_3 from ivo_statictext within w_master_window
end type
type dw_list from ivo_datawindow within w_master_window
end type
type dw_entry from ivo_datawindow within w_master_window
end type
type lstr_m_window from structure within w_master_window
end type
end forward

type lstr_m_window from structure
	string		window_id		descriptor "comment" = "ウィンドウID"
	string		window_name		descriptor "comment" = "ウィンドウ名"
	integer		kengen_kbn		descriptor "comment" = "権限区分"
	integer		siyo_kinsi_flg		descriptor "comment" = "使用禁止フラグ"
	string		bikou		descriptor "comment" = "備考"
	string		rowid
end type

global type w_master_window from iw_main_window
string title = "ウインドウ登録"
boolean f12_key = true
ddplb_syori ddplb_syori
sle_search_string sle_search_string
st_1 st_1
st_2 st_2
st_3 st_3
dw_list dw_list
dw_entry dw_entry
end type
global w_master_window w_master_window

type variables
private integer	i_permission	// 0：全ユーザー、1：システム管理者
private	boolean	i_admin			// ユーザーの管理者権限保有

private string	i_syori_kbn
private string	i_search_string

// #### 定数 #### //
private constant string ic_mode_init	= "init"
private constant string ic_entry_reset	= "entry_reset"
private constant string ic_entry_cancel	= "entry_cancel"
private constant string ic_entry_end	= "entry_end"

// 名称マスタの名称区分 //
private constant long	ic_kengen_kbn	= 143	// 権限区分a

// 処理区分 //
private constant string ic_syori_kbn_ins	= "登録"
private constant string ic_syori_kbn_upd	= "変更"
private constant string ic_syori_kbn_del	= "削除"
private constant string ic_syori_kbn_show	= "照会"
end variables

forward prototypes
public subroutine display_control (string p_mode)
public function boolean of_db_insert (lstr_m_window p_rec)
public function boolean of_db_update (lstr_m_window p_rec)
public function boolean of_db_delete (lstr_m_window p_rec)
end prototypes

public subroutine display_control (string p_mode);string	l_syori_kbn

choose case p_mode
	case ic_mode_init	// 初期表示
		l_syori_kbn	= ddplb_syori.text
		
		ddplb_syori.event constructor( )
		sle_search_string.event constructor( )
		cb_retrieve.event constructor( )
		
		dw_entry.event constructor( )
		dw_list.event constructor( )
		
		ddplb_syori.text	= l_syori_kbn
		ddplb_syori.setfocus( )
		
	case ic_entry_reset // 入力取消
		dw_entry.event constructor( )
		
		// 処理区分「登録」の時は入力欄を使用可にする
		if i_syori_kbn = ic_syori_kbn_ins then
			dw_entry.object.disabled[1]	= 0
		end if
		
		dw_list.enabled	= true
		dw_list.setfocus( )

	case ic_entry_cancel	// 登録・更新・削除キャンセル
		dw_entry.enabled	= true
		dw_entry.setfocus( )

	case ic_entry_end	// 登録・更新・削除終了
		dw_entry.event constructor()
		dw_list.event constructor()
		event retrieve_event( 0, 0 )
		
		dw_list.enabled	= true
		dw_list.setfocus( )
	case else
end choose
end subroutine

public function boolean of_db_insert (lstr_m_window p_rec);// 登録 //
insert into m_window(
	window_id, window_name,
	kengen_kbn, siyo_kinsi_flg,
	bikou,
	touroku_user_id,
	touroku_client_id,
	touroku_pg_id
) values (
	:p_rec.window_id, :p_rec.window_name,
	:p_rec.kengen_kbn, :p_rec.siyo_kinsi_flg,
	:p_rec.bikou,
	:user.user_id,
	:device.name,
	:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	//msg.of_error( fnc.of_string_format( "ウィンドウマスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	msg.of_error( fnc.strg.of_format( "ウィンドウマスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

public function boolean of_db_update (lstr_m_window p_rec);// 更新
update m_window
    set window_id			= :p_rec.window_id,
	    window_name			= :p_rec.window_name,
	    kengen_kbn			= :p_rec.kengen_kbn,
	    siyo_kinsi_flg		= :p_rec.siyo_kinsi_flg,
	    bikou				= :p_rec.bikou,
	    kousin_date			= sysdate,
	    kousin_user_id		= :user.user_id,
	    kousin_client_id	= :device.name,
	    kousin_pg_id		= :i_pg_id
where rowid					= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	//msg.of_error( fnc.of_string_format( "ウィンドウマスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	msg.of_error( fnc.strg.of_format( "ウィンドウマスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

public function boolean of_db_delete (lstr_m_window p_rec);// 削除
delete from m_window
where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
//	msg.of_error( fnc.of_string_format( "ウィンドウマスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	msg.of_error( fnc.strg.of_format( "ウィンドウマスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

on w_master_window.create
int iCurrent
call super::create
this.ddplb_syori=create ddplb_syori
this.sle_search_string=create sle_search_string
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_list=create dw_list
this.dw_entry=create dw_entry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori
this.Control[iCurrent+2]=this.sle_search_string
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.dw_entry
end on

on w_master_window.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori)
destroy(this.sle_search_string)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_list)
destroy(this.dw_entry)
end on

event openquery;call super::openquery;// システム管理者区分
constant integer	c_admin	= 1

//function_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }

// システム管理者権限を保有状況確認
//i_admin	= dbfnc.of_chk_access_arrow( c_admin )
i_admin	= kengen.of_check( c_admin )

// テスト用
i_admin	= true
end event

event resize;call super::resize;long	l_dwheight, l_dwwidth

if this.width <= 3924 then
	l_dwwidth	= 3924
else
	// 新しいウィンドウサイズからデータウィンドウのサイズを計算
	l_dwwidth	= newwidth - dw_list.x -20
end if

// 新しいウィンドウサイズからデータウィンドウのサイズを計算
l_dwheight	= newheight - dw_list.y - 20

// データウィンドウのサイズを変更
dw_list.Resize( l_dwwidth, l_dwheight )
end event

event retrieve_event;call super::retrieve_event;string	l_base_dw_sql, l_sql, l_sql_where

l_base_dw_sql	= dw_list.getsqlselect( )
l_sql			= dw_list.getsqlselect( )

// 検索用SQLの組み立て
if i_search_string <> "" then
	l_sql_where += " and (  mw.window_id like '%" + i_search_string + "%'" + code.crlf
	l_sql_where += "	   or" + code.crlf
	l_sql_where += "		mw.window_name like '%" + i_search_string + "%'" + code.crlf
	l_sql_where += "	  )" + code.crlf
	
	l_sql	+= 	+ l_sql_where
end if

dw_list.setsqlselect( l_sql )

// 検索
if dw_list.retrieve( ) = 0 then
	// DWを元に戻す
	dw_list.setsqlselect( l_base_dw_sql )
	msg.of_error( "入力された検索文字に該当するデータはありません。" )	
	return
end if

// DWを元に戻す //
dw_list.setsqlselect( l_base_dw_sql )

// 検索欄の使用不可制御
choose case i_syori_kbn
	case ic_syori_kbn_ins, ic_syori_kbn_upd, ic_syori_kbn_del	// 登録, 変更, 削除
		ddplb_syori.enabled			= false
		sle_search_string.enabled	= false
		cb_retrieve.enabled			= false
	case ic_syori_kbn_show	// 照会
	case else
end choose

// 入力欄の設定
choose case i_syori_kbn
	case ic_syori_kbn_ins	// 登録
		dw_entry.object.disabled[1]		= 0
		dw_entry.setcolumn( "window_id" )
		
		dw_entry.setfocus( )
		
	case ic_syori_kbn_upd, ic_syori_kbn_del, ic_syori_kbn_show	// 変更, 削除, 照会
		dw_entry.object.disabled[1]		= 1
		
		dw_list.setfocus( )
	case else
end choose

//// ファンクションキーの使用可否
//choose case i_syori_kbn
//	case ic_syori_kbn_del	// 削除
//		dw_list.f12_key	=	true
//		dw_list.setfocus( )
//	case ic_syori_kbn_show	// 照会
//		dw_list.f12_key	=	false
//		dw_list.setfocus( )
//	case else
//end choose
end event

event retrieve_check;call super::retrieve_check;// 入力チェック
if not sle_search_string.of_check( ) then
	return -1
end if

// 変更可能かどうか権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出す）
if not i_admin then
	if i_permission = 0 then
		msg.of_warning( "入力された名称区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
		ddplb_syori.text	= ic_syori_kbn_show	// 照会
	end if
end if

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori.text
i_search_string	= sle_search_string.text

end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	display_control( ic_mode_init )
end if
return 0
end event

event open;call super::open;ddplb_syori.setfocus( )
end event

event update_check;call super::update_check;long	l_cnt
string	l_window_id, l_db_window_name


// DWの入力規則チェック
if dw_entry.accepttext( ) <> 1 then
	return -1
end if

choose case ddplb_syori.text
	case ic_syori_kbn_ins	// ## 登録 ##
		// # 必須入力チェック #
		// ウィンドウID
		if isnull( dw_entry.object.window_id[1] ) or trim( dw_entry.object.window_id[1] ) = "" then
			msg.of_error("ウィンドウIDが入力されていません。" )
			dw_entry.setcolumn( "window_id" )
			dw_entry.setfocus( )
			return -1
		
		else
			// キーをセット
			l_window_id	= dw_entry.object.window_id[1]
		end if
		
		if isnull( dw_entry.object.rowid[1] ) or dw_entry.object.rowid[1] = "" then
			// # 新規登録 #
			select window_name
		  	   into  :l_db_window_name
			  from m_window
			where window_id	= :l_window_id
			using cocos;
		  
			choose case cocos.sqlcode
				case 0	// データ有り
					//msg.of_error( fnc.of_string_format( "登録しようとしているウィンドウはすでに登録があります。【登録済みのウィンドウ】{1}：{2}", code.crlf, string( l_window_id ), l_db_window_name ) )
					msg.of_error( fnc.strg.of_format( "登録しようとしているウィンドウはすでに登録があります。【登録済みのウィンドウ】{1}：{2}", code.crlf, string( l_window_id ), l_db_window_name ) )
					return -1
				case 100 // データ無し
				case else
					//msg.of_error( fnc.of_string_format( "ウィンドウマスタ登録前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ), l_db_window_name ) )
					msg.of_error( fnc.strg.of_format( "ウィンドウマスタ登録前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ), l_db_window_name ) )
					return -1
			end choose
		else
			// # 登録モードだけど検索した内容を変更する場合 #
			select count( 1 )
		   	   into  :l_cnt
		 	  from m_window
			where window_id	= :l_window_id
			using cocos;
		 
			choose case cocos.sqlcode
				case 0 // データ有り
					// データ有りはOK
				case 100 // データ無し
					//msg.of_error( fnc.of_string_format( "変更しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
					msg.of_error( fnc.strg.of_format( "変更しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
					return -1
				case else
					//msg.of_error( fnc.of_string_format( "ウィンドウマスタ変更前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
					msg.of_error( fnc.strg.of_format( "ウィンドウマスタ変更前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
					return -1
			end choose
		end if
		
	case ic_syori_kbn_upd	// ## 変更 ##
		// # 必須入力チェック #
		// ウィンドウID
		if isnull( dw_entry.object.window_id[1] ) or trim( dw_entry.object.window_id[1] ) = "" then
			msg.of_error("ウィンドウIDが入力されていません。" )
			dw_entry.setcolumn( "window_id" )
			dw_entry.setfocus( )
			return -1
		
		else
			// キーをセット
			l_window_id	= dw_entry.object.window_id[1]
		end if
		
		select count( 1 )
		   into  :l_cnt
		  from m_window
		where window_id	= :l_window_id
		 using cocos;
		 
		choose case cocos.sqlcode
			case 0 // データ有り
				// データ有りはOK
			case 100 // データ無し
				//msg.of_error( fnc.of_string_format( "変更しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
				msg.of_error( fnc.strg.of_format( "変更しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
				return -1
			case else
				//msg.of_error( fnc.of_string_format( "ウィンドウマスタ変更前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
				msg.of_error( fnc.strg.of_format( "ウィンドウマスタ変更前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
				return -1
		end choose
		
	case ic_syori_kbn_del	// ## 削除 ##
		// キーをセット
		l_window_id	= dw_entry.object.window_id[1]
		
		select count( 1 )
		   into  :l_cnt
		  from m_window
		where window_id	= :l_window_id
		 using cocos;

		choose case cocos.sqlcode
			case 0 // データ有り
				// データ有りはOK				
			case 100	// データ無し
				//msg.of_error( fnc.of_string_format( "削除しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
				msg.of_error( fnc.strg.of_format( "削除しようとしているウィンドウが登録されていません。【ウィンドウID】{1}", code.crlf, string( l_window_id ) ) )
				return -1
			case else
				//msg.of_error( fnc.of_string_format( "ウィンドウマスタ削除前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
				msg.of_error( fnc.strg.of_format( "ウィンドウマスタ削除前のチェックでエラーが発生しました。{1}：{2}", code.crlf, string( l_window_id ) ) )
				return -1
		end choose
	case else
end choose
end event

event update_event;call super::update_event;lstr_m_window	l_rec
long			l_row

// 画面上の項目をセット
l_rec.window_id			= dw_entry.object.window_id[1]		// ウィンドウID
l_rec.window_name		= dw_entry.object.window_name[1]	// ウィンドウ名
l_rec.kengen_kbn		= dw_entry.object.kengen_kbn[1]		// 権限区分
l_rec.siyo_kinsi_flg	= dw_entry.object.siyo_kinsi_flg[1]	// 使用禁止フラグ
l_rec.bikou				= dw_entry.object.bikou[1]			// 備考
l_rec.rowid				= dw_entry.object.rowid[1]

choose case i_syori_kbn
	case ic_syori_kbn_ins	// # 登録 #
		if isnull( dw_entry.object.rowid[1] ) or dw_entry.object.rowid[1] = "" then
			// 新規登録
			if not msg.of_question( "登録しますか？" ) then
				display_control( ic_entry_cancel )
				return 0
			end if
		
			// 登録処理
			if not of_db_insert( l_rec ) then
				display_control( ic_entry_end )
				return -1
			end if
		
			display_control( ic_entry_end )
		
			msg.of_info("登録しました")
			
		else
			// 登録モードだけど検索した内容を変更する場合
			if not msg.of_question( "変更しますか？" ) then
				display_control( ic_entry_cancel )
				return 0
			end if
		
			// 更新処理
			if not of_db_update( l_rec ) then
				display_control( ic_entry_end )
				return -1
			end if
			
			display_control( ic_entry_end )
			
			msg.of_info("変更しました")
		end if
		
	case ic_syori_kbn_upd	// # 変更 #
		if not msg.of_question( "変更しますか？" ) then
			display_control( ic_entry_cancel )
			return 0
		end if
		
		// 更新処理
		if not of_db_update( l_rec ) then
			display_control( ic_entry_end )
			return -1
		end if
		
		display_control( ic_entry_end )
		
		msg.of_info("変更しました")
		
	case ic_syori_kbn_del	// # 削除 #
		if not msg.of_question( "削除しますか？" ) then
			display_control( ic_entry_cancel )
			return 0
		end if
		
		if not of_db_delete( l_rec ) then
			display_control( ic_entry_end )
			return -1
		end if
		
		display_control( ic_entry_end )
		
		msg.of_info("削除しました")
		
	case else		
end choose

commit using cocos;


end event

event key_f12;call super::key_f12;of_evt_update( 0, 0 )
return 0
end event

type uo_signal from iw_main_window`uo_signal within w_master_window
end type

type st_date from iw_main_window`st_date within w_master_window
end type

type st_user_mei from iw_main_window`st_user_mei within w_master_window
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_master_window
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_master_window
end type

type st_title from iw_main_window`st_title within w_master_window
end type

type st_title_upper from iw_main_window`st_title_upper within w_master_window
end type

type st_upper from iw_main_window`st_upper within w_master_window
end type

type st_second_upper from iw_main_window`st_second_upper within w_master_window
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_master_window
integer taborder = 40
boolean f9_key = true
boolean f10_key = true
end type

event cb_retrieve::constructor;call super::constructor;this.enabled	= true
end event

type ddplb_syori from sv_ddplb_syori within w_master_window
integer x = 352
integer y = 153
integer width = 240
integer taborder = 20
boolean bringtotop = true
string init_disp = "照会"
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )
end event

type sle_search_string from ivo_singlelineedit within w_master_window
integer x = 352
integer y = 256
integer width = 1260
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 2
string text = ""
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

end event

type st_1 from ivo_statictext within w_master_window
integer x = 36
integer y = 160
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type st_2 from ivo_statictext within w_master_window
integer x = 40
integer y = 260
boolean bringtotop = true
long backcolor = 12632256
string text = "検索文字"
alignment alignment = right!
end type

type st_3 from ivo_statictext within w_master_window
integer x = 1640
integer y = 263
integer width = 1524
boolean bringtotop = true
long textcolor = 255
long backcolor = 12632256
string text = "※ウィンドウID・ウィンドウ名を曖昧検索（省略時は全件表示）"
alignment alignment = right!
end type

type dw_list from ivo_datawindow within w_master_window
integer y = 878
integer width = 5120
integer height = 2055
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_master_window_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f5_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.setredraw( false )

this.reset( )
this.settransobject( cocos )

this.setredraw( true )

this.enabled			= true
end event

event doubleclicked;call super::doubleclicked;string	l_window_id
long	l_row

if row <> 0 then
	l_window_id	= this.object.window_id[row]
	
	dw_entry.setredraw( false )
	
	dw_entry.reset( )
	
	// クリックされたのウィンドウIDをもとに検索	
	dw_entry.retrieve( l_window_id )	
	
	choose case i_syori_kbn
		case ic_syori_kbn_ins, ic_syori_kbn_upd		// 登録, 変更
			dw_entry.object.del_flg[1]	= 0
			dw_entry.object.disabled[1]	= 0
			
			dw_entry.f6_key				= true
			
			dw_entry.setcolumn( "window_id" )
			dw_entry.setrow( 1 )
			dw_entry.setfocus( )
			
		case ic_syori_kbn_del	// 削除
			dw_entry.object.del_flg[1]	= 1
			dw_entry.object.disabled[1]	= 1
			
			dw_entry.f6_key				= true
			
			dw_entry.setrow( 1 )
			dw_entry.setfocus( )
			
		case ic_syori_kbn_show	// 照会
			dw_entry.object.del_flg[1]	= 0
			dw_entry.object.disabled[1]	= 1
			
//			dw_list.setfocus()
			
		case else
	end choose
	
	dw_entry.setredraw( true )
	
end if
end event

event retrievestart;call super::retrievestart;of_loading( true )
end event

event retrieveend;call super::retrieveend;of_loading( false )
end event

event retrieverow;call super::retrieverow;yield()
end event

event key_f05;call super::key_f05;// Excel出力
return 0
end event

event clicked;call super::clicked;string	l_columnname

choose case dwo.name
	case "window_id_t", "window_name_t", "kengen_kbn_mei_t", "siyo_kinsi_kbn_t", "bikou_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
	case else
end choose
end event

type dw_entry from ivo_datawindow within w_master_window
integer y = 398
integer width = 5120
integer height = 448
integer taborder = 60
string dataobject = "d_master_window_entry"
boolean border = false
borderstyle borderstyle = stylebox!
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;datawindowchild	l_dwc

this.i_function_name	= { "", "", "", "", "", "取消", "", "", "", "", "", "" }

// F6ボタン(取消ボタン) //
this.f6_key	= false
this.event getfocus()

// DW関連
this.settransobject( cocos )

this.setredraw( true )

// 権限区分ドロップダウンDW
this.getchild( "kengen_kbn",  l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve( ic_kengen_kbn, 1, 0 )

this.reset( )
this.insertrow( 0 )

this.setredraw( true )
end event

event key_f06;call super::key_f06;// F6(取消)ボタン

if msg.of_question( "変更中の内容を取り消しますか？"  ) then
	display_control( ic_entry_reset )
	dw_list.setfocus( )
end if
return 0
end event

event clicked;call super::clicked;
choose case dwo.name
	case "siyo_kinsi_flg_t"	// 使用禁止CheckBox
		if this.object.siyo_kinsi_flg[1] = 1 then
			this.object.siyo_kinsi_flg[1]	= 0
		else
			this.object.siyo_kinsi_flg[1]	= 1
		end if
	case else
end choose
end event

