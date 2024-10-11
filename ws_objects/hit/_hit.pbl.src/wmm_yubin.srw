$PBExportHeader$wmm_yubin.srw
$PBExportComments$郵便番号登録
forward
global type wmm_yubin from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_yubin
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_yubin
end type
type st_syori_kbn from ivo_statictext within wmm_yubin
end type
type dw_entry from ivo_datawindow within wmm_yubin
end type
type ddplb_data_kbn from sv_ddplb_meisyo within wmm_yubin
end type
type st_data_kbn from ivo_statictext within wmm_yubin
end type
type sle_search_string from singlelineedit within wmm_yubin
end type
type st_kensakumoji from ivo_statictext within wmm_yubin
end type
type st_setumei from ivo_statictext within wmm_yubin
end type
type lstr_m_yubin from structure within wmm_yubin
end type
end forward

type lstr_m_yubin from structure
	string		yubin_no
	string		todofu_mei
	string		sikutyo_mei
	string		rowid
	string		tyoiki_mei
	string		tyome
	string		jigyosyo_mei
	integer		jis_code
end type

global type wmm_yubin from iw_main_window
string title = "郵便番号登録"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
ddplb_data_kbn ddplb_data_kbn
st_data_kbn st_data_kbn
sle_search_string sle_search_string
st_kensakumoji st_kensakumoji
st_setumei st_setumei
end type
global wmm_yubin wmm_yubin

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	string	i_data_kbn

	string	i_yubin_no
	string	i_rowid
	
    string	i_search_string
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時

	// ダブルクリック状態検知
	boolean	i_doubleclicked

end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_db_delete (lstr_m_yubin p_rec)
public function boolean of_db_update (lstr_m_yubin p_rec)
public function boolean of_db_insert (lstr_m_yubin p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_yubin_no, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_yubin_no)
public function boolean of_record_lock (string p_rowid, boolean p_lock)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
	case "dw_entry"
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.object.syori_kbn[l_row]	= i_syori_kbn
			dw_entry.setrow( l_row )
//			dw_entry.setcolumn( "yubin_no" )
			dw_entry.setcolumn( "rowid" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
end choose

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )

// 初期化を行わないと項目が重複して表示される
ddplb_data_kbn.reset( )
ddplb_data_kbn.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_back ();
boolean	l_doubleclicked

// Wクリック状態を取得
l_doubleclicked	= i_doubleclicked

// シグナルが有効であればDBアンロックの必要あり
choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor( )
	case "変更", "削除", "照会"
		dw_entry.event constructor( )
end choose


// Wクリック状態でフォーカス移動
if l_doubleclicked then
	dw_entry.setfocus()	// フォーカスバグのおまじない
	dw_list.setfocus()
else
	of_dsp_edit( "callsection", true )
	dw_list.event constructor( )
	of_set_secondfocus( )
end if


end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_yubin
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "郵便番号マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_db_delete (lstr_m_yubin p_rec);
delete from m_yubin
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "郵便番号マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

public function boolean of_db_update (lstr_m_yubin p_rec);
update m_yubin
   set jis_code     = :p_rec.jis_code,
       yubin_no   	= :p_rec.yubin_no,
	   todofu_mei		= :p_rec.todofu_mei,
	   sikutyo_mei	= :p_rec.sikutyo_mei,
	   tyoiki_mei   = :p_rec.tyoiki_mei,
	   tyome   = :p_rec.tyome,
   	   jigyosyo_mei   = :p_rec.jigyosyo_mei,
	   henkou_date		= sysdate,
	   henkou_user_id	= :user.user_id,
	   henkou_client_id	= :device.name,
	   henkou_pg_id		= :i_pg_id,
	   kousin_date		= sysdate,
	   kousin_user_id	= :user.user_id,
	   kousin_client_id	= :device.name,
	   kousin_pg_id		= :i_pg_id
 where rowid			= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "郵便番号マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true


end function

public function boolean of_db_insert (lstr_m_yubin p_rec);
insert into m_yubin(
    data_kbn,
	jis_code,
	yubin_no,todofu_mei,
	sikutyo_mei,
	tyoiki_mei,
	tyome,
	jigyosyo_mei,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
    3,
	:p_rec.jis_code,
	:p_rec.yubin_no,:p_rec.todofu_mei,
	:p_rec.sikutyo_mei,
	:p_rec.tyoiki_mei,
	:p_rec.tyome,
	:p_rec.jigyosyo_mei,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "郵便番号マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_yubin_no, string p_rowid);
string	l_db_todofu_mei

select todofu_mei
  into :l_db_todofu_mei
  from m_yubin
 where yubin_no		= :p_yubin_no
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている郵便番号はすでに登録があります。{1}【登録済の郵便番号】{2}：{3}", code.crlf, p_yubin_no, l_db_todofu_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_yubin_no);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_yubin_no, l_rowid )
end function

public function boolean of_record_lock (string p_rowid, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mg.rowid,mg.haita_flg,
       nvl( to_char( mg.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mg.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mg.henkou_client_id, '???' ),
       nvl( mg.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_yubin mg,
       m_user mu,
       m_window mw
	 where mg.henkou_user_id= mu.user_id(+)
	   and mg.henkou_pg_id	= mw.window_id(+)
	   and mg.rowid	= :p_rowid
   for update
using cocos;

choose case cocos.sqlcode
	case 0
		if l_henkou_user_id <> user.user_id then
			if l_haita_flg <> 0 then
				rollback using cocos;
				msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
				return false
			end if
		end if

		// commitはこっちで行う
		return of_record_lock_rowid( l_rowid, p_lock )
	case 100
		rollback using cocos;
		msg.of_error( "対象レコードが存在しません。" )
	case else
		rollback using cocos;
		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
		return false
end choose

return false

end function

on wmm_yubin.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.ddplb_data_kbn=create ddplb_data_kbn
this.st_data_kbn=create st_data_kbn
this.sle_search_string=create sle_search_string
this.st_kensakumoji=create st_kensakumoji
this.st_setumei=create st_setumei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.st_syori_kbn
this.Control[iCurrent+4]=this.dw_entry
this.Control[iCurrent+5]=this.ddplb_data_kbn
this.Control[iCurrent+6]=this.st_data_kbn
this.Control[iCurrent+7]=this.sle_search_string
this.Control[iCurrent+8]=this.st_kensakumoji
this.Control[iCurrent+9]=this.st_setumei
end on

on wmm_yubin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.ddplb_data_kbn)
destroy(this.st_data_kbn)
destroy(this.sle_search_string)
destroy(this.st_kensakumoji)
destroy(this.st_setumei)
end on

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0
end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0

end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )

end event

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
//i_admin	= kengen.of_check_admin( )


end event

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

/*
// st_second_upperの高さは1列分
st_second_upper.width	= st_upper.width
st_second_upper.x		= st_upper.x
st_second_upper.height	= 89 + code.MGN_TATE * 2
st_second_upper.y		= st_upper.y + st_upper.height

cb_retrieve.width	= 380
cb_retrieve.height	= 85
cb_retrieve.y		= st_second_upper.y + st_second_upper.height - cb_retrieve.height - code.MGN_TATE
cb_retrieve.x		= newwidth - cb_retrieve.width - code.MGN_YOKO
*/

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= 538

dw_list.y			= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y

// DWの登録日時と変更日時

dw_entry.object.henkou_date.x = dw_entry.width -long( dw_entry.object.henkou_date.width ) - 40
dw_entry.object.henkou_date_t.x = long( dw_entry.object.henkou_date.x ) -long( dw_entry.object.henkou_date_t.width ) - 20

dw_entry.object.touroku_date.x = long( dw_entry.object.henkou_date_t.x ) -long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x = long( dw_entry.object.touroku_date.x ) -long( dw_entry.object.touroku_date_t.width ) - 20

end event

event retrieve_event;call super::retrieve_event;
integer l_data_kbn
string	l_base_dw_sql, l_sql, l_sql_where

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_data_kbn      = ddplb_data_kbn.text
i_search_string	= sle_search_string.text

// 照会以外はデータ区分は手入力のみ
if i_syori_kbn <> "照会" and i_data_kbn <> "手入力"then
	msg.of_error( "データ区分が手入力ではない場合、登録、変更、削除できません。" )
	ddplb_syori_kbn.setfocus()
	return -1
end if

select meisyo_code
	  into :l_data_kbn
	  from m_meisyo
	 where meisyo_1	= :ddplb_data_kbn.text
	 and meisyo_kbn=144
	using cocos;


l_base_dw_sql	= dw_list.getsqlselect( )
l_sql			= dw_list.getsqlselect( )

// 検索引数は使用できないので、ここでSQL調整
l_sql_where += " and my.data_kbn  = " + string(l_data_kbn)

// 検索用SQLの組み立て
if i_search_string <> "" then
	l_sql_where += " and (  my.yubin_no like '%" + i_search_string + "%'" + code.crlf
	l_sql_where += "	   or" + code.crlf
	l_sql_where += "		my.full_mei like '%" + i_search_string + "%'" + code.crlf
	l_sql_where += "	   or" + code.crlf
	l_sql_where += "		my.jigyosyo_mei like '%" + i_search_string + "%'" + code.crlf
	l_sql_where += "	  )" + code.crlf
	l_sql_where += " order by rownum"
	
end if

l_sql	+= 	+ l_sql_where
dw_list.setsqlselect( l_sql )

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
//if dw_list.retrieve( i_rowid ) = 0 then
if dw_list.retrieve( ) = 0 then
	// DWを元に戻す
	dw_list.setsqlselect( l_base_dw_sql )
	if i_syori_kbn <> "登録" then
		msg.of_error( "登録されたデータはありません。" )
		ddplb_syori_kbn.setfocus()
		return -1
	end if
end if

// DWを元に戻す
dw_list.setsqlselect( l_base_dw_sql )

setredraw( false )

// 更新部初期化
dw_entry.event constructor( )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if


// 編集モードあれこれ
// 一旦フォーカスを明細部へ
dw_list.setfocus()

choose case i_syori_kbn
	case "登録"
		of_dsp_edit( "dw_entry", true )
		// フォーカスは親更新部へ
		dw_entry.setfocus()
	case "変更", "削除", "照会"
end choose

setredraw( true )


end event

event update_event;call super::update_event;
lstr_m_yubin	l_rec
integer				l_row


l_row	= long( dw_list.object.datawindow.firstrowonpage )
// 構造体に更新値をセット
l_rec.jis_code		= dw_entry.object.jis_code[l_row]
l_rec.yubin_no		= dw_entry.object.yubin_no[l_row]
l_rec.todofu_mei		    = dw_entry.object.todofu_mei[l_row]
l_rec.sikutyo_mei	= dw_entry.object.sikutyo_mei[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]

l_rec.tyoiki_mei				= dw_entry.object.tyoiki_mei[l_row]
l_rec.tyome				= dw_entry.object.tyome[l_row]
l_rec.jigyosyo_mei				= dw_entry.object.jigyosyo_mei[l_row]


choose case i_syori_kbn
	case "登録"
		if not of_db_insert( l_rec ) then
			return -1
		end if
	case "変更"
		if not of_db_update( l_rec ) then
			return -1
		end if
	case "削除"
		if not of_db_delete( l_rec ) then
			return -1
		end if
	case "照会"
end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
post event retrieve_event( 0, 0 )


end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
end if
end event

event update_check;call super::update_check;
long	l_row
long	l_cnt
long l_jis_code
string l_yubin_no
string l_todofu_mei
string l_sikutyo_mei


// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_yubin_no		= dw_entry.object.yubin_no[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.yubin_no, string(dw_entry.object.yubin_no[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.todofu_mei, dw_entry.object.todofu_mei[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.sikutyo_mei, dw_entry.object.sikutyo_mei[l_row] ) <> 0 then
	return -1
end if

// 必須チェック
if len( string( dw_entry.object.todofu_mei[l_row] ) ) = 0 then
	msg.of_error_dwo( dw_entry.object.todofu_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "都道府県" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "todofu_mei" )
	return -1
end if

// 処理区分別チェック
choose case	i_syori_kbn
	case "登録","変更"
		// 重複チェック
		
// すべての入力項目に一致するレコードが存在するかチェック
l_jis_code=dw_entry.object.jis_code[l_row]
l_yubin_no=dw_entry.object.yubin_no[l_row]
l_todofu_mei=dw_entry.object.todofu_mei[l_row]
l_sikutyo_mei=dw_entry.object.sikutyo_mei[l_row]

select my.data_kbn
into :l_cnt
  from m_yubin my
 where  my.jis_code     = :l_jis_code
    and my.yubin_no   	= :l_yubin_no
    and my.todofu_mei	= :l_todofu_mei
    and my.sikutyo_mei	= :l_sikutyo_mei
using cocos;



choose case cocos.sqlcode
	case 0
		msg.of_error( "重複する値が存在します。" )
		return -1
	case 100
		return 0
	case else
		//msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		msg.of_error_db( "エラーが発生しました。", cocos )
		return -1
end choose
		end choose



end event

type uo_signal from iw_main_window`uo_signal within wmm_yubin
end type

type st_date from iw_main_window`st_date within wmm_yubin
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_yubin
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_yubin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_yubin
end type

type st_title from iw_main_window`st_title within wmm_yubin
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_yubin
end type

type st_upper from iw_main_window`st_upper within wmm_yubin
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_yubin
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_yubin
integer taborder = 40
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_yubin
integer x = 8
integer y = 917
integer width = 4208
integer height = 1177
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_yubin_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f9_key = true
boolean f10_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録"
		this.of_set_fnkey( keyf12!, true )
		return
	case "変更","削除"
//		if i_doubleclicked then
			this.of_set_fnkey( keyf12!, true )
			return
//		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "郵便番号マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event doubleclicked;call super::doubleclicked;
long	l_upd_row
string	l_code
long	l_row

setredraw( false )

if row > 0 then
	
	i_yubin_no	= this.object.yubin_no[row]
	i_rowid	= this.object.rowid[row]
	

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.yubin_no[l_row]	= this.object.yubin_no[row]
			dw_entry.object.todofu_mei[l_row]		= this.object.todofu_mei[row]
			dw_entry.object.sikutyo_mei[l_row]		= this.object.sikutyo_mei[row]			
			dw_entry.object.tyoiki_mei[l_row]		= this.object.tyoiki_mei[row]	
			dw_entry.object.tyome[l_row]		    = this.object.tyome[row]			
			dw_entry.object.jigyosyo_mei[l_row]		= this.object.jigyosyo_mei[row]			
			dw_entry.object.jis_code[l_row]		    = this.object.jis_code[row]			

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_rowid, true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_rowid ) > 0 then
				l_row	= long( dw_entry.object.datawindow.firstrowonpage )

				if i_syori_kbn = "変更" then
					of_dsp_edit( "dw_entry", true )
				end if
			else
				msg.of_error( "選択されたレコードが見つかりません。" )
				this.setfocus()
				return -1
			end if
			
			i_doubleclicked	= true

			if i_syori_kbn = "削除" then
				this.event getfocus( )
			end if
	end choose
end if

setredraw( true )


end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_yubin
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )

end event

event selectionchanged;call super::selectionchanged;choose case ddplb_syori_kbn.text
	case "変更", "登録", "削除"
		ddplb_data_kbn.text ="手入力"
		ddplb_data_kbn.enabled = false
	case "照会"
		ddplb_data_kbn.enabled = true
	case else
		// 何もしない
end choose
end event

type st_syori_kbn from ivo_statictext within wmm_yubin
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_yubin
integer y = 373
integer width = 5120
integer height = 533
integer taborder = 60
boolean bringtotop = true
string dataobject = "dmm_yubin_entry"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
long			l_row
string			l_rowid

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	
	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
			if len( trim( l_rowid ) ) > 0 then
				of_record_lock_rowid( l_rowid, false )
			end if
	end choose
	
	i_doubleclicked	= false

end if

this.settransobject(cocos)

this.reset()
this.insertrow(0)

end event

event getfocus;call super::getfocus;
long	l_row

l_row	= long( this.object.datawindow.firstrowonpage )

choose case i_syori_kbn
	case "登録"
		if this.object.syori_kbn[l_row] = "登録" then
			this.of_set_fnkey( keyf6!, true )
			this.of_set_fnkey( keyf12!, true )
			return
		end if
	case "変更", "削除"
		if uo_signal.of_get_status() then
			this.of_set_fnkey( keyf6!, true )
			this.of_set_fnkey( keyf12!, true )
			return
		end if
	case "照会"
end choose

this.of_set_fnkey( keyf6!, false )
this.of_set_fnkey( keyf12!, false )

end event

event itemchanged;call super::itemchanged;
string	l_yubin_no
//int	l_yubin_no

string	l_input
string	l_colnm
string	l_tableid	= "m_yubin"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "yubin_no", "todofu_mei", "sikutyo_mei"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別仕様
choose case dwo.name
	case "yubin_no"
		// ブランドコードコード
		// 数値のみ入力可
//		if not isnumber( data ) then
//			msg.of_error_dwo( dwo, "数値を入力してください。" )
//			return 1
//		end if
//		
//
//		// 処理区分別チェック
//		choose case	i_syori_kbn
//			case "登録"
//				// 重複チェック
//				if not of_dwchk_duplicate( dwo, data ) then
//					return 1
//				end if
//		end choose
		
	// 郵便番号形式チェック
    If Not isnumber(fnc.strg.of_replace(data, "-", "")) Or Len(fnc.strg.of_replace(data, "-", "")) <> 7 Then
		msg.of_error_db( "郵便番号が正しい形式で入力されていません。", cocos )
    Else
		this.post setitem(row,"yubin_no", left(fnc.strg.of_replace(data, "-", ""),3) + "-" + right(fnc.strg.of_replace(data, "-", ""),4))
    End If
	
		// 桁セット
		l_yubin_no		= string(this.object.yubin_no[row])
		if isnull( l_yubin_no ) then
			l_yubin_no	= ""
		end if

	case else

end choose

return 0
end event

type ddplb_data_kbn from sv_ddplb_meisyo within wmm_yubin
integer x = 1060
integer y = 153
integer taborder = 20
boolean bringtotop = true
integer meisyo_kbn = 144
integer meisyo_no = 1
end type

event constructor;call super::constructor;

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_data_kbn )
end event

type st_data_kbn from ivo_statictext within wmm_yubin
integer x = 632
integer y = 167
integer width = 408
boolean bringtotop = true
long backcolor = 12632256
string text = "データ区分"
alignment alignment = right!
end type

type sle_search_string from singlelineedit within wmm_yubin
string tag = "検索文字"
integer x = 352
integer y = 252
integer width = 1092
integer height = 89
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = shiftjis!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI Semilight"
long textcolor = 33554432
long backcolor = 16777215
end type

type st_kensakumoji from ivo_statictext within wmm_yubin
integer x = 32
integer y = 260
boolean bringtotop = true
long backcolor = 12632256
string text = "検索文字"
alignment alignment = right!
end type

type st_setumei from ivo_statictext within wmm_yubin
integer x = 1500
integer y = 260
integer width = 920
boolean bringtotop = true
long textcolor = 0
long backcolor = 12632256
string text = "※郵便番号、住所、事業所名を検索"
borderstyle borderstyle = styleshadowbox!
end type

event constructor;call super::constructor;
this.visible	= true
end event

