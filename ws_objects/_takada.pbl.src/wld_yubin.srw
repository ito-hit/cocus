﻿$PBExportHeader$wld_yubin.srw
$PBExportComments$郵便番号アップロード登録
forward
global type wld_yubin from iw_main_window
end type
type st_status from ivo_statictext within wld_yubin
end type
type st_msg from ivo_statictext within wld_yubin
end type
type cb_clear from ivo_commandbutton within wld_yubin
end type
type dw_list from ivo_datawindow within wld_yubin
end type
type st_filename_t from ivo_statictext within wld_yubin
end type
type st_filename from ivo_statictext within wld_yubin
end type
type st_cnt_t from ivo_statictext within wld_yubin
end type
type st_cnt from ivo_statictext within wld_yubin
end type
type st_okcnt_t from ivo_statictext within wld_yubin
end type
type st_okcnt from ivo_statictext within wld_yubin
end type
type st_errcnt_t from ivo_statictext within wld_yubin
end type
type st_errcnt from ivo_statictext within wld_yubin
end type
type st_warncnt_t from ivo_statictext within wld_yubin
end type
type st_warncnt from ivo_statictext within wld_yubin
end type
type ddplb_status from ivo_dropdownpicturelistbox within wld_yubin
end type
type ddplb_msg from ivo_dropdownpicturelistbox within wld_yubin
end type
type ddplb_data_kbn from sv_ddplb_meisyo within wld_yubin
end type
type st_data_kbn_t from ivo_statictext within wld_yubin
end type
type hpb_progres from ivo_hprogressbar within wld_yubin
end type
end forward

global type wld_yubin from iw_main_window
string title = "郵便番号アップロード登録"
boolean f7_key = true
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
ddplb_status ddplb_status
ddplb_msg ddplb_msg
ddplb_data_kbn ddplb_data_kbn
st_data_kbn_t st_data_kbn_t
hpb_progres hpb_progres
end type
global wld_yubin wld_yubin

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
public subroutine of_dsp_reset ()
public subroutine of_data_count ()
public subroutine of_filter_make ()
public subroutine of_filter_set ()
public function boolean of_db_update ()
public function integer of_fileread_excel (string p_filename)
end prototypes

event dropfile;
// -----------------------------------------------------------------------
//	イベント	:	dropfiles
//	処理概要	:	外部からファイルをドラッグしたときに走るイベント
//	返り値		:	成否( 0:成功 1:失敗 )
// -----------------------------------------------------------------------
nv_dropfile	l_dropfile

if l_dropfile.of_dragqueryfile(handle,i_dragfile_cnt,i_dragfile) <> 0 then
	return 1
end if

if not isnull(i_dragfile) and i_dragfile_cnt > 0 then
	l_dropfile.of_mouseevent()

	i_str_fileread.ret[1].filename	= i_dragfile[1]
	// ファイル読込画面起動
	this.event key_f07(KeyF7!,0)
end if

return 0

end event

public function boolean of_erorr_check ();
// 関連項目値セット＆エラーチェック
long	l_row
long	l_cnt

string	l_status
string	l_msg

long	l_err_cnt	= 0

long	l_yubin_no

// (速度対策)DWObject参照定義
dwobject dwlo_status
dwobject dwlo_msg
dwobject dwlo_jis_code
dwobject dwlo_yubin_no
dwobject dwlo_todofu_mei
dwobject dwlo_sikutyo_mei
dwobject dwlo_jigyosyo_mei
dwobject dwlo_kbn_1
dwobject dwlo_kbn_2
dwobject dwlo_kbn_3
dwobject dwlo_kbn_4
dwobject dwlo_kbn_5
dwobject dwlo_kbn_6
dwobject dwlo_kbn_7
dwobject dwlo_kbn_8
dwobject dwlo_kbn_9

dwlo_status       = dw_list.object.status
dwlo_msg          = dw_list.object.msg
dwlo_jis_code     = dw_list.object.jis_code
dwlo_yubin_no     = dw_list.object.yubin_no
dwlo_todofu_mei   = dw_list.object.todofu_mei
dwlo_sikutyo_mei  = dw_list.object.sikutyo_mei
dwlo_jigyosyo_mei = dw_list.object.jigyosyo_mei
dwlo_kbn_1        = dw_list.object.kbn_1
dwlo_kbn_2        = dw_list.object.kbn_2
dwlo_kbn_3        = dw_list.object.kbn_3
dwlo_kbn_4        = dw_list.object.kbn_4
dwlo_kbn_5        = dw_list.object.kbn_5
dwlo_kbn_6        = dw_list.object.kbn_6
dwlo_kbn_7        = dw_list.object.kbn_7
dwlo_kbn_8        = dw_list.object.kbn_8
dwlo_kbn_9        = dw_list.object.kbn_9

for l_row = 1 to dw_list.rowcount()
	// エラー100件超えたら処理中断
	if l_err_cnt > 100 then
		msg.of_error("エラーチェック時のエラー件数が100件を超えました。処理を中断します。")
		return false
	end if
	
	choose case integer(ddplb_data_kbn.of_get_code())
		case 1	//町域データ
			if (dwlo_jis_code.primary[l_row] < 1000) or (dwlo_jis_code.primary[l_row] > 49999) then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "地方公共団体コードに誤りがあります"
				continue
			end if
			l_yubin_no = long(left(dwlo_yubin_no.primary[l_row],3))*10000 + long(right(dwlo_yubin_no.primary[l_row],4))
			if l_yubin_No < 0 or l_yubin_no > 9999999 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "郵便番号に誤りがあります"
				continue
			end if
			
			if trim(dwlo_todofu_mei.primary[l_row]) = "" then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "都道府県名がありません"
				continue
			end if
			if trim(dwlo_sikutyo_mei.primary[l_row]) = "" then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "市区町村名がありません"
				continue
			end if

			if dwlo_kbn_1.primary[l_row] < 0 or dwlo_kbn_1.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分1に誤りがあります"
				continue
			end if
			if dwlo_kbn_2.primary[l_row] < 0 or dwlo_kbn_2.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分2に誤りがあります"
				continue
			end if
			if dwlo_kbn_3.primary[l_row] < 0 or dwlo_kbn_3.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分3に誤りがあります"
				continue
			end if
			if dwlo_kbn_4.primary[l_row] < 0 or dwlo_kbn_4.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分4に誤りがあります"
				continue
			end if
			if dwlo_kbn_5.primary[l_row] < 0 or dwlo_kbn_5.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分5に誤りがあります"
				continue
			end if
			if dwlo_kbn_6.primary[l_row] < 0 or dwlo_kbn_6.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分6に誤りがあります"
				continue
			end if
			
		case 2	//事業所データ
			if dwlo_jis_code.primary[l_row] < 1000 or dwlo_jis_code.primary[l_row] > 49999 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "地方公共団体コードに誤りがあります"
				continue
			end if
			l_yubin_no = long(left(dwlo_yubin_no.primary[l_row],3))*10000 + long(right(dwlo_yubin_no.primary[l_row],4))
			if l_yubin_No < 0 or l_yubin_no > 9999999 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "郵便番号に誤りがあります"
				continue
			end if

			if trim(dwlo_todofu_mei.primary[l_row]) = "" then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "都道府県名がありません"
				continue
			end if
			if trim(dwlo_sikutyo_mei.primary[l_row]) = "" then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "市区町村名がありません"
				continue
			end if

			if trim(dwlo_jigyosyo_mei.primary[l_row]) = "" then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "大口事業所名がありません"
				continue
			end if

			if dwlo_kbn_7.primary[l_row] < 0 or dwlo_kbn_7.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分7に誤りがあります"
				continue
			end if
			if dwlo_kbn_8.primary[l_row] < 0 or dwlo_kbn_8.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分8に誤りがあります"
				continue
			end if
			if dwlo_kbn_9.primary[l_row] < 0 or dwlo_kbn_9.primary[l_row] > 9 then
				l_err_cnt	= l_err_cnt + 1
				dwlo_status.primary[l_row]	= "エラー"
				dwlo_msg.primary[l_row]		= "区分9に誤りがあります"
				continue
			end if
			
	end choose
next

return true

end function

public subroutine of_dsp_reset ();
string	l_nendo_mei
long	l_kisyo_nengetu
long	l_indx

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
ddplb_status.event constructor()
ddplb_msg.event constructor()

dw_list.event constructor()
cb_retrieve.event constructor()

st_filename.event constructor()
st_cnt.event constructor()
st_okcnt.event constructor()
st_errcnt.event constructor()
st_warncnt.event constructor()

end subroutine

public subroutine of_data_count ();
// 件数セット
long	l_okcnt		= 0
long	l_errcnt	= 0
long	l_warncnt	= 0
long	l_row
string	l_status
string	l_filter_status
string	l_filter_msg

dwobject dwlo_status
dwlo_status = dw_list.object.status

// フィルター解除
// 解除前条件保持
l_filter_status	= ddplb_status.text
l_filter_msg	= ddplb_msg.text
ddplb_status.text	= "(未選択)"
ddplb_msg.text		= "(未選択)"
of_filter_set()

for l_row = 1 to dw_list.rowcount()
	l_status = dwlo_status.primary[l_row]
	
	choose case l_status
		case "エラー"
			l_errcnt = l_errcnt + 1
			
		case "警告"
			l_warncnt = l_warncnt + 1
			
		case else
			l_okcnt = l_okcnt + 1
			
	end choose
next

// 値をセット
st_cnt.text		= string(dw_list.rowcount())
st_okcnt.text	= string(l_okcnt)
st_errcnt.text	= string(l_errcnt)
st_warncnt.text	= string(l_warncnt)

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

dwobject dwlo_status
dwobject dwlo_msg

dwlo_status = dw_list.object.status
dwlo_msg    = dw_list.object.msg

// 初期化
ddplb_status.event constructor()
ddplb_msg.event constructor()

for l_row = 1 to dw_list.rowcount()
	l_status	= dwlo_status.primary[l_row]
	l_msg		= dwlo_msg.primary[l_row]
	
	// ステータス
	//l_rtn	= ddplb_status.FindItem(l_status,0)
	
	if ddplb_status.FindItem(l_status,0) = -1 then
		ddplb_status.insertitem(l_status,upperbound(ddplb_status.item) + 1)
	end if
	
	// メッセージ
	if ddplb_msg.finditem(l_msg,0) = -1 then
		ddplb_msg.insertitem(l_msg,upperbound(ddplb_msg.item) + 1)
	end if
next

end subroutine

public subroutine of_filter_set ();
// フィルター実行
string	l_status
string	l_msg

integer	l_row
string	l_filter	= ""

l_status	= ddplb_status.text
l_msg		= ddplb_msg.text

l_row	= dw_list.getrow()
dw_list.setredraw(false)

// フィルタのリセット
dw_list.setfilter("")
dw_list.filter()

// ステータス
if l_status <> "(未選択)" then
	l_filter = "status = '" + l_status + "'"
end if

// メッセージ
if l_msg <> "(未選択)" then
	if len( l_filter ) <> 0 then
		l_filter = l_filter + " and msg = '" + l_msg + "'"
	else
		l_filter = "msg = '" + l_msg + "'"
	end if
end if

if len(l_filter) <> 0 then
	// フィルタセット
	dw_list.setfilter(l_filter)
	dw_list.filter()
end if

dw_list.setredraw(true)
end subroutine

public function boolean of_db_update ();
// DB更新処理
// 排他フラグが1件でもONとなっている場合、全RollBack後エラーとする
long	l_row
long	l_cnt

integer	l_data_kbn

// (速度対策)DWObject参照定義
dwobject dwlo_jis_code
dwobject dwlo_yubin_no_old
dwobject dwlo_yubin_no
dwobject dwlo_todofu_kana
dwobject dwlo_sikutyo_kana
dwobject dwlo_tyoiki_kana
dwobject dwlo_todofu_mei
dwobject dwlo_sikutyo_mei
dwobject dwlo_tyoiki_mei
dwobject dwlo_tyome
dwobject dwlo_jigyosyo_mei
dwobject dwlo_full_mei
dwobject dwlo_kbn_1
dwobject dwlo_kbn_2
dwobject dwlo_kbn_3
dwobject dwlo_kbn_4
dwobject dwlo_kbn_5
dwobject dwlo_kbn_6
dwobject dwlo_kbn_7
dwobject dwlo_kbn_8
dwobject dwlo_kbn_9

long	l_jis_code
string	l_yubin_no,l_yubin_no_old
string	l_todofu_mei,l_sikutyo_mei,l_tyoiki_mei
string	l_todofu_kana,l_sikutyo_kana,l_tyoiki_kana
string	l_tyome
string	l_jigyosyo_mei
string	l_full_mei
integer	l_kbn_1,l_kbn_2,l_kbn_3,l_kbn_4,l_kbn_5,l_kbn_6,l_kbn_7,l_kbn_8,l_kbn_9
string	l_touroku_date, l_touroku_user_id, l_touroku_client_id, l_touroku_pg_id

// 取込対象区分データ削除
l_data_kbn	= integer(ddplb_data_kbn.of_get_code())	//データ区分
delete from m_yubin
 where data_kbn = :l_data_kbn
 using cocos;

// (速度対策)DWObject参照定義
dwlo_jis_code     = dw_list.object.jis_code		//全国地方公共団体コード
dwlo_yubin_no_old = dw_list.object.yubin_no_old	//郵便番号(旧)
dwlo_yubin_no     = dw_list.object.yubin_no		//郵便番号
dwlo_todofu_kana  = dw_list.object.todofu_kana	//都道府県名(カナ)
dwlo_sikutyo_kana = dw_list.object.sikutyo_kana	//市区町村名(カナ)
dwlo_tyoiki_kana  = dw_list.object.tyoiki_kana	//町域名(カナ)
dwlo_todofu_mei   = dw_list.object.todofu_mei	//都道府県
dwlo_sikutyo_mei  = dw_list.object.sikutyo_mei	//市区町村名
dwlo_tyoiki_mei   = dw_list.object.tyoiki_mei	//町域名
dwlo_tyome        = dw_list.object.tyome		//小字・丁目・番地等
dwlo_jigyosyo_mei = dw_list.object.jigyosyo_mei	//事業所名
dwlo_full_mei     = dw_list.object.full_mei		//フル住所
dwlo_kbn_1        = dw_list.object.kbn_1		//区分1(町域)
dwlo_kbn_2        = dw_list.object.kbn_2		//区分2(町域)
dwlo_kbn_3        = dw_list.object.kbn_3		//区分3(町域)
dwlo_kbn_4        = dw_list.object.kbn_4		//区分4(町域)
dwlo_kbn_5        = dw_list.object.kbn_5		//区分5(町域)
dwlo_kbn_6        = dw_list.object.kbn_6		//区分6(町域)
dwlo_kbn_7        = dw_list.object.kbn_7		//区分1(事業所)
dwlo_kbn_8        = dw_list.object.kbn_8		//区分2(事業所)
dwlo_kbn_9        = dw_list.object.kbn_9		//区分3(事業所)

// 取込データ更新開始
hpb_progres.maxposition = dw_list.rowcount()
hpb_progres.position = 0

for l_row = 1 to dw_list.rowcount()
	hpb_progres.position = l_row

	// 登録データ取得
	l_jis_code		= dwlo_jis_code.primary[l_row]		//全国地方公共団体コード
	l_yubin_no_old	= dwlo_yubin_no_old.primary[l_row]	//郵便番号(旧)
	l_yubin_no		= dwlo_yubin_no.primary[l_row]		//郵便番号
	
	l_todofu_mei	= dwlo_todofu_mei.primary[l_row]	//都道府県
	l_sikutyo_mei	= dwlo_sikutyo_mei.primary[l_row]	//市区町村名
	l_tyoiki_mei	= dwlo_tyoiki_mei.primary[l_row]	//町域名
	
	l_todofu_kana	= dwlo_todofu_kana.primary[l_row]	//都道府県名(カナ)
	l_sikutyo_kana	= dwlo_sikutyo_kana.primary[l_row]	//市区町村名(カナ)
	l_tyoiki_kana	= dwlo_tyoiki_kana.primary[l_row]	//町域名(カナ)
	
	l_tyome			= dwlo_tyome.primary[l_row]			//小字・丁目・番地等
	
	l_jigyosyo_mei	= dwlo_jigyosyo_mei.primary[l_row]	//事業所名
	
	l_full_mei		= dwlo_full_mei.primary[l_row]		//フル住所
	
	l_kbn_1			= dwlo_kbn_1.primary[l_row]			//区分1(町域)
	l_kbn_2			= dwlo_kbn_2.primary[l_row]			//区分2(町域)
	l_kbn_3			= dwlo_kbn_3.primary[l_row]			//区分3(町域)
	l_kbn_4			= dwlo_kbn_4.primary[l_row]			//区分4(町域)
	l_kbn_5			= dwlo_kbn_5.primary[l_row]			//区分5(町域)
	l_kbn_6			= dwlo_kbn_6.primary[l_row]			//区分6(町域)
	
	l_kbn_7			= dwlo_kbn_7.primary[l_row]			//区分1(事業所)
	l_kbn_8			= dwlo_kbn_8.primary[l_row]			//区分2(事業所)
	l_kbn_9			= dwlo_kbn_9.primary[l_row]			//区分3(事業所)

	// 郵便番号M追加
	insert into m_yubin (
		data_kbn,
		jis_code,
		yubin_no_old,yubin_no,
		todofu_kana,sikutyo_kana,tyoiki_kana,
		todofu_mei,sikutyo_mei,tyoiki_mei,
		tyome,
		jigyosyo_mei,
		full_mei,
		kbn_1,kbn_2,kbn_3,
		kbn_4,kbn_5,kbn_6,
		kbn_7,kbn_8,kbn_9,
		touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id)
	values (
		:l_data_kbn,
		:l_jis_code,
		:l_yubin_no_old,:l_yubin_no,
		:l_todofu_kana,:l_sikutyo_kana,:l_tyoiki_kana,
		:l_todofu_mei,:l_sikutyo_mei,:l_tyoiki_mei,
		:l_tyome,
		:l_jigyosyo_mei,
		:l_full_mei,
		:l_kbn_1,:l_kbn_2,:l_kbn_3,
		:l_kbn_4,:l_kbn_5,:l_kbn_6,
		:l_kbn_7,:l_kbn_8,:l_kbn_9,
		SYSDATE,:user.user_id,:device.name,:i_pg_id)
	using cocos;
	
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error(fnc.strg.of_format("郵便番号マスタの更新処理でエラーが発生しました。{1}{2}：{3}",code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
		of_add_db_log("of_db_update", cocos.last_sqlerrcode,cocos.last_sqlerrtext)
		return false
	end if
	
	yield()
next

hpb_progres.position = 0

//登録完了
commit using cocos;

return true
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
	// EXCEL OLE接続に失敗

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
l_cnt = i_dts.importfile(Text!,l_savefile)

if l_cnt < 0 then
	// ファイル削除
	filedelete(l_savefile)
	return 1
end if

// ファイル削除
filedelete(l_savefile)

return 0
end function

on wld_yubin.create
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
this.ddplb_status=create ddplb_status
this.ddplb_msg=create ddplb_msg
this.ddplb_data_kbn=create ddplb_data_kbn
this.st_data_kbn_t=create st_data_kbn_t
this.hpb_progres=create hpb_progres
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
this.Control[iCurrent+15]=this.ddplb_status
this.Control[iCurrent+16]=this.ddplb_msg
this.Control[iCurrent+17]=this.ddplb_data_kbn
this.Control[iCurrent+18]=this.st_data_kbn_t
this.Control[iCurrent+19]=this.hpb_progres
end on

on wld_yubin.destroy
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
destroy(this.ddplb_status)
destroy(this.ddplb_msg)
destroy(this.ddplb_data_kbn)
destroy(this.st_data_kbn_t)
destroy(this.hpb_progres)
end on

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

hpb_progres.y = st_second_upper.y	+ st_second_upper.height - hpb_progres.height - 4
hpb_progres.width = newwidth - 16

// フィルター部
st_status.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_status.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
st_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.x			= l_width - cb_clear.width - code.MGN_YOKO

// フッター2
ddplb_data_kbn.y	= key_fnc.y - code.MGN_TATE - ddplb_data_kbn.height
st_data_kbn_t.y		= ddplb_data_kbn.y + 7

// フッター1
st_filename.y		= ddplb_data_kbn.y - code.MGN_TATE - st_filename.height
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
openwithparm(iw_fileread_window,i_str_fileread,this)

i_str_fileread = message.powerobjectparm

if upperbound(i_str_fileread.ret) > 0 then
	// ファイル名セット
	st_filename.text = i_str_fileread.ret[1].filename
	// ファイル読込結果を画面にセット
	cb_retrieve.event execution(0,0)
end if

return 0

end event

event open;call super::open;
// -------------------------------------------------------------
// ドラッグ＆ドロップの非許可
// -----------------------------------------------------------------
nv_dropfile	l_dropfile

l_dropfile.of_dragacceptfiles(Handle(This),True)

dw_list.setfocus()

end event

event retrieve_event;call super::retrieve_event;
// ファイル読込
string	l_file
long	l_row
long	l_cnt

long	l_data_kbn

// (速度対策)DWObject参照定義
dwobject dwlo_jis_code
dwobject dwlo_yubin_no_old
dwobject dwlo_yubin_no
dwobject dwlo_todofu_kana
dwobject dwlo_sikutyo_kana
dwobject dwlo_tyoiki_kana
dwobject dwlo_todofu_mei
dwobject dwlo_sikutyo_mei
dwobject dwlo_tyoiki_mei
dwobject dwlo_tyome
dwobject dwlo_jigyosyo_mei
dwobject dwlo_full_mei
dwobject dwlo_kbn_1
dwobject dwlo_kbn_2
dwobject dwlo_kbn_3
dwobject dwlo_kbn_4
dwobject dwlo_kbn_5
dwobject dwlo_kbn_6
dwobject dwlo_kbn_7
dwobject dwlo_kbn_8
dwobject dwlo_kbn_9

dwobject dso_data01
dwobject dso_data02
dwobject dso_data03
dwobject dso_data04
dwobject dso_data05
dwobject dso_data06
dwobject dso_data07
dwobject dso_data08
dwobject dso_data09
dwobject dso_data10
dwobject dso_data11
dwobject dso_data12
dwobject dso_data13
dwobject dso_data14
dwobject dso_data15

string	l_timer_1,l_timer_2,l_timer_3,l_timer_4

l_timer_1 = "データストアセット開始：" + String(Now(),"hh:mm:ss")

if upperbound(i_str_fileread.ret) > 0 then
	// データストア
	i_dts = create DataStore
	i_dts.dataobject = "dld_fileread"
	i_dts.reset()
	i_dts.settransobject(cocos)

	setredraw(false)

	dw_list.reset()

	l_file	= trim(i_str_fileread.ret[1].filename)

	// データストアにデータをセット
	if lena(l_file) > 0 then
		// ファイル読込
		choose case upper(mid(l_file,LastPos(l_file,"."),len(l_file)))
			case ".XLSX"
				if of_fileread_excel(l_file) <> 0 then
					msg.of_error("EXCEL読込に失敗しました。")
					return -1
				end if
				
			case ".CSV"
				i_dts.importfile(CSV!,l_file)
//				if of_fileread_csv(l_file) <> 0 then
//					msg.of_error("CSVL読込に失敗しました。")
//					return -1
//				end if
	
			case else	// TEXT、DAT
				i_dts.importfile(Text!,l_file)
//				if of_fileread_text(l_file) <> 0 then
//					msg.of_error("ファイル読込に失敗しました。")
//					return -1
//				end if
				
		end choose
	end if

	l_timer_2	= "データストアセット完了：" + String(Now(),"hh:mm:ss")
	
	// (速度対策)DWObject参照定義
	dwlo_jis_code     = dw_list.object.jis_code
	dwlo_yubin_no_old = dw_list.object.yubin_no_old
	dwlo_yubin_no     = dw_list.object.yubin_no
	dwlo_todofu_kana  = dw_list.object.todofu_kana
	dwlo_sikutyo_kana = dw_list.object.sikutyo_kana
	dwlo_tyoiki_kana  = dw_list.object.tyoiki_kana
	dwlo_todofu_mei   = dw_list.object.todofu_mei
	dwlo_sikutyo_mei  = dw_list.object.sikutyo_mei
	dwlo_tyoiki_mei   = dw_list.object.tyoiki_mei
	dwlo_tyome        = dw_list.object.tyome
	dwlo_jigyosyo_mei = dw_list.object.jigyosyo_mei
	dwlo_full_mei     = dw_list.object.full_mei
	dwlo_kbn_1        = dw_list.object.kbn_1
	dwlo_kbn_2        = dw_list.object.kbn_2
	dwlo_kbn_3        = dw_list.object.kbn_3
	dwlo_kbn_4        = dw_list.object.kbn_4
	dwlo_kbn_5        = dw_list.object.kbn_5
	dwlo_kbn_6        = dw_list.object.kbn_6
	dwlo_kbn_7        = dw_list.object.kbn_7
	dwlo_kbn_8        = dw_list.object.kbn_8
	dwlo_kbn_9        = dw_list.object.kbn_9
	
	dso_data01 = i_dts.object.data01
	dso_data02 = i_dts.object.data02
	dso_data03 = i_dts.object.data03
	dso_data04 = i_dts.object.data04
	dso_data05 = i_dts.object.data05
	dso_data06 = i_dts.object.data06
	dso_data07 = i_dts.object.data07
	dso_data08 = i_dts.object.data08
	dso_data09 = i_dts.object.data09
	dso_data10 = i_dts.object.data10
	dso_data11 = i_dts.object.data11
	dso_data12 = i_dts.object.data12
	dso_data13 = i_dts.object.data13
	dso_data14 = i_dts.object.data14
	dso_data15 = i_dts.object.data15

	// 画面に値をセット
	hpb_progres.maxposition = i_dts.rowcount()
	hpb_progres.position = 0
	
	l_data_kbn = integer(ddplb_data_kbn.of_get_code())
	
	for l_cnt = i_str_fileread.ret[1].startrow to i_dts.rowcount()
		l_row = dw_list.insertrow(0)
		
		hpb_progres.position = l_cnt

		choose case l_data_kbn
			case 1
				dwlo_jis_code.primary[l_row]		= long(dso_data01.primary[l_cnt])	//JIS-Code
				dwlo_yubin_no_old.primary[l_row]	= dso_data02.primary[l_cnt]	//(旧)郵便番号
				dwlo_yubin_no.primary[l_row]		= lefta(dso_data03.primary[l_cnt],3) + "-" + righta(dso_data03.primary[l_cnt],4)	//郵便番号
				dwlo_todofu_kana.primary[l_row]		= lefta(dso_data04.primary[l_cnt],7)	//都道府県名(カナ)
				dwlo_sikutyo_kana.primary[l_row]	= lefta(dso_data05.primary[l_cnt],20)	//市区町村名(カナ)
				dwlo_tyoiki_kana.primary[l_row]		= lefta(dso_data06.primary[l_cnt],20)	//町域名(カナ) > ※本来項目長76byte 現DB定義過少(20byte)のため強制カット
				dwlo_todofu_mei.primary[l_row]		= lefta(dso_data07.primary[l_cnt],8)	//都道府県名
				dwlo_sikutyo_mei.primary[l_row]		= lefta(dso_data08.primary[l_cnt],24)	//市区町村名
				dwlo_tyoiki_mei.primary[l_row]		= lefta(dso_data09.primary[l_cnt],80)	//町域名
				dwlo_tyome.primary[l_row]			= ""	//小字名・丁目・番地
				dwlo_jigyosyo_mei.primary[l_row]	= ""	//大口事業所名
				dwlo_full_mei.primary[l_row]		= lefta((trim(dso_data07.primary[l_cnt]) + trim(dso_data08.primary[l_cnt]) + trim(dso_data09.primary[l_cnt])),200)	//住所
				dwlo_kbn_1.primary[l_row]			= integer(dso_data10.primary[l_cnt])	//区分1
				dwlo_kbn_2.primary[l_row]			= integer(dso_data11.primary[l_cnt])	//区分2
				dwlo_kbn_3.primary[l_row]			= integer(dso_data12.primary[l_cnt])	//区分3
				dwlo_kbn_4.primary[l_row]			= integer(dso_data13.primary[l_cnt])	//区分1
				dwlo_kbn_5.primary[l_row]			= integer(dso_data14.primary[l_cnt])	//区分2
				dwlo_kbn_6.primary[l_row]			= integer(dso_data15.primary[l_cnt])	//区分3
				dwlo_kbn_7.primary[l_row]			= 0	//区分7
				dwlo_kbn_8.primary[l_row]			= 0	//区分8
				dwlo_kbn_9.primary[l_row]			= 0	//区分9
				
			case 2
				dwlo_jis_code.primary[l_row]		= long(dso_data01.primary[l_cnt])	//JIS-Code
				dwlo_yubin_no.primary[l_row]		= lefta(dso_data08.primary[l_cnt],3) + "-" + righta(dso_data08.primary[l_cnt],4)	//大口事業所個別番号
				dwlo_yubin_no_old.primary[l_row]	= dso_data09.primary[l_cnt]	//(旧)郵便番号
				dwlo_todofu_kana.primary[l_row]		= ""	//都道府県名(カナ)
				dwlo_sikutyo_kana.primary[l_row]	= ""	//市区町村名(カナ)
				dwlo_tyoiki_kana.primary[l_row]		= ""	//町域名(カナ)
				dwlo_todofu_mei.primary[l_row]		= lefta(dso_data04.primary[l_cnt],8)	//都道府県名
				dwlo_sikutyo_mei.primary[l_row]		= lefta(dso_data05.primary[l_cnt],24)	//市区町村名
				dwlo_tyoiki_mei.primary[l_row]		= lefta(dso_data06.primary[l_cnt],80)	//町域名
				dwlo_tyome.primary[l_row]			= lefta(dso_data07.primary[l_cnt],124)	//小字名・丁目・番地
				dwlo_jigyosyo_mei.primary[l_row]	= lefta(dso_data03.primary[l_cnt],160)	//大口事業所名
				dwlo_full_mei.primary[l_row]		= lefta((trim(dso_data04.primary[l_cnt]) + trim(dso_data05.primary[l_cnt]) + trim(dso_data06.primary[l_cnt]) + trim(dso_data07.primary[l_cnt])),200)	//住所
				dwlo_kbn_1.primary[l_row]			= 0	//区分1
				dwlo_kbn_2.primary[l_row]			= 0	//区分2
				dwlo_kbn_3.primary[l_row]			= 0	//区分3
				dwlo_kbn_4.primary[l_row]			= 0	//区分4
				dwlo_kbn_5.primary[l_row]			= 0	//区分5
				dwlo_kbn_6.primary[l_row]			= 0	//区分6
				dwlo_kbn_7.primary[l_row]			= integer(dso_data11.primary[l_cnt])	//区分7
				dwlo_kbn_8.primary[l_row]			= integer(dso_data12.primary[l_cnt])	//区分8
				dwlo_kbn_9.primary[l_row]			= integer(dso_data13.primary[l_cnt])	//区分9
				
		end choose
		
		yield()
	next

	hpb_progres.position = 0
	
	l_timer_3 = "画面セット完了：" + String(Now(),"hh:mm:ss")

	// エラーチェック
	if of_erorr_check() = false then
		setredraw(true)
		return 1
	end if

	// 件数セット
	of_data_count()
	
	// フィルタ条件セット
	of_filter_make()
	
	// 構造体初期化
	i_str_fileread	= i_para_reset
	
	setredraw(true)
end if

l_timer_4 = "全処理完了：" + String(Now(),"hh:mm:ss")
//msg.of_info(fnc.strg.of_format("{1}{2}{3}{4}{5}{6}{7}",l_timer_1,code.CRLF,l_timer_2,code.CRLF,l_timer_3,code.CRLF,l_timer_4))

return 0

end event

event openquery;call super::openquery;
of_dsp_reset()

end event

event update_event;call super::update_event;
// 更新処理
string	l_rowcount
string	l_timer_s,l_timer_e

l_timer_s = "データ更新開始：" + String(Now(),"hh:mm:ss")

if not of_db_update() then
	rollback using cocos;
	return -1
end if

commit using cocos;

l_timer_e = "データ更新完了：" + String(Now(),"hh:mm:ss")

l_rowcount	= string(dw_list.rowcount(),"\ \ \ \ \ \ \ 0" ) + "件"
//msg.of_info( fnc.strg.of_format("正常終了しました{1}{2}{3}{1}{4}{1}{5}",code.crlf,"更新件数：",l_rowcount,l_timer_s,l_timer_e))

// 画面初期化
of_dsp_reset()

return 0
end event

event key_f01;call super::key_f01;
// 全選択
long	l_row
long	l_mode	// 1:全選択/0:全解除

// チェック全選択状態時のみ全解除処理、でなければ全選択処理
if dw_list.find("chk = 1",1,dw_list.rowcount()) = dw_list.rowcount() then
	l_mode	= 0
else
	l_mode	= 1
end if

for l_row = 1 TO dw_list.rowcount()
	 dw_list.object.chk[l_row] = l_mode
next

return 0
end event

event key_f03;call super::key_f03;
// 行削除
long	l_row

setredraw(false)

// チェックONの行を削除
for l_row = dw_list.rowcount() to 1 step -1
	if dw_list.object.chk[l_row] = 1 then
		dw_list.deleterow(l_row)
	end if
next

// 件数再セット
of_data_count()

setredraw(true)

return 0

end event

event update_check;call super::update_check;
// フィルター解除
cb_clear.event execution(0,0)

// エラー行がある場合は更新しない
if dw_list.find("status = 'エラー'",1,dw_list.rowcount()) > 0 then
	msg.of_error("エラー行がある為更新出来ません。エラー行を削除して下さい。")
	return -1
end if

return 0
end event

event key_f12;call super::key_f12;
if not of_evt_update(0,0) then
	return -1
end if

return 0


end event

type uo_signal from iw_main_window`uo_signal within wld_yubin
end type

type st_date from iw_main_window`st_date within wld_yubin
end type

type st_user_mei from iw_main_window`st_user_mei within wld_yubin
end type

type uo_test_mode from iw_main_window`uo_test_mode within wld_yubin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wld_yubin
end type

type st_title from iw_main_window`st_title within wld_yubin
end type

type st_title_upper from iw_main_window`st_title_upper within wld_yubin
end type

type st_upper from iw_main_window`st_upper within wld_yubin
end type

type st_second_upper from iw_main_window`st_second_upper within wld_yubin
boolean f6_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wld_yubin
end type

event constructor;call super::constructor;
this.visible	= false
end event

type st_status from ivo_statictext within wld_yubin
integer x = 32
integer y = 384
integer width = 408
boolean bringtotop = true
string text = "ステータス"
alignment alignment = right!
end type

type st_msg from ivo_statictext within wld_yubin
integer x = 908
integer y = 395
integer width = 408
boolean bringtotop = true
string text = "メッセージ"
alignment alignment = right!
end type

type cb_clear from ivo_commandbutton within wld_yubin
integer x = 3664
integer y = 380
integer width = 408
integer taborder = 50
boolean bringtotop = true
string text = "条件クリア"
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event execution;call super::execution;
// フィルター解除

ddplb_status.selectitem ( "(未選択)", 0 )
ddplb_msg.selectitem ( "(未選択)", 0 )

of_filter_set()


return 0

end event

type dw_list from ivo_datawindow within wld_yubin
integer x = 32
integer y = 498
integer width = 4656
integer height = 1365
integer taborder = 40
boolean bringtotop = true
string dataobject = "dld_yubin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.reset()
this.settransobject(cocos)


end event

type st_filename_t from ivo_statictext within wld_yubin
integer x = 32
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込ファイル"
alignment alignment = right!
end type

type st_filename from ivo_statictext within wld_yubin
integer x = 380
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

type st_cnt_t from ivo_statictext within wld_yubin
integer x = 2008
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込件数"
alignment alignment = right!
end type

type st_cnt from ivo_statictext within wld_yubin
integer x = 2356
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

type st_okcnt_t from ivo_statictext within wld_yubin
integer x = 2664
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "正常件数"
alignment alignment = right!
end type

type st_okcnt from ivo_statictext within wld_yubin
integer x = 3012
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

type st_errcnt_t from ivo_statictext within wld_yubin
integer x = 3320
integer y = 1916
integer width = 408
boolean bringtotop = true
string text = "エラー件数"
alignment alignment = right!
end type

type st_errcnt from ivo_statictext within wld_yubin
integer x = 3748
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

type st_warncnt_t from ivo_statictext within wld_yubin
integer x = 4056
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "警告件数"
alignment alignment = right!
end type

type st_warncnt from ivo_statictext within wld_yubin
integer x = 4404
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

type ddplb_status from ivo_dropdownpicturelistbox within wld_yubin
integer x = 460
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
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset()
this.enabled	= true
this.insertitem("(未選択)",upperbound(this.item) + 1)
this.selectitem("(未選択)",1)


end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type ddplb_msg from ivo_dropdownpicturelistbox within wld_yubin
integer x = 1336
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
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset()
this.enabled	= true
this.insertitem("(未選択)",upperbound(this.item) + 1)
this.selectitem("(未選択)",1)


end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type ddplb_data_kbn from sv_ddplb_meisyo within wld_yubin
integer x = 384
integer y = 2005
integer taborder = 50
boolean bringtotop = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
integer i_limit = 2
integer meisyo_kbn = 144
string init_code = "1"
end type

type st_data_kbn_t from ivo_statictext within wld_yubin
integer x = 32
integer y = 2016
integer width = 328
boolean bringtotop = true
string text = "データ区分"
alignment alignment = right!
end type

type hpb_progres from ivo_hprogressbar within wld_yubin
integer x = 8
integer y = 334
integer height = 21
boolean bringtotop = true
unsignedinteger position = 0
boolean smoothscroll = true
end type
