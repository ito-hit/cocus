$PBExportHeader$w_master_nendo.srw
$PBExportComments$事業年度登録
forward
global type w_master_nendo from iw_main_window
end type
type ddplb_syori_kbn from sv_ddplb_syori within w_master_nendo
end type
type dw_list from ivo_datawindow within w_master_nendo
end type
type st_syori_kbn from ivo_statictext within w_master_nendo
end type
type uo_nendo from cv_input_nendo within w_master_nendo
end type
end forward

global type w_master_nendo from iw_main_window
integer width = 5128
integer height = 3271
string title = "事業年度登録"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "AppIcon!"
boolean f12_key = true
ddplb_syori_kbn ddplb_syori_kbn
dw_list dw_list
st_syori_kbn st_syori_kbn
uo_nendo uo_nendo
end type
global w_master_nendo w_master_nendo

type variables
private integer	i_permission	// 0：全ユーザー、1：システム管理者
private	boolean	i_admin			// ユーザーの管理者権限保有
end variables

forward prototypes
public function boolean of_delete_m_syozoku ()
public function boolean of_insert_m_syozoku ()
public function boolean of_delete_m_tokui_tanto ()
public function boolean of_insert_m_tokui_tanto ()
private function boolean chk_nendo_before (long p_nendo_code)
private function boolean chk_overlap_period (long p_date_str, long p_date_end)
private function boolean chk_q (integer p_1q, integer p_2q)
private function boolean chk_year_num (string p_data)
private function boolean reset_dw_list (string p_message)
end prototypes

public function boolean of_delete_m_syozoku ();msg.of_info( "m_syozoku削除" )
return true
end function

public function boolean of_insert_m_syozoku ();msg.of_info( "m_syozoku登録" )
return true
end function

public function boolean of_delete_m_tokui_tanto ();msg.of_info( "m_tokui_tanto削除" )
return true
end function

public function boolean of_insert_m_tokui_tanto ();msg.of_info( "m_tokui_tanto登録" )
return true
end function

private function boolean chk_nendo_before (long p_nendo_code);// 引数の値と今期を比べて今期以前の値ならfalseを返す。

long l_nendo_code

// 現在日付がいつの期かを確認する
select nendo_code
  into :l_nendo_code
  from m_nendo
 where kisyo_date < to_number( to_char( sysdate, 'yyyymmdd' ) )
   and to_number( to_char( sysdate, 'yyyymmdd' ) ) < kimatu_date
 using cocos;
 
if cocos.sqlcode <> 0 then	// sqlが正しく発行されたかどうかのチェック
	msg.of_error( "SQLエラー" )
	return false
end if
 
if p_nendo_code < l_nendo_code then
	return false
end if

return true
end function

private function boolean chk_overlap_period (long p_date_str, long p_date_end);// 年度コードの期間と引数の期間重複しているかをチェックする
// 重複していないならtrue 重複するデータが存在するならfalse

long	l_count	// 重複を検索した結果の件数を格納する変数
boolean l_return

// 期間の重複チェック
select count( * )	// 検索した結果の件数をカウントしてる
  into :l_count	// selectのcount結果を格納してる。
  from m_nendo
 where kisyo_date < :p_date_end
   and kimatu_date > :p_date_str
 using cocos;

if cocos.sqlcode <> 0 then	// sqlが正しく発行されたかどうかのチェック
	msg.of_error( "SQLエラー" )
	l_return = false
end if

choose case l_count
	case 0
		l_return = true
	case else
		l_return = false
end choose

return l_return




/* 備忘録

// 2回目

//// 最新年度コードを取得
//select max( nendo_code )
//  into :l_nendo_code
//  from m_nendo
// using cocos;
// 
//if cocos.sqlcode <> 0 then	// sqlが正しく発行されたかどうかのチェック
//	msg.of_error( "SQLエラー" )
//	l_return = false
//end if

// 期間の重複チェック
select count( * )	// 検索した結果の件数をカウントしてる
  into :l_count	// selectのcount結果を格納してる。
  from m_nendo
// where nendo_code = :l_nendo_code
//   and kisyo_date < :p_date_end
//   and kimatu_date > :p_date_str
 where kisyo_date < :p_date_end
   and kimatu_date > :p_date_str
 using cocos;


// 1回目

choose case cocos.sqlcode
	case 0	// データがあるということは重複している
		l_return = false
	case -1	// nullならデータは重複していないからtrue
		l_return = true
	case else
		msg.of_error( "SQLエラー" )
		l_return = false
end choose

*/
end function

private function boolean chk_q (integer p_1q, integer p_2q);// p_1qとp_2qを比較して問題ないならtrueを返す。
// 12月と1月の境目で計算を分ける。

boolean l_return

if ( p_2q >= 4 ) and ( p_2q <= 12 ) then
	if ( p_1q >= 4 ) and ( p_1q <= 12 ) then
		if ( p_1q - p_2q ) < 0 then
			l_return = true
		else
			l_return = false
		end if	
	else
		l_return = false
	end if	
elseif ( p_2q >= 1 ) and ( p_2q <= 3 ) then
	if ( p_1q >= 4 ) and ( p_1q <= 12 ) then
		if ( p_1q - p_2q ) > 0 then
			l_return = true
		else
			l_return = false
		end if
	elseif ( p_1q >= 1 ) and ( p_1q <= 3 ) then
		if ( p_1q - p_2q ) < 0 then
			l_return = true
		else
			l_return = false
		end if
	else
		l_return = false
	end if
else
	l_return = false
end if

return l_return





/* 備忘録

choose case p_2q
	case ( is >= 4 ) and ( is <= 12 )
		if ( p_1q - p_2q ) < 0 then
			msg.of_error( "1" )
			l_return = true
		else
			msg.of_error( "2" )
			l_return = false
		end if
	case is >= 1, is <= 3
		choose case p_1q
			case is >= 4, is <= 12
				if ( p_1q - p_2q ) > 0 then
					msg.of_error( "3" )
					l_return = true
				else
					msg.of_error( "4" )
					l_return = false
				end if
			case is >= 1, is <= 3
				if ( p_1q - p_2q ) < 0 then
					msg.of_error( "5" )
					l_return = true
				else
					msg.of_error( "6" )
					l_return = false
				end if
			case else
				msg.of_error( "7" )
				l_return = false
		end choose
	case else
		msg.of_error( "8" )
		l_return = false
end choose

return l_return

*/
end function

private function boolean chk_year_num (string p_data);// dataの入力チェック 1年分の数字だけが欲しい
// 多分dw_listしか使わない

boolean l_return

l_return = false

if isnull( p_data ) = false then	// 空白チェック
	if isnumber( p_data ) then 		// 数字のチェック
		if string( integer( p_data ) ) <> "0"  then	// 全角のチェック
			if ( integer( p_data ) >= 1 ) and ( integer( p_data ) <= 12 ) then
				l_return = true
			else
				msg.of_error( "1～12の数字を入力してください。" )
			end if
		end if
	end if
end if

return l_return
end function

private function boolean reset_dw_list (string p_message);
if p_message <> "" then
	msg.of_info( p_message )
end if

dw_list.reset()
dw_list.insertrow(0)

return true
end function

on w_master_nendo.create
int iCurrent
call super::create
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_list=create dw_list
this.st_syori_kbn=create st_syori_kbn
this.uo_nendo=create uo_nendo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori_kbn
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.st_syori_kbn
this.Control[iCurrent+4]=this.uo_nendo
end on

on w_master_nendo.destroy
call super::destroy
destroy(this.ddplb_syori_kbn)
destroy(this.dw_list)
destroy(this.st_syori_kbn)
destroy(this.uo_nendo)
end on

event retrieve_event;call super::retrieve_event; //ddplb_syori_kbnとsle_nendoの情報を見てる
string	l_syori_kbn
long	l_nendo_code

dw_list.reset()	// dw_listの画面をリセット

l_syori_kbn		= ddplb_syori_kbn.text
l_nendo_code	= long( uo_nendo.of_get_input() )

// 処理区分の判定
choose case l_syori_kbn
	case "登録"
		dw_list.insertrow(0)
		dw_list.object.syori_kbn[1] = 1
	case "変更", "照会"
		if dw_list.retrieve( l_nendo_code ) > 0 then
			choose case l_syori_kbn
				case "照会"
					dw_list.object.syori_kbn[1]	= 0
					dw_list.f12_key				= false
					dw_list.event getfocus( )
				case "変更"
					dw_list.object.syori_kbn[1] = 2
					
					dw_list.setcolumn( "nendo_mei" )
					dw_list.setfocus()
				case else
				// 何もしない
			end choose
		else			
			if l_nendo_code > 0 then
				msg.of_error( "入力された年度のデータはありません。" ) 
			end if
		end if
	case "削除"	
		if chk_nendo_before( l_nendo_code ) then	// 今期以前かどうかチェックする。
			if dw_list.retrieve( l_nendo_code ) > 0 then
				dw_list.object.syori_kbn[1]	= 0
				dw_list.f12_key				= true
				dw_list.event getfocus( )
			else
				reset_dw_list( "入力された年度のデータはありません。" )	// 画面のリセット
			end if
		else
			reset_dw_list( "今期以前のデータは削除できません。" )	// 画面のリセット
		end if
	case else
		// 何もしない
end choose
end event

event retrieve_check;call super::retrieve_check;
// 年度の入力チェック
//msg.of_info( uo_nendo.i_syori_kbn )

if not uo_nendo.event sle_input_check() then	// 何も入力しないまま「表示」を押下すると先祖のsleのinput_checkが反応しなかったため追加した。
	return -1
end if

// 変更可能かどうか権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出す）
if not i_admin then
	if i_permission = 0 then
		msg.of_warning( "入力された名称区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
		ddplb_syori_kbn.text	= "照会"
	end if
end if

return 0
end event

event openquery;call super::openquery;// システム管理者区分
//constant integer c_admin	= 1

// システム管理者権限を保有状況確認
//i_admin	= dbfnc.of_chk_access_arrow( c_admin )
i_admin	= kengen.of_check_admin()
end event

event open;call super::open;ddplb_syori_kbn.setfocus()
end event

event update_event;call super::update_event;string	l_syori_kbn
long	l_nendo_code

l_syori_kbn						= ddplb_syori_kbn.text

l_nendo_code					= long( uo_nendo.of_get_input( ) )
dw_list.object.nendo_code[1]	= l_nendo_code

choose case l_syori_kbn
	case "変更", "登録"
		if dw_list.update() = 1 then
			commit using cocos;
			msg.of_info( "データを更新しました。" )
			
//			msg.of_info( "１２３４５６７８９１２３４５６７８９１２３４５６７８９" + code.CRLF + "１２３４５６７８９１２３４５６７８９１２３４５６７８９" )
			msg.of_info( "営業担当者と営業担当者所属のデータを" + code.CRLF + "併せて更新します。" )
			of_insert_m_syozoku( )
			of_insert_m_tokui_tanto( )
			
			reset_dw_list( "データの更新が完了しました。" )	// 画面のリセット
		else
			msg.of_error( "データの更新に失敗しました。" )
			return -1
		end if		
	case "削除"
		if chk_nendo_before( l_nendo_code ) then	// 今期以前かどうかチェックする。
			dw_list.deleterow(1)
			if dw_list.update() = 1 then	// deleterowの操作をupdateする
				commit using cocos;
				msg.of_info( "データを更新しました。" )
				
				msg.of_info( "営業担当者と営業担当者所属のデータを" + code.CRLF + "併せて削除します。" )
				of_delete_m_syozoku( )
				of_delete_m_tokui_tanto( )
				
				reset_dw_list( "データの更新が完了しました。" )	// 画面のリセット
				uo_nendo.of_reset( )	// 入力フォームのリセット
			else
				msg.of_error( "データの更新に失敗しました。" )
				return -1
			end if	
		else
			msg.of_error( "今期以前のデータは削除できません。" )
		end if
	case else
//			何もしない
end choose
end event

event key_f12;call super::key_f12;of_evt_update(0,0)

return 0
end event

event update_check;call super::update_check;// dw_listの入力チェック必要
end event

event key_f10;call super::key_f10;//winctl.post of_close( parent.classname(), false )
winctl.post of_close( this.classname(), false )

return 0
end event

type uo_signal from iw_main_window`uo_signal within w_master_nendo
end type

type st_date from iw_main_window`st_date within w_master_nendo
end type

type st_user_mei from iw_main_window`st_user_mei within w_master_nendo
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_master_nendo
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_master_nendo
end type

type st_title from iw_main_window`st_title within w_master_nendo
end type

type st_title_upper from iw_main_window`st_title_upper within w_master_nendo
end type

type st_upper from iw_main_window`st_upper within w_master_nendo
end type

type st_second_upper from iw_main_window`st_second_upper within w_master_nendo
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_master_nendo
integer taborder = 50
boolean f9_key = true
boolean f10_key = true
end type

type ddplb_syori_kbn from sv_ddplb_syori within w_master_nendo
integer x = 352
integer y = 153
integer width = 240
integer taborder = 30
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event selectionchanged;call super::selectionchanged;
choose case ddplb_syori_kbn.text
	case "変更", "照会", "削除"
//		uo_nendo.of_set_exist_result( true )
	case "登録"
//		uo_nendo.of_set_exist_result( false )
	case else
		// 何もしない
end choose
end event

event constructor;call super::constructor;//uo_nendo.of_set_exist_result( true )
end event

type dw_list from ivo_datawindow within w_master_nendo
integer x = 192
integer y = 395
integer width = 2964
integer height = 896
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_master_nendo"
boolean border = false
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
dw_list.settransobject(cocos)
reset_dw_list( "" ) // 初期画面を表示
end event

event itemchanged;call super::itemchanged;string	l_strat_date, l_end_date
string	l_start_date_str, l_end_date_str

if row > 0 then
	choose case dwo.name
		case "nendo_mei"
			dw_list.object.nendo_mei[row]	= data
		case "date_str_str"
			if len( trim( data ) ) = 0 or isnull( data ) then	// 空白チェック
				msg.of_error( "期間の開始日が入力されていません。" )
				return 1
			else
				if data <> "0" and data <> "9999/99/99" then	// 0と9999/99/99ではないかのチェック
					l_start_date_str = fnc.db.of_date_format( data )
					
					if isdate( l_start_date_str ) then	// 日付として使えるかどうかのチェック
						dw_list.object.date_str_str[row]	= l_start_date_str
						data								= l_start_date_str
						
						l_strat_date						= fnc.strg.of_replace( l_start_date_str, "/", "" )
						dw_list.object.kisyo_date[row]		= long( l_strat_date )
						dw_list.object.kisyo_nengetu[row]	= long( mid( l_strat_date, 1, 6 ) )	// 20220708 → 202207へ切り出し
//						messagebox( "l_start_date_str = " + l_start_date_str, "l_strat_date = " + l_strat_date )

						return 2
					else
						msg.of_error( "入力された日付は適切ではありません。" )
						return 1
					end if
				else
					msg.of_error( "入力された日付は適切ではありません。" )
					return 1
				end if
			end if
		case "date_end_str"
			if len( trim( data ) ) = 0 or isnull( data ) then	// 空白チェック
				msg.of_error( "期間の開始日が入力されていません。" )
				return 1
			else
				if data <> "0" and data <> "9999/99/99" then	// 0と9999/99/99ではないかのチェック
					l_end_date_str	= fnc.db.of_date_format( data )
					
					if isdate( l_end_date_str ) then	// 日付として使えるかどうかのチェック
						dw_list.object.date_end_str[row]	= l_end_date_str
						data								= l_end_date_str
						
						l_end_date							= fnc.strg.of_replace( l_end_date_str, "/", "" )
						dw_list.object.kimatu_date[row]		= long( l_end_date )
						dw_list.object.kimatu_nengetu[row]	= long( mid( l_end_date, 1, 6 ) )
						
						if ( dw_list.object.kisyo_date[row] - dw_list.object.kimatu_date[row] ) > 0 then	// 開始と終了の整合性のチェック
							msg.of_error( "開始日が終了日より未来の日付になっています。" )
							return 1
						end if
						
						if chk_overlap_period( dw_list.object.kisyo_date[row], dw_list.object.kimatu_date[row] ) = false then	// 期間の重複チェック
							msg.of_error( "期間が前年と重複しています。" )
							return 1
						end if

						return 2
					else
						msg.of_error( "入力された日付は適切ではありません。" )
						return 1
					end if
				else
					msg.of_error( "入力された日付は適切ではありません。" )
					return 1
				end if
			end if
		case "tuki_1q"
			// 入力チェック
			if chk_year_num( data ) then
				dw_list.object.tuki_1q[row]	= integer( data )
			else
//				msg.of_error( "半角数字を入力してください。" )
//				dw_list.setcolumn( "tuki_1q" )
				return 1
			end if		
		case "tuki_2q"
			if chk_year_num( data ) then
				if chk_q( dw_list.object.tuki_1q[row], integer( data ) ) = false then
					msg.of_error( "1qより先の月を入力してください。" )
					return 1
				end if
				dw_list.object.tuki_2q[row]	= integer( data )
			else
//				msg.of_error( "半角数字を入力してください。" )
				return 1
			end if
		case "tuki_3q"
			if chk_year_num( data ) then
				if chk_q( dw_list.object.tuki_2q[row], integer( data ) ) = false then
					msg.of_error( "2qより先の月を入力してください。" )
					return 1
				end if
				dw_list.object.tuki_3q[row]	= integer( data )
			else
//				msg.of_error( "半角数字を入力してください。" )
				return 1
			end if
		case "tuki_4q"
			if chk_year_num( data ) then
				if chk_q( dw_list.object.tuki_3q[row], integer( data ) ) = false then
					msg.of_error( "3qより先の月を入力してください。" )
					return 1
				end if
				dw_list.object.tuki_4q[row]	= integer( data )
			else
//				msg.of_error( "半角数字を入力してください。" )
				return 1
			end if
		case else
//			何もしない
	end choose	
end if

return 0

end event

event itemerror;call super::itemerror;return 2
end event

type st_syori_kbn from ivo_statictext within w_master_nendo
integer x = 36
integer y = 160
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type uo_nendo from cv_input_nendo within w_master_nendo
event destroy ( )
integer x = 36
integer y = 260
integer width = 1660
integer taborder = 40
boolean bringtotop = true
end type

on uo_nendo.destroy
call cv_input_nendo::destroy
end on

event constructor;call super::constructor;
//msg.of_info( i_syori_kbn )
end event

