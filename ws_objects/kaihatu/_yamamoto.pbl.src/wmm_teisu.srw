$PBExportHeader$wmm_teisu.srw
$PBExportComments$定数登録
forward
global type wmm_teisu from iw_main_window
end type
type st_syori_kubun from ivo_statictext within wmm_teisu
end type
type st_teisu from ivo_statictext within wmm_teisu
end type
type sle_teisu from ivo_singlelineedit within wmm_teisu
end type
type st_bikou from ivo_statictext within wmm_teisu
end type
type cb_modal from sv_cb_modal within wmm_teisu
end type
type st_teisu_mei from sv_st_meisyo within wmm_teisu
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_teisu
end type
type dw_entry_parent from ivo_datawindow within wmm_teisu
end type
type dw_entry from ivo_datawindow within wmm_teisu
end type
type dw_list from ivo_datawindow within wmm_teisu
end type
type lstr_m_teisu from structure within wmm_teisu
end type
end forward

type lstr_m_teisu from structure
	long		teisu_kbn
	string		teisu_mei
	string		teisu_code
	long		teisu_1
	long		teisu_2
	long		teisu_3
	string		setumei
	long		code_ketasu
	integer		code_zokusei_flg
	long		kousin_kengen
	string		rowid
end type

global type wmm_teisu from iw_main_window
string title = "定数登録"
boolean f12_key = true
st_syori_kubun st_syori_kubun
st_teisu st_teisu
sle_teisu sle_teisu
st_bikou st_bikou
cb_modal cb_modal
st_teisu_mei st_teisu_mei
ddplb_syori_kbn ddplb_syori_kbn
dw_entry_parent dw_entry_parent
dw_entry dw_entry
dw_list dw_list
end type
global wmm_teisu wmm_teisu

type variables
private:
	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	integer	i_permission
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	integer	i_teisu_kbn
	string	i_teisu_mei

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
public subroutine of_back ()
public subroutine of_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock (long p_teisu_kbn, string p_teisu_code)
public function boolean of_check_duplicate (dwobject p_dwo, long p_teisu_kbn, string p_teisu_code, string p_rowid)
public function boolean of_check_digit (dwobject p_dwo, long p_teisu_kbn, long p_digit)
public function boolean of_check_digit_ora (dwobject p_dwo, string p_column, long p_digit)
public function boolean of_check_type (dwobject p_dwo, long p_teisu_kbn, string p_value)
public function boolean of_check_child (dwobject p_dwo, long p_teisu_kbn)
public function boolean of_delete (lstr_m_teisu p_rec)
public function boolean of_insert (lstr_m_teisu p_rec)
public function boolean of_update (lstr_m_teisu p_rec)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);// p_controlによって、ロックやフォーカスを制御する
long	l_row

choose case p_control
	case "callsection"
		// 呼び出し部のロック状態を制御する
		ddplb_syori_kbn.enabled	= p_enabled
		sle_teisu.enabled		= p_enabled
		cb_modal.enabled		= p_enabled
		cb_retrieve.enabled		= p_enabled
		
	case "dw_entry_parent"
		// dw_entry_parentにフォーカスを合わせる 行がないならエラーメッセージ
		l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry_parent.object.syori_kbn[l_row]	= i_syori_kbn

//			if i_syori_kbn <> "登録" then
//				dw_entry_parent.setrow( l_row )
//				dw_entry_parent.setcolumn( "teisu_mei" )
//			else
//				// 登録時は定数コードのロックを解除する
//				dw_entry_parent.object.disabled_code[l_row]	= 0
//				dw_entry_parent.setrow( l_row )
//				dw_entry_parent.setcolumn( "teisu_code" )
//			end if
			
			dw_entry_parent.setrow( l_row )
			dw_entry_parent.setcolumn( "teisu_code" )
			dw_entry_parent.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
		
	case "dw_entry"
		// dw_entryにフォーカスを合わせる 行がないならエラーメッセージ
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.object.syori_kbn[l_row]	= i_syori_kbn
			
//			if i_syori_kbn <> "登録" then
//				dw_entry.setrow( l_row )
//				dw_entry.setcolumn( "teisu_1" )
//			else
//				// 登録時は定数コードのロックを解除する
//				dw_entry.object.disabled_code[l_row]	= 0				
//				dw_entry.setrow( l_row )
//				dw_entry.setcolumn( "teisu_code" )
//			end if
			
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "teisu_code" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
end choose
end subroutine

public subroutine of_back ();// F6：戻りの処理
boolean	l_doubleclicked

// Wクリック状態を取得
l_doubleclicked	= i_doubleclicked

// 処理区分によって戻る場所が変わる = 初期化する場所が変わる
choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor( )
		dw_entry_parent.event constructor( )
	case "変更", "削除", "照会"
		if i_teisu_kbn <> 0 then
			dw_entry.event constructor( )
		else
			dw_entry_parent.event constructor( )
		end if
end choose


// Wクリック状態でフォーカス移動
if l_doubleclicked then
	dw_list.setfocus()
else
	of_dsp_edit( "callsection", true )
	dw_list.event constructor( )
	of_set_secondfocus( )
end if
end subroutine

public subroutine of_reset ();// F9：初期表示
string	l_syori_kbn

l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry_parent.event constructor( )
dw_entry.event constructor( )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
sle_teisu.event constructor( )
cb_modal.event constructor( )
st_teisu_mei.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )
end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);// p_rowidを使って、haita_flgに1を立てる
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_teisu
   set haita_flg			= :l_haita_flg,
       henkou_date			= sysdate,
       henkou_user_id		= :user.user_id,
       henkou_client_id		= :device.name,
       henkou_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "定数マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	// ランプの色を制御する
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_record_lock (long p_teisu_kbn, string p_teisu_code);// p_teisu_kbnとp_teisu_codeでrowidを探して、ロックをかける
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

// p_teisu_kbnとp_teisu_codeからrowidを探す 同時に日付やuser_idもインスタンス変数に格納する
select mt.rowid,mt.haita_flg,
       nvl( to_char( mt.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mt.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mt.henkou_client_id, '???' ),
       nvl( mt.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_teisu mt,
       m_user mu,
       m_window mw
 where mt.henkou_user_id	= mu.user_id(+)
   and mt.henkou_pg_id		= mw.window_id(+)
   and mt.teisu_kbn			= :p_teisu_kbn
   and mt.teisu_code		= :p_teisu_code
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

		// 実際にhaita_flgに1を立てるのはここ
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

public function boolean of_check_duplicate (dwobject p_dwo, long p_teisu_kbn, string p_teisu_code, string p_rowid);// p_rowidが既にm_teisuに存在するかの重複チェックを行う
string	l_teisu_mei

// 引数のレコードを検索する
select decode( teisu_kbn, 0, teisu_mei, teisu_1 )
  into :l_teisu_mei
  from m_teisu
 where teisu_kbn			= :p_teisu_kbn
   and teisu_code			= :p_teisu_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		// 今回はデータが存在したらエラー
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている定数はすでに登録があります。{1}【登録済の名称】{2}：{3} {4}",&
														code.crlf, string( p_teisu_kbn ), p_teisu_code, l_teisu_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_check_digit (dwobject p_dwo, long p_teisu_kbn, long p_digit);// p_teisu_kbnの桁数チェックを行う
long	l_row
integer	l_digit	// 対象定数区分の最大桁数

if i_teisu_kbn	= 0 then
	// p_teisu_kbnの最大桁数を格納する
	select code_ketasu
	  into :l_digit
	  from m_teisu
	 where teisu_kbn	= 0
	   and to_number( teisu_code )	= :p_teisu_kbn
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

// 桁数の比較
if l_digit < p_digit then
	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "入力可能な桁数を超えています。（入力桁数：{1}／最大桁数：{2}）", string( p_digit ), string( l_digit ) ) )
	return false
end if

return true

end function

public function boolean of_check_digit_ora (dwobject p_dwo, string p_column, long p_digit);// Oracleの桁数チェック
constant string	c_table_name	= "m_teisu"

string	l_col_type
integer	l_col_length

// 登録可能桁数取得
//if not fnc.db.of_get_column_info( c_table_name, p_column, l_col_type, l_col_length ) then
//	msg.of_error_dwo( p_dwo, "登録可能な桁数の取得に失敗しました。" )
//	return false
//end if
		
// 桁数チェック
if l_col_length < p_digit then
	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "入力可能な桁数を超えています。（入力桁数：{1}／最大桁数：{2}）", string( p_digit ), string( l_col_length ) ) )

	return false
end if

return true
end function

public function boolean of_check_type (dwobject p_dwo, long p_teisu_kbn, string p_value);// p_teisu_kbnの属性チェック( 0：数値のみ 1：数値以外を含む )を行う
long	l_row
integer	l_flg

if i_teisu_kbn	= 0 then
	// p_teisu_kbnの属性を格納する
	select code_zokusei_flg
	  into :l_flg
	  from m_teisu
	 where teisu_kbn	= 0
	   and to_number( teisu_code )	= :p_teisu_kbn
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

// 属性のチェック
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

public function boolean of_check_child (dwobject p_dwo, long p_teisu_kbn);// 子コード登録時のチェックを行う
long	l_cnt

// p_teisu_kbnで検索したレコード数を格納する
select count(*)
  into :l_cnt
  from m_teisu
 where teisu_kbn	= :p_teisu_kbn
using cocos;
	
if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "子定数登録チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	return false
else
	// ( 親コードを削除するときに )子コードがまだ存在していた時にエラーとする
	if l_cnt > 0 then
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "削除しようとしている定数区分で登録された定数コードが存在するため削除できません。{1}【子の件数】{2}件", code.crlf, string( l_cnt ) ) )
		return false
	end if
end if

return true

end function

public function boolean of_delete (lstr_m_teisu p_rec);// p_recのレコードを削除する commitはupdate_eventで行う

delete from m_teisu
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "定数マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

return true
end function

public function boolean of_insert (lstr_m_teisu p_rec);// p_recのレコードをinsertする commitはupdate_eventで行う

insert into m_teisu(
	teisu_kbn,teisu_mei,
	teisu_code,teisu_1,teisu_2,teisu_3,
	setumei,
	code_ketasu,code_zokusei_flg,
	kousin_kengen,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.teisu_kbn,:p_rec.teisu_mei,
	:p_rec.teisu_code,:p_rec.teisu_1,:p_rec.teisu_2,:p_rec.teisu_3,
	:p_rec.setumei,
	:p_rec.code_ketasu,:p_rec.code_zokusei_flg,
	:p_rec.kousin_kengen,
	:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "定数マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

return true

end function

public function boolean of_update (lstr_m_teisu p_rec);// p_recのレコードをupdateする commitはupdate_eventで行う

if p_rec.teisu_kbn = 0 then
	// p_recの定数コードを取得（子コードの更新を行う必要があるため）
	integer	l_teisu_code

	select to_number( teisu_code )
	  into :l_teisu_code
	  from m_teisu
	 where rowid	= :p_rec.rowid
	using cocos;

	choose case cocos.sqlcode
		case 0
			// rowidを使って親コードの更新を行う
			update m_teisu
			   set teisu_mei		= :p_rec.teisu_mei,
			       teisu_code		= :p_rec.teisu_code,
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
				msg.of_error( fnc.strg.of_format( "定数マスタの更新処理(親)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
				of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
				return false
			end if

			// 親の更新が問題なければ続いて子コードの更新を行う
			update m_teisu
			   set teisu_mei		= :p_rec.teisu_mei,
			       kousin_kengen	= :p_rec.kousin_kengen,
			       henkou_date		= sysdate,
			       henkou_user_id	= :user.user_id,
			       henkou_client_id	= :device.name,
			       henkou_pg_id		= :i_pg_id,
			       kousin_date		= sysdate,
			       kousin_user_id	= :user.user_id,
			       kousin_client_id	= :device.name,
			       kousin_pg_id		= :i_pg_id
			 where teisu_kbn		= :l_teisu_code
			using cocos;
				
			if cocos.sqlcode <> 0 then
				rollback using cocos;
				msg.of_error( fnc.strg.of_format( "定数マスタの更新処理(子)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
				of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
				return false
			end if				
		case 100
			rollback using cocos;
			msg.of_error( "更新対象となるデータが見つからないため更新処理を中断します。" )
			of_add_db_log( "of_update-3", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
			return false
		case else
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "定数マスタの更新処理(親)でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "of_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
			return false
	end choose
else
	// 子コードの更新を行う
	update m_teisu
	   set teisu_code		= :p_rec.teisu_code,
	       teisu_1			= :p_rec.teisu_1,
	       teisu_2			= :p_rec.teisu_2,
	       teisu_3			= :p_rec.teisu_3,
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
	msg.of_error( fnc.strg.of_format( "定数マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-5", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

return true
end function

on wmm_teisu.create
int iCurrent
call super::create
this.st_syori_kubun=create st_syori_kubun
this.st_teisu=create st_teisu
this.sle_teisu=create sle_teisu
this.st_bikou=create st_bikou
this.cb_modal=create cb_modal
this.st_teisu_mei=create st_teisu_mei
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_entry_parent=create dw_entry_parent
this.dw_entry=create dw_entry
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kubun
this.Control[iCurrent+2]=this.st_teisu
this.Control[iCurrent+3]=this.sle_teisu
this.Control[iCurrent+4]=this.st_bikou
this.Control[iCurrent+5]=this.cb_modal
this.Control[iCurrent+6]=this.st_teisu_mei
this.Control[iCurrent+7]=this.ddplb_syori_kbn
this.Control[iCurrent+8]=this.dw_entry_parent
this.Control[iCurrent+9]=this.dw_entry
this.Control[iCurrent+10]=this.dw_list
end on

on wmm_teisu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kubun)
destroy(this.st_teisu)
destroy(this.sle_teisu)
destroy(this.st_bikou)
destroy(this.cb_modal)
destroy(this.st_teisu_mei)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_entry_parent)
destroy(this.dw_entry)
destroy(this.dw_list)
end on

event resize;call super::resize;
dw_entry_parent.y						= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry_parent.x						= code.MGN_YOKO
dw_entry_parent.width					= newwidth - code.MGN_YOKO * 2

dw_entry.y								= dw_entry_parent.y + dw_entry_parent.height + code.MGN_TATE
dw_entry.x								= dw_entry_parent.x
dw_entry.width							= dw_entry_parent.width

dw_list.y								= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x								= code.MGN_YOKO
dw_list.width							= newwidth - code.MGN_YOKO * 2
dw_list.height							= key_fnc.y - code.MGN_TATE * 3 - dw_list.y


// DWの登録日時と変更日時
dw_entry_parent.object.henkou_date.x	= dw_entry_parent.width - long( dw_entry_parent.object.henkou_date.width ) - 32
dw_entry_parent.object.t_henkou_date.x	= long( dw_entry_parent.object.henkou_date.x ) - long( dw_entry_parent.object.t_henkou_date.width ) - 20

dw_entry_parent.object.touroku_date.x	= long( dw_entry_parent.object.t_henkou_date.x ) - long( dw_entry_parent.object.touroku_date.width ) - 40
dw_entry_parent.object.t_touroku_date.x	= long( dw_entry_parent.object.touroku_date.x ) - long( dw_entry_parent.object.t_touroku_date.width ) - 20
end event

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )
end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event key_f12;call super::key_f12;// 更新ボタン

if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0
end event

event retrieve_check;call super::retrieve_check;
// 入力チェック
if not sle_teisu.event input_check( ) then
	return -1
end if

// 変更可能かどうか、権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出して強制的に照会モードにする）
if i_permission <> 0 then
	if not i_admin then
		msg.of_warning( "入力された定数区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
		ddplb_syori_kbn.text	= "照会"
	end if
end if
end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= ddplb_syori_kbn.text
i_teisu_kbn	= long( sle_teisu.text )
i_teisu_mei	= st_teisu_mei.text

if dw_list.retrieve( i_teisu_kbn ) = 0 then
	// 登録以外は0件ならエラーとする
	if i_syori_kbn <> "登録" then
		msg.of_error( "入力した定数区分で登録されたデータはありません。" )
		sle_teisu.setfocus()
		return -1
	end if
end if

setredraw( false )

// 更新部初期化
dw_entry_parent.event constructor( )
dw_entry.event constructor( )

// 照会のとき以外は呼出部をロックする
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

// 子コードは親更新部を表示する
if i_teisu_kbn <> 0 then
	dw_entry_parent.retrieve( 0, string( i_teisu_kbn ) )
end if

dw_list.setfocus()

choose case i_syori_kbn
	case "登録"
		if i_teisu_kbn <> 0 then
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

event key_f06;call super::key_f06;// 戻り

of_back()

return 0
end event

event key_f09;call super::key_f09;// 初期表示

if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_reset()
end if

return 0
end event

event update_check;call super::update_check;long	l_row

// DWの入力規則チェック
if i_teisu_kbn <> 0 then
	// 子コードのDWのaccepttext
	if dw_entry.accepttext() <> 1 then
		return -1
	end if

	l_row	= long( dw_entry.object.datawindow.firstrowonpage )
	
	// teisu_codeのitemchanged
	if dw_entry.event itemchanged( l_row, dw_entry.object.teisu_code, dw_entry.object.teisu_code[l_row] ) <> 0 then
		return -1
	end if
	
	// teisu_1のitemchanged
	if dw_entry.event itemchanged( l_row, dw_entry.object.teisu_1, string( dw_entry.object.teisu_1[l_row] ) ) <> 0 then
		return -1
	end if
	
	// teisu_2のitemchanged
	if dw_entry.event itemchanged( l_row, dw_entry.object.teisu_2, string( dw_entry.object.teisu_2[l_row] ) ) <> 0 then
		return -1
	end if
	
	// teisu_3のitemchanged
	if dw_entry.event itemchanged( l_row, dw_entry.object.teisu_3, string( dw_entry.object.teisu_3[l_row] ) ) <> 0 then
		return -1
	end if
else
	// 親コードのDWのaccepttext
	if dw_entry_parent.accepttext() <> 1 then
		return -1
	end if

	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )
	
	// teisu_codeのitemchanged
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.teisu_code, dw_entry_parent.object.teisu_code[l_row] ) <> 0 then
		return -1
	end if
	
	// teisu_meiのitemchanged
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.teisu_mei, dw_entry_parent.object.teisu_mei[l_row] ) <> 0 then
		return -1
	end if
	
	// setumeiのitemchanged
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.setumei, dw_entry_parent.object.setumei[l_row] ) <> 0 then
		return -1
	end if
	
	// code_ketasu
	if dw_entry_parent.event itemchanged( l_row, dw_entry_parent.object.code_ketasu, string( dw_entry_parent.object.code_ketasu[l_row] ) ) <> 0 then
		return -1
	end if
end if

// 処理区分に基づきメッセージを変更する
upd_head_msg	= i_syori_kbn

end event

event update_event;call super::update_event;lstr_m_teisu	l_rec
integer			l_row

// 必要/不要に関係なく共通化できるレコードセット
// 定数区分が0の場合は親レコードの登録
if i_teisu_kbn = 0 then
	l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

	l_rec.teisu_kbn			= i_teisu_kbn
	l_rec.teisu_mei			= dw_entry_parent.object.teisu_mei[l_row]
	l_rec.teisu_code		= dw_entry_parent.object.teisu_code[l_row]
	l_rec.setumei			= dw_entry_parent.object.setumei[l_row]
	l_rec.code_ketasu		= dw_entry_parent.object.code_ketasu[l_row]
	l_rec.code_zokusei_flg	= dw_entry_parent.object.code_zokusei_flg[l_row]
	l_rec.kousin_kengen		= dw_entry_parent.object.kousin_kengen[l_row]
	l_rec.rowid				= dw_entry_parent.object.rowid[l_row]
else
	select teisu_mei,setumei,
	       code_ketasu,code_zokusei_flg,
	       kousin_kengen
	  into :l_rec.teisu_mei,:l_rec.setumei,
	       :l_rec.code_ketasu,:l_rec.code_zokusei_flg,
	       :l_rec.kousin_kengen
	  from m_teisu
	 where teisu_kbn	= 0
	   and teisu_code	= to_char( :i_teisu_kbn )
	using cocos;

	l_row	= long( dw_entry.object.datawindow.firstrowonpage )

	l_rec.teisu_kbn		= i_teisu_kbn
	l_rec.teisu_code	= dw_entry.object.teisu_code[l_row]
	l_rec.teisu_1		= dw_entry.object.teisu_1[l_row]
	l_rec.teisu_2		= dw_entry.object.teisu_2[l_row]
	l_rec.teisu_3		= dw_entry.object.teisu_3[l_row]
	l_rec.rowid			= dw_entry.object.rowid[l_row]
end if

choose case i_syori_kbn
	case "登録"
		if not of_insert( l_rec ) then
			return -1
		end if
	case "変更"
		if not of_update( l_rec ) then
			return -1
		end if
	case "削除"
		if not of_delete( l_rec ) then
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
// ロック解除
if uo_signal.of_get_status() then
	if i_teisu_kbn <> 0 then
		dw_entry.event constructor( )
	else
		dw_entry_parent.event constructor( )
	end if
end if
end event

type uo_signal from iw_main_window`uo_signal within wmm_teisu
end type

type st_date from iw_main_window`st_date within wmm_teisu
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_teisu
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_teisu
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_teisu
end type

type st_title from iw_main_window`st_title within wmm_teisu
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_teisu
end type

type st_upper from iw_main_window`st_upper within wmm_teisu
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_teisu
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_teisu
integer taborder = 30
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

type st_syori_kubun from ivo_statictext within wmm_teisu
integer x = 76
integer y = 153
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
end type

type st_teisu from ivo_statictext within wmm_teisu
integer x = 76
integer y = 263
boolean bringtotop = true
long backcolor = 12632256
string text = "定数区分"
end type

type sle_teisu from ivo_singlelineedit within wmm_teisu
integer x = 348
integer y = 256
integer width = 180
integer taborder = 20
boolean bringtotop = true
string text = ""
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean chk_required = true
boolean chk_type_num = true
end type

event constructor;call super::constructor;// 初期状態
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.enabled			= true

this.text	= ""

setnull( i_teisu_kbn )

end event

event input_check;call super::input_check;string	l_code
string	l_teisu_kbn,l_teisu_mei
integer	l_kengen

l_code	= trim( this.text )

// 存在チェック
select teisu_code, teisu_mei,
       kousin_kengen
  into :l_teisu_kbn, :l_teisu_mei,
       :l_kengen
  from m_teisu
 where teisu_kbn	= 0
   and teisu_code	= :l_code
using cocos;
	
choose case cocos.sqlcode
	case 0
		st_teisu_mei.text	= trim( l_teisu_mei )
		i_permission		= l_kengen	// 入力されたコードの更新権限を格納する
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

event key_f08;call super::key_f08;
str_mdlpara_mmeisyo	l_mdl_meisyo

// モーダルを開く
l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo_parent", l_mdl_meisyo )

if upperbound( l_mdl_meisyo.ret ) > 0 then
//	i_para_meisyo									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
//	i_para_meisyo[upperbound( i_para_meisyo ) + 1]	= l_mdl_meisyo.ret[upperbound( l_mdl_meisyo.ret )]
//	
//	of_set_input( of_get_meisyo_code() )
//	of_set_meisyo( of_get_meisyo_1() )
//	
//	this.event sle_input_check()
end if

return 0
end event

type st_bikou from ivo_statictext within wmm_teisu
integer x = 2212
integer y = 263
integer width = 964
boolean bringtotop = true
long textcolor = 255
long backcolor = 12632256
string text = "※新区分登録時は定数区分=0を入力"
end type

type cb_modal from sv_cb_modal within wmm_teisu
integer x = 540
integer y = 256
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

event execution;call super::execution;
sle_teisu.event key_f08( keyf8!, 0 )
end event

type st_teisu_mei from sv_st_meisyo within wmm_teisu
integer x = 656
integer y = 263
integer width = 1512
boolean bringtotop = true
string text = ""
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

setnull( i_teisu_mei )
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_teisu
integer x = 348
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;// 初期状態
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )
end event

type dw_entry_parent from ivo_datawindow within wmm_teisu
integer x = 156
integer y = 480
integer width = 4700
integer height = 338
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_teisu_entry_parent"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;long			l_row
string			l_rowid

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	
	if i_teisu_kbn = 0 then
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

event getfocus;call super::getfocus;long	l_row

l_row	= long( this.object.datawindow.firstrowonpage )

if i_teisu_kbn = 0 then
	choose case i_syori_kbn
		case "登録"
			// ロック状態を解除されていたら、F6(戻り)とF12(更新)を有効化する
			if this.object.syori_kbn[l_row] = "登録" then
				this.of_set_fnkey( keyf6!, true )
				this.of_set_fnkey( keyf12!, true )
				return
			end if
		case "変更", "削除"
			// 「変更中」ランプなら、F6(戻り)とF12(更新)を有効化する
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

event itemchanged;call super::itemchanged;integer	l_digit
boolean	l_flg
string	l_col_type
integer	l_col_length

// DW入力時のチェックを行う
choose case dwo.name
	case "teisu_code"
////		// 属性チェック
//		if not of_check_type( dwo, i_teisu_kbn, data ) then
//			return 1
//		end if
//		
		// スペースのチェック
		if not isnumber( trim( data ) ) then
			// 何らかの処理
			return 0
		end if
		
		// 桁数チェック
		if not of_check_digit( dwo, 0, len( data ) ) then
			return 1
		end if

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_check_duplicate( dwo, i_teisu_kbn, data, " " ) then
					return 1
				end if
			case "変更"
				// 重複チェック
				if not of_check_duplicate( dwo, i_teisu_kbn, data, this.object.rowid[row] ) then
					return 1
				end if
			case "削除"
				// 子名称登録チェック
				if not of_check_child( dwo, long( data ) ) then
					return 1
				end if
		end choose
	case "teisu_mei", "setumei"
		if not of_check_digit_ora( dwo, dwo.name, lena( data ) ) then
			return 1
		end if
	case "code_ketasu"
		// 数値チェック
//		if not isnumber( data ) then
//			msg.of_error_dwo( dwo, fnc.strg.of_format( "数字しか入力できません（入力値：{1}", data ) )
//			return 1
//		end if

		// スペースが入ってきた想定 それ以外のチェックはitemerrorの先祖で拾ってる
		// スペースのチェック
		if not isnumber( trim( data ) ) then
			return 0
		end if
		
		// 桁数チェック
		if not of_check_digit_ora( dwo, "teisu_code", long( data ) ) then
			return 1
		end if
		
		// もしくは
		if isnumber( data ) then
			// 桁数チェック
			if not of_check_digit_ora( dwo, "teisu_code", long( data ) ) then
				return 1
			end if
		end if
	case else
end choose

return 0










end event

type dw_entry from ivo_datawindow within wmm_teisu
integer x = 212
integer y = 896
integer width = 3988
integer height = 420
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_teisu_entry"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;long			l_row
string			l_rowid

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	
	if i_teisu_kbn <> 0 then
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

event getfocus;call super::getfocus;long	l_row

l_row	= long( this.object.datawindow.firstrowonpage )

if i_teisu_kbn <> 0 then
	choose case i_syori_kbn
		case "登録"
			// ロック状態を解除されていたら、F6(戻り)とF12(更新)を有効化する
			if this.object.syori_kbn[l_row] = "登録" then
				this.of_set_fnkey( keyf6!, true )
				this.of_set_fnkey( keyf12!, true )
				return
			end if
		case "変更", "削除"
			// 「変更中」ランプなら、F6(戻り)とF12(更新)を有効化する
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

event itemchanged;call super::itemchanged;
// DW入力時のチェックを行う
choose case dwo.name
	case "teisu_code"
		// 属性チェック
		if not of_check_type( dwo, i_teisu_kbn, data ) then
			return 1
		end if

		// 桁数チェック
		if not of_check_digit( dwo, i_teisu_kbn, len( data ) ) then
			return 1
		end if

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_check_duplicate( dwo, i_teisu_kbn, data, " " ) then
					return 1
				end if
			case "変更"
				// 重複チェック
				if not of_check_duplicate( dwo, i_teisu_kbn, data, this.object.rowid[row] ) then
					return 1
				end if
		end choose
	case "teisu_1","teisu_2","teisu_3"
		if not of_check_digit_ora( dwo, dwo.name, lena( data ) ) then
			return 1
		end if
	case else
end choose

return 0
end event

type dw_list from ivo_datawindow within wmm_teisu
integer x = 204
integer y = 1515
integer width = 3916
integer height = 796
integer taborder = 60
boolean bringtotop = true
string dataobject = "dmm_teisu_list"
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

event retrieveend;call super::retrieveend;// 処理中 終了
of_loading( false )
end event

event retrieverow;call super::retrieverow;// 処理の割り込み
yield()
end event

event retrievestart;call super::retrievestart;// 処理中 開始
of_loading( true )
end event

event key_f05;call super::key_f05;// F5：Excel出力
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "定数マスタ{1}", string( today(), "yyyymmdd" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event getfocus;call super::getfocus;
// フォーカスが当たった時にretrieveされているかでファンクションキーのenableを制御する
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録"
		this.of_set_fnkey( keyf12!, true )	// 登録ならF12を有効化
		return
	case "変更","削除"
		if i_doubleclicked then
			this.of_set_fnkey( keyf12!, true )	// 変更か削除で、ダブルクリックされた状態ならF12を有効化
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

event clicked;call super::clicked;string	l_columnname

// クリックされたところがヘッダなら、そこを起点にソートをかける
choose case dwo.name
	case "teisu_kbn_t", "teisu_mei_t", "teisu_code_t", "teisu_1_t", "teisu_2_t", "teisu_3_t", "setsumei_t", "kousin_kengen_mei_t"
		l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) -2 )
		of_set_dynamic_sort( l_columnname )
end choose		

end event

event doubleclicked;call super::doubleclicked;long	l_upd_row
string	l_code
long	l_row

setredraw( false )

if row > 0 then
	// 定数コードを取得
	l_code	= this.object.teisu_code[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の複写用の参照コピー
			if i_teisu_kbn = 0 then
				// 親コードの登録時
				l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )

				dw_entry_parent.object.teisu_kbn[l_row]			= i_teisu_kbn
				dw_entry_parent.object.teisu_mei[l_row]			= i_teisu_mei
				dw_entry_parent.object.teisu_code[l_row]		= this.object.teisu_code[row]
				dw_entry_parent.object.teisu_1[l_row]			= this.object.teisu_1[row]
				dw_entry_parent.object.teisu_2[l_row]			= this.object.teisu_2[row]
				dw_entry_parent.object.teisu_3[l_row]			= this.object.teisu_3[row]
				dw_entry_parent.object.setumei[l_row]			= this.object.setumei[row]
				dw_entry_parent.object.code_ketasu[l_row]		= this.object.code_ketasu[row]
				dw_entry_parent.object.code_zokusei_flg[l_row]	= this.object.code_zokusei_flg[row]
				dw_entry_parent.object.kousin_kengen[l_row]		= this.object.kousin_kengen[row]
			else
				// 子コードの登録時
				l_row	= long( dw_entry.object.datawindow.firstrowonpage )
				
				dw_entry.object.teisu_code[l_row]				= this.object.teisu_code[row]
				dw_entry.object.teisu_1[l_row]					= this.object.teisu_1[row]
				dw_entry.object.teisu_2[l_row]					= this.object.teisu_2[row]
				dw_entry.object.teisu_3[l_row]					= this.object.teisu_3[row]
				dw_entry.object.setumei[l_row]					= this.object.setumei[row]
				dw_entry.object.code_ketasu[l_row]				= this.object.code_ketasu[row]
				dw_entry.object.code_zokusei_flg[l_row]			= this.object.code_zokusei_flg[row]
				dw_entry.object.kousin_kengen[l_row]			= this.object.kousin_kengen[row]
			end if
		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorで行っている
				if uo_signal.of_get_status() then
					if i_teisu_kbn <> 0 then
						dw_entry.event constructor( )
					else
						dw_entry_parent.event constructor( )
					end if
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_teisu_kbn, l_code ) then
					return -1
				end if
			end if

			if i_teisu_kbn = 0 then
				// 0は親コードなのでdw_entry_parentをretrieveする
				if dw_entry_parent.retrieve( i_teisu_kbn, l_code ) > 0 then
					l_row	= long( dw_entry_parent.object.datawindow.firstrowonpage )
					
					// dw_entry_parentにフォーカスを当てる
					if i_syori_kbn = "変更" then
						of_dsp_edit( "dw_entry_parent", true )
					end if
				else
					msg.of_error( "選択されたレコードが見つかりません。" )
					this.setfocus()
					return -1
				end if
			else
				// 0以外はdw_entryをretrieveする
				if dw_entry.retrieve( i_teisu_kbn, l_code ) > 0 then
					l_row	= long( dw_entry.object.datawindow.firstrowonpage )
					
					// dw_entryにフォーカスを当てる
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

