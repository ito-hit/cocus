$PBExportHeader$wmm_tanto.srw
$PBExportComments$営業担当者登録
forward
global type wmm_tanto from iw_main_window
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanto
end type
type st_syori_kbn from ivo_statictext within wmm_tanto
end type
type dw_entry from ivo_datawindow within wmm_tanto
end type
type uo_tanto from cv_input_tanto within wmm_tanto
end type
end forward

global type wmm_tanto from iw_main_window
string title = "営業担当者登録"
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
uo_tanto uo_tanto
end type
global wmm_tanto wmm_tanto

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long	i_tanto_code
	
end variables
forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public function boolean of_record_lock (long p_tanto_code, boolean p_lock)
public function long of_db_insert ()
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_entry.event constructor( )
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
		uo_tanto.of_set_enabled( p_enabled )

	case "dw_entry"

		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_entry.enabled	= true
			dw_entry.setrow( l_row )
			dw_entry.setcolumn( "tanto_mei" )
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
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )
uo_tanto.event constructor( )
uo_tanto.of_set_enabled( true )

// 元の選択中だった処理区分を再セット(selectionchangedの再実行が必要)
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

of_set_secondfocus( )

end subroutine

public function boolean of_record_lock (long p_tanto_code, boolean p_lock);
if not lck.of_tanto_lock( user.user_id, i_pg_id, p_tanto_code, p_lock ) then
	msg.of_error_db( "データを更新できません。", cocos )
	rollback using cocos;	// 関数内でrollbackしているけど、一応書いておく
	return false
else
	commit using cocos;		// 排他ロックに成功したら、関数の呼び出し後にcommitが必ず必要
end if

// 
uo_signal.of_on_signal( p_lock )


return true
end function

public function long of_db_insert ();
nv_master	mst
str_mkihon	l_kihon[]

long	l_nendo_code
long	l_nengetu
long	l_bumon_code,l_eigyosyo_code,l_ka_code
long	l_kisyo_nengetu, l_kimatu_nengetu
long	l_row,l_loop

// 登録時のみ作成する
if i_syori_kbn <> "登録" then
	return 0
end if

l_bumon_code		= dw_entry.object.bumon_code[1]
l_eigyosyo_code		= dw_entry.object.eigyosyo_code[1]
l_ka_code			= dw_entry.object.ka_code[1]

// 事業年度M検索カーソル
declare cur_nendo cursor for
	select kisyo_nengetu,kimatu_nengetu
	  from m_nendo
	 where nendo_code	>= :l_nendo_code
	order by nendo_code
	using cocos;

// 基本情報
if mst.of_kihon_get_full( 0, l_kihon ) = 0 then
	return -1
end if
// 本年度取得
l_nendo_code	= l_kihon[1].jigyo_nendo

open cur_nendo;
if cocos.sqlcode <> 0 then
	msg.of_error_db( "営業担当者所属マスタの登録処理でエラーが発生しました。", cocos )
	return -1
else
	do until cocos.sqlcode <> 0
		
		fetch cur_nendo into :l_kisyo_nengetu, :l_kimatu_nengetu ;

		choose case cocos.sqlcode
			case 0

				// 作成が必要な件数取得
				select months_between( :l_kimatu_nengetu ||'01', :l_kisyo_nengetu ||'01' )
				  into :l_loop
				  from dual
				using cocos ;
				
				l_nengetu	= l_kisyo_nengetu
				l_loop		= l_loop + 1
		
				for l_row = 1 to l_loop
					
					insert into m_syozoku(
						tanto_code,
						nengetu,
						nen,
						tuki,
						bumon_code,
						eigyosyo_code,
						ka_code,
						uriage_mokuhyo,
						arari_mokuhyo,
						touroku_user_id,touroku_client_id,touroku_pg_id,
						kousin_user_id,kousin_client_id,kousin_pg_id
					) values (
						:i_tanto_code,
						:l_nengetu,
						substrb( :l_nengetu, 1, 4 ),
						substrb( :l_nengetu, 5, 6 ),
						:l_bumon_code,
						:l_eigyosyo_code,
						:l_ka_code,
						0,
						0,
						:user.user_id,:device.name,:i_pg_id,
						:user.user_id,:device.name,:i_pg_id
					) using cocos;
					
					if cocos.sqlcode <> 0 then
						rollback using cocos;
						msg.of_error_db( "営業担当者所属マスタの登録処理でエラーが発生しました。", cocos )
						of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
						close cur_nendo ;
						return -1
					end if
		
					// 次年月取得
					select to_number( to_char( add_months( ( :l_nengetu )||'01', 1 ), 'YYYYMM' ) )
					  into :l_nengetu
					  from dual
					using cocos ;
				next

			case 100
				// 処理不要
			case else
				msg.of_error_db( "営業担当者所属マスタの登録処理でエラーが発生しました。", cocos )
				rollback using cocos;
				close cur_nendo ;
				return -1
		end choose
	loop
end if

close cur_nendo;




return 0
end function

on wmm_tanto.create
int iCurrent
call super::create
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.uo_tanto=create uo_tanto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori_kbn
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.uo_tanto
end on

on wmm_tanto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_tanto)
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
uo_tanto.y			= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
// st_second_upper高さ
st_second_upper.height	= uo_tanto.y + uo_tanto.height + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= key_fnc.y - code.MGN_TATE - dw_entry.y

// 登録日時＆変更日時
dw_entry.object.henkou_date.x		= dw_entry.width - long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x		= long( dw_entry.object.henkou_date.x ) - long( dw_entry.object.henkou_date_t.width ) - 20
dw_entry.object.touroku_date.x		= long( dw_entry.object.henkou_date_t.x ) - long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x	= long( dw_entry.object.touroku_date.x ) - long( dw_entry.object.touroku_date_t.width ) - 20


end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
//i_admin	= kengen.of_check_admin( )


end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
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

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not uo_tanto.event sle_input_check( ) then
	return -1
end if

end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_tanto_code	= long( uo_tanto.of_get_input() )

choose case i_syori_kbn
	case "登録"
		dw_entry.event constructor()
		dw_entry.object.tanto_code[1]		= i_tanto_code
		dw_entry.object.nayose_code[1]		= i_tanto_code
		dw_entry.object.user_id[1]			= user.user_id
		dw_entry.object.user_mei[1]			= user.user_mei
		
	case "変更", "削除"
		// 排他処理
		if not of_record_lock( i_tanto_code, true ) then
			return -1
		end if
		if dw_entry.retrieve( i_tanto_code ) = 0 then
			msg.of_error( "入力した営業担当者コードで登録されたデータはありません。" )
			uo_tanto.setfocus()
			return -1
		end if
	case "照会"
		if dw_entry.retrieve( i_tanto_code ) = 0 then
			msg.of_error( "入力した営業担当者コードで登録されたデータはありません。" )
			uo_tanto.setfocus()
			return -1
		end if

end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

of_dsp_edit( "dw_entry", true )

// 一旦フォーカスを明細部へ
dw_entry.setfocus()



end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

if dw_entry.event itemchanged( l_row, dw_entry.object.tanto_mei, string( dw_entry.object.tanto_mei[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.tanto_mei_ryaku, string( dw_entry.object.tanto_mei_ryaku[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.nayose_code, string( dw_entry.object.nayose_code[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.bumon_code, string( dw_entry.object.bumon_code[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.eigyosyo_code, string( dw_entry.object.eigyosyo_code[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ka_code, string( dw_entry.object.ka_code[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.user_id, string( dw_entry.object.user_id[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.haiban_flg, string( dw_entry.object.haiban_flg[l_row] ) ) <> 0 then
	return -1
end if




end event

event update_event;call super::update_event;long		l_row
long		l_count


choose case i_syori_kbn
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error_db( "営業担当者マスタの登録処理でエラーが発生しました。", cocos )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return -1
		end if
		// 営業担当者所属M作成
		if of_db_insert() <> 0 then
			return -1
		end if

		// ログ出力( イベントID, エラーコード, メッセージ )
		of_add_db_log( "update_event", 0, st_title.text + "[" + string( dw_entry.object.tanto_code[1] ) + " " + dw_entry.object.tanto_mei[1] + "]" + i_syori_kbn )

end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
of_dsp_back()

end event

type uo_signal from iw_main_window`uo_signal within wmm_tanto
end type

type st_date from iw_main_window`st_date within wmm_tanto
integer height = 75
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tanto
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tanto
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tanto
end type

type st_title from iw_main_window`st_title within wmm_tanto
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tanto
end type

type st_upper from iw_main_window`st_upper within wmm_tanto
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tanto
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tanto
integer taborder = 40
integer textsize = -11
fontcharset fontcharset = shiftjis!
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanto
integer x = 348
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean visible_sakujyo = false
string init_disp = "照会"
end type

event constructor;call super::constructor;

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.event selectionchanged( i_idx )

setnull( i_syori_kbn )


end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )
 
// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_tanto.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		uo_tanto.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose
end event

type st_syori_kbn from ivo_statictext within wmm_tanto
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_tanto
integer y = 377
integer width = 5056
integer height = 1589
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_tanto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
long			l_row


// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
			of_record_lock( i_tanto_code, false )
	end choose
end if

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

//i_colname	= ""

this.reset()
this.settransobject(cocos)

this.insertrow(0)
this.enabled	= false

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		if this.rowcount() > 0 then
			this.of_set_fnkey( keyf12!, true )
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

event itemchanged;call super::itemchanged;
long	l_code
string	l_mei
long	l_haiban_flg
long	l_cnt

string	l_input
string	l_colnm
string	l_tableid	= "m_tanto"
string	l_msg


// 入力チェック
choose case dwo.name
	case "tanto_mei", "tanto_mei_ryaku", "nayose_code", "bumon_code", "eigyosyo_code", "ka_code", "user_id"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別チェック
choose case dwo.name

	case "nayose_code"
		if lena( trim( data ) ) > 0 then
		
			// 存在チェック
			l_code	= long( data )
			
			if l_code = 0 then
				msg.of_error_dwo( dwo, "0は入力できません。" )
				return 1
			end if
			
			// 自身以外の名寄せ先の場合、存在チェック
			if i_tanto_code <> l_code then
			
				select tanto_mei,
					   haiban_flg
				  into :l_mei,
					   :l_haiban_flg
				  from m_tanto
				 where tanto_code	= :l_code
				using cocos	;
				
				choose case cocos.sqlcode
					case 0
						if l_haiban_flg = 1 then
							msg.of_error_dwo( dwo, "廃番の営業担当者は名寄せ先に設定できません。" )
							return 1
						else
							this.object.nayose_mei[row]		= trim( l_mei )
						end if
					case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
						return 1
					case else
						msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "tanto_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
						return 1
				end choose
			end if
		end if

	case "bumon_code"
		if lena( trim( data ) ) > 0 then

			// 存在チェック
			l_code	= long( data )
			select meisyo_1
			  into :l_mei
			  from m_meisyo
			 where meisyo_kbn	= 21
			   and meisyo_code	= :l_code
			using cocos	;
			
			choose case cocos.sqlcode
				case 0
					this.object.bumon_mei[row]		= trim( l_mei )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		end if

	case "eigyosyo_code"
		if lena( trim( data ) ) > 0 then

			// 存在チェック
			l_code	= long( data )
			select meisyo_1
			  into :l_mei
			  from m_meisyo
			 where meisyo_kbn	= 22
			   and meisyo_code	= :l_code
			using cocos;
			
			choose case cocos.sqlcode
				case 0
					this.object.eigyosho_mei[row]		= trim( l_mei )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		end if

	case "ka_code"
		if lena( trim( data ) ) > 0 then

			// 存在チェック
			l_code	= long( data )
			select meisyo_1
			  into :l_mei
			  from m_meisyo
			 where meisyo_kbn	= 23
			   and meisyo_code	= :l_code
			using cocos;
			
			choose case cocos.sqlcode
				case 0
					this.object.ka_mei[row]		= trim( l_mei )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		end if

	case "user_id"
		if lena( trim( data ) ) > 0 then

			// 存在チェック
			select user_mei
			  into :l_mei
			  from m_user
			 where user_id	= :data
			using cocos	;
			
			choose case cocos.sqlcode
				case 0
					this.object.user_mei[row]		= trim( l_mei )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "user_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		end if

	case "haiban_flg"
		// 廃番チェック
		if data = "1" then
			// 自身が自身以外の名寄せ先として登録されている場合はエラー
			select count('x')
			  into :l_cnt
			  from m_tanto
			 where nayose_code	= :i_tanto_code
			   and tanto_code	<> :i_tanto_code
			using cocos ;
			if l_cnt > 0 then
				msg.of_error_dwo( dwo, "別営業担当者の名寄せコードに登録されている為、廃番にできません。" )
				return 1
			end if
			// 得意先M.担当者コード(現担当者)に登録されている場合、確認メッセージを表示
			select count('x')
			  into :l_cnt
			  from m_tokui
			 where tanto_code	= :i_tanto_code
			using cocos ;
			if l_cnt > 0 then
				if msg.of_warning_question( "得意先マスタの担当者として登録されています。よろしいですか？" ) = false then
					return 1
				end if
			end if
			
		end if

	case else
end choose

return 0
end event

event key_f08;call super::key_f08;
// F8:参照
integer		l_row
string		l_column

// 参照設定
str_mdlpara_mtanto	l_mdl_tanto
str_mdlpara_mmeisyo	l_mdl_meisyo
str_mdlpara_muser	l_mdl_user

l_row		= this.getrow()
l_column	= this.getcolumnname()

// 照会はF8使用不可
if i_syori_kbn = "照会" or i_syori_kbn = "削除" then
	return 0
end if

// F8:参照
choose case l_column
	case "nayose_code"
		// 名寄せ
		l_mdl_tanto	= mdl.of_open_modal( "wsm_tanto", l_mdl_tanto )
		if upperbound( l_mdl_tanto.ret ) > 0 then
			this.object.nayose_code[l_row]	= l_mdl_tanto.ret[1].tanto_code
			if this.event itemchanged( l_row, this.object.nayose_code, string( l_mdl_tanto.ret[1].tanto_code ) ) <> 0 then
				return -1
			end if
		end if

	case "bumon_code"
		// 部門
		l_mdl_meisyo.in_meisyo_kbn	= 21
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			this.object.bumon_code[l_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			if this.event itemchanged( l_row, this.object.bumon_code, string( l_mdl_meisyo.ret[1].meisyo_code ) ) <> 0 then
				return -1
			end if
		end if
		
	case "eigyosyo_code"
		// 営業所
		l_mdl_meisyo.in_meisyo_kbn	= 22
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			this.object.eigyosyo_code[l_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			if this.event itemchanged( l_row, this.object.eigyosyo_code, string( l_mdl_meisyo.ret[1].meisyo_code ) ) <> 0 then
				return -1
			end if
		end if
	case "ka_code"
		// 課
		l_mdl_meisyo.in_meisyo_kbn	= 23
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			this.object.ka_code[l_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			if this.event itemchanged( l_row, this.object.ka_code, string( l_mdl_meisyo.ret[1].meisyo_code ) ) <> 0 then
				return -1
			end if
		end if
	case "user_id"
		// ユーザー 未実装
		l_mdl_user	= mdl.of_open_modal( "wsm_user", l_mdl_user )
		if upperbound( l_mdl_user.ret ) > 0 then
			this.object.user_id[l_row]	= l_mdl_user.ret[1].user_id
			if this.event itemchanged( l_row, this.object.user_id, string( l_mdl_user.ret[1].user_id ) ) <> 0 then
				return -1
			end if
		end if
end choose


return 0
end event

event buttonclicked;call super::buttonclicked;
choose case dwo.name
	case "b_nayose"
		this.setcolumn( "nayose_code" )
	case "b_bumon"
		this.setcolumn( "bumon_code" )
	case "b_eigyosyo"
		this.setcolumn( "eigyosyo_code" )
	case "b_ka"
		this.setcolumn( "ka_code" )
	case "b_user"
		this.setcolumn( "user_id" )

	case else
		return 0
end choose

this.event key_f08( keyf8!, 0 )


return 0


end event

type uo_tanto from cv_input_tanto within wmm_tanto
event destroy ( )
integer x = 32
integer y = 260
integer width = 1412
integer taborder = 20
boolean bringtotop = true
string title_text = "コード"
long input_width = 128
long bikou_width = 0
boolean bikou_visible = false
end type

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

