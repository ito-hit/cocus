$PBExportHeader$wmm_kanjyo_kamoku.srw
$PBExportComments$勘定科目登録
forward
global type wmm_kanjyo_kamoku from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_kanjyo_kamoku
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_kanjyo_kamoku
end type
type st_syori_kbn from ivo_statictext within wmm_kanjyo_kamoku
end type
type dw_entry from ivo_datawindow within wmm_kanjyo_kamoku
end type
type lstr_m_kamoku from structure within wmm_kanjyo_kamoku
end type
end forward

type lstr_m_kamoku from structure
	long		kamoku_code
	string		kamoku_mei
	long		hojyo_kamoku_code
	string		hojyo_kamoku_mei
	integer		tegata_nyuryoku_flg
	integer		bumon_nyuryoku_flg
	integer		siyo_kinsi_flg
	string		rowid
end type

global type wmm_kanjyo_kamoku from iw_main_window
string title = "勘定科目登録"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
end type
global wmm_kanjyo_kamoku wmm_kanjyo_kamoku

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	long	i_kamoku_code
	long	i_hojyo_kamoku_code

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
public function boolean of_db_delete (lstr_m_kamoku p_rec)
public function boolean of_db_update (lstr_m_kamoku p_rec)
public function boolean of_db_insert (lstr_m_kamoku p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_kamoku_code, integer p_hojyo_kamoku_code)
public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_kamoku_code, long p_hojyo_kamoku_code, string p_rowid)
public function boolean of_record_lock (boolean p_lock)
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
			dw_entry.setcolumn( "kamoku_code" )
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
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

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

public function boolean of_db_delete (lstr_m_kamoku p_rec);
delete from m_kamoku
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "勘定科目マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[勘定科目=" + string(p_rec.kamoku_code) + " " + p_rec.kamoku_mei+ " 補助科目=" + string(p_rec.hojyo_kamoku_code) + " " + p_rec.hojyo_kamoku_mei +"]" + i_syori_kbn )

return true
end function

public function boolean of_db_update (lstr_m_kamoku p_rec);
if i_syori_kbn= "変更" and i_hojyo_kamoku_code =0 then
	update m_kamoku
	   set kamoku_mei		= :p_rec.kamoku_mei,
   		   tegata_nyuryoku_flg= :p_rec.tegata_nyuryoku_flg, //更新してもよい？
		   bumon_nyuryoku_flg= :p_rec.bumon_nyuryoku_flg, //更新してもよい？
		   siyo_kinsi_flg= :p_rec.siyo_kinsi_flg, //更新してもよい？
		   henkou_date		= sysdate,
		   henkou_user_id	= :user.user_id,
		   henkou_client_id	= :device.name,
		   henkou_pg_id		= :i_pg_id,
		   kousin_user_id	= :user.user_id,
		   kousin_pg_id		= :i_pg_id
	 where kamoku_code   	= :p_rec.kamoku_code
	using cocos;
else

	update m_kamoku
	   set kamoku_code   	= :p_rec.kamoku_code,
		   kamoku_mei		= :p_rec.kamoku_mei,
		   hojyo_kamoku_code= :p_rec.hojyo_kamoku_code,
		   hojyo_kamoku_mei	= :p_rec.hojyo_kamoku_mei,
		   tegata_nyuryoku_flg= :p_rec.tegata_nyuryoku_flg,
		   bumon_nyuryoku_flg= :p_rec.bumon_nyuryoku_flg,
		   siyo_kinsi_flg= :p_rec.siyo_kinsi_flg,
		   henkou_date		= sysdate,
		   henkou_user_id	= :user.user_id,
		   henkou_client_id	= :device.name,
		   henkou_pg_id		= :i_pg_id,
		   kousin_user_id	= :user.user_id,
		   kousin_pg_id		= :i_pg_id
	 where rowid			= :p_rec.rowid
	using cocos;

end if

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "勘定科目マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[勘定科目=" + string(p_rec.kamoku_code) + " " + p_rec.kamoku_mei+ " 補助科目=" + string(p_rec.hojyo_kamoku_code) + " " + p_rec.hojyo_kamoku_mei +"]" + i_syori_kbn )

return true


end function

public function boolean of_db_insert (lstr_m_kamoku p_rec);
insert into m_kamoku(
	kamoku_code,kamoku_mei,
	hojyo_kamoku_code,
	hojyo_kamoku_mei,
	tegata_nyuryoku_flg,
	bumon_nyuryoku_flg,
	siyo_kinsi_flg,
	touroku_user_id,touroku_client_id,touroku_pg_id
) values (
	:p_rec.kamoku_code,:p_rec.kamoku_mei,
	:p_rec.hojyo_kamoku_code,
	:p_rec.hojyo_kamoku_mei,
	:p_rec.tegata_nyuryoku_flg,
	:p_rec.bumon_nyuryoku_flg,
	:p_rec.siyo_kinsi_flg,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "勘定科目マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[勘定科目=" + string(p_rec.kamoku_code) + " " + p_rec.kamoku_mei+ " 補助科目=" + string(p_rec.hojyo_kamoku_code) + " " + p_rec.hojyo_kamoku_mei +"]" + i_syori_kbn )


return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, integer p_kamoku_code, integer p_hojyo_kamoku_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_kamoku_code, p_hojyo_kamoku_code, l_rowid )
end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_kamoku_code, long p_hojyo_kamoku_code, string p_rowid);
long l_db_kamoku_code
long l_db_hojyo_kamoku_code
string  l_db_kamoku_mei
string  l_db_hojyo_kamoku_mei



select kamoku_code,hojyo_kamoku_code,kamoku_mei,hojyo_kamoku_mei
  into :l_db_kamoku_code,:l_db_hojyo_kamoku_code,:l_db_kamoku_mei,:l_db_hojyo_kamoku_mei
  from m_kamoku
 where kamoku_code		= :p_kamoku_code
   and hojyo_kamoku_code	= :p_hojyo_kamoku_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。{1}【登録済の勘定科目】{2}：{3}{4}【登録済の補助科目】{5}：{6}",code.crlf,string(l_db_kamoku_code),l_db_kamoku_mei,code.crlf,string(l_db_hojyo_kamoku_code),l_db_hojyo_kamoku_mei))
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		return false
end choose

end function

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_kamoku_lock( i_pg_id,i_kamoku_code,i_hojyo_kamoku_code) then
//	if lck.of_kamoku_lock( i_pg_id,i_kamoku_code) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_kamoku_unlock( i_pg_id,i_kamoku_code,i_hojyo_kamoku_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true

end function

on wmm_kanjyo_kamoku.create
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

on wmm_kanjyo_kamoku.destroy
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
dw_entry.height		= 326

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
if dw_list.retrieve( i_kamoku_code ) = 0 then
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
lstr_m_kamoku	l_rec
integer		l_row


l_row	= long( dw_entry.object.datawindow.firstrowonpage )

if l_row = 0 then
	l_row=1
end if
	
// 構造体に更新値をセット
l_rec.kamoku_code		= dw_entry.object.kamoku_code[l_row]
l_rec.kamoku_mei		    = dw_entry.object.kamoku_mei[l_row]
l_rec.hojyo_kamoku_code	= dw_entry.object.hojyo_kamoku_code[l_row]
l_rec.hojyo_kamoku_mei	= dw_entry.object.hojyo_kamoku_mei[l_row]
l_rec.tegata_nyuryoku_flg	= dw_entry.object.tegata_nyuryoku_flg[l_row]
l_rec.bumon_nyuryoku_flg	= dw_entry.object.bumon_nyuryoku_flg[l_row]
l_rec.siyo_kinsi_flg	= dw_entry.object.siyo_kinsi_flg[l_row]
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

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
end if
end event

event update_check;call super::update_check;
long	l_row
long	l_cnt
dwobject l_dwo
l_dwo	= this.dw_entry.object
string l_rowid


// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_kamoku_code		= dw_entry.object.kamoku_code[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.kamoku_code, string(dw_entry.object.kamoku_code[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.kamoku_mei, dw_entry.object.kamoku_mei[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.hojyo_kamoku_mei, dw_entry.object.hojyo_kamoku_mei[l_row] ) <> 0 then
	return -1
end if


// 必須チェック
if len( string( dw_entry.object.kamoku_code[l_row] ) ) = 0 then
	msg.of_error_dwo( dw_entry.object.kamoku_code, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "勘定科目名" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "kamoku_code" )
	return -1
end if

if len( string( dw_entry.object.hojyo_kamoku_code[l_row] ) ) = 0 then
	msg.of_error_dwo( dw_entry.object.hojyo_kamoku_code, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "補助科目名" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "hojyo_kamoku_code" )
	return -1
end if

long	l_kamoku_code
long	l_hojyo_kamoku_code
string  l_kamoku_mei

l_kamoku_code = dw_entry.object.kamoku_code[l_row]
l_kamoku_mei = dw_entry.object.kamoku_mei[l_row]
l_hojyo_kamoku_code = dw_entry.object.hojyo_kamoku_code[l_row]
l_rowid	=  dw_entry.object.rowid[l_row]

choose case i_syori_kbn
	case "登録"
		// 重複チェック
		if not of_dwchk_duplicate( l_dwo.kamoku_code, l_kamoku_code ,l_hojyo_kamoku_code) then
			return 1
		end if
		
		
		// 親コードが登録済みかどうかチェック
	
		select count('x')
		  into :l_cnt
		  from m_kamoku
		 where kamoku_code		= :l_kamoku_code
		using cocos;
		//				   and rowidtochar( rowid )	<> :l_row
		
		if l_cnt = 0 then 
			if l_hojyo_kamoku_code <> 0 then
				msg.of_error_dwo( l_dwo.kamoku_code, fnc.strg.of_format( "親の勘定科目レコードが登録されていないため、補助科目レコードを登録できません。{1}【未登録の勘定科目】{2}",code.crlf,string(l_kamoku_code)))
				return -1
			end if
		else 
			// 親コードの勘定科目名と子コードの勘定科目名が一致するかどうかチェック
	
			select count('x')
			  into :l_cnt
			  from m_kamoku
	  		 where kamoku_code		= :l_kamoku_code
			   and hojyo_kamoku_code= 0
   			   and nvl(kamoku_mei,'???')	   <> nvl(:l_kamoku_mei,'???')
			using cocos;
		
			if l_cnt > 0 then 
				if l_hojyo_kamoku_code <> 0 then
					msg.of_error_dwo( l_dwo.kamoku_mei, fnc.strg.of_format( "親の勘定科目名と一致しない勘定科目名になっているため、登録できません。{1}【勘定科目】:{2}",code.crlf,string(l_kamoku_code)))
					return -1
				end if
			end if
			
		end if

	case "変更"
		
		// 重複チェック
		if not of_dwchk_duplicate( l_dwo.kamoku_code, l_kamoku_code, l_hojyo_kamoku_code, l_rowid) then
			return 1
		end if
		
		
		// 親コードが登録済みかどうかチェック
	
		select count('x')
		  into :l_cnt
		  from m_kamoku
		 where kamoku_code		= :l_kamoku_code
		using cocos;
		//				   and rowidtochar( rowid )	<> :l_row
		
		if l_cnt = 0 then 
			if l_hojyo_kamoku_code <> 0 then
				msg.of_error_dwo( l_dwo.kamoku_code, fnc.strg.of_format( "親の勘定科目レコードが登録されていないため、補助科目レコードを登録できません。{1}【未登録の勘定科目】{2}",code.crlf,string(l_kamoku_code)))
				return -1
			end if
			
		else 
			// 親コードの勘定科目名と子コードの勘定科目名が一致するかどうかチェック
	
			select count('x')
			  into :l_cnt
			  from m_kamoku
	  		 where kamoku_code		= :l_kamoku_code
			   and hojyo_kamoku_code= 0
   			   and nvl(kamoku_mei,'???')	   <> nvl(:l_kamoku_mei,'???')
			using cocos;
		
			if l_cnt <> 0 then 
				if l_hojyo_kamoku_code <> 0 then
					msg.of_error_dwo( l_dwo.kamoku_mei, fnc.strg.of_format( "親の勘定科目名と一致しない勘定科目名になっているため、登録できません。{1}【勘定科目】:{2}",code.crlf,string(l_kamoku_code)))
					return -1
				end if
			end if
			
			
		end if
	case "削除"

		if l_hojyo_kamoku_code = 0 then
			
			// 子コードが存在するかどうかチェック
		
			select count('x')
			  into :l_cnt
			  from m_kamoku
			 where kamoku_code		= :l_kamoku_code
			 and hojyo_kamoku_code <> 0
			using cocos;
			
			if l_cnt > 0 then 	
				msg.of_error_dwo( l_dwo.hojyo_kamoku_code, fnc.strg.of_format( "補助科目レコードが存在するため、親の勘定科目レコードを削除できません。{1}【登録済みの勘定科目】{2}",code.crlf,string(l_kamoku_code)))
				return -1
			end if
		end if
	case "照会"
end choose




end event

type uo_signal from iw_main_window`uo_signal within wmm_kanjyo_kamoku
end type

type st_date from iw_main_window`st_date within wmm_kanjyo_kamoku
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_kanjyo_kamoku
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_kanjyo_kamoku
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_kanjyo_kamoku
end type

type st_title from iw_main_window`st_title within wmm_kanjyo_kamoku
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_kanjyo_kamoku
end type

type st_upper from iw_main_window`st_upper within wmm_kanjyo_kamoku
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_kanjyo_kamoku
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_kanjyo_kamoku
integer taborder = 20
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_kanjyo_kamoku
integer x = 8
integer y = 679
integer width = 4208
integer height = 1177
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_kanjyo_kamoku_list"
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
l_file	= fnc.strg.of_format( "勘定科目登録_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

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
	
//	i_kamoku_code	    = this.object.kamoku_code[row]
//	i_hojyo_kamoku_code	= this.object.hojyo_kamoku_code[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.kamoku_code[l_row]      	= this.object.kamoku_code[row]
			dw_entry.object.kamoku_mei[l_row]	    	= this.object.kamoku_mei[row]
			dw_entry.object.hojyo_kamoku_code[l_row]	= this.object.hojyo_kamoku_code[row]
			dw_entry.object.hojyo_kamoku_mei[l_row]		= this.object.hojyo_kamoku_mei[row]			


		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if


				
				// インスタンス変数へ値セット(ロック関連に使用)
				i_kamoku_code	= this.object.kamoku_code[row]
				i_hojyo_kamoku_code	= this.object.hojyo_kamoku_code[row]
				
				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( true ) then
					setredraw( true )
					return -1
				end if
				
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_kamoku_code, i_hojyo_kamoku_code) > 0 then
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

type ddplb_syori_kbn from sv_ddplb_syori within wmm_kanjyo_kamoku
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )

end event

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

end event

type st_syori_kbn from ivo_statictext within wmm_kanjyo_kamoku
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_kanjyo_kamoku
integer y = 373
integer width = 5120
integer height = 274
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_kanjyo_kamoku_entry"
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
			of_record_lock( false )
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
long	l_kamoku_code
//int	l_kamoku_code
long	l_hojyo_kamoku_code


string	l_input
string	l_colnm
string	l_tableid	= "m_kamoku"
string	l_msg
long    l_row

l_row=row

l_kamoku_code		= this.object.kamoku_code[row]
l_hojyo_kamoku_code		= this.object.hojyo_kamoku_code[row]

// 桁数チェック
choose case dwo.name
	case "kamoku_code", "kamoku_mei"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case  "hojyo_kamoku_code"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別仕様
choose case dwo.name
	case "kamoku_code"
		// 勘定科目コードコード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		

		// 桁セット
		l_kamoku_code		= long(this.object.kamoku_code[row])
		if isnull(data ) then
//			l_kamoku_code	= 0
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		// 勘定科目は0不可
		if long(data) = 0 then
			msg.of_error_dwo( dwo, "0は入力できません。" )
			return 1
		end if
		
	case "hojyo_kamoku_code"
		
		// 補助勘定科目コード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		

		// 桁セット
		l_hojyo_kamoku_code		= this.object.hojyo_kamoku_code[row]
		if isnull( l_hojyo_kamoku_code ) then
			l_hojyo_kamoku_code	= 0
		end if
		
	case  "hojyo_kamoku_mei"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if l_hojyo_kamoku_code=0 then
			if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if
		else
			if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if
		end if

	case else

end choose

return 0
end event

