$PBExportHeader$wmm_senden_tyohyo.srw
$PBExportComments$専伝帳票登録
forward
global type wmm_senden_tyohyo from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_senden_tyohyo
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_senden_tyohyo
end type
type dw_list from ivo_datawindow within wmm_senden_tyohyo
end type
type dw_entry from ivo_datawindow within wmm_senden_tyohyo
end type
type lstr_m_senden_tyohyo from structure within wmm_senden_tyohyo
end type
end forward

type lstr_m_senden_tyohyo from structure
	string		tyohyo_id
	string		tyohyo_mei
	string		tyohyo_mei_ryaku
	long		tyohyo_syubetu
	long		max_gyo_su
	long		syori_jyun
	string		guide_message
	string		rowid
end type

global type wmm_senden_tyohyo from iw_main_window
string title = "専伝帳票登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_list dw_list
dw_entry dw_entry
end type
global wmm_senden_tyohyo wmm_senden_tyohyo

type variables
private:

	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	string	i_tyohyo_id
	
	long 	i_syohin_code
	long 	i_iro_no
	
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
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id)
public function boolean of_record_lock (string p_tyohyo_id, boolean p_lock)
public function boolean of_db_delete (lstr_m_senden_tyohyo p_rec)
public function boolean of_db_insert (lstr_m_senden_tyohyo p_rec)
public function boolean of_db_update (lstr_m_senden_tyohyo p_rec)
end prototypes

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
		dw_list.enabled			= p_enabled
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.object.syori_kbn[l_row] = i_syori_kbn
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "tyohyo_id" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
		
end choose

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_senden_tyohyo
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "専伝帳票マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装



end subroutine

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_rowid);
string	l_db_tyohyo_mei

select tyohyo_mei
  into :l_db_tyohyo_mei
  from m_senden_tyohyo
 where tyohyo_id			=  :p_tyohyo_id
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている帳票IDはすでに登録があります。{1}【登録済の帳票ID】{2}：{3}", code.crlf, p_tyohyo_id, l_db_tyohyo_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error_db( "入力チェックでエラーが発生しました。", cocos )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_tyohyo_id, l_rowid )
end function

public function boolean of_record_lock (string p_tyohyo_id, boolean p_lock);
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
  from m_senden_tyohyo mm,
       m_user mu,
       m_window mw
 where mm.henkou_user_id = mu.user_id(+)
 and mm.henkou_pg_id	 = mw.window_id(+)
 and mm.tyohyo_id	     = :p_tyohyo_id
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

public function boolean of_db_delete (lstr_m_senden_tyohyo p_rec);
delete from m_senden_tyohyo
 where rowid = :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "専伝帳票マスタの削除処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[" + p_rec.tyohyo_id + " " + p_rec.tyohyo_mei + "]" + i_syori_kbn )

return true
end function

public function boolean of_db_insert (lstr_m_senden_tyohyo p_rec);
insert into m_senden_tyohyo(
	tyohyo_id,tyohyo_mei,tyohyo_mei_ryaku,
	tyohyo_syubetu,max_gyo_su,syori_jyun,guide_message,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.tyohyo_id,:p_rec.tyohyo_mei,:p_rec.tyohyo_mei_ryaku,
	:p_rec.tyohyo_syubetu,:p_rec.max_gyo_su,:p_rec.syori_jyun,:p_rec.guide_message,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "専伝帳票マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[" + p_rec.tyohyo_id + " " + p_rec.tyohyo_mei_ryaku + "]" + i_syori_kbn )

return true

end function

public function boolean of_db_update (lstr_m_senden_tyohyo p_rec);
update m_senden_tyohyo
   set tyohyo_id		= :p_rec.tyohyo_id,
	   tyohyo_mei		= :p_rec.tyohyo_mei,
	   tyohyo_mei_ryaku	= :p_rec.tyohyo_mei_ryaku,
	   tyohyo_syubetu	= :p_rec.tyohyo_syubetu,
	   max_gyo_su		= :p_rec.max_gyo_su,
	   syori_jyun		= :p_rec.syori_jyun,
	   guide_message	= :p_rec.guide_message,
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
	msg.of_error_db( "専伝帳票マスタの更新処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[" + p_rec.tyohyo_id + " " + p_rec.tyohyo_mei + "]" + i_syori_kbn )

return true


end function

on wmm_senden_tyohyo.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_list=create dw_list
this.dw_entry=create dw_entry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.dw_entry
end on

on wmm_senden_tyohyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_list)
destroy(this.dw_entry)
end on

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width
long	l_dw_list_width = 1360		// 固定

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

// 呼出部
// 1行目
ddplb_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y			= st_second_upper.y + code.MGN_UPPER_TATE + 7			// タイトル「+7」

// st_second_upper高さ
st_second_upper.height	= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE - st_second_upper.y

// 表示ボタン
cb_retrieve.x			= l_width - cb_retrieve.width - code.MGN_YOKO
cb_retrieve.y			= ddplb_syori_kbn.y

// 入力部
dw_entry.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x				= code.MGN_YOKO
dw_entry.width			= l_width - code.MGN_YOKO * 2
dw_entry.height			= 353

// 明細部
dw_list.y				= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= l_width - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y

// 登録日時＆変更日時
dw_entry.object.henkou_date.x		= dw_entry.width - long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x		= long( dw_entry.object.henkou_date.x ) - long( dw_entry.object.henkou_date_t.width ) - 20
dw_entry.object.touroku_date.x		= long( dw_entry.object.henkou_date_t.x ) - long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x	= long( dw_entry.object.touroku_date.x ) - long( dw_entry.object.touroku_date_t.width ) - 20

/*
// 複写元グループ
gb_fukusya_moto.x		= code.MGN_YOKO
gb_fukusya_moto.y		= uo_syohin.y + uo_syohin.height + code.MGN_TATE_MIDDLE

// コード
uo_syohin_moto.x 		= gb_fukusya_moto.x + code.MGN_YOKO
uo_syohin_moto.y 		= gb_fukusya_moto.y + code.MGN_TATE_LARGE

// 複写元グループ高さ、幅
gb_fukusya_moto.width	= uo_syohin_moto.x + uo_syohin_moto.width + code.MGN_YOKO
gb_fukusya_moto.height	= uo_syohin_moto.y + uo_syohin_moto.height + 42 - gb_fukusya_moto.y

// ↓、複写
st_down_arrow.y			= gb_fukusya_moto.y + gb_fukusya_moto.height + code.MGN_TATE_MIDDLE
cb_copy.y				= st_down_arrow.y

// 寸法情報タイトル
st_sunpo_title.x		= code.MGN_YOKO
st_sunpo_title.y		= cb_copy.y + 89 + code.MGN_TATE

// 前行複写、一括複写
cb_zengyo_copy.y		= key_fnc.y - code.MGN_TATE_MIDDLE - cb_zengyo_copy.height
cb_ikkatu_copy.y		= cb_zengyo_copy.y

// 入力部
dw_list.x				= code.MGN_YOKO
dw_list.y				= st_sunpo_title.y + st_sunpo_title.height + code.MGN_TATE
dw_list.height			= cb_zengyo_copy.y - code.MGN_TATE - dw_list.y
dw_list.width			= l_dw_list_width + 90												// 90：スクロール幅

// 前行複写、一括複写
cb_ikkatu_copy.x		= ( dw_list.x + l_dw_list_width + 90 ) - cb_ikkatu_copy.width		// 90：スクロール幅
cb_zengyo_copy.x		= cb_ikkatu_copy.x  - cb_ikkatu_copy.width - code.MGN_GROUP_YOKO
*/
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

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_tyohyo_id ) = 0 then
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

dw_list.setfocus()

choose case i_syori_kbn
	case "登録"
		of_dsp_edit( "dw_entry", true )
		dw_entry.setfocus()
	case "変更", "削除", "照会"
end choose

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

i_tyohyo_id		= dw_entry.object.tyohyo_id[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.tyohyo_id, dw_entry.object.tyohyo_id[l_row] ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "tyohyo_id" )
	dw_entry.setfocus()
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.tyohyo_mei, dw_entry.object.tyohyo_mei[l_row] ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "tyohyo_mei" )
	dw_entry.setfocus()
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.tyohyo_mei_ryaku, dw_entry.object.tyohyo_mei_ryaku[l_row] ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "tyohyo_mei_ryaku" )
	dw_entry.setfocus()
	return -1
end if

// 種別のみここで必須チェック
if isnull( dw_entry.object.tyohyo_syubetu[l_row] ) then
	msg.of_error_dwo( dw_entry.object.tyohyo_syubetu, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", dw_entry.object.tyohyo_syubetu.tag ) )
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "tyohyo_syubetu" )
	dw_entry.setfocus()
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.max_gyo_su, string( dw_entry.object.max_gyo_su[l_row] ) ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "max_gyo_su" )
	dw_entry.setfocus()
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.syori_jyun, string( dw_entry.object.syori_jyun[l_row] ) ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "syori_jyun" )
	dw_entry.setfocus()
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.guide_message, dw_entry.object.guide_message[l_row] ) <> 0 then
	dw_entry.setrow( l_row )
	dw_entry.setcolumn( "guide_message" )
	dw_entry.setfocus()
	return -1
end if


end event

event update_event;call super::update_event;
lstr_m_senden_tyohyo	l_rec
integer					l_row

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

// 構造体に更新値をセット
l_rec.tyohyo_id			= dw_entry.object.tyohyo_id[l_row]
l_rec.tyohyo_mei		= dw_entry.object.tyohyo_mei[l_row]
l_rec.tyohyo_mei_ryaku	= dw_entry.object.tyohyo_mei_ryaku[l_row]
l_rec.tyohyo_syubetu	= dw_entry.object.tyohyo_syubetu[l_row]
l_rec.max_gyo_su		= dw_entry.object.max_gyo_su[l_row]
l_rec.syori_jyun		= dw_entry.object.syori_jyun[l_row]
l_rec.guide_message		= dw_entry.object.guide_message[l_row]
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

type uo_signal from iw_main_window`uo_signal within wmm_senden_tyohyo
end type

type st_date from iw_main_window`st_date within wmm_senden_tyohyo
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_senden_tyohyo
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_senden_tyohyo
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_senden_tyohyo
end type

type st_title from iw_main_window`st_title within wmm_senden_tyohyo
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_senden_tyohyo
end type

type st_upper from iw_main_window`st_upper within wmm_senden_tyohyo
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_senden_tyohyo
integer height = 132
boolean sf1_key = true
boolean sf2_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_senden_tyohyo
integer y = 156
integer taborder = 30
end type

event clicked;call super::clicked;
//this.enabled	= true

end event

type st_syori_kbn from ivo_statictext within wmm_senden_tyohyo
integer x = 32
integer y = 164
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_senden_tyohyo
integer x = 348
integer y = 156
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
string init_disp = "登録"
end type

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )

end event

type dw_list from ivo_datawindow within wmm_senden_tyohyo
integer x = 36
integer y = 676
integer width = 2712
integer height = 825
integer taborder = 60
string dataobject = "dmm_senden_tyohyo_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean row_multi_select = true
boolean save_excel = false
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)

// スクロールを戻す
this.object.datawindow.horizontalscrollposition = 0

this.enabled	= false


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
	case "登録","変更","削除"
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event doubleclicked;call super::doubleclicked;long	l_upd_row
string	l_code
long	l_row
long 	l_pos

setredraw( false )

i_doubleclicked	= false

if row > 0 then
	
	i_tyohyo_id	= this.object.tyohyo_id[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.tyohyo_id[l_row]		= this.object.tyohyo_id[row]
			dw_entry.object.tyohyo_mei[l_row]		= this.object.tyohyo_mei[row]
			dw_entry.object.tyohyo_mei_ryaku[l_row]	= this.object.tyohyo_mei_ryaku[row]
			dw_entry.object.tyohyo_syubetu[l_row]	= this.object.tyohyo_syubetu[row]
			dw_entry.object.max_gyo_su[l_row]		= this.object.max_gyo_su[row]
			dw_entry.object.syori_jyun[l_row]		= this.object.syori_jyun[row]
			dw_entry.object.guide_message[l_row]	= this.object.guide_message[row]
			dw_entry.object.syori_kbn[l_row] 		= i_syori_kbn

		case "変更", "削除", "照会"
			
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_tyohyo_id, true ) then
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve( i_tyohyo_id ) > 0 then
				l_row	= long( dw_entry.object.datawindow.firstrowonpage )
				dw_entry.object.syori_kbn[l_row] = i_syori_kbn

				if i_syori_kbn = "変更" then
					of_dsp_edit( "dw_entry", true )
				//else	
				//	of_dsp_edit( "dw_entry", false )
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

event key_f05;call super::key_f05;

string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "専伝帳票マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

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

type dw_entry from ivo_datawindow within wmm_senden_tyohyo
integer x = 32
integer y = 281
integer width = 4532
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_senden_tyohyo_entry"
boolean border = false
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
long			l_row
string			l_rowid
datawindowchild	l_dwc

// ddlb検索
// 285：帳票種別
this.getchild( "tyohyo_syubetu", l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve( 285, 1, 0 )

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

//this.i_function_name	= { "", "", "", "", "", "取消", "", "", "", "", "", "" }

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
string	l_input
string	l_colnm
string	l_tableid	= "m_senden_tyohyo"
string	l_msg
boolean	l_hissu 	= false		// False：未入力(null)を許容しない

// 必須チェック
if dwo.name = "guide_message" then
	// True：未入力(null)を許容する
	l_hissu = true
end if

choose case dwo.name
	case "tyohyo_id", "tyohyo_mei", "tyohyo_mei_ryaku", "max_gyo_su", "syori_jyun", "guide_message"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, l_hissu, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別仕様
choose case dwo.name
	case "tyohyo_id"
		// 帳票ID

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, data ) then
					return 1
				end if
		end choose
		
	case "max_gyo_su" 
		// MAX行数
		
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if

		// 0～99
		if double( trim( data )) < 0 or double( trim( data )) > 99 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：0～99】" )
			return 1
		end if
		
	case "syori_jyun"
		// 処理順番
		
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if

		// 0～99
		if double( trim( data )) < 1 or double( trim( data )) > 999 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：1～999】" )
			return 1
		end if
	case else

end choose

return 0
end event

