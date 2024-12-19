$PBExportHeader$wm_torihiki_karikaizyo.srw
$PBExportComments$取引停止仮解除設定
forward
global type wm_torihiki_karikaizyo from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wm_torihiki_karikaizyo
end type
type ddplb_syori_kbn from sv_ddplb_syori within wm_torihiki_karikaizyo
end type
type uo_tokui from cv_input_tokui within wm_torihiki_karikaizyo
end type
type dw_list from ivo_datawindow within wm_torihiki_karikaizyo
end type
type uo_seikyu from cv_input_tokui_seikyu within wm_torihiki_karikaizyo
end type
end forward

global type wm_torihiki_karikaizyo from iw_main_window
string title = "取引停止仮解除設定"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
uo_tokui uo_tokui
dw_list dw_list
uo_seikyu uo_seikyu
end type
global wm_torihiki_karikaizyo wm_torihiki_karikaizyo

type variables
private:

	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long 	i_seikyu_code
	long 	i_tokui_code
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時


end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public function boolean of_db_delete (any p_rec)
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_record_lock (long p_tokui_code, boolean p_lock)
public function boolean of_record_lock (long p_seikyu_code, long p_tokui_code, boolean p_lock)
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
//of_set_secondfocus( )					// 処理区分の表示がないので
of_set_firstfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		uo_seikyu.of_set_enabled( p_enabled )
		uo_tokui.of_set_enabled( p_enabled )
		cb_retrieve.enabled		= p_enabled

	case "dw_list"

		l_row	= long( dw_list.object.datawindow.firstrowonpage )
		if l_row > 0 then
			dw_list.object.syori_kbn.Expression = "'" + i_syori_kbn + "'"
			dw_list.setrow( l_row )
			dw_list.setcolumn( "chk" )
			dw_list.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if

end choose

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
uo_seikyu.event constructor( )
uo_tokui.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text		= l_syori_kbn

of_dsp_edit( "callsection", true )

//of_set_secondfocus( )			// 処理区分の表示がないので
of_set_firstfocus( )

end subroutine

public function boolean of_db_delete (any p_rec);

return true

end function

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_tokui
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
 using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "得意先マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
end subroutine

public function boolean of_record_lock (long p_tokui_code, boolean p_lock);
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
  from m_tokui mm,
       m_user mu,
       m_window mw
 where mm.henkou_user_id	= mu.user_id(+)
   and mm.henkou_pg_id		= mw.window_id(+)
   and mm.tokui_code		= :p_tokui_code
   for update
 using cocos;

choose case cocos.sqlcode
	case 0
		if p_lock = true then
			if l_henkou_user_id <> user.user_id then
				if l_haita_flg <> 0 then
					rollback using cocos;
					msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
					return false
				end if
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

public function boolean of_record_lock (long p_seikyu_code, long p_tokui_code, boolean p_lock);
long		l_tokui_code
long 		l_syusoku_flg
long		l_row
datastore	l_dts

l_dts = create datastore
l_dts.dataobject = "dm_torihiki_karikaizyo"
l_dts.settransobject(cocos)

// datastore検索
if l_dts.retrieve( p_seikyu_code, p_tokui_code ) > 0 then
	for l_row = 1 to l_dts.rowcount()
		l_tokui_code	= l_dts.object.tokui_code[l_row]
		l_syusoku_flg	= l_dts.object.syusoku_flg[l_row]
		
		// 終息フラグ = 1:終息は処理なし
		if l_syusoku_flg = 1 then
			continue
		end if

		// 排他処理
		if not of_record_lock( l_tokui_code, p_lock ) then
			destroy l_dts
			return false
		end if
	next
end if

destroy l_dts

return true

end function

on wm_torihiki_karikaizyo.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.uo_tokui=create uo_tokui
this.dw_list=create dw_list
this.uo_seikyu=create uo_seikyu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.uo_tokui
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.uo_seikyu
end on

on wm_torihiki_karikaizyo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.uo_tokui)
destroy(this.dw_list)
destroy(this.uo_seikyu)
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
uo_seikyu.y				= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」

// 2行目
uo_tokui.y				= uo_seikyu.y + 89 + code.MGN_UPPER_TATE_GAP		// 2行目「MGN_UPPER_TATE_GAP:11」

// st_second_upper高さ
st_second_upper.height	= uo_tokui.y + uo_tokui.height + code.MGN_UPPER_TATE - st_second_upper.y

// 表示ボタン
cb_retrieve.x			= l_width - cb_retrieve.width - code.MGN_YOKO
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= l_width - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE_MIDDLE - dw_list.y

end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
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
//uo_seikyu.sle_input.setfocus()


end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event retrieve_check;call super::retrieve_check;
long	l_cnt
long	l_haita_cnt
long 	l_seikyu_code
long 	l_tokui_code

// リトリーブ前の事前チェック
// 入力チェック
// 請求先の入力チェック
if lena( trim( uo_seikyu.sle_input.text ) ) > 0 then
	if not uo_seikyu.sle_input.event input_check() then
		return -1
	end if
end if

// 得意先の入力チェック
if lena( trim( uo_tokui.sle_input.text ) ) > 0 then
	if not uo_tokui.sle_input.event input_check() then
		return -1
	end if
end if

i_syori_kbn		= ddplb_syori_kbn.text
l_seikyu_code 	= long( uo_seikyu.sle_input.text )
l_tokui_code 	= long( uo_tokui.sle_input.text )
if isnull( l_seikyu_code ) then
	l_seikyu_code = 0
end if
if isnull( l_tokui_code ) then
	l_tokui_code = 0
end if

// 存在チェック
select count(*),
       sum( decode( haita_flg, 1, 1, 0 ))
  into :l_cnt,
       :l_haita_cnt
  from ( select distinct tokui_code, haita_flg from m_tokui 
          where torihiki_teisi_kbn = 2
		    and (:l_tokui_code  = 0  or (:l_tokui_code  <> 0  and tokui_code  = :l_tokui_code))
		    and (:l_seikyu_code = 0  or (:l_seikyu_code <> 0  and seikyu_code = :l_seikyu_code))
		) mt 
 using cocos;

if cocos.sqlcode = -1 then
	msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
	this.setfocus()
	return -1
end if

if i_syori_kbn = "変更" then
	if l_cnt = 0 then
		msg.of_error( "該当データが存在しません。この処理は実行できません。" )
		this.setfocus()
		return -1
	end if
	if l_haita_cnt > 0 then
		msg.of_error( "該当データは編集中のため、この処理は実行できません。" )
		this.setfocus()
		return -1
	end if
end if

end event

event retrieve_event;call super::retrieve_event;long	l_row
long	l_loop
long	l_nengetu


// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_seikyu_code 	= long( uo_seikyu.sle_input.text )
i_tokui_code 	= long( uo_tokui.sle_input.text )
if isnull( i_seikyu_code ) then
	i_seikyu_code = 0
end if
if isnull( i_tokui_code ) then
	i_tokui_code = 0
end if

// 更新部初期化
dw_list.event constructor( )

choose case i_syori_kbn
	case "変更"

		// 排他チェック
		if not of_record_lock( i_seikyu_code, i_tokui_code, true ) then
			return -1
		end if

		// 検索実行
		if dw_list.retrieve( i_seikyu_code, i_tokui_code )  = 0 then
			msg.of_error( "入力した請求先、得意先で登録されたデータはありません。" )
			uo_tokui.setfocus()
			uo_tokui.sle_input.setfocus()
			return -1
		end if

end choose

setredraw( false )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
	of_dsp_edit( "dw_list", true )
else
	of_dsp_edit( "callsection", true )
	of_dsp_edit( "dw_list", true )
end if

dw_list.setfocus()

setredraw( true )

end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

// 全てチェックされていない場合
if dw_list.find( "chk = 1", 1, dw_list.rowcount() ) = 0 then
	msg.of_error( "更新対象データがありません。" )
	return -1
end if


end event

event update_event;call super::update_event;
long		l_row
long		l_count

choose case i_syori_kbn
	case "登録", "変更"
		
		setredraw( false )
		for l_row = 1 to dw_list.rowcount()
			if dw_list.object.chk[l_row] = 1 then
				// チェックありは取引停止区分 = 9:仮解除 に設定
				dw_list.object.torihiki_teisi_kbn[l_row] = 9
			else
				dw_list.setitemstatus( l_row, 0, Primary!, NotModified! )
			end if
		next
		setredraw( true )
		
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "得意先マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return -1
		end if


	case "削除"
	case "照会"
end choose

// ログ出力
of_add_db_log( "update_event", 0, st_title.text + "[" + trim( uo_seikyu.sle_input.text ) + " " + trim( uo_tokui.sle_input.text ) + "]" + i_syori_kbn )


msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()


end event

type uo_signal from iw_main_window`uo_signal within wm_torihiki_karikaizyo
end type

type st_date from iw_main_window`st_date within wm_torihiki_karikaizyo
end type

type st_user_mei from iw_main_window`st_user_mei within wm_torihiki_karikaizyo
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_torihiki_karikaizyo
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_torihiki_karikaizyo
end type

type st_title from iw_main_window`st_title within wm_torihiki_karikaizyo
end type

type st_title_upper from iw_main_window`st_title_upper within wm_torihiki_karikaizyo
end type

type st_upper from iw_main_window`st_upper within wm_torihiki_karikaizyo
end type

type st_second_upper from iw_main_window`st_second_upper within wm_torihiki_karikaizyo
integer height = 231
boolean sf1_key = true
boolean sf2_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_torihiki_karikaizyo
integer taborder = 30
end type

type st_syori_kbn from ivo_statictext within wm_torihiki_karikaizyo
integer x = 2440
integer y = 153
boolean bringtotop = true
long textcolor = 255
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

event constructor;call super::constructor;
this.visible	= false
end event

type ddplb_syori_kbn from sv_ddplb_syori within wm_torihiki_karikaizyo
boolean visible = false
integer x = 2756
integer y = 146
integer width = 240
boolean bringtotop = true
long textcolor = 255
boolean enabled = false
boolean sorted = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean visible_touroku = false
boolean visible_sakujyo = false
boolean visible_syokai = false
string init_disp = "変更"
end type

event constructor;call super::constructor;
if ancestorreturnvalue <> 0 then
	return ancestorreturnvalue
end if

// selectionchangedを呼び出す
this.event selectionchanged( i_idx )

this.visible	= false
this.enabled	= true

setnull( i_syori_kbn )
end event

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_seikyu.of_set_dbchk_dupe( )
		uo_tokui.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_seikyu.of_set_dbchk_exst( )
		uo_tokui.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose

end event

type uo_tokui from cv_input_tokui within wm_torihiki_karikaizyo
string tag = "得意先"
integer x = 32
integer y = 256
integer taborder = 20
boolean bringtotop = true
boolean f4_key = false
boolean bikou_visible = false
boolean syusoku_hyoji = false
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

type dw_list from ivo_datawindow within wm_torihiki_karikaizyo
integer x = 32
integer y = 377
integer width = 5120
integer height = 1230
integer taborder = 40
string dataobject = "dm_torihiki_karikaizyo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f9_key = true
boolean f10_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;
long		l_row
long		l_tokui_code
long 		l_syusoku_flg

datawindowchild		ldwc

if this.rowcount() > 0 then
	
	choose case i_syori_kbn
		case "変更", "削除"		// ここでは「変更のみ」
			for l_row = 1 to this.rowcount()
				l_tokui_code	= this.object.tokui_code[l_row]
				l_syusoku_flg	= this.object.syusoku_flg[l_row]

				// 終息フラグ = 1:終息は処理なし
				if l_syusoku_flg = 1 then
					continue
				end if
				
				// ロック解除
				of_record_lock( l_tokui_code, false )
			next
	end choose
end if

this.i_function_name	= { "全選択", "", "", "", "", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf1!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf1!, false )
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f01;call super::key_f01;
// 全選択

long	l_row
long	l_mode	= 1	// 1:全選択/0:全解除

// 全行のチェックボックスがONでない場合(OFFが１つでもある) = 全選択
// 全行のチェックボックスがONの場合    (OFFが１つもない)   = 全解除
if dw_list.find( "chk = 0 and syusoku_flg = 0", 1, dw_list.rowcount() ) = 0 then
	l_mode	= 0
end if

for l_row = 1 TO dw_list.rowcount()
	// 終息フラグ = 1:終息 は解除
	if dw_list.object.syusoku_flg[l_row] = 1 then
		dw_list.object.chk[l_row] = 0		// 0:全解除
	else
		dw_list.object.chk[l_row] = l_mode
	end if
next

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

type uo_seikyu from cv_input_tokui_seikyu within wm_torihiki_karikaizyo
string tag = "請求先"
integer x = 32
integer y = 156
integer taborder = 10
boolean bringtotop = true
boolean chk_required = true
boolean bikou_visible = false
boolean torihiki_hyoji = false
end type

on uo_seikyu.destroy
call cv_input_tokui_seikyu::destroy
end on

