$PBExportHeader$iw_fileread_window.srw
$PBExportComments$ファイル読込用ウィンドウ
forward
global type iw_fileread_window from iw_modal_window
end type
type st_filename from ivo_statictext within iw_fileread_window
end type
type sle_filename from ivo_singlelineedit within iw_fileread_window
end type
type cb_filename from sv_cb_modal within iw_fileread_window
end type
type sle_start_pos from ivo_singlelineedit within iw_fileread_window
end type
type st_start_pos from ivo_statictext within iw_fileread_window
end type
end forward

global type iw_fileread_window from iw_modal_window
integer height = 1618
string title = "ファイル読込"
st_filename st_filename
sle_filename sle_filename
cb_filename cb_filename
sle_start_pos sle_start_pos
st_start_pos st_start_pos
end type
global iw_fileread_window iw_fileread_window

type variables

public:
	str_para_fileread	i_str_fileread	// 親ウインドウとの受け渡し用構造体

private:
	str_para_fileread	i_para_reset		// i_str_filereadの初期化用
	boolean				i_retreive	= true	// sle_filename直接入力で検索する/しない
end variables

forward prototypes
public function integer of_fileread_csv (string p_filename)
public function integer of_fileread_excel (string p_filename)
public function integer of_fileread_text (string p_filename)
end prototypes

public function integer of_fileread_csv (string p_filename);
// ファイル読込 CSV
long	l_cnt

l_cnt = dw_list.importfile(CSV!,p_filename)

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

ole_excel.workbooks.open(p_filename)

// 保存先
l_savefile	= GetCurrentDirectory() + "\TEMP_" + string(Today(),"YYYYMMDDHHMMSS") + ".txt"

// TAB区切りテキストに変換して保存
ole_excel.application.activeworkbook.saveas(l_savefile,-4158)

// Excelオブジェクト破棄
ole_excel.application.displayalerts = false
ole_excel.application.quit
ole_excel.disconnectobject()
destroy ole_excel

// Text!でインポート
l_cnt = dw_list.importfile(Text!,l_savefile)

if l_cnt < 0 then
	// ファイル削除
	filedelete(l_savefile)
	return 1
end if

long	l_sec

do while l_sec < 30
	if fileexists (l_savefile) then
		// ファイル削除
		filedelete(l_savefile)
		sleep(1)
	else
		exit
	end if
	l_sec = l_sec + 1
loop
// ファイル削除
//filedelete(l_savefile)

return 0
end function

public function integer of_fileread_text (string p_filename);
// ファイル読込 TEXT＆DAT
long	l_cnt

l_cnt = dw_list.importfile(Text!,p_filename)

return 0
end function

on iw_fileread_window.create
int iCurrent
call super::create
this.st_filename=create st_filename
this.sle_filename=create sle_filename
this.cb_filename=create cb_filename
this.sle_start_pos=create sle_start_pos
this.st_start_pos=create st_start_pos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_filename
this.Control[iCurrent+2]=this.sle_filename
this.Control[iCurrent+3]=this.cb_filename
this.Control[iCurrent+4]=this.sle_start_pos
this.Control[iCurrent+5]=this.st_start_pos
end on

on iw_fileread_window.destroy
call super::destroy
destroy(this.st_filename)
destroy(this.sle_filename)
destroy(this.cb_filename)
destroy(this.sle_start_pos)
destroy(this.st_start_pos)
end on

event openquery;call super::openquery;
// 不要項目非表示
p_size_adjust.visible	= false
uo_test_mode.visible	= false
uo_signal.visible		= false
st_date.visible			= false
st_user_mei.visible		= false
st_title.visible		= false
st_title_upper.visible	= false
st_upper.visible		= false
st_tail.visible			= false

// 親ウインドウからのパラメータを変数に格納
i_str_fileread	= i_msgparm.powerobjectparm

// dropfile対応
if upperbound(i_str_fileread.ret) > 0 then
	if lena(i_str_fileread.ret[1].filename) > 0 then
		i_retreive	= false
		sle_filename.text = i_str_fileread.ret[1].filename
		i_retreive	= true
	end if
end if

// inパラメータ以外を初期化しておく
i_str_fileread	= i_para_reset

end event

event retrieve_event;call super::retrieve_event;
string	l_file
int		l_fileno
long 	l_pos
string	l_ext
long	l_cnt

l_file	= trim(sle_filename.text)

if lena(l_file) > 0 then
	l_pos = LastPos(l_file,".")
	// 拡張子取得
	l_ext = upper(mid(l_file,l_pos,len(l_file)))

	// dw初期化
//	dw_list.event constructor()
	dw_list.reset()

	setredraw(false)

	// ファイル読込
	choose case l_ext
		case ".XLSX"
			if of_fileread_excel(l_file) <> 0 then
				msg.of_error_sle(sle_filename,fnc.strg.of_format("EXCEL読込に失敗しました。",""))
				setredraw(true)
				return -1
			end if
			
		case ".CSV"
			if of_fileread_csv(l_file) <> 0 then
				msg.of_error_sle(sle_filename,fnc.strg.of_format("CSVL読込に失敗しました。",""))
				setredraw(true)
				return -1
			end if

		case else	// TEXT、DAT
			if of_fileread_text(l_file) <> 0 then
				msg.of_error_sle(sle_filename,fnc.strg.of_format("ファイル読込に失敗しました。",""))
				setredraw(true)
				return -1
			end if
			// 項目幅調整
			if dw_list.rowcount() > 0 then
				l_cnt	= lena(string(dw_list.object.data01[1]))
				dw_list.Modify("data01" + ".Width = " + string(l_cnt * 40))
			end if
			
	end choose

	setredraw(true)
end if

return 0
end event

event resize;
// 上書き

// ファイル名
st_filename.x	= 32
st_filename.y	= 39
sle_filename.x	= st_filename.x + st_filename.width + code.MGN_YOKO
sle_filename.y	= 32
// ボタン
cb_filename.x	= sle_filename.x + sle_filename.width + code.MGN_YOKO
cb_filename.y	= 32

// 取込開始行
st_start_pos.y	= newheight - st_start_pos.height - code.MGN_TATE * 2 - 4
sle_start_pos.y	= newheight - sle_start_pos.height - code.MGN_TATE * 2

// キャンセルボタン
cb_cancel.width	= 340
cb_cancel.y		= newheight - cb_cancel.height - code.MGN_TATE * 2
cb_cancel.x		= newwidth - cb_cancel.width - code.MGN_YOKO

// ＯＫボタン
cb_ok.width		= 340
cb_ok.y			= newheight - cb_ok.height - code.MGN_TATE * 2
cb_ok.x			= cb_cancel.x - cb_ok.width - code.MGN_GROUP_YOKO

// dw
dw_list.x		= 32
dw_list.y		= sle_filename.y + sle_filename.height + code.MGN_TATE
dw_list.width	= newwidth - code.MGN_YOKO * 2
dw_list.height	= cb_cancel.y - code.MGN_TATE * 2 - dw_list.y

return 0

end event

event update_event;call super::update_event;
long	l_strow
string	l_filename

l_filename	= trim(sle_filename.text)

// 開始位置
l_strow	= long(sle_start_pos.text)

if isnull(l_strow) or l_strow < 1 then
	l_strow	= 1
end if

// 配列に値をセット
if dw_list.rowcount() > 0 then
	i_str_fileread.ret[1].filename	= l_filename
	i_str_fileread.ret[1].startrow	= l_strow
end if

closewithreturn(this,i_str_fileread)


end event

event close;call super::close;
//closewithreturn(this,i_str_fileread)

return 0
end event

event retrieve_check;call super::retrieve_check;
// 直接入力の場合はチェック不要
if i_retreive then
	return 0
end if

// リトリーブ前の事前チェック
// 入力チェック
if not sle_filename.event input_check() then
	return -1
end if

end event

type uo_signal from iw_modal_window`uo_signal within iw_fileread_window
boolean visible = true
end type

type st_date from iw_modal_window`st_date within iw_fileread_window
boolean visible = true
end type

type st_user_mei from iw_modal_window`st_user_mei within iw_fileread_window
end type

type uo_test_mode from iw_modal_window`uo_test_mode within iw_fileread_window
end type

type p_size_adjust from iw_modal_window`p_size_adjust within iw_fileread_window
end type

type st_title from iw_modal_window`st_title within iw_fileread_window
boolean visible = false
integer width = 344
string text = "ファイル読込"
end type

type st_title_upper from iw_modal_window`st_title_upper within iw_fileread_window
boolean visible = false
end type

type st_upper from iw_modal_window`st_upper within iw_fileread_window
boolean visible = false
end type

type st_tail from iw_modal_window`st_tail within iw_fileread_window
boolean visible = false
end type

type cb_ok from iw_modal_window`cb_ok within iw_fileread_window
end type

type cb_cancel from iw_modal_window`cb_cancel within iw_fileread_window
end type

type dw_list from iw_modal_window`dw_list within iw_fileread_window
integer x = 76
integer y = 299
string dataobject = "dld_fileread"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean enter_key = false
boolean enter2tab = false
boolean save_excel = false
end type

event constructor;call super::constructor;
// トランザクション接続
dw_list.dataobject	= "dld_fileread"
this.reset()
this.settransobject(cocos)


end event

type cb_retrieve from iw_modal_window`cb_retrieve within iw_fileread_window
boolean visible = false
integer x = 1220
integer y = 462
end type

type st_filename from ivo_statictext within iw_fileread_window
integer x = 32
integer y = 188
integer width = 408
boolean bringtotop = true
string text = "ファイル名"
alignment alignment = right!
end type

type sle_filename from ivo_singlelineedit within iw_fileread_window
integer x = 460
integer y = 181
integer width = 2680
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

event constructor;call super::constructor;
this.enabled	= true
this.text		= ""


end event

event input_check;call super::input_check;
string	l_file
int		l_fileno
long 	l_pos
string	l_ext



l_file	= trim( sle_filename.text )

if lena( l_file ) > 0 then
	// 存在チェック
	if not fileexists( l_file ) then
		// 
		msg.of_error_sle( this, fnc.strg.of_format( "指定されたファイルの読み込みが出来ません。指定したファイル名を確認してください。", "" ) )
		return false
	end if

	// ファイル使用中チェック
	l_fileno = fileopen( l_file, LineMode!, Write!, LockReadWrite!, Append! )
	if l_fileno = -1 then
		// 指定されたファイルは使用中です
		msg.of_error_sle( this, fnc.strg.of_format( "指定されたファイルは使用中です。", "" ) )
		return false
	end if
	fileclose( l_fileno )

	// 拡張子チェック
	l_pos = LastPos( l_file, "." )
	// 拡張子取得
	l_ext = upper( mid( l_file, l_pos, len( l_file ) ) )

	// ".XLSX", ".CSV", ".TXT", ".DAT" 以外はエラー
	choose case l_ext
		case ".XLSX", ".CSV", ".TXT", ".DAT"
			// OK
		case else	
			msg.of_error_sle( this, fnc.strg.of_format( "使用可能なファイルではありません。", "" ) )
			return false
	end choose

	// 直接入力された時
	if i_retreive then
		// 読込実行	
		cb_retrieve.event execution( 0, 0 )
	end if

	
end if

return true
end event

type cb_filename from sv_cb_modal within iw_fileread_window
integer x = 3160
integer y = 181
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = shiftjis!
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.enabled	= true
end event

event execution;call super::execution;

string	ls_file
string	ls_string
string	ls_filter
long 	ll_pos
string	ls_ext
String	ls_dir

ls_file	= trim( sle_filename.text )

//if lena( ls_file ) > 0 then
//
//	ll_pos = LastPos( ls_file, "." ) + 1
//		// 拡張子取得
//	ls_ext = upper( mid( ls_file, ll_pos, len( ls_file ) ) )
//
//	if ll_pos = 0 then
//		ls_dir = ls_file
//	else
//		ls_dir = mid( ls_file, 1, lastpos( ls_file, "\" ) - 1 )
//	end if
//
//end if

//ls_filter	=  "Excel Files (*.XLSX),*.XLSX;*.xlsx, CSV Files (*.CSV),*.CSV;*.csv, TEXT Files (*.TXT),*.txt;*.TXT, DAT Files (*.DAT),*.dat;*.DAT "
ls_filter	=  "Import Files (*.XLSX;*.CSV;*.TXT;*.DAT),*.XLSX;*.xlsx;*.CSV;*.csv;*.txt;*.TXT;*.dat;*.DAT"

if getfileopenname( "ファイルを開く", ls_file, ls_string, ls_ext, ls_filter ) = 1 then
	sle_filename.text	= ls_file
	sle_filename.event input_check()
end if


return 0
end event

type sle_start_pos from ivo_singlelineedit within iw_fileread_window
integer x = 460
integer y = 715
integer width = 88
integer taborder = 50
boolean bringtotop = true
integer init_imemode = 3
string text = "0"
end type

event constructor;call super::constructor;
this.enabled	= true
this.text		= "1"


end event

type st_start_pos from ivo_statictext within iw_fileread_window
integer x = 28
integer y = 722
integer width = 408
boolean bringtotop = true
string text = "取込開始行"
alignment alignment = right!
end type

