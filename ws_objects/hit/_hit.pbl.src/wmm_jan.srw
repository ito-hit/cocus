$PBExportHeader$wmm_jan.srw
$PBExportComments$JAN登録
forward
global type wmm_jan from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_jan
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_jan
end type
type dw_list from ivo_datawindow within wmm_jan
end type
type st_syohin_code from ivo_statictext within wmm_jan
end type
type sle_syohin_code from ivo_singlelineedit within wmm_jan
end type
type cb_menu_id from sv_cb_modal within wmm_jan
end type
type st_hin_ban from ivo_statictext within wmm_jan
end type
type st_hin_mei from ivo_statictext within wmm_jan
end type
type st_syusoku_flg from ivo_statictext within wmm_jan
end type
type dw_entry from ivo_datawindow within wmm_jan
end type
type lstr_m_gtin from structure within wmm_jan
end type
end forward

type lstr_m_gtin from structure
	string		gtin_code
	long		sku_code
	long		syohin_code
	long		iro_no
	long		code_kbn
	string		jigyosya_code
	long		touroku_iti
	long		indicator
	long		irisu
	string		rowid
end type

global type wmm_jan from iw_main_window
string title = "JAN登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_list dw_list
st_syohin_code st_syohin_code
sle_syohin_code sle_syohin_code
cb_menu_id cb_menu_id
st_hin_ban st_hin_ban
st_hin_mei st_hin_mei
st_syusoku_flg st_syusoku_flg
dw_entry dw_entry
end type
global wmm_jan wmm_jan

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long	i_syohin_code
	string	i_jan_code
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時


end variables

forward prototypes
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_record_lock (string p_gtin_code, boolean p_lock)
public function boolean of_record_lock_loop (long p_syohin_code, boolean p_lock)
public function integer of_get_checkdigit (string p_jan13)
public function boolean of_set_itemcode_auto ()
public function string of_get_jancode (string p_jigyosya_code, string p_item_code)
public function string of_get_itemcode (string p_jigyosya_code, string p_item_code)
public function boolean of_dwchk_duplicate_ora (dwobject p_dwo, string p_gtin_code)
public function boolean of_dwchk_duplicate_ora (dwobject p_dwo, string p_gtin_code, string p_rowid)
public function boolean of_dwchk_duplicate_dw (dwobject p_dwo, long p_row, string p_gtin_code)
public function boolean of_db_delete (lstr_m_gtin p_rec)
public function boolean of_db_insert (lstr_m_gtin p_rec)
public function boolean of_db_update (lstr_m_gtin p_rec)
public function boolean of_db_update_gtin_kanri ()
end prototypes

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_gtin
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTINマスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_dsp_reset ();string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）

dw_list.event constructor( )
dw_entry.event constructor( )
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_back ();
dw_list.event constructor( )
dw_entry.event constructor( )

of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )


end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		sle_syohin_code.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled

	case "dw_list"
		if dw_list.rowcount() > 0 then
			dw_list.object.syori_kbn.Expression = "'" + i_syori_kbn + "'"
			dw_list.setrow( l_row )
			dw_list.setcolumn( "item_code" )
			dw_list.setfocus()
	 	else
			msg.of_error( "編集可能な行がありません。" )
		end if
end choose

end subroutine

public function boolean of_record_lock (string p_gtin_code, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mm.rowid,mm.haita_flg,
       nvl( to_char( mm.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mm.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mm.henkou_client_id, '???' ),
       nvl( mm.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_gtin mm,
       m_user mu,
       m_window mw
	 where mm.henkou_user_id= mu.user_id(+)
	   and mm.henkou_pg_id	= mw.window_id(+)
	   and trim( mm.gtin_code )	= :p_gtin_code
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

public function boolean of_record_lock_loop (long p_syohin_code, boolean p_lock);
long		l_cnt	= 1
string		l_gtin_code, l_gtin_code_h[]

// GTINマスタ検索カーソル
declare cur cursor for
	select trim( gtin_code )
	  from m_gtin
	 where syohin_code	= :p_syohin_code
	   and code_kbn		= 1
	using cocos;
open cur;
if cocos.sqlcode <> 0 then
	msg.of_error_db( "GTINマスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	do until cocos.sqlcode <> 0
		fetch cur into :l_gtin_code;

		choose case cocos.sqlcode
			case 0
				l_gtin_code_h[upperbound( l_gtin_code_h ) + 1]	= l_gtin_code
			case 100
			case else
				msg.of_error_db( "GTINマスタのレコードロックでエラーが発生しました。", cocos )
				return false
		end choose
	loop
end if

close cur;

for l_cnt = 1 to upperbound( l_gtin_code_h )
	if not of_record_lock( l_gtin_code_h[l_cnt], p_lock ) then
		return false
	end if
next

return true


//
//string	l_gtin_code
//long	l_rtn
//
//
//// GTINマスタ検索カーソル
//declare cur_m_gtin cursor for
//	select trim( gtin_code )
//	  from m_gtin
//	 where syohin_code	= :p_syohin_code
//	   and code_kbn		= 1
//	using cocos;
//
//// カーソルオープン
//open cur_m_gtin ;
//do 
//	
//	// 値を取得
//	fetch cur_m_gtin into :l_gtin_code ;
//
//	// SQLCODEを取得
//	l_rtn = sqlca.sqlcode
//	
//	if l_rtn = -1 then
//		// データベースエラー
//		msg.of_error_db( "GTINマスタのレコードロックでエラーが発生しました。", cocos )
//		close cur_m_gtin ;
//		return false
//	elseif l_rtn = 0 then
//		// 存在する場合
//		// 排他処理
//		if not of_record_lock( l_gtin_code, p_lock ) then
//			close cur_m_gtin ;
//			return false
//		end if
//	end if
//	
//loop while l_rtn = 0
//
//close cur_m_gtin ; 
//
//
//return true
//
end function

public function integer of_get_checkdigit (string p_jan13);
// チェックデジット計算
int	l_length
int	l_sumodd
int	l_sumeven
int	l_total
int	l_checkdigit
int	l_index
int	l_digit

l_length = len( p_jan13 )

// 12桁ない場合はエラー(戻り値-1)
if l_length <> 12 then
	return -1
end if

l_sumodd	= 0
l_sumeven	= 0

for l_index = 1 to l_length

	l_digit = integer( mid( p_jan13, l_index, 1 ) )
	
	// 偶数＆奇数で合計
	if mod( l_index, 2 ) = 1 then
		l_sumodd	= l_sumodd + l_digit
	else
		l_sumeven	= l_sumeven + l_digit
	end if
next

// 偶数を3倍し、基数を加算
l_total = l_sumodd + ( l_sumeven * 3 )

l_checkdigit = mod( l_total, 10 )

if l_checkdigit <> 0 then
	l_checkdigit = 10 - l_checkdigit
end if

return l_checkdigit

end function

public function boolean of_set_itemcode_auto ();
string	l_jigyosya_code
int		l_jido_saiban_flg
long	l_row
long	l_start
long	l_end
long	l_now
string	l_item_code
string	l_jan13
int		l_check_digit
string	l_status
string	l_rowid

i_syori_kbn			= ddplb_syori_kbn.text
l_jigyosya_code		= dw_entry.object.jigyosya_code[1]
l_jido_saiban_flg	= dw_entry.object.jido_saiban_flg[1]

if isnull( l_jigyosya_code ) then
	return false
end if

if i_syori_kbn = "登録" then
	l_status	= "新規登録"
elseif i_syori_kbn = "変更" then
	l_status	= "変更"
elseif i_syori_kbn = "削除" then
	l_status	= "削除"
end if

// 自動採番「する」
if l_jido_saiban_flg = 1 then
	l_start	= dw_entry.object.item_code_str[1]
	l_end	= dw_entry.object.item_code_end[1]
	l_now	= dw_entry.object.item_code_gen[1]

	for l_row = 1 to dw_list.rowcount()
		// 最大値チェック
		if l_now = l_end then
			msg.of_error( "最大のアイテムコードに達しました。これ以上自動採番出来ません。" )
			return true
		end if

		// 別寸にも採番チェック
		if dw_entry.object.b_flg[1] = 0 and dw_list.object.ms_size_mei[l_row] = "別寸" then
			continue
		end if
		
		l_item_code	= trim( dw_list.object.item_code[l_row] )

		if isnull( l_item_code ) then
			l_item_code	= ""
		end if

		if len( string( l_item_code ) ) = 0 then

			l_jan13	= of_get_jancode( l_jigyosya_code, string( l_now ) )
			
			// 重複チェック(画面)
			if not of_dwchk_duplicate_dw( dw_list.object.item_code, l_row, l_jan13 ) then
				return false
			end if
			l_rowid	= dw_list.object.rowid[l_row]
			// 重複チェック(DB)
			if not of_dwchk_duplicate_ora( dw_list.object.item_code, l_jan13, l_rowid ) then
				return false
			end if

			l_now	= l_now + 1
			// 画面に値セット
			dw_list.object.jigyosya_code[l_row]	= l_jigyosya_code
			dw_list.object.item_code[l_row]		= of_get_itemcode( l_jigyosya_code, string( l_now ) )
			dw_list.object.gtin_code[l_row]		= l_jan13
			dw_list.object.status[l_row]		= l_status
			// 現在NOセット
			dw_entry.object.item_code_gen[1]	= l_now
		end if

	next

else
// 「しない」

	// 最大採番値
	choose case len( l_jigyosya_code )
		case 7
			l_end	= 99999
		case 9
			l_end	= 999
		case 10
			l_end	= 99
		case else
	end choose
	
	// 開始No
	l_start	= dw_list.object.item_code_str[1]
	if len( string( l_start ) ) > 0 then
		l_now	= l_start
	else
		l_now	= 1
	end if

	for l_row = 1 to dw_list.rowcount()
		
		// 最大値チェック
		if l_now = l_end then
			msg.of_error( "最大のアイテムコードに達しました。これ以上自動採番出来ません。" )
			return true
		end if
		
		// 別寸にも採番チェック
		if dw_entry.object.b_flg[1] = 0 and dw_list.object.ms_size_mei[l_row] = "別寸" then
			continue
		end if

		l_item_code	= trim( string( dw_list.object.item_code[l_row] ) )

		if isnull( l_item_code ) then
			l_item_code	= ""
		end if
		
		if len( string( l_item_code ) ) = 0 then
			// 画面に値セット
			dw_list.object.jigyosya_code[l_row]	= l_jigyosya_code
			dw_list.object.item_code[l_row]		= of_get_itemcode( l_jigyosya_code, string( l_now ) )
			dw_list.object.gtin_code[l_row]		= of_get_jancode( l_jigyosya_code, string( l_now ) )
			dw_list.object.status[l_row]		= l_status
			l_now	= l_now + 1
		end if

	next

end if


return true
end function

public function string of_get_jancode (string p_jigyosya_code, string p_item_code);
// JANコード作成

string	l_item_code
string	l_jan13

l_jan13	= ""

l_item_code	= of_get_itemcode( p_jigyosya_code, p_item_code )

if len( l_item_code ) = 0 then
	return l_jan13
end if

l_jan13	= p_jigyosya_code + l_item_code + string( of_get_checkdigit( p_jigyosya_code + l_item_code ) )

return l_jan13

end function

public function string of_get_itemcode (string p_jigyosya_code, string p_item_code);
// ITEMコード作成(前0)

string	l_item_code

l_item_code	= ""

choose case len( p_jigyosya_code )
	case 7
		if len( p_item_code ) > 5 then
			msg.of_error( "アイテムコードは採番範囲内の値を入力してください。" )
			return l_item_code
		end if
		l_item_code	= rightA( "00000" + p_item_code, 5 )
	case 9
		if len( p_item_code ) > 3 then
			msg.of_error( "アイテムコードは採番範囲内の値を入力してください。" )
			return l_item_code
		end if
		l_item_code	= rightA( "00000" + p_item_code, 3 )
	case 10
		if len( p_item_code ) > 2 then
			msg.of_error( "アイテムコードは採番範囲内の値を入力してください。" )
			return l_item_code
		end if
		l_item_code	= rightA( "00000" + p_item_code, 2 )
	case else
end choose


return l_item_code

end function

public function boolean of_dwchk_duplicate_ora (dwobject p_dwo, string p_gtin_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate_ora( p_dwo, p_gtin_code, l_rowid )


end function

public function boolean of_dwchk_duplicate_ora (dwobject p_dwo, string p_gtin_code, string p_rowid);
string	l_sku_code

select sku_code
  into :l_sku_code
  from m_gtin
 where gtin_code			= :p_gtin_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしているJANコードはすでに登録があります。{1}【登録済のコード】{2}", code.crlf, p_gtin_code ) )
		return false
	case 100
		return true
	case else
		msg.of_error_db( "入力チェックでエラーが発生しました。", cocos )
		return false
end choose

end function

public function boolean of_dwchk_duplicate_dw (dwobject p_dwo, long p_row, string p_gtin_code);
long	l_find	= 0
long	l_rowcnt

l_rowcnt	= dw_list.rowcount()

if p_row < l_rowcnt then
	// 自身より下に存在するか
	l_find	= dw_list.find( "gtin_code = '" + p_gtin_code + "'",  p_row + 1, l_rowcnt )
	
	if l_find > 0 then
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしているJANコードはすでに登録があります。{1}【登録済のコード】{2}", code.crlf, p_gtin_code ) )
		return false
	end if
end if

if p_row > 1 then
	// 自身より↑に存在するか
	l_find	= dw_list.find( "gtin_code = '" + p_gtin_code + "'",  p_row - 1, 1 )
	
	if l_find > 0 then
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしているJANコードはすでに登録があります。{1}【登録済のコード】{2}", code.crlf, p_gtin_code ) )
		return false
	end if
end if

return true
end function

public function boolean of_db_delete (lstr_m_gtin p_rec);
delete from m_gtin
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTINマスタの削除処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if



return true
end function

public function boolean of_db_insert (lstr_m_gtin p_rec);
insert into m_gtin(
	gtin_code,
	sku_code,
	syohin_code,
	iro_no,
	code_kbn,
	jigyosya_code,
	touroku_iti,
	indicator,
	irisu,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.gtin_code,
	:p_rec.sku_code,
	:p_rec.syohin_code,
	:p_rec.iro_no,
	:p_rec.code_kbn,
	:p_rec.jigyosya_code,
	:p_rec.touroku_iti,
	:p_rec.indicator,
	:p_rec.irisu,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTINマスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true

end function

public function boolean of_db_update (lstr_m_gtin p_rec);
update m_gtin
   set 
       gtin_code		= :p_rec.gtin_code,
       sku_code			= :p_rec.sku_code,
       syohin_code		= :p_rec.syohin_code,
       iro_no			= :p_rec.iro_no,
       code_kbn			= :p_rec.code_kbn,
       jigyosya_code	= :p_rec.jigyosya_code,
       touroku_iti		= :p_rec.touroku_iti,
       indicator		= :p_rec.indicator,
       irisu			= :p_rec.irisu,
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
	msg.of_error_db( "GTINマスタの更新処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if


return true


end function

public function boolean of_db_update_gtin_kanri ();
long	l_item_code_gen
string	l_jigyosya_code


l_jigyosya_code	= dw_entry.object.jigyosya_code[1]
l_item_code_gen	= dw_entry.object.item_code_gen[1]

// 現在値と検索時の値を比較
if l_item_code_gen = dw_entry.getitemdecimal( 1, "item_code_gen", primary!, true ) then
	return true
end if

update m_gtin_kanri
   set 
       item_code_gen	= :l_item_code_gen,
       henkou_date		= sysdate,
	   henkou_user_id	= :user.user_id,
	   henkou_client_id	= :device.name,
	   henkou_pg_id		= :i_pg_id,
	   kousin_date		= sysdate,
	   kousin_user_id	= :user.user_id,
	   kousin_client_id	= :device.name,
	   kousin_pg_id		= :i_pg_id
 where jigyosya_code			= :l_jigyosya_code
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTIN管理マスタの更新処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_update_gtin_kanri", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true


end function

on wmm_jan.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_list=create dw_list
this.st_syohin_code=create st_syohin_code
this.sle_syohin_code=create sle_syohin_code
this.cb_menu_id=create cb_menu_id
this.st_hin_ban=create st_hin_ban
this.st_hin_mei=create st_hin_mei
this.st_syusoku_flg=create st_syusoku_flg
this.dw_entry=create dw_entry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.st_syohin_code
this.Control[iCurrent+5]=this.sle_syohin_code
this.Control[iCurrent+6]=this.cb_menu_id
this.Control[iCurrent+7]=this.st_hin_ban
this.Control[iCurrent+8]=this.st_hin_mei
this.Control[iCurrent+9]=this.st_syusoku_flg
this.Control[iCurrent+10]=this.dw_entry
end on

on wmm_jan.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_list)
destroy(this.st_syohin_code)
destroy(this.sle_syohin_code)
destroy(this.cb_menu_id)
destroy(this.st_hin_ban)
destroy(this.st_hin_mei)
destroy(this.st_syusoku_flg)
destroy(this.dw_entry)
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

// 呼出部
// 1行目
ddplb_syori_kbn.y	= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7		// タイトル「+7」
// 2行目
sle_syohin_code.y	= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
st_syohin_code.y	= sle_syohin_code.y + 7		// タイトル「+7」
cb_menu_id.y		= sle_syohin_code.y			// ボタン
st_hin_ban.y		= sle_syohin_code.y + 3		// 表示テキスト「+3」
st_hin_mei.y		= sle_syohin_code.y + 3		// 表示テキスト「+3」
// st_second_upper高さ
st_second_upper.height	= sle_syohin_code.y + sle_syohin_code.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE_MIDDLE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= 274

dw_list.y			= dw_entry.y + dw_entry.height + code.MGN_TATE_MIDDLE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE_MIDDLE - dw_list.y


end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
	dw_list.event constructor( )
end if

end event

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

event retrieve_event;call super::retrieve_event;
string	l_jigyosya_code

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_syohin_code	= long( sle_syohin_code.text )


choose case i_syori_kbn
	case "登録"
		// リスト検索
		if dw_list.retrieve( i_syohin_code ) = 0 then
			msg.of_error( "入力した商品コードで登録されたデータはありません。" )
			sle_syohin_code.setfocus()
			return -1
		end if
		// // GTIN管理M(dw_entry)検索
		dw_entry.insertrow(0)
		dw_entry.object.syori_kbn[1]	= i_syori_kbn
		
	case "変更", "削除"
		// 排他処理
		if not of_record_lock_loop( i_syohin_code, true ) then
			return -1
		end if
		// リスト検索
		if dw_list.retrieve( i_syohin_code ) = 0 then
			msg.of_error( "入力した商品コードで登録されたデータはありません。" )
			sle_syohin_code.setfocus()
			return -1
		end if
		// GTIN管理M(dw_entry)検索
		l_jigyosya_code	= dw_list.object.jigyosya_code[1]
		if dw_entry.retrieve( l_jigyosya_code ) = 0 then
			dw_entry.insertrow(0)
		end if
		dw_entry.object.syori_kbn[1]	= i_syori_kbn
		
	case "照会"
		if dw_list.retrieve( i_syohin_code ) = 0 then
			msg.of_error( "入力した商品コードで登録されたデータはありません。" )
			sle_syohin_code.setfocus()
			return -1
		end if
		// GTIN管理M(dw_entry)検索
		l_jigyosya_code	= dw_list.object.jigyosya_code[1]
		if dw_entry.retrieve( l_jigyosya_code ) = 0 then
			dw_entry.insertrow(0)
		end if
		dw_entry.object.syori_kbn[1]	= i_syori_kbn
end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

of_dsp_edit( "dw_list", false )


// 一旦フォーカスを明細部へ
dw_entry.setfocus()



end event

event update_check;call super::update_check;
long	l_row
long	l_cnt

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

if dw_entry.accepttext() <> 1 then
	return -1
end if

for l_row = 1 to dw_list.rowcount()

	if dw_list.event itemchanged( l_row, dw_list.object.item_code, dw_list.object.item_code[l_row] ) <> 0 then
		return -1
	end if

next


end event

event update_event;call super::update_event;lstr_m_gtin		l_rec
long			l_row


// 構造体に更新値をセット

choose case i_syori_kbn
	case "登録"

		for l_row = 1 to dw_list.rowcount()
			l_rec.gtin_code		= dw_list.object.gtin_code[l_row]
			l_rec.sku_code		= dw_list.object.ms_sku_code[l_row]
			l_rec.syohin_code	= dw_list.object.ms_syohin_code[l_row]
			l_rec.iro_no		= dw_list.object.iro_no[l_row]
			l_rec.code_kbn		= dw_list.object.code_kbn[l_row]
			l_rec.jigyosya_code	= dw_list.object.jigyosya_code[l_row]
			l_rec.touroku_iti	= dw_list.object.touroku_iti[l_row]
			l_rec.indicator		= dw_list.object.indicator[l_row]
			l_rec.irisu			= dw_list.object.irisu[l_row]
			l_rec.rowid			= dw_list.object.rowid[l_row]

			if not of_db_insert( l_rec ) then
				return -1
			end if
			
		next

		// ログ出力
		of_add_db_log( "of_db_insert", 0, st_title.text + "[" + trim( sle_syohin_code.text ) + " " + trim( st_hin_ban.text ) + " " + trim( st_hin_mei.text ) + "]" + i_syori_kbn )


	case "変更"

		for l_row = 1 to dw_list.rowcount()
			l_rec.gtin_code		= dw_list.object.gtin_code[l_row]
			l_rec.sku_code		= dw_list.object.ms_sku_code[l_row]
			l_rec.syohin_code	= dw_list.object.ms_syohin_code[l_row]
			l_rec.iro_no		= dw_list.object.iro_no[l_row]
			l_rec.code_kbn		= dw_list.object.code_kbn[l_row]
			l_rec.jigyosya_code	= dw_list.object.jigyosya_code[l_row]
			l_rec.touroku_iti	= dw_list.object.touroku_iti[l_row]
			l_rec.indicator		= dw_list.object.indicator[l_row]
			l_rec.irisu			= dw_list.object.irisu[l_row]
			l_rec.rowid			= dw_list.object.rowid[l_row]
			// rowid=null and gtin_codeが入力されていれば、INSERT
			if isnull( l_rec.rowid ) then
				if len( trim( l_rec.gtin_code ) ) > 0 then
					if not of_db_insert( l_rec ) then
						return -1
					end if
				end if
			else
				// rowidがあり、gtin_codeが入力されていれば、UPDATE
				if len( trim( l_rec.gtin_code ) ) > 0 then
					if not of_db_update( l_rec ) then
						return -1
					end if
				else
				// rowidがあり、gtin_codeが未入力であればDELETE
					if not of_db_delete( l_rec ) then
						return -1
					end if					
				end if
			end if
		next

		// ログ出力
		of_add_db_log( "update_event", 0, st_title.text + "[" + trim( sle_syohin_code.text ) + " " + trim( st_hin_ban.text ) + " " + trim( st_hin_mei.text ) + "]" + i_syori_kbn )

			
	case "削除"

		for l_row = 1 to dw_list.rowcount()
			l_rec.gtin_code		= dw_list.object.gtin_code[l_row]
			l_rec.sku_code		= dw_list.object.ms_sku_code[l_row]
			l_rec.syohin_code	= dw_list.object.ms_syohin_code[l_row]
			l_rec.iro_no		= dw_list.object.iro_no[l_row]
			l_rec.code_kbn		= dw_list.object.code_kbn[l_row]
			l_rec.jigyosya_code	= dw_list.object.jigyosya_code[l_row]
			l_rec.touroku_iti	= dw_list.object.touroku_iti[l_row]
			l_rec.indicator		= dw_list.object.indicator[l_row]
			l_rec.irisu			= dw_list.object.irisu[l_row]
			l_rec.rowid			= dw_list.object.rowid[l_row]

			if not of_db_delete( l_rec ) then
				return -1
			end if
		next

		// ログ出力
		of_add_db_log( "of_db_delete", 0, st_title.text + "[" + trim( sle_syohin_code.text ) + " " + trim( st_hin_ban.text ) + " " + trim( st_hin_mei.text ) + "]" + i_syori_kbn )

			
	case "照会"
end choose

// GTIN管理マスタ更新
choose case i_syori_kbn
	case "登録", "変更"
		if not of_db_update_gtin_kanri() then
			return -1
		end if
end choose


msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
post event retrieve_event( 0, 0 )


end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not sle_syohin_code.event input_check( ) then
	return -1
end if

end event

type uo_signal from iw_main_window`uo_signal within wmm_jan
end type

type st_date from iw_main_window`st_date within wmm_jan
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_jan
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_jan
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_jan
end type

type st_title from iw_main_window`st_title within wmm_jan
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_jan
end type

type st_upper from iw_main_window`st_upper within wmm_jan
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_jan
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_jan
integer y = 156
integer taborder = 40
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type st_syori_kbn from ivo_statictext within wmm_jan
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_jan
integer x = 348
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

type dw_list from ivo_datawindow within wmm_jan
integer y = 640
integer width = 5120
integer height = 1643
integer taborder = 60
boolean bringtotop = true
string dataobject = "dmm_jan_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean save_excel = false
boolean row_focus_ind = true
end type

event constructor;call super::constructor;
long			l_row
string			l_rowid


if long( this.object.datawindow.firstrowonpage ) > 0 then

	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
			for l_row = 1 to this.rowcount()
				l_rowid		= trim( this.object.rowid[l_row] )
				if len( trim( l_rowid ) ) > 0 then
					of_record_lock_rowid( l_rowid, false )
				end if
			next
	end choose
	
end if

this.reset()
this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
//	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
//	this.of_set_fnkey( keyf5!, false )
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

event retrieveend;call super::retrieveend;
of_loading( false )
end event

event retrieverow;call super::retrieverow;
yield()
end event

event retrievestart;call super::retrievestart;
of_loading( true )

end event

event itemchanged;call super::itemchanged;
string	l_jigyosya_code
string	l_jan13
int		l_check_degit
string	l_status
string	l_data_bf
string	l_item_code
string	l_rowid

i_syori_kbn			= ddplb_syori_kbn.text
l_jigyosya_code		= trim( dw_entry.object.jigyosya_code[1] )

choose case dwo.name
	case "item_code"

		if len( trim( data ) ) > 0 then

			// 数値のみ入力可
			if not isnumber( trim( data ) ) then
				msg.of_error_dwo( dwo, "数値を入力してください。" )
				return 1
			end if
			
			l_data_bf	= this.object.item_code[row]
			
			if isnull( l_data_bf ) then
				l_data_bf	= ""
			end if
			
			if data <> l_data_bf then
				
				if len( data ) > 0 then
		
					if i_syori_kbn = "登録" then
						l_status	= "新規登録"
					elseif i_syori_kbn = "変更" then
						l_status	= "変更"
					elseif i_syori_kbn = "削除" then
						l_status	= "削除"
					end if
					l_jan13	= of_get_jancode( l_jigyosya_code, trim( data ) )
					if len( l_jan13 ) = 0 then
						return 1
					end if
					// 重複チェック(画面)
					if not of_dwchk_duplicate_dw( dwo, row, l_jan13 ) then
						return 1
					end if
					l_rowid	= this.object.rowid[row]
					// 重複チェック(DB)
					if not of_dwchk_duplicate_ora( dwo, l_jan13, l_rowid ) then
						return 1
					end if
					
					this.object.gtin_code[row]	= l_jan13
					this.object.status[row]		= l_status
					// 前ゼロ値をセット
					l_item_code	= of_get_itemcode( l_jigyosya_code, trim( data ) )
					this.post setitem( row, "item_code", l_item_code )
				end if
			end if
		else
			this.object.gtin_code[row]	= ""
			this.object.status[row]		= ""
		end if
		
	case else


end choose

return 0
end event

event clicked;call super::clicked;
string	l_columnname

// クリックされたところがヘッダなら、そこを起点にソートをかける
if string( dwo.type ) = "text" and right( string( dwo.name ), 2 ) = "_t" then
	l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) - 2 )
	of_set_dynamic_sort( l_columnname )
end if



end event

type st_syohin_code from ivo_statictext within wmm_jan
integer x = 32
integer y = 267
boolean bringtotop = true
long backcolor = 12632256
string text = "商品コード"
alignment alignment = right!
end type

type sle_syohin_code from ivo_singlelineedit within wmm_jan
string tag = "商品コード"
integer x = 348
integer y = 260
integer width = 288
integer taborder = 20
boolean bringtotop = true
string text = ""
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;

this.enabled			= true

this.text			= ""
st_hin_ban.text		= ""
st_hin_mei.text		= ""
st_syusoku_flg.text	= ""

setnull( i_syohin_code )

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }


end event

event input_check;call super::input_check;
string	l_code
string	l_hin_ban
string	l_hin_mei
string	l_syusoku_flg
long	l_cnt

l_code		= trim( sle_syohin_code.text )
i_syori_kbn	= ddplb_syori_kbn.text

// 必須チェック
if len( l_code ) = 0 then
	msg.of_error_sle( this, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ) )
	this.setfocus()
	return false
end if
// 型チェック
if isnumber( l_code ) = false then
	msg.of_error_sle( this, fnc.strg.of_format( "必数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

// 商品マスタ存在チェック
select max( hin_ban ), max( hin_mei ), decode( max( syusoku_flg ), 1, '終息', '' )
  into :l_hin_ban, :l_hin_mei, :l_syusoku_flg
  from m_syohin
 where syohin_code	= to_number( :l_code )
using cocos;
	
choose case cocos.sqlcode
	case 0
		st_hin_ban.text		= l_hin_ban
		st_hin_mei.text		= l_hin_mei
		st_syusoku_flg.text	= l_syusoku_flg
	case 100
		msg.of_error_sle( this, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", this.tag ) )
		this.setfocus()
		return false
	case else
		msg.of_error_sle( this, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

// GTINマスタ存在チェック
select count('x')
  into :l_cnt
  from m_gtin
 where syohin_code	= to_number( :l_code )
   and code_kbn		= 1
using cocos;

if i_syori_kbn = "登録" then
	if l_cnt > 0 then
		msg.of_error_sle( this, fnc.strg.of_format( "該当データが存在します。この処理は実行できません。", "" ) )
		this.setfocus()
		return false
	end if
else
	if l_cnt = 0 then
		msg.of_error_sle( this, fnc.strg.of_format( "入力された{1}はGTINマスタに存在しません。", this.tag ) )
		this.setfocus()
		return false
	end if
end if

// 終息チェック
if st_syusoku_flg.text	= "終息" then
	if i_syori_kbn <> "照会" then
		msg.of_error_sle( this, "終息設定された商品は照会のみ可能です。" )
		ddplb_syori_kbn.text	= "照会"
		this.setfocus()
	end if
end if

return true

end event

event key_f08;call super::key_f08;//
//// 参照設定
//str_mdlpara_syohin	l_mdl_syohin
//
//// モーダルを開く
//l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )
//
//if upperbound( l_mdl_syohin.ret ) > 0 then
//	sle_syohin_code.text	= string( l_mdl_syohin.ret[1].syohin_code )
//	st_hin_ban.text			= l_mdl_syohin.ret[1].hin_ban
//	st_hin_mei.text			= l_mdl_syohin.ret[1].hin_mei
//	st_syusoku_flg.text		= l_mdl_syohin.ret[1].syusoku_flg
//end if
//
return 0
end event

type cb_menu_id from sv_cb_modal within wmm_jan
integer x = 652
integer y = 260
integer taborder = 30
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
sle_syohin_code.event key_f08( keyf8!, 0 )
end event

type st_hin_ban from ivo_statictext within wmm_jan
integer x = 780
integer y = 263
integer width = 408
integer height = 82
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

type st_hin_mei from ivo_statictext within wmm_jan
integer x = 1204
integer y = 263
integer width = 1608
integer height = 82
boolean bringtotop = true
long backcolor = 134217752
string text = ""
end type

type st_syusoku_flg from ivo_statictext within wmm_jan
integer x = 2844
integer y = 263
integer width = 408
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 553648127
string text = ""
end type

type dw_entry from ivo_datawindow within wmm_jan
integer y = 373
integer width = 5120
integer height = 256
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_jan_jigyosya"
boolean border = false
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
long			l_row
string			l_rowid

// GTIN管理Mは楽観ロックでOKのはず

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	
	choose case i_syori_kbn
		case "変更", "削除"
//			// ロック解除
//			if len( trim( l_rowid ) ) > 0 then
//				of_record_lock_rowid( l_rowid, false )
//			end if
			// 参照ボタン設定
			this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
		case else
			this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
	end choose
	
end if

this.settransobject(cocos)

this.reset()
this.insertrow(0)

end event

event key_f08;call super::key_f08;

if this.rowcount() = 0 then
	return 0
end if

// F8:参照
//choose case this.getcolumnname()
//	case "jigyosya_code"
//		// 事業者
//		of_reference( this, this.object.jigyosya_code, this.getrow() )
//		
//end choose


return 0
end event

event itemchanged;call super::itemchanged;
string	l_jigyosya_code
int		l_haiban_flg
long	l_row

choose case dwo.name
	case "jigyosya_code"
		
		l_jigyosya_code	= trim( data )
		
		// 事業者存在＆廃番チェック
		select haiban_flg
		  into :l_haiban_flg
		  from m_gtin_kanri
		 where jigyosya_code	= :l_jigyosya_code
		using cocos	;
		 
		choose case cocos.sqlcode
			case 0
				if l_haiban_flg = 1 then
					msg.of_error_dwo( dwo, "廃番の事業者は設定できません。" )
					return 1
				else
					if this.retrieve( l_jigyosya_code ) > 0 then
						this.object.syori_kbn[row]	= ddplb_syori_kbn.text
					end if
				end if
			case 100
				msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyosya_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
		
		// dw_listに値セット
		if data <> this.object.jigyosya_code[row] then
			for l_row = 1 to dw_list.rowcount()
				dw_list.object.jigyosya_code[l_row]	= trim( data )
				
			next
		end if
		
	case else


end choose

return 0
end event

event clicked;call super::clicked;
// F8:参照
choose case dwo.name
	case "b_jigyosya_code"
		// 参照起動
//		of_reference( this, dwo, row )

	case "b_saiban"
		// 自動採番
		of_set_itemcode_auto()



end choose

end event

event losefocus;call super::losefocus;
if this.accepttext() <> 1 then
	return -1
end if

end event

