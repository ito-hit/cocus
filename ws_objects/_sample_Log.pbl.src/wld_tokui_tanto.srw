$PBExportHeader$wld_tokui_tanto.srw
$PBExportComments$得意先担当者一斉変更
forward
global type wld_tokui_tanto from iw_main_window
end type
type st_status from ivo_statictext within wld_tokui_tanto
end type
type st_msg from ivo_statictext within wld_tokui_tanto
end type
type cb_clear from ivo_commandbutton within wld_tokui_tanto
end type
type dw_list from ivo_datawindow within wld_tokui_tanto
end type
type st_filename_t from ivo_statictext within wld_tokui_tanto
end type
type st_filename from ivo_statictext within wld_tokui_tanto
end type
type st_cnt_t from ivo_statictext within wld_tokui_tanto
end type
type st_cnt from ivo_statictext within wld_tokui_tanto
end type
type st_okcnt_t from ivo_statictext within wld_tokui_tanto
end type
type st_okcnt from ivo_statictext within wld_tokui_tanto
end type
type st_errcnt_t from ivo_statictext within wld_tokui_tanto
end type
type st_errcnt from ivo_statictext within wld_tokui_tanto
end type
type st_warncnt_t from ivo_statictext within wld_tokui_tanto
end type
type st_warncnt from ivo_statictext within wld_tokui_tanto
end type
type uo_nendo from sv_ddplb_nendo within wld_tokui_tanto
end type
type sle_month from ivo_singlelineedit within wld_tokui_tanto
end type
type st_month from ivo_statictext within wld_tokui_tanto
end type
type ddplb_status from ivo_dropdownpicturelistbox within wld_tokui_tanto
end type
type ddplb_msg from ivo_dropdownpicturelistbox within wld_tokui_tanto
end type
end forward

global type wld_tokui_tanto from iw_main_window
string title = "得意先担当者一斉変更"
boolean f7_key = true
boolean f9_key = false
boolean f12_key = true
event dropfile pbm_dropfiles
st_status st_status
st_msg st_msg
cb_clear cb_clear
dw_list dw_list
st_filename_t st_filename_t
st_filename st_filename
st_cnt_t st_cnt_t
st_cnt st_cnt
st_okcnt_t st_okcnt_t
st_okcnt st_okcnt
st_errcnt_t st_errcnt_t
st_errcnt st_errcnt
st_warncnt_t st_warncnt_t
st_warncnt st_warncnt
uo_nendo uo_nendo
sle_month sle_month
st_month st_month
ddplb_status ddplb_status
ddplb_msg ddplb_msg
end type
global wld_tokui_tanto wld_tokui_tanto

type prototypes

end prototypes

type variables


str_para_fileread	i_str_fileread
str_para_fileread	i_para_reset		// i_str_filereadの初期化用

// ドラッグファイル
string	i_dragfile[]		// ドラッグファイル パス・ファイル名を格納する配列
long	i_dragfile_cnt		// ドラッグしたファイル件数
datastore i_dts
end variables

forward prototypes
public function boolean of_erorr_check ()
public subroutine of_error_set (long p_row, string p_status, string p_msg)
public subroutine of_dsp_reset ()
public subroutine of_data_count ()
public subroutine of_filter_make ()
public subroutine of_filter_set ()
public function boolean of_db_update ()
public function integer of_fileread_csv (string p_filename)
public function integer of_fileread_excel (string p_filename)
public function integer of_fileread_text (string p_filename)
end prototypes

event dropfile;
// -----------------------------------------------------------------------
//	イベント	:	dropfiles
//	処理概要	:	外部からファイルをドラッグしたときに走るイベント
//	返り値		:	成否( 0:成功 1:失敗 )
// -----------------------------------------------------------------------

nv_dropfile	l_dropfile

if l_dropfile.of_dragqueryfile( handle, i_dragfile_cnt, i_dragfile ) <> 0 then
	return 1
end if

if not isnull( i_dragfile ) and i_dragfile_cnt > 0 then

	l_dropfile.of_mouseevent()

	i_str_fileread.ret[1].filename	= i_dragfile[1]
	// ファイル読込画面起動
	this.event key_f07( KeyF7!, 0 )

end if

return 0

end event

public function boolean of_erorr_check ();
// 関連項目値セット＆エラーチェック

long	l_row
long	l_cnt
long	l_tokui_code
string	l_tokui_mei
string	l_torihiki_teisi_kbn
string	l_syusoku_flg
long	l_gen_tanto_code_ms
long	l_gen_tanto_code
string	l_gen_tanto_mei
long	l_sin_tanto_code
string	l_sin_tanto_mei
long	l_sin_haiban_flg
long	l_err_cnt	= 0

string	l_status
string	l_msg

for l_row = 1 to dw_list.rowcount()
	
	// エラー100件超えたら処理中断
	if l_err_cnt > 100 then
		msg.of_error( "エラーチェック時のエラー件数が100件を超えました。処理を中断します。" )
		return false
	end if
	
	// 初期化
	l_status	= ""	// ステータス
	l_msg		= ""	// メッセージ
	
	l_tokui_code		= dw_list.object.tokui_code[l_row]		// 得意先コード
	l_gen_tanto_code	= dw_list.object.gen_tanto_code[l_row]	// 現担当者コード
	l_sin_tanto_code	= dw_list.object.sin_tanto_code[l_row]	// 新担当者コード

	// 得意先
	select mt.tokui_mei, meisyo_code || ':' || mei.meisyo_1, decode( mt.syusoku_flg, 1, '1:対象', '' ), tanto_code
	  into :l_tokui_mei, :l_torihiki_teisi_kbn, :l_syusoku_flg, :l_gen_tanto_code_ms
	  from m_tokui mt,
           ( select meisyo_code, meisyo_1 from m_meisyo where meisyo_kbn = 106 ) mei
	 where mt.tokui_code			= :l_tokui_code
	   and mt.torihiki_teisi_kbn	= mei.meisyo_code(+)
	using cocos;

	choose case cocos.sqlcode
		case 0
			dw_list.object.tokui_mei[l_row]				= l_tokui_mei
			dw_list.object.torihiki_teisi_kbn[l_row]	= l_torihiki_teisi_kbn
			dw_list.object.syusoku_flg[l_row]			= l_syusoku_flg
			if l_tokui_code > 99999 then
				l_err_cnt	= l_err_cnt + 1
				of_error_set( l_row, "エラー", "終息済みの得意先" )
				continue
			end if
			
		case 100
			l_err_cnt	= l_err_cnt + 1
			of_error_set( l_row, "エラー", "未登録の得意先" )
			continue
		case else
			msg.of_error( "入力チェック中にエラーが発生しました" )
			return false
	end choose

	// 現担当者
	select tanto_mei
	  into :l_gen_tanto_mei
	  from m_tanto
	 where tanto_code	= :l_gen_tanto_code
	using cocos;

	choose case cocos.sqlcode
		case 0
			dw_list.object.gen_tanto_mei[l_row]		= l_gen_tanto_mei
		case 100
			l_err_cnt	= l_err_cnt + 1
			of_error_set( l_row, "エラー", "未登録の現担当者" )
			continue
		case else
			msg.of_error( "入力チェック中にエラーが発生しました" )
			return false
	end choose
	
	// 新担当者
	select tanto_mei, haiban_flg
	  into :l_sin_tanto_mei, :l_sin_haiban_flg
	  from m_tanto
	 where tanto_code	= :l_sin_tanto_code
	using cocos;

	choose case cocos.sqlcode
		case 0
			dw_list.object.sin_tanto_mei[l_row]		= l_sin_tanto_mei
			if l_sin_haiban_flg = 1 then
				l_err_cnt	= l_err_cnt + 1
				of_error_set( l_row, "エラー", "新担当者が廃番状態" )
				continue
			end if
		case 100
			l_err_cnt	= l_err_cnt + 1
			of_error_set( l_row, "エラー", "未登録の新担当者" )
			continue
		case else
			msg.of_error( "入力チェック中にエラーが発生しました" )
			return false
	end choose

	// 警告チェック
	if l_syusoku_flg = "1:対象" then
		of_error_set( l_row, "警告", "得意先が終息済み" )
		continue
	end if
	if l_gen_tanto_code <> l_gen_tanto_code_ms then
		of_error_set( l_row, "警告", "現担当者がマスタと異なる" )
		continue
	end if
	if l_sin_tanto_code = l_gen_tanto_code_ms then
		of_error_set( l_row, "警告", "変更なし" )
		continue
	end if
	
next


return true

end function

public subroutine of_error_set (long p_row, string p_status, string p_msg);
// ステータス＆メッセージを画面にセット
dw_list.object.status[p_row]	= p_status
dw_list.object.msg[p_row]		= p_msg


end subroutine

public subroutine of_dsp_reset ();
string	l_nendo_mei
long	l_kisyo_nengetu
long	l_indx

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
ddplb_status.event constructor( )
ddplb_msg.event constructor( )

dw_list.event constructor( )
cb_retrieve.event constructor( )
uo_nendo.event constructor( )
sle_month.event constructor( )

st_filename.event constructor( )
st_cnt.event constructor( )
st_okcnt.event constructor( )
st_errcnt.event constructor( )
st_warncnt.event constructor( )

// 年度に初期値セット
select mn.nendo_mei,mn.kisyo_nengetu
  into :l_nendo_mei,:l_kisyo_nengetu
  from m_kihon mk,
       m_nendo mn
 where mk.kanri_code	= 0
   and mk.jigyo_nendo	= mn.nendo_code(+)
using cocos;

choose case cocos.sqlcode
	case 0
		l_indx	= uo_nendo.ddplb_nendo.selectitem(l_nendo_mei, 0 )
		uo_nendo.ddplb_nendo.event selectionchanged(l_indx)
		sle_month.text = string( long( right( string( l_kisyo_nengetu ), 2 ) ) )
	case 100
		msg.of_error( "マスタに存在しません。" )
	case else
		msg.of_error_db( "入力チェック中にエラーが発生しました。", cocos )
end choose



end subroutine

public subroutine of_data_count ();
// 件数セット
long	l_cnt		= 0
long	l_okcnt		= 0
long	l_errcnt	= 0
long	l_warncnt	= 0
long	l_row
string	l_status
string	l_filter_status
string	l_filter_msg

l_cnt	= dw_list.rowcount()

// フィルター解除
// 解除前条件保持
l_filter_status	= ddplb_status.text
l_filter_msg	= ddplb_msg.text
ddplb_status.text	= "(未選択)"
ddplb_msg.text		= "(未選択)"
of_filter_set()

for l_row = 1 to dw_list.rowcount()
	
	l_status	= dw_list.object.status[l_row]
	
	choose case l_status
		case "エラー"
			l_errcnt	= l_errcnt + 1
		case "警告"
			l_warncnt	= l_warncnt + 1
		case else
			l_okcnt		= l_okcnt + 1
	end choose

next

// 値をセット
st_cnt.text		= string( l_cnt )
st_okcnt.text	= string( l_okcnt )
st_errcnt.text	= string( l_errcnt )
st_warncnt.text	= string( l_warncnt )

// フィルター再セット
ddplb_status.text	= l_filter_status
ddplb_msg.text		= l_filter_msg
of_filter_set()

end subroutine

public subroutine of_filter_make ();
// フィルター条件セット
long	l_row
string	l_status
string	l_msg

long	l_rtn

// 初期化
ddplb_status.event constructor( )
ddplb_msg.event constructor( )

for l_row = 1 to dw_list.rowcount()
	
	l_status	= dw_list.object.status[l_row]
	l_msg		= dw_list.object.msg[l_row]
	
	// ステータス
	l_rtn	= ddplb_status.FindItem( l_status, 0 )
	
	if ddplb_status.FindItem( l_status, 0 ) = -1 then
		ddplb_status.insertitem( l_status, upperbound( ddplb_status.item ) + 1 )
	end if
	// メッセージ
	if ddplb_msg.finditem( l_msg, 0 ) = -1 then
		ddplb_msg.insertitem( l_msg, upperbound( ddplb_msg.item ) + 1 )
	end if

next

end subroutine

public subroutine of_filter_set ();
// フィルター実行

string	l_status
string	l_msg

integer	l_row
string	l_filter	= ""

//if dw_list.rowcount() = 0 then
//	return
//end if

l_status	= ddplb_status.text
l_msg		= ddplb_msg.text

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()

// ステータス
if l_status <> "(未選択)" then
	l_filter	= "status = '" + l_status + "'"
//	l_filter	= "status like '%" + l_status + "%'"
end if
//comment LIKE ~'%o_a15progress%~'
//comment like ~'%o*_a15progress%~' escape ~'*~' 

// メッセージ
if l_msg <> "(未選択)" then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and msg = '" + l_msg + "'"
	else
		l_filter	= "msg = '" + l_msg + "'"
	end if
end if

if len( l_filter ) <> 0 then
	// フィルタセット
	dw_list.setfilter( l_filter )
	dw_list.filter()
end if

// 選択行にスクロール
//dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end subroutine

public function boolean of_db_update ();
// DB更新処理
// 排他フラグが1件でもONとなっている場合、全RollBack後エラーとする

long	l_row
long	l_cnt
long	l_tokui_code
long	l_tanto_code
string	l_nendo_mei
long	l_month_from
long	l_nengetu_from, l_nengetu_to
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei

l_nendo_mei		= uo_nendo.ddplb_nendo.text
l_month_from	= long( sle_month.text )

// 得意先担当者M更新範囲
select kisyo_nengetu, kimatu_nengetu
  into :l_nengetu_from, :l_nengetu_to
  from m_nendo
 where nendo_mei	= :l_nendo_mei
 using cocos;
 
// 更新年月FROM
if l_nengetu_to < long( left( string( l_nengetu_to ), 4 ) + string( l_month_from, "00" ) ) then
	l_nengetu_from	= long( left( string( l_nengetu_from ), 4 ) + string( l_month_from, "00" ) )
else
	l_nengetu_from	= long( left( string( l_nengetu_to ), 4 ) + string( l_month_from, "00" ) )
end if

for l_row = 1 to dw_list.rowcount()
	
	// 「変更なし」の場合はスキップ
	if dw_list.object.msg[l_row] = "変更なし" then
		continue
	end if

	l_tokui_code	= dw_list.object.tokui_code[l_row]
	l_tanto_code	= dw_list.object.sin_tanto_code[l_row]

	// 得意先担当者M排他チェック
	select nvl( to_char( mm.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
		   nvl( mm.henkou_user_id, '???' ),
		   nvl( mu.user_mei, '???' ),
		   nvl( mm.henkou_client_id, '???' ),
		   nvl( mm.henkou_pg_id, '???' ),
		   nvl( mw.window_name, '???' )
	  into :l_henkou_date,
		   :l_henkou_user_id,:l_user_mei,
		   :l_henkou_client_id,
		   :l_henkou_pg_id,:l_window_mei
	  from m_tokui_tanto mm,
		   m_user mu,
		   m_window mw
	 where mm.henkou_user_id= mu.user_id(+)
	   and mm.henkou_pg_id	= mw.window_id(+)
	   and mm.tokui_code	= :l_tokui_code
	   and mm.nengetu		between :l_nengetu_from and :l_nengetu_to
	   and mm.haita_flg		= 1
	   and rownum			= 1
	using cocos;
	choose case cocos.sqlcode
		case 0
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
			return false
		case 100
			// 何もしない
		case else
			rollback using cocos;
			msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
			return false
	end choose

	// 得意先担当者M更新
	update m_tokui_tanto
	   set tanto_code		= :l_tanto_code,
		   henkou_date		= sysdate,
		   henkou_user_id	= :user.user_id,
		   henkou_client_id	= :device.name,
		   henkou_pg_id		= :i_pg_id,
		   kousin_user_id	= :user.user_id,
		   kousin_pg_id		= :i_pg_id
	 where tokui_code		= :l_tokui_code
	   and nengetu			between :l_nengetu_from and :l_nengetu_to
	using cocos;
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error_db( "得意先担当者マスタの更新処理でエラーが発生しました。", cocos )
		of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
		return false
	end if

	// 得意先M排他チェック
	select nvl( to_char( mm.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
		   nvl( mm.henkou_user_id, '???' ),
		   nvl( mu.user_mei, '???' ),
		   nvl( mm.henkou_client_id, '???' ),
		   nvl( mm.henkou_pg_id, '???' ),
		   nvl( mw.window_name, '???' )
	  into :l_henkou_date,
		   :l_henkou_user_id,:l_user_mei,
		   :l_henkou_client_id,
		   :l_henkou_pg_id,:l_window_mei
	  from m_tokui mm,
		   m_user mu,
		   m_window mw
	 where mm.henkou_user_id= mu.user_id(+)
	   and mm.henkou_pg_id	= mw.window_id(+)
	   and mm.tokui_code	= :l_tokui_code
	   and mm.haita_flg		= 1
	using cocos;
	choose case cocos.sqlcode
		case 0
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
			return false
		case 100
			// 何もしない
		case else
			rollback using cocos;
			msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
			return false
	end choose

	// 得意先M更新
	update m_tokui
	   set tanto_code		= :l_tanto_code,
		   henkou_date		= sysdate,
		   henkou_user_id	= :user.user_id,
		   henkou_client_id	= :device.name,
		   henkou_pg_id		= :i_pg_id,
		   kousin_user_id	= :user.user_id,
		   kousin_pg_id		= :i_pg_id
	 where tokui_code		= :l_tokui_code
	using cocos;
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error_db( "得意先マスタの更新処理でエラーが発生しました。", cocos )
		of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
		return false
	end if

next

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[読込ファイル=" + st_filename.text + " 件数=" + string( dw_list.rowcount() ) + "件]" + "更新" )


return true
end function

public function integer of_fileread_csv (string p_filename);
// ファイル読込 CSV

long	l_cnt

l_cnt = i_dts.importfile( CSV!, p_filename )



return 0
end function

public function integer of_fileread_excel (string p_filename);
// ファイル読込 EXCEL
oleobject	ole_excel
oleobject	ole_xlsheet

int			l_rtn
string		l_savefile
long		l_cnt

ole_excel = create oleobject

// Excelオブジェクト接続
l_rtn = ole_excel.ConnectToNewObject("Excel.Application")
if l_rtn < 0 then
	// EXCEL接続に失敗しました

	// Excelオブジェクト破棄
	ole_excel.disconnectobject()
	destroy ole_excel
	return 1
end if

ole_excel.workbooks.open( p_filename )

// 保存先
l_savefile	= GetCurrentDirectory() + "\TEMP_" + string( Today(), "YYYYMMDDHHMMSS" ) + ".txt"

// TAB区切りテキストに変換して保存
ole_excel.application.activeworkbook.saveas( l_savefile, -4158 )

// Excelオブジェクト破棄
ole_excel.application.displayalerts = false
ole_excel.application.quit
ole_excel.disconnectobject()
destroy ole_excel

// Text!でインポート
l_cnt = i_dts.importfile( Text!, l_savefile )

if l_cnt < 0 then
	// ファイル削除
	filedelete( l_savefile )
	return 1
end if

long	l_sec

do while l_sec < 30
	if fileexists ( l_savefile ) then
		// ファイル削除
		filedelete( l_savefile )
		sleep( 1 )
	else
		exit
	end if
	l_sec = l_sec + 1
loop
//// ファイル削除
//filedelete( l_savefile )


return 0
end function

public function integer of_fileread_text (string p_filename);
// ファイル読込 TEXT＆DAT

long	l_cnt

l_cnt = i_dts.importfile( Text!, p_filename )



return 0
end function

on wld_tokui_tanto.create
int iCurrent
call super::create
this.st_status=create st_status
this.st_msg=create st_msg
this.cb_clear=create cb_clear
this.dw_list=create dw_list
this.st_filename_t=create st_filename_t
this.st_filename=create st_filename
this.st_cnt_t=create st_cnt_t
this.st_cnt=create st_cnt
this.st_okcnt_t=create st_okcnt_t
this.st_okcnt=create st_okcnt
this.st_errcnt_t=create st_errcnt_t
this.st_errcnt=create st_errcnt
this.st_warncnt_t=create st_warncnt_t
this.st_warncnt=create st_warncnt
this.uo_nendo=create uo_nendo
this.sle_month=create sle_month
this.st_month=create st_month
this.ddplb_status=create ddplb_status
this.ddplb_msg=create ddplb_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_status
this.Control[iCurrent+2]=this.st_msg
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.st_filename_t
this.Control[iCurrent+6]=this.st_filename
this.Control[iCurrent+7]=this.st_cnt_t
this.Control[iCurrent+8]=this.st_cnt
this.Control[iCurrent+9]=this.st_okcnt_t
this.Control[iCurrent+10]=this.st_okcnt
this.Control[iCurrent+11]=this.st_errcnt_t
this.Control[iCurrent+12]=this.st_errcnt
this.Control[iCurrent+13]=this.st_warncnt_t
this.Control[iCurrent+14]=this.st_warncnt
this.Control[iCurrent+15]=this.uo_nendo
this.Control[iCurrent+16]=this.sle_month
this.Control[iCurrent+17]=this.st_month
this.Control[iCurrent+18]=this.ddplb_status
this.Control[iCurrent+19]=this.ddplb_msg
end on

on wld_tokui_tanto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_status)
destroy(this.st_msg)
destroy(this.cb_clear)
destroy(this.dw_list)
destroy(this.st_filename_t)
destroy(this.st_filename)
destroy(this.st_cnt_t)
destroy(this.st_cnt)
destroy(this.st_okcnt_t)
destroy(this.st_okcnt)
destroy(this.st_errcnt_t)
destroy(this.st_errcnt)
destroy(this.st_warncnt_t)
destroy(this.st_warncnt)
destroy(this.uo_nendo)
destroy(this.sle_month)
destroy(this.st_month)
destroy(this.ddplb_status)
destroy(this.ddplb_msg)
end on

event resize;call super::resize;// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

// フィルター部
st_status.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_status.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
st_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.x			= l_width - cb_clear.width - code.MGN_YOKO

// フッター2
sle_month.y			= key_fnc.y - code.MGN_TATE - sle_month.height
st_month.y			= sle_month.y + 7
uo_nendo.y			= sle_month.y

// フッター1
st_filename.y		= sle_month.y - code.MGN_TATE - st_filename.height
st_filename_t.y		= st_filename.y
st_cnt_t.y			= st_filename.y + 7
st_cnt.y			= st_filename.y
st_okcnt_t.y		= st_filename.y + 7
st_okcnt.y			= st_filename.y
st_errcnt_t.y		= st_filename.y + 7
st_errcnt.y			= st_filename.y
st_warncnt_t.y		= st_filename.y + 7
st_warncnt.y		= st_filename.y

// dw
dw_list.y			= cb_clear.y + cb_clear.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= st_filename.y - code.MGN_TATE - dw_list.y


end event

event key_f07;call super::key_f07;
// ファイル読込

// ファイルを開く
openwithparm( iw_fileread_window, i_str_fileread, this )

i_str_fileread	= message.powerobjectparm


if upperbound( i_str_fileread.ret ) > 0 then

	// ファイル名セット
	st_filename.text	= i_str_fileread.ret[1].filename
	// ファイル読込結果を画面にセット
	cb_retrieve.event execution( 0, 0 )
	
end if



return 0

end event

event open;call super::open;
// -------------------------------------------------------------
// ドラッグ＆ドロップの許可
// -------------------------------------------------------------
nv_dropfile	l_dropfile

l_dropfile.of_dragacceptfiles( Handle( This ), True )

dw_list.setfocus()
end event

event retrieve_event;call super::retrieve_event;
// ファイル読込
string	l_file
int		l_fileno
long 	l_pos
string	l_ext
long	l_cnt
long	l_row
long	l_row_ins


string	l_timer_1,l_timer_2,l_timer_3,l_timer_4

l_timer_1	= "開始：" + String( Now(), "hh:mm:ss")


if upperbound( i_str_fileread.ret ) > 0 then

	// データストア
	i_dts = create DataStore
	i_dts.dataobject	= "dld_fileread"
	i_dts.reset()
	i_dts.settransobject(cocos)

	setredraw( false )

	dw_list.reset()

	l_file	= trim( i_str_fileread.ret[1].filename )
	l_cnt	= i_str_fileread.ret[1].startrow

	// データストアにデータをセット
	if lena( l_file ) > 0 then
	
		l_pos = LastPos( l_file, "." )
		// 拡張子取得
		l_ext = upper( mid( l_file, l_pos, len( l_file ) ) )
	
		// ファイル読込
		choose case l_ext
			case ".XLSX"
				if of_fileread_excel( l_file ) <> 0 then
					msg.of_error( "EXCEL読込に失敗しました。" )
					return -1
				end if
				
			case ".CSV"
				if of_fileread_csv( l_file ) <> 0 then
					msg.of_error( "CSVL読込に失敗しました。" )
					return -1
				end if
	
			case else	// TEXT、DAT
				if of_fileread_text( l_file ) <> 0 then
					msg.of_error( "ファイル読込に失敗しました。" )
					return -1
				end if
				
		end choose
	
	end if

l_timer_2	= "データストアセット完了：" + String( Now(), "hh:mm:ss")


	// 画面に値をセット
	for l_row = l_cnt to i_dts.rowcount()
		l_row_ins	= dw_list.insertrow(0)
		dw_list.object.tokui_code[l_row_ins]		= dec( i_dts.object.data01[l_row] )
		dw_list.object.gen_tanto_code[l_row_ins]	= dec( i_dts.object.data02[l_row] )
		dw_list.object.sin_tanto_code[l_row_ins]	= dec( i_dts.object.data03[l_row] )
	next

l_timer_3	= "画面セット完了：" + String( Now(), "hh:mm:ss")


//	// 構造体からデータを画面にセットする
//	for l_cnt = 1 to upperbound( i_str_fileread.ret )
//		l_row	= dw_list.insertrow(0)
//		dw_list.object.tokui_code[l_row]		= dec( i_str_fileread.ret[l_cnt].data01 )
//		dw_list.object.gen_tanto_code[l_row]	= dec( i_str_fileread.ret[l_cnt].data02 )
//		dw_list.object.sin_tanto_code[l_row]	= dec( i_str_fileread.ret[l_cnt].data03 )
//	next

	// エラーチェック
	if of_erorr_check() = false then
		dw_list.reset()
		setredraw( true )
		return -1
	end if

	// 件数セット
	of_data_count()
	// フィルタ条件セット
	of_filter_make()
	// 構造体初期化
	i_str_fileread	= i_para_reset
	
	setredraw( true )

end if

l_timer_4	= "処理完了：" + String( Now(), "hh:mm:ss")

//msg.of_info( fnc.strg.of_format( "{1}{2}{3}{4}{5}{6}{7}", l_timer_1, code.CRLF, l_timer_2, code.CRLF, l_timer_3, code.CRLF, l_timer_4 ) )

return 0

end event

event openquery;call super::openquery;
of_dsp_reset()

end event

event update_event;call super::update_event;
// 更新処理

string	l_rowcount

if not of_db_update() then
	rollback using cocos;
	return -1
end if

commit using cocos;

l_rowcount	= string( dw_list.rowcount(), "\ \ \ \ \ \ \ 0" ) + "件"
msg.of_info( fnc.strg.of_format( "正常終了しました{1}{2}{3}", code.crlf, "更新件数・・・・・", l_rowcount ) )


// 画面初期化
of_dsp_reset()


return 0
end event

event key_f01;call super::key_f01;
// 全選択

integer	l_mode
integer	l_row, l_rowcnt, l_chkcnt

l_rowcnt	= dw_list.rowcount()
l_chkcnt	= long( dw_list.describe( "evaluate( 'sum( chk )', 0 )" ) )

if l_rowcnt = l_chkcnt then
	// 全選択状態なので選択解除
	l_mode	= 0
else
	// 未選択もしくは一部選択状態なので全選択
	l_mode	= 1
end if

for l_row = 1 to dw_list.rowcount()
	dw_list.object.chk[l_row]	= l_mode
next

return 0

end event

event key_f03;call super::key_f03;
// 行削除

long	l_row
long	l_chkcnt


l_chkcnt	= long( dw_list.describe( "evaluate( 'sum( chk )', 0 )" ) )

if l_chkcnt = 0 then
	return 0
else
	if msg.of_question( "削除しますが宜しいですか？" ) then
		setredraw( false )
		// チェックONの行を削除
		for l_row = dw_list.rowcount() to 1 step -1
			if dw_list.object.chk[l_row] = 1 then
				dw_list.deleterow( l_row )
			end if
		next
		// 件数再セット
		of_data_count()
		setredraw( true )
	end if
end if



return 0

end event

event update_check;call super::update_check;

// フィルター解除
cb_clear.event execution(0,0)

// 行がない
if dw_list.rowcount() = 0 then
	msg.of_error( "更新対象データがありません。" )
	return -1
end if


// エラー行がある場合は更新しない
if dw_list.find( "status = 'エラー'", 1, dw_list.rowcount() ) > 0 then
	msg.of_error( "エラー行がある為更新出来ません。エラー行を削除して下さい。" )
	return -1
end if



return 0
end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

type uo_signal from iw_main_window`uo_signal within wld_tokui_tanto
end type

type st_date from iw_main_window`st_date within wld_tokui_tanto
end type

type st_user_mei from iw_main_window`st_user_mei within wld_tokui_tanto
end type

type uo_test_mode from iw_main_window`uo_test_mode within wld_tokui_tanto
end type

type p_size_adjust from iw_main_window`p_size_adjust within wld_tokui_tanto
end type

type st_title from iw_main_window`st_title within wld_tokui_tanto
end type

type st_title_upper from iw_main_window`st_title_upper within wld_tokui_tanto
end type

type st_upper from iw_main_window`st_upper within wld_tokui_tanto
end type

type st_second_upper from iw_main_window`st_second_upper within wld_tokui_tanto
end type

type cb_retrieve from iw_main_window`cb_retrieve within wld_tokui_tanto
end type

event constructor;call super::constructor;
this.visible	= false
end event

type st_status from ivo_statictext within wld_tokui_tanto
integer x = 32
integer y = 384
integer width = 408
boolean bringtotop = true
string text = "ステータス"
alignment alignment = right!
end type

type st_msg from ivo_statictext within wld_tokui_tanto
integer x = 904
integer y = 395
integer width = 408
boolean bringtotop = true
string text = "メッセージ"
alignment alignment = right!
end type

type cb_clear from ivo_commandbutton within wld_tokui_tanto
integer x = 3664
integer y = 380
integer width = 408
boolean bringtotop = true
string text = "条件クリア"
end type

event execution;call super::execution;
// フィルター解除

ddplb_status.selectitem ( "(未選択)", 0 )
ddplb_msg.selectitem ( "(未選択)", 0 )

of_filter_set()


return 0

end event

type dw_list from ivo_datawindow within wld_tokui_tanto
integer x = 32
integer y = 498
integer width = 4072
integer height = 1369
integer taborder = 40
boolean bringtotop = true
string dataobject = "dld_tokui_tanto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
end type

event constructor;call super::constructor;
this.reset()
this.settransobject(cocos)


end event

event clicked;call super::clicked;
if row > 0 then
	if dwo.name = "chk" then
		if this.object.chk[row] = 0 then
			this.object.chk[row] = 1
		else
			this.object.chk[row] = 0
		end if
	end if
end if

end event

type st_filename_t from ivo_statictext within wld_tokui_tanto
integer x = 32
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込ﾌｧｲﾙ"
alignment alignment = right!
end type

type st_filename from ivo_statictext within wld_tokui_tanto
integer x = 376
integer y = 1913
integer width = 1608
integer height = 82
boolean bringtotop = true
integer textsize = -12
string text = ""
boolean border = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_cnt_t from ivo_statictext within wld_tokui_tanto
integer x = 2004
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込件数"
alignment alignment = right!
end type

type st_cnt from ivo_statictext within wld_tokui_tanto
integer x = 2348
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_okcnt_t from ivo_statictext within wld_tokui_tanto
integer x = 2656
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "正常件数"
alignment alignment = right!
end type

type st_okcnt from ivo_statictext within wld_tokui_tanto
integer x = 3000
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 134217741
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_errcnt_t from ivo_statictext within wld_tokui_tanto
integer x = 3308
integer y = 1916
integer width = 408
boolean bringtotop = true
string text = "エラー件数"
alignment alignment = right!
end type

type st_errcnt from ivo_statictext within wld_tokui_tanto
integer x = 3732
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 255
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_warncnt_t from ivo_statictext within wld_tokui_tanto
integer x = 4040
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "警告件数"
alignment alignment = right!
end type

type st_warncnt from ivo_statictext within wld_tokui_tanto
integer x = 4384
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 255
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type uo_nendo from sv_ddplb_nendo within wld_tokui_tanto
integer y = 2016
integer taborder = 50
boolean bringtotop = true
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf10_key = true
boolean sf12_key = true
end type

on uo_nendo.destroy
call sv_ddplb_nendo::destroy
end on

event constructor;call super::constructor;
//this.backcolor			= 536870912		// 背景色(透明)
//this.st_title.backcolor	= 536870912		// 背景色(透明)
//this.r_back.fillcolor	= 536870912		// 背景色(透明)
//this.r_back.linecolor	= 536870912		// 背景色(透明)
//this.st_aida.backcolor	= 536870912		// 背景色(透明)

//this.ddplb_nendo.enabled	= false
this.enabled	= true

end event

type sle_month from ivo_singlelineedit within wld_tokui_tanto
integer x = 1832
integer y = 2016
integer width = 88
integer taborder = 60
boolean bringtotop = true
string text = ""
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf7_key = true
boolean sf10_key = true
boolean sf12_key = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_month from ivo_statictext within wld_tokui_tanto
integer x = 1940
integer y = 2023
integer width = 888
boolean bringtotop = true
string text = "月以降を新担当者に変更"
end type

type ddplb_status from ivo_dropdownpicturelistbox within wld_tokui_tanto
integer x = 456
integer y = 380
integer width = 428
integer height = 363
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","",""}
integer itempictureindex[] = {1,0,0,0}
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf10_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset( )
this.enabled	= true
this.insertitem( "(未選択)", upperbound( this.item ) + 1 )
this.selectitem( "(未選択)", 1 )

this.event selectionchanged( i_idx )

end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type ddplb_msg from ivo_dropdownpicturelistbox within wld_tokui_tanto
integer x = 1328
integer y = 380
integer width = 2008
integer height = 363
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","","","","","",""}
integer itempictureindex[] = {1,0,0,0,0,0,0,0}
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf10_key = true
boolean sf12_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset( )
this.enabled	= true
this.insertitem( "(未選択)", upperbound( this.item ) + 1 )
this.selectitem( "(未選択)", 1 )

this.event selectionchanged( i_idx )

end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

