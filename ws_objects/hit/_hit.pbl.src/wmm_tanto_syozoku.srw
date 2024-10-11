$PBExportHeader$wmm_tanto_syozoku.srw
$PBExportComments$営業担当者所属登録
forward
global type wmm_tanto_syozoku from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_tanto_syozoku
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanto_syozoku
end type
type st_bumon from ivo_statictext within wmm_tanto_syozoku
end type
type st_bumon_code from ivo_statictext within wmm_tanto_syozoku
end type
type st_bumon_mei from ivo_statictext within wmm_tanto_syozoku
end type
type st_eigyo from ivo_statictext within wmm_tanto_syozoku
end type
type st_eigyosyo_code from ivo_statictext within wmm_tanto_syozoku
end type
type st_eigyosyo_mei from ivo_statictext within wmm_tanto_syozoku
end type
type st_ka from ivo_statictext within wmm_tanto_syozoku
end type
type st_ka_code from ivo_statictext within wmm_tanto_syozoku
end type
type st_ka_mei from ivo_statictext within wmm_tanto_syozoku
end type
type dw_list from ivo_datawindow within wmm_tanto_syozoku
end type
type st_memo from ivo_statictext within wmm_tanto_syozoku
end type
type st_right_arrow from ivo_statictext within wmm_tanto_syozoku
end type
type cb_copy from ivo_commandbutton within wmm_tanto_syozoku
end type
type cb_clear from ivo_commandbutton within wmm_tanto_syozoku
end type
type uo_nendo from sv_ddplb_nendo within wmm_tanto_syozoku
end type
type uo_bumon from cv_input_meisyo within wmm_tanto_syozoku
end type
type uo_eigyo from cv_input_meisyo within wmm_tanto_syozoku
end type
type uo_ka from cv_input_meisyo within wmm_tanto_syozoku
end type
type uo_tanto from cv_input_tanto within wmm_tanto_syozoku
end type
end forward

global type wmm_tanto_syozoku from iw_main_window
string title = "営業担当者所属登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
st_bumon st_bumon
st_bumon_code st_bumon_code
st_bumon_mei st_bumon_mei
st_eigyo st_eigyo
st_eigyosyo_code st_eigyosyo_code
st_eigyosyo_mei st_eigyosyo_mei
st_ka st_ka
st_ka_code st_ka_code
st_ka_mei st_ka_mei
dw_list dw_list
st_memo st_memo
st_right_arrow st_right_arrow
cb_copy cb_copy
cb_clear cb_clear
uo_nendo uo_nendo
uo_bumon uo_bumon
uo_eigyo uo_eigyo
uo_ka uo_ka
uo_tanto uo_tanto
end type
global wmm_tanto_syozoku wmm_tanto_syozoku

type variables
	private:

	// 呼出し部の情報を保管
	string	i_syori_kbn
	long	i_tanto_code
	long	i_nengetu_from, i_nengetu_to
	long	i_nendo_code
	string	i_nendo_mei_now
end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock (long p_tanto_code, long p_nengetu, boolean p_lock)
public function boolean of_record_lock (long p_tanto_code, long p_nengetu_from, long p_nengetu_to, boolean p_lock)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public subroutine of_dsp_open ()
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		uo_tanto.of_set_enabled( p_enabled )
		uo_nendo.enabled		= p_enabled
		uo_nendo.ddplb_nendo.enabled		= p_enabled
		cb_retrieve.enabled		= p_enabled

	case "dw_list"

		l_row	= long( dw_list.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_list.setrow( l_row )
			dw_list.setcolumn( "bumon_code" )
			dw_list.setfocus()
			// 一括入力系
			uo_bumon.of_set_enabled( p_enabled )
			uo_eigyo.of_set_enabled( p_enabled )
			uo_ka.of_set_enabled( p_enabled )
			cb_copy.enabled				= p_enabled
			cb_clear.enabled			= p_enabled
			
		else
			msg.of_error( "編集可能な行がありません。" )
		end if

end choose

end subroutine

public subroutine of_dsp_reset ();string	l_syori_kbn
long	l_indx
string	l_nendo_mei


l_syori_kbn	= i_syori_kbn

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )

uo_tanto.event constructor( )
//uo_tanto.of_set_enabled( true )

uo_nendo.event constructor( )

cb_retrieve.event constructor( )

uo_bumon.event constructor( )
uo_eigyo.event constructor( )
uo_ka.event constructor( )

cb_copy.event constructor( )
cb_clear.event constructor( )

// 年度に初期値セット
select mn.nendo_code,mn.nendo_mei
  into :i_nendo_code,:l_nendo_mei
  from m_kihon mk,
       m_nendo mn
 where mk.kanri_code	= 0
   and mk.jigyo_nendo	= mn.nendo_code(+)
using cocos;

choose case cocos.sqlcode
	case 0
		l_indx	= uo_nendo.ddplb_nendo.SelectItem(l_nendo_mei, 0 )
		uo_nendo.ddplb_nendo.event selectionchanged(l_indx)
	case 100
		msg.of_error( "マスタに存在しません。" )
	case else
		msg.of_error_db( "入力チェック中にエラーが発生しました。", cocos )
end choose

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
//integer	l_haita_flg
//
//if p_lock then
//	l_haita_flg	= 1
//else
//	l_haita_flg	= 0
//end if
//
////update m_syozoku
////   set haita_flg			= :l_haita_flg,
////       henkou_date			= sysdate,
////       henkou_user_id		= :user.user_id,
////       henkou_client_id		= :device.name,
////       henkou_pg_id			= :i_pg_id
//// where rowid				= :p_rowid
////using cocos;
//
//update m_syozoku
//   set haita_flg			= :l_haita_flg,
//       kousin_date			= sysdate,
//       kousin_user_id		= :user.user_id,
//       kousin_client_id		= :device.name,
//       kousin_pg_id			= :i_pg_id
// where rowid				= :p_rowid
//using cocos;
//
//if cocos.sqlcode <> 0 then
//	rollback using cocos;
//	msg.of_error_db( "担当者所属マスタのレコードロックでエラーが発生しました。", cocos )
//	return false
//else
//	commit using cocos;
//	uo_signal.of_on_signal( p_lock )
//end if
//
return true
end function

public function boolean of_record_lock (long p_tanto_code, long p_nengetu, boolean p_lock);
return true


//string	l_rowid
//string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
//string	l_user_mei,l_window_mei
//integer	l_haita_flg
//
//select mm.rowid,mm.haita_flg,
//       nvl( to_char( mm.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
//       nvl( mm.henkou_user_id, '???' ),
//       nvl( mu.user_mei, '???' ),
//       nvl( mm.henkou_client_id, '???' ),
//       nvl( mm.henkou_pg_id, '???' ),
//       nvl( mw.window_name, '???' )
//  into :l_rowid,:l_haita_flg,
//       :l_henkou_date,
//       :l_henkou_user_id,:l_user_mei,
//       :l_henkou_client_id,
//       :l_henkou_pg_id,:l_window_mei
//  from m_syozoku mm,
//       m_user mu,
//       m_window mw
// where mm.henkou_user_id	= mu.user_id(+)
//   and mm.henkou_pg_id		= mw.window_id(+)
//   and mm.tanto_code		= :p_tanto_code
//   and mm.nengetu			= :p_nengetu
//   for update
//using cocos;
//
//choose case cocos.sqlcode
//	case 0
//		if l_henkou_user_id <> user.user_id then
//			if l_haita_flg <> 0 then
//				rollback using cocos;
//				msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
//				return false
//			end if
//		end if
//
//		// commitはこっちで行う
//		return of_record_lock_rowid( l_rowid, p_lock )
//	case 100
//		rollback using cocos;
//		msg.of_error( "対象レコードが存在しません。" )
//	case else
//		rollback using cocos;
//		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
//		return false
//end choose
//
//return false
//
end function

public function boolean of_record_lock (long p_tanto_code, long p_nengetu_from, long p_nengetu_to, boolean p_lock);
//long		l_nengetu
//long		l_row
//datastore	l_dts
//
//
//l_dts = create datastore
//l_dts.dataobject = "dmm_tanto_syozoku"
//l_dts.settransobject(cocos)
//
//// datastore検索
//if l_dts.retrieve( p_tanto_code, p_nengetu_from, p_nengetu_to ) > 0 then
//	for l_row = 1 to l_dts.rowcount()
//		l_nengetu	= l_dts.object.nengetu[l_row]
//		// 排他処理
//		if not of_record_lock( p_tanto_code, l_nengetu, p_lock ) then
//			destroy l_dts
//			return false
//		end if
//	next
//end if
//
//destroy l_dts


return true

end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装あり

// 参照設定
str_mdlpara_mmeisyo	l_mdl_meisyo

// F8:参照
choose case p_dwo.name
	case "bumon_code"
		// 部門
		l_mdl_meisyo.in_meisyo_kbn	= 21
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.bumon_code[p_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			p_dw.object.bumon_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
		end if
		
	case "eigyosyo_code"
		// 営業所
		l_mdl_meisyo.in_meisyo_kbn	= 22
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.eigyosyo_code[p_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			p_dw.object.eigyosho_mei[p_row]		= l_mdl_meisyo.ret[1].meisyo_1
		end if
	case "ka_code"
		// 課
		l_mdl_meisyo.in_meisyo_kbn	= 23
		l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
		if upperbound( l_mdl_meisyo.ret ) > 0 then
			p_dw.object.ka_code[p_row]	= dec( l_mdl_meisyo.ret[1].meisyo_code )
			p_dw.object.ka_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
		end if

end choose


end subroutine

public subroutine of_dsp_open ();
long	l_indx
string	l_nendo_mei

// 年度に初期値セット
select mn.nendo_code,mn.nendo_mei
  into :i_nendo_code,:i_nendo_mei_now
  from m_kihon mk,
       m_nendo mn
 where mk.kanri_code	= 0
   and mk.jigyo_nendo	= mn.nendo_code(+)
using cocos;

choose case cocos.sqlcode
	case 0
		l_indx	= uo_nendo.ddplb_nendo.SelectItem(i_nendo_mei_now, 0 )
		uo_nendo.ddplb_nendo.event selectionchanged(l_indx)
	case 100
		msg.of_error( "マスタに存在しません。" )
	case else
		msg.of_error_db( "入力チェック中にエラーが発生しました。", cocos )
end choose

of_set_secondfocus( )

end subroutine

on wmm_tanto_syozoku.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_bumon=create st_bumon
this.st_bumon_code=create st_bumon_code
this.st_bumon_mei=create st_bumon_mei
this.st_eigyo=create st_eigyo
this.st_eigyosyo_code=create st_eigyosyo_code
this.st_eigyosyo_mei=create st_eigyosyo_mei
this.st_ka=create st_ka
this.st_ka_code=create st_ka_code
this.st_ka_mei=create st_ka_mei
this.dw_list=create dw_list
this.st_memo=create st_memo
this.st_right_arrow=create st_right_arrow
this.cb_copy=create cb_copy
this.cb_clear=create cb_clear
this.uo_nendo=create uo_nendo
this.uo_bumon=create uo_bumon
this.uo_eigyo=create uo_eigyo
this.uo_ka=create uo_ka
this.uo_tanto=create uo_tanto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.st_bumon
this.Control[iCurrent+4]=this.st_bumon_code
this.Control[iCurrent+5]=this.st_bumon_mei
this.Control[iCurrent+6]=this.st_eigyo
this.Control[iCurrent+7]=this.st_eigyosyo_code
this.Control[iCurrent+8]=this.st_eigyosyo_mei
this.Control[iCurrent+9]=this.st_ka
this.Control[iCurrent+10]=this.st_ka_code
this.Control[iCurrent+11]=this.st_ka_mei
this.Control[iCurrent+12]=this.dw_list
this.Control[iCurrent+13]=this.st_memo
this.Control[iCurrent+14]=this.st_right_arrow
this.Control[iCurrent+15]=this.cb_copy
this.Control[iCurrent+16]=this.cb_clear
this.Control[iCurrent+17]=this.uo_nendo
this.Control[iCurrent+18]=this.uo_bumon
this.Control[iCurrent+19]=this.uo_eigyo
this.Control[iCurrent+20]=this.uo_ka
this.Control[iCurrent+21]=this.uo_tanto
end on

on wmm_tanto_syozoku.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.st_bumon)
destroy(this.st_bumon_code)
destroy(this.st_bumon_mei)
destroy(this.st_eigyo)
destroy(this.st_eigyosyo_code)
destroy(this.st_eigyosyo_mei)
destroy(this.st_ka)
destroy(this.st_ka_code)
destroy(this.st_ka_mei)
destroy(this.dw_list)
destroy(this.st_memo)
destroy(this.st_right_arrow)
destroy(this.cb_copy)
destroy(this.cb_clear)
destroy(this.uo_nendo)
destroy(this.uo_bumon)
destroy(this.uo_eigyo)
destroy(this.uo_ka)
destroy(this.uo_tanto)
end on

event resize;call super::resize;// 1段目ボタン(Height:85) Y座標：156
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
st_bumon.y			= uo_tanto.y + 7		// タイトル「+7」
st_eigyo.y			= uo_tanto.y + 7		// タイトル「+7」
st_ka.y				= uo_tanto.y + 7		// タイトル「+7」
st_bumon_code.y		= uo_tanto.y + 3		// 表示テキスト「+3」
st_bumon_mei.y		= uo_tanto.y + 3		// 表示テキスト「+3」
st_eigyosyo_code.y	= uo_tanto.y + 3		// 表示テキスト「+3」
st_eigyosyo_mei.y	= uo_tanto.y + 3		// 表示テキスト「+3」
st_ka_code.y		= uo_tanto.y + 3		// 表示テキスト「+3」
st_ka_mei.y			= uo_tanto.y + 3		// 表示テキスト「+3」
// 3行目
uo_nendo.y			= uo_tanto.y + uo_tanto.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
// st_second_upper高さ
st_second_upper.height	= uo_nendo.y + uo_nendo.height + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// フッター
uo_bumon.y			= key_fnc.y - code.MGN_TATE - uo_bumon.height
uo_eigyo.y			= uo_bumon.y
uo_ka.y				= uo_bumon.y
cb_copy.y			= uo_bumon.y
cb_clear.y			= uo_bumon.y
st_right_arrow.y	= uo_bumon.y

st_memo.x			= code.MGN_YOKO
st_memo.y			= uo_bumon.y - code.MGN_TATE - st_memo.height

// dw
dw_list.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= st_memo.y - code.MGN_TATE - dw_list.y


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

event key_f12;call super::key_f12;if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event open;call super::open;
// 年度初期値セット
of_dsp_open()
// 初期表示
of_set_firstfocus( )


end event

event key_f09;call super::key_f09;// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event retrieve_check;call super::retrieve_check;
long	l_cnt

i_syori_kbn		= ddplb_syori_kbn.text


// リトリーブ前の事前チェック
// 入力チェック
if not uo_tanto.event sle_input_check( ) then
	return -1
end if

// 年度の入力チェック
if not uo_nendo.ddplb_nendo.event input_check() then
	return -1
end if

i_syori_kbn		= ddplb_syori_kbn.text
i_tanto_code	= long( uo_tanto.of_get_input() )
i_nengetu_from	= long( left( uo_nendo.st_meisyo_kisyo.text, 4 ) + right( uo_nendo.st_meisyo_kisyo.text, 2 ) )
i_nengetu_to	= long( left( uo_nendo.st_meisyo_kimatu.text, 4 ) + right( uo_nendo.st_meisyo_kimatu.text, 2 ) )

if i_nengetu_from = 0 or i_nengetu_to = 0 then
	msg.of_error( "年度情報の開始年月、終了年月が取得出来ません。" )
	return -1
end if

// 照会以外は過去年度の変更不可
if i_syori_kbn <> "照会" then
	if uo_nendo.ddplb_nendo.text < i_nendo_mei_now then
		msg.of_error( "過去のデータは修正出来ません。" )
		return -1
	end if
end if

// 存在チェック
select count('x')
  into :l_cnt
  from m_syozoku
 where tanto_code	= :i_tanto_code
   and nengetu		between :i_nengetu_from and :i_nengetu_to
using cocos;

if cocos.sqlcode = -1 then
	msg.of_error_db( "入力チェック中にエラーが発生しました", cocos )
	this.setfocus()
	return -1
end if

if i_syori_kbn = "登録" then
	if l_cnt <> 0 then
		msg.of_error( "該当データが存在します。この処理は実行できません。" )
		this.setfocus()
		return -1
	end if
end if



end event

event retrieve_event;call super::retrieve_event;long	l_row
long	l_loop
long	l_nengetu
long	l_nendo_code


// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_tanto_code	= long( uo_tanto.of_get_input() )
//i_nengetu_from	= long( left( uo_nendo.st_meisyo_kisyo.text, 4 ) + right( uo_nendo.st_meisyo_kisyo.text, 2 ) )
//i_nengetu_to	= long( left( uo_nendo.st_meisyo_kimatu.text, 4 ) + right( uo_nendo.st_meisyo_kimatu.text, 2 ) )
i_nengetu_from	= long( fnc.strg.of_replace(  uo_nendo.st_meisyo_kisyo.text, "/", "" ) )
i_nengetu_to	= long( fnc.strg.of_replace(  uo_nendo.st_meisyo_kimatu.text, "/", "" ) )


//setredraw( false )

// 更新部初期化
dw_list.event constructor( )

choose case i_syori_kbn
	case "登録"

		setredraw( false )
		
		// 登録の場合行追加
		select months_between( :i_nengetu_to ||'01', :i_nengetu_from ||'01' )
		  into :l_loop
		  from dual
		using cocos ;
		
		l_nengetu	= i_nengetu_from
		l_loop		= l_loop + 1
		
		for l_row = 1 to l_loop
			dw_list.insertrow(0)
			dw_list.object.tanto_code[l_row]	= i_tanto_code
			dw_list.object.tanto_mei[l_row]		= uo_tanto.of_get_tanto_mei()
			dw_list.object.nengetu[l_row]		= l_nengetu
			dw_list.object.nen[l_row]			= long( left( string( l_nengetu ), 4 ) )
			dw_list.object.tuki[l_row]			= long( right( string( l_nengetu ), 2 ) )
			dw_list.object.tuki_dsp[l_row]		= string( long( right( string( l_nengetu ), 2 ) ) ) + "月"
			dw_list.object.bumon_code[l_row]	= long( st_bumon_code.text )
			dw_list.object.bumon_mei[l_row]		= st_bumon_mei.text
			dw_list.object.eigyosyo_code[l_row]	= long( st_eigyosyo_code.text )
			dw_list.object.eigyosho_mei[l_row]	= st_eigyosyo_mei.text
			dw_list.object.ka_code[l_row]		= long( st_ka_code.text )
			dw_list.object.ka_mei[l_row]		= st_ka_mei.text
			// 次年月取得
			select to_number( to_char( add_months( ( :l_nengetu )||'01', 1 ), 'YYYYMM' ) )
			  into :l_nengetu
			  from dual
			using cocos ;
		next
		
		setredraw( true )

	case "変更", "削除"

		// 排他チェック
		if not of_record_lock( i_tanto_code, i_nengetu_from, i_nengetu_to, true ) then
//			setredraw( true )
			return -1
		end if

		// 検索実行
		if dw_list.retrieve( i_tanto_code, i_nengetu_from, i_nengetu_to )  = 0 then
			msg.of_error( "入力した担当者、年度で登録されたデータはありません。" )
			uo_tanto.setfocus()
			return -1
		end if

	case "照会"
		// 検索実行
		if dw_list.retrieve( i_tanto_code, i_nengetu_from, i_nengetu_to )  = 0 then
			msg.of_error( "入力した担当者、年度で登録されたデータはありません。" )
			uo_tanto.setfocus()
			return -1
		end if
		
end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
	of_dsp_edit( "dw_list", true )
else
	of_dsp_edit( "callsection", true )
	of_dsp_edit( "dw_list", false )
end if

dw_list.setfocus()


end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

setredraw( false )

for l_row = 1 to dw_list.rowcount()

	dw_list.setrow( l_row )

	if dw_list.event itemchanged( l_row, dw_list.object.bumon_code, string( dw_list.object.bumon_code[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.eigyosyo_code, string( dw_list.object.eigyosyo_code[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.ka_code, string( dw_list.object.ka_code[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.uriage_mokuhyo, string( dw_list.object.uriage_mokuhyo[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.arari_mokuhyo, string( dw_list.object.arari_mokuhyo[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
next

setredraw( true )

end event

event update_event;call super::update_event;
long		l_row
long		l_count

choose case i_syori_kbn
	case "登録", "変更"

		setredraw( false )

		// 単位戻し
		for l_row = 1 to dw_list.rowcount()
			dw_list.object.uriage_mokuhyo[l_row]	= dec( dw_list.object.uriage_mokuhyo[l_row] ) * 1000
			dw_list.object.arari_mokuhyo[l_row]		= dec( dw_list.object.arari_mokuhyo[l_row] ) * 1000
		next

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error_db( "営業担当者所属マスタの登録処理でエラーが発生しました。", cocos )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			setredraw( true )
			return -1
		end if

		setredraw( true )

	case "削除"

		setredraw( false )

		//行の削除
		l_count = dw_list.rowcount()
		for l_row = 1 to l_count
			dw_list.deleterow(1)
		next
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error_db( "営業担当者所属マスタの削除処理でエラーが発生しました。", cocos )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			setredraw( true )
			return -1
		end if

		setredraw( true )

	case "照会"
end choose

// ログ出力
of_add_db_log( "update_event", 0, st_title.text + "[" + trim( uo_tanto.of_get_input() ) + " " + trim( uo_tanto.of_get_tanto_mei() ) + " " + trim( uo_nendo.ddplb_nendo.text ) + "]" + i_syori_kbn )
		
msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()


end event

type uo_signal from iw_main_window`uo_signal within wmm_tanto_syozoku
end type

type st_date from iw_main_window`st_date within wmm_tanto_syozoku
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tanto_syozoku
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tanto_syozoku
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tanto_syozoku
end type

type st_title from iw_main_window`st_title within wmm_tanto_syozoku
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tanto_syozoku
end type

type st_upper from iw_main_window`st_upper within wmm_tanto_syozoku
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tanto_syozoku
integer height = 345
boolean sf1_key = true
boolean sf2_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tanto_syozoku
integer y = 359
integer taborder = 40
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type st_syori_kbn from ivo_statictext within wmm_tanto_syozoku
integer x = 36
integer y = 160
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tanto_syozoku
integer x = 348
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;
this.enabled			= true

setnull( i_syori_kbn )
end event

type st_bumon from ivo_statictext within wmm_tanto_syozoku
integer x = 1664
integer y = 263
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "現所属"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type st_bumon_code from ivo_statictext within wmm_tanto_syozoku
integer x = 1928
integer y = 260
integer width = 88
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean righttoleft = true
boolean sf1_key = true
boolean sf2_key = true
end type

type st_bumon_mei from ivo_statictext within wmm_tanto_syozoku
integer x = 2032
integer y = 260
integer width = 488
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean sf1_key = true
boolean sf2_key = true
end type

type st_eigyo from ivo_statictext within wmm_tanto_syozoku
integer x = 2536
integer y = 263
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "営業所"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type st_eigyosyo_code from ivo_statictext within wmm_tanto_syozoku
integer x = 2800
integer y = 260
integer width = 88
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean righttoleft = true
boolean sf1_key = true
boolean sf2_key = true
end type

type st_eigyosyo_mei from ivo_statictext within wmm_tanto_syozoku
integer x = 2904
integer y = 260
integer width = 488
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean sf1_key = true
boolean sf2_key = true
end type

type st_ka from ivo_statictext within wmm_tanto_syozoku
integer x = 3408
integer y = 263
integer width = 88
boolean bringtotop = true
long backcolor = 12632256
string text = "課"
alignment alignment = right!
boolean sf1_key = true
boolean sf2_key = true
end type

type st_ka_code from ivo_statictext within wmm_tanto_syozoku
integer x = 3512
integer y = 260
integer width = 128
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean righttoleft = true
boolean sf1_key = true
boolean sf2_key = true
end type

type st_ka_mei from ivo_statictext within wmm_tanto_syozoku
integer x = 3656
integer y = 260
integer width = 488
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
boolean sf1_key = true
boolean sf2_key = true
end type

type dw_list from ivo_datawindow within wmm_tanto_syozoku
integer y = 494
integer width = 5120
integer height = 754
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_tanto_syozoku"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f5_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean row_focus_ind = true
end type

event constructor;call super::constructor;
long		l_row
long		l_tanto_code
long		l_nengetu

if this.rowcount() > 0 then
	
	choose case i_syori_kbn
		case "変更", "削除"
			for l_row = 1 to this.rowcount()
				l_tanto_code	= this.object.tanto_code[l_row]
				l_nengetu		= this.object.nengetu[l_row]
				// ロック解除
				of_record_lock( l_tanto_code, l_nengetu, false )
			next
	end choose
end if

this.i_function_name	= { "全選択", "", "", "", "Excel出力", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf1!, true )
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf1!, false )
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "営業担当者所属マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event key_f01;call super::key_f01;
// 全選択

integer	l_mode
integer	l_row, l_rowcnt, l_chkcnt

l_rowcnt	= dw_list.rowcount()
l_chkcnt	= long( dw_list.describe( "evaluate( 'sum( chk )', 0 )" ) )

if l_rowcnt = l_chkcnt then
	// 全選択状態なので選択解除
	l_mode	= 0
else
	// 未選択もしくは一部選択状態なので全選択
	l_mode	= 1
end if

for l_row = 1 to dw_list.rowcount()
	dw_list.object.chk[l_row]	= l_mode
next

return 0

end event

event itemchanged;call super::itemchanged;
decimal	l_uriage
decimal	l_arari
decimal	l_arari_ritu

string	l_column_type
decimal	l_column_length

long	l_code
string	l_mei

string	l_input
string	l_colnm
string	l_tableid	= "m_syozoku"
string	l_msg

// 入力チェック
choose case dwo.name
	case "bumon_code", "eigyosyo_code", "ka_code"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if

	case "uriage_mokuhyo", "arari_mokuhyo"
		l_input	= trim( data )
		// 売上目標、粗利目標は千円単位での入力
		if lena( l_input ) > 0 then
			l_input	= l_input + "000"
		end if
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
			
	case else
end choose

// 個別チェック
choose case dwo.name
	
	case "bumon_code"

		// 存在チェック
		l_code	= long( trim( data ) )
		select  meisyo_1
		into    :l_mei
		from    m_meisyo
		where	meisyo_kbn	= 21
		and		meisyo_code	= :l_code
		using cocos	;
		
		choose case cocos.sqlcode
			case 0
				this.object.bumon_mei[row]		= trim( l_mei )
			case 100
				msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				this.setfocus()
				return 1
			case else
				msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				this.setfocus()
				return 1
		end choose
		
	case "eigyosyo_code"

		// 存在チェック
		l_code	= long( trim( data ) )
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
				msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				this.setfocus()
				return 1
			case else
				msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				this.setfocus()
				return 1
		end choose
	case "ka_code"

		// 存在チェック
		l_code	= long( trim( data ) )
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
				msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				this.setfocus()
				return 1
			case else
				msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				this.setfocus()
				return 1
		end choose

	
	case "uriage_mokuhyo"
		
//		if not dbfnc.of_get_column_info( "M_SYOZOKU", "URIAGE_MOKUHYO", l_column_type, l_column_length ) then
//			msg.of_error_dwo( dwo, "カラム情報が取得できません。" )
//			return 1
//		else
//			// 1000円単位での入力
//			l_column_length	= l_column_length - 4
//			if l_column_length < lena( data ) then
//				msg.of_error_dwo( dwo, "入力可能数をオーバーしています。~r~n( 入力値：" + string( lena( trim( fo_nvl( data, "" ) ) ) ) + " / 最大値：" + string( l_column_length ) + " )" )
//				return 1
//			end if
//		end if
		
		// 粗利率計算
		if this.object.uriage_mokuhyo[row] <> dec( data ) then
			l_arari		= dec( this.object.arari_mokuhyo[row] )
			l_uriage	= dec( data )
			if l_uriage = 0 then
				l_arari_ritu	= 0
			else
				l_arari_ritu	= round( l_arari / l_uriage, 3 )
			end if
			
			this.object.arari_ritu[row]		= l_arari_ritu
		end if

	case "arari_mokuhyo"
		
////		if not fnc.db.of_get_column_info( "M_SYOZOKU", "ARARI_MOKUHYO", l_column_type, l_column_length ) then
//		if not dbfnc.of_get_column_info( "M_SYOZOKU", "ARARI_MOKUHYO", l_column_type, l_column_length ) then
//			msg.of_error_dwo( dwo, "カラム情報が取得できません。" )
//			return 1
//		else
//			// 1000円単位での入力
//			l_column_length	= l_column_length - 4
//			if l_column_length < lena( data ) then
//				msg.of_error_dwo( dwo, "入力可能数をオーバーしています。~r~n( 入力値：" + string( lena( trim( fo_nvl( data, "" ) ) ) ) + " / 最大値：" + string( l_column_length ) + " )" )
//				return 1
//			end if
//		end if

		// 粗利率計算
		if this.object.arari_mokuhyo[row] <> dec( data ) then
			l_arari		= dec( data )
			l_uriage	= dec( this.object.uriage_mokuhyo[row] )
			if l_uriage = 0 then
				l_arari_ritu	= 0
			else
				l_arari_ritu	= round( l_arari / l_uriage, 3 )
			end if
	
			this.object.arari_ritu[row]		= l_arari_ritu
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
str_mdlpara_mmeisyo	l_mdl_meisyo

l_row		= this.getrow()
l_column	= this.getcolumnname()

// 照会はF8使用不可
if i_syori_kbn = "照会" or i_syori_kbn = "削除" then
	return 0
end if


// F8:参照
choose case l_column
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

end choose


end event

event clicked;call super::clicked;
if row > 0 then
	if dwo.name = "chk" then
		if this.object.chk[row] = 0 then
			this.object.chk[row] = 1
		else
			this.object.chk[row] = 0
		end if
	end if
end if
end event

type st_memo from ivo_statictext within wmm_tanto_syozoku
integer x = 36
integer y = 1280
integer width = 496
boolean bringtotop = true
long backcolor = 553648127
string text = "(目標単位：千円)"
boolean sf1_key = true
boolean sf2_key = true
end type

type st_right_arrow from ivo_statictext within wmm_tanto_syozoku
integer x = 2904
integer y = 1390
integer width = 88
boolean bringtotop = true
long backcolor = 553648127
string text = "→"
alignment alignment = center!
boolean sf1_key = true
boolean sf2_key = true
end type

type cb_copy from ivo_commandbutton within wmm_tanto_syozoku
integer x = 3028
integer y = 1383
integer width = 488
boolean bringtotop = true
fontcharset fontcharset = shiftjis!
string text = "選択行へ反映"
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "全選択", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.enabled			= false


end event

event execution;call super::execution;long	l_row

// 画面に行がない場合は処理しない
if dw_list.rowcount() = 0 then
	return 0
end if

if i_syori_kbn = "照会" then
	return 0
end if


for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chk[l_row] = 1 then
		dw_list.object.bumon_code[l_row]	= long( uo_bumon.sle_input.text )
		dw_list.object.bumon_mei[l_row]		= uo_bumon.st_meisyo.text
		dw_list.object.eigyosyo_code[l_row]	= long( uo_eigyo.sle_input.text )
		dw_list.object.eigyosho_mei[l_row]	= uo_eigyo.st_meisyo.text
		dw_list.object.ka_code[l_row]		= long( uo_ka.sle_input.text )
		dw_list.object.ka_mei[l_row]		= uo_ka.st_meisyo.text
	end if
next

end event

type cb_clear from ivo_commandbutton within wmm_tanto_syozoku
integer x = 3552
integer y = 1383
integer width = 488
boolean bringtotop = true
fontcharset fontcharset = shiftjis!
string text = "目標金額クリア"
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
end type

event execution;call super::execution;long	l_row

// 画面に行がない場合は処理しない
if dw_list.rowcount() = 0 then
	return
end if

if i_syori_kbn = "照会" then
	return 0
end if

for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chk[l_row] = 1 then
		dw_list.object.uriage_mokuhyo[l_row]	= 0
		dw_list.object.arari_mokuhyo[l_row]	= 0
	end if
next

end event

event constructor;call super::constructor;this.i_function_name	= { "全選択", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.enabled			= false

end event

type uo_nendo from sv_ddplb_nendo within wmm_tanto_syozoku
string tag = "年度"
integer x = 20
integer y = 359
integer width = 1932
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean enter_key = true
boolean enter2tab = true
end type

on uo_nendo.destroy
call sv_ddplb_nendo::destroy
end on

event constructor;call super::constructor;
this.enabled				= true
this.ddplb_nendo.enabled	= true



return 0
end event

type uo_bumon from cv_input_meisyo within wmm_tanto_syozoku
event destroy ( )
string tag = "部門"
integer x = 36
integer y = 1383
integer width = 920
integer taborder = 60
boolean bringtotop = true
boolean enter2tab = true
string title_text = "部門"
long title_width = 168
long input_width = 88
integer meisyo_kbn = 21
end type

on uo_bumon.destroy
call cv_input_meisyo::destroy
end on

event constructor;call super::constructor;
//this.st_meisyo.width	= 488			// 名称幅
//this.backcolor			= 536870912		// 背景色(透明)
//this.st_title.backcolor	= 536870912		// 背景色(透明)

this.of_set_enabled( false )

end event

type uo_eigyo from cv_input_meisyo within wmm_tanto_syozoku
event destroy ( )
string tag = "営業所"
integer x = 992
integer y = 1383
integer width = 1000
integer taborder = 70
boolean bringtotop = true
boolean enter2tab = true
string title_text = "営業所"
long title_width = 248
long input_width = 88
integer meisyo_kbn = 22
end type

on uo_eigyo.destroy
call cv_input_meisyo::destroy
end on

event constructor;call super::constructor;
//this.st_meisyo.width	= 488			// 名称幅
//this.backcolor			= 536870912		// 背景色(透明)
//this.st_title.backcolor	= 536870912		// 背景色(透明)

this.of_set_enabled( false )

end event

type uo_ka from cv_input_meisyo within wmm_tanto_syozoku
event destroy ( )
string tag = "課"
integer x = 2028
integer y = 1383
integer width = 840
integer taborder = 80
boolean bringtotop = true
boolean enter2tab = true
string title_text = "課"
long title_width = 88
long input_width = 128
integer meisyo_kbn = 23
end type

on uo_ka.destroy
call cv_input_meisyo::destroy
end on

event constructor;call super::constructor;
//this.st_meisyo.width		= 488			// 名称幅
//this.backcolor				= 536870912		// 背景色(透明)
//this.st_title.backcolor		= 536870912		// 背景色(透明)

this.of_set_enabled( false )

end event

type uo_tanto from cv_input_tanto within wmm_tanto_syozoku
event destroy ( )
string tag = "担当者"
integer x = 36
integer y = 256
integer width = 1596
integer taborder = 20
boolean bringtotop = true
long input_width = 128
long bikou_width = 168
end type

on uo_tanto.destroy
call cv_input_tanto::destroy
end on

event sle_input_check;call super::sle_input_check;
// 

string	l_code
long	l_bumon_code, l_eigyosho_code, l_ka_code, l_haiban_flg
string	l_tanto_mei, l_bumon_mei, l_eigyosho_mei,l_ka_mei
//integer	l_kengen
//string	l_colnm
//string	l_msg

l_code		= this.of_get_input()

// 存在チェック
select mt.tanto_mei,
       mt.bumon_code,
       mei_21.meisyo_1,
       mt.eigyosyo_code,
       mei_22.meisyo_1,
       mt.ka_code,
       mei_23.meisyo_1,
       mt.haiban_flg
  into :l_tanto_mei,
       :l_bumon_code,
       :l_bumon_mei,
       :l_eigyosho_code,
       :l_eigyosho_mei,
       :l_ka_code,
       :l_ka_mei,
       :l_haiban_flg
  from m_tanto mt,
       ( select meisyo_code, meisyo_1 from m_meisyo where meisyo_kbn = 21 )    mei_21,
       ( select meisyo_code, meisyo_1 from m_meisyo where meisyo_kbn = 22 )    mei_22,
       ( select meisyo_code, meisyo_1 from m_meisyo where meisyo_kbn = 23 )    mei_23
 where mt.bumon_code       = mei_21.meisyo_code(+)
   and mt.eigyosyo_code    = mei_22.meisyo_code(+)
   and mt.ka_code          = mei_23.meisyo_code(+)
   and mt.tanto_code	    = :l_code
using cocos;

choose case cocos.sqlcode
	case 0
		st_bumon_code.text		= trim( string( l_bumon_code ) )
		st_bumon_mei.text		= trim( l_bumon_mei )
		st_eigyosyo_code.text	= trim( string( l_eigyosho_code ) )
		st_eigyosyo_mei.text	= trim( l_eigyosho_mei )
		st_ka_code.text			= trim( string( l_ka_code ) )
		st_ka_mei.text			= trim( l_ka_mei )
		// 一括入力にもセット
		uo_bumon.sle_input.text	= trim( string( l_bumon_code ) )
		uo_bumon.st_meisyo.text	= trim( l_bumon_mei )
		uo_eigyo.sle_input.text	= trim( string( l_eigyosho_code ) )
		uo_eigyo.st_meisyo.text	= trim( l_eigyosho_mei )
		uo_ka.sle_input.text	= trim( string( l_ka_code ) )
		uo_ka.st_meisyo.text	= trim( l_ka_mei )
	case 100
		msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", this.tag ) )
		return false
	case else
		msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		return false
end choose


return true

end event

event constructor;call super::constructor;

this.of_set_enabled( true )

end event

