$PBExportHeader$wm_syohin_sunpo.srw
$PBExportComments$商品寸法登録
forward
global type wm_syohin_sunpo from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wm_syohin_sunpo
end type
type ddplb_syori_kbn from sv_ddplb_syori within wm_syohin_sunpo
end type
type dw_list from ivo_datawindow within wm_syohin_sunpo
end type
type uo_syohin from cv_input_syohin within wm_syohin_sunpo
end type
type uo_syohin_moto from cv_input_syohin within wm_syohin_sunpo
end type
type st_down_arrow from ivo_statictext within wm_syohin_sunpo
end type
type cb_copy from ivo_commandbutton within wm_syohin_sunpo
end type
type st_sunpo_title from ivo_statictext within wm_syohin_sunpo
end type
type cb_zengyo_copy from ivo_commandbutton within wm_syohin_sunpo
end type
type cb_ikkatu_copy from ivo_commandbutton within wm_syohin_sunpo
end type
type uo_iro_moto from cv_input within wm_syohin_sunpo
end type
type gb_fukusya_moto from ivo_groupbox within wm_syohin_sunpo
end type
end forward

global type wm_syohin_sunpo from iw_main_window
string title = "商品寸法登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_list dw_list
uo_syohin uo_syohin
uo_syohin_moto uo_syohin_moto
st_down_arrow st_down_arrow
cb_copy cb_copy
st_sunpo_title st_sunpo_title
cb_zengyo_copy cb_zengyo_copy
cb_ikkatu_copy cb_ikkatu_copy
uo_iro_moto uo_iro_moto
gb_fukusya_moto gb_fukusya_moto
end type
global wm_syohin_sunpo wm_syohin_sunpo

type variables
private:

	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	long 	i_syohin_code
	long 	i_iro_no
	
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
public function boolean of_record_lock (long p_syohin_code, long p_iro_no, boolean p_lock)
public function boolean of_record_lock (long p_syohin_code, long p_iro_no, string p_size_code, boolean p_lock)
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
uo_syohin_moto.event constructor( )
uo_iro_moto.event constructor( )
dw_list.event constructor( )
cb_copy.event constructor( )
cb_zengyo_copy.event constructor( )
cb_ikkatu_copy.event constructor( )
of_set_secondfocus( )
//uo_syohin.sle_input.setfocus()


end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled			= p_enabled
		uo_syohin.enabled				= p_enabled
		uo_syohin.sle_input.enabled		= p_enabled
		uo_syohin.sle_input_iro.enabled	= p_enabled
		cb_retrieve.enabled				= p_enabled

	case "dw_list"
		
		l_row	= long( dw_list.object.datawindow.firstrowonpage )
		if l_row > 0 then
			dw_list.enabled			= p_enabled
			dw_list.object.syori_kbn.Expression = "'" + i_syori_kbn + "'"

			// 複写
			uo_syohin_moto.enabled					= p_enabled
			uo_iro_moto.enabled						= p_enabled

			// 前行複写、一括複写
			cb_copy.enabled							= p_enabled
			cb_zengyo_copy.enabled					= p_enabled
			cb_ikkatu_copy.enabled					= p_enabled
			
			uo_syohin_moto.sle_input.setfocus()
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
uo_syohin.event constructor( )

// 複写機能
uo_syohin_moto.event constructor( )
uo_iro_moto.event constructor( )
cb_copy.event constructor( )
cb_zengyo_copy.event constructor( )
cb_ikkatu_copy.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text = l_syori_kbn
ddplb_syori_kbn.event constructor( )

of_dsp_edit( "callsection", true )

of_set_secondfocus( )
//uo_syohin.sle_input.setfocus()

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

update m_syohin
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "商品マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
end subroutine

public function boolean of_record_lock (long p_syohin_code, long p_iro_no, boolean p_lock);
long		l_syohin_code
long 		l_iro_no
string 		l_size_code
long		l_row
datastore	l_dts

l_dts = create datastore
l_dts.dataobject = "dm_syohin_sunpo"
l_dts.settransobject(cocos)

// datastore検索
if l_dts.retrieve( p_syohin_code, p_iro_no ) > 0 then
	for l_row = 1 to l_dts.rowcount()
		l_syohin_code	= l_dts.object.syohin_code[l_row]
		l_iro_no		= l_dts.object.iro_no[l_row]
		l_size_code		= l_dts.object.size_code[l_row]
		
		// 排他処理
		if not of_record_lock( l_syohin_code, l_iro_no, l_size_code, p_lock ) then
			destroy l_dts
			return false
		end if
	next
end if

destroy l_dts

return true

end function

public function boolean of_record_lock (long p_syohin_code, long p_iro_no, string p_size_code, boolean p_lock);string	l_rowid
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
  from m_syohin mm,
       m_user mu,
       m_window mw
 where mm.henkou_user_id	= mu.user_id(+)
   and mm.henkou_pg_id		= mw.window_id(+)
   and mm.syohin_code		= :p_syohin_code
   and mm.syohin_code		= :p_syohin_code
   and mm.iro_no			= :p_iro_no
   and mm.size_code			= :p_size_code
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

on wm_syohin_sunpo.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_list=create dw_list
this.uo_syohin=create uo_syohin
this.uo_syohin_moto=create uo_syohin_moto
this.st_down_arrow=create st_down_arrow
this.cb_copy=create cb_copy
this.st_sunpo_title=create st_sunpo_title
this.cb_zengyo_copy=create cb_zengyo_copy
this.cb_ikkatu_copy=create cb_ikkatu_copy
this.uo_iro_moto=create uo_iro_moto
this.gb_fukusya_moto=create gb_fukusya_moto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.uo_syohin
this.Control[iCurrent+5]=this.uo_syohin_moto
this.Control[iCurrent+6]=this.st_down_arrow
this.Control[iCurrent+7]=this.cb_copy
this.Control[iCurrent+8]=this.st_sunpo_title
this.Control[iCurrent+9]=this.cb_zengyo_copy
this.Control[iCurrent+10]=this.cb_ikkatu_copy
this.Control[iCurrent+11]=this.uo_iro_moto
this.Control[iCurrent+12]=this.gb_fukusya_moto
end on

on wm_syohin_sunpo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_list)
destroy(this.uo_syohin)
destroy(this.uo_syohin_moto)
destroy(this.st_down_arrow)
destroy(this.cb_copy)
destroy(this.st_sunpo_title)
destroy(this.cb_zengyo_copy)
destroy(this.cb_ikkatu_copy)
destroy(this.uo_iro_moto)
destroy(this.gb_fukusya_moto)
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
ddplb_syori_kbn.y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7			// タイトル「+7」

// 2行目
uo_syohin.y			= ddplb_syori_kbn.y  + 89 + code.MGN_UPPER_TATE_GAP		// 2行目「MGN_UPPER_TATE_GAP:11」

// st_second_upper高さ
st_second_upper.height	= uo_syohin.y + uo_syohin.height + code.MGN_UPPER_TATE - st_second_upper.y

// 表示ボタン
cb_retrieve.x			= l_width - cb_retrieve.width - code.MGN_YOKO
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// 複写元グループ
gb_fukusya_moto.x		= code.MGN_YOKO
gb_fukusya_moto.y		= uo_syohin.y + uo_syohin.height + code.MGN_TATE_MIDDLE

// 商品コード
uo_syohin_moto.x 		= gb_fukusya_moto.x + code.MGN_YOKO
uo_syohin_moto.y 		= gb_fukusya_moto.y + code.MGN_TATE_LARGE

// 色番
uo_iro_moto.x 			= gb_fukusya_moto.x + code.MGN_YOKO
uo_iro_moto.y 			= uo_syohin_moto.y + uo_syohin_moto.height + code.MGN_DW_ITEM_TATE

// 複写元グループ高さ、幅	
gb_fukusya_moto.width	= uo_syohin_moto.x + uo_syohin_moto.width + code.MGN_YOKO
gb_fukusya_moto.height	= uo_iro_moto.y + uo_iro_moto.height + ( code.MGN_TATE_MIDDLE + code.MGN_GROUP_TATE ) - gb_fukusya_moto.y
						// 無理やり：「MGN_TATE_MIDDLE：32、code.MGN_GROUP_TATE：8」 

// ↓、複写
st_down_arrow.y			= gb_fukusya_moto.y + gb_fukusya_moto.height + code.MGN_TATE_MIDDLE
cb_copy.y				= st_down_arrow.y

// 寸法情報タイトル
st_sunpo_title.x		= code.MGN_YOKO
st_sunpo_title.y		= cb_copy.y + 89 + code.MGN_TATE	// 

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
string	l_code
string 	l_syori_kbn
long 	l_syohin_code
long 	l_iro_no

// リトリーブ前の事前チェック
// 入力チェック
// 商品コードの入力チェック
if not uo_syohin.sle_input.event input_check() then
	uo_syohin.sle_input.setfocus()
	return -1
end if
if not uo_syohin.event sle_input_check() then
	uo_syohin.sle_input.setfocus()
	return -1
end if

// 色番の入力チェック
if not uo_syohin.sle_input_iro.event input_check() then
	uo_syohin.sle_input_iro.setfocus()
	return -1
end if
if not uo_syohin.event sle_iro_input_check() then
	uo_syohin.sle_input_iro.setfocus()
	return -1
end if

l_syori_kbn		= ddplb_syori_kbn.text
l_syohin_code 	= long( uo_syohin.sle_input.text )
l_iro_no 		= long( uo_syohin.sle_input_iro.text )

// 存在チェック
select count(*)
  into :l_cnt
  from m_syohin
 where syohin_code	= :l_syohin_code
   and iro_no		= :l_iro_no
using cocos;

if cocos.sqlcode = -1 then
	msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
	this.setfocus()
	return -1
end if

if l_cnt = 0 then
	msg.of_error( "該当データが存在しません。この処理は実行できません。" )
	this.setfocus()
	return -1
end if

end event

event retrieve_event;call super::retrieve_event;long	l_row
long	l_loop
long	l_nengetu

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_syohin_code 	= long( uo_syohin.sle_input.text )
i_iro_no 		= long( uo_syohin.sle_input_iro.text )

// 更新部初期化
dw_list.event constructor( )

choose case i_syori_kbn
	case "変更"

		// 排他チェック
		if not of_record_lock( i_syohin_code, i_iro_no, true ) then
			return -1
		end if

		// 検索実行
		if dw_list.retrieve( i_syohin_code, i_iro_no )  = 0 then
			msg.of_error( "入力した商品コード、色番で登録されたデータはありません。" )
			uo_syohin.setfocus()
			uo_syohin.sle_input.setfocus()
			return -1
		end if

	case "照会"
		
		// 検索実行
		if dw_list.retrieve( i_syohin_code, i_iro_no )  = 0 then
			msg.of_error( "入力した商品コード、色番で登録されたデータはありません。" )
			uo_syohin.setfocus()
			uo_syohin.sle_input.setfocus()
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

//dw_list.setfocus()

setredraw( true )


end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	//dw_list.setfocus()
	return -1
end if

setredraw( false )

for l_row = 1 to dw_list.rowcount()

	dw_list.setrow( l_row )

	if dw_list.event itemchanged( l_row, dw_list.object.sunpo_tate, string( dw_list.object.sunpo_tate[l_row] ) ) <> 0 then
		dw_list.setrow( l_row )
		dw_list.setcolumn( "sunpo_tate" )
		dw_list.setfocus()
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.sunpo_yoko, string( dw_list.object.sunpo_yoko[l_row] ) ) <> 0 then
		dw_list.setrow( l_row )
		dw_list.setcolumn( "sunpo_yoko" )
		dw_list.setfocus()
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.sunpo_takasa, string( dw_list.object.sunpo_takasa[l_row] ) ) <> 0 then
		dw_list.setrow( l_row )
		dw_list.setcolumn( "sunpo_takasa" )
		dw_list.setfocus()
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.jyuryo, string( dw_list.object.jyuryo[l_row] ) ) <> 0 then
		dw_list.setrow( l_row )
		dw_list.setcolumn( "jyuryo" )
		dw_list.setfocus()
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.tijimi_ritu, string( dw_list.object.tijimi_ritu[l_row] ) ) <> 0 then
		dw_list.setrow( l_row )
		dw_list.setcolumn( "tijimi_ritu" )
		dw_list.setfocus()
		setredraw( true )
		return -1
	end if
	
next

setredraw( true )

end event

event update_event;call super::update_event;
long		l_row

choose case i_syori_kbn
	case "登録", "変更"
		
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "商品マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return -1
		end if


	case "削除"
	case "照会"
end choose

// ログ出力
of_add_db_log( "update_event", 0, st_title.text + "[" + trim( uo_syohin.sle_input.text ) + " " + trim( uo_syohin.sle_input_iro.text ) + "]" + i_syori_kbn )

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()


end event

type uo_signal from iw_main_window`uo_signal within wm_syohin_sunpo
end type

type st_date from iw_main_window`st_date within wm_syohin_sunpo
end type

type st_user_mei from iw_main_window`st_user_mei within wm_syohin_sunpo
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_syohin_sunpo
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_syohin_sunpo
end type

type st_title from iw_main_window`st_title within wm_syohin_sunpo
end type

type st_title_upper from iw_main_window`st_title_upper within wm_syohin_sunpo
end type

type st_upper from iw_main_window`st_upper within wm_syohin_sunpo
end type

type st_second_upper from iw_main_window`st_second_upper within wm_syohin_sunpo
integer height = 231
boolean sf1_key = true
boolean sf2_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_syohin_sunpo
integer taborder = 30
end type

type st_syori_kbn from ivo_statictext within wm_syohin_sunpo
integer x = 32
integer y = 164
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type ddplb_syori_kbn from sv_ddplb_syori within wm_syohin_sunpo
integer x = 348
integer y = 156
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean visible_touroku = false
boolean visible_sakujyo = false
string init_disp = "変更"
end type

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )

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
		uo_syohin.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_syohin.of_set_dbchk_exst( )
		uo_syohin_moto.of_set_dbchk_exst( )
		uo_iro_moto.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose

end event

type dw_list from ivo_datawindow within wm_syohin_sunpo
integer x = 32
integer y = 928
integer width = 1360
integer height = 825
integer taborder = 50
string dataobject = "dm_syohin_sunpo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean save_excel = false
boolean row_focus_ind = true
end type

event constructor;call super::constructor;
long		l_row
long		l_syohin_code
long 		l_iro_no
string 		l_size_code

if this.rowcount() > 0 then
	
	choose case i_syori_kbn
		case "変更", "削除"		// ここでは「変更」のみ
			for l_row = 1 to this.rowcount()
				l_syohin_code	= this.object.syohin_code[l_row]
				l_iro_no		= this.object.iro_no[l_row]
				l_size_code		= this.object.size_code[l_row]
				
				// ロック解除
				of_record_lock( l_syohin_code, l_iro_no, l_size_code, false )
			next
	end choose
end if

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)

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
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event itemchanged;call super::itemchanged;
choose case dwo.name
	case "sunpo_tate"
		// 0.01～999.00
		if lena( trim( data ) ) = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "縦" ) )
			return 1
		end if

		if not isnumber( trim( data )) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		if double( trim( data )) < 0.01 or double( trim( data )) > 999.00 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：0.01～999.00】" )
			return 1
		end if

	case "sunpo_yoko"
		// 0.01～999.00
		if lena( trim( data ) ) = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "横" ) )
			return 1
		end if

		if not isnumber( trim( data )) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		if double( trim( data )) < 0.01 or double( trim( data )) > 999.00 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：0.01～999.00】" )
			return 1
		end if

	case "sunpo_takasa"
		// 0.01～999.00
		if lena( trim( data ) ) = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "高さ" ) )
			return 1
		end if

		if not isnumber( trim( data )) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		if double( trim( data )) < 0.01 or double( trim( data )) > 999.00 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：0.01～999.00】" )
			return 1
		end if

	case "jyuryo"
		// 1～99999
		if lena( trim( data ) ) = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "重量" ) )
			return 1
		end if

		if not isnumber( trim( data )) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		if double( trim( data )) < 1 or double( trim( data )) > 99999 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：1～99999】" )
			return 1
		end if

	case "tijimi_ritu"
		// 0.01～1.00
		if lena( trim( data ) ) = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "縮み" ) )
			return 1
		end if
		
		if not isnumber( trim( data )) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		if double( trim( data )) < 0.01 or double( trim( data )) > 1.00 then
			msg.of_error_dwo( dwo, "入力値「" + trim( data ) + "」は入力範囲を超えています。~r~n【入力範囲：0.01～1.00】" )
			return 1
		end if

case else
end choose

return 0
end event

event doubleclicked;call super::doubleclicked;
long	l_row
double	l_sunpo_tate
double	l_sunpo_yoko
double	l_sunpo_takasa
double	l_jyuryo
double	l_tijimi_ritu

// 変更以外は処理しない
if i_syori_kbn <> "変更" then
	return
end if

if row > 0 then
	
	// 現在行の値取得
	l_sunpo_tate 	= dw_list.object.sunpo_tate[row]
	l_sunpo_yoko 	= dw_list.object.sunpo_yoko[row]
	l_sunpo_takasa 	= dw_list.object.sunpo_takasa[row]
	l_jyuryo 		= dw_list.object.jyuryo[row]
	l_tijimi_ritu 	= dw_list.object.tijimi_ritu[row]
	
	// 現在行を一括複写
	for l_row = row + 1 to dw_list.rowcount()
		// 全て0の場合
		if	( isnull( dw_list.object.sunpo_tate[l_row] )   or dw_list.object.sunpo_tate[l_row] = 0 ) and & 
			( isnull( dw_list.object.sunpo_yoko[l_row] )   or dw_list.object.sunpo_yoko[l_row] = 0 ) and & 
			( isnull( dw_list.object.sunpo_takasa[l_row] ) or dw_list.object.sunpo_takasa[l_row] = 0 ) and & 
			( isnull( dw_list.object.jyuryo[l_row] )       or dw_list.object.jyuryo[l_row] = 0 ) and & 
			( isnull( dw_list.object.tijimi_ritu[l_row] )  or dw_list.object.tijimi_ritu[l_row] = 0 ) then
		   
			// 値セット
			dw_list.object.sunpo_tate[l_row] 	= l_sunpo_tate
			dw_list.object.sunpo_yoko[l_row] 	= l_sunpo_yoko
			dw_list.object.sunpo_takasa[l_row] = l_sunpo_takasa
			dw_list.object.jyuryo[l_row] 		= l_jyuryo
			dw_list.object.tijimi_ritu[l_row] 	= l_tijimi_ritu
		else
		   exit
		end if
	next

end if

end event

event clicked;call super::clicked;
string	l_columnname

// クリックされたところがヘッダなら、そこを起点にソートをかける
if string( dwo.type ) = "text" and right( string( dwo.name ), 2 ) = "_t" then
	l_columnname	= left( string( dwo.name ), len( string( dwo.name ) ) - 2 )
	of_set_dynamic_sort( l_columnname )
end if

end event

type uo_syohin from cv_input_syohin within wm_syohin_sunpo
string tag = "コード"
integer x = 32
integer y = 256
integer taborder = 20
boolean bringtotop = true
boolean chk_required = true
boolean arrow_visible = false
end type

on uo_syohin.destroy
call cv_input_syohin::destroy
end on

event sle_input_check;call super::sle_input_check;
if ancestorreturnvalue = false then
	return ancestorreturnvalue
end if

string 	l_code
string 	l_syori_kbn

l_code		= trim( this.sle_input.text )
l_syori_kbn	= ddplb_syori_kbn.text

// 終息チェック
if l_syori_kbn <> "照会" then
	if uo_syohin.of_get_syusoku_flg() = 1 then
		of_reset( "meisyobikou" )
		msg.of_error_sle( this.sle_input, fnc.strg.of_format( "終息設定された商品は照会のみ可能です。", this.tag ) )
		this.sle_input.setfocus()
		return false
	end if
end if

return true

end event

event constructor;call super::constructor;
this.enabled = true

setnull( i_syohin_code )

end event

type uo_syohin_moto from cv_input_syohin within wm_syohin_sunpo
string tag = "商品コード"
integer x = 64
integer y = 462
integer taborder = 40
boolean bringtotop = true
boolean f6_key = true
string title_text = "商品コード"
boolean bikou_visible = false
boolean input_iro_visible = false
boolean arrow_visible = false
boolean iro_mei_visible = false
boolean syusoku_hyoji = false
end type

on uo_syohin_moto.destroy
call cv_input_syohin::destroy
end on

event constructor;call super::constructor;
this.enabled = false

end event

event getfocuses;call super::getfocuses;

if dw_list.rowcount() > 0 then
	this.sle_input.of_set_fnkey( keyf6!, true )
else
	this.sle_input.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		this.sle_input.of_set_fnkey( keyf12!, true )
		return 0
end choose

this.sle_input.of_set_fnkey( keyf12!, false )

return 0
end event

type st_down_arrow from ivo_statictext within wm_syohin_sunpo
integer x = 560
integer y = 732
integer width = 96
boolean bringtotop = true
string text = "↓"
alignment alignment = center!
end type

type cb_copy from ivo_commandbutton within wm_syohin_sunpo
integer x = 700
integer y = 732
boolean bringtotop = true
string text = "複写"
boolean space_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

this.enabled			= false

end event

event execution;call super::execution;
if ancestorreturnvalue <> 0 then
	return ancestorreturnvalue
end if

long		l_row
long		l_row2
long 		l_syohin_code
long 		l_iro_no
long 		l_size_iti
string 		l_size_mei
nv_master	mst
str_msyohin l_syohin[]

// 照会の場合は処理しない
if i_syori_kbn = "照会" then
	return
end if

// 画面に行がない場合は処理しない
if dw_list.rowcount() = 0 then
	return
end if

// 複写元チェック
// 商品コードの入力チェック
if len( trim( uo_syohin_moto.sle_input.text ) ) = 0 then
	msg.of_error_sle( uo_syohin_moto.sle_input, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", uo_syohin_moto.tag ) )
	uo_syohin_moto.sle_input.setfocus()
	return -1
else
	if not uo_syohin_moto.sle_input.event input_check() then
		return -1
	end if
end if

// 色番の入力チェック
if len( trim( uo_iro_moto.sle_input.text ) ) = 0 then
	msg.of_error_sle( uo_iro_moto.sle_input, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", uo_iro_moto.tag ) )
	uo_iro_moto.sle_input.setfocus()
	return -1
else
	if not uo_iro_moto.sle_input.event input_check() then
		return -1
	end if
end if

// 複写元
l_syohin_code 	= long( uo_syohin_moto.sle_input.text )
l_iro_no 		= long( uo_iro_moto.sle_input.text )

if mst.of_syohin_get_full( l_syohin_code, l_iro_no, l_syohin ) > 0 then

	// 複写元データをセット
	for l_row = 1 to dw_list.rowcount()
		l_size_iti = dw_list.object.size_iti[l_row]
		l_size_mei = dw_list.object.size_mei[l_row]
		
		// サイズ位置とサイズ名が同じ場合は値をセット
		for l_row2 = 1 to upperbound( l_syohin )
			if l_syohin[l_row2].size_iti         = l_size_iti and & 
			   trim( l_syohin[l_row2].size_mei ) = trim( l_size_mei ) then
				dw_list.object.sunpo_tate[l_row] 	= l_syohin[l_row2].sunpo_tate
				dw_list.object.sunpo_yoko[l_row] 	= l_syohin[l_row2].sunpo_yoko
				dw_list.object.sunpo_takasa[l_row] 	= l_syohin[l_row2].sunpo_takasa
				dw_list.object.jyuryo[l_row] 		= l_syohin[l_row2].jyuryo
				dw_list.object.tijimi_ritu[l_row] 	= l_syohin[l_row2].tijimi_ritu
				exit
			end if
		next
	next
end if

l_row = long( dw_list.object.datawindow.firstrowonpage )
if l_row > 0 then
	dw_list.setrow( l_row )
	dw_list.setcolumn( "sunpo_tate" )
	dw_list.setfocus()
end if

end event

type st_sunpo_title from ivo_statictext within wm_syohin_sunpo
integer x = 32
integer y = 843
integer width = 408
boolean bringtotop = true
string text = "●寸法情報"
end type

type cb_zengyo_copy from ivo_commandbutton within wm_syohin_sunpo
integer x = 692
integer y = 1774
boolean bringtotop = true
string text = "前行複写"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

this.enabled			= false


end event

event execution;call super::execution;
long	l_row

// 照会の場合は処理しない
if i_syori_kbn = "照会" then
	return
end if

// 画面に行がない場合は処理しない
if dw_list.rowcount() = 0 then
	return
end if

// 現在の行が1行以下の場合は処理しない
l_row = dw_list.getrow()
if l_row <= 1 then
	return
end if

// 前行を複写
dw_list.object.sunpo_tate[l_row] 	= dw_list.object.sunpo_tate[l_row - 1]
dw_list.object.sunpo_yoko[l_row] 	= dw_list.object.sunpo_yoko[l_row - 1]
dw_list.object.sunpo_takasa[l_row] 	= dw_list.object.sunpo_takasa[l_row - 1]
dw_list.object.jyuryo[l_row] 		= dw_list.object.jyuryo[l_row - 1]
dw_list.object.tijimi_ritu[l_row] 	= dw_list.object.tijimi_ritu[l_row - 1]

dw_list.setrow( l_row )
dw_list.setcolumn( "sunpo_tate" )
dw_list.setfocus()


end event

type cb_ikkatu_copy from ivo_commandbutton within wm_syohin_sunpo
integer x = 1056
integer y = 1774
boolean bringtotop = true
string text = "一括複写"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

this.enabled			= false

end event

event execution;call super::execution;
long	l_row
long	l_row2
double	l_sunpo_tate
double	l_sunpo_yoko
double	l_sunpo_takasa
double	l_jyuryo
double	l_tijimi_ritu

// 照会の場合は処理しない
if i_syori_kbn = "照会" then
	return
end if

// 画面に行がない場合は処理しない
if dw_list.rowcount() = 0 then
	return
end if

l_row = dw_list.getrow()
if l_row < 1 then
	return
end if

// 現在行の値取得
l_sunpo_tate 	= dw_list.object.sunpo_tate[l_row]
l_sunpo_yoko 	= dw_list.object.sunpo_yoko[l_row]
l_sunpo_takasa 	= dw_list.object.sunpo_takasa[l_row]
l_jyuryo 		= dw_list.object.jyuryo[l_row]
l_tijimi_ritu 	= dw_list.object.tijimi_ritu[l_row]

// 現在行を一括複写
for l_row2 = l_row + 1 to dw_list.rowcount()
	// 全て0の場合
	if	( isnull( dw_list.object.sunpo_tate[l_row2] )   or dw_list.object.sunpo_tate[l_row2] = 0 ) and & 
	 	( isnull( dw_list.object.sunpo_yoko[l_row2] )   or dw_list.object.sunpo_yoko[l_row2] = 0 ) and & 
		( isnull( dw_list.object.sunpo_takasa[l_row2] ) or dw_list.object.sunpo_takasa[l_row2] = 0 ) and & 
		( isnull( dw_list.object.jyuryo[l_row2] )       or dw_list.object.jyuryo[l_row2] = 0 ) and & 
		( isnull( dw_list.object.tijimi_ritu[l_row2] )  or dw_list.object.tijimi_ritu[l_row2] = 0 ) then
	   
	   	// 値セット
		dw_list.object.sunpo_tate[l_row2] 	= l_sunpo_tate
		dw_list.object.sunpo_yoko[l_row2] 	= l_sunpo_yoko
		dw_list.object.sunpo_takasa[l_row2] = l_sunpo_takasa
		dw_list.object.jyuryo[l_row2] 		= l_jyuryo
		dw_list.object.tijimi_ritu[l_row2] 	= l_tijimi_ritu
	else
	   exit
	end if
next

dw_list.setrow( l_row )
dw_list.setcolumn( "sunpo_tate" )
dw_list.setfocus()

end event

type uo_iro_moto from cv_input within wm_syohin_sunpo
string tag = "色番"
integer x = 64
integer y = 569
integer taborder = 41
boolean bringtotop = true
string title_text = "色番"
end type

on uo_iro_moto.destroy
call cv_input::destroy
end on

event constructor;call super::constructor;
// 初期化処理
this.of_reset( "all" )

this.enabled = false

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_msyohin	l_mdl_syohin

// モーダルを開く
l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )

if upperbound( l_mdl_syohin.ret ) > 0 then
	// 商品コードをセット
	uo_syohin_moto.of_set_input( string( l_mdl_syohin.ret[1].syohin_code ))
	uo_syohin_moto.sle_input.event input_check()
	
	// 名称のセット
	this.of_set_input( string( l_mdl_syohin.ret[1].iro_no ))
	this.of_set_meisyo( l_mdl_syohin.ret[1].iro_mei )
end if

return true

end event

event sle_input_check;call super::sle_input_check;
string		l_input
long		l_syohin_code, l_iro_no
str_msyohin	l_syohin[]

// 商品コード未入力時は抜ける
if upperbound( uo_syohin_moto.i_para_syohin ) = 0 then
	// 未入力チェックは複写ボタン押下時にする
	/*
	this.sle_input.of_msg_error( "商品コードが入力されていません。" )
	of_reset( "meisyobikou" )	// 備考も消す
	uo_syohin_moto.sle_input.setfocus()
	
	return false
	*/
	return true		// 商品コード未入力時は抜ける
end if

l_input			= trim( this.of_get_input( ) )
l_syohin_code	= uo_syohin_moto.i_para_syohin[1].syohin_code	// uo_syohinの商品コードを取得

if len( l_input ) > 0 then
	l_iro_no	= long( l_input )
	
	// データ取得と存在チェック
	if mst.of_syohin_get( l_syohin_code, l_iro_no, l_syohin ) > 0 then
		// 名称のセット
		of_set_meisyo( string( l_syohin[1].iro_mei ) )
	else
		sle_input.of_msg_error( "入力された色番はマスタに存在しません。" )
		of_reset( "meisyobikou" )	// 備考も消す
		sle_input.setfocus()
		
		return false
	end if
else
	of_reset( "meisyobikou" )	// 備考も消す
	return false
end if

return true
end event

event getfocuses;call super::getfocuses;

if dw_list.rowcount() > 0 then
	this.sle_input.of_set_fnkey( keyf6!, true )
else
	this.sle_input.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		this.sle_input.of_set_fnkey( keyf12!, true )
		return 0
end choose

this.sle_input.of_set_fnkey( keyf12!, false )

return 0
end event

type gb_fukusya_moto from ivo_groupbox within wm_syohin_sunpo
integer x = 32
integer y = 398
integer width = 3336
integer height = 302
boolean bringtotop = false
string text = "複写元"
end type

