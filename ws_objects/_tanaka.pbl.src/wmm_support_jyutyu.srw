$PBExportHeader$wmm_support_jyutyu.srw
$PBExportComments$入力支援設定
forward
global type wmm_support_jyutyu from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_support_jyutyu
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_support_jyutyu
end type
type st_syori_kbn from ivo_statictext within wmm_support_jyutyu
end type
type dw_entry from ivo_datawindow within wmm_support_jyutyu
end type
type uo_tokui from cv_input_tokui within wmm_support_jyutyu
end type
type lstr_m_nyuryoku_sien from structure within wmm_support_jyutyu
end type
end forward

type lstr_m_nyuryoku_sien from structure
	long		tokui_code
	string		tokui_mei
	long		mise_code
	string		mise_mei
	integer		jyutyuzan_flg
	integer		kakuho_kbn
	integer		syukka_kbn
	integer		syukka_kyoten
	integer		syukka_houhou
	integer		zbin_flg
	long		kakeritu
	integer		syobun_flg
	string		aite_bumon_code
	string		aite_denpyo_kbn
	integer		aite_baika_flg
	long		nyuryoku_gyosu
	integer		jyutyu_tekiyo_kbn
	string		jyutyu_tekiyo
	integer		denpyo_tekiyo_kbn
	string		denpyo_tekiyo
	integer		buturyu_tekiyo_kbn
	string		buturyu_tekiyo
	integer		nohinsyo_bikou_kbn
	string		nohinsyo_bikou
	integer		naiyou_meisai_bikou_kbn
	string		naiyou_meisai_bikou
	integer		fax_comment_kbn
	string		fax_comment
	string		tyui_jikou_jyutyu
	string		tyui_jikou_kako
	string		rowid
end type

global type wmm_support_jyutyu from iw_main_window
string title = "入力支援設定"
dw_list dw_list
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
dw_entry dw_entry
uo_tokui uo_tokui
end type
global wmm_support_jyutyu wmm_support_jyutyu

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	long	i_tokui_code
	long	i_mise_code
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時

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
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_db_delete (lstr_m_nyuryoku_sien p_rec)
public function boolean of_db_update (lstr_m_nyuryoku_sien p_rec)
public function boolean of_db_insert (lstr_m_nyuryoku_sien p_rec)
public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_mise_code, string p_rowid)
public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_mise_code)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public function boolean of_record_lock (long p_tokui_code, long p_mise_code, boolean p_lock)
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
			dw_entry.setcolumn( "tokui_code" )
			dw_entry.setfocus()
		else
			msg.of_error( "編集可能な行がありません。" )
		end if
	
	case "dw_list"

		dw_entry.enabled	= p_enabled
		dw_list.enabled		= p_enabled
		dw_entry.object.syori_kbn[1]	= i_syori_kbn
		dw_list.object.syori_kbn.Expression = "'" + i_syori_kbn + "'"
		dw_list.setrow(1)
//		dw_list.setcolumn( "item_code" )
		dw_list.setfocus()
	
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

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_nyuryoku_sien
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "物件マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_db_delete (lstr_m_nyuryoku_sien p_rec);
delete from m_nyuryoku_sien
 where rowid	= :p_rec.rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "物件マスタの削除処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_delete", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_delete", 0, st_title.text + "[得意先=" + string(p_rec.tokui_code) + " " + p_rec.tokui_mei +" 店=" + string(p_rec.mise_code) + " " + p_rec.mise_mei +"]" + i_syori_kbn )

return true
end function

public function boolean of_db_update (lstr_m_nyuryoku_sien p_rec);
update m_nyuryoku_sien
   set tokui_code               = :p_rec.tokui_code,
       mise_code                = :p_rec.mise_code,
       jyutyuzan_flg            = :p_rec.jyutyuzan_flg,
       kakuho_kbn               = :p_rec.kakuho_kbn,
       syukka_kbn               = :p_rec.syukka_kbn,
       syukka_kyoten            = :p_rec.syukka_kyoten,
       syukka_houhou            = :p_rec.syukka_houhou,
       zbin_flg                 = :p_rec.zbin_flg,
       kakeritu                 = :p_rec.kakeritu,
       syobun_flg               = :p_rec.syobun_flg,
       aite_bumon_code          = :p_rec.aite_bumon_code,
       aite_denpyo_kbn          = :p_rec.aite_denpyo_kbn,
       aite_baika_flg           = :p_rec.aite_baika_flg,
       nyuryoku_gyosu           = :p_rec.nyuryoku_gyosu,
       jyutyu_tekiyo_kbn        = :p_rec.jyutyu_tekiyo_kbn,
       jyutyu_tekiyo            = :p_rec.jyutyu_tekiyo,
       denpyo_tekiyo_kbn        = :p_rec.denpyo_tekiyo_kbn,
       denpyo_tekiyo            = :p_rec.denpyo_tekiyo,
       buturyu_tekiyo_kbn       = :p_rec.buturyu_tekiyo_kbn,
       buturyu_tekiyo           = :p_rec.buturyu_tekiyo,
       nohinsyo_bikou_kbn       = :p_rec.nohinsyo_bikou_kbn,
       nohinsyo_bikou           = :p_rec.nohinsyo_bikou,
       naiyou_meisai_bikou_kbn  = :p_rec.naiyou_meisai_bikou_kbn,
       naiyou_meisai_bikou      = :p_rec.naiyou_meisai_bikou,
       fax_comment_kbn          = :p_rec.fax_comment_kbn,
       fax_comment              = :p_rec.fax_comment,
       tyui_jikou_jyutyu        = :p_rec.tyui_jikou_jyutyu,
       tyui_jikou_kako          = :p_rec.tyui_jikou_kako,
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
	msg.of_error( fnc.strg.of_format( "物件マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_update", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_update", 0, st_title.text + "[得意先=" + string(p_rec.tokui_code) + " " + p_rec.tokui_mei +" 店=" + string(p_rec.mise_code) + " " + p_rec.mise_mei +"]" + i_syori_kbn )

return true


end function

public function boolean of_db_insert (lstr_m_nyuryoku_sien p_rec);
insert into m_nyuryoku_sien(
	mise_code,
	tokui_code,
	tyui_jikou_jyutyu,
	touroku_user_id,touroku_client_id,touroku_pg_id
) values (
	:p_rec.mise_code,
	:p_rec.tokui_code,
	:p_rec.tyui_jikou_jyutyu,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "物件マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if

// ログ出力
of_add_db_log( "of_db_insert", 0, st_title.text + "[得意先=" + string(p_rec.tokui_code) + " " + p_rec.tokui_mei +" 店=" + string(p_rec.mise_code) + " " + p_rec.mise_mei +"]" + i_syori_kbn )

return true

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_mise_code, string p_rowid);
string  l_db_tokui_mei
string	l_db_mise_mei

select mt.tokui_mei,mm.mise_mei
  into :l_db_tokui_mei,:l_db_mise_mei
  from m_nyuryoku_sien mns,
       m_tokui mt,
       m_mise mm
 where mns.tokui_code               = mt.tokui_code(+)
   and mns.mise_code                = mm.mise_code(+)
   and mns.tokui_code               = mm.tokui_code(+)
   and mns.tokui_code               = :p_tokui_code
   and mns.mise_code                = :p_mise_code
   and rowidtochar( mns.rowid )	<> :p_rowid
using cocos;

choose case cocos.sqlcode
	case 0
		msg.of_error( fnc.strg.of_format( "登録しようとしているデータはすでに登録があります。{1}【登録済の得意先】{2}：{3}{4}【登録済の店】{5}:{6}", code.crlf, string(p_tokui_code), l_db_tokui_mei, code.crlf,string(p_mise_code), l_db_mise_mei  ))
//「登録しようとしているデータはすでに登録があります。」
//「【登録済の得意先】[得意先コード]：[得意先名]」※[]内は引数
//「【登録済の店】[店コード]：[店名]」※[]内は引数

		return false
	case 100
		return true
	case else
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		return false
end choose

end function

public function boolean of_dwchk_duplicate (dwobject p_dwo, long p_tokui_code, long p_mise_code);
string	l_rowid

l_rowid	= " "

return of_dwchk_duplicate( p_dwo, p_tokui_code, p_mise_code, l_rowid )
end function

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 参照設定

str_mdlpara_mtokui	l_mdl_tokui
str_mdlpara_mmise	l_mdl_mise

long l_row

// F8:参照
choose case p_dwo.name
	case "b_tokui"
		l_mdl_tokui	= mdl.of_open_modal( "wsm_tokui", l_mdl_tokui )
		if upperbound( l_mdl_tokui.ret ) > 0 then
			p_dw.object.tokui_code[p_row]	= l_mdl_tokui.ret[1].tokui_code
			p_dw.object.tokui_mei[p_row]	    = l_mdl_tokui.ret[1].tokui_mei

		end if
		
	case "b_mise"
		
		l_row	= long( dw_entry.object.datawindow.firstrowonpage )

		// inパラメータがある場合はここでセットする
		l_mdl_mise.in_tokui_code	=  long(dw_entry.object.tokui_code[l_row])

		l_mdl_mise	= mdl.of_open_modal( "wsm_mise", l_mdl_mise )
		if upperbound( l_mdl_mise.ret ) > 0 then
			p_dw.object.mise_code[p_row]	= l_mdl_mise.ret[1].mise_code
			p_dw.object.mise_mei[p_row]	    = l_mdl_mise.ret[1].mise_mei

		end if
			
end choose


end subroutine

public function boolean of_record_lock (long p_tokui_code, long p_mise_code, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mg.rowid,mg.haita_flg,
       nvl( to_char( mg.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mg.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mg.henkou_client_id, '???' ),
       nvl( mg.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_nyuryoku_sien mg,
       m_user mu,
       m_window mw
	 where mg.henkou_user_id= mu.user_id(+)
	   and mg.henkou_pg_id	= mw.window_id(+)
	   and mg.tokui_code= :p_tokui_code
	   and mg.mise_code	= :p_mise_code
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

on wmm_support_jyutyu.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.dw_entry=create dw_entry
this.uo_tokui=create uo_tokui
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.st_syori_kbn
this.Control[iCurrent+4]=this.dw_entry
this.Control[iCurrent+5]=this.uo_tokui
end on

on wmm_support_jyutyu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.dw_entry)
destroy(this.uo_tokui)
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

// 呼出部
// 1行目
ddplb_syori_kbn.y	= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7		// タイトル「+7」
// 2行目
uo_tokui.y       	= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
// st_second_upper高さ
st_second_upper.height	= uo_tokui.y + uo_tokui.height + code.MGN_UPPER_TATE_GAP - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )


dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= 1272

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
string	l_base_dw_sql, l_sql, l_sql_where

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn		= ddplb_syori_kbn.text
i_tokui_code	= uo_tokui.of_get_tokui_code()

l_base_dw_sql	= dw_list.getsqlselect( )
l_sql			= dw_list.getsqlselect( )

// 検索引数は使用できないので、ここでSQL調整


// 検索用SQLの組み立て
if not isnull(i_tokui_code) then
	l_sql_where += "    and mns.tokui_code               =" + string(i_tokui_code) + code.crlf
	
end if

l_sql_where += " order by mns.tokui_code,mns.mise_code"

l_sql	+= 	+ l_sql_where
dw_list.setsqlselect( l_sql )



// 登録の場合は0件であってもエラーとしない（それ以外はメッセージ出してもとに戻す）
if dw_list.retrieve(  ) = 0 then
	if i_syori_kbn <> "登録" then
		msg.of_error( "登録されたデータはありません。" )
		ddplb_syori_kbn.setfocus()
		// DWを元に戻す
		dw_list.setsqlselect( l_base_dw_sql )
		return -1
	end if
end if

// DWを元に戻す
dw_list.setsqlselect( l_base_dw_sql )

setredraw( false )

// 更新部初期化
dw_entry.event constructor( )

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
	of_dsp_edit( "dw_edit",true)
else
	of_dsp_edit( "callsection", true )
	of_dsp_edit( "dw_edit",true)
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
lstr_m_nyuryoku_sien	l_rec
integer				l_row


l_row	= long( dw_list.object.datawindow.firstrowonpage )
// 構造体に更新値をセット
l_rec.tokui_code               = dw_entry.object.tokui_code[l_row]
l_rec.tokui_mei                = dw_entry.object.tokui_mei[l_row]
l_rec.mise_code                = dw_entry.object.mise_code[l_row]
l_rec.mise_mei                 = dw_entry.object.mise_mei[l_row]
l_rec.jyutyuzan_flg            = dw_entry.object.jyutyuzan_flg[l_row]
l_rec.kakuho_kbn               = dw_entry.object.kakuho_kbn[l_row]
l_rec.syukka_kbn               = dw_entry.object.syukka_kbn[l_row]
l_rec.syukka_kyoten            = dw_entry.object.syukka_kyoten[l_row]
l_rec.syukka_houhou            = dw_entry.object.syukka_houhou[l_row]
l_rec.zbin_flg                 = dw_entry.object.zbin_flg[l_row]
l_rec.kakeritu                 = dw_entry.object.kakeritu[l_row]
l_rec.syukka_houhou            = dw_entry.object.syukka_houhou[l_row]
l_rec.syobun_flg               = dw_entry.object.syobun_flg[l_row]
l_rec.aite_bumon_code          = dw_entry.object.aite_bumon_code[l_row]
l_rec.aite_denpyo_kbn          = dw_entry.object.aite_denpyo_kbn[l_row]
l_rec.aite_baika_flg           = dw_entry.object.aite_baika_flg[l_row]
l_rec.nyuryoku_gyosu           = dw_entry.object.nyuryoku_gyosu[l_row]
l_rec.jyutyu_tekiyo_kbn        = dw_entry.object.jyutyu_tekiyo_kbn[l_row]
l_rec.jyutyu_tekiyo            = dw_entry.object.jyutyu_tekiyo[l_row]
l_rec.denpyo_tekiyo_kbn        = dw_entry.object.denpyo_tekiyo_kbn[l_row]
l_rec.denpyo_tekiyo            = dw_entry.object.denpyo_tekiyo[l_row]
l_rec.buturyu_tekiyo_kbn       = dw_entry.object.buturyu_tekiyo_kbn[l_row]
l_rec.buturyu_tekiyo           = dw_entry.object.buturyu_tekiyo[l_row]
l_rec.nohinsyo_bikou_kbn       = dw_entry.object.nohinsyo_bikou_kbn[l_row]
l_rec.nohinsyo_bikou           = dw_entry.object.nohinsyo_bikou[l_row]
l_rec.naiyou_meisai_bikou_kbn  = dw_entry.object.naiyou_meisai_bikou_kbn[l_row]
l_rec.naiyou_meisai_bikou      = dw_entry.object.naiyou_meisai_bikou[l_row]
l_rec.fax_comment_kbn          = dw_entry.object.fax_comment_kbn[l_row]
l_rec.fax_comment              = dw_entry.object.fax_comment[l_row]
l_rec.tyui_jikou_jyutyu        = dw_entry.object.tyui_jikou_jyutyu[l_row]
l_rec.tyui_jikou_kako          = dw_entry.object.tyui_jikou_kako[l_row]
l_rec.rowid                    = dw_entry.object.rowid[l_row]


choose case i_syori_kbn
		
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "入力支援設定の更新でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if
//	case "登録"
//		if not of_db_insert( l_rec ) then
//			return -1
//		end if
//	case "変更"
//		if not of_db_update( l_rec ) then
//			return -1
//		end if
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
string	l_code
long	l_row
long	l_cnt
long	l_syusoku_flg

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

i_mise_code		= dw_entry.object.mise_code[l_row]

if dw_entry.event itemchanged( l_row, dw_entry.object.tokui_code, string(dw_entry.object.tokui_code[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.mise_code, string(dw_entry.object.mise_code[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyutyuzan_flg, string(dw_entry.object.jyutyuzan_flg[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.kakuho_kbn_mei, string(dw_entry.object.kakuho_kbn[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyutyuzan_flg, string(dw_entry.object.jyutyuzan_flg[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyutyuzan_flg, string(dw_entry.object.jyutyuzan_flg[l_row]) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyutyuzan_flg, string(dw_entry.object.jyutyuzan_flg[l_row]) ) <> 0 then
	return -1
end if


if dw_entry.event itemchanged( l_row, dw_entry.object.tyui_jikou_jyutyu, dw_entry.object.tyui_jikou_jyutyu[l_row] ) <> 0 then
	return -1
end if

// 必須チェック
//if len( string( dw_entry.object.mise_mei[l_row] ) ) = 0 then
//	msg.of_error_dwo( dw_entry.object.mise_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "店" ) )
//	dw_entry.setfocus()
//	dw_entry.setcolumn( "mise_mei" )
//	return -1
//end if

long l_tokui_code
long l_mise_code
string l_rowid

l_tokui_code = dw_entry.object.tokui_code[l_row]
l_mise_code = dw_entry.object.mise_code[l_row]
l_rowid	=  dw_entry.object.rowid[l_row]

// 処理区分別チェック
if i_syori_kbn <> "登録" then
	// 重複チェック
	if not of_dwchk_duplicate( dw_entry.object, l_tokui_code, l_mise_code,l_rowid ) then
		return -1
	end if
else
	// 重複チェック
	if not of_dwchk_duplicate( dw_entry.object, l_tokui_code, l_mise_code ) then
		return -1
	end if
end if

// 終息の得意先コードの場合
//if l_syusoku_flg <> 0 then
////	st_syusoku.visible	= true
//end if

// 存在チェック
select count('x')
into :l_syusoku_flg
from m_tokui
where tokui_code	= to_number( :l_tokui_code  )
and syusoku_flg    = 1
using cocos;
	


// 登録は終息の得意先コードは実行不可
if i_syori_kbn = "登録" and l_syusoku_flg <> 0 then
	msg.of_error("得意先が終息のため、この処理は実行できません。" )
	this.setfocus()
	return -1
end if


// 存在チェック
select count('x')
into :l_syusoku_flg
from m_mise
where tokui_code	= to_number( :l_tokui_code  )
and mise_code	= to_number( :l_mise_code  )
and syusoku_flg    = 1
using cocos;
	


// 登録は終息の店コードは実行不可
if i_syori_kbn = "登録" and l_syusoku_flg <> 0 then
	msg.of_error("店が終息のため、この処理は実行できません。" )
	this.setfocus()
	return -1
end if




end event

type uo_signal from iw_main_window`uo_signal within wmm_support_jyutyu
end type

type st_date from iw_main_window`st_date within wmm_support_jyutyu
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_support_jyutyu
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_support_jyutyu
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_support_jyutyu
end type

type st_title from iw_main_window`st_title within wmm_support_jyutyu
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_support_jyutyu
end type

type st_upper from iw_main_window`st_upper within wmm_support_jyutyu
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_support_jyutyu
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_support_jyutyu
integer taborder = 30
end type

event constructor;call super::constructor;
this.enabled	= true

end event

type dw_list from ivo_datawindow within wmm_support_jyutyu
integer x = 16
integer y = 1678
integer width = 4208
integer height = 992
integer taborder = 40
boolean bringtotop = true
string dataobject = "dmm_support_jyutyu_list"
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
l_file	= fnc.strg.of_format( "入力支援設定マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )


if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event doubleclicked;call super::doubleclicked;
long	l_upd_row
string	l_code
long	l_row
long	l_mise_code
long    l_tokui_code

setredraw( false )

if row > 0 then

	i_tokui_code= this.object.tokui_code[row]
	i_mise_code	= this.object.mise_code[row]

	choose case i_syori_kbn
		case "登録"
			// 新規登録の際の参照コピー
			l_row	= long( dw_entry.object.datawindow.firstrowonpage )
			
//			// 存在チェック
//			select max( mise_code )
//  			into :l_mise_code
// 			 from m_nyuryoku_sien
//			using cocos;
//	
//			choose case cocos.sqlcode
//				case 0
//					l_mise_code = l_mise_code + 1
//				case 100
//					l_mise_code = 1
//				case else
//					msg.of_error_sle( this.object.mise_code, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
//					this.setfocus()
//					return 1
//			end choose
			
			dw_entry.object.tokui_code[l_row]           = this.object.tokui_code[row]					
			dw_entry.object.mise_code[l_row]           = this.object.mise_code[row]			
			dw_entry.object.jyutyuzan_flg[l_row]           = this.object.jyutyuzan_flg[row]		
			dw_entry.object.kakuho_kbn[l_row]           = this.object.kakuho_kbn[row]		
    		dw_entry.object.kakuho_kbn_mei[l_row]           = this.object.kakuho_kbn_mei[row]	
   			dw_entry.object.syukka_kbn[l_row]           = this.object.syukka_kbn[row]		
   			dw_entry.object.syukka_kbn_mei[l_row]           = this.object.syukka_kbn_mei[row]	
			dw_entry.object.syukka_kyoten[l_row]           = this.object.syukka_kyoten[row]		
			dw_entry.object.syukka_kyoten_mei[l_row]           = this.object.syukka_kyoten_mei[row]		
			dw_entry.object.syukka_houhou[l_row]           = this.object.syukka_houhou[row]		
			dw_entry.object.syukka_houhou_mei[l_row]           = this.object.syukka_houhou_mei[row]		
			dw_entry.object.zbin_flg[l_row]           = this.object.zbin_flg[row]		
   			dw_entry.object.kakeritu[l_row]           = this.object.kakeritu[row]		
   			dw_entry.object.syobun_flg[l_row]           = this.object.syobun_flg[row]		
   			dw_entry.object.aite_bumon_code[l_row]           = this.object.aite_bumon_code[row]		
   			dw_entry.object.aite_denpyo_kbn[l_row]           = this.object.aite_denpyo_kbn[row]	
   			dw_entry.object.aite_baika_flg[l_row]           = this.object.aite_baika_flg[row]		
   			dw_entry.object.nyuryoku_gyosu[l_row]           = this.object.nyuryoku_gyosu[row]		
  			dw_entry.object.jyutyu_tekiyo_kbn[l_row]           = this.object.jyutyu_tekiyo_kbn[row]		
   			dw_entry.object.jyutyu_tekiyo_kbn_mei[l_row]           = this.object.jyutyu_tekiyo_kbn_mei[row]		
   			dw_entry.object.jyutyu_tekiyo[l_row]           = this.object.jyutyu_tekiyo[row]		
   			dw_entry.object.denpyo_tekiyo_kbn[l_row]           = this.object.denpyo_tekiyo_kbn[row]		
   			dw_entry.object.denpyo_tekiyo_kbn_mei[l_row]           = this.object.denpyo_tekiyo_kbn_mei[row]		
   			dw_entry.object.denpyo_tekiyo[l_row]           = this.object.denpyo_tekiyo[row]		
   			dw_entry.object.buturyu_tekiyo_kbn[l_row]           = this.object.buturyu_tekiyo_kbn[row]		
   			dw_entry.object.buturyu_tekiyo_kbn_mei[l_row]           = this.object.buturyu_tekiyo_kbn_mei[row]		
   			dw_entry.object.buturyu_tekiyo[l_row]           = this.object.buturyu_tekiyo[row]		
   			dw_entry.object.nohinsyo_bikou_kbn[l_row]           = this.object.nohinsyo_bikou_kbn[row]		
   			dw_entry.object.nohinsyo_bikou_kbn_mei[l_row]           = this.object.nohinsyo_bikou_kbn_mei[row]		
   			dw_entry.object.nohinsyo_bikou[l_row]           = this.object.nohinsyo_bikou[row]		
   			dw_entry.object.naiyou_meisai_bikou_kbn[l_row]           = this.object.naiyou_meisai_bikou_kbn[row]		
 			dw_entry.object.naiyou_meisai_bikou_kbn_mei[l_row]           = this.object.naiyou_meisai_bikou_kbn_mei[row]		
			dw_entry.object.naiyou_meisai_bikou[l_row]           = this.object.naiyou_meisai_bikou[row]		
   			dw_entry.object.fax_comment_kbn[l_row]           = this.object.fax_comment_kbn[row]		
   			dw_entry.object.fax_comment_kbn_mei[l_row]           = this.object.fax_comment_kbn_mei[row]	
   			dw_entry.object.fax_comment[l_row]           = this.object.fax_comment[row]		
   			dw_entry.object.tyui_jikou_jyutyu[l_row]           = this.object.tyui_jikou_jyutyu[row]		
   			dw_entry.object.tyui_jikou_kako[l_row]           = this.object.tyui_jikou_kako[row]		
		
			

		case "変更", "削除", "照会"
			// 変更・削除の場合はレコードロック
			if i_syori_kbn <> "照会" then
				// ロック解除はconstructorでやっちゃう
				if uo_signal.of_get_status() then
					dw_entry.event constructor( )
				end if

				// 対象レコードをロックして更新部へ表示
				if not of_record_lock( i_tokui_code,i_mise_code, true ) then
					setredraw( true )
					return -1
				end if
			end if

			// entryDWにコピー
			if dw_entry.retrieve(i_tokui_code,i_mise_code ) > 0 then
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

type ddplb_syori_kbn from sv_ddplb_syori within wmm_support_jyutyu
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

type st_syori_kbn from ivo_statictext within wmm_support_jyutyu
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type dw_entry from ivo_datawindow within wmm_support_jyutyu
integer y = 373
integer width = 5120
integer height = 1237
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_support_jyutyu_entry"
boolean border = false
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;

DataWindowChild	ldwc_kakuho_kbn
DataWindowChild	ldwc_syukka_kbn
DataWindowChild	ldwc_syukka_houhou
DataWindowChild	ldwc_syukka_kyoten
DataWindowChild	ldwc_jyutyu_tekiyo
DataWindowChild	ldwc_denpyo_tekiyo
DataWindowChild	ldwc_buturyu_tekiyo
DataWindowChild	ldwc_nohinsyo_bikou
DataWindowChild	ldwc_naiyou_meisai_bikou
DataWindowChild	ldwc_fax_comment

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "kakuho_kbn_mei", ldwc_kakuho_kbn)
ldwc_kakuho_kbn.settransobject( cocos )

meisyo_kbn		= 210
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_kakuho_kbn.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) // l_rowに入れる必要なし？

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "syukka_kbn_mei", ldwc_syukka_kbn)
ldwc_syukka_kbn.settransobject( cocos )

meisyo_kbn		= 208
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_syukka_kbn.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "syukka_houhou_mei", ldwc_syukka_houhou)
ldwc_syukka_houhou.settransobject( cocos )

meisyo_kbn		= 213
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_syukka_houhou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "syukka_kyoten_mei", ldwc_syukka_kyoten)
ldwc_syukka_kyoten.settransobject( cocos )

meisyo_kbn		= 189
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_syukka_kyoten.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "jyutyu_tekiyo_kbn_mei", ldwc_jyutyu_tekiyo)
ldwc_jyutyu_tekiyo.settransobject( cocos )

meisyo_kbn		= 176
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_jyutyu_tekiyo.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "denpyo_tekiyo_kbn_mei", ldwc_denpyo_tekiyo)
ldwc_denpyo_tekiyo.settransobject( cocos )

meisyo_kbn		= 177
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_denpyo_tekiyo.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "buturyu_tekiyo_kbn_mei", ldwc_buturyu_tekiyo)
ldwc_buturyu_tekiyo.settransobject( cocos )

meisyo_kbn		= 178
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_buturyu_tekiyo.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "nohinsyo_bikou_kbn_mei", ldwc_nohinsyo_bikou)
ldwc_nohinsyo_bikou.settransobject( cocos )

meisyo_kbn		= 179
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_nohinsyo_bikou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "naiyou_meisai_bikou_kbn_mei", ldwc_naiyou_meisai_bikou)
ldwc_naiyou_meisai_bikou.settransobject( cocos )

meisyo_kbn		= 180
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_naiyou_meisai_bikou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "fax_comment_kbn_mei", ldwc_fax_comment)
ldwc_fax_comment.settransobject( cocos )

meisyo_kbn		= 181
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_fax_comment.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 


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
//this.enabled	= false
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
string	l_mise_code
//int	l_mise_code
//string	l_mei
string	l_meisyo_code,l_meisyo_mei

string	l_input
string	l_colnm
string	l_tableid	= "m_nyuryoku_sien"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "tokui_code","mise_code"
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
	case "mise_code"
		// 店コード
		// 数値のみ入力可
		if not isnumber( data ) then
			msg.of_error_dwo( dwo, "数値を入力してください。" )
			return 1
		end if
		l_code = this.object.tokui_code[row]
		// 存在チェック
		select mise_mei
		  into :l_mei
		  from m_mise
		 where tokui_code	= :l_code
		 and mise_code 	= :data
		using cocos	;
		
		choose case cocos.sqlcode
			case 0
				this.object.mise_mei[row]		= trim( l_mei )
			case 100
					msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "jigyo_nendo_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose



		// 処理区分別チェック
		choose case	i_syori_kbn
			case "登録"
//				// 重複チェック
//				if not of_dwchk_duplicate( dwo, data ) then
//					return 1
//				end if
		end choose
		
		// 桁セット
		l_mise_code		= string(this.object.mise_code[row])
		if isnull( l_mise_code ) then
			l_mise_code	= ""
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

	case "kakuho_kbn_mei"
							
		l_mei	= data 
	
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.kakuho_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
		
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 210
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.kakuho_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("kakuho_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "syukka_kbn_mei"
							
		l_mei	= data
		
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.syukka_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
		
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 208
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.syukka_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("syukka_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "syukka_houhou_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.syukka_houhou_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
		
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 213
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.syukka_houhou[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("syukka_houhou_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "syukka_kyoten_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.syukka_kyoten_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 189
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.syukka_kyoten[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("syukka_kyoten_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "jyutyu_tekiyo_kbn_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.jyutyu_tekiyo_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 176
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.jyutyu_tekiyo_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("jyutyu_tekiyo_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "denpyo_tekiyo_kbn_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.denpyo_tekiyo_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
		
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 177
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.denpyo_tekiyo_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("denpyo_tekiyo_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "buturyu_tekiyo_kbn_mei"
							
		l_mei	= data 
	
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.buturyu_tekiyo_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 178
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.buturyu_tekiyo_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("buturyu_tekiyo_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "nohinsyo_bikou_kbn_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.nohinsyo_bikou_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 179
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.nohinsyo_bikou_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("nohinsyo_bikou_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "naiyou_meisai_bikou_kbn_mei"
							
		l_mei	= data 
	
		if  data=""  then
			msg.of_error_dwo( dw_entry.object.naiyou_meisai_bikou_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if

		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 180
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.naiyou_meisai_bikou_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("naiyou_meisai_bikou_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose
	
	case "fax_comment_kbn_mei"
							
		l_mei	= data 

		if  data=""  then
			msg.of_error_dwo( dw_entry.object.fax_comment_kbn_mei, fnc.strg.of_format( "必須入力項目に値が設定されていません。[ {1} ]", "入力支援設定" ) )
//			dw_entry.setfocus()
//			dw_entry.setcolumn( "printer_syubetu_mei" )
			return 1
		end if
	
		// 存在チェック
		select meisyo_code,meisyo_1
		into :l_meisyo_code,:l_meisyo_mei
		from m_meisyo
		where meisyo_kbn	= 181
		and meisyo_code	= :l_mei
		using cocos;
		
		choose case cocos.sqlcode
			case 0
				this.object.fax_comment_kbn[row]	= integer(l_meisyo_code)
			case 100
				msg.of_error_dwo(dwo, fnc.strg.of_format("入力された{1}はマスタに存在しません。", describe(dwo.name + ".tag")))
				return 1
			case else
				msg.of_error_dwo(dwo, fnc.strg.of_format("{1}入力チェック中にエラーが発生しました{2}（{3}）", describe("fax_comment_kbn_mei.text"), code.crlf, fnc.strg.of_replace(cocos.sqlerrtext, code.lf, " ")))
				return 1
		end choose

	case else

end choose

return 0
end event

event buttonclicked;call super::buttonclicked;
// F8:参照
choose case dwo.name
	case "b_tokui"
		
		//if this.object.taisyo_kbn=4
		
		// 参照起動
		of_reference( this, dwo, row )
		
	case "b_mise"
		
		//if this.object.taisyo_kbn=4
		
		// 参照起動
		of_reference( this, dwo, row )
		
end choose
end event

type uo_tokui from cv_input_tokui within wmm_support_jyutyu
integer x = 36
integer y = 260
integer taborder = 20
boolean bringtotop = true
end type

event constructor;call super::constructor;
uo_tokui.of_set_enabled(true)
end event

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

