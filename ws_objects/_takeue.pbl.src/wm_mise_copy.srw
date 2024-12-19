$PBExportHeader$wm_mise_copy.srw
$PBExportComments$店一括複写登録
forward
global type wm_mise_copy from iw_main_window
end type
type st_tokui_from_count_title from ivo_statictext within wm_mise_copy
end type
type rb_uwagaki_no from ivo_radiobutton within wm_mise_copy
end type
type rb_uwagaki_yes from ivo_radiobutton within wm_mise_copy
end type
type st_uwagaki from ivo_statictext within wm_mise_copy
end type
type st_tokui_from_count from sv_st_meisyo within wm_mise_copy
end type
type uo_tokui_send from cv_input_tokui within wm_mise_copy
end type
type uo_tokui_to from cv_input_tokui within wm_mise_copy
end type
type st_mise from ivo_statictext within wm_mise_copy
end type
type sle_mise_from from ivo_singlelineedit within wm_mise_copy
end type
type st_touroku_date_namidashu from ivo_statictext within wm_mise_copy
end type
type sle_mise_to from ivo_singlelineedit within wm_mise_copy
end type
type st_mise_mei from ivo_statictext within wm_mise_copy
end type
type st_tokui_from_count_ken from ivo_statictext within wm_mise_copy
end type
type cbx_heiten_flg from ivo_checkbox within wm_mise_copy
end type
type st_arrow from ivo_statictext within wm_mise_copy
end type
type uo_tokui_from from cv_input_tokui within wm_mise_copy
end type
type st_tokui_to_count_title from ivo_statictext within wm_mise_copy
end type
type st_tokui_to_count from sv_st_meisyo within wm_mise_copy
end type
type st_tokui_to_count_ken from ivo_statictext within wm_mise_copy
end type
type sle_mise_mei from ivo_singlelineedit within wm_mise_copy
end type
type st_mise_mei_set from ivo_statictext within wm_mise_copy
end type
type st_entry_count_title from ivo_statictext within wm_mise_copy
end type
type st_entry_count from sv_st_meisyo within wm_mise_copy
end type
type st_entry_count_ken from ivo_statictext within wm_mise_copy
end type
type st_update_count_title from ivo_statictext within wm_mise_copy
end type
type st_update_count from sv_st_meisyo within wm_mise_copy
end type
type st_update_count_ken from ivo_statictext within wm_mise_copy
end type
type uo_progress from cv_hprogressbar_pct within wm_mise_copy
end type
type st_progress from ivo_statictext within wm_mise_copy
end type
type st_tokui_to_set from ivo_statictext within wm_mise_copy
end type
type gb_uwagaki from ivo_groupbox within wm_mise_copy
end type
type gb_tokui_cond from ivo_groupbox within wm_mise_copy
end type
type gb_yoyaku from ivo_groupbox within wm_mise_copy
end type
end forward

global type wm_mise_copy from iw_main_window
string title = "店一括複写登録"
boolean f6_key = true
boolean f12_key = true
st_tokui_from_count_title st_tokui_from_count_title
rb_uwagaki_no rb_uwagaki_no
rb_uwagaki_yes rb_uwagaki_yes
st_uwagaki st_uwagaki
st_tokui_from_count st_tokui_from_count
uo_tokui_send uo_tokui_send
uo_tokui_to uo_tokui_to
st_mise st_mise
sle_mise_from sle_mise_from
st_touroku_date_namidashu st_touroku_date_namidashu
sle_mise_to sle_mise_to
st_mise_mei st_mise_mei
st_tokui_from_count_ken st_tokui_from_count_ken
cbx_heiten_flg cbx_heiten_flg
st_arrow st_arrow
uo_tokui_from uo_tokui_from
st_tokui_to_count_title st_tokui_to_count_title
st_tokui_to_count st_tokui_to_count
st_tokui_to_count_ken st_tokui_to_count_ken
sle_mise_mei sle_mise_mei
st_mise_mei_set st_mise_mei_set
st_entry_count_title st_entry_count_title
st_entry_count st_entry_count
st_entry_count_ken st_entry_count_ken
st_update_count_title st_update_count_title
st_update_count st_update_count
st_update_count_ken st_update_count_ken
uo_progress uo_progress
st_progress st_progress
st_tokui_to_set st_tokui_to_set
gb_uwagaki gb_uwagaki
gb_tokui_cond gb_tokui_cond
gb_yoyaku gb_yoyaku
end type
global wm_mise_copy wm_mise_copy

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

	// 検索条件
	long		l_where_tokui_from_code
	long		l_where_mise_from
	long		l_where_mise_to
	long		l_where_heiten_flg
	long		l_where_tokui_to_code
	long		l_where_tokui_send_code
	string	l_where_mise_mei
	long		l_where_uwagaki
	// 検索結果 件数
	long		l_count_where
	long		l_count_entry
	long		l_count_update
	long		l_count_haita

end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_update ()
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);// p_controlによって、ロックやフォーカスを制御する
long	l_row

choose case p_control
	case "callsection"
		// 呼び出し部のロック状態を制御する
		uo_tokui_from.of_set_enabled( p_enabled )

		sle_mise_from.enabled					= p_enabled
		sle_mise_to.enabled						= p_enabled

		uo_tokui_to.of_set_enabled( p_enabled )

		gb_uwagaki.enabled						= p_enabled
		rb_uwagaki_yes.enabled					= p_enabled
		rb_uwagaki_no.enabled					= p_enabled

		uo_tokui_send.of_set_enabled( p_enabled )

		sle_mise_mei.enabled						= p_enabled

	case "detailsection"

end choose

end subroutine

public function boolean of_update ();
// 更新登録処理
long		l_progress_count, l_insert, l_update
integer	l_haita_flg
boolean	l_lock
datetime	l_sysdate
long		l_ret

long		l_mise_code
string	l_m_mise_from_rowid
string	l_m_mise_to_rowid
long		l_progress_max

string	ls_message, ls_message2, ls_message3

string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei

l_lock = false
l_haita_flg	= 0

l_insert = 0
l_update = 0

// プログレスバー設定
if l_where_uwagaki = 0 then
	l_progress_max	= l_count_entry
else
	l_progress_max	= l_count_entry + l_count_update
end if
uo_progress.i_min = 0
uo_progress.i_max = l_progress_max
uo_progress.i_now = 0
//uo_progress.i_step = 1
uo_progress.of_init(0,l_progress_max,0,1)
l_progress_count = 0

select sysdate
  into :l_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

declare	cur1 cursor for
	select	m_mise_from.mise_code
	,			m_mise_from.rowid
	,			m_mise_to.rowid
	from		M_MISE	m_mise_from
	,			M_MISE	m_mise_to
	where		m_mise_from.tokui_code	= :l_where_tokui_from_code
	and		m_mise_from.mise_code	between :l_where_mise_from and :l_where_mise_to
	and		(m_mise_from.heiten_flg = 0 or :l_where_heiten_flg = 1)
	and		:l_where_tokui_to_code	= m_mise_to.tokui_code	(+)
	and		m_mise_from.mise_code	= m_mise_to.mise_code	(+)
	order by	m_mise_from.mise_code
using		cocos;
if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

// 2024.11.25itoロックチェック処理実装

// 店マスタ排他チェック
string	l_kousin_user_id,l_kousin_client_id

declare cur_haita cursor for
	select	nvl(m_mise_to.kousin_user_id,'???'),
			nvl(m_mise_to.kousin_client_id,'???'),
			m_mise_to.haita_flg
	  from    M_MISE m_mise_from
	 ,       M_MISE m_mise_to
	 where   m_mise_from.tokui_code = :l_where_tokui_from_code
	 and     m_mise_from.mise_code between :l_where_mise_from and :l_where_mise_to
	 and     (m_mise_from.heiten_flg = 0 or :l_where_heiten_flg = 1)
	 and     :l_where_tokui_to_code = m_mise_to.tokui_code (+)
	 and     m_mise_from.mise_code = m_mise_to.mise_code (+)
	 order by m_mise_to.haita_flg desc
	 for update nowait
	 using   cocos;

open cur_haita;
if cocos.sqlcode <> 0 then
	choose case cocos.sqldbcode
		case 54
			//Resource Busy
			msg.of_error("対象データは他の端末で更新処理中です。")
			
		case else
			//DB Exception
			msg.of_error(fnc.strg.of_format("排他チェック処理でエラーが発生しました。{1}{2}",code.crlf,cocos.last_sqlerrtext))
	end choose
	
	// 排他チェックに失敗
	close cur_haita;
	rollback using cocos;
	return false;
end if

fetch next cur_haita
 into :l_kousin_user_id,
	  :l_kousin_client_id,
	  :l_haita_flg;

do while cocos.sqlcode = 0
	// 排他チェック
//		if (l_kousin_user_id <> user.user_id) and (l_haita_flg <> 0) then
	if l_haita_flg <> 0 then
		msg.of_error(fnc.strg.of_format("対象データは他の端末で変更中です。{1}（端末ID:{2} ユーザーID:{3}）",code.crlf,l_kousin_client_id,l_kousin_user_id))
		
		// 排他チェックに失敗
		close cur_haita;
		rollback using cocos;
		return false;
	end if
	
	// 抜け道
	if l_haita_flg = 0 then exit
	
	// 次行取得
	fetch next cur_haita
	 into :l_kousin_user_id,
		  :l_kousin_client_id,
		  :l_haita_flg;
loop
close cur_haita;
// 排他チェックに成功



open cur1;
do while true
	//フェッチできなくなるまでループします
	FETCH	cur1
	INTO	:l_mise_code
	,		:l_m_mise_from_rowid
	,		:l_m_mise_to_rowid
	;
	if cocos.sqlcode = 100 then
		exit
	end if
	if cocos.sqlcode <> 0 then
		msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
		of_add_db_log( "of_update-4", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
		return false
	end if

	if not isnull(l_m_mise_to_rowid) then
		if l_where_uwagaki = 0 then
			continue
		end if
		// 更新対象
		l_progress_count ++
		l_update ++
		uo_progress.of_up()
		yield()  // 画面更新を強制

// 悲観ロック解除関数を使わない場合は更新ユーザーID,更新プログラムIDも更新する
		update	M_MISE
		/*
		set		iraimoto_mei		= :l_where_mise_mei
		,			okuri_tokui_code	= :l_where_tokui_send_code
		,			henkou_date			= :l_sysdate
		,			henkou_user_id		= :user.user_id
		,			henkou_client_id	= :device.name
		,			henkou_pg_id		= :i_pg_id
		,			kousin_user_id		= :user.user_id
		,			kousin_pg_id		= :i_pg_id
		,			haita_flg			= :l_haita_flg
		*/
		
		set (mise_kbn, mise_mei_full, mise_mei, mise_mei_ryaku, 
     mise_mei_label, mise_mei_kana, heiten_flg, syusoku_flg,
     todofuken_code, sikutyoson_code, yubin_no,
     jyusyo1, jyusyo2, jyusyo3, okuri_mei1, okuri_mei2,
     tel_no, fax_no, hensin_flg, meisai_kbn, layout_kbn,
     haisin_houhou, hensin_fax_no, hensin_address, hensin_mise_code,
     nohinsyo_hakkou_kbn, nohinsyo_kingaku_flg, nohinsyo_kousou_kbn,
     iraimoto_flg, iraimoto_mei, aite_kaisya_code, aite_mise_code,
     okuri_tokui_code, okuri_mise_code, okuri_center_code,
     syukka_kyoten_sitei_kbn, syukka_kyoten_code, uriage_tokui_code,
     unso_code, tyakuten_code, tyakuten_tome_flg, kobetu_haiso_flg,
     leadtime_kbn, leadtime_keisan_kbn, nouhinbi_hyoji_flg,
     haitatu_sitei_flg, haitatu_sitei_jikoku, nifuda_bikou,
     niokurinin_code, untin_seikyu_flg,
     henkou_date, henkou_user_id, henkou_client_id, henkou_pg_id,
     kousin_user_id, kousin_pg_id, haita_flg) = 
    (select mise_kbn, mise_mei_full, mise_mei, mise_mei_ryaku,
            mise_mei_label, mise_mei_kana, heiten_flg, syusoku_flg,
            todofuken_code, sikutyoson_code, yubin_no,
            jyusyo1, jyusyo2, jyusyo3, okuri_mei1, okuri_mei2,
            tel_no, fax_no, hensin_flg, meisai_kbn, layout_kbn,
            haisin_houhou, hensin_fax_no, hensin_address, hensin_mise_code,
            nohinsyo_hakkou_kbn, nohinsyo_kingaku_flg, nohinsyo_kousou_kbn,
            iraimoto_flg, :l_where_mise_mei, aite_kaisya_code, aite_mise_code,
            :l_where_tokui_send_code, okuri_mise_code, okuri_center_code,
            syukka_kyoten_sitei_kbn, syukka_kyoten_code, uriage_tokui_code,
            unso_code, tyakuten_code, tyakuten_tome_flg, kobetu_haiso_flg,
            leadtime_kbn, leadtime_keisan_kbn, nouhinbi_hyoji_flg,
            haitatu_sitei_flg, haitatu_sitei_jikoku, nifuda_bikou,
            niokurinin_code, untin_seikyu_flg,
            :l_sysdate, :user.user_id, :device.name, :i_pg_id,
            :user.user_id, :i_pg_id, :l_haita_flg
     from M_MISE 
     where rowid = :l_m_mise_from_rowid)
	  
		where		tokui_code			= :l_where_tokui_to_code
		and		mise_code			= :l_mise_code
		using		cocos;
		if cocos.sqlcode <> 0 then
			msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "of_update-5", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
			return false
		end if
	end if
	if isnull(l_m_mise_to_rowid) then
		// 新規対象
		l_progress_count ++
		l_insert ++
		uo_progress.of_up()
		yield()  // 画面更新を強制
		
		insert	into	M_MISE (
					tokui_code
		,			mise_code
		,			mise_kbn
		,			mise_mei_full
		,			mise_mei
		,			mise_mei_ryaku
		,			mise_mei_label
		,			mise_mei_kana
		,			heiten_flg
		,			syusoku_flg
		,			todofuken_code
		,			sikutyoson_code
		,			yubin_no
		,			jyusyo1
		,			jyusyo2
		,			jyusyo3
		,			okuri_mei1
		,			okuri_mei2
		,			tel_no
		,			fax_no
		,			hensin_flg
		,			meisai_kbn
		,			layout_kbn
		,			haisin_houhou
		,			hensin_fax_no
		,			hensin_address
		,			hensin_mise_code
		,			nohinsyo_hakkou_kbn
		,			nohinsyo_kingaku_flg
		,			nohinsyo_kousou_kbn
		,			iraimoto_flg
		,			iraimoto_mei
		,			aite_kaisya_code
		,			aite_mise_code
		,			okuri_tokui_code
		,			okuri_mise_code
		,			okuri_center_code
		,			syukka_kyoten_sitei_kbn
		,			syukka_kyoten_code
		,			uriage_tokui_code
		,			unso_code
		,			tyakuten_code
		,			tyakuten_tome_flg
		,			kobetu_haiso_flg
		,			leadtime_kbn
		,			leadtime_keisan_kbn
		,			nouhinbi_hyoji_flg
		,			haitatu_sitei_flg
		,			haitatu_sitei_jikoku
		,			nifuda_bikou
		,			niokurinin_code
		,			untin_seikyu_flg
		,			touroku_user_id
		,			touroku_client_id
		,			touroku_pg_id
		,			haita_flg
		)
		select	:l_where_tokui_to_code			tokui_code
		,			mise_code
		,			mise_kbn
		,			mise_mei_full
		,			mise_mei
		,			mise_mei_ryaku
		,			mise_mei_label
		,			mise_mei_kana
		,			heiten_flg
		,			syusoku_flg
		,			todofuken_code
		,			sikutyoson_code
		,			yubin_no
		,			jyusyo1
		,			jyusyo2
		,			jyusyo3
		,			okuri_mei1
		,			okuri_mei2
		,			tel_no
		,			fax_no
		,			hensin_flg
		,			meisai_kbn
		,			layout_kbn
		,			haisin_houhou
		,			hensin_fax_no
		,			hensin_address
		,			hensin_mise_code
		,			nohinsyo_hakkou_kbn
		,			nohinsyo_kingaku_flg
		,			nohinsyo_kousou_kbn
		,			iraimoto_flg
		,			:l_where_mise_mei					iraimoto_mei
		,			aite_kaisya_code
		,			aite_mise_code
		,			:l_where_tokui_send_code		okuri_tokui_code
		,			okuri_mise_code
		,			okuri_center_code
		,			syukka_kyoten_sitei_kbn
		,			syukka_kyoten_code
		,			uriage_tokui_code
		,			unso_code
		,			tyakuten_code
		,			tyakuten_tome_flg
		,			kobetu_haiso_flg
		,			leadtime_kbn
		,			leadtime_keisan_kbn
		,			nouhinbi_hyoji_flg
		,			haitatu_sitei_flg
		,			haitatu_sitei_jikoku
		,			nifuda_bikou
		,			niokurinin_code
		,			untin_seikyu_flg
		,			:user.user_id						touroku_user_id
		,			:device.name						touroku_client_id
		,			:i_pg_id								touroku_pg_id
		,			:l_haita_flg						haita_flg
		from		M_MISE
		where		rowid									= :l_m_mise_from_rowid
		using		cocos;
		if cocos.sqlcode <> 0 then
			msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "of_update-6", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
			return false
		end if
	end if
loop
close cur1;
if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-7", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if


// 20241125.ito操作ログ処理実装

ls_message = st_title.text + "[複写元得意先=" + &
             string(uo_tokui_from.sle_input.text) + " " + &
             trim(string(uo_tokui_from.st_meisyo.text)) + " " + &
				 "店コード複写範囲=" + &
             trim(string(sle_mise_from.text)) + " ～ " + &
             trim(string(sle_mise_to.text)) + " "

// 閉店フラグの処理
if cbx_heiten_flg.checked then
    ls_message += "閉店含む "
end if

ls_message += "]"

of_add_db_log("update_event", 0, ls_message)


ls_message2 = st_title.text + "[複写先得意先=" + &
             string(uo_tokui_to.sle_input.text) + " " + &
             trim(string(uo_tokui_to.st_meisyo.text)) + " " + &
 				 "送り得意先=" + &
             string(uo_tokui_send.sle_input.text) + " " + &
             trim(string(uo_tokui_send.st_meisyo.text)) + " " + &
             trim(string(sle_mise_mei.text)) + " " + &
				 "]"

of_add_db_log("update_event", 0, ls_message2)


ls_message3 = st_title.text + "[" + &
             "登録件数=" + string(l_insert) + "件" + " " + &
             "更新件数=" + string(l_update) + "件" + " " + &
				 "]" + i_syori_kbn

of_add_db_log("update_event", 0, ls_message3)


// プログレスバー100%
uo_progress.of_up()

// 結果表示
st_entry_count.text = string(l_count_entry,"#,##0")
if l_where_uwagaki = 0 then
	st_update_count.text = "0"
else
	st_update_count.text = string(l_count_update,"#,##0")
end if

// commit using cocos;
// ランプの色を制御する
uo_signal.of_on_signal( l_lock )

return true

end function

public subroutine of_dsp_reset ();// F9：初期表示

i_syori_kbn = "初期"

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）

// ヘッダ部
of_dsp_edit( "callsection", true )

uo_tokui_from.event constructor( )
st_tokui_from_count.event constructor( )

sle_mise_from.event constructor( )
sle_mise_to.event constructor( )
cbx_heiten_flg.event constructor( )

uo_tokui_to.event constructor( )
st_tokui_to_count.event constructor( )

rb_uwagaki_yes.checked = false
rb_uwagaki_no.checked = true

uo_tokui_send.event constructor( )

sle_mise_mei.event constructor( )

st_entry_count.event constructor( )
st_update_count.event constructor( )

uo_progress.i_min = 0
uo_progress.i_max = 100
uo_progress.i_now = 0
uo_progress.i_step = 1
uo_progress.of_init(0,100,0,1)
uo_progress.event constructor( )

// 明細部
of_dsp_edit( "detailsection", false )

of_set_firstfocus( )

end subroutine

public subroutine of_dsp_back ();// F6：戻りの処理

setredraw( false )

// ヘッダ部
of_dsp_edit( "detailsection", true )

uo_tokui_from.event constructor( )
st_tokui_from_count.event constructor( )

sle_mise_from.event constructor( )
sle_mise_to.event constructor( )
cbx_heiten_flg.event constructor( )

uo_tokui_to.event constructor( )
st_tokui_to_count.event constructor( )

rb_uwagaki_yes.checked = false
rb_uwagaki_no.checked = true

uo_tokui_send.event constructor( )

sle_mise_mei.event constructor( )

st_entry_count.event constructor( )
st_update_count.event constructor( )

uo_progress.i_min = 0
uo_progress.i_max = 100
uo_progress.i_now = 0
uo_progress.i_step = 1
uo_progress.of_init(0,100,0,1)
uo_progress.event constructor( )

// 明細部
of_dsp_edit( "callsection", true )

setredraw( true )

of_set_firstfocus( )

end subroutine

on wm_mise_copy.create
int iCurrent
call super::create
this.st_tokui_from_count_title=create st_tokui_from_count_title
this.rb_uwagaki_no=create rb_uwagaki_no
this.rb_uwagaki_yes=create rb_uwagaki_yes
this.st_uwagaki=create st_uwagaki
this.st_tokui_from_count=create st_tokui_from_count
this.uo_tokui_send=create uo_tokui_send
this.uo_tokui_to=create uo_tokui_to
this.st_mise=create st_mise
this.sle_mise_from=create sle_mise_from
this.st_touroku_date_namidashu=create st_touroku_date_namidashu
this.sle_mise_to=create sle_mise_to
this.st_mise_mei=create st_mise_mei
this.st_tokui_from_count_ken=create st_tokui_from_count_ken
this.cbx_heiten_flg=create cbx_heiten_flg
this.st_arrow=create st_arrow
this.uo_tokui_from=create uo_tokui_from
this.st_tokui_to_count_title=create st_tokui_to_count_title
this.st_tokui_to_count=create st_tokui_to_count
this.st_tokui_to_count_ken=create st_tokui_to_count_ken
this.sle_mise_mei=create sle_mise_mei
this.st_mise_mei_set=create st_mise_mei_set
this.st_entry_count_title=create st_entry_count_title
this.st_entry_count=create st_entry_count
this.st_entry_count_ken=create st_entry_count_ken
this.st_update_count_title=create st_update_count_title
this.st_update_count=create st_update_count
this.st_update_count_ken=create st_update_count_ken
this.uo_progress=create uo_progress
this.st_progress=create st_progress
this.st_tokui_to_set=create st_tokui_to_set
this.gb_uwagaki=create gb_uwagaki
this.gb_tokui_cond=create gb_tokui_cond
this.gb_yoyaku=create gb_yoyaku
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tokui_from_count_title
this.Control[iCurrent+2]=this.rb_uwagaki_no
this.Control[iCurrent+3]=this.rb_uwagaki_yes
this.Control[iCurrent+4]=this.st_uwagaki
this.Control[iCurrent+5]=this.st_tokui_from_count
this.Control[iCurrent+6]=this.uo_tokui_send
this.Control[iCurrent+7]=this.uo_tokui_to
this.Control[iCurrent+8]=this.st_mise
this.Control[iCurrent+9]=this.sle_mise_from
this.Control[iCurrent+10]=this.st_touroku_date_namidashu
this.Control[iCurrent+11]=this.sle_mise_to
this.Control[iCurrent+12]=this.st_mise_mei
this.Control[iCurrent+13]=this.st_tokui_from_count_ken
this.Control[iCurrent+14]=this.cbx_heiten_flg
this.Control[iCurrent+15]=this.st_arrow
this.Control[iCurrent+16]=this.uo_tokui_from
this.Control[iCurrent+17]=this.st_tokui_to_count_title
this.Control[iCurrent+18]=this.st_tokui_to_count
this.Control[iCurrent+19]=this.st_tokui_to_count_ken
this.Control[iCurrent+20]=this.sle_mise_mei
this.Control[iCurrent+21]=this.st_mise_mei_set
this.Control[iCurrent+22]=this.st_entry_count_title
this.Control[iCurrent+23]=this.st_entry_count
this.Control[iCurrent+24]=this.st_entry_count_ken
this.Control[iCurrent+25]=this.st_update_count_title
this.Control[iCurrent+26]=this.st_update_count
this.Control[iCurrent+27]=this.st_update_count_ken
this.Control[iCurrent+28]=this.uo_progress
this.Control[iCurrent+29]=this.st_progress
this.Control[iCurrent+30]=this.st_tokui_to_set
this.Control[iCurrent+31]=this.gb_uwagaki
this.Control[iCurrent+32]=this.gb_tokui_cond
this.Control[iCurrent+33]=this.gb_yoyaku
end on

on wm_mise_copy.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_tokui_from_count_title)
destroy(this.rb_uwagaki_no)
destroy(this.rb_uwagaki_yes)
destroy(this.st_uwagaki)
destroy(this.st_tokui_from_count)
destroy(this.uo_tokui_send)
destroy(this.uo_tokui_to)
destroy(this.st_mise)
destroy(this.sle_mise_from)
destroy(this.st_touroku_date_namidashu)
destroy(this.sle_mise_to)
destroy(this.st_mise_mei)
destroy(this.st_tokui_from_count_ken)
destroy(this.cbx_heiten_flg)
destroy(this.st_arrow)
destroy(this.uo_tokui_from)
destroy(this.st_tokui_to_count_title)
destroy(this.st_tokui_to_count)
destroy(this.st_tokui_to_count_ken)
destroy(this.sle_mise_mei)
destroy(this.st_mise_mei_set)
destroy(this.st_entry_count_title)
destroy(this.st_entry_count)
destroy(this.st_entry_count_ken)
destroy(this.st_update_count_title)
destroy(this.st_update_count)
destroy(this.st_update_count_ken)
destroy(this.uo_progress)
destroy(this.st_progress)
destroy(this.st_tokui_to_set)
destroy(this.gb_uwagaki)
destroy(this.gb_tokui_cond)
destroy(this.gb_yoyaku)
end on

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )

end event

event open;call super::open;
// 初期表示
of_dsp_reset()
of_set_firstfocus()

end event

event key_f12;call super::key_f12;// 更新ボタン

if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0
end event

event retrieve_check;call super::retrieve_check;
// 入力チェック
if not uo_tokui_from.event sle_input_check( ) then
	return -1
end if

// 変更可能かどうか、権限を確認する（管理者権限を持たない場合、管理者権限が必要な区分を検索されたら警告出して強制的に照会モードにする）
if i_permission <> 0 then
	if not i_admin then
		msg.of_warning( "入力された定数区分の内容を変更するためには「システム管理者権限」が必要なため照会モードで継続します。" )
//		ddplb_syori_kbn.text	= "照会"
	end if
end if

return 0

end event

event retrieve_event;call super::retrieve_event;long	l_tokui_code
long	l_row

l_tokui_code = long( trim( uo_tokui_from.of_get_input( ) ) )

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= "表示"

setredraw( false )

// 呼出部をロックする
of_dsp_edit( "callsection", false )

// 明細部
of_dsp_edit( "detailsection", true )

setredraw( true )

of_set_secondfocus( )

end event

event key_f06;call super::key_f06;// 戻り

of_dsp_back()

return 0
end event

event key_f09;call super::key_f09;// 初期表示

if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event update_check;call super::update_check;
long	l_count
long	l_row

long		l_tokui_code

// 入力チェック
if not uo_tokui_from.event sle_input_check( ) then
	return -1
end if

if not sle_mise_from.event input_check( ) then
	return -1
end if
if not sle_mise_to.event input_check( ) then
	return -1
end if

/*
if not uo_tokui_to.event sle_input_check( ) then
	return -1
end if
*/

// エラーメッセージ(No3)
if uo_tokui_to.of_get_syusoku_flg() = 1 then
	msg.of_error( "終息の得意先は指定できません。" )
	uo_tokui_to.of_setfocus()
	return -1
end if
// エラーメッセージ(No4)
if l_tokui_code = uo_tokui_from.of_get_tokui_code() then
	msg.of_error( "複写元と複写先は異なる得意先を設定してください。" )
	uo_tokui_to.of_setfocus()
	return -1
end if

if not uo_tokui_send.event sle_input_check( ) then
	return -1
end if
if not sle_mise_mei.event input_check( ) then
	return -1
end if

// 検索条件設定
// 得意先コード
l_where_tokui_from_code = long( trim( uo_tokui_from.of_get_input() ) )
// 対象店
if lena(sle_mise_from.text) = 0 then
	l_where_mise_from = 1
else
	l_where_mise_from = long(sle_mise_from.text)
end if
sle_mise_from.text = string(l_where_mise_from,"0")
if lena(sle_mise_to.text) = 0 then
	l_where_mise_to = 99999
else
	l_where_mise_to = long(sle_mise_to.text)
end if
sle_mise_to.text = string(l_where_mise_to,"0")
// 閉店
l_where_heiten_flg = 0
if cbx_heiten_flg.checked then
	l_where_heiten_flg = 1
end if
// 複写先
l_where_tokui_to_code = long( trim( uo_tokui_to.of_get_input() ) )
l_where_tokui_send_code = long( trim( uo_tokui_send.of_get_input() ) )
l_where_mise_mei = sle_mise_mei.text
if rb_uwagaki_yes.checked then
	l_where_uwagaki = 1
else
	l_where_uwagaki = 0
end if

// 件数をカウント
select	COUNT(*)
,			sum(case when m_mise_to.mise_code is null then 1 else 0 end)
,			sum(case when m_mise_to.mise_code is null then 0 else 1 end)
,			sum(case when nvl(m_mise_to.haita_flg,0) = 1 then 1 else 0 end)
into		:l_count_where
,			:l_count_entry
,			:l_count_update
,			:l_count_haita
from		M_MISE	m_mise_from
,			M_MISE	m_mise_to
where		m_mise_from.tokui_code	= :l_where_tokui_from_code
and		m_mise_from.mise_code	between :l_where_mise_from and :l_where_mise_to
and		(m_mise_from.heiten_flg = 0 or :l_where_heiten_flg = 1)
and		:l_where_tokui_to_code	= m_mise_to.tokui_code	(+)
and		m_mise_from.mise_code	= m_mise_to.mise_code	(+)
using		cocos;
if cocos.sqlcode = 100 then
	l_count_where = 0
	l_count_entry = 0
	l_count_update = 0
elseif cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-check-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return -1
end if

// 件数チェック
if l_where_uwagaki = 0 then
	// 上書き無し 登録件数無し
	if l_count_entry = 0 then
		msg.of_error( "更新対象のデータがありません。" )
		return -1
	end if
end if
if l_where_uwagaki = 1 then
	// 上書き有り 登録件数、更新件数無し
	if l_count_where = 0 then
		msg.of_error( "更新対象のデータがありません。" )
		return -1
	end if
end if

/*
// 該当するデータが排他フラグ=1の場合
if l_count_haita > 0 then
	msg.of_error( "複写先の排他フラグが有効のため、この処理は実行できません。" )
	return -1
end if
*/


// 店マスタ排他チェック
	string	l_kousin_user_id,l_kousin_client_id
	long l_haita_flg
	
	declare cur_haita cursor for
		select	nvl(m_mise_to.kousin_user_id,'???'),
				nvl(m_mise_to.kousin_client_id,'???'),
				m_mise_to.haita_flg
		  from    M_MISE m_mise_from
		 ,       M_MISE m_mise_to
		 where   m_mise_from.tokui_code = :l_where_tokui_from_code
		 and     m_mise_from.mise_code between :l_where_mise_from and :l_where_mise_to
		 and     (m_mise_from.heiten_flg = 0 or :l_where_heiten_flg = 1)
		 and     :l_where_tokui_to_code = m_mise_to.tokui_code (+)
		 and     m_mise_from.mise_code = m_mise_to.mise_code (+)
		 order by m_mise_to.haita_flg desc
		 using   cocos;
	
	open cur_haita;
	if cocos.sqlcode <> 0 then
		choose case cocos.sqldbcode
			case 54
				//Resource Busy
				msg.of_error("対象データは他の端末で更新処理中です。")
				
			case else
				//DB Exception
				msg.of_error(fnc.strg.of_format("排他チェック処理でエラーが発生しました。{1}{2}",code.crlf,cocos.last_sqlerrtext))
		end choose
		
		// 排他チェックに失敗
		close cur_haita;
		rollback using cocos;
		return -1;
	end if
	
	fetch next cur_haita
	 into :l_kousin_user_id,
		  :l_kousin_client_id,
		  :l_haita_flg;
	
	do while cocos.sqlcode = 0
		// 排他チェック
//		if (l_kousin_user_id <> user.user_id) and (l_haita_flg <> 0) then
		if l_haita_flg <> 0 then
			msg.of_error(fnc.strg.of_format("対象データは他の端末で変更中です。{1}（端末ID:{2} ユーザーID:{3}）",code.crlf,l_kousin_client_id,l_kousin_user_id))
			
			// 排他チェックに失敗
			close cur_haita;
			rollback using cocos;
			return -1;
		end if
		
		// 抜け道
		if l_haita_flg = 0 then exit
		
		// 次行取得
		fetch next cur_haita
		 into :l_kousin_user_id,
			  :l_kousin_client_id,
			  :l_haita_flg;
	loop
	close cur_haita;
	// 排他チェックに成功






return 0

end event

event update_event;call super::update_event;long	l_ret
long	l_count

l_ret = 0
i_syori_kbn = "更新"

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

// 初期表示処理
if l_ret = 0 then
//	this.of_back()
//	this.of_reset()
end if

return l_ret

end event

type uo_signal from iw_main_window`uo_signal within wm_mise_copy
end type

type st_date from iw_main_window`st_date within wm_mise_copy
end type

type st_user_mei from iw_main_window`st_user_mei within wm_mise_copy
integer height = 75
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type uo_test_mode from iw_main_window`uo_test_mode within wm_mise_copy
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_mise_copy
end type

type st_title from iw_main_window`st_title within wm_mise_copy
end type

type st_title_upper from iw_main_window`st_title_upper within wm_mise_copy
end type

type st_upper from iw_main_window`st_upper within wm_mise_copy
end type

type st_second_upper from iw_main_window`st_second_upper within wm_mise_copy
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_mise_copy
integer taborder = 70
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= false
this.visible	= false

end event

type st_tokui_from_count_title from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 2356
integer y = 388
integer width = 360
boolean bringtotop = true
long backcolor = 553648127
string text = "登録件数"
alignment alignment = right!
end type

type rb_uwagaki_no from ivo_radiobutton within wm_mise_copy
string tag = "上書き"
integer x = 1224
integer y = 985
integer width = 372
long backcolor = 553648127
string text = "しない"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_uwagaki_yes from ivo_radiobutton within wm_mise_copy
string tag = "上書き"
integer x = 920
integer y = 985
integer width = 284
long backcolor = 553648127
string text = "する"
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_uwagaki from ivo_statictext within wm_mise_copy
integer x = 496
integer y = 992
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "上書き有無"
alignment alignment = right!
end type

type st_tokui_from_count from sv_st_meisyo within wm_mise_copy
integer x = 2732
integer y = 388
integer width = 360
boolean bringtotop = true
boolean enabled = false
string text = "登録件数"
boolean f3_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= "0"

long		l_tokui_count

l_where_tokui_from_code = long( trim( uo_tokui_from.of_get_input() ) )
l_where_mise_from = long(sle_mise_from.text)
l_where_mise_to = long(sle_mise_to.text)

select	count(*)
into		:l_tokui_count
from		m_mise
where		m_mise.tokui_code		= :l_where_tokui_from_code
and		m_mise.mise_code		between :l_where_mise_from and :l_where_mise_to
using		cocos;

choose case cocos.sqlcode
	case 0
		this.text = String(l_tokui_count,"#,##0")

	case 100
		// データが無い場合は初期化
		this.text = "0"

	case else
		msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		return -1
end choose

return 0

end event

type uo_tokui_send from cv_input_tokui within wm_mise_copy
integer x = 496
integer y = 1092
integer taborder = 50
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
boolean chk_required = true
string title_text = "送り得意先"
long title_width = 390
end type

on uo_tokui_send.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	return true
else
	l_tokui_code		= i_para_tokui[1].tokui_code
end if

return true

end event

event constructor;call super::constructor;// 初期状態
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type uo_tokui_to from cv_input_tokui within wm_mise_copy
integer x = 32
integer y = 789
integer taborder = 40
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
boolean chk_required = true
string title_text = "複写先得意先"
long title_width = 450
boolean syusoku_hyoji = false
end type

on uo_tokui_to.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code
long		l_tokui_count
string 	l_tokui_mei

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	sle_mise_to.event constructor( )
	return true
else
	l_tokui_code		= i_para_tokui[1].tokui_code
	l_tokui_mei			= i_para_tokui[1].tokui_mei

	// エラーメッセージ(No3)
	if this.of_get_syusoku_flg() = 1 then
		msg.of_error( "終息の得意先は指定できません。" )
		this.of_setfocus()
		return false
	end if
	// エラーメッセージ(No4)
	if l_tokui_code = uo_tokui_from.of_get_tokui_code() then
		msg.of_error( "複写元と複写先は異なる得意先を設定してください。" )
		this.of_setfocus()
		return false
	end if
end if

sle_mise_mei.text = this.of_get_tokui_mei_syagai()
st_tokui_to_count.event constructor( )

uo_tokui_send.sle_input.text = string(l_tokui_code)
uo_tokui_send.st_meisyo.text = string(l_tokui_mei)

return true

end event

event constructor;call super::constructor;// 初期状態
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type st_mise from ivo_statictext within wm_mise_copy
integer x = 496
integer y = 580
integer width = 572
boolean bringtotop = true
long backcolor = 553648127
string text = "店コード複写範囲"
alignment alignment = right!
end type

type sle_mise_from from ivo_singlelineedit within wm_mise_copy
string tag = "店コード"
integer x = 1084
integer y = 580
integer width = 240
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "12345"
integer limit = 5
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_num = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.text				= "1"

end event

event input_check;call super::input_check;
//チェック
long		l_mise_from
long		l_mise_to

if lena( trim( this.text ) ) > 0 then
	// 数値チェック
	if not isnumber( this.text ) then
		this.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", this.text ) )
		return false
	end if

	l_mise_from = long( this.text )

	if l_mise_from < 1 or l_mise_to > 99999 then
		this.of_msg_error( "入力値「" + this.tag + "」は入力範囲を超えています。~r~n【入力範囲：1～99999】" )
		this.setfocus()
		return false
	end if

	// 大小チェック
	if lena( trim( sle_mise_to.text ) ) > 0 then
		l_mise_to	= long(sle_mise_to.text)

		if l_mise_from > l_mise_to then
			this.of_msg_error( "店コードの前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= String(l_mise_from)
	l_where_mise_from = l_mise_from
end if

st_tokui_from_count.event constructor( )
st_tokui_to_count.event constructor( )

return true

end event

event key_f08;call super::key_f08;
str_mdlpara_mmise	l_mdl_mise
str_mmise			l_para_mise[]			// データの受け渡しをする構造体
str_mmise			l_para_reset[]			// i_mdl_mise.retの初期化用

if lena( trim( uo_tokui_from.of_get_input() ) ) > 0 then
	l_mdl_mise.in_tokui_code = long( trim( uo_tokui_from.of_get_input() ) )
end if
// モーダルを開く
l_mdl_mise	= mdl.of_open_modal( "wsm_mise", l_mdl_mise )

if upperbound( l_mdl_mise.ret ) > 0 then
	l_para_mise								= l_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	l_para_mise[upperbound(l_para_mise) + 1]	= l_mdl_mise.ret[upperbound( l_mdl_mise.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	this.text = string( l_para_mise[1].mise_code )
	this.event input_check()
	this.selecttext( 1, len( this.text ) )
end if

return 0

end event

type st_touroku_date_namidashu from ivo_statictext within wm_mise_copy
integer x = 1340
integer y = 580
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_mise_to from ivo_singlelineedit within wm_mise_copy
string tag = "店コード"
integer x = 1508
integer y = 580
integer width = 240
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
string text = "12345"
integer limit = 5
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_num = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.text				= "99999"

end event

event input_check;call super::input_check;
//チェック
long		l_mise_from
long		l_mise_to

if lena( trim( this.text ) ) > 0 then
	// 数値チェック
	if not isnumber( this.text ) then
		this.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", this.text ) )
		return false
	end if

	l_mise_to = long(this.text)

	if l_mise_to < 1 or l_mise_to > 99999 then
		this.of_msg_error( "入力値「" + this.tag + "」は入力範囲を超えています。~r~n【入力範囲：1～99999】" )
		this.setfocus()
		return false
	end if

	// 大小チェック
	if lena( trim( sle_mise_from.text ) ) > 0 then
		l_mise_from	= long(sle_mise_from.text)

		if l_mise_to < l_mise_from then
			this.of_msg_error( "店コードの前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= string(l_mise_to)
	l_where_mise_to = l_mise_to
end if

st_tokui_from_count.event constructor( )
st_tokui_to_count.event constructor( )

return true

end event

event key_f08;call super::key_f08;
str_mdlpara_mmise	l_mdl_mise
str_mmise			l_para_mise[]			// データの受け渡しをする構造体
str_mmise			l_para_reset[]			// i_mdl_mise.retの初期化用

if lena( trim( uo_tokui_from.of_get_input() ) ) > 0 then
	l_mdl_mise.in_tokui_code = long( trim( uo_tokui_from.of_get_input() ) )
end if
// モーダルを開く
l_mdl_mise	= mdl.of_open_modal( "wsm_mise", l_mdl_mise )

if upperbound( l_mdl_mise.ret ) > 0 then
	l_para_mise								= l_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	l_para_mise[upperbound(l_para_mise) + 1]	= l_mdl_mise.ret[upperbound( l_mdl_mise.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	this.text = string( l_para_mise[1].mise_code )
	this.event input_check()
	this.selecttext( 1, len( this.text ) )
end if

return 0

end event

type st_mise_mei from ivo_statictext within wm_mise_copy
integer x = 496
integer y = 1191
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "依頼元名"
alignment alignment = right!
end type

type st_tokui_from_count_ken from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 3108
integer y = 388
integer width = 152
boolean bringtotop = true
long backcolor = 553648127
string text = "件"
alignment alignment = right!
end type

type cbx_heiten_flg from ivo_checkbox within wm_mise_copy
string tag = "閉店を含む"
integer x = 1764
integer y = 580
integer width = 548
long backcolor = 553648127
string text = "閉店を含む"
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.checked	= false
end event

type st_arrow from ivo_statictext within wm_mise_copy
integer x = 1340
integer y = 700
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "↓"
alignment alignment = center!
end type

type uo_tokui_from from cv_input_tokui within wm_mise_copy
event destroy ( )
integer x = 32
integer y = 388
integer taborder = 10
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
boolean chk_required = true
string title_text = "複写元得意先"
long title_width = 450
end type

on uo_tokui_from.destroy
call cv_input_tokui::destroy
end on

event constructor;call super::constructor;// 初期状態
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code
long		l_tokui_count

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	st_tokui_from_count.event	constructor()
	return false
else
	l_tokui_code	= i_para_tokui[1].tokui_code

	// エラーメッセージ(No4)
	if l_tokui_code = uo_tokui_to.of_get_tokui_code() then
		msg.of_error( "複写元と複写先は異なる得意先を設定してください。" )
		this.of_setfocus()
		return false
	end if

	// 対象店
	if lena(sle_mise_from.text) = 0 then
		l_where_mise_from = 0
	else
		l_where_mise_from = long(sle_mise_from.text)
	end if
	sle_mise_from.text = string(l_where_mise_from,"0")
	if lena(sle_mise_to.text) = 0 then
		l_where_mise_to = 99999
	else
		l_where_mise_to = long(sle_mise_to.text)
	end if
	sle_mise_to.text = string(l_where_mise_to,"0")
end if

st_tokui_from_count.event constructor( )

return true

end event

type st_tokui_to_count_title from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 2356
integer y = 789
integer width = 360
boolean bringtotop = true
long backcolor = 553648127
string text = "登録件数"
alignment alignment = right!
end type

type st_tokui_to_count from sv_st_meisyo within wm_mise_copy
integer x = 2732
integer y = 789
integer width = 360
boolean bringtotop = true
boolean enabled = false
string text = "登録件数"
boolean f3_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= "0"

long		l_tokui_count

l_where_tokui_to_code = long( trim( uo_tokui_to.of_get_input() ) )
l_where_mise_from = long(sle_mise_from.text)
l_where_mise_to = long(sle_mise_to.text)

select	count(*)
into		:l_tokui_count
from		m_mise
where		m_mise.tokui_code		= :l_where_tokui_to_code
and		m_mise.mise_code		between :l_where_mise_from and :l_where_mise_to
using		cocos;

choose case cocos.sqlcode
	case 0
		this.text = String(l_tokui_count,"#,##0")

	case 100
		// データが無い場合は初期化
		this.text = "0"

	case else
		msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		return -1
end choose

return 0

end event

type st_tokui_to_count_ken from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 3108
integer y = 789
integer width = 152
boolean bringtotop = true
long backcolor = 553648127
string text = "件"
alignment alignment = right!
end type

type sle_mise_mei from ivo_singlelineedit within wm_mise_copy
integer x = 900
integer y = 1191
integer width = 1768
integer taborder = 60
boolean bringtotop = true
integer init_imemode = 1
integer limit = 40
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type st_mise_mei_set from ivo_statictext within wm_mise_copy
integer x = 2820
integer y = 1191
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "をセット"
end type

type st_entry_count_title from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 1132
integer y = 1404
integer width = 360
boolean bringtotop = true
long backcolor = 553648127
string text = "登録件数"
alignment alignment = right!
end type

type st_entry_count from sv_st_meisyo within wm_mise_copy
integer x = 1508
integer y = 1404
integer width = 360
boolean bringtotop = true
boolean enabled = false
string text = "登録件数"
boolean f3_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= "0"

end event

type st_entry_count_ken from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 1884
integer y = 1404
integer width = 152
boolean bringtotop = true
long backcolor = 553648127
string text = "件"
alignment alignment = right!
end type

type st_update_count_title from ivo_statictext within wm_mise_copy
string tag = "更新件数"
integer x = 1132
integer y = 1508
integer width = 360
boolean bringtotop = true
long backcolor = 553648127
string text = "更新件数"
alignment alignment = right!
end type

type st_update_count from sv_st_meisyo within wm_mise_copy
integer x = 1508
integer y = 1508
integer width = 360
boolean bringtotop = true
boolean enabled = false
string text = "更新件数"
boolean f3_key = true
end type

event constructor;call super::constructor;// 初期状態
this.text	= "0"

end event

type st_update_count_ken from ivo_statictext within wm_mise_copy
string tag = "登録件数"
integer x = 1884
integer y = 1508
integer width = 152
boolean bringtotop = true
long backcolor = 553648127
string text = "件"
alignment alignment = right!
end type

type uo_progress from cv_hprogressbar_pct within wm_mise_copy
integer x = 832
integer y = 1707
integer height = 82
boolean bringtotop = true
integer i_step = 1
end type

on uo_progress.destroy
call cv_hprogressbar_pct::destroy
end on

type st_progress from ivo_statictext within wm_mise_copy
string tag = "更新状況"
integer x = 484
integer y = 1707
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "更新状況"
alignment alignment = right!
end type

type st_tokui_to_set from ivo_statictext within wm_mise_copy
integer x = 2820
integer y = 1092
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "をセット"
end type

type gb_uwagaki from ivo_groupbox within wm_mise_copy
integer x = 900
integer y = 946
integer width = 720
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_tokui_cond from ivo_groupbox within wm_mise_copy
integer x = 484
integer y = 487
integer width = 1844
integer height = 203
boolean bringtotop = false
long backcolor = 553648127
string text = "複写元条件"
boolean f12_key = true
end type

type gb_yoyaku from ivo_groupbox within wm_mise_copy
integer x = 484
integer y = 892
integer width = 2680
integer height = 402
boolean bringtotop = false
long backcolor = 553648127
string text = "複写先更新指定"
boolean f12_key = true
end type

