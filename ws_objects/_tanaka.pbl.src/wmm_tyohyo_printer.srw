$PBExportHeader$wmm_tyohyo_printer.srw
$PBExportComments$帳票プリンター登録
forward
global type wmm_tyohyo_printer from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_tyohyo_printer
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tyohyo_printer
end type
type st_syori_kbn from ivo_statictext within wmm_tyohyo_printer
end type
type dw_entry from ivo_datawindow within wmm_tyohyo_printer
end type
type lstr_m_tyohyo_printer from structure within wmm_tyohyo_printer
end type
end forward

type lstr_m_tyohyo_printer from structure
	string		tyohyo_id
	string		printer_mei
	string		printer_mei_ryaku
	string		rowid
	string		printer_syubetu
	integer		kyoten_cd
	string		client_id
	string		client_name
	integer		use_flg
end type

global type wmm_tyohyo_printer from iw_main_window
string title = "帳票プリンター登録"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
end type
global wmm_tyohyo_printer wmm_tyohyo_printer

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	string	i_tyohyo_id
	string	i_client_id
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時
	
	string	meisyo_code[]
	long	meisyo_code_num[]
	string	meisyo_mei[]

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
public function boolean of_db_delete (lstr_m_tyohyo_printer p_rec)
public function boolean of_db_update (lstr_m_tyohyo_printer p_rec)
public function boolean of_db_insert (lstr_m_tyohyo_printer p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_client_id, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_client_id)
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
			dw_entry.setcolumn( "tyohyo_id" )
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
	//of_set_secondfocus( )
	of_set_firstfocus( )
end if


end subroutine

public function boolean of_db_delete (lstr_m_tyohyo_printer p_rec);
delete from m_tyohyo_printer
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "帳票プリンターマスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[帳票ID=" + string(p_rec.tyohyo_id) + " クライアントID=" + p_rec.client_id + "]" + i_syori_kbn )

return true
end function

public function boolean of_db_update (lstr_m_tyohyo_printer p_rec);
update m_tyohyo_printer
   set tyohyo_id   	= :p_rec.tyohyo_id,
       client_id		= :p_rec.client_id,
	   client_name		= :p_rec.client_name,
   	   kyoten_cd		= :p_rec.kyoten_cd,
	   printer_mei		= :p_rec.printer_mei,
	   printer_mei_ryaku= :p_rec.printer_mei_ryaku,
	   printer_syubetu	= :p_rec.printer_syubetu,
	   use_flg			= :p_rec.use_flg,
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
	msg.of_error( fnc.strg.of_format( "帳票プリンターマスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[帳票ID=" + string(p_rec.tyohyo_id) + " クライアントID=" + p_rec.client_id + "]" + i_syori_kbn )

return true


end function

public function boolean of_db_insert (lstr_m_tyohyo_printer p_rec);
insert into m_tyohyo_printer(
	tyohyo_id,
	client_id,
	client_name,
	kyoten_cd,printer_mei,
	printer_mei_ryaku,
	printer_syubetu,
	use_flg,
	touroku_user_id,touroku_client_id,touroku_pg_id
) values (
	:p_rec.tyohyo_id,
	:p_rec.client_id,
	:p_rec.client_name,	
	:p_rec.kyoten_cd,:p_rec.printer_mei,
	:p_rec.printer_mei_ryaku,
	:p_rec.printer_syubetu,
	:p_rec.use_flg,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "帳票プリンターマスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[帳票ID=" + string(p_rec.tyohyo_id) + " クライアントID=" + p_rec.client_id + "]" + i_syori_kbn )

return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_client_id, string p_rowid);
string	l_db_printer_mei

select printer_mei
  into :l_db_printer_mei
  from m_tyohyo_printer
 where tyohyo_id		= :p_tyohyo_id
   and client_id        = :p_client_id
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

   
choose case cocos.sqlcode
	case 0
		msg.of_error( fnc.strg.of_format( "登録しようとしている帳票プリンターコードはすでに登録があります。{1}【登録済の帳票ID】{2}{3}【登録済のクライアントID】{4}", code.crlf, p_tyohyo_id, code.crlf,p_client_id) )
		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, string p_tyohyo_id, string p_client_id);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_tyohyo_id, p_client_id, l_rowid )
end function

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_tyohyo_printer_lock( i_pg_id,i_tyohyo_id,i_client_id ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_tyohyo_printer_unlock( i_pg_id, i_tyohyo_id,i_client_id ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true

end function

on wmm_tyohyo_printer.create
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

on wmm_tyohyo_printer.destroy
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
dw_entry.height		= 538

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
if dw_list.retrieve( i_tyohyo_id,i_client_id ) = 0 then
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
lstr_m_tyohyo_printer	l_rec
integer				l_row


l_row	= long( dw_list.object.datawindow.firstrowonpage )
// 構造体に更新値をセット
l_rec.tyohyo_id		= dw_entry.object.tyohyo_id[l_row]

l_rec.printer_mei		    = dw_entry.object.printer_mei[l_row]
l_rec.printer_mei_ryaku	= dw_entry.object.printer_mei_ryaku[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]

l_rec.kyoten_cd  = dw_entry.object.kyoten_cd[l_row]

l_rec.client_id  = dw_entry.object.client_id[l_row]
l_rec.client_name = dw_entry.object.client_name[l_row]
l_rec.printer_syubetu  = dw_entry.object.printer_syubetu[l_row]

l_rec.use_flg  = dw_entry.object.use_flg[l_row]


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
string  l_rowid

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_tyohyo_id		= dw_entry.object.tyohyo_id[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.tyohyo_id, string(dw_entry.object.tyohyo_id[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.kyoten_mei, string(dw_entry.object.kyoten_cd[l_row] )) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.client_id, dw_entry.object.client_id[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.printer_mei, dw_entry.object.printer_mei[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.printer_mei_ryaku, dw_entry.object.printer_mei_ryaku[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.printer_syubetu_mei, dw_entry.object.printer_syubetu_mei[l_row] ) <> 0 then
	return -1
end if

// 必須チェック
if isnull( dw_entry.object.kyoten_mei[l_row]  )  then
	msg.of_error_dwo( dw_entry.object.kyoten_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "使用拠点" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "kyoten_mei" )
	return -1
end if

if isnull( dw_entry.object.printer_mei[l_row] )  then
	msg.of_error_dwo( dw_entry.object.printer_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "帳票プリンター名" ) )
	dw_entry.setfocus()
	dw_entry.setcolumn( "printer_mei" )
	return -1
end if

string l_tyohyo_id
string l_client_id

l_tyohyo_id   =  dw_entry.object.tyohyo_id[l_row]
l_client_id =  dw_entry.object.client_id[l_row]
l_rowid	=  dw_entry.object.rowid[l_row]

// 処理区分別チェック
if i_syori_kbn <> "登録" then
	// 重複チェック
	if not of_dwchk_duplicate( dw_entry.object, l_tyohyo_id, l_client_id ,l_rowid ) then
		return -1
	end if
else
	// 重複チェック
	if not of_dwchk_duplicate( dw_entry.object, l_tyohyo_id, l_client_id ) then
		return -1
	end if

end if
	
	
	

end event

type uo_signal from iw_main_window`uo_signal within wmm_tyohyo_printer
end type

type st_date from iw_main_window`st_date within wmm_tyohyo_printer
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tyohyo_printer
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tyohyo_printer
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tyohyo_printer
end type

type st_title from iw_main_window`st_title within wmm_tyohyo_printer
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tyohyo_printer
end type

type st_upper from iw_main_window`st_upper within wmm_tyohyo_printer
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tyohyo_printer
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tyohyo_printer
integer taborder = 20
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_tyohyo_printer
integer x = 8
integer y = 935
integer width = 4208
integer height = 846
integer taborder = 30
boolean bringtotop = true
string dataobject = "dmm_tyohyo_printer_list"
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
		if i_doubleclicked then
			this.of_set_fnkey( keyf12!, true )
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "帳票プリンター登録_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event doubleclicked;call super::doubleclicked;
long	l_upd_row
string	l_code
long	l_row
string	l_meisyo_kbn,l_meisyo_mei,l_meisyo_code
string	l_mei

setredraw( false )

if row > 0 then
	
	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
			dw_entry.object.tyohyo_id[l_row]	= this.object.tyohyo_id[row]
			dw_entry.object.kyoten_cd[l_row]	= this.object.kyoten_cd[row]
			dw_entry.object.kyoten_mei[l_row]	= this.object.kyoten_mei_ryaku[row]
			dw_entry.object.client_id[l_row]	= this.object.client_id[row]
			dw_entry.object.client_name[l_row]	= this.object.client_name[row]			
			dw_entry.object.printer_mei[l_row]	= this.object.printer_mei[row]
			dw_entry.object.printer_mei_ryaku[l_row]		= this.object.printer_mei_ryaku[row]	
			dw_entry.object.printer_syubetu[l_row]		= this.object.printer_syubetu[row]
//			dw_entry.object.printer_syubetu_mei[l_row]		= this.object.printer_syubetu_mei[row]
			
			l_mei	= this.object.printer_syubetu[row]

			// 存在チェック
			select meisyo_code,meisyo_1
			into :l_meisyo_code,:l_meisyo_mei
			from m_meisyo
			where meisyo_kbn	= 35
			and meisyo_code	= :l_mei
			using cocos;
				
			choose case cocos.sqlcode
				case 0
					dw_entry.object.printer_syubetu_mei[l_row]		= trim( l_meisyo_code )
				case 100
					dw_entry.object.printer_syubetu_mei[l_row] =""
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "purinter_syubetu_mei_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
					
			dw_entry.object.use_flg[l_row]		= this.object.use_flg[row]

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// インスタンス変数へ値セット(ロック関連に使用)
				i_tyohyo_id	= this.object.tyohyo_id[row]
				i_client_id	= this.object.client_id[row]
				
				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_tyohyo_id,i_client_id ) > 0 then
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
//dw_entry.setcolumn("tyohyo_id")
//			dw_entry.setfocus()
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

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tyohyo_printer
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

type st_syori_kbn from ivo_statictext within wmm_tyohyo_printer
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_tyohyo_printer
integer y = 373
integer width = 5120
integer height = 537
boolean bringtotop = true
string dataobject = "dmm_tyohyo_printer_entry"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

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
string	l_tyohyo_id
//int	l_tyohyo_id
string	l_mei
long l_kyoten_code
string	l_meisyo_code,l_meisyo_mei

string	l_input
string	l_colnm
string	l_tableid	= "m_tyohyo_printer"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "tyohyo_id",  "client_id", "printer_mei", "printer_mei_ryaku"
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
	case "tyohyo_id"
		// 帳票プリンターコードコード
		// 数値のみ入力可
//		if not isnumber( data ) then
//			msg.of_error_dwo( dwo, "数値を入力してください。" )
//			return 1
//		end if
		

		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
//				if not of_dwchk_duplicate( dwo, data ) then
//					return 1
//				end if
		end choose
		
		// 桁セット
//		l_tyohyo_id		= string(this.object.tyohyo_id[row])
//		if isnull( l_tyohyo_id ) then
//			l_tyohyo_id	= ""
//		end if

	case "kyoten_mei"
		


		l_mei	= data 
	
//		// 存在チェック
//		select meisyo_code,meisyo_1
//		into :l_meisyo_code,:l_meisyo_mei
//		from m_meisyo
//		where meisyo_kbn	= 163
//		and meisyo_code	= :l_mei
//		using cocos;
//		
//		l_kyoten_code	= long(data) 
	
		if data=""  then
			msg.of_error_dwo( dw_entry.object.kyoten_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "使用拠点" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "kyoten_mei" )
			return 1
		end if
	
	
		// 存在チェック
		select kyoten_code
		into :l_kyoten_code
		from m_kyoten
		where kyoten_code	= :l_mei
		using cocos;
					
				choose case cocos.sqlcode
					case 0
						this.object.kyoten_cd[row]		= l_kyoten_code
					case 100
							msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
						return 1
					case else
						msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
						return 1
				end choose
						
	case "printer_syubetu_mei"
		l_mei	= trim(data) 
	
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.printer_syubetu_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "帳票プリンター名" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 35
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.printer_syubetu[row]		= l_meisyo_code
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose

	case else

end choose

return 0
end event

event constructor;call super::constructor;
DataWindowChild	ldwc_kyoten
DataWindowChild	ldwc_printer_syubetu

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "kyoten_mei", ldwc_kyoten)
ldwc_kyoten.settransobject( cocos )

//meisyo_kbn		= 157
//meisyo_no		= 1
//l_code_visible	= 0

l_row	= ldwc_kyoten.retrieve(0,1) 
//l_row	= ldwc_kyoten.retrieve(0) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "printer_syubetu_mei", ldwc_printer_syubetu)
ldwc_printer_syubetu.settransobject( cocos )

meisyo_kbn		= 35
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_printer_syubetu.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

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

