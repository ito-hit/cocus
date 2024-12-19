$PBExportHeader$_wld_tyakuten.srw
$PBExportComments$郵便番号アップロード登録
forward
global type _wld_tyakuten from iw_main_window
end type
type st_status from ivo_statictext within _wld_tyakuten
end type
type st_msg from ivo_statictext within _wld_tyakuten
end type
type cb_clear from ivo_commandbutton within _wld_tyakuten
end type
type dw_list from ivo_datawindow within _wld_tyakuten
end type
type st_filename_t from ivo_statictext within _wld_tyakuten
end type
type st_filename from ivo_statictext within _wld_tyakuten
end type
type st_cnt_t from ivo_statictext within _wld_tyakuten
end type
type st_cnt from ivo_statictext within _wld_tyakuten
end type
type st_okcnt_t from ivo_statictext within _wld_tyakuten
end type
type st_okcnt from ivo_statictext within _wld_tyakuten
end type
type st_errcnt_t from ivo_statictext within _wld_tyakuten
end type
type st_errcnt from ivo_statictext within _wld_tyakuten
end type
type st_warncnt_t from ivo_statictext within _wld_tyakuten
end type
type st_warncnt from ivo_statictext within _wld_tyakuten
end type
type ddplb_status from ivo_dropdownpicturelistbox within _wld_tyakuten
end type
type ddplb_msg from ivo_dropdownpicturelistbox within _wld_tyakuten
end type
type ddplb_data_kbn from sv_ddplb_meisyo within _wld_tyakuten
end type
type st_data_kbn_t from ivo_statictext within _wld_tyakuten
end type
type hpb_progress3 from ivo_hprogressbar within _wld_tyakuten
end type
end forward

global type _wld_tyakuten from iw_main_window
string title = "運送便着店アップロード登録"
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
ddplb_status ddplb_status
ddplb_msg ddplb_msg
ddplb_data_kbn ddplb_data_kbn
st_data_kbn_t st_data_kbn_t
hpb_progress3 hpb_progress3
end type
global _wld_tyakuten _wld_tyakuten

type prototypes

// dropfile用
Subroutine DragAcceptFiles(ULong hWnd,Boolean fAccept) Library "Shell32.dll"
Subroutine DragFinish(ULong hDrop) Library "Shell32.dll"
Function Int DragQueryFileA(Long hDrop,Int iFile,ref String lpszFile,Int cch) Library "Shell32.dll" alias for "DragQueryFileA;Ansi"
Function Int DragQueryFile(Long hDrop,Int iFile,ref String lpszFile,Int cch) Library "Shell32.dll" alias for "DragQueryFileW;Unicode"
Subroutine mouse_event(ulong dwFlags,ulong dx,ulong dy,ulong cButtons,ulong dwExtraInfo) LIBRARY "user32.dll"

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
public subroutine of_dragacceptfiles (long p_handle, boolean p_accept)
public function long of_dragqueryfile (long p_handle, ref long p_filecnt, ref string p_file[])
public subroutine of_mouseevent ()
end prototypes

event dropfile;
// -----------------------------------------------------------------------
//	イベント	:	dropfiles
//	処理概要	:	外部からファイルをドラッグしたときに走るイベント
//	返り値		:	成否( 0:成功 1:失敗 )
// -----------------------------------------------------------------------
// get drag-drop file name
if of_dragqueryfile(handle,i_dragfile_cnt,i_dragfile) <> 0 then
	return 1
end if

if not isnull(i_dragfile) and i_dragfile_cnt > 0 then
	of_mouseevent()

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

for l_row = 1 to dw_list.rowcount()
//	// 初期化
//	l_status	= ""	// ステータス
//	l_msg		= ""	// メッセージ
//	
//	l_tokui_code		= dw_list.object.tokui_code[l_row]		// 得意先コード
//	l_gen_tanto_code	= dw_list.object.gen_tanto_code[l_row]	// 現担当者コード
//	l_sin_tanto_code	= dw_list.object.sin_tanto_code[l_row]	// 新担当者コード
//
//
//	// 警告チェック
//	if l_syusoku_flg = "1:対象" then
//		of_error_set(l_row,"警告","得意先が終息済み")
//		continue
//	end if
//	
//	if l_gen_tanto_code <> l_gen_tanto_code_ms then
//		of_error_set(l_row,"警告","現担当者がマスタと異なる")
//		continue
//	end if
//	
//	if l_sin_tanto_code = l_gen_tanto_code_ms then
//		of_error_set(l_row,"警告","変更なし")
//		continue
//	end if
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
ddplb_status.event constructor()
ddplb_msg.event constructor()

dw_list.event constructor()
cb_retrieve.event constructor()
//uo_nendo.event constructor()
//sle_month.event constructor()

st_filename.event constructor()
st_cnt.event constructor()
st_okcnt.event constructor()
st_errcnt.event constructor()
st_warncnt.event constructor()

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
		//l_indx	= uo_nendo.ddplb_nendo.SelectItem(l_nendo_mei,0)
		//uo_nendo.ddplb_nendo.event selectionchanged(l_indx)
		//sle_month.text = string(long(right(string(l_kisyo_nengetu),2)))
		
	case 100
		msg.of_error("マスタに存在しません。")
		
	case else
		msg.of_error(fnc.strg.of_format("入力チェック中にエラーが発生しました{1}（{2}）",code.crlf,fnc.strg.of_replace(cocos.sqlerrtext,code.lf," ")))
		
end choose



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

// フィルター解除
// 解除前条件保持
l_filter_status	= ddplb_status.text
l_filter_msg	= ddplb_msg.text
ddplb_status.text	= "(未選択)"
ddplb_msg.text		= "(未選択)"
of_filter_set()

for l_row = 1 to dw_list.rowcount()
	l_status = dw_list.object.status[l_row]
	
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

// 初期化
ddplb_status.event constructor()
ddplb_msg.event constructor()

for l_row = 1 to dw_list.rowcount()
	l_status	= dw_list.object.status[l_row]
	l_msg		= dw_list.object.msg[l_row]
	
	// ステータス
	l_rtn	= ddplb_status.FindItem(l_status,0)
	
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

// 取込データ更新開始
hpb_progress3.maxposition = dw_list.rowcount()
hpb_progress3.position = 0
for l_row = 1 to dw_list.rowcount()
	hpb_progress3.position = l_row

	// 登録データ取得
	l_jis_code		= dw_list.object.jis_code[l_row]		//全国地方公共団体コード
	l_yubin_no_old	= dw_list.object.yubin_no_old[l_row]	//郵便番号(旧)
	l_yubin_no		= dw_list.object.yubin_no[l_row]		//郵便番号
	
	l_todofu_mei	= dw_list.object.todofu_mei[l_row]		//都道府県
	l_sikutyo_mei	= dw_list.object.sikutyo_mei[l_row]		//市区町村名
	l_tyoiki_mei	= dw_list.object.tyoiki_mei[l_row]		//町域名
	
	l_todofu_kana	= dw_list.object.todofu_kana[l_row]		//都道府県名(カナ)
	l_sikutyo_kana	= dw_list.object.sikutyo_kana[l_row]	//市区町村名(カナ)
	l_tyoiki_kana	= dw_list.object.tyoiki_kana[l_row]		//町域名(カナ)
	
	l_tyome			= dw_list.object.tyome[l_row]			//小字・丁目・番地等
	
	l_jigyosyo_mei	= dw_list.object.jigyosyo_mei[l_row]	//事業所名
	
	l_full_mei		= dw_list.object.full_mei[l_row]		//フル住所
	
	l_kbn_1			= dw_list.object.kbn_1[l_row]		//区分1(町域)
	l_kbn_2			= dw_list.object.kbn_2[l_row]		//区分2(町域)
	l_kbn_3			= dw_list.object.kbn_3[l_row]		//区分3(町域)
	l_kbn_4			= dw_list.object.kbn_4[l_row]		//区分4(町域)
	l_kbn_5			= dw_list.object.kbn_5[l_row]		//区分5(町域)
	l_kbn_6			= dw_list.object.kbn_6[l_row]		//区分6(町域)
	
	l_kbn_7			= dw_list.object.kbn_7[l_row]		//区分1(事業所)
	l_kbn_8			= dw_list.object.kbn_8[l_row]		//区分2(事業所)
	l_kbn_9			= dw_list.object.kbn_9[l_row]		//区分3(事業所)
//	// 「変更なし」の場合はスキップ
//	if dw_list.object.msg[l_row] = "変更なし" then
//		continue
//	end if
//
//	l_tokui_code = dw_list.object.tokui_code[l_row]
//	l_tanto_code = dw_list.object.sin_tanto_code[l_row]
//
//	// 得意先担当者M排他チェック
//	select nvl(to_char(mm.henkou_date,'yyyy/mm/dd hh24:mi:ss'),'????/??/?? ??:??:??'),
//		   nvl(mm.henkou_user_id,'???'),
//		   nvl(mu.user_mei,'???'),
//		   nvl(mm.henkou_client_id,'???'),
//		   nvl(mm.henkou_pg_id,'???'),
//		   nvl(mw.window_name,'???')
//	  into :l_henkou_date,
//		   :l_henkou_user_id,:l_user_mei,
//		   :l_henkou_client_id,
//		   :l_henkou_pg_id,:l_window_mei
//	  from m_tokui_tanto mm,
//		   m_user mu,
//		   m_window mw
//	 where mm.henkou_user_id = mu.user_id(+)
//	   and mm.henkou_pg_id	 = mw.window_id(+)
//	   and mm.tokui_code	 = :l_tokui_code
//	   and mm.nengetu		 between :l_nengetu_from and :l_nengetu_to
//	   and mm.haita_flg		 = 1
//	   and rownum			 = 1
//	using cocos;
//	
//	choose case cocos.sqlcode
//		case 0
//			rollback using cocos;
//			msg.of_error(fnc.strg.of_format("他の端末で編集中です。{1}{2}{1}{3}{1}{4}～",code.crlf,l_user_mei,l_window_mei,l_henkou_date))
//			return false
//			
//		case 100
//			// 何もしない
//			
//		case else
//			rollback using cocos;
//			msg.of_error_db("レコードロックでエラーが発生しました。", cocos )
//			return false
//			
//	end choose
//
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
next

//登録完了
commit using cocos;

return true
end function

public subroutine of_dragacceptfiles (long p_handle, boolean p_accept);
DragAcceptFiles(p_handle,p_accept)

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

l_filecnt = dragqueryfile(p_handle,-1,l_filename,0)
p_filecnt = l_filecnt

for l_cnt = 1 to l_filecnt
	// make it's size enough
	l_filename = filla(' ',l_size)

	if dragqueryfile(p_handle,l_cnt - 1,l_filename,l_size) > 0 then 
		p_file[l_cnt] = l_filename
	end if
next

// handle destroy
dragfinish(p_handle)	

return 0
end function

public subroutine of_mouseevent ();
mouse_event(2,0,0,0,0)	// left mouse down
mouse_event(4,0,0,0,0)	// left mouse up

RETURN
end subroutine

on _wld_tyakuten.create
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
this.hpb_progress3=create hpb_progress3
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
this.Control[iCurrent+19]=this.hpb_progress3
end on

on _wld_tyakuten.destroy
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
destroy(this.hpb_progress3)
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

hpb_progress3.x = dw_list.x
hpb_progress3.width = dw_list.width

end event

event key_f07;call super::key_f07;
// ファイル読込

// ファイルを開く
openwithparm(iw_fileread_window,i_str_fileread,this)

i_str_fileread	= message.powerobjectparm

if upperbound(i_str_fileread.ret) > 0 then
	// ファイル名セット
	st_filename.text	= i_str_fileread.ret[1].filename
	// ファイル読込結果を画面にセット
	cb_retrieve.event execution(0,0)
end if

return 0

end event

event open;call super::open;
// -------------------------------------------------------------
// ドラッグ＆ドロップの非許可
// -----------------------------------------------------------------
of_dragacceptfiles(Handle(This),True)

dw_list.setfocus()
end event

event retrieve_event;call super::retrieve_event;
// ファイル読込
long	l_row
long	l_cnt

if upperbound(i_str_fileread.ret) > 0 then
	setredraw(false)

	dw_list.reset()

	// 構造体からデータを画面にセットする
	for l_cnt = 1 to upperbound(i_str_fileread.ret)
		l_row	= dw_list.insertrow(0)

		choose case integer(ddplb_data_kbn.of_get_code())
			case 1
				dw_list.object.jis_code[l_row]		= long(i_str_fileread.ret[l_cnt].data01)	//JIS-Code
				dw_list.object.yubin_no[l_row]		= left(i_str_fileread.ret[l_cnt].data03,3) + "-" + right(i_str_fileread.ret[l_cnt].data03,4)	//郵便番号
//				if len(trim(i_str_fileread.ret[l_cnt].data02)) = 5 then
//					dw_list.object.yubin_no_old[l_row]	= left(i_str_fileread.ret[l_cnt].data02,3) + "-" + right(i_str_fileread.ret[l_cnt].data02,2)	//(旧)郵便番号
//				else
//					dw_list.object.yubin_no_old[l_row]	= i_str_fileread.ret[l_cnt].data02	//(旧)郵便番号
//				end if
				dw_list.object.yubin_no_old[l_row]	= i_str_fileread.ret[l_cnt].data02	//(旧)郵便番号
				dw_list.object.todofu_kana[l_row]	= i_str_fileread.ret[l_cnt].data04	//都道府県名(カナ)
				dw_list.object.sikutyo_kana[l_row]	= i_str_fileread.ret[l_cnt].data05	//市区町村名(カナ)
				dw_list.object.tyoiki_kana[l_row]	= left(i_str_fileread.ret[l_cnt].data06,20)	//町域名(カナ) > ※本来項目長76byte 現DB定義過少(20byte)のため強制カット
				dw_list.object.todofu_mei[l_row]	= i_str_fileread.ret[l_cnt].data07	//都道府県名
				dw_list.object.sikutyo_mei[l_row]	= i_str_fileread.ret[l_cnt].data08	//市区町村名
				dw_list.object.tyoiki_mei[l_row]	= i_str_fileread.ret[l_cnt].data09	//町域名
				dw_list.object.tyome[l_row]			= ""								//小字名・丁目・番地
				dw_list.object.jigyosyo_mei[l_row]	= ""								//大口事業所名
				dw_list.object.full_mei[l_row]		= trim(i_str_fileread.ret[l_cnt].data07) + trim(i_str_fileread.ret[l_cnt].data08) + trim(i_str_fileread.ret[l_cnt].data09)	//住所
				dw_list.object.kbn_1[l_row]			= integer(i_str_fileread.ret[l_cnt].data10)	//区分1
				dw_list.object.kbn_2[l_row]			= integer(i_str_fileread.ret[l_cnt].data11)	//区分2
				dw_list.object.kbn_3[l_row]			= integer(i_str_fileread.ret[l_cnt].data13)	//区分3
				dw_list.object.kbn_4[l_row]			= integer(i_str_fileread.ret[l_cnt].data13)	//区分1
				dw_list.object.kbn_5[l_row]			= integer(i_str_fileread.ret[l_cnt].data14)	//区分2
				dw_list.object.kbn_6[l_row]			= integer(i_str_fileread.ret[l_cnt].data15)	//区分3
				dw_list.object.kbn_7[l_row]			= 0									//区分7
				dw_list.object.kbn_8[l_row]			= 0									//区分8
				dw_list.object.kbn_9[l_row]			= 0									//区分9
				
			case 2
				dw_list.object.jis_code[l_row]		= long(i_str_fileread.ret[l_cnt].data01)	//JIS-Code
				dw_list.object.yubin_no[l_row]		= left(i_str_fileread.ret[l_cnt].data08,3) + "-" + right(i_str_fileread.ret[l_cnt].data08,4)	//大口事業所個別番号
//				if len(trim(i_str_fileread.ret[l_cnt].data09)) = 5 then
//					dw_list.object.yubin_no_old[l_row]	= left(i_str_fileread.ret[l_cnt].data09,3) + "-" + right(i_str_fileread.ret[l_cnt].data09,2)	//(旧)郵便番号
//				else
//					dw_list.object.yubin_no_old[l_row]	= i_str_fileread.ret[l_cnt].data09	//(旧)郵便番号
//				end if
				dw_list.object.yubin_no_old[l_row]	= i_str_fileread.ret[l_cnt].data09	//(旧)郵便番号
				dw_list.object.todofu_kana[l_row]	= ""								//都道府県名(カナ)
				dw_list.object.sikutyo_kana[l_row]	= ""								//市区町村名(カナ)
				dw_list.object.tyoiki_kana[l_row]	= ""								//町域名(カナ)
				dw_list.object.todofu_mei[l_row]	= i_str_fileread.ret[l_cnt].data04	//都道府県名
				dw_list.object.sikutyo_mei[l_row]	= i_str_fileread.ret[l_cnt].data05	//市区町村名
				dw_list.object.tyoiki_mei[l_row]	= i_str_fileread.ret[l_cnt].data06	//町域名
				dw_list.object.tyome[l_row]			= i_str_fileread.ret[l_cnt].data07	//小字名・丁目・番地
				dw_list.object.jigyosyo_mei[l_row]	= i_str_fileread.ret[l_cnt].data03	//大口事業所名
				dw_list.object.full_mei[l_row]		= trim(i_str_fileread.ret[l_cnt].data04) + trim(i_str_fileread.ret[l_cnt].data05) + trim(i_str_fileread.ret[l_cnt].data06) + trim(i_str_fileread.ret[l_cnt].data07)	//住所
				dw_list.object.kbn_1[l_row]			= 0									//区分1
				dw_list.object.kbn_2[l_row]			= 0									//区分2
				dw_list.object.kbn_3[l_row]			= 0									//区分3
				dw_list.object.kbn_4[l_row]			= 0									//区分4
				dw_list.object.kbn_5[l_row]			= 0									//区分5
				dw_list.object.kbn_6[l_row]			= 0									//区分6
				dw_list.object.kbn_7[l_row]			= integer(i_str_fileread.ret[l_cnt].data11)	//区分7
				dw_list.object.kbn_8[l_row]			= integer(i_str_fileread.ret[l_cnt].data12)	//区分8
				dw_list.object.kbn_9[l_row]			= integer(i_str_fileread.ret[l_cnt].data13)	//区分9
				
			case 10
				
		end choose
	next

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

return 0

end event

event openquery;call super::openquery;
of_dsp_reset()

end event

event update_event;call super::update_event;
// 更新処理
if not of_db_update() then
	rollback using cocos;
	return -1
end if

commit using cocos;

// 画面初期化
of_dsp_reset()

return 0
end event

event key_f01;call super::key_f01;
// 全選択
long	l_row
long	l_mode	= 0	// 1:全選択/0:全解除

// チェックONが１つでもあれば全解除、なければ全選択
if dw_list.find( "chk = 1", 1, dw_list.rowcount() ) = 0 then
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

type uo_signal from iw_main_window`uo_signal within _wld_tyakuten
end type

type st_date from iw_main_window`st_date within _wld_tyakuten
end type

type st_user_mei from iw_main_window`st_user_mei within _wld_tyakuten
end type

type uo_test_mode from iw_main_window`uo_test_mode within _wld_tyakuten
end type

type p_size_adjust from iw_main_window`p_size_adjust within _wld_tyakuten
end type

type st_title from iw_main_window`st_title within _wld_tyakuten
end type

type st_title_upper from iw_main_window`st_title_upper within _wld_tyakuten
end type

type st_upper from iw_main_window`st_upper within _wld_tyakuten
end type

type st_second_upper from iw_main_window`st_second_upper within _wld_tyakuten
end type

type cb_retrieve from iw_main_window`cb_retrieve within _wld_tyakuten
end type

event constructor;call super::constructor;
this.visible	= false
end event

type st_status from ivo_statictext within _wld_tyakuten
integer x = 32
integer y = 384
integer width = 408
boolean bringtotop = true
string text = "ステータス"
alignment alignment = right!
end type

type st_msg from ivo_statictext within _wld_tyakuten
integer x = 908
integer y = 395
integer width = 408
boolean bringtotop = true
string text = "メッセージ"
alignment alignment = right!
end type

type cb_clear from ivo_commandbutton within _wld_tyakuten
integer x = 3664
integer y = 380
integer width = 408
integer taborder = 50
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

type dw_list from ivo_datawindow within _wld_tyakuten
integer x = 32
integer y = 498
integer width = 4656
integer height = 1365
integer taborder = 40
boolean bringtotop = true
string dataobject = "dld_tyakuten"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f8_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
end type

event constructor;call super::constructor;
this.reset()
this.settransobject(cocos)


end event

type st_filename_t from ivo_statictext within _wld_tyakuten
integer x = 32
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込ファイル"
alignment alignment = right!
end type

type st_filename from ivo_statictext within _wld_tyakuten
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

type st_cnt_t from ivo_statictext within _wld_tyakuten
integer x = 2008
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込件数"
alignment alignment = right!
end type

type st_cnt from ivo_statictext within _wld_tyakuten
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

type st_okcnt_t from ivo_statictext within _wld_tyakuten
integer x = 2664
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "正常件数"
alignment alignment = right!
end type

type st_okcnt from ivo_statictext within _wld_tyakuten
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

type st_errcnt_t from ivo_statictext within _wld_tyakuten
integer x = 3320
integer y = 1916
integer width = 408
boolean bringtotop = true
string text = "エラー件数"
alignment alignment = right!
end type

type st_errcnt from ivo_statictext within _wld_tyakuten
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

type st_warncnt_t from ivo_statictext within _wld_tyakuten
integer x = 4056
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "警告件数"
alignment alignment = right!
end type

type st_warncnt from ivo_statictext within _wld_tyakuten
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

type ddplb_status from ivo_dropdownpicturelistbox within _wld_tyakuten
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
boolean f10_key = true
boolean f12_key = true
boolean sf10_key = true
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

type ddplb_msg from ivo_dropdownpicturelistbox within _wld_tyakuten
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
boolean f10_key = true
boolean f12_key = true
boolean sf10_key = true
boolean sf12_key = true
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

type ddplb_data_kbn from sv_ddplb_meisyo within _wld_tyakuten
integer x = 384
integer y = 2005
integer taborder = 50
boolean bringtotop = true
integer i_limit = 2
integer meisyo_kbn = 156
boolean code_visible = true
string init_code = "1"
end type

type st_data_kbn_t from ivo_statictext within _wld_tyakuten
integer x = 32
integer y = 2016
integer width = 328
boolean bringtotop = true
string text = "運送便"
alignment alignment = right!
end type

type hpb_progress3 from ivo_hprogressbar within _wld_tyakuten
integer x = 16
integer y = 284
integer width = 4096
boolean bringtotop = true
unsignedinteger position = 0
boolean smoothscroll = true
boolean sf6_key = true
end type

