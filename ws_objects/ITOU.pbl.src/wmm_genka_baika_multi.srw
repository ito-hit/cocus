$PBExportHeader$wmm_genka_baika_multi.srw
$PBExportComments$原価売価登録（一覧）
forward
global type wmm_genka_baika_multi from iw_main_window
end type
type gb_tankahyo from ivo_groupbox within wmm_genka_baika_multi
end type
type st_syori_kbn from ivo_statictext within wmm_genka_baika_multi
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_genka_baika_multi
end type
type uo_daibunrui from cv_input_bunrui within wmm_genka_baika_multi
end type
type uo_tyubunrui from cv_input_bunrui within wmm_genka_baika_multi
end type
type uo_syobunrui from cv_input_bunrui within wmm_genka_baika_multi
end type
type uo_group from cv_input_group within wmm_genka_baika_multi
end type
type uo_tokui from cv_input_tokui within wmm_genka_baika_multi
end type
type uo_kojyo from cv_input_kojyo within wmm_genka_baika_multi
end type
type uo_brand from cv_input_brand within wmm_genka_baika_multi
end type
type uo_bumon from cv_input_meisyo within wmm_genka_baika_multi
end type
type uo_season from cv_input_meisyo within wmm_genka_baika_multi
end type
type sle_tekiyo_start_date_from_t from ivo_statictext within wmm_genka_baika_multi
end type
type sle_tekiyo_start_date_from from ivo_singlelineedit within wmm_genka_baika_multi
end type
type sle_tekiyo_start_date_to_t from ivo_statictext within wmm_genka_baika_multi
end type
type sle_tekiyo_start_date_to from ivo_singlelineedit within wmm_genka_baika_multi
end type
type ddplb_zei_kbn_t from ivo_statictext within wmm_genka_baika_multi
end type
type sle_zeiritu from ivo_singlelineedit within wmm_genka_baika_multi
end type
type rb_input_hoho_t from ivo_statictext within wmm_genka_baika_multi
end type
type rb_tujyo from ivo_radiobutton within wmm_genka_baika_multi
end type
type rb_all from ivo_radiobutton within wmm_genka_baika_multi
end type
type cbx_jyoudai_flg from ivo_checkbox within wmm_genka_baika_multi
end type
type cbx_haiban_flg from ivo_checkbox within wmm_genka_baika_multi
end type
type cbx_bettyu_flg from ivo_checkbox within wmm_genka_baika_multi
end type
type st_tekiyo_start_date from ivo_statictext within wmm_genka_baika_multi
end type
type st_zeiritu from ivo_statictext within wmm_genka_baika_multi
end type
type st_percent from ivo_statictext within wmm_genka_baika_multi
end type
type ddplb_zei_kbn from sv_ddplb_meisyo within wmm_genka_baika_multi
end type
type cbx_tankahyo_9 from ivo_checkbox within wmm_genka_baika_multi
end type
type cbx_tankahyo_1 from ivo_checkbox within wmm_genka_baika_multi
end type
type cbx_tankahyo_2 from ivo_checkbox within wmm_genka_baika_multi
end type
type st_tankahyo_hakkou_kbn from ivo_statictext within wmm_genka_baika_multi
end type
type cbx_tankahyo_3 from ivo_checkbox within wmm_genka_baika_multi
end type
type st_syohin_cd_to from ivo_statictext within wmm_genka_baika_multi
end type
type sle_syohin_cd_from from ivo_singlelineedit within wmm_genka_baika_multi
end type
type sle_syohin_cd_to from ivo_singlelineedit within wmm_genka_baika_multi
end type
type st_syohin_cd_from from ivo_statictext within wmm_genka_baika_multi
end type
type sle_tekiyo_start_date from ivo_singlelineedit within wmm_genka_baika_multi
end type
type dw_list from ivo_datawindow within wmm_genka_baika_multi
end type
type st_aite_hinban_t from ivo_statictext within wmm_genka_baika_multi
end type
type st_aite_hinban from sv_st_meisyo within wmm_genka_baika_multi
end type
type syohin_genka_check from structure within wmm_genka_baika_multi
end type
type up_iti_check from structure within wmm_genka_baika_multi
end type
type iro_up_check from structure within wmm_genka_baika_multi
end type
end forward

type syohin_genka_check from structure
	long		syohin_code
	long		genka
end type

type up_iti_check from structure
	long		syohin_code
	long		iro_no
	long		up_iti
	long		up_1
	long		up_2
	long		up_3
	long		up_4
	long		up_5
end type

type iro_up_check from structure
	long		syohin_code
	long		iro_no
	long		up_1
	long		up_2
	long		up_3
	long		up_4
	long		up_5
end type

global type wmm_genka_baika_multi from iw_main_window
string title = "原価売価登録（一覧）"
gb_tankahyo gb_tankahyo
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
uo_daibunrui uo_daibunrui
uo_tyubunrui uo_tyubunrui
uo_syobunrui uo_syobunrui
uo_group uo_group
uo_tokui uo_tokui
uo_kojyo uo_kojyo
uo_brand uo_brand
uo_bumon uo_bumon
uo_season uo_season
sle_tekiyo_start_date_from_t sle_tekiyo_start_date_from_t
sle_tekiyo_start_date_from sle_tekiyo_start_date_from
sle_tekiyo_start_date_to_t sle_tekiyo_start_date_to_t
sle_tekiyo_start_date_to sle_tekiyo_start_date_to
ddplb_zei_kbn_t ddplb_zei_kbn_t
sle_zeiritu sle_zeiritu
rb_input_hoho_t rb_input_hoho_t
rb_tujyo rb_tujyo
rb_all rb_all
cbx_jyoudai_flg cbx_jyoudai_flg
cbx_haiban_flg cbx_haiban_flg
cbx_bettyu_flg cbx_bettyu_flg
st_tekiyo_start_date st_tekiyo_start_date
st_zeiritu st_zeiritu
st_percent st_percent
ddplb_zei_kbn ddplb_zei_kbn
cbx_tankahyo_9 cbx_tankahyo_9
cbx_tankahyo_1 cbx_tankahyo_1
cbx_tankahyo_2 cbx_tankahyo_2
st_tankahyo_hakkou_kbn st_tankahyo_hakkou_kbn
cbx_tankahyo_3 cbx_tankahyo_3
st_syohin_cd_to st_syohin_cd_to
sle_syohin_cd_from sle_syohin_cd_from
sle_syohin_cd_to sle_syohin_cd_to
st_syohin_cd_from st_syohin_cd_from
sle_tekiyo_start_date sle_tekiyo_start_date
dw_list dw_list
st_aite_hinban_t st_aite_hinban_t
st_aite_hinban st_aite_hinban
end type
global wmm_genka_baika_multi wmm_genka_baika_multi

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str
	
	// 呼出し部の情報を保管
	long	i_tekiyo_start_date_from
	long	i_tekiyo_start_date_to
	string i_syori_kbn
	long    i_tokui_code, i_tekiyo_start_date
	long	i_bumon_code
	string  i_syohin_code_from
	string  i_syohin_code_to
	long  i_daibunrui_code
	long  i_tyubunrui_code
	long  i_syobunrui_code
	long	i_group_code
	long	i_brand_code
	long	i_season_code
	long	i_kojyo_code
	long i_zeiritu_str_date
	long i_zeiritu_end_date

	boolean	i_jyoudai_flg
	boolean	i_haiban_flg
	boolean	i_bettyu_flg
	
	boolean	i_none_flg
	boolean	i_haru_natu_flg
	boolean	i_aki_fuyu_flg
	boolean	i_all_flg
	
	string ls_tankahyo_condition
	boolean lb_has_tankahyo_condition
	
	long i_syohizei_kbn
	nv_master	mst
	
end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_reset ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_open ()
public function integer of_check_new_up ()
public function boolean of_record_lock (boolean p_lock)
public function boolean of_db_update (any p_rec)
public function boolean of_db_delete (any p_rec)
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )
rb_tujyo.event constructor( )
rb_all.event constructor( )
sle_zeiritu.event constructor()
ddplb_zei_kbn.event constructor()
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= ddplb_syori_kbn.text

// constructorで各コントロールリセット

dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
uo_tokui.event constructor( )

uo_daibunrui.event constructor( )
uo_tyubunrui.event constructor( )
uo_syobunrui.event constructor( )

uo_kojyo.event constructor( )
uo_brand.event constructor( )
uo_season.event constructor( )
uo_bumon.event constructor( )


uo_group.event constructor( )

sle_syohin_cd_from.event constructor( )
sle_syohin_cd_to.event constructor( )

cbx_jyoudai_flg.event constructor( )
cbx_haiban_flg.event constructor( )
cbx_bettyu_flg.event constructor( )

cbx_tankahyo_9.event constructor( )
cbx_tankahyo_1.event constructor( )
cbx_tankahyo_2.event constructor( )
cbx_tankahyo_3.event constructor( )

sle_tekiyo_start_date.event constructor( )
ddplb_zei_kbn.event constructor( )
sle_zeiritu.event constructor( )
rb_tujyo.event constructor( )
rb_all.event constructor( )
sle_tekiyo_start_date_from.event constructor( )
sle_tekiyo_start_date_to.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

// selectionchangedを呼び出す
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row
boolean toggle_p_enabled
if p_enabled then
	toggle_p_enabled = false
else
	toggle_p_enabled = true
end if
choose case p_control
	case "callsection"
		//uo_tokui.of_set_enabled( p_enabled )
		//ddplb_syori_kbn.enabled = p_enabled
		rb_tujyo.checked = true
		rb_tujyo.enabled = toggle_p_enabled
		rb_all.checked = false
		rb_all.enabled = toggle_p_enabled
		sle_tekiyo_start_date_from.enabled = toggle_p_enabled
		sle_tekiyo_start_date_to.enabled = toggle_p_enabled
		ddplb_syori_kbn.enabled = p_enabled
		uo_tokui.of_set_enabled( p_enabled )
		uo_daibunrui.of_set_enabled( p_enabled )
		uo_kojyo.of_set_enabled( p_enabled )
		uo_tyubunrui.of_set_enabled( p_enabled )
		uo_brand.of_set_enabled( p_enabled )
		uo_syobunrui.of_set_enabled( p_enabled )
		uo_season.of_set_enabled( p_enabled )
		uo_bumon.of_set_enabled( p_enabled )
		uo_group.of_set_enabled( p_enabled )
		sle_syohin_cd_from.enabled = p_enabled
		sle_syohin_cd_to.enabled = p_enabled
		cbx_jyoudai_flg.enabled = p_enabled
		cbx_haiban_flg.enabled = p_enabled
		cbx_bettyu_flg.enabled = p_enabled
		cbx_tankahyo_9.enabled = p_enabled
		cbx_tankahyo_1.enabled = p_enabled
		cbx_tankahyo_2.enabled = p_enabled
		cbx_tankahyo_3.enabled = p_enabled
		ddplb_zei_kbn.enabled = toggle_p_enabled
		sle_zeiritu.enabled = toggle_p_enabled
		sle_tekiyo_start_date.enabled = p_enabled
		cb_retrieve.enabled		= p_enabled
end choose
end subroutine

public subroutine of_dsp_open ();
end subroutine

public function integer of_check_new_up ();return 0
end function

public function boolean of_record_lock (boolean p_lock);
long l_i, l_count
string ls_prev_syohin_code
boolean lb_need_lock

l_count = dw_list.RowCount()

// 悲観ロック＆ロック解除関数
if p_lock then
	// ロック
    ls_prev_syohin_code = "" // 前の商品コードを初期化
	for l_i = 1 to l_count
		// 前の商品コードと現在の商品コードを比較
        lb_need_lock = (ls_prev_syohin_code <> string(dw_list.object.syohin_dsp[l_i]))
		// 商品コードが異なる場合のみロック
        if lb_need_lock then
            if lck.of_tanka_lock(i_pg_id, i_tokui_code, dw_list.object.syohin_dsp[l_i]) then
                commit using cocos;  // commitは子孫側で行う
            else
                return false
            end if
        end if
		
		if lck.of_aite_hinban_lock( i_pg_id, i_tokui_code, dw_list.object.sku_code[l_i] ) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
		
		// 現在の商品コードを保存
        ls_prev_syohin_code = string(dw_list.object.syohin_dsp[l_i])
	next
else
	// アンロック
	ls_prev_syohin_code = "" // 前の商品コードを初期化
	for l_i = 1 to l_count
        lb_need_lock = (ls_prev_syohin_code <> string(dw_list.object.syohin_dsp[l_i]))
		   if lb_need_lock then
            if lck.of_tanka_unlock(i_pg_id, i_tokui_code, dw_list.object.syohin_dsp[l_i]) then
                commit using cocos;  // commitは子孫側で行う
            else
                return false
            end if
        end if

		if lck.of_aite_hinban_unlock( i_pg_id, i_tokui_code, dw_list.object.sku_code[l_i] ) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
		// 現在の商品コードを保存
        ls_prev_syohin_code = string(dw_list.object.syohin_dsp[l_i])
	next
	
end if

uo_signal.of_on_signal( p_lock )

return true
end function

public function boolean of_db_update (any p_rec);
// 変数宣言
long l_i, l_count, ll_row
long l_tokuisaki_cd, l_shohin_cd, l_iro_no, l_today, l_tekiyo_start_date, l_tekiyo_end_date, l_zeiritu, ls_zei_kbn, l_tanka, l_aite_hinban, l_aite_baika1, l_aite_baika2, l_new_baika1, l_new_baika2
decimal{2} ldc_tanka, ldc_new_up1, ldc_new_up2, ldc_new_up3, ldc_new_up4, ldc_new_up5, ldc_zeibetu_tanka, ldc_zeibetu_up_1, ldc_zeibetu_up_2, ldc_zeibetu_up_3, ldc_zeibetu_up_4, ldc_zeibetu_up_5
boolean l_sokuji

string ls_operation_type
any la_operations[]

any la_current_op[]
string ls_log_message

l_count = dw_list.RowCount()

// 即時か予約かの判定
if sle_tekiyo_start_date_from.text <> "" then
	l_today = long(string( fnc.db.of_get_date(), "yyyymmdd"))
	if i_tekiyo_start_date_from <= l_today then
		l_sokuji = true
	else
		l_sokuji = false
	end if
else
	l_sokuji = true
end if

for l_i = 1 to l_count
	// チェックの入っている行のみ更新対象
	if dw_list.object.chk[l_i] = 0 then
		continue
	end if
	any la_op[6]
	// データウィンドウから値を取得
	l_shohin_cd = dw_list.object.mt_syohin[l_i]
	l_tokuisaki_cd = dw_list.object.mt_tokui[l_i]
	ldc_tanka = dw_list.object.new_tanka[l_i]
	ldc_new_up1 = dw_list.object.new_up_1[l_i]
	ldc_new_up2 = dw_list.object.new_up_2[l_i]
	ldc_new_up3 = dw_list.object.new_up_3[l_i]
	ldc_new_up4 = dw_list.object.new_up_4[l_i]
	ldc_new_up5 = dw_list.object.new_up_5[l_i]
	ls_zei_kbn = dw_list.object.zei_kbn[l_i]
	l_zeiritu = dw_list.object.zeiritu[l_i]
	l_tanka = dw_list.object.tanka[l_i]
	l_tekiyo_start_date = i_tekiyo_start_date_from
	l_tekiyo_end_date = i_tekiyo_start_date_to
	
	l_iro_no = dw_list.object.iro_no[l_i]
	l_aite_hinban = long(dw_list.object.aite_hinban[l_i])
	l_aite_baika1 = dw_list.object.aite_baika1[l_i]
	l_aite_baika2 = dw_list.object.aite_baika2[l_i]
	l_new_baika1 = dw_list.object.new_baika1[l_i]
	l_new_baika2 = dw_list.object.new_baika2[l_i]

	// 即時更新の場合
	if l_sokuji then
		// 即時更新かつ税区分が1:単価税込の場合税別の単価、アップ額を計算する
		if ls_zei_kbn = 1 then
			ldc_zeibetu_tanka = dw_list.object.new_tanka[l_i] - round(dw_list.object.new_tanka[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
			ldc_zeibetu_up_1 =  dw_list.object.new_up_1[l_i] - round(dw_list.object.new_up_1[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
			ldc_zeibetu_up_2 =  dw_list.object.new_up_2[l_i] - round(dw_list.object.new_up_2[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
			ldc_zeibetu_up_3 =  dw_list.object.new_up_3[l_i] - round(dw_list.object.new_up_3[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
			ldc_zeibetu_up_4 =  dw_list.object.new_up_4[l_i] - round(dw_list.object.new_up_4[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
			ldc_zeibetu_up_5 =  dw_list.object.new_up_5[l_i] - round(dw_list.object.new_up_5[l_i] / (1 + dw_list.object.zeiritu[l_i] / 100) * (dw_list.object.zeiritu[l_i] / 100), 0)
		end if

		update	m_tanka
		set	tanka		= :ldc_tanka,
			up_1 = :ldc_new_up1,
			up_2 = :ldc_new_up2,
			up_3 = :ldc_new_up3,
			up_4 = :ldc_new_up4,
			up_5 = :ldc_new_up5,
			tanka_henkou_date = :l_tekiyo_start_date,
			old_tanka = :l_tanka,
			zei_kbn = :ls_zei_kbn,
			zeiritu = :l_zeiritu,
			zeibetu_tanka = case when :ls_zei_kbn = '1' then :ldc_zeibetu_tanka else zeibetu_tanka end,
			zeibetu_up_1 = case when :ls_zei_kbn = '1' then :ldc_zeibetu_up_1 else zeibetu_up_1 end,
			zeibetu_up_2 = case when :ls_zei_kbn = '1' then :ldc_zeibetu_up_2 else zeibetu_up_2 end,
			zeibetu_up_3 = case when :ls_zei_kbn = '1' then :ldc_zeibetu_up_3 else zeibetu_up_3 end,
			zeibetu_up_4 = case when :ls_zei_kbn = '1' then :ldc_zeibetu_up_4 else zeibetu_up_4 end,
			zeibetu_up_5 = case when :ls_zei_kbn = '1' then :ldc_zeibetu_up_5 else zeibetu_up_5 end,
			henkou_date			= sysdate,
			henkou_user_id		= :user.user_id,
			henkou_client_id	= :device.name,
			henkou_pg_id		= :i_pg_id
			where	tokui_code	= :l_tokuisaki_cd
		and syohin_code			= :l_shohin_cd
		using cocos;
		
		// 2. 相手品番マスターへの操作
		//新売価の1,2,相手品番全てが初期値だったら相手品番マスタを削除する
		if dw_list.object.new_baika1[l_i] = 0 and dw_list.object.new_baika2[l_i] = 0 and (isnull(dw_list.object.aite_hinban[l_i]) or trim(dw_list.object.aite_hinban[l_i]) = "")then
			delete m_aite_hinban 
			where	tokui_code	= :l_tokuisaki_cd
			and syohin_code			= :l_shohin_cd
			and iro_no			= :l_iro_no
			using cocos;
		else
			//新売価の1,2,相手品番のいずれかが入力されていたら相手品番マスタを更新する
			update	m_aite_hinban
			set	aite_hinban		= :l_aite_hinban,
				aite_baika1 = :l_aite_baika1,
				aite_baika2 = :l_aite_baika2,
				henkou_date			= SYSDATE,
				henkou_user_id		= :user.user_id,
				henkou_client_id	= :device.name,
				henkou_pg_id		= :i_pg_id
				where	tokui_code	= :l_tokuisaki_cd
			and syohin_code			= :l_shohin_cd
			and iro_no			= :l_iro_no
			using cocos;
		end if
	// 予約の場合
	else
		update	m_tanka
		set	new_tanka		= :ldc_tanka,
			new_up_1 = :ldc_new_up1,
			new_up_2 = :ldc_new_up2,
			new_up_3 = :ldc_new_up3,
			new_up_4 = :ldc_new_up4,
			new_up_5 = :ldc_new_up5,
			new_zei_kbn = :ls_zei_kbn,
			new_zeiritu = :l_zeiritu,
			tekiyo_date_str = :l_tekiyo_start_date,
			tekiyo_date_end = :i_tekiyo_start_date_to,
			henkou_date			= SYSDATE,
			henkou_user_id		= :user.user_id,
			henkou_client_id	= :device.name,
			henkou_pg_id		= :i_pg_id
		where	tokui_code	= :l_tokuisaki_cd
		and syohin_code			= :l_shohin_cd
		using cocos;
		// 2. 相手品番マスターへの操作
		//新売価の1,2,相手品番全てが初期値だったら相手品番マスタを削除する
		if dw_list.object.new_baika1[l_i] = 0 and dw_list.object.new_baika2[l_i] = 0 and isnull(dw_list.object.aite_hinban[l_i]) then
			delete m_aite_hinban 
			where	tokui_code	= :l_tokuisaki_cd
			and syohin_code			= :l_shohin_cd
			and iro_no			= :l_iro_no
			using cocos;
		else
			//新売価の1,2,相手品番のいずれかが入力されていたら相手品番マスタを更新する
			update	m_aite_hinban
			set	aite_hinban		= :l_aite_hinban,
				new_baika1 = :l_aite_baika1,
				new_baika2 = :l_aite_baika2,
				tekiyo_date_str = :l_tekiyo_start_date,
				tekiyo_date_end = :i_tekiyo_start_date_to,
				henkou_date			= SYSDATE,
				henkou_user_id		= :user.user_id,
				henkou_client_id	= :device.name,
				henkou_pg_id		= :i_pg_id
			where	tokui_code	= :l_tokuisaki_cd
			and syohin_code			= :l_shohin_cd
			and iro_no			= :l_iro_no
			using cocos;
		end if
		
	end if 

	if cocos.sqlcode <> 0 then
		// (更新)更新エラー
		msg.of_error(fnc.strg.of_format("{1}の更新処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
		of_add_db_log("update_event",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
		rollback using cocos;
		return false
	end if
	
	// 操作情報を配列に格納
	la_op[1] = string(i_tokui_code)
	la_op[2] = trim(string(uo_tokui.st_meisyo.text))
	la_op[3] = trim(string(dw_list.object.mt_syohin[l_i]))
	la_op[4] = trim(string(dw_list.object.hin_ban[l_i]))
	la_op[5] = trim(string(dw_list.object.hin_mei[l_i]))
	la_op[6] = ddplb_syori_kbn.text
	
	la_operations[UpperBound(la_operations) + 1] = la_op

next

// ログを明細ごとに出す
for ll_row = 1 to UpperBound(la_operations)
	la_current_op = la_operations[ll_row]
	ls_log_message = st_title.text + "[" + &
							string(la_current_op[1]) + " " + &
							string(la_current_op[2]) + " " + &
							string(la_current_op[3]) + " " + &
							string(la_current_op[4]) + " " + &
							string(la_current_op[5]) + "]" + &
							string(la_current_op[6])
    of_add_db_log("of_db_update", 0, ls_log_message)
next

return true
end function

public function boolean of_db_delete (any p_rec);
// 変数宣言
long l_i, l_count, ll_row
long l_tokuisaki_cd, l_shohin_cd, l_iro_no

any la_operations[]
any la_current_op[]
string ls_log_message

// データウィンドウの行数を取得
l_count = dw_list.RowCount()
for l_i = 1 to l_count
	if dw_list.object.chk[l_i] = 0 then
		continue
	end if
	any la_op2[6]
	l_shohin_cd = dw_list.object.mt_syohin[l_i]
	l_tokuisaki_cd = dw_list.object.mt_tokui[l_i]
	l_iro_no = dw_list.object.iro_no[l_i]

	delete from m_tanka
	where	tokui_code	= :l_tokuisaki_cd
		and syohin_code			= :l_shohin_cd
	using cocos;

	delete from m_aite_hinban
	where	tokui_code	= :l_tokuisaki_cd
		and syohin_code			= :l_shohin_cd
		and iro_no			= :l_iro_no
	using cocos;

	if cocos.sqlcode <> 0 then
		// (更新)更新エラー
		msg.of_error(fnc.strg.of_format("{1}の更新処理でエラーが発生しました。{2}{3}：{4}",this.title,code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
		of_add_db_log("of_db_delete",cocos.last_sqlerrcode,cocos.last_sqlerrtext)
		rollback using cocos;
		return false
	end if
	
	// 操作情報を配列に格納
	la_op2[1] = string(i_tokui_code)
	la_op2[2] = trim(string(uo_tokui.st_meisyo.text))
	la_op2[3] = trim(string(dw_list.object.mt_syohin[l_i]))
	la_op2[4] = trim(string(dw_list.object.hin_ban[l_i]))
	la_op2[5] = trim(string(dw_list.object.hin_mei[l_i]))
	la_op2[6] = ddplb_syori_kbn.text
	la_operations[UpperBound(la_operations) + 1] = la_op2
next

// ログを明細ごとに出す
for ll_row = 1 to UpperBound(la_operations)
	la_current_op = la_operations[ll_row]
	ls_log_message = st_title.text + "[" + &
							string(la_current_op[1]) + " " + &
							string(la_current_op[2]) + " " + &
							string(la_current_op[3]) + " " + &
							string(la_current_op[4]) + " " + &
							string(la_current_op[5]) + "]" + &
							string(la_current_op[6])
    of_add_db_log("update_event", 0, ls_log_message)
next

return true
end function

on wmm_genka_baika_multi.create
int iCurrent
call super::create
this.gb_tankahyo=create gb_tankahyo
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.uo_daibunrui=create uo_daibunrui
this.uo_tyubunrui=create uo_tyubunrui
this.uo_syobunrui=create uo_syobunrui
this.uo_group=create uo_group
this.uo_tokui=create uo_tokui
this.uo_kojyo=create uo_kojyo
this.uo_brand=create uo_brand
this.uo_bumon=create uo_bumon
this.uo_season=create uo_season
this.sle_tekiyo_start_date_from_t=create sle_tekiyo_start_date_from_t
this.sle_tekiyo_start_date_from=create sle_tekiyo_start_date_from
this.sle_tekiyo_start_date_to_t=create sle_tekiyo_start_date_to_t
this.sle_tekiyo_start_date_to=create sle_tekiyo_start_date_to
this.ddplb_zei_kbn_t=create ddplb_zei_kbn_t
this.sle_zeiritu=create sle_zeiritu
this.rb_input_hoho_t=create rb_input_hoho_t
this.rb_tujyo=create rb_tujyo
this.rb_all=create rb_all
this.cbx_jyoudai_flg=create cbx_jyoudai_flg
this.cbx_haiban_flg=create cbx_haiban_flg
this.cbx_bettyu_flg=create cbx_bettyu_flg
this.st_tekiyo_start_date=create st_tekiyo_start_date
this.st_zeiritu=create st_zeiritu
this.st_percent=create st_percent
this.ddplb_zei_kbn=create ddplb_zei_kbn
this.cbx_tankahyo_9=create cbx_tankahyo_9
this.cbx_tankahyo_1=create cbx_tankahyo_1
this.cbx_tankahyo_2=create cbx_tankahyo_2
this.st_tankahyo_hakkou_kbn=create st_tankahyo_hakkou_kbn
this.cbx_tankahyo_3=create cbx_tankahyo_3
this.st_syohin_cd_to=create st_syohin_cd_to
this.sle_syohin_cd_from=create sle_syohin_cd_from
this.sle_syohin_cd_to=create sle_syohin_cd_to
this.st_syohin_cd_from=create st_syohin_cd_from
this.sle_tekiyo_start_date=create sle_tekiyo_start_date
this.dw_list=create dw_list
this.st_aite_hinban_t=create st_aite_hinban_t
this.st_aite_hinban=create st_aite_hinban
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_tankahyo
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.ddplb_syori_kbn
this.Control[iCurrent+4]=this.uo_daibunrui
this.Control[iCurrent+5]=this.uo_tyubunrui
this.Control[iCurrent+6]=this.uo_syobunrui
this.Control[iCurrent+7]=this.uo_group
this.Control[iCurrent+8]=this.uo_tokui
this.Control[iCurrent+9]=this.uo_kojyo
this.Control[iCurrent+10]=this.uo_brand
this.Control[iCurrent+11]=this.uo_bumon
this.Control[iCurrent+12]=this.uo_season
this.Control[iCurrent+13]=this.sle_tekiyo_start_date_from_t
this.Control[iCurrent+14]=this.sle_tekiyo_start_date_from
this.Control[iCurrent+15]=this.sle_tekiyo_start_date_to_t
this.Control[iCurrent+16]=this.sle_tekiyo_start_date_to
this.Control[iCurrent+17]=this.ddplb_zei_kbn_t
this.Control[iCurrent+18]=this.sle_zeiritu
this.Control[iCurrent+19]=this.rb_input_hoho_t
this.Control[iCurrent+20]=this.rb_tujyo
this.Control[iCurrent+21]=this.rb_all
this.Control[iCurrent+22]=this.cbx_jyoudai_flg
this.Control[iCurrent+23]=this.cbx_haiban_flg
this.Control[iCurrent+24]=this.cbx_bettyu_flg
this.Control[iCurrent+25]=this.st_tekiyo_start_date
this.Control[iCurrent+26]=this.st_zeiritu
this.Control[iCurrent+27]=this.st_percent
this.Control[iCurrent+28]=this.ddplb_zei_kbn
this.Control[iCurrent+29]=this.cbx_tankahyo_9
this.Control[iCurrent+30]=this.cbx_tankahyo_1
this.Control[iCurrent+31]=this.cbx_tankahyo_2
this.Control[iCurrent+32]=this.st_tankahyo_hakkou_kbn
this.Control[iCurrent+33]=this.cbx_tankahyo_3
this.Control[iCurrent+34]=this.st_syohin_cd_to
this.Control[iCurrent+35]=this.sle_syohin_cd_from
this.Control[iCurrent+36]=this.sle_syohin_cd_to
this.Control[iCurrent+37]=this.st_syohin_cd_from
this.Control[iCurrent+38]=this.sle_tekiyo_start_date
this.Control[iCurrent+39]=this.dw_list
this.Control[iCurrent+40]=this.st_aite_hinban_t
this.Control[iCurrent+41]=this.st_aite_hinban
end on

on wmm_genka_baika_multi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_tankahyo)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.uo_daibunrui)
destroy(this.uo_tyubunrui)
destroy(this.uo_syobunrui)
destroy(this.uo_group)
destroy(this.uo_tokui)
destroy(this.uo_kojyo)
destroy(this.uo_brand)
destroy(this.uo_bumon)
destroy(this.uo_season)
destroy(this.sle_tekiyo_start_date_from_t)
destroy(this.sle_tekiyo_start_date_from)
destroy(this.sle_tekiyo_start_date_to_t)
destroy(this.sle_tekiyo_start_date_to)
destroy(this.ddplb_zei_kbn_t)
destroy(this.sle_zeiritu)
destroy(this.rb_input_hoho_t)
destroy(this.rb_tujyo)
destroy(this.rb_all)
destroy(this.cbx_jyoudai_flg)
destroy(this.cbx_haiban_flg)
destroy(this.cbx_bettyu_flg)
destroy(this.st_tekiyo_start_date)
destroy(this.st_zeiritu)
destroy(this.st_percent)
destroy(this.ddplb_zei_kbn)
destroy(this.cbx_tankahyo_9)
destroy(this.cbx_tankahyo_1)
destroy(this.cbx_tankahyo_2)
destroy(this.st_tankahyo_hakkou_kbn)
destroy(this.cbx_tankahyo_3)
destroy(this.st_syohin_cd_to)
destroy(this.sle_syohin_cd_from)
destroy(this.sle_syohin_cd_to)
destroy(this.st_syohin_cd_from)
destroy(this.sle_tekiyo_start_date)
destroy(this.dw_list)
destroy(this.st_aite_hinban_t)
destroy(this.st_aite_hinban)
end on

event resize;call super::resize;
// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y
long l_row_4_y
long l_row_5_y
long l_row_6_y
long l_row_7_y
long l_row_8_y

long l_komoku_height = 89

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」

st_syori_kbn.y				= l_row_1_y
ddplb_syori_kbn.y				= l_row_1_y
uo_tokui.y				= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_daibunrui.y			= l_row_2_y

// 3行目
l_row_3_y	= l_row_2_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
uo_tyubunrui.y		= l_row_3_y

// 4行目
l_row_4_y	= l_row_3_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
uo_syobunrui.y		= l_row_4_y

// 5行目
l_row_5_y	= l_row_4_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
uo_group.y		= l_row_5_y

// 6行目
l_row_6_y	= l_row_5_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_syohin_cd_from.y		= l_row_6_y
sle_syohin_cd_from.y		= l_row_6_y
st_syohin_cd_to.y		= l_row_6_y
sle_syohin_cd_to.y		= l_row_6_y
cbx_jyoudai_flg.y = l_row_6_y
cbx_haiban_flg.y = l_row_6_y
cbx_bettyu_flg.y = l_row_6_y
st_tankahyo_hakkou_kbn.y = l_row_6_y
cbx_tankahyo_9.y = l_row_6_y
cbx_tankahyo_1.y = l_row_6_y
cbx_tankahyo_2.y = l_row_6_y
cbx_tankahyo_3.y = l_row_6_y
gb_tankahyo.y = l_row_6_y

// 7行目
l_row_7_y	= l_row_6_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_tekiyo_start_date.y		= l_row_7_y
sle_tekiyo_start_date.y		= l_row_7_y

// st_second_upper高さ
st_second_upper.height	= l_row_7_y + l_komoku_height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 8行目
l_row_8_y	= st_second_upper.y + st_second_upper.height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
ddplb_zei_kbn_t.y		= l_row_8_y
ddplb_zei_kbn.y		= l_row_8_y
st_zeiritu.y		= l_row_8_y
sle_zeiritu.y		= l_row_8_y
st_percent.y		= l_row_8_y
rb_input_hoho_t.y		= l_row_8_y
rb_tujyo.y		= l_row_8_y
rb_all.y		= l_row_8_y


// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )
//cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height - l_komoku_height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )


// フッター
sle_tekiyo_start_date_from.y			= key_fnc.y - code.MGN_TATE - sle_tekiyo_start_date_from.height
sle_tekiyo_start_date_from_t.y			= sle_tekiyo_start_date_from.y
sle_tekiyo_start_date_to_t.y			= sle_tekiyo_start_date_from.y
sle_tekiyo_start_date_to.y			= sle_tekiyo_start_date_from.y

// dw_list
dw_list.y				= l_row_8_y + l_komoku_height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= sle_tekiyo_start_date_to.y - code.MGN_TATE - dw_list.y


end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format("{1}{2}",this.title,string(today(),"yyyymmdd"))

return 0


end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック

// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

if not uo_kojyo.event sle_input_check( ) then
	return -1
end if

if not uo_brand.event sle_input_check( ) then
	return -1
end if

if not uo_season.event sle_input_check( ) then
	return -1
end if

if not uo_bumon.event sle_input_check( ) then
	return -1
end if

if not uo_daibunrui.event sle_input_check( ) then
	return -1
end if

if not uo_tyubunrui.event sle_input_check( ) then
	return -1
end if

if not uo_syobunrui.event sle_input_check( ) then
	return -1
end if

if not uo_group.event sle_input_check( ) then
	return -1
end if


end event

event update_event;call super::update_event;
// 処理区分別対応
choose case ddplb_syori_kbn.text
	case "変更"
		if not of_db_update( 0 ) then
			return -1
		end if
	case "削除"
		if not of_db_delete( 0 ) then
			return -1
		end if
end choose

msg.of_info(fnc.strg.of_format("{1}しました", ddplb_syori_kbn.text))

commit using cocos;

// 戻り処理
of_dsp_back()

end event

event update_check;call super::update_check;
long	l_row
long l_syohin_code, l_genka
syohin_genka_check l_syohin_genka[]
up_iti_check l_up_iti[]
iro_up_check l_iro_up[]
long l_array_idx, l_check_idx, l_position_idx
string l_message
boolean l_has_same_position

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

if not sle_zeiritu.event input_check() then
	return -1
end if

if not sle_tekiyo_start_date_from.event input_check( ) then
	return -1
end if

if not sle_tekiyo_start_date_to.event input_check( ) then
	return -1
end if

dw_list.setredraw( false )

for l_row = 1 to dw_list.rowcount()
	choose case dw_list.GetItemStatus(l_row, 0, Primary!)
	case NotModified!
		continue
	end choose
	
	if dw_list.object.chk[l_row] = 0 then
		continue
	end if
	dw_list.setrow( l_row )
	
	if dw_list.event itemchanged( l_row, dw_list.object.new_tanka, string( dw_list.object.new_tanka[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	
	if i_syohizei_kbn <> dw_list.object.zei_kbn[l_row] then
		msg.of_error_dwo(dw_list.object.zei_kbn, "明細の税区分が得意先マスタの税区分と異なります。")
		dw_list.setredraw( true )
		return -1
	end if
	// 配列のインデックスを増やす
	l_array_idx++
	// 構造体配列に値を格納
	l_syohin_genka[l_array_idx].syohin_code = dw_list.object.syohin_dsp[l_row]
	l_syohin_genka[l_array_idx].genka = dw_list.object.new_tanka[l_row]
	
	l_up_iti[l_array_idx].syohin_code = dw_list.object.syohin_dsp[l_row]
	l_up_iti[l_array_idx].iro_no = dw_list.object.iro_no[l_row]
	l_up_iti[l_array_idx].up_iti = dw_list.object.up_iti[l_row]
	l_up_iti[l_array_idx].up_1 = dw_list.object.new_up_1[l_row]
	l_up_iti[l_array_idx].up_2 = dw_list.object.new_up_2[l_row]
	l_up_iti[l_array_idx].up_3 = dw_list.object.new_up_3[l_row]
	l_up_iti[l_array_idx].up_4 = dw_list.object.new_up_4[l_row]
	l_up_iti[l_array_idx].up_5 = dw_list.object.new_up_5[l_row]
	
	for l_check_idx = 1 to l_array_idx - 1
		// 商品コードと色番の組み合わせが一致するかチェック
		if l_syohin_genka[l_check_idx].syohin_code = l_syohin_genka[l_array_idx].syohin_code and &
			l_syohin_genka[l_check_idx].genka <> l_syohin_genka[l_array_idx].genka then
			// 重複エラーメッセージ
			msg.of_error_dwo(dw_list.object.new_tanka, "原価の変更・削除は商品単位で行わなければなりません。")
			dw_list.setredraw( true )
			return -1
		end if
		// ここを関数化する。渡す引数はl_up_itiだけでいい？返す引数はどんな形が一番効率よく可読性も上がる？メッセージとdw_list.object.up_○を返してもいいものか？
		if l_up_iti[l_check_idx].syohin_code = l_up_iti[l_array_idx].syohin_code and &
		l_up_iti[l_check_idx].iro_no = l_up_iti[l_array_idx].iro_no then
		
			l_has_same_position = false
			for l_position_idx = 1 to l_array_idx -1
				if l_up_iti[l_position_idx].iro_no = l_up_iti[l_array_idx].iro_no and &
					l_up_iti[l_position_idx].up_iti = l_up_iti[l_array_idx].up_iti then
					l_has_same_position = true
					exit
				end if
			next
			
			// どのカラムが異なるか特定
			if l_up_iti[l_check_idx].up_1 <> l_up_iti[l_array_idx].up_1 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_1, l_message)
				 dw_list.setredraw( true )
				 return -1
			elseif l_up_iti[l_check_idx].up_2 <> l_up_iti[l_array_idx].up_2 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_2, l_message)
				 dw_list.setredraw( true )
				 return -1
			elseif l_up_iti[l_check_idx].up_3 <> l_up_iti[l_array_idx].up_3 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_3, l_message)
				 dw_list.setredraw( true )
				 return -1
			elseif l_up_iti[l_check_idx].up_4 <> l_up_iti[l_array_idx].up_4 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_4, l_message)
				 dw_list.setredraw( true )
				 return -1
			elseif l_up_iti[l_check_idx].up_5 <> l_up_iti[l_array_idx].up_5 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_5, l_message)
				 dw_list.setredraw( true )
				 return -1
			 end if
			 
		end if
    next
	 // チェックがついている行のうち、適用日fromとtoが消費税マスタの適用開始日、終了日の範囲外の場合エラーメッセージNo5を表示する
	 // fromが消費税マスタの適用開始日より前、またはtoが終了日より後の場合はエラー
if dw_list.object.chk[l_row] = 1 then
	// 入力値が消費税マスタの適用期間の範囲外かチェック
    if i_tekiyo_start_date_from < i_zeiritu_str_date or &
       i_tekiyo_start_date_to > i_zeiritu_end_date then
        msg.of_error_dwo(dw_list.object.chk, "適用日の税率が消費税マスターの登録税率と異なります。")
        dw_list.setredraw( true )
        return -1
    end if
end if
	 
next

dw_list.setredraw( true )

end event

event retrieve_event;call super::retrieve_event;
string  l_sql_old, l_sql_new, l_sql_where, l_sql_tail

// 検索条件に入力された内容をインスタンス変数に保持

if sle_syohin_cd_from.text <> "" then
	i_syohin_code_from		= sle_syohin_cd_from.text
else
	i_syohin_code_from		= ""
end if

if sle_syohin_cd_to.text <> "" then
	i_syohin_code_to		= sle_syohin_cd_to.text
else
	i_syohin_code_to		= ""
end if

if sle_tekiyo_start_date.text <> "" then
	i_tekiyo_start_date		= long( i_str.of_replace( sle_tekiyo_start_date.text, "/", "" ) )
else
	i_tekiyo_start_date		= 0
end if

i_tokui_code = uo_tokui.of_get_tokui_code()

i_daibunrui_code		= uo_daibunrui.of_get_daibunrui_code( )
i_tyubunrui_code		= uo_tyubunrui.of_get_tyubunrui_code( )
i_syobunrui_code		= uo_syobunrui.of_get_syobunrui_code( )

i_kojyo_code		= long( uo_kojyo.of_get_kojyo_code() )
i_brand_code			= uo_brand.of_get_brand_code( )
i_season_code			= long( uo_season.of_get_meisyo_code( ) )
i_bumon_code		= long( uo_bumon.of_get_meisyo_code() )
i_group_code			= uo_group.of_get_group_code( )

i_jyoudai_flg			= cbx_jyoudai_flg.checked
i_haiban_flg		= cbx_haiban_flg.checked
i_bettyu_flg			= cbx_bettyu_flg.checked

i_none_flg			= cbx_tankahyo_9.checked
i_haru_natu_flg		= cbx_tankahyo_1.checked
i_aki_fuyu_flg			= cbx_tankahyo_2.checked
i_all_flg			= cbx_tankahyo_3.checked


// 元のSQLを取得
l_sql_old = dw_list.getsqlselect()

// 条件の初期化
l_sql_where = ""

// ## 条件作成 ## //
// 得意先コード
if i_tokui_code <> -1 then
	l_sql_where += "mt.tokui_code = " + string(i_tokui_code)
	l_sql_where += "and ma.tokui_code = " + string(i_tokui_code)
end if

// 大分類
if i_daibunrui_code <> -1 then
	l_sql_where	+= "   and ms.daibunrui_code        = " + string( i_daibunrui_code ) + code.crlf
end if

// 中分類
if i_tyubunrui_code <> -1 then
	l_sql_where	+= "   and ms.tyubunrui_code        = " + string( i_tyubunrui_code ) + code.crlf
end if

// 小分類
if i_syobunrui_code <> -1 then
	l_sql_where	+= "   and ms.syobunrui_code        = " + string( i_syobunrui_code ) + code.crlf
end if

// ブランド
if i_brand_code <> -1 then
	l_sql_where	+= "   and ms.brand_code            = " + string( i_brand_code ) + code.crlf
end if

// シーズン
if i_season_code <> 0 then
	l_sql_where	+= "   and ms.season_code           = " + string( i_season_code ) + code.crlf
end if

// 管理部門
if i_bumon_code <> 0 then
	l_sql_where	+= "   and ms.bumon_code            = " + string( i_bumon_code ) + code.crlf
end if

// グループ
if i_group_code <> -1 then
	l_sql_where	+= "   and ms.group_code            = " + string( i_group_code ) + code.crlf
end if


// 商品コード（from）
if i_syohin_code_from <> "" then
	l_sql_where	+= "   and ms.syohin_code >= '" + string( i_syohin_code_from ) + "'" + code.crlf
end if


// 工場コード
if i_kojyo_code <> 0 then
	l_sql_where	+= "   and ms.siiresaki_code = '" + string( i_kojyo_code ) + "'" + code.crlf
end if

// 商品コード（to）
if i_syohin_code_to <> "" then
	l_sql_where	+= "   and ms.syohin_code <= '" + string( i_syohin_code_to ) + "'" + code.crlf
end if

// 上代有り
if i_jyoudai_flg then
	l_sql_where	+= "   and ms.jyoudai_koukai_flg     = 1 " + code.crlf
end if

// 廃版
if i_haiban_flg then
	l_sql_where	+= "   and ms.haiban_flg     = 1 " + code.crlf
end if

// 別注
if i_bettyu_flg then
	l_sql_where	+= "   and ms.bettyu_flg     = 1 " + code.crlf
end if

// 単価表発行（複数チェックされていたらor検索にする）
ls_tankahyo_condition = ""
lb_has_tankahyo_condition = false
// 出力なし
if i_none_flg then
    ls_tankahyo_condition += "ms.tankahyo_hakkou_kbn = 9"
    lb_has_tankahyo_condition = true
end if

// 春夏
if i_haru_natu_flg then
    if lb_has_tankahyo_condition then
        ls_tankahyo_condition += " or "
    end if
    ls_tankahyo_condition += "ms.tankahyo_hakkou_kbn = 1"
    lb_has_tankahyo_condition = true
end if

// 秋冬
if i_aki_fuyu_flg then
    if lb_has_tankahyo_condition then
        ls_tankahyo_condition += " or "
    end if
    ls_tankahyo_condition += "ms.tankahyo_hakkou_kbn = 2"
    lb_has_tankahyo_condition = true
end if

// 全て
if i_all_flg then
    if lb_has_tankahyo_condition then
        ls_tankahyo_condition += " or "
    end if
    ls_tankahyo_condition += "ms.tankahyo_hakkou_kbn = 3"
    lb_has_tankahyo_condition = true
end if

// 条件が1つ以上ある場合、括弧で囲む
if lb_has_tankahyo_condition then
    ls_tankahyo_condition = "(" + ls_tankahyo_condition + ")"
    
    // 既存の WHERE 句に追加
    if l_sql_where <> "" then
        l_sql_where += " and " + ls_tankahyo_condition + code.crlf
    else
        l_sql_where = ls_tankahyo_condition + code.crlf
    end if
end if

// 適用開始日
if i_tekiyo_start_date <> 0 then
	 l_sql_where	+= "   and mt.tekiyo_date_str = '" + string( i_tekiyo_start_date ) + "'" + code.crlf
end if

// 元のSQLに"where"が存在するか確認
boolean lb_has_where
lb_has_where = Pos(Lower(l_sql_old), " where ") > 0

// 条件の接続詞を設定
if l_sql_where <> "" then
    if lb_has_where then
        l_sql_where = " and " + l_sql_where
    else
        l_sql_where = " where " + l_sql_where
    end if
end if

// 元のSQLに"order by"が存在するか確認
long ll_order_by_pos
ll_order_by_pos = LastPos(Lower(l_sql_old), "order by")

// 新しいSQLを構築
if ll_order_by_pos > 0 then
    // "order by"が存在する場合
    l_sql_new = Mid(l_sql_old, 1, ll_order_by_pos - 1) + l_sql_where + " " + Mid(l_sql_old, ll_order_by_pos)
else
    // "order by"が存在しない場合
    l_sql_new = l_sql_old + l_sql_where
end if

// デバッグ用メッセージボックス
// MessageBox("Debug: 新しいSQL", l_sql_new)

// データウィンドウの設定と検索
dw_list.reset()
dw_list.setsqlselect(l_sql_new)
if dw_list.retrieve() = 0 then
    // 検索結果がない場合、元のSQLに戻す
    dw_list.setsqlselect(l_sql_old)
    msg.of_error("検索されたデータはありません。")
    return -1
end if

// 検索後、元のSQLに戻す
dw_list.setsqlselect(l_sql_old)

choose case i_syori_kbn
	case "登録"
	case "変更","削除"
		if not of_record_lock( true ) then
			dw_list.reset()
			this.setfocus()
			return -1
		end if
	case "照会"
end choose

of_dsp_edit( "callsection", false )

dw_list.setfocus()

//rb_tujyo.enabled = true
//rb_all.enabled = true

end event

event openquery;call super::openquery;
i_str	= create nv_string

end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
end if

end event

type uo_signal from iw_main_window`uo_signal within wmm_genka_baika_multi
end type

type st_date from iw_main_window`st_date within wmm_genka_baika_multi
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_genka_baika_multi
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_genka_baika_multi
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_genka_baika_multi
end type

type st_title from iw_main_window`st_title within wmm_genka_baika_multi
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_genka_baika_multi
end type

type st_upper from iw_main_window`st_upper within wmm_genka_baika_multi
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_genka_baika_multi
integer x = 4
integer y = 139
integer height = 839
boolean f12_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_genka_baika_multi
integer x = 4300
integer y = 871
integer taborder = 140
end type

type gb_tankahyo from ivo_groupbox within wmm_genka_baika_multi
integer x = 3004
integer y = 750
integer width = 1716
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type st_syori_kbn from ivo_statictext within wmm_genka_baika_multi
integer x = 32
integer y = 167
integer width = 392
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_genka_baika_multi
integer x = 444
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
boolean visible_touroku = false
string init_disp = "変更"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.event selectionchanged( i_idx )

//setnull( i_syori_kbn )


end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )
i_syori_kbn	= trim( this.text )
 
// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
	case "変更", "削除", "照会"
	case else
end choose
end event

type uo_daibunrui from cv_input_bunrui within wmm_genka_baika_multi
integer x = 32
integer y = 302
integer width = 2240
integer taborder = 30
boolean bringtotop = true
string title_text = "大分類"
long title_width = 390
long input_width = 128
long bikou_width = 0
end type

on uo_daibunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_tyubunrui from cv_input_bunrui within wmm_genka_baika_multi
integer x = 32
integer y = 412
integer width = 2240
integer taborder = 40
boolean bringtotop = true
string title_text = "中分類"
long title_width = 390
long input_width = 128
long bikou_width = 0
boolean daibunrui = false
boolean tyubunrui = true
end type

on uo_tyubunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_syobunrui from cv_input_bunrui within wmm_genka_baika_multi
integer x = 36
integer y = 519
integer width = 2280
integer taborder = 50
boolean bringtotop = true
boolean f1_key = true
string title_text = "小分類"
long title_width = 390
long input_width = 168
long bikou_width = 0
boolean daibunrui = false
boolean syobunrui = true
end type

on uo_syobunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_group from cv_input_group within wmm_genka_baika_multi
integer x = 36
integer y = 644
integer width = 2240
integer taborder = 100
boolean bringtotop = true
long title_width = 390
long input_width = 128
long bikou_width = 0
end type

on uo_group.destroy
call cv_input_group::destroy
end on

type uo_tokui from cv_input_tokui within wmm_genka_baika_multi
integer x = 700
integer y = 167
integer width = 2464
integer taborder = 20
boolean bringtotop = true
boolean f4_key = false
long bikou_width = 272
boolean syusoku_hyoji = false
boolean syohizei_hyoji = true
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;
string l_aite_hinban
long ll_tokui_code, li_ret, ll_syohizei_kbn, ll_syohizei_code
dec ld_syohizei_ritu, l_syohizei_ritu
str_mtokui lstr_tokui[]
str_mtanto lstr_tanto[]
str_mzeiritu lstr_zei[]

if uo_tokui.sle_input.text = "" then
	msg.of_error_sle(this.sle_input, "得意先コードが未入力です。")
	return false
end if

ll_tokui_code = long(uo_tokui.sle_input.text)

// of_tokui_get関数を呼び出す
li_ret = mst.of_tokui_get(ll_tokui_code,lstr_tokui)

// 結果を確認
if li_ret > 0 then
	i_syohizei_kbn = lstr_tokui[1].syohizei_kbn 
else
end if

li_ret = mst.of_zeiritu_get(1,i_syohizei_kbn,lstr_zei)

// 結果を確認
if li_ret > 0 then
	ld_syohizei_ritu = lstr_zei[1].syohizei_ritu
else
end if

select mz.syohizei_ritu,
		mz.zeiritu_str_date,
		mz.zeiritu_end_date
into :l_syohizei_ritu,
		:i_zeiritu_str_date,
		:i_zeiritu_end_date
from m_zeiritu mz
where mz.torihiki_kbn = 1
and mz.zeiritu_kbn = 1
order by mz.zeiritu_str_date desc
using cocos;

sle_zeiritu.text = string(l_syohizei_ritu)

ddplb_zei_kbn.selectitem( i_syohizei_kbn)

if this.sle_input.text <> '' then
	ll_tokui_code = long(this.sle_input.text)
	select min(ma.aite_hinban)
	into :l_aite_hinban
	from m_aite_hinban ma
	where ma.tokui_code = :ll_tokui_code
	using cocos;
	
	st_aite_hinban.text = l_aite_hinban
end if

return true
end event

type uo_kojyo from cv_input_kojyo within wmm_genka_baika_multi
integer x = 2336
integer y = 302
integer taborder = 60
boolean bringtotop = true
borderstyle borderstyle = styleshadowbox!
end type

on uo_kojyo.destroy
call cv_input_kojyo::destroy
end on

event constructor;call super::constructor;
this.st_title.text = "工場仕入先"

end event

type uo_brand from cv_input_brand within wmm_genka_baika_multi
integer x = 2336
integer y = 412
integer taborder = 70
boolean bringtotop = true
long title_width = 488
long input_width = 128
long bikou_width = 0
end type

on uo_brand.destroy
call cv_input_brand::destroy
end on

type uo_bumon from cv_input_meisyo within wmm_genka_baika_multi
string tag = "部門"
integer x = 3556
integer y = 519
integer width = 1360
integer taborder = 90
boolean bringtotop = true
string title_text = "部門"
long title_width = 328
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 21
end type

on uo_bumon.destroy
call cv_input_meisyo::destroy
end on

type uo_season from cv_input_meisyo within wmm_genka_baika_multi
integer x = 2336
integer y = 519
integer width = 1200
integer taborder = 80
boolean bringtotop = true
string title_text = "シーズン"
long title_width = 488
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 121
end type

on uo_season.destroy
call cv_input_meisyo::destroy
end on

type sle_tekiyo_start_date_from_t from ivo_statictext within wmm_genka_baika_multi
integer x = 32
integer y = 1778
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "適用日"
alignment alignment = right!
end type

type sle_tekiyo_start_date_from from ivo_singlelineedit within wmm_genka_baika_multi
string tag = "発売日(開始日)"
integer x = 444
integer y = 1778
integer width = 404
integer taborder = 170
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "0000/00/00"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= false

this.text				= string(fnc.db.of_get_date())

i_tekiyo_start_date_from		= long(fnc.db.of_get_date())

end event

event input_check;call super::input_check;
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_tekiyo_start_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			msg.of_error_sle( this, "適用日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date
else
	msg.of_error_sle( this, "適用日(開始日)が入力されていません" )
	return false
end if
i_tekiyo_start_date_from = long(i_str.of_replace(this.text, "/", ""))

return true

end event

type sle_tekiyo_start_date_to_t from ivo_statictext within wmm_genka_baika_multi
integer x = 868
integer y = 1778
integer width = 88
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_tekiyo_start_date_to from ivo_singlelineedit within wmm_genka_baika_multi
string tag = "発売日(終了日)"
integer x = 976
integer y = 1778
integer width = 404
integer taborder = 180
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= false

this.text				= "9999/99/99"

i_tekiyo_start_date_to		= 99999999

end event

event input_check;call super::input_check;
string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	/*
	if  this.text = "9999/99/99" or  this.text = "99999999"  or this.text = "9" then
		l_date = "9999/99/99"
	else
		l_date = fnc.db.of_date_format( this.text )
		if isnull( l_date ) then
			msg.of_error_sle( this, "不正な日付です。" )
			return false
		end if
	end if
*/
	l_date = fnc.db.of_date_format( this.text )
	if isnull( l_date ) or ( not isdate( l_date) and l_date <> "9999/99/99") then
		msg.of_error_sle( this, "不正な日付です。" )
		return false	
	end if

	// 日付大小チェック
	l_date_from	= sle_tekiyo_start_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date_from > l_date then
			this.of_msg_error( "適用日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date
else
	msg.of_error_sle( this, "適用日(終了日)が入力されていません" )
	return false
end if
i_tekiyo_start_date_to = long(i_str.of_replace(this.text, "/", "")) 

return true

end event

type ddplb_zei_kbn_t from ivo_statictext within wmm_genka_baika_multi
integer x = 32
integer y = 985
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "原価税区分"
alignment alignment = right!
end type

type sle_zeiritu from ivo_singlelineedit within wmm_genka_baika_multi
integer x = 1152
integer y = 985
integer width = 228
integer taborder = 160
boolean bringtotop = true
integer init_imemode = 1
boolean chk_digits = true
boolean chk_type_num = true
integer i_limit = 4
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled = false

this.text				= ""

end event

event input_check;call super::input_check;string l_zei
long l_row
dec {2}ld_syohizei_ritu

this.text	= trim( this.text )
l_zei		= this.text

// 数値チェック
/*
if not isnumber( l_zei ) then
	msg.of_error( fnc.strg.of_format( "数値しか入力できません。（入力値：{1}）", l_zei ) )
	return false
end if
*/
if len(l_zei) = 0 then
    ld_syohizei_ritu = 0
	 this.text = "0"
else
end if

ld_syohizei_ritu = dec(l_zei)

for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chk[l_row] = 1 then
		dw_list.object.zeiritu[l_row] = ld_syohizei_ritu
		dw_list.object.zeiritu_decimal[l_row] = ld_syohizei_ritu / 100
	end if
next
return true

end event

type rb_input_hoho_t from ivo_statictext within wmm_genka_baika_multi
integer x = 1540
integer y = 985
integer width = 328
boolean bringtotop = true
long backcolor = 553648127
string text = "入力方法"
alignment alignment = right!
end type

type rb_tujyo from ivo_radiobutton within wmm_genka_baika_multi
string tag = "通常"
integer x = 1888
integer y = 985
integer width = 348
long backcolor = 553648127
string text = "通常"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event clicked;call super::clicked;
long ll_row_count, ll_i

// DataWindowの総行数を取得
ll_row_count = dw_list.RowCount()

// 全ての行のhouhou_flgを0に設定
for ll_i = 1 to ll_row_count
    dw_list.object.houhou_flg[ll_i] = 0
next


//dw_list.Modify("houhou_flg.Text='0'")
end event

event constructor;call super::constructor;this.enabled = false
this.checked = true
end event

type rb_all from ivo_radiobutton within wmm_genka_baika_multi
string tag = "全項目"
integer x = 2256
integer y = 985
integer width = 416
long backcolor = 553648127
string text = "全項目"
boolean f9_key = true
boolean f10_key = true
end type

event clicked;call super::clicked;
long ll_row_count, ll_i

// DataWindowの総行数を取得
ll_row_count = dw_list.RowCount()

// 全ての行のhouhou_flgを1に設定
for ll_i = 1 to ll_row_count
    dw_list.object.houhou_flg[ll_i] = 1
next


//dw_list.Modify("houhou_flg.Text='1'")
end event

event constructor;call super::constructor;this.enabled = false
this.checked = false
end event

type cbx_jyoudai_flg from ivo_checkbox within wmm_genka_baika_multi
string tag = "上代有り"
integer x = 1288
integer y = 761
integer width = 460
long backcolor = 12632256
string text = "上代有り"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type cbx_haiban_flg from ivo_checkbox within wmm_genka_baika_multi
string tag = "廃番"
integer x = 1768
integer y = 761
integer width = 284
long backcolor = 12632256
string text = "廃番"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type cbx_bettyu_flg from ivo_checkbox within wmm_genka_baika_multi
string tag = "別注"
integer x = 2072
integer y = 761
integer width = 304
long backcolor = 12632256
string text = "別注"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type st_tekiyo_start_date from ivo_statictext within wmm_genka_baika_multi
integer x = 32
integer y = 871
integer width = 392
boolean bringtotop = true
long backcolor = 12632256
string text = "適用開始日"
alignment alignment = right!
end type

type st_zeiritu from ivo_statictext within wmm_genka_baika_multi
integer x = 924
integer y = 985
integer width = 212
boolean bringtotop = true
long backcolor = 553648127
string text = "税率"
alignment alignment = right!
end type

type st_percent from ivo_statictext within wmm_genka_baika_multi
integer x = 1400
integer y = 985
integer width = 120
boolean bringtotop = true
long backcolor = 553648127
string text = "%"
alignment alignment = right!
end type

type ddplb_zei_kbn from sv_ddplb_meisyo within wmm_genka_baika_multi
string tag = "原価税区分"
integer x = 444
integer y = 985
integer width = 460
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = shiftjis!
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 104
end type

event selectionchanged;call super::selectionchanged;
long l_row, ll_tokui_code, li_ret, li_ret2, ll_syohizei_kbn, ll_syohizei_code
dec ld_syohizei_ritu
string ll_syohizei_code_dsp
str_mzeiritu lstr_zei[]
str_mmeisyo lstr_meisyo[]

ll_syohizei_code = this.of_get_code_num( )
// of_tokui_get関数を呼び出す
li_ret = mst.of_zeiritu_get(1,ll_syohizei_code,lstr_zei)

// 結果を確認
if li_ret > 0 then
	ld_syohizei_ritu = lstr_zei[1].syohizei_ritu
	li_ret2 = mst.of_meisyo_get(104, string(ll_syohizei_code), lstr_meisyo)
	if li_ret2 > 0 then
		ll_syohizei_code_dsp = string(ll_syohizei_code) + ':' + lstr_meisyo[1].meisyo_1
	else
	end if
else
end if

//sle_zeiritu.text = string(ld_syohizei_ritu)

for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chk[l_row] = 1 then
		dw_list.object.zei_kbn[l_row] = ll_syohizei_code
		dw_list.object.zei_kbn_dsp[l_row] = ll_syohizei_code_dsp
//		dw_list.object.zeiritu[l_row] = ld_syohizei_ritu
	end if
next
end event

event constructor;call super::constructor;
this.enabled = false
end event

type cbx_tankahyo_9 from ivo_checkbox within wmm_genka_baika_multi
string tag = "9"
integer x = 3084
integer y = 789
integer width = 392
long backcolor = 553648127
string text = "出力なし"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type cbx_tankahyo_1 from ivo_checkbox within wmm_genka_baika_multi
string tag = "1"
integer x = 3496
integer y = 789
integer width = 392
long backcolor = 553648127
string text = "春夏"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type cbx_tankahyo_2 from ivo_checkbox within wmm_genka_baika_multi
string tag = "2"
integer x = 3908
integer y = 789
integer width = 440
long backcolor = 553648127
string text = "秋冬"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type st_tankahyo_hakkou_kbn from ivo_statictext within wmm_genka_baika_multi
string tag = "159"
integer x = 2592
integer y = 789
integer width = 392
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "単価表発行"
alignment alignment = right!
end type

type cbx_tankahyo_3 from ivo_checkbox within wmm_genka_baika_multi
string tag = "3"
integer x = 4368
integer y = 789
integer width = 392
long backcolor = 553648127
string text = "全て"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked = true
end event

type st_syohin_cd_to from ivo_statictext within wmm_genka_baika_multi
integer x = 780
integer y = 757
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_syohin_cd_from from ivo_singlelineedit within wmm_genka_baika_multi
string tag = "商品CD"
integer x = 444
integer y = 757
integer width = 316
integer taborder = 110
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
boolean chk_digits = true
integer i_limit = 7
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event key_f08;call super::key_f08;str_mdlpara_msyohin	l_syohin

l_syohin = mdl.of_open_modal( "wsm_syohin", l_syohin )

if upperbound(l_syohin.ret) > 0 then
	this.text	= string( l_syohin.ret[1].syohin_code )
end if

return 0

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
//l_code_to		= long( sle_syohin_cd_to.text )

//前後関係チェック
//if l_code_to > 0 then
	//if l_code_from > l_code_to then
		//this.of_msg_error( "商品コードの前後関係が不正です。" )
//		return false
	//end if
//end if

return true

end event

type sle_syohin_cd_to from ivo_singlelineedit within wmm_genka_baika_multi
string tag = "商品CD"
integer x = 952
integer y = 757
integer width = 316
integer taborder = 120
boolean bringtotop = true
integer textsize = -11
string text = "9999999"
integer limit = 7
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean chk_digits = true
integer i_limit = 7
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event key_f08;call super::key_f08;str_mdlpara_msyohin	l_syohin

l_syohin	= mdl.of_open_modal( "wsm_syohin", l_syohin )

if upperbound(l_syohin.ret) > 0 then
	this.text	= string( l_syohin.ret[1].syohin_code )
end if

return 0

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

//l_code_from		= long( sle_syohin_code_from.text )
l_code_to		= long( l_code )

//前後関係チェック
//if l_code_from > 0 then
	//if l_code_from > l_code_to then
		//this.of_msg_error( "商品コードの前後関係が不正です。" )
		//return false
	//end if
//end if

return true

end event

type st_syohin_cd_from from ivo_statictext within wmm_genka_baika_multi
integer x = 32
integer y = 757
integer width = 392
boolean bringtotop = true
long backcolor = 12632256
string text = "商品CD"
alignment alignment = right!
end type

type sle_tekiyo_start_date from ivo_singlelineedit within wmm_genka_baika_multi
string tag = "適用開始日"
integer x = 444
integer y = 871
integer width = 448
integer taborder = 130
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "0000/00/00"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

i_tekiyo_start_date_from		= 0
end event

event input_check;call super::input_check;
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_tekiyo_start_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			this.of_msg_error( "発売日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type dw_list from ivo_datawindow within wmm_genka_baika_multi
integer y = 1099
integer width = 5120
integer height = 626
boolean bringtotop = true
string dataobject = "dmm_genka_baika_multi"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f5_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }


choose case i_syori_kbn
	case "変更", "削除"
		if not of_record_lock( false ) then
			return -1
		end if		
end choose

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
	case "登録","変更","削除"
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "原価売価登録(一覧)_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event key_f08;call super::key_f08;
return 0
end event

event itemchanged;call super::itemchanged;
string	l_input
string	l_colnm
string	l_tableid_tanka	= "m_tanka"
string	l_tableid_aite_hinban	= "m_aite_hinban"
string	l_msg

long li_tokui, li_tokui_syohin, li_tokui_syusoku

l_input	= trim( data )
l_colnm	= dwo.tag
// 入力チェック、入力項目は全て必須、開始日と終了日はチェックしない
choose case dwo.name
		// 単価マスタでチェックする
	case "new_tanka", "new_up_1", "new_up_2", "new_up_3", "new_up_4", "new_up_5"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid_tanka, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case  "new_baika1", "new_baika2", "aite_hinban"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid_aite_hinban, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

return 0

end event

type st_aite_hinban_t from ivo_statictext within wmm_genka_baika_multi
integer x = 3184
integer y = 167
integer width = 272
boolean bringtotop = true
long backcolor = 12632256
string text = "相手品番"
alignment alignment = right!
end type

type st_aite_hinban from sv_st_meisyo within wmm_genka_baika_multi
integer x = 3476
integer y = 167
integer width = 400
boolean bringtotop = true
string text = "aite_hinban"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

