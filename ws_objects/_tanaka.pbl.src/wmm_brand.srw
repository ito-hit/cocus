$PBExportHeader$wmm_brand.srw
$PBExportComments$ブランド登録
forward
global type wmm_brand from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_brand
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_brand
end type
type st_syori_kbn from ivo_statictext within wmm_brand
end type
type dw_entry from ivo_datawindow within wmm_brand
end type
type lstr_m_brand from structure within wmm_brand
end type
end forward

type lstr_m_brand from structure
	integer		brand_code
	string		brand_mei
	string		brand_mei_ryaku
	string		rowid
end type

global type wmm_brand from iw_main_window
string title = "ブランド登録"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
end type
global wmm_brand wmm_brand

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	integer	i_brand_code
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
public function boolean of_db_delete (lstr_m_brand p_rec)
public function boolean of_db_update (lstr_m_brand p_rec)
public function boolean of_db_insert (lstr_m_brand p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_brand_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_brand_code)
public function boolean of_record_lock (boolean p_lock)
end prototypes

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
			dw_entry.setcolumn( "brand_code" )
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

//of_set_secondfocus( )
of_set_firstfocus( )

end subroutine

public subroutine of_dsp_back ();//
//boolean	l_doubleclicked
//
//// Wクリック状態を取得
//l_doubleclicked	= i_doubleclicked
//
//// シグナルが有効であればDBアンロックの必要あり
//choose case i_syori_kbn
//	case "登録"
//		dw_entry.event constructor( )
//	case "変更", "削除", "照会"
//		dw_entry.event constructor( )
//end choose
//
//
//// Wクリック状態でフォーカス移動
//if l_doubleclicked then
//	dw_entry.setfocus()	// フォーカスバグのおまじない
//	dw_list.setfocus()
//else
//	of_dsp_edit( "callsection", true )
//	dw_list.event constructor( )
////	of_set_secondfocus( )
//	of_set_firstfocus( )
//end if


dw_list.event constructor( )
dw_entry.event constructor( )

of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )



end subroutine

public function boolean of_db_delete (lstr_m_brand p_rec);
delete from m_brand
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
//	msg.of_error( fnc.strg.of_format( "ブランドマスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	msg.of_error_db( "ブランドマスタの削除処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[" + string(p_rec.brand_code) + " " + p_rec.brand_mei + "]" + i_syori_kbn )

return true
end function

public function boolean of_db_update (lstr_m_brand p_rec);
update m_brand
   set brand_code   	= :p_rec.brand_code,
	   brand_mei		= :p_rec.brand_mei,
	   brand_mei_ryaku	= :p_rec.brand_mei_ryaku,
	   henkou_date		= sysdate,
	   henkou_user_id	= :user.user_id,
	   henkou_client_id	= :device.name,
	   henkou_pg_id		= :i_pg_id,
	   kousin_user_id	= :user.user_id,
	   kousin_pg_id		= :i_pg_id
 where rowid			= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "ブランドマスタの更新処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[" + string(p_rec.brand_code) + " " + p_rec.brand_mei + "]" + i_syori_kbn )

return true


end function

public function boolean of_db_insert (lstr_m_brand p_rec);
insert into m_brand(
	brand_code,brand_mei,
	brand_mei_ryaku,
	touroku_user_id,touroku_client_id,touroku_pg_id
) values (
	:p_rec.brand_code,:p_rec.brand_mei,
	:p_rec.brand_mei_ryaku,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "ブランドマスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[" + string(p_rec.brand_code) + " " + p_rec.brand_mei + "]" + i_syori_kbn )

return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_brand_code, string p_rowid);
string	l_db_brand_mei

select brand_mei
  into :l_db_brand_mei
  from m_brand
 where brand_code		= :p_brand_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしているブランドはすでに登録があります。{1}【登録済のブランド】{2}：{3}", code.crlf, p_brand_code, l_db_brand_mei ) )
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_brand_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_brand_code, l_rowid )
end function

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_brand_lock( i_pg_id, i_brand_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_brand_unlock( i_pg_id, i_brand_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true
end function

on wmm_brand.create
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

on wmm_brand.destroy
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
dw_entry.height		= 224

dw_list.y			= dw_entry.y + dw_entry.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y

// DWの登録日時と変更日時

dw_entry.object.henkou_date.x = dw_entry.width -long( dw_entry.object.henkou_date.width ) - 32
dw_entry.object.henkou_date_t.x = long( dw_entry.object.henkou_date.x ) -long( dw_entry.object.henkou_date_t.width ) - 20

dw_entry.object.touroku_date.x = long( dw_entry.object.henkou_date_t.x ) -long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x = long( dw_entry.object.touroku_date.x ) -long( dw_entry.object.touroku_date_t.width ) - 20

end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text


// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_brand_code ) = 0 then
	if i_syori_kbn <> "登録" then
		msg.of_error( "登録されたデータはありません。" )
		ddplb_syori_kbn.setfocus()
		return -1
	end if
end if

//setredraw( false )

// 更新部初期化
dw_entry.event constructor( )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
	of_dsp_edit( "dw_entry", true )
else
	of_dsp_edit( "callsection", true )
	of_dsp_edit( "dw_entry", true )
end if

// 一旦フォーカスを明細部へ
dw_entry.setfocus()

//setredraw( true )
end event

event update_event;call super::update_event;
lstr_m_brand	l_rec
integer				l_row


l_row	= long( dw_list.object.datawindow.firstrowonpage )
l_row	= long( dw_entry.object.datawindow.firstrowonpage )

// 構造体に更新値をセット

l_rec.brand_mei		    = dw_entry.object.brand_mei[l_row]
l_rec.brand_mei_ryaku	= dw_entry.object.brand_mei_ryaku[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]
l_rec.brand_code		= dw_entry.object.brand_code[l_row]

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

i_brand_code		= dw_entry.object.brand_code[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.brand_code, string(dw_entry.object.brand_code[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.brand_mei, dw_entry.object.brand_mei[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.brand_mei_ryaku, dw_entry.object.brand_mei_ryaku[l_row] ) <> 0 then
	return -1
end if

// 必須チェック
//if len( string( dw_entry.object.brand_mei[l_row] ) ) = 0 then
//	msg.of_error_dwo( dw_entry.object.brand_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "ブランド名" ) )
//	dw_entry.setfocus()
//	dw_entry.setcolumn( "brand_mei" )
//	return -1
//end if

end event

type uo_signal from iw_main_window`uo_signal within wmm_brand
end type

type st_date from iw_main_window`st_date within wmm_brand
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_brand
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_brand
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_brand
end type

type st_title from iw_main_window`st_title within wmm_brand
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_brand
end type

type st_upper from iw_main_window`st_upper within wmm_brand
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_brand
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_brand
integer taborder = 20
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_brand
integer x = 8
integer y = 679
integer width = 4208
integer height = 1177
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_brand_list"
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
//l_file	= fnc.strg.of_format( "ブランドマスタ{1}", string( today(), "yyyymmdd" ) )
l_file	= fnc.strg.of_format( "ブランド登録_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

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
	
	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.brand_code[l_row]	= this.object.brand_code[row]
			dw_entry.object.brand_mei[l_row]		= this.object.brand_mei[row]
			dw_entry.object.brand_mei_ryaku[l_row]		= this.object.brand_mei_ryaku[row]			


		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// インスタンス変数へ値セット(ロック関連に使用)
				i_brand_code	= integer(this.object.brand_code[row])
				
				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_brand_code ) > 0 then
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

type ddplb_syori_kbn from sv_ddplb_syori within wmm_brand
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.enabled			= true

setnull( i_syori_kbn )

// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

end event

type st_syori_kbn from ivo_statictext within wmm_brand
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_brand
integer y = 373
integer width = 5120
integer height = 274
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_brand_entry"
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
string	l_brand_code
//int	l_brand_code

string	l_input
string	l_colnm
string	l_tableid	= "m_brand"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "brand_code", "brand_mei", "brand_mei_ryaku"
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
	case "brand_code"
		// ブランドコードコード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo, data ) then
					return 1
				end if
		end choose
		
		// 桁セット
		l_brand_code		= string(this.object.brand_code[row])
		if isnull( l_brand_code ) then
			l_brand_code	= ""
		end if

	case else

end choose

return 0
end event

