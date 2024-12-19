$PBExportHeader$wmm_ryutu_kako.srw
$PBExportComments$流通加工登録
forward
global type wmm_ryutu_kako from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_ryutu_kako
end type
type st_syori_kbn from ivo_statictext within wmm_ryutu_kako
end type
type dw_entry from ivo_datawindow within wmm_ryutu_kako
end type
type uo_tokui_tanto from cv_input_tokui_tanto within wmm_ryutu_kako
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_ryutu_kako
end type
type lstr_m_ryutu_kako from structure within wmm_ryutu_kako
end type
end forward

type lstr_m_ryutu_kako from structure
	long		syohin_code
	string		hin_ban
	string		ryutu_kako_kbn1
	string		rowid
	long		tokui_code
	string		ryutu_kako_kbn2
	string		ryutu_kako_kbn3
	string		ryutu_kako_kbn4
	string		ryutu_kako_kbn5
	string		tokui_mei
	string		hin_mei
end type

global type wmm_ryutu_kako from iw_main_window
string title = "流通加工登録"
dw_list dw_list
st_syori_kbn st_syori_kbn
dw_entry dw_entry
uo_tokui_tanto uo_tokui_tanto
ddplb_syori_kbn ddplb_syori_kbn
end type
global wmm_ryutu_kako wmm_ryutu_kako

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	long i_tokui_code
	long	i_syohin_code
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
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_db_delete (lstr_m_ryutu_kako p_rec)
public function boolean of_db_update (lstr_m_ryutu_kako p_rec)
public function boolean of_db_insert (lstr_m_ryutu_kako p_rec)
public function boolean of_record_lock (long p_tokui_code, long p_syohin_code, boolean p_lock)
public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_syohin_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_syohin_code)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
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
			dw_entry.setcolumn( "syohin_code" )
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

//// シグナルが有効であればDBアンロックの必要あり
//choose case i_syori_kbn
//	case "登録"
//		dw_entry.event constructor( )
//	case "変更", "削除", "照会"
//		dw_entry.event constructor( )
//end choose

dw_list.event constructor( )
dw_entry.event constructor( )

//// Wクリック状態でフォーカス移動
//if l_doubleclicked then
//	dw_entry.setfocus()	// フォーカスバグのおまじない
//	dw_list.setfocus()
//else
//	of_dsp_edit( "callsection", true )
//	dw_list.event constructor( )
//	of_set_secondfocus( )
//end if

of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_ryutu_kako
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "流通加工マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_db_delete (lstr_m_ryutu_kako p_rec);
delete from m_ryutu_kako
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "流通加工マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[得意先ID=" + string(p_rec.tokui_code) + " " + string(p_rec.tokui_mei)+ " 商品=" + string(p_rec.syohin_code) + " " + p_rec.hin_ban + " " +  p_rec.hin_mei +"]" + i_syori_kbn )

//流通加工登録[得意先=(&1) (&2) 商品=(&3) (&4) (&5)](&6)
//(&1):得意先コード　(&2):得意先名　(&3):商品コード　(&4):品番　(&5):品名　(&6):処理区分

return true
end function

public function boolean of_db_update (lstr_m_ryutu_kako p_rec);
update m_ryutu_kako
   set syohin_code   	= :p_rec.syohin_code,
	   ryutu_kako_kbn1	= :p_rec.ryutu_kako_kbn1,
   	   ryutu_kako_kbn2	= :p_rec.ryutu_kako_kbn2,
  	   ryutu_kako_kbn3	= :p_rec.ryutu_kako_kbn3,
 	   ryutu_kako_kbn4  = :p_rec.ryutu_kako_kbn4,
	   ryutu_kako_kbn5	= :p_rec.ryutu_kako_kbn5,
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
	msg.of_error( fnc.strg.of_format( "流通加工マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[得意先ID=" + string(p_rec.tokui_code) + " " + string(p_rec.tokui_mei)+ " 商品=" + string(p_rec.syohin_code) + " " + p_rec.hin_ban + " " +  p_rec.hin_mei +"]" + i_syori_kbn )

return true


end function

public function boolean of_db_insert (lstr_m_ryutu_kako p_rec);
insert into m_ryutu_kako(
	syohin_code,
	tokui_code,
	ryutu_kako_kbn1,
	ryutu_kako_kbn2,
	ryutu_kako_kbn3,
	ryutu_kako_kbn4,
	ryutu_kako_kbn5,
	touroku_user_id,touroku_client_id,touroku_pg_id
) values (
	:p_rec.syohin_code,
	:p_rec.tokui_code,
	:p_rec.ryutu_kako_kbn1,
	:p_rec.ryutu_kako_kbn2,
	:p_rec.ryutu_kako_kbn3,
	:p_rec.ryutu_kako_kbn4,
	:p_rec.ryutu_kako_kbn5,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "流通加工マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[得意先ID=" + string(p_rec.tokui_code) + " " + string(p_rec.tokui_mei)+ " 商品=" + string(p_rec.syohin_code) + " " + p_rec.hin_ban + " " +  p_rec.hin_mei +"]" + i_syori_kbn )

return true

end function

public function boolean of_record_lock (long p_tokui_code, long p_syohin_code, boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
//	if lck.of_ryutu_kako_lock( i_tokui_code,i_syohin_code ) then
//		commit using cocos;  // commitは子孫側で行う
//	else
//		return false
//	end if
else
	// アンロック
//	if lck.of_ryutu_kako_unlock( i_tokui_code,i_syohin_code ) then
//		commit using cocos;  // commitは子孫側で行う
//	else
//		return false
//	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_syohin_code, string p_rowid);
long	l_db_tokuji_code
long	l_db_syohin_code

select syohin_code
  into :l_db_syohin_code
  from m_ryutu_kako
 where tokui_code       = :p_tokui_code
   and syohin_code		= :p_syohin_code
   and rowidtochar( rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
	//	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている流通加工コードはすでに登録があります。{1}【登録済の流通加工コードコード】{2}：{3}", code.crlf,p_tokui_code,  p_syohin_code ) )
		msg.of_error( fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。{1}【登録済の得意先コード】：{2}{3}【登録済の商品コード】：{4}", code.crlf,string(p_tokui_code),  code.crlf, string(p_syohin_code )) )

		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_syohin_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_tokui_code, p_syohin_code, l_rowid )
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
//long l_row

// 未実装あり

// 参照設定
str_mdlpara_mmeisyo	l_mdl_meisyo
str_mdlpara_muser	l_mdl_user

str_mdlpara_msyohin	l_mdl_syohin

//l_row	= this.getrow()

// F8:参照
choose case p_dwo.name
	case "b_syohin"
		
			l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )
			if upperbound( l_mdl_syohin.ret ) > 0 then
				p_dw.object.syohin_code[p_row]	= l_mdl_syohin.ret[1].syohin_code
				p_dw.object.hin_ban[p_row]	    = l_mdl_syohin.ret[1].hin_ban
				p_dw.object.hin_mei[p_row]	    = l_mdl_syohin.ret[1].hin_mei

			end if
		case "b_kako_kbn1"
			
			l_mdl_meisyo.in_meisyo_kbn	= 173
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.ryutu_kako_kbn1[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.ryutu_kako_kbn1_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1

			end if
			



		case "b_kako_kbn2"
			
			l_mdl_meisyo.in_meisyo_kbn	= 173
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.ryutu_kako_kbn2[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.ryutu_kako_kbn2_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
			end if

		case "b_kako_kbn3"
			
			l_mdl_meisyo.in_meisyo_kbn	= 173
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.ryutu_kako_kbn3[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.ryutu_kako_kbn3_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
			end if

		case "b_kako_kbn4"
			
			l_mdl_meisyo.in_meisyo_kbn	= 173
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.ryutu_kako_kbn4[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.ryutu_kako_kbn4_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
			end if
			
		
		case "b_kako_kbn5"
			
			l_mdl_meisyo.in_meisyo_kbn	= 173
			l_mdl_meisyo	= mdl.of_open_modal( "wsm_meisyo", l_mdl_meisyo )
			if upperbound( l_mdl_meisyo.ret ) > 0 then
	
				p_dw.object.ryutu_kako_kbn5[p_row]	= l_mdl_meisyo.ret[1].meisyo_code 
				p_dw.object.ryutu_kako_kbn5_mei[p_row]	= l_mdl_meisyo.ret[1].meisyo_1
			end if
			
			
end choose


end subroutine

on wmm_ryutu_kako.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.uo_tokui_tanto=create uo_tokui_tanto
this.ddplb_syori_kbn=create ddplb_syori_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.dw_entry
this.Control[iCurrent+4]=this.uo_tokui_tanto
this.Control[iCurrent+5]=this.ddplb_syori_kbn
end on

on wmm_ryutu_kako.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_tokui_tanto)
destroy(this.ddplb_syori_kbn)
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
dw_entry.height		= 633

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

i_tokui_code    = long( uo_tokui_tanto.of_get_input( ) )

// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve( i_tokui_code ) = 0 then
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
lstr_m_ryutu_kako	l_rec
long				l_row


l_row	= long( dw_entry.object.datawindow.firstrowonpage )

// 構造体に更新値をセット
l_rec.syohin_code		= dw_entry.object.syohin_code[l_row]
l_rec.hin_ban		    = dw_entry.object.hin_ban[l_row]
l_rec.hin_mei		    = dw_entry.object.hin_mei[l_row]
l_rec.ryutu_kako_kbn1	= dw_entry.object.ryutu_kako_kbn1[l_row]
l_rec.ryutu_kako_kbn2	= dw_entry.object.ryutu_kako_kbn2[l_row]
l_rec.ryutu_kako_kbn3	= dw_entry.object.ryutu_kako_kbn3[l_row]
l_rec.ryutu_kako_kbn4	= dw_entry.object.ryutu_kako_kbn4[l_row]
l_rec.ryutu_kako_kbn5	= dw_entry.object.ryutu_kako_kbn5[l_row]
l_rec.rowid				= dw_entry.object.rowid[l_row]
l_rec.tokui_code		= i_tokui_code
l_rec.tokui_mei		    = dw_entry.object.tokui_mei[l_row]


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

// 結果を明細部に再読み込み（最終行を削除して、「終了」ボタンを押した場合に必要。setfocusがあれば良い？）
of_dsp_back()


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
string l_kako_kbn[6]
boolean jyuhuku_flg
integer i,j

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_syohin_code		= long(dw_entry.object.syohin_code[l_row])

if dw_entry.event itemchanged( l_row, dw_entry.object.syohin_code, string(dw_entry.object.syohin_code[l_row]) ) <> 0 then
	return -1
end if

//if dw_entry.event itemchanged( l_row, dw_entry.object.hin_ban, dw_entry.object.hin_ban[l_row] ) <> 0 then
//	return -1
//end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ryutu_kako_kbn1, dw_entry.object.ryutu_kako_kbn1[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ryutu_kako_kbn2, dw_entry.object.ryutu_kako_kbn2[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ryutu_kako_kbn3, dw_entry.object.ryutu_kako_kbn3[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ryutu_kako_kbn4, dw_entry.object.ryutu_kako_kbn4[l_row] ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.ryutu_kako_kbn5, dw_entry.object.ryutu_kako_kbn5[l_row] ) <> 0 then
	return -1
end if





//// 必須チェック
//if len( string( dw_entry.object.syohin_code[l_row] ) ) = 0 then
////if isnull( dw_entry.object.syohin_code[l_row] )  then
////if  dw_entry.object.syohin_code[l_row]=""  then
//	msg.of_error_dwo( dw_entry.object.syohin_code, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "流通加工名" ) )
//	dw_entry.setfocus()
//	dw_entry.setcolumn( "syohin_code" )
//	return -1
//end if
//
//if len( string( dw_entry.object.ryutu_kako_kbn1[l_row] ) ) = 0 then
////if isnull( dw_entry.object.ryutu_kako_kbn1[l_row] )  then	
////if dw_entry.object.ryutu_kako_kbn1[l_row]=""  then	
//	msg.of_error_dwo( dw_entry.object.ryutu_kako_kbn1, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "流通加工名" ) )
//	dw_entry.setfocus()
//	dw_entry.setcolumn( "ryutu_kako_kbn1" )
//	return -1
//end if

// 重複チェック

		
		l_kako_kbn={dw_entry.object.ryutu_kako_kbn1[l_row],dw_entry.object.ryutu_kako_kbn2[l_row],dw_entry.object.ryutu_kako_kbn3[l_row],dw_entry.object.ryutu_kako_kbn4[l_row],dw_entry.object.ryutu_kako_kbn5[l_row]}
		jyuhuku_flg = true

		for i=1 to 4
			for j=i+1 to 5 
				if not l_kako_kbn[i]="" and not  l_kako_kbn[j]="" then
					if l_kako_kbn[i] = l_kako_kbn[j] then 
						jyuhuku_flg = false
					end if
				end if
			next
        next
		
		if jyuhuku_flg = false then
			//l_msg="区分1～5のコードが重複しています。"
			msg.of_error_dwo( dw_entry.object.ryutu_kako_kbn1, "区分1～5のコードが重複しています。" )
			
			//msg.of_error_dwo( dwo, l_msg )
			dw_entry.setfocus()
			dw_entry.setcolumn( "ryutu_kako_kbn1" )
			return -1
	end if
		

// エディットコントロールの名前を配列で管理
string ls_edit_fields[] = { "ryutu_kako_kbn1", "ryutu_kako_kbn2", "ryutu_kako_kbn3", "ryutu_kako_kbn4", "ryutu_kako_kbn5" }




// チェック処理
// チェック対象フィールド名を配列で定義
string ls_kbn_fields[] = { "ryutu_kako_kbn1", "ryutu_kako_kbn2", "ryutu_kako_kbn3", "ryutu_kako_kbn4", "ryutu_kako_kbn5" }
integer li_index
string ls_value


integer li_check
string ls_next_value


// チェック処理
for li_index = 1 to UpperBound(ls_kbn_fields)
    // 現在のフィールドの値を取得
    ls_value=dw_entry.getitemstring(l_row, ls_kbn_fields[li_index] )

    // 空のフィールドが見つかった場合
    if IsNull(ls_value) or Trim(ls_value) = "" then
        // 後続のフィールドに値がないか確認
        for li_check = li_index + 1 to UpperBound(ls_kbn_fields)
            
            ls_next_value=dw_entry.getitemstring(l_row, ls_kbn_fields[li_check])
            if Not IsNull(ls_next_value) and Trim(ls_next_value) <> "" then
                // エラーを表示して処理を終了
				msg.of_error_dwo( dw_entry.object.ryutu_kako_kbn1, "区分1～5は順番に入力する必要があります。" )
                //MessageBox("エラー", ls_kbn_fields[li_index] + " が空で、" + ls_kbn_fields[li_check] + " に値が入力されています。")
                return -1
            end if
        next
        exit // 空のフィールドが見つかった時点で後続のチェックを終了
    end if
next



//		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
//			msg.of_error_dwo( dwo, l_msg )
//			return 1
//		end if

end event

event retrieve_check;call super::retrieve_check;
string	l_code
integer	l_syusoku_flg
string	l_input
string	l_colnm
string	l_tableid	= "m_ryutu_kako"
string	l_msg

long	l_db_tokui_code
long    l_cnt

// リトリーブ前の事前チェック
// 入力チェック
if not uo_tokui_tanto.event sle_input_check( ) then
	return -1
end if

l_code		= string( uo_tokui_tanto.of_get_input( ) )

if i_syori_kbn = "登録" then
	
	select count('x')
	  into :l_cnt
	  from m_ryutu_kako
	 where tokui_code       = to_number( :l_code )
	using cocos;
	
	
	if l_cnt > 0 then
		msg.of_error( fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。{1}【登録済の得意先コード】：{2}", code.crlf,l_code ))
		return -1
	end if
			
			
//	choose case cocos.sqlcode
//		case 0
//		//	msg.of_error_dwo( p_dwo, fnc.strg.of_format( "登録しようとしている流通加工コードはすでに登録があります。{1}【登録済の流通加工コードコード】{2}：{3}", code.crlf,p_tokui_code,  p_syohin_code ) )
//			msg.of_error( fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。{1}【登録済の得意先コード】：{2}", code.crlf,l_code ))
//			return -1
//		case 100
//		case else
//			msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
//			return -1
//			
//	end choose
end if


// 存在チェック
select syusoku_flg
  into :l_syusoku_flg
  from m_tokui
 where tokui_code	= to_number( :l_code )
using cocos;

choose case cocos.sqlcode
	case 0
		if l_syusoku_flg=1 then
			msg.of_error( "選択している得意先は終息しているため、この処理は実行できません。")

			this.setfocus()
			return -1
		end if
	case 100
		return 0
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		this.setfocus()
		return -1
end choose

end event

type uo_signal from iw_main_window`uo_signal within wmm_ryutu_kako
end type

type st_date from iw_main_window`st_date within wmm_ryutu_kako
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_ryutu_kako
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_ryutu_kako
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_ryutu_kako
end type

type st_title from iw_main_window`st_title within wmm_ryutu_kako
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_ryutu_kako
end type

type st_upper from iw_main_window`st_upper within wmm_ryutu_kako
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_ryutu_kako
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_ryutu_kako
integer taborder = 30
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_ryutu_kako
integer x = 8
integer y = 864
integer width = 4208
integer height = 992
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_ryutu_kako_list"
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
l_file	= fnc.strg.of_format( "流通加工登録_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event doubleclicked;call super::doubleclicked;
long	l_upd_row
string	l_code
long	l_row
long    l_tokui_code
long	l_syohin_code

setredraw( false )

if row > 0 then
	
	i_tokui_code	= long(this.object.tokui_code[row])
	i_syohin_code	= long(this.object.syohin_code[row])


	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
//			// 存在チェック
//			select max( syohin_code )
//  			into :l_syohin_code
// 			 from m_ryutu_kako
//			using cocos;
//	
//			choose case cocos.sqlcode
//				case 0
//					l_syohin_code = l_syohin_code + 1
//				case 100
//					l_syohin_code = 1
//				case else
//					msg.of_error_sle( this.object.syohin_code, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
//					this.setfocus()
//					return 1
//			end choose
//			
			dw_entry.object.syohin_code[l_row]		= i_syohin_code
			dw_entry.object.hin_ban[l_row]		= this.object.hin_ban[row]
			dw_entry.object.hin_mei[l_row]		= this.object.hin_mei[row]
//			dw_entry.object.tokui_code[l_row]		= this.object.tokui_code[row]			
			dw_entry.object.tokui_mei[l_row]		= this.object.tokui_mei[row]			
			dw_entry.object.ryutu_kako_kbn1[l_row]		= this.object.ryutu_kako_kbn1[row]
			dw_entry.object.ryutu_kako_kbn2[l_row]		= this.object.ryutu_kako_kbn2[row]
			dw_entry.object.ryutu_kako_kbn3[l_row]		= this.object.ryutu_kako_kbn3[row]
			dw_entry.object.ryutu_kako_kbn4[l_row]		= this.object.ryutu_kako_kbn4[row]
			dw_entry.object.ryutu_kako_kbn5[l_row]		= this.object.ryutu_kako_kbn5[row]
			dw_entry.object.ryutu_kako_kbn1_mei[l_row]		= this.object.ryutu_kako_kbn1_mei[row]
			dw_entry.object.ryutu_kako_kbn2_mei[l_row]		= this.object.ryutu_kako_kbn2_mei[row]
			dw_entry.object.ryutu_kako_kbn3_mei[l_row]		= this.object.ryutu_kako_kbn3_mei[row]
			dw_entry.object.ryutu_kako_kbn4_mei[l_row]		= this.object.ryutu_kako_kbn4_mei[row]
			dw_entry.object.ryutu_kako_kbn5_mei[l_row]		= this.object.ryutu_kako_kbn5_mei[row]
			
			

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_tokui_code, i_syohin_code, true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_tokui_code,i_syohin_code ) > 0 then
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

type st_syori_kbn from ivo_statictext within wmm_ryutu_kako
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_ryutu_kako
integer y = 373
integer width = 5120
integer height = 473
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_ryutu_kako_entry"
boolean border = false
boolean f8_key = true
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
			if len( trim( l_rowid ) ) > 0 then
				of_record_lock_rowid( l_rowid, false )
			end if

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
long	l_code
string	l_mei
string  l_ban
long    l_tokui_code
long	l_syohin_code
//int	l_syohin_code
string l_kako_kbn[6]
boolean jyuhuku_flg
integer i,j
string	l_meisyo_code,l_meisyo_mei


string	l_input
string	l_colnm
string	l_tableid	= "m_ryutu_kako"
string	l_msg

//l_tokui_code		= this.object.tokui_code[row]

l_syohin_code		= this.object.syohin_code[row]

i_tokui_code    = long( uo_tokui_tanto.of_get_input( ) )

// 桁数チェック
choose case dwo.name
	case "syohin_code"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	
	case "ryutu_kako_kbn1"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	
	
	case "ryutu_kako_kbn2", "ryutu_kako_kbn3", "ryutu_kako_kbn4", "ryutu_kako_kbn5"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

//// 重複チェック
//choose case dwo.name
//	case  "ryutu_kako_kbn1", "ryutu_kako_kbn2", "ryutu_kako_kbn3", "ryutu_kako_kbn4", "ryutu_kako_kbn5"
//		l_input	= trim( data )
//		l_colnm	= dwo.tag		// タグ値で項目名を取得
//		
//		l_kako_kbn={this.object.ryutu_kako_kbn1[row],this.object.ryutu_kako_kbn2[row],this.object.ryutu_kako_kbn3[row],this.object.ryutu_kako_kbn4[row],this.object.ryutu_kako_kbn5[row]}
//		jyuhuku_flg = true
//
//		for i=1 to 4
//			for j=i+1 to 5 
//				if not l_kako_kbn[i]="" and not  l_kako_kbn[j]="" then
//					if l_kako_kbn[i] = l_kako_kbn[j] then 
//						jyuhuku_flg = false
//					end if
//				end if
//			next
//        next
//		
//		if jyuhuku_flg = false then
//			l_msg="区分1～5のコードが重複しています。"
//			msg.of_error_dwo( dwo, l_msg )
//			return 1
//	end if
//		
////		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
////			msg.of_error_dwo( dwo, l_msg )
////			return 1
////		end if
//	case else
//end choose

/*
//中抜きチェック
choose case dwo.name
	case  "ryutu_kako_kbn1"
		if  (data ="" and  this.object.ryutu_kako_kbn2[row]<>"")  then
			l_msg="区分1～5は順番に入力する必要があります。"
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case  "ryutu_kako_kbn2"
		if (this.object.ryutu_kako_kbn1[row] ="" and data<>"" ) or (data ="" and  this.object.ryutu_kako_kbn3[row]<>"") then
			l_msg="区分1～5は順番に入力する必要があります。"
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case  "ryutu_kako_kbn3"
		if (this.object.ryutu_kako_kbn2[row] ="" and data<>"" ) or (data ="" and  this.object.ryutu_kako_kbn4[row]<>"") then
			l_msg="区分1～5は順番に入力する必要があります。"
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if

	case  "ryutu_kako_kbn4"
		
		if (this.object.ryutu_kako_kbn3[row] ="" and data<>"" ) or (data ="" and  this.object.ryutu_kako_kbn5[row]<>"") then
			l_msg="区分1～5は順番に入力する必要があります。"
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if

	case  "ryutu_kako_kbn5"
		if (this.object.ryutu_kako_kbn4[row] ="" and data<>"" ) then
			l_msg="区分1～5は順番に入力する必要があります。"
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if

	case else
end choose
*/

// 個別仕様
choose case dwo.name
	case "syohin_code"
		// 流通加工コード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		
		// 存在チェック
		select distinct syohin_code,hin_ban,hin_mei
		  into :l_code,:l_ban,:l_mei
		  from m_syohin
		 where syohin_code	= :data
		using cocos	;
		
		choose case cocos.sqlcode
			case 0
				this.object.hin_ban[row]        =trim(l_ban)
				this.object.hin_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "syohin_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose


		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
				// 重複チェック
				if not of_dwchk_duplicate( dwo,i_tokui_code, long(data) ) then
					return 1
				end if
		end choose
		
		// 桁セット
		l_syohin_code		= this.object.syohin_code[row]
		if isnull( l_syohin_code ) then
//			l_syohin_code	= ""
		end if

	case "tokui_code"

		// 存在チェック
		select tokui_mei
		  into :l_mei
		  from m_tokui
		 where tokui_code	= :data
		using cocos	;
		
		choose case cocos.sqlcode
			case 0
				this.object.tokui_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
		
	case "ryutu_kako_kbn1"
		
			
		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if

		if lena( trim( data ) ) > 0 then

			// 存在チェック
			
			select meisyo_code,meisyo_1
			into :l_meisyo_code,:l_mei 
			from m_meisyo
			where meisyo_kbn	= 173
			and meisyo_code	= :data
			using cocos;
			
			choose case cocos.sqlcode
				case 0
					this.object.ryutu_kako_kbn1_mei[row]		= trim( l_mei )
				case 100
						msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
					return 1
				case else
					msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
					return 1
			end choose
		else
			this.object.ryutu_kako_kbn1_mei[row]=""
	end if	

	case "ryutu_kako_kbn2"
		
		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
		if lena( trim( data ) ) > 0 then
		
		// 存在チェック
		
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_mei 
		from m_meisyo
		where meisyo_kbn	= 173
		and meisyo_code	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.ryutu_kako_kbn2_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
		
		else
			this.object.ryutu_kako_kbn2_mei[row]=""
	end if	

	case "ryutu_kako_kbn3"
		
		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
		if lena( trim( data ) ) > 0 then
		// 存在チェック
		
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_mei 
		from m_meisyo
		where meisyo_kbn	= 173
		and meisyo_code	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.ryutu_kako_kbn3_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
		else
			this.object.ryutu_kako_kbn3_mei[row]=""
	end if	

	case "ryutu_kako_kbn4"
		
		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
		if lena( trim( data ) ) > 0 then
			
		// 存在チェック
		
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_mei 
		from m_meisyo
		where meisyo_kbn	= 173
		and meisyo_code	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.ryutu_kako_kbn4_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
		else
			this.object.ryutu_kako_kbn4_mei[row]=""
	end if	

	case "ryutu_kako_kbn5"
		
		//桁数チェック
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
		
		if lena( trim( data ) ) > 0 then
		// 存在チェック
		
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_mei 
		from m_meisyo
		where meisyo_kbn	= 173
		and meisyo_code	= :data
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.ryutu_kako_kbn5_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
	
	else
			this.object.ryutu_kako_kbn5_mei[row]=""
	end if	

	case else

end choose

return 0
end event

event clicked;call super::clicked;
// F8:参照
choose case dwo.name
	case "b_syohin"
		
		//if this.object.taisyo_kbn=4
		
		// 参照起動
		of_reference( this, dwo, row )
	case "b_kako_kbn1","b_kako_kbn2","b_kako_kbn3","b_kako_kbn4","b_kako_kbn5"
		// 参照起動
		of_reference( this, dwo, row )

		if dw_entry.event itemchanged( row, dw_entry.object.ryutu_kako_kbn1, dw_entry.object.ryutu_kako_kbn1[row] ) <> 0 then
			return -1
		end if
		
end choose
end event

type uo_tokui_tanto from cv_input_tokui_tanto within wmm_ryutu_kako
string tag = "得意先"
integer x = 532
integer y = 156
integer taborder = 20
boolean bringtotop = true
end type

on uo_tokui_tanto.destroy
call cv_input_tokui_tanto::destroy
end on

event sle_input_check;call super::sle_input_check;

string	l_code
string	l_hin_ban
string	l_hin_mei
string	l_syusoku_flg
long	l_cnt

//l_code		= trim( sle_syohin_code.text )
l_code		=string( uo_tokui_tanto.of_get_input( ) )

i_syori_kbn	= ddplb_syori_kbn.text
//
//// 必須チェック
//if len( l_code ) = 0 then
////	msg.of_error( this, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ) )
//	this.setfocus()
//	return false
//end if

// 必須チェック
if len( l_code ) = 0 then
	msg.of_error(fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ))
	this.setfocus()
	return false
end if

// 入力チェック
if lena( string( l_code ) ) > 0 then
	if of_get_syusoku_flg() = 1 then
		of_reset( "meisyobikou" )
		msg.of_error_sle( this.sle_input, fnc.strg.of_format( "選択している得意先は終息しているため、この処理は実行できません。", this.tag ) )
		this.sle_input.setfocus()
		return false
	end if
end if

/*
//

string	l_code
integer	l_syusoku_flg
string	l_input
string	l_colnm
string	l_tableid	= "m_ryutu_kako"
string	l_msg

l_code	= trim( of_get_input( ) )
//l_code		= string( uo_tokui_tanto.text )

// 存在チェック
select syusoku_flg
  into :l_syusoku_flg
  from m_tokui
 where tokui_code	= to_number( :l_code )
using cocos;

messagebox("test",string(l_syusoku_flg))
choose case cocos.sqlcode
	case 0
		if l_syusoku_flg=1 then
			//msg.of_error_sle( this, fnc.strg.of_format( "選択している得意先は終息しているため、この処理は実行できません。", "" ) )
			msg.of_error( "選択している得意先は終息しているため、この処理は実行できません。")

			this.setfocus()
			return false
		end if
	case 100
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		this.setfocus()
		return false
	case else
//		msg.of_error_sle( this, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )

		this.setfocus()
		return false
end choose
*/

return true


end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_ryutu_kako
integer x = 352
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )

this.enabled			= true

setnull( i_syori_kbn )
end event

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
//		uo_tokui_tanto.of_set_dbchk_dupe( )
//		uo_tokui_tanto.of_set_dbchk_dupe( )




	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_tokui_tanto.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose

end event

