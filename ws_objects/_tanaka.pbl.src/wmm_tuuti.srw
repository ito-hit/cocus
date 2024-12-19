$PBExportHeader$wmm_tuuti.srw
$PBExportComments$通知管理登録
forward
global type wmm_tuuti from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_tuuti
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tuuti
end type
type st_syori_kbn from ivo_statictext within wmm_tuuti
end type
type dw_entry from ivo_datawindow within wmm_tuuti
end type
type lstr_m_tuuti_kanri from structure within wmm_tuuti
end type
end forward

type lstr_m_tuuti_kanri from structure
	integer		tuuti_syubetu
	integer		taisyo_kbn
	string		taisyo_code
	string		rowid
	integer		teisi_flg
	integer		tuuti_lvl
	integer		tuuti_nissu
	integer		mail_flg
end type

global type wmm_tuuti from iw_main_window
string title = "通知管理登録"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
end type
global wmm_tuuti wmm_tuuti

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	int	i_tuuti_syubetu
	int	i_taisyo_kbn
	string	i_taisyo_code
	int	i_tuuti_lvl
	int i_teisi_flg	
	int i_tuuti_nissu
	int i_mail_flg
	
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時

	// ダブルクリック状態検知
	boolean	i_doubleclicked


protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible
	
		// 初期選択させておきたい名称コード
	string	init_code
end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_db_delete (lstr_m_tuuti_kanri p_rec)
public function boolean of_db_update (lstr_m_tuuti_kanri p_rec)
public function boolean of_db_insert (lstr_m_tuuti_kanri p_rec)
public function boolean of_record_lock (integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code)
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
			dw_entry.setcolumn( "tuuti_syubetu" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
end choose

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn = ddplb_syori_kbn.text

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

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_tuuti_kanri
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "通知管理マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_db_delete (lstr_m_tuuti_kanri p_rec);
delete from m_tuuti_kanri
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "通知管理マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

public function boolean of_db_update (lstr_m_tuuti_kanri p_rec);
update m_tuuti_kanri
   set tuuti_syubetu   	= :p_rec.tuuti_syubetu,
	   taisyo_kbn		= :p_rec.taisyo_kbn,
	   taisyo_code	= :p_rec.taisyo_code,
	   teisi_flg	= :p_rec.teisi_flg,
	   tuuti_lvl	= :p_rec.tuuti_lvl,
	   tuuti_nissu	= :p_rec.tuuti_nissu,
	   mail_flg		= :p_rec.mail_flg,
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
	msg.of_error( fnc.strg.of_format( "通知管理マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true


end function

public function boolean of_db_insert (lstr_m_tuuti_kanri p_rec);
insert into m_tuuti_kanri(
	tuuti_syubetu,taisyo_kbn,
	taisyo_code,
	teisi_flg,
	tuuti_lvl,
	tuuti_nissu,
	mail_flg,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.tuuti_syubetu,:p_rec.taisyo_kbn,
	:p_rec.taisyo_code,
	:p_rec.teisi_flg,
	:p_rec.tuuti_lvl,
	:p_rec.tuuti_nissu,
	:p_rec.mail_flg,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "通知管理マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true

end function

public function boolean of_record_lock (integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mtk.rowid,mtk.haita_flg,
       nvl( to_char( mtk.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mtk.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mtk.henkou_client_id, '???' ),
       nvl( mtk.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_tuuti_kanri mtk,
       m_user mu,
       m_window mw
	 where mtk.henkou_user_id= mu.user_id(+)
	   and mtk.henkou_pg_id	= mw.window_id(+)
	   and mtk.tuuti_syubetu	= :p_tuuti_syubetu
	   and mtk.taisyo_kbn	= :p_taisyo_kbn
   	   and mtk.taisyo_code	= :p_taisyo_code
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

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装あり

// 参照設定
str_mdlpara_mmeisyo	l_mdl_meisyo
str_mdlpara_muser	l_mdl_user


// F8:参照
choose case p_dwo.name
	case "b_taisyo"

		if p_dw.object.taisyo_kbn[p_row]=4 then
		
			l_mdl_meisyo.in_meisyo_kbn	= 24
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.taisyo_code[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.taisyo_code_meisyo[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
			end if
		
		elseif p_dw.object.taisyo_kbn[p_row]=5 then
		
			l_mdl_user	= mdl.of_open_modal( "wsm_user", l_mdl_user )
			if upperbound( l_mdl_user.ret ) > 0 then
				p_dw.object.taisyo_code[p_row]	= l_mdl_user.ret[1].user_id
				p_dw.object.taisyo_code_meisyo[p_row]	= l_mdl_user.ret[1].user_mei
			end if
			
		end if

end choose


end subroutine

public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code, string p_rowid);
integer	l_db_taisyo_kbn

select taisyo_kbn
  into :l_db_taisyo_kbn
  from m_tuuti_kanri
 where tuuti_syubetu		= :p_tuuti_syubetu
   and taisyo_kbn			= :p_taisyo_kbn
   and taisyo_code			= :p_taisyo_code   
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
//		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている通知管理はすでに登録があります。{1}【登録済のブランドコードコード】{2}：{3}", code.crlf, p_tuuti_syubetu, l_db_taisyo_kbn ) )
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている通知管理はすでに登録があります。通知種別{1}:送信対象{2}:対象コード{3}",string(p_tuuti_syubetu),string(p_taisyo_kbn),p_taisyo_code))

		return false
	case 100
		return true
	case else
//		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )

		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_tuuti_syubetu, integer p_taisyo_kbn, string p_taisyo_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_tuuti_syubetu,p_taisyo_kbn,p_taisyo_code, l_rowid )
end function

on wmm_tuuti.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.st_syori_kbn
this.Control[iCurrent+4]=this.dw_entry
end on

on wmm_tuuti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
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

// st_second_upperの高さは1列分
st_second_upper.width	= st_upper.width
st_second_upper.x		= st_upper.x
st_second_upper.height	= 89 + code.MGN_TATE * 2
st_second_upper.y		= st_upper.y + st_upper.height

cb_retrieve.width	= 380
cb_retrieve.height	= 85
cb_retrieve.y		= st_second_upper.y + st_second_upper.height - cb_retrieve.height - code.MGN_TATE
cb_retrieve.x		= newwidth - cb_retrieve.width - code.MGN_YOKO

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= 307

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
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_tuuti_syubetu,i_taisyo_kbn,i_taisyo_code ) = 0 then
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
lstr_m_tuuti_kanri	l_rec
integer				l_row


l_row	= long( dw_entry.object.datawindow.firstrowonpage )
// 構造体に更新値をセット
l_rec.tuuti_syubetu		= dw_entry.object.tuuti_syubetu[l_row]
l_rec.taisyo_kbn		    = dw_entry.object.taisyo_kbn[l_row]
l_rec.taisyo_code	= dw_entry.object.taisyo_code[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]
l_rec.teisi_flg				= dw_entry.object.teisi_flg[l_row]
l_rec.tuuti_lvl				= dw_entry.object.tuuti_lvl[l_row]
l_rec.tuuti_nissu				= dw_entry.object.tuuti_nissu[l_row]
l_rec.mail_flg				= dw_entry.object.mail_flg[l_row]


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

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_tuuti_syubetu		= dw_entry.object.tuuti_syubetu[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.tuuti_syubetu, string(dw_entry.object.tuuti_syubetu[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.taisyo_kbn, string(dw_entry.object.taisyo_kbn[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.taisyo_code, dw_entry.object.taisyo_code[l_row] ) <> 0 then
	return -1
end if

// 必須チェック
if len( string( dw_entry.object.taisyo_kbn[l_row] ) ) = 0 then
	msg.of_error_dwo( dw_entry.object.taisyo_kbn, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "通知種別" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "taisyo_kbn" )
	return -1
end if

end event

type uo_signal from iw_main_window`uo_signal within wmm_tuuti
end type

type st_date from iw_main_window`st_date within wmm_tuuti
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tuuti
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tuuti
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tuuti
end type

type st_title from iw_main_window`st_title within wmm_tuuti
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tuuti
end type

type st_upper from iw_main_window`st_upper within wmm_tuuti
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tuuti
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tuuti
integer taborder = 20
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_tuuti
integer x = 8
integer y = 814
integer width = 4208
integer height = 1177
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_tuuti_list"
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
l_file	= fnc.strg.of_format( "ブランドマスタ{1}", string( today(), "yyyymmdd" ) )

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
	
	i_tuuti_syubetu	= this.object.tuuti_syubetu[row]
	i_taisyo_kbn	= this.object.taisyo_kbn[row]
	i_taisyo_code	= this.object.taisyo_code[row]
	i_tuuti_lvl		= this.object.tuuti_lvl[row]
	i_teisi_flg		= this.object.teisi_flg[row]
	i_tuuti_nissu	= this.object.tuuti_nissu[row]
	i_mail_flg		= this.object.mail_flg[row]
	
	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.tuuti_syubetu[l_row]	= this.object.tuuti_syubetu[row]
			dw_entry.object.tuuti_syubetu_mei[l_row]	= this.object.tuuti_syubetu_mei[row]
			
			dw_entry.object.taisyo_kbn[l_row]		= this.object.taisyo_kbn[row]
			dw_entry.object.taisyo_kbn_mei[l_row]		= this.object.taisyo_kbn_mei[row]
			dw_entry.object.taisyo_code[l_row]		= this.object.taisyo_code[row]
			dw_entry.object.taisyo_code_meisyo[l_row]		= this.object.taisyo_code_meisyo[row]		
			dw_entry.object.tuuti_lvl[l_row]		= this.object.tuuti_lvl[row]
			dw_entry.object.tuuti_lvl_mei[l_row]		= this.object.tuuti_lvl_mei[row]
			dw_entry.object.teisi_flg[l_row]		= this.object.teisi_flg[row]
			dw_entry.object.tuuti_nissu[l_row]		= this.object.tuuti_nissu[row]
			dw_entry.object.mail_flg[l_row]			= this.object.mail_flg[row]

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_tuuti_syubetu,i_taisyo_kbn,i_taisyo_code, true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_tuuti_syubetu,i_taisyo_kbn,i_taisyo_code ) > 0 then
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

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tuuti
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

type st_syori_kbn from ivo_statictext within wmm_tuuti
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_tuuti
integer y = 373
integer width = 5120
integer height = 306
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_tuuti_entry"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
DataWindowChild	ldwc_tuuti_syubetu
DataWindowChild	ldwc_taisyo_kbn
DataWindowChild	ldwc_tuuti_lvl

long			l_row
string			l_rowid
integer		l_code_visible


// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "tuuti_syubetu_mei", ldwc_tuuti_syubetu)
ldwc_tuuti_syubetu.settransobject( cocos )

meisyo_kbn		= 163
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_tuuti_syubetu.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "taisyo_kbn_mei", ldwc_taisyo_kbn)
ldwc_taisyo_kbn.settransobject( cocos )

meisyo_kbn		= 165
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_taisyo_kbn.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "tuuti_lvl_mei", ldwc_tuuti_lvl)
ldwc_tuuti_lvl.settransobject( cocos )

meisyo_kbn		= 3
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_tuuti_lvl.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

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
string	l_tuuti_syubetu
//int	l_tuuti_syubetu
string	l_mei
string	l_meisyo_code,l_meisyo_mei

string	l_input
string	l_colnm
string	l_tableid	= "m_tuuti_kanri"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "tuuti_syubetu", "taisyo_kbn"
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
	case "tuuti_syubetu_mei"
		
		this.object.taisyo_code[row]=''
		this.object.taisyo_code_meisyo[row]=''
				
		l_mei	= data 
	
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 163
		and meisyo_code	= :l_mei
		using cocos;
		
			choose case cocos.sqlcode
				case 0
					this.object.tuuti_syubetu[row]		= integer( l_meisyo_code )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "tuuti_syubetu_mei.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
				end choose
				
	case "taisyo_kbn_mei"
		

		
		if this.object.taisyo_kbn[row]=4 or	this.object.taisyo_kbn[row]=5  then
			this.object.taisyo_code[row]=''
			this.object.taisyo_code_meisyo[row]=''
		else
			this.object.taisyo_code[row]='0'
			this.object.taisyo_code_meisyo[row]=''
		end if
		

		l_mei	= data 
	
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 165
		and meisyo_code	= :l_mei
		using cocos;
		
			choose case cocos.sqlcode
				case 0
					this.object.taisyo_kbn[row]		= integer( l_meisyo_code )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "taisyo_kbn_mei.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
				end choose
				
	case "tuuti_lvl_mei"
		l_mei	= data 
	
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 3
		and meisyo_code	= :l_mei
		using cocos;
		
			choose case cocos.sqlcode
				case 0
					this.object.tuuti_lvl[row]		= integer( l_meisyo_code )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "tuuti_lvl_mei.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
				end choose
				
	case "taisyo_code"
		

		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if this.object.taisyo_kbn[row]=4 or	this.object.taisyo_kbn[row]=5  then
			if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if
		else
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if
		end if

		// 存在チェック
		
		if(this.object.taisyo_kbn[row] >=1 and this.object.taisyo_kbn[row] <=3) then
			this.object.taisyo_code[row] = '0' //主キーなのでnull値はNG？
		elseif this.object.taisyo_kbn[row]=4 then
			
		
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_mei 
		from m_meisyo
		where meisyo_kbn	= 24
		and meisyo_code	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.taisyo_code_meisyo[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
	elseif 	this.object.taisyo_kbn[row]=5 then
				
		select user_mei
		into :l_mei 
		from m_user
		where user_id	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.taisyo_code_meisyo[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
	end if
	
	if 	data="" then 
		data="0"	
	end if
					// 重複チェック
				if not of_dwchk_duplicate( dwo, this.object.tuuti_syubetu[row],	this.object.taisyo_kbn[row],data ) then
					return 1
				end if
	
	case else

end choose

return 0
end event

event clicked;call super::clicked;
// F8:参照
choose case dwo.name
	case "b_taisyo"
		
		//if this.object.taisyo_kbn=4
		
		// 参照起動
		of_reference( this, dwo, row )


end choose
end event

