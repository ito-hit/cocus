$PBExportHeader$w_master_meisyo.srw
$PBExportComments$名称マスタメンテナンス
forward
global type w_master_meisyo from iw_main_window
end type
type st_meisyo_kbn from ivo_statictext within w_master_meisyo
end type
type st_syori_kbn from ivo_statictext within w_master_meisyo
end type
type sle_meisyo_kbn from ivo_singlelineedit within w_master_meisyo
end type
type ddplb_syori_kbn from sv_ddplb_syori within w_master_meisyo
end type
type cb_meisyo_kbn from sv_cb_modal within w_master_meisyo
end type
type st_meisyo_mei from sv_st_meisyo within w_master_meisyo
end type
type st_3 from ivo_statictext within w_master_meisyo
end type
type dw_entry_parent from ivo_datawindow within w_master_meisyo
end type
type dw_list from ivo_datawindow within w_master_meisyo
end type
type dw_entry from ivo_datawindow within w_master_meisyo
end type
type lstr_m_meisyo from structure within w_master_meisyo
end type
end forward

type lstr_m_meisyo from structure
	integer		meisyo_kbn
	string		meisyo_mei
	string		meisyo_code
	string		meisyo_1
	string		meisyo_2
	string		meisyo_3
	string		setumei
	integer		code_ketasu
	integer		code_zokusei_flg
	integer		kousin_kengen
	string		rowid
end type

global type w_master_meisyo from iw_main_window
string title = "名称登録"
boolean f12_key = true
st_meisyo_kbn st_meisyo_kbn
st_syori_kbn st_syori_kbn
sle_meisyo_kbn sle_meisyo_kbn
ddplb_syori_kbn ddplb_syori_kbn
cb_meisyo_kbn cb_meisyo_kbn
st_meisyo_mei st_meisyo_mei
st_3 st_3
dw_entry_parent dw_entry_parent
dw_list dw_list
dw_entry dw_entry
end type
global w_master_meisyo w_master_meisyo

type variables
private:
	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	integer	i_permission	
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	integer	i_meisyo_kbn
	string	i_meisyo_mei
	
	// ロック状態
	// boolean	i_lck_parent, i_lck_meisyo

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
public function boolean of_db_delete (lstr_m_meisyo p_rec)
public function boolean of_db_insert (lstr_m_meisyo p_rec)
public function boolean of_db_update (lstr_m_meisyo p_rec)
public subroutine of_dsp_reset ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock (long p_meisyo_kbn, string p_meisyo_code)
public subroutine of_dsp_back ()
public function boolean of_dwchk_child (dwobject p_dwo, integer p_meisyo_kbn)
public function boolean of_dwchk_digit (dwobject p_dwo, integer p_meisyo_kbn, integer p_inp_digit)
public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_meisyo_kbn, string p_meisyo_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_meisyo_kbn, string p_meisyo_code)
public function boolean of_dwchk_digit_ora (dwobject p_dwo, string p_column_name, integer p_inp_digit)
public function boolean of_dwchk_numeric (dwobject p_dwo, integer p_meisyo_kbn, string p_value)
end prototypes

public function boolean of_db_delete (lstr_m_meisyo p_rec);
delete from m_meisyo
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "名称マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true
end function

public function boolean of_db_insert (lstr_m_meisyo p_rec);
insert into m_meisyo(
	meisyo_kbn,meisyo_mei,
	meisyo_code,meisyo_1,meisyo_2,meisyo_3,
	setumei,
	code_ketasu,code_zokusei_flg,
	kousin_kengen,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.meisyo_kbn,:p_rec.meisyo_mei,
	:p_rec.meisyo_code,:p_rec.meisyo_1,:p_rec.meisyo_2,:p_rec.meisyo_3,
	:p_rec.setumei,
	:p_rec.code_ketasu,:p_rec.code_zokusei_flg,
	:p_rec.kousin_kengen,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "名称マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true

end function

public function boolean of_db_update (lstr_m_meisyo p_rec);
if p_rec.meisyo_kbn = 0 then
	// 先に元の名称区分を取得（子の更新を行う必要があるため）
	integer	l_meisyo_kbn

	select to_number( meisyo_code )
	  into :l_meisyo_kbn
	  from m_meisyo
	 where rowid	= :p_rec.rowid
	using cocos;

	choose case cocos.sqlcode
		case 0
			update m_meisyo
//			   set meisyo_kbn		= :p_rec.meisyo_kbn,
			   set meisyo_mei		= :p_rec.meisyo_mei,
			       meisyo_code		= :p_rec.meisyo_code,
			       setumei			= :p_rec.setumei,
			       code_ketasu		= :p_rec.code_ketasu,
			       code_zokusei_flg	= :p_rec.code_zokusei_flg,
			       kousin_kengen	= :p_rec.kousin_kengen,
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
				msg.of_error( fnc.strg.of_format( "名称マスタの更新処理(親)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
				of_add_db_log( "of_db_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
				return false
			end if

			// 親の更新が問題なければ続いて子の更新を行う
			update m_meisyo
//			   set meisyo_kbn		= to_number( :p_rec.meisyo_code ),
			   set meisyo_mei		= :p_rec.meisyo_mei,
			       kousin_kengen	= :p_rec.kousin_kengen,
			       henkou_date		= sysdate,
			       henkou_user_id	= :user.user_id,
			       henkou_client_id	= :device.name,
			       henkou_pg_id		= :i_pg_id,
			       kousin_date		= sysdate,
			       kousin_user_id	= :user.user_id,
			       kousin_client_id	= :device.name,
			       kousin_pg_id		= :i_pg_id
			 where meisyo_kbn		= :l_meisyo_kbn
			using cocos;
				
			if cocos.sqlcode <> 0 then
				rollback using cocos;
				msg.of_error( fnc.strg.of_format( "名称マスタの更新処理(子)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
				of_add_db_log( "of_db_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
				return false
			end if				
		case 100
			rollback using cocos;
			msg.of_error( "更新対象となるデータが見つからないため更新処理を中断します。" )
			return false
		case else
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "名称マスタの更新処理(親)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "of_db_update-3", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return false
	end choose
else
	update m_meisyo
	   set meisyo_code		= :p_rec.meisyo_code,
	       meisyo_1			= :p_rec.meisyo_1,
	       meisyo_2			= :p_rec.meisyo_2,
	       meisyo_3			= :p_rec.meisyo_3,
	       setumei			= :p_rec.setumei,
	       henkou_date		= sysdate,
	       henkou_user_id	= :user.user_id,
	       henkou_client_id	= :device.name,
	       henkou_pg_id		= :i_pg_id,
	       kousin_kengen	= :p_rec.kousin_kengen,
	       kousin_date		= sysdate,
	       kousin_user_id	= :user.user_id,
	       kousin_client_id	= :device.name,
	       kousin_pg_id		= :i_pg_id
	 where rowid			= :p_rec.rowid
	using cocos;
end if

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "名称マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

return true


end function

public subroutine of_dsp_reset ();string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry_parent.event constructor( )
dw_entry.event constructor( )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
sle_meisyo_kbn.event constructor( )
cb_meisyo_kbn.event constructor( )
st_meisyo_mei.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		sle_meisyo_kbn.enabled	= p_enabled
		cb_meisyo_kbn.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
	case "dw_entry_parent"
		l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

		if l_row > 0 then
			// dw_entry_parent.object.disabled[l_row]	= 0
			dw_entry_parent.object.syori_kbn[l_row]		= i_syori_kbn
			dw_entry_parent.setrow( l_row )
			dw_entry_parent.setcolumn( "meisyo_code" )
			dw_entry_parent.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
	case "dw_entry"
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			// dw_entry.object.disabled[l_row]	= 0
			dw_entry.object.syori_kbn[l_row]	= i_syori_kbn
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "meisyo_code" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
end choose

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_meisyo
   set haita_flg			= :l_haita_flg,
       henkou_date			= sysdate,
       henkou_user_id		= :user.user_id,
       henkou_client_id		= :device.name,
       henkou_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "名称マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_record_lock (long p_meisyo_kbn, string p_meisyo_code);string	l_rowid
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
  from m_meisyo mm,
       m_user mu,
       m_window mw
 where mm.henkou_user_id	= mu.user_id(+)
   and mm.henkou_pg_id		= mw.window_id(+)
   and mm.meisyo_kbn		= :p_meisyo_kbn
   and mm.meisyo_code		= :p_meisyo_code
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
		return of_record_lock_rowid( l_rowid, true )
	case 100
		rollback using cocos;
		msg.of_error( "対象レコードが存在しません。" )
	case else
		rollback using cocos;
		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
end choose

return false

end function

public subroutine of_dsp_back ();
boolean	l_doubleclicked

// Wクリック状態を取得
l_doubleclicked	= i_doubleclicked

// シグナルが有効であればDBアンロックの必要あり
choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor( )
		dw_entry_parent.event constructor( )
	case "変更", "削除", "照会"
		if i_meisyo_kbn <> 0 then
			dw_entry.event constructor( )
		else
			dw_entry_parent.event constructor( )
		end if
end choose


// Wクリック状態でフォーカス移動
if l_doubleclicked then
	dw_entry_parent.setfocus()	// フォーカスバグのおまじない
	dw_list.setfocus()
else
	of_dsp_edit( "callsection", true )
	dw_list.event constructor( )
	of_set_secondfocus( )
end if


end subroutine

public function boolean of_dwchk_child (dwobject p_dwo, integer p_meisyo_kbn);
long	l_cnt

select count(*)
  into :l_cnt
  from m_meisyo
 where meisyo_kbn	= :p_meisyo_kbn
using cocos;
	
if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "子名称登録チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	return false
else
	if l_cnt > 0 then
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "削除しようとしている名称区分で登録された名称コードが存在するため削除できません。{1}【子の件数】{2}件", code.crlf, string( l_cnt ) ) )
		return false
	end if
end if

return true

end function

public function boolean of_dwchk_digit (dwobject p_dwo, integer p_meisyo_kbn, integer p_inp_digit);
long	l_row
integer	l_digit

if i_meisyo_kbn	= 0 then
	select code_ketasu
	  into :l_digit
	  from m_meisyo
	 where meisyo_kbn	= 0
	   and to_number( meisyo_code )	= :p_meisyo_kbn
	using cocos;
	
	choose case cocos.sqlcode
		case 0
		case 100
			msg.of_error( "対象レコードが見つかりません。" )
			return false
		case else
			msg.of_error( fnc.strg.of_format( "桁数チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			return false
	end choose
else
	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

	l_digit	= dw_entry_parent.object.code_ketasu[l_row]
end if

if l_digit < p_inp_digit then
	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "入力可能な桁数を超えています。（入力桁数：{1}／最大桁数：{2}）", string( p_inp_digit ), string( l_digit ) ) )
	return false
end if

return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_meisyo_kbn, string p_meisyo_code, string p_rowid);
string	l_db_meisyo_mei

select decode( meisyo_kbn, 0, meisyo_mei, meisyo_1 )
  into :l_db_meisyo_mei
  from m_meisyo
 where meisyo_kbn			= :p_meisyo_kbn
   and meisyo_code			= :p_meisyo_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている名称はすでに登録があります。{1}【登録済の名称】{2}：{3} {4}", code.crlf, string( p_meisyo_kbn ), p_meisyo_code, l_db_meisyo_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_meisyo_kbn, string p_meisyo_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_meisyo_kbn, p_meisyo_code, l_rowid )
end function

public function boolean of_dwchk_digit_ora (dwobject p_dwo, string p_column_name, integer p_inp_digit);
constant string	c_table_name	= "m_meisyo"

string	l_col_type
integer	l_col_length

// 登録可能桁数取得
if not fnc.db.of_get_column_info( c_table_name, p_column_name, l_col_type, l_col_length ) then
	msg.of_error_dwo( p_dwo, "登録可能な桁数の取得に失敗しました。" )
	return false
end if
		
// 桁数チェック
if l_col_length < p_inp_digit then
	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "入力可能な桁数を超えています。（入力桁数：{1}／最大桁数：{2}）", string( p_inp_digit ), string( l_col_length ) ) )

	return false
end if

return true
end function

public function boolean of_dwchk_numeric (dwobject p_dwo, integer p_meisyo_kbn, string p_value);
long	l_row
integer	l_flg

if i_meisyo_kbn	= 0 then
	select code_zokusei_flg
	  into :l_flg
	  from m_meisyo
	 where meisyo_kbn	= 0
	   and to_number( meisyo_code )	= :p_meisyo_kbn
	using cocos;
	
	choose case cocos.sqlcode
		case 0
		case 100
			msg.of_error( "対象レコードが見つかりません。" )
			return false
		case else
			msg.of_error( fnc.strg.of_format( "属性チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			return false
	end choose
else
	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

	l_flg	= dw_entry_parent.object.code_zokusei_flg[l_row]
end if

if l_flg <> 0 then
	return true
else
	if isnumber( p_value ) then
		return true
	else
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", p_value ) )
		return false
	end if
end if

end function

on w_master_meisyo.create
int iCurrent
call super::create
this.st_meisyo_kbn=create st_meisyo_kbn
this.st_syori_kbn=create st_syori_kbn
this.sle_meisyo_kbn=create sle_meisyo_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.cb_meisyo_kbn=create cb_meisyo_kbn
this.st_meisyo_mei=create st_meisyo_mei
this.st_3=create st_3
this.dw_entry_parent=create dw_entry_parent
this.dw_list=create dw_list
this.dw_entry=create dw_entry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_meisyo_kbn
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.sle_meisyo_kbn
this.Control[iCurrent+4]=this.ddplb_syori_kbn
this.Control[iCurrent+5]=this.cb_meisyo_kbn
this.Control[iCurrent+6]=this.st_meisyo_mei
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.dw_entry_parent
this.Control[iCurrent+9]=this.dw_list
this.Control[iCurrent+10]=this.dw_entry
end on

on w_master_meisyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_meisyo_kbn)
destroy(this.st_syori_kbn)
destroy(this.sle_meisyo_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.cb_meisyo_kbn)
destroy(this.st_meisyo_mei)
destroy(this.st_3)
destroy(this.dw_entry_parent)
destroy(this.dw_list)
destroy(this.dw_entry)
end on

event resize;call super::resize;// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256

dw_entry_parent.y		= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry_parent.x		= code.MGN_YOKO
dw_entry_parent.width	= newwidth - code.MGN_YOKO * 2

dw_entry.y				= dw_entry_parent.y + dw_entry_parent.height + code.MGN_TATE
dw_entry.x				= dw_entry_parent.x
dw_entry.width			= dw_entry_parent.width

dw_list.y				= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )


end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not sle_meisyo_kbn.event input_check( ) then
	return -1
end if

// 変更可能かどうか権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出して強制的に照会モードにする）
if i_permission <> 0 then
	if not i_admin then
		msg.of_warning( "入力された名称区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
		ddplb_syori_kbn.text	= "照会"
	end if
end if


end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_meisyo_kbn	= long( sle_meisyo_kbn.text )
i_meisyo_mei	= st_meisyo_mei.text

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_meisyo_kbn ) = 0 then
	if i_syori_kbn <> "登録" then
		msg.of_error( "入力したた名称区分で登録されたデータはありません。" )
		sle_meisyo_kbn.setfocus()
		return -1
	end if
end if

setredraw( false )

// 更新部初期化
dw_entry_parent.event constructor( )
dw_entry.event constructor( )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

// 親コード以外は親更新部表示
if i_meisyo_kbn <> 0 then
	dw_entry_parent.retrieve( 0, string( i_meisyo_kbn ) )
end if

// 編集モードあれこれ
// 一旦フォーカスを明細部へ
dw_list.setfocus()

choose case i_syori_kbn
	case "登録"
		if i_meisyo_kbn <> 0 then
			of_dsp_edit( "dw_entry", true )
			// フォーカスは親更新部へ
			dw_entry.setfocus()
		else
			of_dsp_edit( "dw_entry_parent", true )
			// フォーカスは更新部へ
			dw_entry_parent.setfocus()
		end if
	case "変更", "削除", "照会"
end choose

setredraw( true )


end event

event update_event;call super::update_event;lstr_m_meisyo	l_rec
integer			l_row

// 必要/不要に関係なく共通化できるレコードセット
// 名称区分が0の場合は親レコードの登録
if i_meisyo_kbn = 0 then
	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

	l_rec.meisyo_kbn		= i_meisyo_kbn
	l_rec.meisyo_mei		= dw_entry_parent.object.meisyo_mei[l_row]
	l_rec.meisyo_code		= dw_entry_parent.object.meisyo_code[l_row]
	l_rec.setumei			= dw_entry_parent.object.setumei[l_row]
	l_rec.code_ketasu		= dw_entry_parent.object.code_ketasu[l_row]
	l_rec.code_zokusei_flg	= dw_entry_parent.object.code_zokusei_flg[l_row]
	l_rec.kousin_kengen		= dw_entry_parent.object.kousin_kengen[l_row]
	l_rec.rowid				= dw_entry_parent.object.rowid[l_row]
else
	select meisyo_mei,setumei,
	       code_ketasu,code_zokusei_flg,
	       kousin_kengen
	  into :l_rec.meisyo_mei,:l_rec.setumei,
	       :l_rec.code_ketasu,:l_rec.code_zokusei_flg,
	       :l_rec.kousin_kengen
	  from m_meisyo
	 where meisyo_kbn	= 0
	   and meisyo_code	= to_char( :i_meisyo_kbn )
	using cocos;

	l_row	= long( dw_entry.object.datawindow.firstrowonpage )

	l_rec.meisyo_kbn	= i_meisyo_kbn
	l_rec.meisyo_code	= dw_entry.object.meisyo_code[l_row]
	l_rec.meisyo_1		= dw_entry.object.meisyo_1[l_row]
	l_rec.meisyo_2		= dw_entry.object.meisyo_2[l_row]
	l_rec.meisyo_3		= dw_entry.object.meisyo_3[l_row]
	l_rec.rowid			= dw_entry.object.rowid[l_row]
end if

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

event key_f12;call super::key_f12;if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if i_meisyo_kbn <> 0 then
	if dw_entry.accepttext() <> 1 then
		return -1
	end if

	l_row	= long( dw_entry.object.datawindow.firstrowonpage )

	if dw_entry.event itemchanged( l_row, dw_entry.object.meisyo_code, dw_entry.object.meisyo_code[l_row] ) <> 0 then
		return -1
	end if

	if dw_entry.event itemchanged( l_row, dw_entry.object.meisyo_1, dw_entry.object.meisyo_1[l_row] ) <> 0 then
		return -1
	end if

	if dw_entry.event itemchanged( l_row, dw_entry.object.meisyo_2, dw_entry.object.meisyo_2[l_row] ) <> 0 then
		return -1
	end if

	if dw_entry.event itemchanged( l_row, dw_entry.object.meisyo_3, dw_entry.object.meisyo_3[l_row] ) <> 0 then
		return -1
	end if
else
	if dw_entry_parent.accepttext() <> 1 then
		return -1
	end if

	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )
	
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.meisyo_code, dw_entry_parent.object.meisyo_code[l_row] ) <> 0 then
		return -1
	end if
	
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.meisyo_mei, dw_entry_parent.object.meisyo_mei[l_row] ) <> 0 then
		return -1
	end if
	
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.setumei, dw_entry_parent.object.setumei[l_row] ) <> 0 then
		return -1
	end if
	
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.code_ketasu, dw_entry_parent.object.code_ketasu[l_row] ) <> 0 then
		return -1
	end if
end if

// 処理区分に基づきメッセージを変更する
i_upd_head_msg	= i_syori_kbn

end event

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0
end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	if i_meisyo_kbn <> 0 then
		dw_entry.event constructor( )
	else
		dw_entry_parent.event constructor( )
	end if
end if

end event

type uo_signal from iw_main_window`uo_signal within w_master_meisyo
end type

type st_date from iw_main_window`st_date within w_master_meisyo
end type

type st_user_mei from iw_main_window`st_user_mei within w_master_meisyo
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_master_meisyo
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_master_meisyo
end type

type st_title from iw_main_window`st_title within w_master_meisyo
end type

type st_title_upper from iw_main_window`st_title_upper within w_master_meisyo
end type

type st_upper from iw_main_window`st_upper within w_master_meisyo
end type

type st_second_upper from iw_main_window`st_second_upper within w_master_meisyo
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_master_meisyo
integer taborder = 30
boolean f9_key = true
boolean f10_key = true
end type

event cb_retrieve::constructor;call super::constructor;this.enabled	= true
end event

type st_meisyo_kbn from ivo_statictext within w_master_meisyo
integer x = 36
integer y = 260
boolean bringtotop = true
long backcolor = 12632256
string text = "名称区分"
alignment alignment = right!
end type

type st_syori_kbn from ivo_statictext within w_master_meisyo
integer x = 36
integer y = 160
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type sle_meisyo_kbn from ivo_singlelineedit within w_master_meisyo
string tag = "名称区分"
integer x = 352
integer y = 256
integer width = 180
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
string text = ""
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean chk_required = true
boolean chk_type_num = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""

setnull( i_meisyo_kbn )
setnull( i_meisyo_mei )

end event

event input_check;call super::input_check;string	l_code
string	l_meisyo_kbn,l_meisyo_mei
integer	l_kengen

l_code	= trim( sle_meisyo_kbn.text )

// 存在チェック
select meisyo_code,meisyo_mei,
       kousin_kengen
  into :l_meisyo_kbn,:l_meisyo_mei,
       :l_kengen
  from m_meisyo
 where meisyo_kbn	= 0
   and meisyo_code	= :l_code
using cocos;
	
choose case cocos.sqlcode
	case 0
		st_meisyo_mei.text	= trim( l_meisyo_mei )
		i_permission		= l_kengen
	case 100
		of_msg_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", this.tag ) )
		this.setfocus()
		return false
	case else
		of_msg_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		this.setfocus()
		return false
end choose

return true

end event

event key_f08;call super::key_f08;str_mdlpara_meisyo_parent l_meisyo

l_meisyo	= mdl.of_open_modal( "w_modal_meisyo_parent", l_meisyo )

if l_meisyo.ret then
	sle_meisyo_kbn.text	= l_meisyo.out_meisyo_code
	st_meisyo_mei.text	= l_meisyo.out_meisyo_1
end if

return 0
end event

event key_f09;call super::key_f09;messagebox( this.classname(), "F9" )

return 0
end event

type ddplb_syori_kbn from sv_ddplb_syori within w_master_meisyo
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )
end event

type cb_meisyo_kbn from sv_cb_modal within w_master_meisyo
integer x = 540
integer y = 256
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;this.enabled	= true
end event

event execution;call super::execution;sle_meisyo_kbn.event key_f08( keyf8!, 0 )
end event

type st_meisyo_mei from sv_st_meisyo within w_master_meisyo
integer x = 660
integer y = 263
integer width = 1512
boolean bringtotop = true
string text = ""
end type

event constructor;call super::constructor;this.text	= ""
end event

type st_3 from ivo_statictext within w_master_meisyo
integer x = 2188
integer y = 263
integer width = 1056
boolean bringtotop = true
long textcolor = 255
long backcolor = 12632256
string text = "※新区分登録時は名称区分＝0を入力"
end type

type dw_entry_parent from ivo_datawindow within w_master_meisyo
integer y = 384
integer width = 5120
integer height = 331
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_master_meisyo_entry_parent"
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
	
	if i_meisyo_kbn = 0 then
		choose case i_syori_kbn
			case "変更", "削除"
				// ロック解除
				if len( trim( l_rowid ) ) > 0 then
					of_record_lock_rowid( l_rowid, false )
				end if
		end choose
		
		i_doubleclicked	= false
	end if
end if

this.settransobject(cocos)

this.reset()
this.insertrow(0)

end event

event itemchanged;call super::itemchanged;
integer	l_digit
boolean	l_flg
string	l_col_type
integer	l_col_length

choose case dwo.name
	case "meisyo_code"
		// 属性チェック
		if not of_dwchk_numeric( dwo, i_meisyo_kbn, data ) then
			return 1
		end if

		// 桁数チェック
		if not of_dwchk_digit( dwo, 0, len( data ) ) then
			return 1
		end if

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, i_meisyo_kbn, data ) then
					return 1
				end if
			case "変更"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, i_meisyo_kbn, data, this.object.rowid[row] ) then
					return 1
				end if
			case "削除"
				// 子名称登録チェック
				if not of_dwchk_child( dwo, long( data ) ) then
					return 1
				end if
		end choose
	case "meisyo_mei", "setumei"
		if not of_dwchk_digit_ora( dwo, dwo.name, lena( data ) ) then
			return 1
		end if
	case "code_ketasu"
		// 数値チェック
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "数字しか入力できません（入力値：{1}", data ) )
			return 1
		end if

		if not of_dwchk_digit_ora( dwo, "meisyo_code", long( data ) ) then
			return 1
		end if
	case else
end choose

return 0
end event

event getfocus;call super::getfocus;long	l_row

l_row	= long( this.object.datawindow.firstrowonpage )

if i_meisyo_kbn = 0 then
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
end if

end event

type dw_list from ivo_datawindow within w_master_meisyo
integer y = 1511
integer width = 5120
integer height = 1056
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_master_meisyo_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f9_key = true
boolean f10_key = true
boolean row_multi_select = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)

end event

event retrievestart;call super::retrievestart;of_loading( true )
end event

event retrieveend;call super::retrieveend;of_loading( false )
end event

event retrieverow;call super::retrieverow;yield()
end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "名称マスタ{1}", string( today(), "yyyymmdd" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event doubleclicked;call super::doubleclicked;long	l_upd_row
string	l_code
long	l_row

setredraw( false )

if row > 0 then
	// 名称コードを取得
	l_code	= this.object.meisyo_code[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			if i_meisyo_kbn = 0 then
				l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

				dw_entry_parent.object.meisyo_kbn_char[l_row]	= string( i_meisyo_kbn )
				dw_entry_parent.object.meisyo_kbn[l_row]		= i_meisyo_kbn
				dw_entry_parent.object.meisyo_mei[l_row]		= i_meisyo_mei
				dw_entry_parent.object.meisyo_code[l_row]		= this.object.meisyo_code[row]
				dw_entry_parent.object.meisyo_1[l_row]			= this.object.meisyo_1[row]
				dw_entry_parent.object.meisyo_2[l_row]			= this.object.meisyo_2[row]
				dw_entry_parent.object.meisyo_3[l_row]			= this.object.meisyo_3[row]
				dw_entry_parent.object.setumei[l_row]			= this.object.setumei[row]
				dw_entry_parent.object.code_ketasu[l_row]		= this.object.code_ketasu[row]
				dw_entry_parent.object.code_zokusei_flg[l_row]	= this.object.code_zokusei_flg[row]
				dw_entry_parent.object.kousin_kengen[l_row]		= this.object.kousin_kengen[row]
			else
				l_row	= long( dw_entry.object.datawindow.firstrowonpage )
				
				dw_entry.object.meisyo_code[l_row]				= this.object.meisyo_code[row]
				dw_entry.object.meisyo_1[l_row]					= this.object.meisyo_1[row]
				dw_entry.object.meisyo_2[l_row]					= this.object.meisyo_2[row]
				dw_entry.object.meisyo_3[l_row]					= this.object.meisyo_3[row]
				dw_entry.object.setumei[l_row]					= this.object.setumei[row]
				dw_entry.object.code_ketasu[l_row]				= this.object.code_ketasu[row]
				dw_entry.object.code_zokusei_flg[l_row]			= this.object.code_zokusei_flg[row]
				dw_entry.object.kousin_kengen[l_row]			= this.object.kousin_kengen[row]
			end if
		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					if i_meisyo_kbn <> 0 then
						dw_entry.event constructor( )
					else
						dw_entry_parent.event constructor( )
					end if
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_meisyo_kbn, l_code ) then
					return -1
				end if
			end if

			if i_meisyo_kbn = 0 then
				// 0は名称区分なので親DWに
				if dw_entry_parent.retrieve( i_meisyo_kbn, l_code ) > 0 then
					l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

					if i_syori_kbn = "変更" then
						of_dsp_edit( "dw_entry_parent", true )
					end if
				else
					msg.of_error( "選択されたレコードが見つかりません。" )
					this.setfocus()
					return -1
				end if
			else
				// 0以外は子DWに
				if dw_entry.retrieve( i_meisyo_kbn, l_code ) > 0 then
					l_row	= long( dw_entry.object.datawindow.firstrowonpage )

					if i_syori_kbn = "変更" then
						of_dsp_edit( "dw_entry", true )
					end if
				else
					msg.of_error( "選択されたレコードが見つかりません。" )
					this.setfocus()
					return -1
				end if
			end if
			
			i_doubleclicked	= true

			if i_syori_kbn = "削除" then
				this.event getfocus( )
			end if
	end choose
end if

setredraw( true )


end event

event clicked;call super::clicked;string	l_columnname

choose case dwo.name
	case "meisyo_kbn_t", "meisyo_mei_t", "meisyo_code_t", "meisyo_1_t", "meisyo_2_t", "meisyo_3_t", "setsumei_t", "kousin_kengen_mei_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
end choose		

// テスト
//if row > 0 then
//	messagebox( "", string( this.object.名称区分テスト[row] ) )
//end if
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
		if i_doubleclicked then
			this.of_set_fnkey( keyf12!, true )
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

type dw_entry from ivo_datawindow within w_master_meisyo
integer y = 793
integer width = 5120
integer height = 416
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_master_meisyo_entry"
boolean border = false
borderstyle borderstyle = stylebox!
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
	
	if i_meisyo_kbn <> 0 then
		choose case i_syori_kbn
			case "変更", "削除"
				// ロック解除
				if len( trim( l_rowid ) ) > 0 then
					of_record_lock_rowid( l_rowid, false )
				end if
		end choose
		
		i_doubleclicked	= false
	end if
end if

this.settransobject(cocos)

this.reset()
this.insertrow(0)

end event

event itemchanged;call super::itemchanged;
choose case dwo.name
	case "meisyo_code"
		// 属性チェック
		if not of_dwchk_numeric( dwo, i_meisyo_kbn, data ) then
			return 1
		end if

		// 桁数チェック
		if not of_dwchk_digit( dwo, i_meisyo_kbn, len( data ) ) then
			return 1
		end if

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, i_meisyo_kbn, data ) then
					return 1
				end if
			case "変更"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, i_meisyo_kbn, data, this.object.rowid[row] ) then
					return 1
				end if
		end choose
	case "meisyo_1","meisyo_2","meisyo_3"
		if not of_dwchk_digit_ora( dwo, dwo.name, lena( data ) ) then
			return 1
		end if
	case else
end choose

return 0
end event

event getfocus;call super::getfocus;long	l_row

l_row	= long( this.object.datawindow.firstrowonpage )

if i_meisyo_kbn <> 0 then
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
end if


end event

