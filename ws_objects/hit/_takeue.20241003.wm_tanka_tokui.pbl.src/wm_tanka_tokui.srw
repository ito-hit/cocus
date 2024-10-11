$PBExportHeader$wm_tanka_tokui.srw
$PBExportComments$単価一括登録(1得意先全商品)
forward
global type wm_tanka_tokui from iw_main_window
end type
type st_target_syohin from ivo_statictext within wm_tanka_tokui
end type
type rb_haiban_2 from ivo_radiobutton within wm_tanka_tokui
end type
type rb_haiban_1 from ivo_radiobutton within wm_tanka_tokui
end type
type st_haiban_kbn from ivo_statictext within wm_tanka_tokui
end type
type st_tokuisaki_namidash from ivo_statictext within wm_tanka_tokui
end type
type sle_syohin_code_from from ivo_singlelineedit within wm_tanka_tokui
end type
type sle_syohin_code_to from ivo_singlelineedit within wm_tanka_tokui
end type
type st_tokuisaki_code from ivo_statictext within wm_tanka_tokui
end type
type st_syohin_bikou from ivo_statictext within wm_tanka_tokui
end type
type rb_uwagaki_no from ivo_radiobutton within wm_tanka_tokui
end type
type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_tokui
end type
type st_uwagaki from ivo_statictext within wm_tanka_tokui
end type
type dw_list from ivo_datawindow within wm_tanka_tokui
end type
type uo_tokui from cv_input_tokui_tanto within wm_tanka_tokui
end type
type cbx_tankahyo_9 from ivo_checkbox within wm_tanka_tokui
end type
type cbx_tankahyo_1 from ivo_checkbox within wm_tanka_tokui
end type
type cbx_tankahyo_2 from ivo_checkbox within wm_tanka_tokui
end type
type st_tankahyo_hakkou_kbn from ivo_statictext within wm_tanka_tokui
end type
type cbx_tankahyo_3 from ivo_checkbox within wm_tanka_tokui
end type
type rb_haiban_3 from ivo_radiobutton within wm_tanka_tokui
end type
type rb_haiban_9 from ivo_radiobutton within wm_tanka_tokui
end type
type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_tokui
end type
type st_syohizei_kbn from sv_st_meisyo within wm_tanka_tokui
end type
type gb_haiban_kbn from ivo_groupbox within wm_tanka_tokui
end type
type gb_uwagaki from ivo_groupbox within wm_tanka_tokui
end type
type gb_tankahyo from ivo_groupbox within wm_tanka_tokui
end type
end forward

global type wm_tanka_tokui from iw_main_window
string title = "単価一括登録（１商品全得意先）"
boolean minbox = false
boolean center = false
boolean f12_key = true
st_target_syohin st_target_syohin
rb_haiban_2 rb_haiban_2
rb_haiban_1 rb_haiban_1
st_haiban_kbn st_haiban_kbn
st_tokuisaki_namidash st_tokuisaki_namidash
sle_syohin_code_from sle_syohin_code_from
sle_syohin_code_to sle_syohin_code_to
st_tokuisaki_code st_tokuisaki_code
st_syohin_bikou st_syohin_bikou
rb_uwagaki_no rb_uwagaki_no
rb_uwagaki_yes rb_uwagaki_yes
st_uwagaki st_uwagaki
dw_list dw_list
uo_tokui uo_tokui
cbx_tankahyo_9 cbx_tankahyo_9
cbx_tankahyo_1 cbx_tankahyo_1
cbx_tankahyo_2 cbx_tankahyo_2
st_tankahyo_hakkou_kbn st_tankahyo_hakkou_kbn
cbx_tankahyo_3 cbx_tankahyo_3
rb_haiban_3 rb_haiban_3
rb_haiban_9 rb_haiban_9
st_tanka_touroku_flg st_tanka_touroku_flg
st_syohizei_kbn st_syohizei_kbn
gb_haiban_kbn gb_haiban_kbn
gb_uwagaki gb_uwagaki
gb_tankahyo gb_tankahyo
end type
global wm_tanka_tokui wm_tanka_tokui

type variables
private:
	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	integer	i_permission
	
	// 呼出し部の情報を保管
	string	i_syori_kbn

	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時

	// ダブルクリック状態検知
	boolean	i_doubleclicked

	// 単価マスタ用データストア
	datastore	dw_tanka

end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_back ()
public subroutine of_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock ()
public function boolean of_update ()
public function integer of_datastore ()
protected subroutine of_set_firstfocus ()
protected subroutine of_set_secondfocus ()
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);// p_controlによって、ロックやフォーカスを制御する
long	l_row

choose case p_control
	case "callsection"
		// 呼び出し部のロック状態を制御する
		uo_tokui.of_set_enabled( p_enabled )

	case "detailsection"
		// 明細部
		dw_list.enabled							= p_enabled
		sle_syohin_code_from.enabled			= p_enabled
		sle_syohin_code_to.enabled				= p_enabled

		gb_tankahyo.enabled						= p_enabled
		cbx_tankahyo_9.enabled					= p_enabled
		cbx_tankahyo_1.enabled					= p_enabled
		cbx_tankahyo_2.enabled					= p_enabled
		cbx_tankahyo_3.enabled					= p_enabled

		gb_haiban_kbn.enabled					= p_enabled
		rb_haiban_1.enabled						= p_enabled
		rb_haiban_2.enabled						= p_enabled
		rb_haiban_3.enabled						= p_enabled
		rb_haiban_9.enabled						= p_enabled

		gb_uwagaki.enabled						= p_enabled
		rb_uwagaki_yes.enabled					= p_enabled
		rb_uwagaki_no.enabled					= p_enabled

end choose
end subroutine

public subroutine of_back ();// F6：戻りの処理

setredraw( false )

// 明細部
of_dsp_edit( "detailsection", false )

dw_list.reset()

sle_syohin_code_from.event constructor( )
sle_syohin_code_to.event constructor( )

cbx_tankahyo_9.checked = true
cbx_tankahyo_1.checked = true
cbx_tankahyo_2.checked = true
cbx_tankahyo_3.checked = true

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_uwagaki_yes.checked = false
rb_uwagaki_no.checked = true

// 呼び出し部
of_dsp_edit( "callsection", true )
of_set_firstfocus( )

setredraw( true )

end subroutine

public subroutine of_reset ();// F9：初期表示

i_syori_kbn = "初期"

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
setredraw( false )

// ヘッダ部
of_dsp_edit( "callsection", true )

uo_tokui.event constructor( )
st_syohizei_kbn.event constructor()
st_tanka_touroku_flg.event constructor()
st_syohizei_kbn.visible = false
st_tanka_touroku_flg.visible = false

// 明細部
of_dsp_edit( "detailsection", false )

dw_list.reset()

sle_syohin_code_from.event constructor( )
sle_syohin_code_to.event constructor( )

cbx_tankahyo_9.checked = true
cbx_tankahyo_1.checked = true
cbx_tankahyo_2.checked = true
cbx_tankahyo_3.checked = true

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_uwagaki_yes.checked = false
rb_uwagaki_no.checked = true

setredraw( true )

of_set_firstfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);// p_rowidを使って、haita_flgに1を立てる
long		l_row_count
long		l_row
integer	l_haita_flg
datetime	l_sysdate
long		l_ret

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

select sysdate
  into :l_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	return false
end if

// フィルタを更新対象とする
dw_tanka.setfilter("not isnull(m_tanka_rowid)")
dw_tanka.filter()

l_row_count = dw_tanka.rowcount()
for l_row = 1 to l_row_count
	dw_tanka.SetItem(l_row,"haita_flg"			,l_haita_flg)
	dw_tanka.SetItem(l_row,"henkou_date"		,l_sysdate)
	dw_tanka.SetItem(l_row,"henkou_user_id"	,user.user_id)
	dw_tanka.SetItem(l_row,"henkou_client_id"	,device.name)
	dw_tanka.SetItem(l_row,"henkou_pg_id"		,i_pg_id)
next
l_ret = dw_tanka.update()
if l_ret = 1 then
	commit using cocos;
	// ランプの色を制御する
	uo_signal.of_on_signal( p_lock )
else
	rollback using cocos;
	msg.of_error_db( "単価マスタのレコードロックでエラーが発生しました。", cocos )
	return false
end if

return true

end function

public function boolean of_record_lock ();// rowidを探して、ロックをかける
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

long		l_count

// 上書きしない場合は排他チェック、更新をしない
if rb_uwagaki_no.checked then
	return true
end if

// 該当する単価M.排他フラグ=1の場合
dw_tanka.setfilter( "haita_flg=1 and not isnull(m_tanka_rowid)" )
dw_tanka.filter()

l_count = dw_tanka.rowcount()
if l_count > 0 then
//	msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
	msg.of_error( "他の端末で編集中です。" )
	return false
end if

// フィルタを戻す
dw_tanka.setfilter("")
dw_tanka.filter()

// 実際にhaita_flgに1を立てるのはここ
return of_record_lock_rowid( l_rowid, true )

end function

public function boolean of_update ();// 更新登録処理
long		l_loop
long		l_row
long		l_row_count
integer	l_haita_flg
boolean	l_lock
datetime	l_sysdate
long		l_ret
string	l_m_tanka_rowid

l_lock = false
l_haita_flg	= 0

select sysdate
  into :l_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

long		l_syohizei_ritu
long		l_syohin_code
long		l_up_iti
decimal	l_up_gaku[6]
long		l_tokui_code
long		l_syohizei_kbn
long		l_kakaku_group_kbn
decimal	l_kakeritu
long		l_upkomi_kbn
decimal	l_tanka
decimal	l_old_tanka
decimal	l_new_tanka
decimal	l_jyoudai

l_tokui_code = long( trim( uo_tokui.of_get_input() ) )

// 単価M.消費税率 = 消費税率M.消費税率(取引区分＝1、消費税率区分＝1、適用日はシステム日付で合致)
select	syohizei_ritu
into		:l_syohizei_ritu
from		m_zeiritu
where		m_zeiritu.torihiki_kbn		= 1
and		m_zeiritu.zeiritu_kbn		= 1
and		to_number(to_char(SYSDATE,'YYYYMMDD'))
			between m_zeiritu.zeiritu_str_date and m_zeiritu.zeiritu_end_date
using		cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

// 上書きする場合のみ更新をする
if rb_uwagaki_yes.checked then
	// フィルタを全件(更新対象と登録対象)とする
	dw_tanka.setfilter("")
	dw_tanka.filter()
else
	// フィルタを登録対象のみ
	dw_tanka.setfilter("isnull(m_tanka_rowid)")
	dw_tanka.filter()
end if

l_row_count = dw_tanka.rowcount()
for l_loop = 1 to l_row_count
	l_m_tanka_rowid = dw_tanka.GetItemString(l_loop,"m_tanka_rowid")
	if IsNull(l_m_tanka_rowid) then
		// 登録対象
		l_row = dw_tanka.insertrow(0)						// データウィンドウの初期値設定済
		l_syohin_code = dw_tanka.GetItemDecimal(l_loop,"m_syohin_syohin_code")
		dw_tanka.SetItem(l_row,"tokui_code"				,l_tokui_code)
		dw_tanka.SetItem(l_row,"syohin_code"			,l_syohin_code)	// dw_tanka.GetItemDecimal(l_loop,"m_syohin_syohin_code"))

		dw_tanka.SetItem(l_row,"touroku_date"			,l_sysdate)
		dw_tanka.SetItem(l_row,"touroku_user_id"		,user.user_id)
		dw_tanka.SetItem(l_row,"touroku_client_id"	,device.name)
		dw_tanka.SetItem(l_row,"touroku_pg_id"			,i_pg_id)
	else
		// 更新対象
		l_row = l_loop

		dw_tanka.SetItem(l_row,"henkou_date"			,l_sysdate)
		dw_tanka.SetItem(l_row,"henkou_user_id"		,user.user_id)
		dw_tanka.SetItem(l_row,"henkou_client_id"		,device.name)
		dw_tanka.SetItem(l_row,"henkou_pg_id"			,i_pg_id)
		dw_tanka.SetItem(l_row,"kousin_date"			,l_sysdate)
		dw_tanka.SetItem(l_row,"kousin_user_id"		,user.user_id)
		dw_tanka.SetItem(l_row,"kousin_client_id"		,device.name)
		dw_tanka.SetItem(l_row,"kousin_pg_id"			,i_pg_id)
	end if

	l_syohin_code = dw_tanka.GetItemDecimal(l_row,"syohin_code")


	// 商品マスタから、価格グループ区分取得、上代を取得
	select	distinct
				kakaku_group_kbn
	,			jyoudai
	into		:l_kakaku_group_kbn
	,			:l_jyoudai
	from		m_syohin
	where		m_syohin.syohin_code				= :l_syohin_code
	and		rownum								= 1
	using		cocos;
	
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		of_add_db_log( "of_update-3", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
		return false
	end if

	// 掛率（※1） = 掛率M.掛率(商品M.価格グループ区分 = 掛率M.価格グループ区分 AND 掛率M.得意先コード = 画面.得意先コード)
	select	kakeritu
	,			upkomi_kbn
	into		:l_kakeritu
	,			:l_upkomi_kbn
	from		m_kakeritu
	where		m_kakeritu.kakaku_group_kbn	= :l_kakaku_group_kbn
	and		m_kakeritu.tokui_code			= :l_tokui_code
	using		cocos;
	
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		of_add_db_log( "of_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
		return false
	end if

	// 掛率M.アップ額込み区分 → 単価M.アップ額1～5
	choose case l_upkomi_kbn
		case	0 to 4
			// 掛率M.アップ額込み区分が0の場合　※別紙「UP額」参照
			// 単価M.アップ額(数字) = 商品Mのアップ額を商品コード、アップ位置でGROUP BYして値を取得しセット
			// 掛率M.アップ額込み区分が1～4の場合
			// 単価M.アップ額(数字) = 掛率M.アップ額込み区分 の値より大きい(数字)の単価M.アップ額(数字)に商品M.アップ額をセット
			for l_up_iti = l_upkomi_kbn + 1 to 5

				select	distinct	up_gaku
				into		:l_up_gaku[l_up_iti]
				from		m_syohin
				where		m_syohin.syohin_code		= :l_syohin_code
				and		m_syohin.up_iti			= :l_up_iti
				and		rownum						= 1
				using		cocos;
			
				if cocos.sqlcode = 100 then
					l_up_gaku[l_up_iti] = 0
				elseif cocos.sqlcode <> 0 then
					rollback using cocos;
					msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
					of_add_db_log( "of_update-5", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
					return false
				end if

				dw_tanka.SetItem(l_row,"up_" + String(l_up_iti),l_up_gaku[l_up_iti])
			next
		case	5
			// 掛率M.アップ額込み区分が5の場合
			// 単価M.アップ額1～5 = 全て0をセット
			dw_tanka.SetItem(l_row,"up_1",0)
			dw_tanka.SetItem(l_row,"up_2",0)
			dw_tanka.SetItem(l_row,"up_3",0)
			dw_tanka.SetItem(l_row,"up_4",0)
			dw_tanka.SetItem(l_row,"up_5",0)
	end choose

	// 単価M.前回単価 = 前回の単価M.単価をセットする
	l_old_tanka = dw_tanka.GetItemDecimal(l_row,"tanka")
	if IsNull(l_old_tanka) then
		l_old_tanka = 0
	end if
	dw_tanka.SetItem(l_row,"old_tanka",l_old_tanka)
	// 単価M.単価 = 商品M.上代価格(画面.商品コード = 商品M.商品コード) ×（※1÷100）　10 円の位まで四捨五入
	l_tanka = l_jyoudai * l_kakeritu / 100
	l_tanka = Round(l_tanka / 100,0) * 100		// 100円未満四捨五入
	dw_tanka.SetItem(l_row,"tanka",l_tanka)
	// 単価M.単価変更日 = システム日付をセット
	dw_tanka.SetItem(l_row,"tanka_henkou_date",fo_num_today())

	// 単価M.消費税区分 = 得意先M.消費税区分
	select	syohizei_kbn
	into		:l_syohizei_kbn
	from		m_tokui
	where		m_tokui.tokui_code		= :l_tokui_code
	using		cocos;
	
	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		of_add_db_log( "of_update-6", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
		return false
	end if

	dw_tanka.SetItem(l_row,"zei_kbn",l_syohizei_kbn)

	// 単価M.消費税率 = 消費税率M.消費税率(取引区分＝1、消費税率区分＝1、適用日はシステム日付で合致)
	dw_tanka.SetItem(l_row,"zeiritu",l_syohizei_ritu)

	// 単価M.新単価～新単価適用終了日 = 単価M.新単価と単価M.単価が同じ場合はクリアする
	l_new_tanka = dw_tanka.GetItemDecimal(l_row,"new_tanka")
	if l_tanka = l_new_tanka then
		dw_tanka.SetItem(l_row,"new_tanka"			,0)
		dw_tanka.SetItem(l_row,"new_up_1"			,0)
		dw_tanka.SetItem(l_row,"new_up_2"			,0)
		dw_tanka.SetItem(l_row,"new_up_3"			,0)
		dw_tanka.SetItem(l_row,"new_up_4"			,0)
		dw_tanka.SetItem(l_row,"new_up_5"			,0)
		dw_tanka.SetItem(l_row,"new_zei_kbn"		,0)
		dw_tanka.SetItem(l_row,"new_zeiritu"		,0)
		dw_tanka.SetItem(l_row,"new_jyodai"			,0)
		dw_tanka.SetItem(l_row,"new_kakeritu"		,0)
		dw_tanka.SetItem(l_row,"tekiyo_date_str"	,0)
		dw_tanka.SetItem(l_row,"tekiyo_date_end"	,0)
	end if

	dw_tanka.SetItem(l_row,"haita_flg"				,l_haita_flg)
next

l_ret = dw_tanka.update()
if l_ret = 1 then
	commit using cocos;
	// ランプの色を制御する
	uo_signal.of_on_signal( l_lock )
else
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-7", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if


return true

end function

public function integer of_datastore ();// 単価マスタデータストアの条件を設定し読み込む
long		l_row
long		l_tokui_code
string	l_kakaku_group_kbn
long		l_syohin_from
long		l_syohin_to
string	l_tankahyo_hakkou_kbn
long		l_haiban_kbn
string	l_code
long		l_count

// 得意先コード
l_tokui_code = long( trim( uo_tokui.of_get_input() ) )
// 対象商品
l_kakaku_group_kbn = ""
for l_row = 1 to dw_list.rowcount()
	if dw_list.GetItemString(l_row,"chkbox") = "0" then
		continue
	end if
	if l_kakaku_group_kbn <> "" then
		l_kakaku_group_kbn = l_kakaku_group_kbn + ","
	end if
	l_kakaku_group_kbn = l_kakaku_group_kbn + string(dw_list.GetItemDecimal(l_row,"kakaku_group_kbn"))
next
// 商品コード範囲 開始
l_code = sle_syohin_code_from.text
if l_code = "" then
	l_code = "0"
end if
l_syohin_from = long( l_code )
// 商品コード範囲 終了
l_code = sle_syohin_code_to.text
if l_code = "" then
	l_code = "9999999"
end if
l_syohin_to = long( l_code )
// 単価表発行
l_tankahyo_hakkou_kbn = ""
if cbx_tankahyo_9.checked then
	if l_tankahyo_hakkou_kbn <> "" then
		l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + ","
	end if
	l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + cbx_tankahyo_9.tag
end if
if cbx_tankahyo_1.checked then
	if l_tankahyo_hakkou_kbn <> "" then
		l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + ","
	end if
	l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + cbx_tankahyo_1.tag
end if
if cbx_tankahyo_2.checked then
	if l_tankahyo_hakkou_kbn <> "" then
		l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + ","
	end if
	l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + cbx_tankahyo_2.tag
end if
if cbx_tankahyo_3.checked then
	if l_tankahyo_hakkou_kbn <> "" then
		l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + ","
	end if
	l_tankahyo_hakkou_kbn = l_tankahyo_hakkou_kbn + cbx_tankahyo_3.tag
end if
// 廃番区分
l_haiban_kbn = 0
if rb_haiban_1.checked then
	l_haiban_kbn = long(rb_haiban_1.tag)
end if
if rb_haiban_2.checked then
	l_haiban_kbn = long(rb_haiban_2.tag)
end if
if rb_haiban_3.checked then
	l_haiban_kbn = long(rb_haiban_3.tag)
end if
if rb_haiban_9.checked then
	l_haiban_kbn = long(rb_haiban_9.tag)
end if

// データ読み込み
l_count = dw_tanka.retrieve(l_tokui_code,l_kakaku_group_kbn,l_syohin_from,l_syohin_to,l_tankahyo_hakkou_kbn,l_haiban_kbn)

if l_count < 0 then
	msg.of_error_db( "更新対象の読み込みでエラーが発生しました。", cocos )
else
	if l_count > 0 then
		// 上書きする場合のみ更新をする
		if rb_uwagaki_yes.checked then
			// フィルタを全件(更新対象と登録対象)とする
			dw_tanka.setfilter("")
			dw_tanka.filter()
		else
			// フィルタを登録対象のみ
			dw_tanka.setfilter("IsNull(m_tanka_rowid)")
			dw_tanka.filter()
		end if
		l_count = dw_tanka.rowcount()
	end if
	if dw_tanka.rowcount() = 0 then
		msg.of_error( "更新対象のデータがありません。" )
	end if
end if

return l_count

end function

protected subroutine of_set_firstfocus ();
uo_tokui.setfocus()
uo_tokui.sle_input.setfocus()

end subroutine

protected subroutine of_set_secondfocus ();
dw_list.setfocus()

end subroutine

on wm_tanka_tokui.create
int iCurrent
call super::create
this.st_target_syohin=create st_target_syohin
this.rb_haiban_2=create rb_haiban_2
this.rb_haiban_1=create rb_haiban_1
this.st_haiban_kbn=create st_haiban_kbn
this.st_tokuisaki_namidash=create st_tokuisaki_namidash
this.sle_syohin_code_from=create sle_syohin_code_from
this.sle_syohin_code_to=create sle_syohin_code_to
this.st_tokuisaki_code=create st_tokuisaki_code
this.st_syohin_bikou=create st_syohin_bikou
this.rb_uwagaki_no=create rb_uwagaki_no
this.rb_uwagaki_yes=create rb_uwagaki_yes
this.st_uwagaki=create st_uwagaki
this.dw_list=create dw_list
this.uo_tokui=create uo_tokui
this.cbx_tankahyo_9=create cbx_tankahyo_9
this.cbx_tankahyo_1=create cbx_tankahyo_1
this.cbx_tankahyo_2=create cbx_tankahyo_2
this.st_tankahyo_hakkou_kbn=create st_tankahyo_hakkou_kbn
this.cbx_tankahyo_3=create cbx_tankahyo_3
this.rb_haiban_3=create rb_haiban_3
this.rb_haiban_9=create rb_haiban_9
this.st_tanka_touroku_flg=create st_tanka_touroku_flg
this.st_syohizei_kbn=create st_syohizei_kbn
this.gb_haiban_kbn=create gb_haiban_kbn
this.gb_uwagaki=create gb_uwagaki
this.gb_tankahyo=create gb_tankahyo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_target_syohin
this.Control[iCurrent+2]=this.rb_haiban_2
this.Control[iCurrent+3]=this.rb_haiban_1
this.Control[iCurrent+4]=this.st_haiban_kbn
this.Control[iCurrent+5]=this.st_tokuisaki_namidash
this.Control[iCurrent+6]=this.sle_syohin_code_from
this.Control[iCurrent+7]=this.sle_syohin_code_to
this.Control[iCurrent+8]=this.st_tokuisaki_code
this.Control[iCurrent+9]=this.st_syohin_bikou
this.Control[iCurrent+10]=this.rb_uwagaki_no
this.Control[iCurrent+11]=this.rb_uwagaki_yes
this.Control[iCurrent+12]=this.st_uwagaki
this.Control[iCurrent+13]=this.dw_list
this.Control[iCurrent+14]=this.uo_tokui
this.Control[iCurrent+15]=this.cbx_tankahyo_9
this.Control[iCurrent+16]=this.cbx_tankahyo_1
this.Control[iCurrent+17]=this.cbx_tankahyo_2
this.Control[iCurrent+18]=this.st_tankahyo_hakkou_kbn
this.Control[iCurrent+19]=this.cbx_tankahyo_3
this.Control[iCurrent+20]=this.rb_haiban_3
this.Control[iCurrent+21]=this.rb_haiban_9
this.Control[iCurrent+22]=this.st_tanka_touroku_flg
this.Control[iCurrent+23]=this.st_syohizei_kbn
this.Control[iCurrent+24]=this.gb_haiban_kbn
this.Control[iCurrent+25]=this.gb_uwagaki
this.Control[iCurrent+26]=this.gb_tankahyo
end on

on wm_tanka_tokui.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_target_syohin)
destroy(this.rb_haiban_2)
destroy(this.rb_haiban_1)
destroy(this.st_haiban_kbn)
destroy(this.st_tokuisaki_namidash)
destroy(this.sle_syohin_code_from)
destroy(this.sle_syohin_code_to)
destroy(this.st_tokuisaki_code)
destroy(this.st_syohin_bikou)
destroy(this.rb_uwagaki_no)
destroy(this.rb_uwagaki_yes)
destroy(this.st_uwagaki)
destroy(this.dw_list)
destroy(this.uo_tokui)
destroy(this.cbx_tankahyo_9)
destroy(this.cbx_tankahyo_1)
destroy(this.cbx_tankahyo_2)
destroy(this.st_tankahyo_hakkou_kbn)
destroy(this.cbx_tankahyo_3)
destroy(this.rb_haiban_3)
destroy(this.rb_haiban_9)
destroy(this.st_tanka_touroku_flg)
destroy(this.st_syohizei_kbn)
destroy(this.gb_haiban_kbn)
destroy(this.gb_uwagaki)
destroy(this.gb_tankahyo)
end on

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )

end event

event open;call super::open;
// 初期表示
of_reset()
of_set_firstfocus( )

end event

event key_f12;call super::key_f12;// 更新ボタン

if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0
end event

event retrieve_check;call super::retrieve_check;
// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

// 変更可能かどうか、権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出して強制的に照会モードにする）
if i_permission <> 0 then
	if not i_admin then
		msg.of_warning( "入力された定数区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
//		ddplb_syori_kbn.text	= "照会"
	end if
end if

// エラーメッセージ(No2)
if uo_tokui.of_get_syusoku_flg() = 1 then
	msg.of_error( "終息の得意先は指定できません。" )
	return -1
end if

// エラーメッセージ(No3)
if st_syohizei_kbn.text = "2" then
	msg.of_error( "単価税込の得意先は指定できません。" )
	return -1
end if

// エラーメッセージ(No4)
if st_tanka_touroku_flg.text = "0" then
	msg.of_error( "この得意先は、単価一括登録「しない」に設定されています。" )
	return -1
end if

return 0

end event

event retrieve_event;call super::retrieve_event;long	l_tokui_code
long	l_row

l_tokui_code = long( trim( uo_tokui.of_get_input( ) ) )

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= "表示"

setredraw( false )

// 呼出部をロックする
of_dsp_edit( "callsection", false )

// 明細部
of_dsp_edit( "detailsection", true )

dw_list.reset()
dw_list.modify( "chkbox.Protect='1~tif( kakeritu = 0 , 1 , 0 )'")	// 掛率0は選択不可
dw_list.retrieve(l_tokui_code)
dw_list.setfocus()

sle_syohin_code_from.event constructor( )
sle_syohin_code_to.event constructor( )

cbx_tankahyo_9.checked = true
cbx_tankahyo_1.checked = true
cbx_tankahyo_2.checked = true
cbx_tankahyo_3.checked = true

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_uwagaki_yes.checked = false
rb_uwagaki_no.checked = true

setredraw( true )

end event

event key_f06;call super::key_f06;// 戻り

of_back()

return 0
end event

event key_f09;call super::key_f09;// 初期表示

if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_reset()
end if

return 0
end event

event update_check;call super::update_check;long	l_count
long	l_row

// DWの入力規則チェック
l_count = 0
for l_row = 1 to dw_list.rowcount()
	if dw_list.GetItemString(l_row,"chkbox") = "1" then
		l_count ++
	end if
next
if l_count = 0 then
	msg.of_error( dw_list.tag + "は必須入力です。" )
	dw_list.setfocus()
	return -1
end if

// 入力チェック
if not sle_syohin_code_from.event input_check( ) then
	return -1
end if
if not sle_syohin_code_to.event input_check( ) then
	return -1
end if

return 0

end event

event update_event;call super::update_event;long	l_ret
long	l_count

l_ret = 0
i_syori_kbn = "更新"

dw_tanka = create datastore
dw_tanka.dataobject 	= "ds_tanka_tokui_tanka"
dw_tanka.settransobject(cocos)  

// 対象レコードを検索
if l_ret = 0 then
	l_count = of_datastore()
	if l_count <= 0 then
		l_ret = -1
	end if
end if

// 対象レコードをロック
if l_ret = 0 then
	if not of_record_lock() then
		l_ret = -1
	end if
end if

// 対象レコードを更新
if l_ret = 0 then
	if not of_update() then
		l_ret = -1
	end if
end if

if l_ret = 0 then
	msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )
	commit using cocos;
else
	rollback using cocos;
end if

destroy dw_tanka

// 戻る 処理
this.of_back()

return l_ret

end event

event key_f01;call super::key_f01;// F1:全選択
long		l_row
long		l_count_on
long		l_count_off
string	l_chkbox

l_count_on = 0

// チェック状態を確認
for l_row = 1 to dw_list.rowcount()
	if dw_list.GetItemDecimal(l_row,"kakeritu") = 0 then
		// チェック不可
		continue
	end if
	l_chkbox = dw_list.GetItemString(l_row,"chkbox")
	if l_chkbox = "0" then
		l_count_off ++
	else
		l_count_on ++
	end if
next

// 全てON→全てOFF
if l_count_off = 0 and l_count_on > 0 then
	l_chkbox = "0"
else
	// 全てOFF または 一部ON→全てON
	l_chkbox = "1"
end if
for l_row = 1 to dw_list.rowcount()
	if dw_list.GetItemDecimal(l_row,"kakeritu") = 0 then
		// チェック不可
		continue
	end if
	dw_list.SetItem(l_row,"chkbox",l_chkbox)
next

return 0

end event

type uo_signal from iw_main_window`uo_signal within wm_tanka_tokui
end type

type st_date from iw_main_window`st_date within wm_tanka_tokui
end type

type st_user_mei from iw_main_window`st_user_mei within wm_tanka_tokui
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_tanka_tokui
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_tanka_tokui
end type

type st_title from iw_main_window`st_title within wm_tanka_tokui
end type

type st_title_upper from iw_main_window`st_title_upper within wm_tanka_tokui
end type

type st_upper from iw_main_window`st_upper within wm_tanka_tokui
end type

type st_second_upper from iw_main_window`st_second_upper within wm_tanka_tokui
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_tanka_tokui
integer taborder = 60
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

type st_target_syohin from ivo_statictext within wm_tanka_tokui
integer x = 32
integer y = 494
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "対象商品"
alignment alignment = right!
end type

type rb_haiban_2 from ivo_radiobutton within wm_tanka_tokui
string tag = "2"
integer x = 912
integer y = 1330
integer width = 408
long backcolor = 553648127
string text = "F／Oまで"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_haiban_1 from ivo_radiobutton within wm_tanka_tokui
string tag = "1"
integer x = 464
integer y = 1330
integer width = 428
long backcolor = 553648127
string text = "現行品のみ"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_haiban_kbn from ivo_statictext within wm_tanka_tokui
string tag = "122"
integer x = 32
integer y = 1330
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "廃番区分"
alignment alignment = right!
end type

type st_tokuisaki_namidash from ivo_statictext within wm_tanka_tokui
integer x = 780
integer y = 1038
integer width = 88
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_syohin_code_from from ivo_singlelineedit within wm_tanka_tokui
string tag = "商品CD"
integer x = 444
integer y = 1038
integer width = 316
integer taborder = 40
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999999"
integer limit = 7
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_required = true
boolean chk_digits = true
integer i_limit = 7
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event input_check;call super::input_check;string	l_code
long		l_code_from
long		l_code_to

this.text	= trim( this.text )
l_code		= this.text

// 空の場合
if l_code = "" then
	if chk_required then
		of_msg_error( this.tag + "は必須入力です。" )
		this.setfocus()
		return false
	end if
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_code_from	= long( l_code )
l_code_to		= long( sle_syohin_code_to.text )

//前後関係チェック
if l_code_to > 0 then
	if l_code_from > l_code_to then
		this.of_msg_error( "商品コードの前後関係が不正です。" )
		return false
	end if
end if

return true

end event

event key_f08;call super::key_f08;str_mdlpara_msyohin	l_syohin

l_syohin = mdl.of_open_modal( "wsm_syohin", l_syohin )

if upperbound(l_syohin.ret) > 0 then
	this.text	= string( l_syohin.ret[1].syohin_code )
end if

return 0

end event

type sle_syohin_code_to from ivo_singlelineedit within wm_tanka_tokui
string tag = "商品CD"
integer x = 868
integer y = 1038
integer width = 316
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
string text = "9999999"
integer limit = 7
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_required = true
boolean chk_digits = true
integer i_limit = 7
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event input_check;call super::input_check;string	l_code
long		l_code_from
long		l_code_to

this.text	= trim( this.text )
l_code		= this.text

// 空の場合
if l_code = "" then
	if chk_required then
		of_msg_error( this.tag + "は必須入力です。" )
		this.setfocus()
		return false
	end if
end if

// 数値チェック
if not isnumber( l_code ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_code ) )
	return false
end if

l_code_from		= long( sle_syohin_code_from.text )
l_code_to		= long( l_code )

//前後関係チェック
if l_code_from > 0 then
	if l_code_from > l_code_to then
		this.of_msg_error( "商品コードの前後関係が不正です。" )
		return false
	end if
end if

return true

end event

event key_f08;call super::key_f08;str_mdlpara_msyohin	l_syohin

l_syohin	= mdl.of_open_modal( "wsm_syohin", l_syohin )

if upperbound(l_syohin.ret) > 0 then
	this.text	= string( l_syohin.ret[1].syohin_code )
end if

return 0

end event

type st_tokuisaki_code from ivo_statictext within wm_tanka_tokui
integer x = 32
integer y = 1038
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "商品CD"
alignment alignment = right!
end type

type st_syohin_bikou from ivo_statictext within wm_tanka_tokui
integer x = 444
integer y = 928
integer width = 1808
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "※上代登録商品、および一括登録対象商品のみ登録します"
end type

type rb_uwagaki_no from ivo_radiobutton within wm_tanka_tokui
string tag = "上書き"
integer x = 752
integer y = 1490
integer width = 348
long backcolor = 553648127
string text = "しない"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_tokui
string tag = "上書き"
integer x = 464
integer y = 1490
integer width = 268
long backcolor = 553648127
string text = "する"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_uwagaki from ivo_statictext within wm_tanka_tokui
integer x = 32
integer y = 1490
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "上書き"
alignment alignment = right!
end type

type dw_list from ivo_datawindow within wm_tanka_tokui
string tag = "対象部門"
integer x = 444
integer y = 494
integer width = 1252
integer height = 402
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_tanka_tokui_kakeritu"
boolean vscrollbar = true
boolean livescroll = false
boolean f1_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;dw_list.settransobject(cocos)
dw_list.reset()

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

end event

type uo_tokui from cv_input_tokui_tanto within wm_tanka_tokui
event destroy ( )
integer x = 76
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean chk_required = true
end type

on uo_tokui.destroy
call cv_input_tokui_tanto::destroy
end on

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code
long		l_syohizei_kbn
long		l_tanka_touroku_flg

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	st_syohizei_kbn.event		constructor()
	st_tanka_touroku_flg.event	constructor()
	return false
else
	l_tokui_code	= i_para_tokui[1].tokui_code

	// 消費税区分（1＝単価税別2＝単価税込）※名称区分＝104
	// 単価登録フラグ（1＝一括登録あり）
	select	m_tokui.syohizei_kbn
	,			m_tokui.tanka_touroku_flg
	into		:l_syohizei_kbn
	,			:l_tanka_touroku_flg
	from		m_tokui
	where		m_tokui.tokui_code			= :l_tokui_code
	using		cocos;
	
	choose case cocos.sqlcode
		case 0
			st_syohizei_kbn.text			= String(l_syohizei_kbn)
			st_tanka_touroku_flg.text	= String(l_tanka_touroku_flg)

		case 100
			// データが無い場合は初期化
			st_syohizei_kbn.event		constructor()
			st_tanka_touroku_flg.event	constructor()

		case else
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			this.setfocus()
			return false
	end choose

end if

return true

end event

event constructor;call super::constructor;this.of_set_enabled( true )

end event

type cbx_tankahyo_9 from ivo_checkbox within wm_tanka_tokui
string tag = "9"
integer x = 524
integer y = 1170
integer width = 392
long backcolor = 553648127
string text = "出力なし"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.checked	= true

end event

type cbx_tankahyo_1 from ivo_checkbox within wm_tanka_tokui
string tag = "1"
integer x = 936
integer y = 1170
integer width = 392
long backcolor = 553648127
string text = "春夏"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.checked		= true
end event

type cbx_tankahyo_2 from ivo_checkbox within wm_tanka_tokui
string tag = "2"
integer x = 1348
integer y = 1170
integer width = 440
long backcolor = 553648127
string text = "秋冬"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.checked	= true
end event

type st_tankahyo_hakkou_kbn from ivo_statictext within wm_tanka_tokui
string tag = "159"
integer x = 32
integer y = 1170
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "単価表発行"
alignment alignment = right!
end type

type cbx_tankahyo_3 from ivo_checkbox within wm_tanka_tokui
string tag = "3"
integer x = 1808
integer y = 1170
integer width = 392
long backcolor = 553648127
string text = "全て"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_haiban_3 from ivo_radiobutton within wm_tanka_tokui
string tag = "3"
integer x = 1340
integer y = 1330
integer width = 428
long backcolor = 553648127
string text = "準廃番まで"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_haiban_9 from ivo_radiobutton within wm_tanka_tokui
string tag = "9"
integer x = 1788
integer y = 1330
integer width = 408
long backcolor = 553648127
string text = "廃番まで"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_tokui
integer x = 2192
integer y = 263
integer width = 500
boolean bringtotop = true
boolean enabled = false
string text = "単価登録フラグ"
boolean f3_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= "0"

end event

type st_syohizei_kbn from sv_st_meisyo within wm_tanka_tokui
integer x = 2696
integer y = 263
integer width = 500
boolean bringtotop = true
string text = "消費税区分"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type gb_haiban_kbn from ivo_groupbox within wm_tanka_tokui
integer x = 444
integer y = 1291
integer width = 1772
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_uwagaki from ivo_groupbox within wm_tanka_tokui
integer x = 444
integer y = 1451
integer width = 676
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_tankahyo from ivo_groupbox within wm_tanka_tokui
integer x = 444
integer y = 1131
integer width = 1716
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

