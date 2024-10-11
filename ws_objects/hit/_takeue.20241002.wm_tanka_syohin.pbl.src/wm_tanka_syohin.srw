$PBExportHeader$wm_tanka_syohin.srw
$PBExportComments$単価一括登録(1商品全得意先)
forward
global type wm_tanka_syohin from iw_main_window
end type
type st_jyoudai_label from ivo_statictext within wm_tanka_syohin
end type
type st_kakaku_group_kbn_label from ivo_statictext within wm_tanka_syohin
end type
type st_bumon_code from ivo_statictext within wm_tanka_syohin
end type
type rb_torihiki_teisi_kbn_no from ivo_radiobutton within wm_tanka_syohin
end type
type rb_torihiki_teisi_kbn_yes from ivo_radiobutton within wm_tanka_syohin
end type
type st_torihiki_teisi_kbn from ivo_statictext within wm_tanka_syohin
end type
type st_tokuisaki_namidash from ivo_statictext within wm_tanka_syohin
end type
type sle_tokuisaki_code_from from ivo_singlelineedit within wm_tanka_syohin
end type
type sle_tokuisaki_code_to from ivo_singlelineedit within wm_tanka_syohin
end type
type st_tokuisaki_code from ivo_statictext within wm_tanka_syohin
end type
type st_tokuisaki_bikou from ivo_statictext within wm_tanka_syohin
end type
type st_jyoudai_yen from ivo_statictext within wm_tanka_syohin
end type
type rb_uwagaki_no from ivo_radiobutton within wm_tanka_syohin
end type
type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_syohin
end type
type st_uwagaki from ivo_statictext within wm_tanka_syohin
end type
type uo_syohin from cv_input_syohin within wm_tanka_syohin
end type
type st_kakaku_group_kbn_mei from sv_st_meisyo within wm_tanka_syohin
end type
type st_jyoudai from sv_st_meisyo within wm_tanka_syohin
end type
type dw_list from ivo_datawindow within wm_tanka_syohin
end type
type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_syohin
end type
type st_kakaku_group_kbn from sv_st_meisyo within wm_tanka_syohin
end type
type gb_torihiki_teisi_kbn from ivo_groupbox within wm_tanka_syohin
end type
type gb_uwagaki from ivo_groupbox within wm_tanka_syohin
end type
end forward

global type wm_tanka_syohin from iw_main_window
string title = "単価一括登録（１商品全得意先）"
boolean minbox = false
boolean center = false
boolean f12_key = true
st_jyoudai_label st_jyoudai_label
st_kakaku_group_kbn_label st_kakaku_group_kbn_label
st_bumon_code st_bumon_code
rb_torihiki_teisi_kbn_no rb_torihiki_teisi_kbn_no
rb_torihiki_teisi_kbn_yes rb_torihiki_teisi_kbn_yes
st_torihiki_teisi_kbn st_torihiki_teisi_kbn
st_tokuisaki_namidash st_tokuisaki_namidash
sle_tokuisaki_code_from sle_tokuisaki_code_from
sle_tokuisaki_code_to sle_tokuisaki_code_to
st_tokuisaki_code st_tokuisaki_code
st_tokuisaki_bikou st_tokuisaki_bikou
st_jyoudai_yen st_jyoudai_yen
rb_uwagaki_no rb_uwagaki_no
rb_uwagaki_yes rb_uwagaki_yes
st_uwagaki st_uwagaki
uo_syohin uo_syohin
st_kakaku_group_kbn_mei st_kakaku_group_kbn_mei
st_jyoudai st_jyoudai
dw_list dw_list
st_tanka_touroku_flg st_tanka_touroku_flg
st_kakaku_group_kbn st_kakaku_group_kbn
gb_torihiki_teisi_kbn gb_torihiki_teisi_kbn
gb_uwagaki gb_uwagaki
end type
global wm_tanka_syohin wm_tanka_syohin

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
		uo_syohin.of_set_enabled( p_enabled )
		st_kakaku_group_kbn.enabled			= p_enabled
		st_jyoudai.enabled						= p_enabled
		st_tanka_touroku_flg.enabled			= p_enabled

	case "detailsection"
		// 明細部
		dw_list.enabled							= p_enabled
		sle_tokuisaki_code_from.enabled		= p_enabled
		sle_tokuisaki_code_to.enabled			= p_enabled

		gb_torihiki_teisi_kbn.enabled			= p_enabled
		rb_torihiki_teisi_kbn_yes.enabled	= p_enabled
		rb_torihiki_teisi_kbn_no.enabled		= p_enabled

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

sle_tokuisaki_code_from.event constructor( )
sle_tokuisaki_code_to.event constructor( )

rb_torihiki_teisi_kbn_yes.checked = false
rb_torihiki_teisi_kbn_no.checked = true

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

uo_syohin.event constructor( )

st_kakaku_group_kbn.event constructor( )
st_kakaku_group_kbn_mei.event constructor( )
st_kakaku_group_kbn.visible = false

st_jyoudai.event constructor( )

st_tanka_touroku_flg.event constructor( )
st_tanka_touroku_flg.visible = false

// 明細部
of_dsp_edit( "detailsection", false )

dw_list.reset()

sle_tokuisaki_code_from.event constructor( )
sle_tokuisaki_code_to.event constructor( )

rb_torihiki_teisi_kbn_yes.checked = false
rb_torihiki_teisi_kbn_no.checked = true

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

l_syohin_code = long( trim( uo_syohin.of_get_input() ) )
l_kakaku_group_kbn = long( st_kakaku_group_kbn.text )
l_jyoudai = Dec( st_jyoudai.tag )

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
	of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

// 掛率M.アップ額込み区分が0の場合　※別紙「UP額」参照
// 単価M.アップ額(数字) = 商品Mのアップ額を商品コード、アップ位置でGROUP BYして値を取得しセット
for l_up_iti = 1 to 5
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
		of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
		return false
	end if
next

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
		l_tokui_code = dw_tanka.GetItemDecimal(l_loop,"m_tokui_tokui_code")
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

	l_tokui_code = dw_tanka.GetItemDecimal(l_row,"tokui_code")

	// 掛率（※1） = 掛率M.掛率(商品M.価格グループ区分 = 掛率M.価格グループ区分 AND 掛率M.得意先コード = 得意先M.得意先コード)		
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
		of_add_db_log( "of_update-3", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
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
		of_add_db_log( "of_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
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
	of_add_db_log( "of_update-5", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

return true

end function

public function integer of_datastore ();// 単価マスタデータストアの条件を設定し読み込む
long		l_row
long		l_syohin_code
string	l_bumon
long		l_tokui_from
long		l_tokui_to
string	l_code
long		l_teisi_kbn
long		l_kakaku_group_kbn
long		l_count

/*
 　ア）商品マスターの単価登録区分＝1（一括登録あり）の商品で、かつ上代登録のある商品。
 　イ）得意先マスターの単価登録区分＝1（一括登録あり）の得意先で、かつ終息済みでない得意先。
 　ウ）画面上で指定された部門に所属する得意先（得意先マスターの部門コード）。
 　エ）当該商品の価格グループが、掛率マスターに掛率ゼロ以外で登録されている得意先。
 　オ）その他、画面上で指定された条件。
 　カ）商品マスターの終息フラグ＝0（終息済みではない）の商品。

 ・当画面での予約登録は、考慮しない。
	上書き「する」の場合は、予約登録がある場合も現在単価を更新する。
	上書き「しない」の場合は予約登録のみの場合（現在単価＝ゼロ）も更新対象としない（レコード有無のみで判断してよし）。

 ・条件指定欄の「取引停止先」は、取引停止区分＝3（完全停止）を対象とするかどうか。
 ・単価税込みの得意先は考慮不要。税込み得意先は得意先登録時に「一括登録」を選択できない。
*/

// 商品コード
l_syohin_code = long( trim( uo_syohin.of_get_input() ) )
// 対象部門
l_bumon = ""
for l_row = 1 to dw_list.rowcount()
	if dw_list.GetItemString(l_row,"chkbox") = "0" then
		continue
	end if
	if l_bumon <> "" then
		l_bumon = l_bumon + ","
	end if
	l_bumon = l_bumon + trim(dw_list.GetItemString(l_row,"meisyo_code"))
next
// 得意先コード範囲 開始
l_code = sle_tokuisaki_code_from.text
if l_code = "" then
	l_code = "0"
end if
l_tokui_from = long( l_code )
// 得意先コード範囲 終了
l_code = sle_tokuisaki_code_to.text
if l_code = "" then
	l_code = "999999"
end if
l_tokui_to = long( l_code )
// 取引停止先 画面.取引停止先 = 登録しない の場合
l_teisi_kbn = 0
if rb_torihiki_teisi_kbn_yes.checked then
	l_teisi_kbn = 1
end if
// 当該商品の価格グループが、掛率マスターに掛率ゼロ以外で登録されている得意先
l_kakaku_group_kbn = long( st_kakaku_group_kbn.text )

// データ読み込み
l_count = dw_tanka.retrieve(l_syohin_code,l_bumon,l_tokui_from,l_tokui_to,l_teisi_kbn,l_kakaku_group_kbn)

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
uo_syohin.setfocus()
uo_syohin.sle_input.setfocus()

end subroutine

protected subroutine of_set_secondfocus ();
dw_list.setfocus()

end subroutine

on wm_tanka_syohin.create
int iCurrent
call super::create
this.st_jyoudai_label=create st_jyoudai_label
this.st_kakaku_group_kbn_label=create st_kakaku_group_kbn_label
this.st_bumon_code=create st_bumon_code
this.rb_torihiki_teisi_kbn_no=create rb_torihiki_teisi_kbn_no
this.rb_torihiki_teisi_kbn_yes=create rb_torihiki_teisi_kbn_yes
this.st_torihiki_teisi_kbn=create st_torihiki_teisi_kbn
this.st_tokuisaki_namidash=create st_tokuisaki_namidash
this.sle_tokuisaki_code_from=create sle_tokuisaki_code_from
this.sle_tokuisaki_code_to=create sle_tokuisaki_code_to
this.st_tokuisaki_code=create st_tokuisaki_code
this.st_tokuisaki_bikou=create st_tokuisaki_bikou
this.st_jyoudai_yen=create st_jyoudai_yen
this.rb_uwagaki_no=create rb_uwagaki_no
this.rb_uwagaki_yes=create rb_uwagaki_yes
this.st_uwagaki=create st_uwagaki
this.uo_syohin=create uo_syohin
this.st_kakaku_group_kbn_mei=create st_kakaku_group_kbn_mei
this.st_jyoudai=create st_jyoudai
this.dw_list=create dw_list
this.st_tanka_touroku_flg=create st_tanka_touroku_flg
this.st_kakaku_group_kbn=create st_kakaku_group_kbn
this.gb_torihiki_teisi_kbn=create gb_torihiki_teisi_kbn
this.gb_uwagaki=create gb_uwagaki
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_jyoudai_label
this.Control[iCurrent+2]=this.st_kakaku_group_kbn_label
this.Control[iCurrent+3]=this.st_bumon_code
this.Control[iCurrent+4]=this.rb_torihiki_teisi_kbn_no
this.Control[iCurrent+5]=this.rb_torihiki_teisi_kbn_yes
this.Control[iCurrent+6]=this.st_torihiki_teisi_kbn
this.Control[iCurrent+7]=this.st_tokuisaki_namidash
this.Control[iCurrent+8]=this.sle_tokuisaki_code_from
this.Control[iCurrent+9]=this.sle_tokuisaki_code_to
this.Control[iCurrent+10]=this.st_tokuisaki_code
this.Control[iCurrent+11]=this.st_tokuisaki_bikou
this.Control[iCurrent+12]=this.st_jyoudai_yen
this.Control[iCurrent+13]=this.rb_uwagaki_no
this.Control[iCurrent+14]=this.rb_uwagaki_yes
this.Control[iCurrent+15]=this.st_uwagaki
this.Control[iCurrent+16]=this.uo_syohin
this.Control[iCurrent+17]=this.st_kakaku_group_kbn_mei
this.Control[iCurrent+18]=this.st_jyoudai
this.Control[iCurrent+19]=this.dw_list
this.Control[iCurrent+20]=this.st_tanka_touroku_flg
this.Control[iCurrent+21]=this.st_kakaku_group_kbn
this.Control[iCurrent+22]=this.gb_torihiki_teisi_kbn
this.Control[iCurrent+23]=this.gb_uwagaki
end on

on wm_tanka_syohin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_jyoudai_label)
destroy(this.st_kakaku_group_kbn_label)
destroy(this.st_bumon_code)
destroy(this.rb_torihiki_teisi_kbn_no)
destroy(this.rb_torihiki_teisi_kbn_yes)
destroy(this.st_torihiki_teisi_kbn)
destroy(this.st_tokuisaki_namidash)
destroy(this.sle_tokuisaki_code_from)
destroy(this.sle_tokuisaki_code_to)
destroy(this.st_tokuisaki_code)
destroy(this.st_tokuisaki_bikou)
destroy(this.st_jyoudai_yen)
destroy(this.rb_uwagaki_no)
destroy(this.rb_uwagaki_yes)
destroy(this.st_uwagaki)
destroy(this.uo_syohin)
destroy(this.st_kakaku_group_kbn_mei)
destroy(this.st_jyoudai)
destroy(this.dw_list)
destroy(this.st_tanka_touroku_flg)
destroy(this.st_kakaku_group_kbn)
destroy(this.gb_torihiki_teisi_kbn)
destroy(this.gb_uwagaki)
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
if not uo_syohin.event sle_input_check( ) then
	return -1
end if

// 変更可能かどうか、権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出して強制的に照会モードにする）
if i_permission <> 0 then
	if not i_admin then
		msg.of_warning( "入力された定数区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
//		ddplb_syori_kbn.text	= "照会"
	end if
end if

// 商品M.商品コード = 画面.商品コード のレコードが存在し、商品M.終息フラグ = 1の場合、
// エラーメッセージ(No2)を表示する
if uo_syohin.of_get_syusoku_flg() = 1 then
	msg.of_error( "終息品は指定できません。" )
	return -1
end if

// 商品M.商品コード = 画面.商品コード のレコードが存在し、商品M.上代価格 = 0の場合、
// エラーメッセージ(No3)を表示する
if st_jyoudai.text = "" then
	msg.of_error( "この商品は上代価格が登録されていません。" )
	return -1
end if
if long(st_jyoudai.text) = 0 then
	msg.of_error( "この商品は上代価格が登録されていません。" )
	return -1
end if

// 商品M.商品コード = 画面.商品コード のレコードが存在し、商品M.単価登録フラグ <> 1（一括登録あり）の場合、
// エラーメッセージ(No4)を表示する
// 単価登録フラグ（0＝しない1＝上代×掛け率による一括登録の対象とする）
if st_tanka_touroku_flg.text = "0" then
	msg.of_error( "この商品は、単価一括登録「しない」に設定されています。" )
	return -1
end if

return 0

end event

event retrieve_event;call super::retrieve_event;// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= "表示"

setredraw( false )

// 呼出部をロックする
of_dsp_edit( "callsection", false )

// 明細部
of_dsp_edit( "detailsection", true )

// 名称Mの名称１を対象部門に表示する
// 条件：名称M.名称区分 = 21　※部門名（営業部門）	
dw_list.reset()
dw_list.retrieve()
dw_list.setfocus()

sle_tokuisaki_code_from.event constructor( )
sle_tokuisaki_code_to.event constructor( )

rb_torihiki_teisi_kbn_yes.checked = false
rb_torihiki_teisi_kbn_no.checked = true

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
if not sle_tokuisaki_code_from.event input_check( ) then
	return -1
end if
if not sle_tokuisaki_code_to.event input_check( ) then
	return -1
end if

return 0

end event

event update_event;call super::update_event;long	l_ret
long	l_count

l_ret = 0
i_syori_kbn = "更新"

dw_tanka = create datastore
dw_tanka.dataobject 	= "ds_tanka_syohin_tanka"
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
	dw_list.SetItem(l_row,"chkbox",l_chkbox)
next

return 0

end event

type uo_signal from iw_main_window`uo_signal within wm_tanka_syohin
end type

type st_date from iw_main_window`st_date within wm_tanka_syohin
end type

type st_user_mei from iw_main_window`st_user_mei within wm_tanka_syohin
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_tanka_syohin
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_tanka_syohin
end type

type st_title from iw_main_window`st_title within wm_tanka_syohin
end type

type st_title_upper from iw_main_window`st_title_upper within wm_tanka_syohin
end type

type st_upper from iw_main_window`st_upper within wm_tanka_syohin
end type

type st_second_upper from iw_main_window`st_second_upper within wm_tanka_syohin
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_tanka_syohin
integer taborder = 50
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

type st_jyoudai_label from ivo_statictext within wm_tanka_syohin
integer x = 1360
integer y = 263
integer width = 168
integer height = 75
boolean bringtotop = true
long backcolor = 12632256
string text = "上代"
alignment alignment = right!
end type

type st_kakaku_group_kbn_label from ivo_statictext within wm_tanka_syohin
integer x = 356
integer y = 263
integer width = 488
integer height = 75
boolean bringtotop = true
long backcolor = 12632256
string text = "価格グループ"
alignment alignment = right!
end type

type st_bumon_code from ivo_statictext within wm_tanka_syohin
integer x = 32
integer y = 494
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "対象部門"
alignment alignment = right!
end type

type rb_torihiki_teisi_kbn_no from ivo_radiobutton within wm_tanka_syohin
string tag = "取引停止先"
integer x = 912
integer y = 1170
integer width = 408
long backcolor = 553648127
string text = "登録しない"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_torihiki_teisi_kbn_yes from ivo_radiobutton within wm_tanka_syohin
string tag = "取引停止先"
integer x = 464
integer y = 1170
integer width = 428
long backcolor = 553648127
string text = "登録する"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_torihiki_teisi_kbn from ivo_statictext within wm_tanka_syohin
integer x = 32
integer y = 1170
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "取引停止先"
alignment alignment = right!
end type

type st_tokuisaki_namidash from ivo_statictext within wm_tanka_syohin
integer x = 736
integer y = 1038
integer width = 88
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_tokuisaki_code_from from ivo_singlelineedit within wm_tanka_syohin
string tag = "得意先CD"
integer x = 444
integer y = 1038
integer width = 272
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "999999"
integer limit = 6
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_required = true
boolean chk_digits = true
integer i_limit = 6
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
l_code_to		= long( sle_tokuisaki_code_to.text )

//前後関係チェック
if l_code_to > 0 then
	if l_code_from > l_code_to then
		this.of_msg_error( "得意先コードの前後関係が不正です。" )
		return false
	end if
end if

return true

end event

event key_f08;call super::key_f08;str_mdlpara_mtokui	l_tokui

l_tokui	= mdl.of_open_modal( "wsm_tokui", l_tokui )

if upperbound(l_tokui.ret) > 0 then
	this.text	= string( l_tokui.ret[1].tokui_code )
end if

return 0

end event

type sle_tokuisaki_code_to from ivo_singlelineedit within wm_tanka_syohin
string tag = "得意先CD"
integer x = 844
integer y = 1038
integer width = 272
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
string text = "999999"
integer limit = 6
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_required = true
boolean chk_digits = true
integer i_limit = 6
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

l_code_from		= long( sle_tokuisaki_code_from.text )
l_code_to		= long( l_code )

//前後関係チェック
if l_code_from > 0 then
	if l_code_from > l_code_to then
		this.of_msg_error( "得意先コードの前後関係が不正です。" )
		return false
	end if
end if

return true

end event

event key_f08;call super::key_f08;str_mdlpara_mtokui	l_tokui

l_tokui	= mdl.of_open_modal( "wsm_tokui", l_tokui )

if upperbound(l_tokui.ret) > 0 then
	this.text	= string( l_tokui.ret[1].tokui_code )
end if

return 0

end event

type st_tokuisaki_code from ivo_statictext within wm_tanka_syohin
integer x = 32
integer y = 1038
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "得意先CD"
alignment alignment = right!
end type

type st_tokuisaki_bikou from ivo_statictext within wm_tanka_syohin
integer x = 444
integer y = 928
integer width = 1808
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "※掛率登録のある得意先、および一括登録対象得意先のみ登録します"
end type

type st_jyoudai_yen from ivo_statictext within wm_tanka_syohin
integer x = 2056
integer y = 267
integer width = 88
integer height = 75
boolean bringtotop = true
long backcolor = 12632256
string text = "円"
alignment alignment = right!
end type

type rb_uwagaki_no from ivo_radiobutton within wm_tanka_syohin
string tag = "上書き"
integer x = 752
integer y = 1330
integer width = 348
long backcolor = 553648127
string text = "しない"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_syohin
string tag = "上書き"
integer x = 464
integer y = 1330
integer width = 268
long backcolor = 553648127
string text = "する"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_uwagaki from ivo_statictext within wm_tanka_syohin
integer x = 32
integer y = 1330
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "上書き"
alignment alignment = right!
end type

type uo_syohin from cv_input_syohin within wm_tanka_syohin
integer x = 76
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean chk_required = true
string title_text = "商品CD"
boolean input_iro_visible = false
boolean arrow_visible = false
boolean iro_mei_visible = false
end type

on uo_syohin.destroy
call cv_input_syohin::destroy
end on

event constructor;call super::constructor;this.of_set_enabled( true )
this.st_title.text = "商品ＣＤ"

end event

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_syohin_code
long		l_iro_no
string	l_size_code
decimal	l_jyoudai
long		l_tanka_touroku_flg
long		l_group_code
string	l_group_mei

// 商品CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	st_kakaku_group_kbn_mei.event	constructor()
	st_kakaku_group_kbn.event		constructor()
	st_jyoudai.event					constructor()
	st_tanka_touroku_flg.event		constructor()

	return false
else
	l_syohin_code	= i_para_syohin[1].syohin_code
	l_iro_no			= i_para_syohin[1].iro_no
	l_size_code		= i_para_syohin[1].size_code

	// 存在チェック
	select NVL(m_syohin.jyoudai,0)
			,NVL(m_syohin.tanka_touroku_flg,0)
			,NVL(m_syohin.kakaku_group_kbn,0)
			,NVL(m_meisyo.meisyo_1,' ')
	  into :l_jyoudai
			,:l_tanka_touroku_flg
			,:l_group_code
			,:l_group_mei
	  from m_syohin
			,m_meisyo
	 where m_syohin.syohin_code		= :l_syohin_code
		and m_syohin.iro_no				= :l_iro_no
		and m_syohin.size_code			= :l_size_code
		and 131								= m_meisyo.meisyo_kbn		(+)
		and m_syohin.kakaku_group_kbn	= m_meisyo.meisyo_code		(+)
	 using cocos;
	
	choose case cocos.sqlcode
		case 0
			// 上代価格（標準価格、建値（※営業一部が販売する商品は全て上代を登録する））
			st_jyoudai.text				= String(l_jyoudai,"#,##0.00")
			st_jyoudai.tag					= String(l_jyoudai,"0.00")	// タグに記憶
			// 価格グループ区分（下代計算時の掛率を設定する商品群の区分）※名称区分＝131
			st_kakaku_group_kbn.text		= string(l_group_code)
			st_kakaku_group_kbn_mei.text	= trim(l_group_mei)
			// 単価登録フラグ（0＝しない1＝上代×掛け率による一括登録の対象とする）
			st_tanka_touroku_flg.text	= String(l_tanka_touroku_flg)

		case 100
			// データが無い場合は初期化
			st_kakaku_group_kbn_mei.event	constructor()
			st_kakaku_group_kbn.event		constructor()
			st_jyoudai.event					constructor()
			st_tanka_touroku_flg.event		constructor()

		case else
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			this.setfocus()
			return false
	end choose

end if

return true

end event

type st_kakaku_group_kbn_mei from sv_st_meisyo within wm_tanka_syohin
integer x = 864
integer y = 263
integer width = 500
boolean bringtotop = true
string text = "価格グループ"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type st_jyoudai from sv_st_meisyo within wm_tanka_syohin
integer x = 1548
integer y = 263
integer width = 500
boolean bringtotop = true
string text = "上代1,234,567.89"
boolean f3_key = true
boolean f5_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""
this.tag		= ""


end event

type dw_list from ivo_datawindow within wm_tanka_syohin
string tag = "対象部門"
integer x = 444
integer y = 494
integer width = 1252
integer height = 402
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_tanka_syohin_bumon"
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
dw_list.object.meisyo_1_t.text = "部門"

this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

end event

type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_syohin
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

type st_kakaku_group_kbn from sv_st_meisyo within wm_tanka_syohin
integer x = 2696
integer y = 263
integer width = 500
boolean bringtotop = true
string text = "価格グループ"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type gb_torihiki_teisi_kbn from ivo_groupbox within wm_tanka_syohin
integer x = 444
integer y = 1131
integer width = 900
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_uwagaki from ivo_groupbox within wm_tanka_syohin
integer x = 444
integer y = 1291
integer width = 680
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

