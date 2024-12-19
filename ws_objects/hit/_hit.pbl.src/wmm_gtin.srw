$PBExportHeader$wmm_gtin.srw
$PBExportComments$GTIN管理登録
forward
global type wmm_gtin from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_gtin
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_gtin
end type
type dw_entry from ivo_datawindow within wmm_gtin
end type
type dw_list from ivo_datawindow within wmm_gtin
end type
type lstr_m_gtin_kanri from structure within wmm_gtin
end type
end forward

type lstr_m_gtin_kanri from structure
	string		jigyosya_code
	string		jigyosya_mei
	integer		jido_saiban_flg
	long		item_code_str
	long		item_code_end
	long		item_code_gen
	integer		rep_flg
	integer		haiban_flg
	string		rowid
end type

global type wmm_gtin from iw_main_window
string title = "GTIN管理登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_entry dw_entry
dw_list dw_list
end type
global wmm_gtin wmm_gtin

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	string	i_jigyosya_code
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
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock (string p_jigyosya_code, boolean p_lock)
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_db_delete (lstr_m_gtin_kanri p_rec)
public function boolean of_db_insert (lstr_m_gtin_kanri p_rec)
public function boolean of_db_update (lstr_m_gtin_kanri p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_jigyosya_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_jigyosya_code)
end prototypes

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_gtin_kanri
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTIN管理マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_record_lock (string p_jigyosya_code, boolean p_lock);
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
  from m_gtin_kanri mm,
       m_user mu,
       m_window mw
	 where mm.henkou_user_id= mu.user_id(+)
	   and mm.henkou_pg_id	= mw.window_id(+)
	   and mm.jigyosya_code	= :p_jigyosya_code
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

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )

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

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
	case "dw_entry"
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.object.syori_kbn[l_row]	= i_syori_kbn
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "jigyosya_code" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
		

end choose

end subroutine

public function boolean of_db_delete (lstr_m_gtin_kanri p_rec);
delete from m_gtin_kanri
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTIN管理マスタの削除処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[" + p_rec.jigyosya_code + " " + p_rec.jigyosya_mei + "]" + i_syori_kbn )

return true
end function

public function boolean of_db_insert (lstr_m_gtin_kanri p_rec);
insert into m_gtin_kanri(
	jigyosya_code,jigyosya_mei,
	jido_saiban_flg,
	item_code_str,item_code_end,item_code_gen,
	rep_flg,haiban_flg,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.jigyosya_code,:p_rec.jigyosya_mei,
	:p_rec.jido_saiban_flg,
	:p_rec.item_code_str,:p_rec.item_code_end,:p_rec.item_code_gen,
	:p_rec.rep_flg,:p_rec.haiban_flg,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "GTIN管理マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[" + p_rec.jigyosya_code + " " + p_rec.jigyosya_mei + "]" + i_syori_kbn )

return true

end function

public function boolean of_db_update (lstr_m_gtin_kanri p_rec);
update m_gtin_kanri
   set jigyosya_code	= :p_rec.jigyosya_code,
	   jigyosya_mei		= :p_rec.jigyosya_mei,
	   jido_saiban_flg	= :p_rec.jido_saiban_flg,
	   item_code_str	= :p_rec.item_code_str,
	   item_code_end	= :p_rec.item_code_end,
	   item_code_gen	= :p_rec.item_code_gen,
	   rep_flg			= :p_rec.rep_flg,
	   haiban_flg		= :p_rec.haiban_flg,
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
	msg.of_error_db( "GTIN管理マスタの更新処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[" + p_rec.jigyosya_code + " " + p_rec.jigyosya_mei + "]" + i_syori_kbn )

return true


end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_jigyosya_code, string p_rowid);
string	l_db_jigyosya_mei

select jigyosya_mei
  into :l_db_jigyosya_mei
  from m_gtin_kanri
 where jigyosya_code		= :p_jigyosya_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている事業者コードはすでに登録があります。{1}【登録済の事業者コード】{2}：{3}", code.crlf, p_jigyosya_code, l_db_jigyosya_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error_db( "入力チェックでエラーが発生しました。", cocos )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_jigyosya_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_jigyosya_code, l_rowid )
end function

on wmm_gtin.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_entry=create dw_entry
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.dw_list
end on

on wmm_gtin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_entry)
destroy(this.dw_list)
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
// st_second_upper高さ
st_second_upper.height	= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y		= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= 274

dw_list.y			= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y

// 登録日時＆変更日時
dw_entry.object.henkou_date.x		= dw_entry.width - long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x		= long( dw_entry.object.henkou_date.x ) - long( dw_entry.object.henkou_date_t.width ) - 20
dw_entry.object.touroku_date.x		= long( dw_entry.object.henkou_date_t.x ) - long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x	= long( dw_entry.object.touroku_date.x ) - long( dw_entry.object.touroku_date_t.width ) - 20


end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
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
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_jigyosya_code ) = 0 then
	if i_syori_kbn <> "登録" then
		msg.of_error( "登録されたデータはありません。" )
		ddplb_syori_kbn.setfocus()
		return -1
	end if
end if

setredraw( false )

// 更新部初期化
dw_entry.event constructor( )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

of_dsp_edit( "dw_entry", true )

//// 編集モードあれこれ
//// 一旦フォーカスを明細部へ
//dw_list.setfocus()
//
//choose case i_syori_kbn
//	case "登録"
//		of_dsp_edit( "dw_entry", true )
//		// フォーカスは親更新部へ
//		dw_entry.setfocus()
//	case "変更", "削除", "照会"
//end choose

setredraw( true )


end event

event update_check;call super::update_check;
long	l_row
long	l_cnt

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_jigyosya_code		= dw_entry.object.jigyosya_code[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.jigyosya_code, dw_entry.object.jigyosya_code[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jigyosya_mei, dw_entry.object.jigyosya_mei[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jido_saiban_flg, string( dw_entry.object.jido_saiban_flg[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.item_code_str, string( dw_entry.object.item_code_str[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.item_code_end, string( dw_entry.object.item_code_end[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.item_code_gen, string( dw_entry.object.item_code_gen[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.rep_flg, string( dw_entry.object.rep_flg[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.haiban_flg, string( dw_entry.object.haiban_flg[l_row] ) ) <> 0 then
	return -1
end if

// 複合チェック
// 自動採番「1」
if dw_entry.object.jido_saiban_flg[l_row] = 1 then
	// 必須チェック
	if len( string( dw_entry.object.item_code_str[l_row] ) ) = 0 then
		msg.of_error_dwo( dw_entry.object.item_code_str, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "商品アイテムコード（開始）" ) )
		dw_entry.setfocus()
		dw_entry.setcolumn( "item_code_str" )
		return -1
	end if
	if len( string( dw_entry.object.item_code_end[l_row] ) ) = 0 then
		msg.of_error_dwo( dw_entry.object.item_code_end, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "商品アイテムコード（終了）" ) )
		dw_entry.setfocus()
		dw_entry.setcolumn( "item_code_end" )
		return -1
	end if
	if len( string( dw_entry.object.item_code_gen[l_row] ) ) = 0 then
		msg.of_error_dwo( dw_entry.object.item_code_gen, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "商品アイテムコード（現在）" ) )
		dw_entry.setfocus()
		dw_entry.setcolumn( "item_code_gen" )
		return -1
	end if
	// 大小チェック
	if dw_entry.object.item_code_str[l_row] > dw_entry.object.item_code_end[l_row] then
		msg.of_error_dwo( dw_entry.object.item_code_str, fnc.strg.of_format( "採番範囲の大小関係が間違っています。[ {1} ]", "商品アイテムコード（開始）＆（終了）" ) )
		dw_entry.setfocus()
		dw_entry.setcolumn( "item_code_str" )
		return -1
	end if
	// 範囲チェック
	if dw_entry.object.item_code_str[l_row] > dw_entry.object.item_code_gen[l_row] or dw_entry.object.item_code_end[l_row] < dw_entry.object.item_code_gen[l_row] then
		msg.of_error_dwo( dw_entry.object.item_code_gen, fnc.strg.of_format( "現在No.は採番範囲内の値を入力してください。[ {1} ]", "商品アイテムコード（現在）" ) )
		dw_entry.setfocus()
		dw_entry.setcolumn( "item_code_gen" )
		return -1
	end if
end if



end event

event update_event;call super::update_event;lstr_m_gtin_kanri	l_rec
integer				l_row


l_row	= long( dw_entry.object.datawindow.firstrowonpage )
// 構造体に更新値をセット
l_rec.jigyosya_code		= dw_entry.object.jigyosya_code[l_row]
l_rec.jigyosya_mei		= dw_entry.object.jigyosya_mei[l_row]
l_rec.jido_saiban_flg	= dw_entry.object.jido_saiban_flg[l_row]
l_rec.item_code_str		= dw_entry.object.item_code_str[l_row]
l_rec.item_code_end		= dw_entry.object.item_code_end[l_row]
l_rec.item_code_gen		= dw_entry.object.item_code_gen[l_row]
l_rec.rep_flg			= dw_entry.object.rep_flg[l_row]
l_rec.haiban_flg		= dw_entry.object.haiban_flg[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]

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

type uo_signal from iw_main_window`uo_signal within wmm_gtin
end type

type st_date from iw_main_window`st_date within wmm_gtin
integer height = 75
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_gtin
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_gtin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_gtin
end type

type st_title from iw_main_window`st_title within wmm_gtin
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_gtin
end type

type st_upper from iw_main_window`st_upper within wmm_gtin
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_gtin
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_gtin
integer y = 156
integer textsize = -11
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type st_syori_kbn from ivo_statictext within wmm_gtin
integer x = 32
integer y = 167
integer height = 75
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_gtin
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

type dw_entry from ivo_datawindow within wmm_gtin
integer y = 373
integer width = 5120
integer height = 274
integer taborder = 20
boolean bringtotop = true
string dataobject = "dmm_gtin_entry"
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
string	l_jigyosya_code
string	l_input
string	l_colnm
string	l_tableid	= "m_gtin_kanri"
string	l_msg


// 項目チェック
choose case dwo.name
	case "jigyosya_code", "jigyosya_mei", "item_code_str", "item_code_end", "item_code_gen"

		l_input	= trim( data )
//		l_colnm	= this.describe( dwo.name + "_t.text'" )	// タイトルより項目名を取得
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別仕様
choose case dwo.name
	case "jigyosya_code"
		// 事業者コード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		// 入力値の桁数が7桁、9桁、10桁以外の場合
		if len( data )  <> 7 and len( data ) <> 9 and len( data ) <> 10 then
			msg.of_error_dwo( dwo, "事業所コードの桁数は7桁、9桁、10桁で入力してください。" )
			return 1
		end if

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, data ) then
					return 1
				end if

				// 桁セット
				l_jigyosya_code		= this.object.jigyosya_code[row]
				if isnull( l_jigyosya_code ) then
					l_jigyosya_code	= ""
				end if
				if data <> l_jigyosya_code then
					this.object.jigyosya_code_byte[row]	= "(" + string( len( data ) ) + "桁)"
				end if
				
		end choose
		

	case "item_code_str", "item_code_end", "item_code_gen"
		// 事業所コード＋入力値桁数＞12桁 チェック
		l_jigyosya_code		= this.object.jigyosya_code[row]
		if len( l_jigyosya_code ) > 0 then
			if len( l_jigyosya_code ) + len( data ) > 12 then
				msg.of_error_dwo( dwo, "事業部桁数と合計して12桁以内になるように入力してください。" )
				return 1
			end if
		end if

	case else

end choose







return 0
end event

type dw_list from ivo_datawindow within wmm_gtin
integer y = 640
integer width = 5120
integer height = 1643
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_gtin_list"
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
l_file	= fnc.strg.of_format( "GTIN管理マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
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

event doubleclicked;call super::doubleclicked;long	l_upd_row
string	l_code
long	l_row

setredraw( false )

if row > 0 then
	
	i_jigyosya_code	= this.object.jigyosya_code[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.jigyosya_code[l_row]	= this.object.jigyosya_code[row]
			dw_entry.object.jigyosya_code_byte[l_row]	= "(" + string( len( i_jigyosya_code ) ) + "桁)"
			dw_entry.object.jigyosya_mei[l_row]		= this.object.jigyosya_mei[row]
			if this.object.jido_saiban_flg[row] = "1:対象" then
				dw_entry.object.item_code_str[l_row]	= 1
			else
				dw_entry.object.item_code_str[l_row]	= 0
			end if
			dw_entry.object.item_code_str[l_row]	= this.object.item_code_str[row]
			dw_entry.object.item_code_end[l_row]	= this.object.item_code_end[row]
			dw_entry.object.item_code_gen[l_row]	= this.object.item_code_gen[row]
			if this.object.rep_flg[row] = "1:対象" then
				dw_entry.object.rep_flg[l_row]			= 1
			else
				dw_entry.object.rep_flg[l_row]			= 0
			end if
			if this.object.haiban_flg[row] = "1:廃番" then
				dw_entry.object.haiban_flg[l_row]		= 1
			else
				dw_entry.object.haiban_flg[l_row]		= 0
			end if

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_jigyosya_code, true ) then
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_jigyosya_code ) > 0 then
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

event clicked;call super::clicked;
string	l_columnname

// クリックされたところがヘッダなら、そこを起点にソートをかける
if string( dwo.type ) = "text" and right( string( dwo.name ), 2 ) = "_t" then
	l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) - 2 )
	of_set_dynamic_sort( l_columnname )
end if



end event

