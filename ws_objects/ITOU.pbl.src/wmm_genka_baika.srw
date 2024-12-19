$PBExportHeader$wmm_genka_baika.srw
$PBExportComments$原価売価登録
forward
global type wmm_genka_baika from iw_main_window
end type
type st_syori_kbn from ivo_statictext within wmm_genka_baika
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_genka_baika
end type
type uo_tokui from cv_input_tokui within wmm_genka_baika
end type
type uo_syohin_iro from cv_input_syohin within wmm_genka_baika
end type
type st_aite_hinban_t from ivo_statictext within wmm_genka_baika
end type
type st_aite_hinban from sv_st_meisyo within wmm_genka_baika
end type
type st_bumon_t from ivo_statictext within wmm_genka_baika
end type
type st_bumon from sv_st_meisyo within wmm_genka_baika
end type
type st_siiresaki_t from ivo_statictext within wmm_genka_baika
end type
type st_irisu_t from ivo_statictext within wmm_genka_baika
end type
type st_irisu from sv_st_meisyo within wmm_genka_baika
end type
type st_siiresaki from sv_st_meisyo within wmm_genka_baika
end type
type st_bikou2 from ivo_statictext within wmm_genka_baika
end type
type dw_entry from ivo_datawindow within wmm_genka_baika
end type
type dw_list from ivo_datawindow within wmm_genka_baika
end type
type rb_input_hoho_t from ivo_statictext within wmm_genka_baika
end type
type rb_tujyo from ivo_radiobutton within wmm_genka_baika
end type
type rb_all from ivo_radiobutton within wmm_genka_baika
end type
type st_baika_nyuryoku from ivo_statictext within wmm_genka_baika
end type
type sle_tekiyo_start_date_from_t from ivo_statictext within wmm_genka_baika
end type
type sle_tekiyo_start_date_from from ivo_singlelineedit within wmm_genka_baika
end type
type sle_tekiyo_start_date_to_t from ivo_statictext within wmm_genka_baika
end type
type sle_tekiyo_start_date_to from ivo_singlelineedit within wmm_genka_baika
end type
type st_bikou3 from ivo_statictext within wmm_genka_baika
end type
type st_comment from ivo_statictext within wmm_genka_baika
end type
type cb_zengyo from commandbutton within wmm_genka_baika
end type
type cb_all from commandbutton within wmm_genka_baika
end type
type lstr_m_tanka from structure within wmm_genka_baika
end type
type lstr_m_aite_hinban from structure within wmm_genka_baika
end type
type up_iti_check from structure within wmm_genka_baika
end type
end forward

type lstr_m_tanka from structure
	long		tokui_code
	long		syohin_code
	long		tanka
	long		up_1
	long		up_2
	long		up_3
	long		up_4
	long		up_5
	long		tanka_henkou_date
	long		old_tanka
	long		zei_kbn
	long		zeiritu
	long		zeibetu_tanka
	long		zeibetu_up_1
	long		zeibetu_up_2
	long		zeibetu_up_3
	long		zeibetu_up_4
	long		zeibetu_up_5
	long		new_tanka
	long		new_up_1
	long		new_up_2
	long		new_up_3
	long		new_up_4
	long		new_up_5
	long		new_zei_kbn
	long		new_zeiritu
	long		tekiyo_date_str
	long		tekiyo_date_end
end type

type lstr_m_aite_hinban from structure
	long		tokui_code
	long		sku_code
	long		syohin_code
	long		iro_no
	string		aite_hinban
	long		aite_baika1
	long		aite_baika2
	long		new_baika1
	long		new_baika2
	long		tekiyo_date_str
	long		tekiyo_date_end
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

global type wmm_genka_baika from iw_main_window
string title = "原価売価登録"
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
uo_tokui uo_tokui
uo_syohin_iro uo_syohin_iro
st_aite_hinban_t st_aite_hinban_t
st_aite_hinban st_aite_hinban
st_bumon_t st_bumon_t
st_bumon st_bumon
st_siiresaki_t st_siiresaki_t
st_irisu_t st_irisu_t
st_irisu st_irisu
st_siiresaki st_siiresaki
st_bikou2 st_bikou2
dw_entry dw_entry
dw_list dw_list
rb_input_hoho_t rb_input_hoho_t
rb_tujyo rb_tujyo
rb_all rb_all
st_baika_nyuryoku st_baika_nyuryoku
sle_tekiyo_start_date_from_t sle_tekiyo_start_date_from_t
sle_tekiyo_start_date_from sle_tekiyo_start_date_from
sle_tekiyo_start_date_to_t sle_tekiyo_start_date_to_t
sle_tekiyo_start_date_to sle_tekiyo_start_date_to
st_bikou3 st_bikou3
st_comment st_comment
cb_zengyo cb_zengyo
cb_all cb_all
end type
global wmm_genka_baika wmm_genka_baika

type variables
private:
	// ユーザーオブジェクト
	nv_string	i_str
	
	// 呼出し部の情報を保管
	long	i_tekiyo_start_date_from
	long	i_tekiyo_start_date_to
	long i_syohi_zei
	string i_syori_kbn
	long    i_tokui_code, i_tekiyo_start_date
	long	i_bumon_code
	long	i_syohin_code
	string  i_syohin_code_from
	string  i_syohin_code_to
	long  i_daibunrui_code
	long  i_tyubunrui_code
	long  i_syobunrui_code
	long	i_group_code
	long	i_brand_code
	long	i_season_code
	long	i_kojyo_code
	
	boolean	i_jyoudai_flg
	boolean	i_haiban_flg
	boolean	i_bettyu_flg
	
	boolean	i_none_flg
	boolean	i_haru_natu_flg
	boolean	i_aki_fuyu_flg
	boolean	i_all_flg
	
	string ls_tankahyo_condition
	boolean lb_has_tankahyo_condition
	
	long i_zeiritu_str_date
	long i_zeiritu_end_date
	
	nv_master	mst

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
public function boolean of_db_insert (lstr_m_tanka p_rec, lstr_m_aite_hinban p_rec2, boolean b_sokuji)
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
public function boolean of_set_dw (datawindow dw_entry, datawindow dw_list, string s_cud)
public function boolean of_record_lock (boolean p_lock)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row
boolean toggle_p_enabled

// 検索前は触らせない、検索後に触れる項目はtoggle_p_enabled使う
if p_enabled then
	toggle_p_enabled = false
else
	toggle_p_enabled = true
end if

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled = p_enabled
		uo_tokui.of_set_enabled( p_enabled )
		uo_syohin_iro.of_set_enabled( p_enabled )
		cb_retrieve.enabled		= p_enabled
		rb_tujyo.checked = true
		rb_tujyo.enabled = toggle_p_enabled
		rb_all.checked = false
		rb_all.enabled = toggle_p_enabled
		dw_entry.enabled = toggle_p_enabled
		sle_tekiyo_start_date_from.enabled = toggle_p_enabled
		sle_tekiyo_start_date_to.enabled = toggle_p_enabled
		cb_zengyo.enabled = toggle_p_enabled
		cb_all.enabled = toggle_p_enabled
end choose
end subroutine

public function boolean of_db_insert (lstr_m_tanka p_rec, lstr_m_aite_hinban p_rec2, boolean b_sokuji);
// 変数宣言
decimal{2} l_tanka, l_up1, l_up2, l_up3, l_up4, l_up5
if b_sokuji = true then

if p_rec.zei_kbn = 1 then
	// 税別の場合は税別の価格を計算
	l_tanka = p_rec.tanka - round(p_rec.tanka / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
	l_up1 = p_rec.up_1 - round(p_rec.up_1 / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
	l_up2 = p_rec.up_2 - round(p_rec.up_2 / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
	l_up3 = p_rec.up_3 - round(p_rec.up_3 / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
	l_up4 = p_rec.up_4 - round(p_rec.up_4 / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
	l_up5 = p_rec.up_5 - round(p_rec.up_5 / (1 + p_rec.zeiritu / 100) * (p_rec.zeiritu / 100), 0)
end if

insert into m_tanka(
	tokui_code,
	syohin_code,
	tanka,
	up_1,
	up_2,
	up_3,
	up_4,
	up_5,
	tanka_henkou_date,
	old_tanka,
	zei_kbn,
	zeiritu,
	zeibetu_tanka,
	zeibetu_up_1,
	zeibetu_up_2,
	zeibetu_up_3,
	zeibetu_up_4,
	zeibetu_up_5,
	touroku_user_id,touroku_client_id,touroku_pg_id,
	henkou_user_id,henkou_client_id,henkou_pg_id
) values (
	:p_rec.tokui_code,
	:p_rec.syohin_code,
	:p_rec.tanka,
	:p_rec.up_1,
	:p_rec.up_2,
	:p_rec.up_3,
	:p_rec.up_4,
	:p_rec.up_5,
	:p_rec.tanka_henkou_date,
	:p_rec.old_tanka,
	:p_rec.zei_kbn,
	:p_rec.zeiritu,
	:l_tanka,
	:l_up1,
	:l_up2,
	:l_up3,
	:l_up4,
	:l_up5,
		:user.user_id,:device.name,:i_pg_id,
	:user.user_id,:device.name,:i_pg_id
) using cocos;

else
end if

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db("単価マスタの登録処理でエラーが発生しました。", cocos)
	of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	return false
end if
	//正常な実行ログを吐く
	//of_add_db_log( "of_db_insert", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
return true
end function

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= ddplb_syori_kbn.text

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

// selectionchangedを呼び出す
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

of_dsp_edit( "callsection", true )
dw_entry.event constructor( )
dw_list.event constructor( )
uo_tokui.event constructor( )
st_aite_hinban.event constructor( )
uo_syohin_iro.event constructor( )
st_bumon.event constructor( )
st_siiresaki.event constructor( )
st_irisu.event constructor( )
rb_tujyo.event constructor( )
rb_all.event constructor( )
sle_tekiyo_start_date_from.event constructor( )
sle_tekiyo_start_date_to.event constructor( )
st_bikou3.event constructor( )

of_set_secondfocus( )
end subroutine

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_entry.event constructor( )
dw_list.event constructor( )
rb_tujyo.event constructor( )
rb_all.event constructor( )
sle_tekiyo_start_date_from.event constructor( )
sle_tekiyo_start_date_to.event constructor( )
st_bikou3.event constructor( )
of_set_secondfocus( )

end subroutine

public function boolean of_set_dw (datawindow dw_entry, datawindow dw_list, string s_cud);
long l_i, l_count, l_today

boolean b_sokuji

// 現在日付を取得
l_today = long(string( fnc.db.of_get_date(), "yyyymmdd"))
if i_tekiyo_start_date_from <= l_today then
	b_sokuji = true  // 即時更新
else
	b_sokuji = false  // 予約更新
end if

l_count = dw_list.RowCount()
if s_cud = "登録" then
	dw_entry.setitemstatus( 1, 0, primary!, NewModified! )
	dw_entry.object.tokui_code[1] = i_tokui_code
	dw_entry.object.syohin_code[1] = i_syohin_code
elseif s_cud = "変更" then
elseif s_cud = "削除" then
	dw_entry.DeleteRow(1)
	for l_i = 1 to l_count
		// 0の場合相手品番マスタがあるので削除する
		if dw_list.object.no_aite_hinban_flg[l_i] = 0 then
			dw_list.DeleteRow(l_i)
                l_i = l_i - 1
			 l_count = l_count -1
		end if
	next
	return true
end if

for l_i = 1 to l_count
	// 即時登録
	if b_sokuji = true then
		dw_entry.object.tanka[1] = dw_entry.object.tanka_ent[1]
		dw_entry.object.up_1[1] = dw_list.object.new_up_1[l_i]
		dw_entry.object.up_2[1] = dw_list.object.new_up_2[l_i]
		dw_entry.object.up_3[1] = dw_list.object.new_up_3[l_i]
		dw_entry.object.up_4[1] = dw_list.object.new_up_4[l_i]
		dw_entry.object.up_5[1] = dw_list.object.new_up_5[l_i]
		dw_entry.object.tanka_henkou_date[1] = i_tekiyo_start_date_from
		dw_entry.object.old_tanka[1] = dw_entry.object.tanka_dsp[1]
		dw_entry.object.zei_kbn[1] = dw_entry.object.zei_kbn_ent[1]
		dw_entry.object.zeiritu[1] = dw_entry.object.zei_ritu[1]
		if dw_entry.object.zei_kbn[1] = 1 then
			// 税別の場合は税別の価格を計算
			dw_entry.object.zeibetu_tanka[1] = dw_entry.object.tanka[1] - round(dw_entry.object.tanka[1] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
			dw_entry.object.zeibetu_up_1[1] = dw_list.object.new_up_1[l_i] - round(dw_list.object.new_up_1[l_i] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
			dw_entry.object.zeibetu_up_2[1] = dw_list.object.new_up_2[l_i] - round(dw_list.object.new_up_2[l_i] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
			dw_entry.object.zeibetu_up_3[1] = dw_list.object.new_up_3[l_i] - round(dw_list.object.new_up_3[l_i] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
			dw_entry.object.zeibetu_up_4[1] = dw_list.object.new_up_4[l_i]  - round(dw_list.object.new_up_4[l_i] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
			dw_entry.object.zeibetu_up_5[1] = dw_list.object.new_up_5[l_i] - round(dw_list.object.new_up_5[l_i] / (1 + dw_entry.object.zei_ritu[1] / 100) * (dw_entry.object.zei_ritu[1] / 100), 0)
		end if
		
		// 即時登録の時に予約系のカラムを0にする？
		dw_entry.object.new_tanka[1] = 0
		dw_entry.object.new_up_1[1] = 0
		dw_entry.object.new_up_2[1] = 0
		dw_entry.object.new_up_3[1] = 0
		dw_entry.object.new_up_4[1] = 0
		dw_entry.object.new_up_5[1] = 0
		dw_entry.object.new_zei_kbn[1] = 0
		dw_entry.object.new_zeiritu[1] = 0
		dw_entry.object.tekiyo_date_str[1] = 0
		dw_entry.object.tekiyo_date_end[1] = 0
	else
		dw_entry.object.new_tanka[1] = dw_entry.object.tanka_ent[1]
		dw_entry.object.new_up_1[1] = dw_list.object.new_up_1[l_i]
		dw_entry.object.new_up_2[1] = dw_list.object.new_up_2[l_i]
		dw_entry.object.new_up_3[1] = dw_list.object.new_up_3[l_i]
		dw_entry.object.new_up_4[1] = dw_list.object.new_up_4[l_i]
		dw_entry.object.new_up_5[1] = dw_list.object.new_up_5[l_i]
		dw_entry.object.new_zei_kbn[1] = dw_entry.object.zei_kbn_ent[1]
		dw_entry.object.new_zeiritu[1] = dw_entry.object.zei_ritu[1]
		dw_entry.object.tekiyo_date_str[1] = i_tekiyo_start_date_from
		dw_entry.object.tekiyo_date_end[1] = i_tekiyo_start_date_to
	end if

	// 相手品番マスタへの操作判定。
	if dw_list.object.new_baika1_dsp[l_i] = 0 and dw_list.object.new_baika2_dsp[l_i] = 0 and (isnull(dw_list.object.aite_hinban[l_i]) or trim(dw_list.object.aite_hinban[l_i]) = "") then
		// 0の場合相手品番マスタがあるので削除する
		if dw_list.object.no_aite_hinban_flg[l_i] = 0 then
			dw_list.DeleteRow(l_i)
                l_i = l_i - 1
			 l_count = l_count -1
		// 相手品番マスタがないなら何も操作しなくていい
		else
			dw_list.setitemstatus( l_i, 0, primary!, NotModified! )
			continue;
		end if
	else
		// 0の場合相手品番マスタがあるので更新する
		if dw_list.object.no_aite_hinban_flg[l_i] = 0 then
			dw_list.setitemstatus( l_i, 0, primary!, DataModified! )
		else
			dw_list.setitemstatus( l_i, 0, primary!, NewModified! )
			dw_list.object.tokui_code[l_i] = i_tokui_code
			dw_list.object.syohin_code[l_i] = i_syohin_code
		end if

		if b_sokuji = true then
			dw_list.object.aite_baika1[l_i] = dw_list.object.new_baika1_dsp[l_i]
			dw_list.object.aite_baika2[l_i] = dw_list.object.new_baika2_dsp[l_i]
		else
			dw_list.object.new_baika1[l_i] = dw_list.object.new_baika1_dsp[l_i]
			dw_list.object.new_baika2[l_i] = dw_list.object.new_baika2_dsp[l_i]
			dw_list.object.tekiyo_date_str[l_i] = i_tekiyo_start_date_from
			dw_list.object.tekiyo_date_end[l_i] = i_tekiyo_start_date_to
		end if

	end if
next
return true
end function

public function boolean of_record_lock (boolean p_lock);
long l_i, l_count

l_count = dw_list.RowCount()

// 悲観ロック＆ロック解除関数
if p_lock then
	// ロック
	if lck.of_tanka_lock( i_pg_id, i_tokui_code, i_syohin_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if

	for l_i = 1 to l_count
		if lck.of_aite_hinban_lock( i_pg_id, i_tokui_code, dw_list.object.sku_code[l_i] ) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
	next
else
	// アンロック
	if lck.of_tanka_unlock( i_pg_id, i_tokui_code, i_syohin_code ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
	
	for l_i = 1 to l_count
		if lck.of_aite_hinban_unlock( i_pg_id, i_tokui_code, dw_list.object.sku_code[l_i] ) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
	next
	
end if

uo_signal.of_on_signal( p_lock )

return true
end function

on wmm_genka_baika.create
int iCurrent
call super::create
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.uo_tokui=create uo_tokui
this.uo_syohin_iro=create uo_syohin_iro
this.st_aite_hinban_t=create st_aite_hinban_t
this.st_aite_hinban=create st_aite_hinban
this.st_bumon_t=create st_bumon_t
this.st_bumon=create st_bumon
this.st_siiresaki_t=create st_siiresaki_t
this.st_irisu_t=create st_irisu_t
this.st_irisu=create st_irisu
this.st_siiresaki=create st_siiresaki
this.st_bikou2=create st_bikou2
this.dw_entry=create dw_entry
this.dw_list=create dw_list
this.rb_input_hoho_t=create rb_input_hoho_t
this.rb_tujyo=create rb_tujyo
this.rb_all=create rb_all
this.st_baika_nyuryoku=create st_baika_nyuryoku
this.sle_tekiyo_start_date_from_t=create sle_tekiyo_start_date_from_t
this.sle_tekiyo_start_date_from=create sle_tekiyo_start_date_from
this.sle_tekiyo_start_date_to_t=create sle_tekiyo_start_date_to_t
this.sle_tekiyo_start_date_to=create sle_tekiyo_start_date_to
this.st_bikou3=create st_bikou3
this.st_comment=create st_comment
this.cb_zengyo=create cb_zengyo
this.cb_all=create cb_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syori_kbn
this.Control[iCurrent+2]=this.ddplb_syori_kbn
this.Control[iCurrent+3]=this.uo_tokui
this.Control[iCurrent+4]=this.uo_syohin_iro
this.Control[iCurrent+5]=this.st_aite_hinban_t
this.Control[iCurrent+6]=this.st_aite_hinban
this.Control[iCurrent+7]=this.st_bumon_t
this.Control[iCurrent+8]=this.st_bumon
this.Control[iCurrent+9]=this.st_siiresaki_t
this.Control[iCurrent+10]=this.st_irisu_t
this.Control[iCurrent+11]=this.st_irisu
this.Control[iCurrent+12]=this.st_siiresaki
this.Control[iCurrent+13]=this.st_bikou2
this.Control[iCurrent+14]=this.dw_entry
this.Control[iCurrent+15]=this.dw_list
this.Control[iCurrent+16]=this.rb_input_hoho_t
this.Control[iCurrent+17]=this.rb_tujyo
this.Control[iCurrent+18]=this.rb_all
this.Control[iCurrent+19]=this.st_baika_nyuryoku
this.Control[iCurrent+20]=this.sle_tekiyo_start_date_from_t
this.Control[iCurrent+21]=this.sle_tekiyo_start_date_from
this.Control[iCurrent+22]=this.sle_tekiyo_start_date_to_t
this.Control[iCurrent+23]=this.sle_tekiyo_start_date_to
this.Control[iCurrent+24]=this.st_bikou3
this.Control[iCurrent+25]=this.st_comment
this.Control[iCurrent+26]=this.cb_zengyo
this.Control[iCurrent+27]=this.cb_all
end on

on wmm_genka_baika.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.uo_tokui)
destroy(this.uo_syohin_iro)
destroy(this.st_aite_hinban_t)
destroy(this.st_aite_hinban)
destroy(this.st_bumon_t)
destroy(this.st_bumon)
destroy(this.st_siiresaki_t)
destroy(this.st_irisu_t)
destroy(this.st_irisu)
destroy(this.st_siiresaki)
destroy(this.st_bikou2)
destroy(this.dw_entry)
destroy(this.dw_list)
destroy(this.rb_input_hoho_t)
destroy(this.rb_tujyo)
destroy(this.rb_all)
destroy(this.st_baika_nyuryoku)
destroy(this.sle_tekiyo_start_date_from_t)
destroy(this.sle_tekiyo_start_date_from)
destroy(this.sle_tekiyo_start_date_to_t)
destroy(this.sle_tekiyo_start_date_to)
destroy(this.st_bikou3)
destroy(this.st_comment)
destroy(this.cb_zengyo)
destroy(this.cb_all)
end on

event retrieve_event;call super::retrieve_event;
long li_tokui
dec l_syohizei_ritu
str_mtokui	l_tokui[]
i_syohin_code = long(uo_syohin_iro.sle_input.text)
i_tokui_code = long(uo_tokui.sle_input.text)

// 検索実行
// setredrawの使い方決まり次第変更する
// setredraw( false )
dw_entry.setredraw( false )
dw_list.setredraw( false )
if dw_entry.retrieve(i_syohin_code, i_tokui_code)  = 0 then
	msg.of_error( "検索されたデータはありません。" )
	dw_entry.setredraw( true )
	dw_list.setredraw( true )
	return -1
end if

if dw_list.retrieve(i_syohin_code, i_tokui_code)  = 0 then
	msg.of_error( "検索されたデータはありません。" )
	dw_entry.setredraw( true )
	dw_list.setredraw( true )
	return -1
end if

choose case i_syori_kbn
	case "登録"
		if dw_entry.object.no_tanka_flg[1] = 0 then
			dw_entry.event constructor( )
			dw_list.event constructor( )
			msg.of_error( "検索されたデータは単価マスタがあります。処理区分を登録以外で検索してください。" )	
			dw_entry.setredraw( true )
			dw_list.setredraw( true )
			return -1
		else
			li_tokui = mst.of_tokui_get(i_tokui_code, l_tokui)
			dw_entry.object.zei_kbn_ent[1] = l_tokui[1].syohizei_kbn
			// 消費税率マスターから現時点の税率を取得する
			select mz.syohizei_ritu
			into :l_syohizei_ritu
			from m_zeiritu mz
			where mz.torihiki_kbn = 1
			and mz.zeiritu_kbn = 1
			order by mz.zeiritu_str_date desc
			using cocos;

			dw_entry.object.zei_ritu[1] = l_syohizei_ritu
		end if
	case "変更","削除"
		if not of_record_lock( true ) then
			dw_entry.reset()
			dw_entry.InsertRow(0)

			dw_entry.setredraw( true )
			dw_list.setredraw( true )

			return -1
		end if
		if dw_entry.object.no_tanka_flg[1] = 1 then
			dw_entry.event constructor( )
			dw_list.event constructor( )
			msg.of_error( "検索されたデータは単価マスタがありません。処理区分を" + i_syori_kbn + "以外で検索してください。" )
			dw_entry.setredraw( true )
			dw_list.setredraw( true )
			return -1
		end if
	case "照会"
		if dw_entry.object.no_tanka_flg[1] = 1 then
			dw_entry.event constructor( )
			dw_list.event constructor( )
			msg.of_error( "検索されたデータは単価マスタがありません。処理区分を" + i_syori_kbn + "以外で検索してください。" )
			dw_entry.setredraw( true )
			dw_list.setredraw( true )
			return -1
		end if
end choose
dw_entry.setredraw( true )
dw_list.setredraw( true )

of_dsp_edit( "callsection", false )

dw_entry.setfocus()

end event

event resize;call super::resize;
// 呼出部
long l_row_1_y
long l_row_2_y
long l_row_3_y

long l_komoku_height = 89

// 1行目
l_row_1_y = st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」

st_syori_kbn.y = l_row_1_y
ddplb_syori_kbn.y = l_row_1_y
uo_tokui.y = l_row_1_y
st_aite_hinban_t.y = l_row_1_y
st_aite_hinban.y = l_row_1_y

// 2行目
l_row_2_y = l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_syohin_iro.y = l_row_2_y

// 3行目
l_row_3_y = l_row_2_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 3行目「MGN_UPPER_TATE_GAP:11」
st_bumon_t.y = l_row_3_y
st_bumon.y = l_row_3_y
st_bikou2.y = l_row_3_y
st_siiresaki_t.y = l_row_3_y
st_siiresaki.y = l_row_3_y
st_irisu_t.y = l_row_3_y
st_irisu.y = l_row_3_y

// st_second_upper高さ
st_second_upper.height	= l_row_3_y + l_komoku_height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y = ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )


dw_entry.y = st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x = code.MGN_YOKO
dw_entry.width = newwidth - code.MGN_YOKO * 2
//dw_entry.height = dw_entry.y - code.MGN_TATE - dw_entry.y
dw_entry.height = 654

st_baika_nyuryoku.y = dw_entry.y + dw_entry.height + code.MGN_TATE
rb_input_hoho_t.y = dw_entry.y + dw_entry.height + code.MGN_TATE
rb_tujyo.y = dw_entry.y + dw_entry.height + code.MGN_TATE
rb_all.y = dw_entry.y + dw_entry.height + code.MGN_TATE

// フッター
sle_tekiyo_start_date_from.y = key_fnc.y - code.MGN_TATE - sle_tekiyo_start_date_from.height
sle_tekiyo_start_date_from_t.y = sle_tekiyo_start_date_from.y
sle_tekiyo_start_date_to_t.y = sle_tekiyo_start_date_from.y
sle_tekiyo_start_date_to.y = sle_tekiyo_start_date_from.y
st_bikou3.y = sle_tekiyo_start_date_from.y
st_comment.y = sle_tekiyo_start_date_from.y


cb_zengyo.y = sle_tekiyo_start_date_from.y - code.MGN_TATE - cb_zengyo.height
cb_all.y = cb_zengyo.y

dw_list.y = st_baika_nyuryoku.y + l_komoku_height + code.MGN_TATE
dw_list.x = code.MGN_YOKO
dw_list.width = newwidth - code.MGN_YOKO * 2
dw_list.height = cb_zengyo.y - dw_list.y - code.MGN_TATE
end event

event update_event;call super::update_event;
dw_entry.setredraw( false )
dw_list.setredraw( false )

of_set_dw(dw_entry, dw_list, i_syori_kbn)

if not dw_entry.update( true, false ) = 1 then
	rollback using cocos;
	msg.of_error_db( "単価マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	dw_entry.setredraw( true )
	dw_list.setredraw( true )
	return -1
end if

if not dw_list.update( true, false ) = 1 then
	rollback using cocos;
	msg.of_error_db( "相手品番マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	dw_entry.setredraw( true )
	dw_list.setredraw( true )
	return -1
end if

of_add_db_log( "update_event", 0, st_title.text +  "[" + &
string(i_tokui_code)  + " " + &
trim(string(uo_tokui.st_meisyo.text))+ " " + &
string(i_syohin_code) + " " + &
trim(string(uo_syohin_iro.st_meisyo.text)) + " " + &
trim(string(uo_syohin_iro.st_meisyo_hin_mei.text)) + " "+ &
"]" + i_syori_kbn )

dw_entry.setredraw( true )
dw_list.setredraw( true )

commit using cocos;
msg.of_info(fnc.strg.of_format("{1}しました", ddplb_syori_kbn.text))
// 戻り処理
of_dsp_back()

end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event openquery;call super::openquery;
i_str	= create nv_string
end event

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

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック

// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

if not uo_syohin_iro.event sle_input_check( ) then
	return -1
end if
end event

event update_check;call super::update_check;
long	l_row
long l_syohin_code, l_genka
up_iti_check l_up_iti[]
long l_array_idx, l_check_idx, l_position_idx
string l_message
boolean l_has_same_position

i_tekiyo_start_date_from = long(i_str.of_replace(sle_tekiyo_start_date_from.text, "/", ""))
i_tekiyo_start_date_to = long(i_str.of_replace(sle_tekiyo_start_date_to.text, "/", "")) 

if dw_list.accepttext() <> 1 then
	return -1
end if

if dw_entry.event itemchanged( 1, dw_entry.object.tanka_ent, string( dw_entry.object.tanka_ent[1] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( 1, dw_entry.object.zei_ritu, string( dw_entry.object.zei_ritu[1] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( 1, dw_entry.object.note, string( dw_entry.object.note[1] ) ) <> 0 then
	return -1
end if

if not sle_tekiyo_start_date_from.event input_check( ) then
	return -1
end if

if not sle_tekiyo_start_date_to.event input_check( ) then
	return -1
end if
 
if i_syohi_zei <> dw_entry.object.zei_kbn_ent[1] then
	msg.of_error_dwo(dw_entry.object.zei_kbn_ent, "税区分が得意先マスタの税区分と異なります。")
	return -1
end if
for l_row = 1 to dw_list.rowcount()
    l_array_idx++
    
    l_up_iti[l_array_idx].syohin_code = i_syohin_code
    l_up_iti[l_array_idx].iro_no = dw_list.object.iro_no[l_row]
    l_up_iti[l_array_idx].up_iti = dw_list.object.up_iti[l_row]
    l_up_iti[l_array_idx].up_1 = dw_list.object.new_up_1[l_row]
    l_up_iti[l_array_idx].up_2 = dw_list.object.new_up_2[l_row]
    l_up_iti[l_array_idx].up_3 = dw_list.object.new_up_3[l_row]
    l_up_iti[l_array_idx].up_4 = dw_list.object.new_up_4[l_row]
    l_up_iti[l_array_idx].up_5 = dw_list.object.new_up_5[l_row]
    
    // 同一色番の全レコードをチェック
    for l_check_idx = 1 to l_array_idx - 1
        if l_up_iti[l_check_idx].iro_no = l_up_iti[l_array_idx].iro_no then
            // まず同じアップ位置があるかチェック
            l_has_same_position = false
            for l_position_idx = 1 to l_array_idx - 1
                if l_up_iti[l_position_idx].iro_no = l_up_iti[l_array_idx].iro_no and &
                   l_up_iti[l_position_idx].up_iti = l_up_iti[l_array_idx].up_iti then
                    l_has_same_position = true
                    exit
                end if
            next
			// アップ額の差異をチェック
			if l_up_iti[l_check_idx].up_1 <> l_up_iti[l_array_idx].up_1 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_1, l_message)
				 return -1
			elseif l_up_iti[l_check_idx].up_2 <> l_up_iti[l_array_idx].up_2 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_2, l_message)
				 return -1
			elseif l_up_iti[l_check_idx].up_3 <> l_up_iti[l_array_idx].up_3 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_3, l_message)
				 return -1
			elseif l_up_iti[l_check_idx].up_4 <> l_up_iti[l_array_idx].up_4 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_4, l_message)
				 return -1
			elseif l_up_iti[l_check_idx].up_5 <> l_up_iti[l_array_idx].up_5 then
				 if l_has_same_position then
					  l_message = "同一アップ位置に異なるアップ額が入力されています。"
				 else
					  l_message = "同一色別に異なるアップ額が入力されています。"
				 end if
				 msg.of_error_dwo(dw_list.object.new_up_5, l_message)
				 return -1
			end if
		end if
	next
next

// 入力値が消費税マスタの適用期間の範囲外かチェック
if i_tekiyo_start_date_from < i_zeiritu_str_date then
		msg.of_error_sle( sle_tekiyo_start_date_from, "適用日の税率が消費税マスターの登録税率と異なります。" )
		dw_list.setredraw( true )
		return -1
end if
if i_tekiyo_start_date_to > i_zeiritu_end_date then
	msg.of_error_sle( sle_tekiyo_start_date_to, "適用日の税率が消費税マスターの登録税率と異なります。" )
	dw_list.setredraw( true )
	return -1
end if
 
end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
	dw_list.event constructor( )
end if

end event

type uo_signal from iw_main_window`uo_signal within wmm_genka_baika
end type

type st_date from iw_main_window`st_date within wmm_genka_baika
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_genka_baika
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_genka_baika
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_genka_baika
end type

type st_title from iw_main_window`st_title within wmm_genka_baika
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_genka_baika
end type

type st_upper from iw_main_window`st_upper within wmm_genka_baika
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_genka_baika
integer height = 501
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_genka_baika
integer x = 4180
integer y = 366
integer taborder = 40
end type

type st_syori_kbn from ivo_statictext within wmm_genka_baika
integer x = 32
integer y = 167
integer width = 332
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_genka_baika
integer x = 380
integer y = 167
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
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
 
choose case l_syori
	case "登録"
	case "変更", "削除", "照会"
	case else
end choose
end event

type uo_tokui from cv_input_tokui within wmm_genka_baika
event destroy ( )
string tag = "得意先"
integer x = 636
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
long ll_tokui_code, li_ret, ll_syusoku_flg, ll_tanto_code
string ll_tanto_mei

str_mtokui lstr_tokui[]

if uo_tokui.sle_input.text = "" then
	msg.of_error_sle(this.sle_input, "得意先コードが未入力です。")
	return false
end if

ll_tokui_code = long(uo_tokui.sle_input.text)

// of_tokui_get関数を呼び出す
li_ret = mst.of_tokui_get(ll_tokui_code,lstr_tokui)

// 結果を確認
if li_ret > 0 then
	ll_syusoku_flg = lstr_tokui[1].syusoku_flg
	i_syohi_zei = lstr_tokui[1].syohizei_kbn
else
end if

select mz.zeiritu_str_date,
		mz.zeiritu_end_date
into  :i_zeiritu_str_date,
		:i_zeiritu_end_date
from m_zeiritu mz
where mz.torihiki_kbn = 1
and mz.zeiritu_kbn = 1
order by mz.zeiritu_str_date desc
using cocos;

// 得意先が終息の場合エラーメッセージ(No3)を表示する
if ll_syusoku_flg = 1 then
	msg.of_error_sle(this.sle_input, "得意先が終息のため、この処理は実行できません。")
	this.sle_input.setfocus()
	return false
end if

return true

end event

type uo_syohin_iro from cv_input_syohin within wmm_genka_baika
event destroy ( )
integer x = 32
integer y = 267
integer width = 3980
integer taborder = 30
boolean bringtotop = true
string title_text = "商品"
long title_width = 330
long meisyo_width = 390
long iro_mei_width = 690
boolean input_iro_visible = false
boolean arrow_visible = false
boolean iro_mei_visible = false
boolean syusoku_hyoji = false
boolean yoyaku_hyoji = true
end type

on uo_syohin_iro.destroy
call cv_input_syohin::destroy
end on

event constructor;call super::constructor;//this.of_set_enabled( true )
end event

event sle_input_check;call super::sle_input_check;// 変数宣言
long ll_syohin_code, ll_tokui_code, li_ret, li_ret2, li_ret3, ll_tokutei_tokui_kbn, ll_syusoku_flg, ll_bumon_code, ll_irisu, ll_siiresaki_code
string ls_size_code, l_aite_hinban, l_kojyo_mei, l_bumon_mei
str_msyohin l_syohin[]
str_mmeisyo	l_meisyo[]
str_mkojyo l_kojyo[]

if uo_syohin_iro.sle_input.text = ""then
	msg.of_error_sle(this.sle_input, "商品コードが未入力です。")
	return false
end if

ll_syohin_code = long(uo_syohin_iro.sle_input.text)
// of_syohin_get_full関数を呼び出す
li_ret = mst.of_syohin_get_full(ll_syohin_code,l_syohin)

// 結果を確認
if li_ret > 0 then
	ll_tokutei_tokui_kbn = l_syohin[1].tokutei_tokui_kbn
	ll_syusoku_flg = l_syohin[1].syusoku_flg
	ll_bumon_code = l_syohin[1].bumon_code
	ll_irisu = l_syohin[1].irisu
	ll_siiresaki_code = l_syohin[1].siiresaki_code
else
end if

// 商品が終息の場合エラーメッセージ(No1)を表示する	
if ll_syusoku_flg = 1 then
	msg.of_error_sle(this.sle_input, "終息のため、この処理は実行できません。")
	this.sle_input.setfocus()
	return false
else
end if

li_ret2 = mst.of_kojyo_get(ll_siiresaki_code ,l_kojyo)

if li_ret2 > 0 then
	l_kojyo_mei = l_kojyo[1].kojyo_mei
else
end if

if uo_tokui.sle_input.text <> '' then
	ll_tokui_code = long(uo_tokui.sle_input.text)
	select ma.aite_hinban
	into :l_aite_hinban
	from m_aite_hinban ma
	where ma.tokui_code = :ll_tokui_code
	and ma.syohin_code = :ll_syohin_code
	using cocos;
	
	st_aite_hinban.text = l_aite_hinban
end if

li_ret3 = mst.of_meisyo_get( 21, string(ll_bumon_code ), l_meisyo )
if li_ret3 > 0 then
	l_bumon_mei = l_meisyo[1].meisyo_1
else
end if
st_bumon.text = l_bumon_mei

if ll_bumon_code = 1 then
	st_bikou2.text = '共用'
else 
	st_bikou2.text = ''
end if
st_irisu.text = string(ll_irisu)
st_siiresaki.text = l_kojyo_mei
return true
end event

type st_aite_hinban_t from ivo_statictext within wmm_genka_baika
integer x = 3116
integer y = 167
integer width = 272
boolean bringtotop = true
long backcolor = 12632256
string text = "相手品番"
alignment alignment = right!
end type

type st_aite_hinban from sv_st_meisyo within wmm_genka_baika
integer x = 3404
integer y = 167
integer width = 400
boolean bringtotop = true
string text = "aite_hinban"
end type

event constructor;call super::constructor;
this.text	= ""

end event

type st_bumon_t from ivo_statictext within wmm_genka_baika
integer x = 32
integer y = 366
integer width = 332
boolean bringtotop = true
long backcolor = 12632256
string text = "部門"
alignment alignment = right!
end type

type st_bumon from sv_st_meisyo within wmm_genka_baika
integer x = 380
integer y = 366
integer width = 400
boolean bringtotop = true
string text = "bumon"
end type

event constructor;call super::constructor;
this.text	= ""

end event

type st_siiresaki_t from ivo_statictext within wmm_genka_baika
integer x = 960
integer y = 366
integer width = 272
boolean bringtotop = true
long backcolor = 12632256
string text = "仕入先"
alignment alignment = right!
end type

type st_irisu_t from ivo_statictext within wmm_genka_baika
integer x = 2780
integer y = 366
integer width = 184
boolean bringtotop = true
long backcolor = 12632256
string text = "入数"
alignment alignment = right!
end type

type st_irisu from sv_st_meisyo within wmm_genka_baika
integer x = 2980
integer y = 366
integer width = 228
boolean bringtotop = true
string text = "irisu"
end type

event constructor;call super::constructor;
this.text	= ""

end event

type st_siiresaki from sv_st_meisyo within wmm_genka_baika
integer x = 1248
integer y = 366
integer width = 1516
boolean bringtotop = true
string text = "siiresaki"
end type

event constructor;call super::constructor;
this.text	= ""

end event

type st_bikou2 from ivo_statictext within wmm_genka_baika
integer x = 760
integer y = 366
integer width = 184
boolean bringtotop = true
long textcolor = 255
long backcolor = 12632256
alignment alignment = right!
end type

event constructor;call super::constructor;
this.text	= ""
end event

type dw_entry from ivo_datawindow within wmm_genka_baika
integer x = 4
integer y = 654
integer width = 5100
integer height = 658
boolean bringtotop = true
string dataobject = "dmm_genka_baika_entry"
boolean border = false
boolean livescroll = false
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)

DataWindowChild	ldwc_zei_kbn

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "zei_kbn_ent", ldwc_zei_kbn)
ldwc_zei_kbn.settransobject( cocos )

meisyo_kbn		= 104
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_zei_kbn.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

choose case i_syori_kbn
	case "変更", "削除"
		// ロック解除
		if not of_record_lock( false ) then
			return -1
		end if
end choose

this.insertrow(0)
this.enabled	= false

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf6!, true )
	this.of_set_fnkey( keyf12!, true )
else
	this.of_set_fnkey( keyf6!, false )
	this.of_set_fnkey( keyf12!, false )
end if

end event

event itemchanged;call super::itemchanged;
string l_str_date, l_end_date

string	l_input
string	l_colnm
string	l_tableid	= "m_tanka"
string	l_msg
long li_tokui, li_tokui_syohin, li_tokui_syusoku

nv_master	mst

l_input	= trim( data )
l_colnm	= dwo.tag

// 入力チェック
choose case dwo.name
	case "tanka_ent", "zei_kbn_ent"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, i_str.of_replace(dwo.name,'_ent',''), l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		dw_entry.object.tanka[1] = long(l_input)
		// 2単価税込の場合だけ税率は必須
	case "zei_ritu"
		if long(l_input) = 2 then
			if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, 'zeiritu', l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if	
		end if
		dw_entry.object.zeiritu[1] = dec(l_input)
	case else
end choose

// 個別チェック
choose case dwo.name
	case "tanka_ent"
		if long(data) <= 0 or double(data) <> long(data) then
			msg.of_error_dwo( dwo, '負数、小数、0の値は入力できません。' )
			return 1
		end if
end choose

return 0

end event

event key_f08;call super::key_f08;/*
// F8:参照
choose case this.getcolumnname()
	case "tokui_code"
		// 得意先
		of_reference( this, this.object.tokui_code, this.getrow() )
end choose
*/

return 0
end event

type dw_list from ivo_datawindow within wmm_genka_baika
integer y = 1497
integer width = 5100
integer height = 658
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_genka_baika_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
end type

event constructor;call super::constructor;
long			l_row
string			l_rowid
integer		l_code_visible

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)

choose case i_syori_kbn
	case "変更", "削除"
		if l_row > 0 then
			if not of_record_lock( false ) then
				return -1
			end if
		end if
end choose

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

this.reset()

this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf6!, true )
	this.of_set_fnkey( keyf12!, true )
else
	this.of_set_fnkey( keyf6!, false )
	this.of_set_fnkey( keyf12!, false )
end if

end event

event itemchanged;call super::itemchanged;
string l_str_date, l_end_date

string	l_input
string	l_colnm
string	l_tableid_tanka	= "m_tanka"
string	l_tableid_aite_hinban	= "m_aite_hinban"
string	l_msg

long li_tokui, li_tokui_syohin, li_tokui_syusoku

l_input	= trim( data )
l_colnm	= dwo.tag
// 入力チェック
choose case dwo.name
		// 単価マスタでチェックする
	case "new_up_1", "new_up_2", "new_up_3", "new_up_4", "new_up_5"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid_tanka, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case  "new_baika1_dsp", "new_baika2_dsp", "aite_hinban"
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid_aite_hinban, i_str.of_replace(dwo.name,'_dsp',''), l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別チェック
choose case dwo.name
	case "new_baika1_dsp", "new_baika2_dsp", "new_up_1", "new_up_2", "new_up_3", "new_up_4", "new_up_5"
		if long(data) < 0 or double(data) <> long(data) then
			msg.of_error_dwo( dwo, '負数、小数の値は入力できません。' )
			return 1
		end if
	case else
end choose

return 0

end event

event key_f08;call super::key_f08;
return 0
end event

event doubleclicked;call super::doubleclicked;
cb_all.event clicked()

end event

type rb_input_hoho_t from ivo_statictext within wmm_genka_baika
integer x = 744
integer y = 1362
integer width = 328
boolean bringtotop = true
long backcolor = 553648127
string text = "入力方法"
alignment alignment = right!
end type

type rb_tujyo from ivo_radiobutton within wmm_genka_baika
string tag = "通常"
integer x = 1092
integer y = 1362
integer width = 348
long backcolor = 553648127
string text = "通常"
boolean checked = true
boolean f9_key = true
boolean f10_key = true
end type

event clicked;call super::clicked;
long ll_row_count, ll_i

ll_row_count = dw_list.RowCount()

for ll_i = 1 to ll_row_count
    dw_list.object.houhou_flg[ll_i] = 0
next

end event

event constructor;call super::constructor;
this.enabled = false
this.checked = true
end event

type rb_all from ivo_radiobutton within wmm_genka_baika
string tag = "全項目"
integer x = 1460
integer y = 1362
integer width = 416
long backcolor = 553648127
string text = "全項目"
boolean f9_key = true
boolean f10_key = true
end type

event clicked;call super::clicked;
long ll_row_count, ll_i

ll_row_count = dw_list.RowCount()

for ll_i = 1 to ll_row_count
    dw_list.object.houhou_flg[ll_i] = 1
next

end event

event constructor;call super::constructor;
this.enabled = false
this.checked = false
end event

type st_baika_nyuryoku from ivo_statictext within wmm_genka_baika
integer x = 32
integer y = 1362
integer width = 692
boolean bringtotop = true
long backcolor = 553648127
string text = "●売価入力(サイズ単位)"
alignment alignment = right!
end type

type sle_tekiyo_start_date_from_t from ivo_statictext within wmm_genka_baika
integer x = 32
integer y = 2247
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "適用日"
alignment alignment = right!
end type

type sle_tekiyo_start_date_from from ivo_singlelineedit within wmm_genka_baika
string tag = "発売日(開始日)"
integer x = 444
integer y = 2247
integer width = 404
integer taborder = 80
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled = false
this.text				= string(fnc.db.of_get_date())

i_tekiyo_start_date_from		= long(fnc.db.of_get_date())

end event

event input_check;call super::input_check;
string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then
	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) or not isdate( l_date ) then
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

	if this.text > string(fnc.db.of_get_date()) then 
		st_bikou3.text = '予約登録'
	else
		st_bikou3.text = ''
	end if
else
	msg.of_error_sle( this, "適用日(開始日)が入力されていません" )
	return false
end if

return true

end event

type sle_tekiyo_start_date_to_t from ivo_statictext within wmm_genka_baika
integer x = 868
integer y = 2247
integer width = 88
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_tekiyo_start_date_to from ivo_singlelineedit within wmm_genka_baika
string tag = "発売日(終了日)"
integer x = 976
integer y = 2247
integer width = 404
integer taborder = 90
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled = false
this.text				= "9999/99/99"

i_tekiyo_start_date_to		= 99999999

end event

event input_check;call super::input_check;
string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	/*
	if  this.text = "9999/99/99" or  this.text = "99999999" or this.text = "9" then
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
			msg.of_error_sle( this, "適用日の前後関係が不正です。" )
			return false
		end if
	end if

	// 値セット
	this.text	= l_date
else
	msg.of_error_sle( this, "適用日(終了日)が入力されていません" )
	return false
end if

return true

end event

type st_bikou3 from ivo_statictext within wmm_genka_baika
integer x = 1400
integer y = 2247
integer width = 256
boolean bringtotop = true
long textcolor = 255
long backcolor = 553648127
string text = "予約登録"
alignment alignment = right!
end type

event constructor;call super::constructor;
this.text	= ""
end event

type st_comment from ivo_statictext within wmm_genka_baika
integer x = 1676
integer y = 2247
integer width = 1504
boolean bringtotop = true
long backcolor = 553648127
string text = "※予約登録の場合も、相手品番は即時更新されます。"
alignment alignment = right!
end type

type cb_zengyo from commandbutton within wmm_genka_baika
integer x = 3968
integer y = 2180
integer width = 380
integer height = 89
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI"
string text = "前行複写"
end type

event constructor;
this.enabled = false
end event

event clicked;
long ll_currentrow, ll_previousrow

// カーソルがある行
ll_currentrow = dw_list.GetRow()

ll_previousrow = ll_currentrow - 1

// データが存在するかチェック
if ll_previousrow > 0 then
    // 1行上のデータをコピー
    dw_list.object.new_baika1_dsp[ll_currentrow] = dw_list.object.new_baika1_dsp[ll_previousrow]
    dw_list.object.aite_hinban[ll_currentrow] = dw_list.object.aite_hinban[ll_previousrow]
    dw_list.object.new_baika2_dsp[ll_currentrow] = dw_list.object.new_baika2_dsp[ll_previousrow]
    dw_list.object.new_up_1[ll_currentrow] = dw_list.object.new_up_1[ll_previousrow]
    dw_list.object.new_up_2[ll_currentrow] = dw_list.object.new_up_2[ll_previousrow]
    dw_list.object.new_up_3[ll_currentrow] = dw_list.object.new_up_3[ll_previousrow]
    dw_list.object.new_up_4[ll_currentrow] = dw_list.object.new_up_4[ll_previousrow]
    dw_list.object.new_up_5[ll_currentrow] = dw_list.object.new_up_5[ll_previousrow]
else
//    MessageBox("エラー", "1行目より上のデータはコピーできません。")
end if
end event

type cb_all from commandbutton within wmm_genka_baika
integer x = 4372
integer y = 2183
integer width = 380
integer height = 89
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "Yu Gothic UI"
string text = "一括複写"
end type

event constructor;
this.enabled = false
end event

event clicked;
// カーソルがある行から下方向にデータをコピーする
long ll_currentrow, ll_lastrow, ll_row

ll_currentrow = dw_list.GetRow()
ll_lastrow = dw_list.RowCount()

dw_list.setredraw(false)

// カーソル行の1つ下から最終行まで繰り返し
for  ll_row = ll_currentrow + 1 to dw_list.RowCount()
	// 新売価1,2,新UP1~5は0以外、相手品番はスペースを除去してnullでないデータが1つでもあればループ終了
	if dw_list.object.new_baika1_dsp[ll_row] <> 0 or &
	(not isnull(dw_list.object.aite_hinban[ll_row]) and len(trim(dw_list.object.aite_hinban[ll_row])) > 0) or &
	dw_list.object.new_baika2_dsp[ll_row] <> 0 or &
	dw_list.object.new_up_1[ll_row] <> 0 or &
	dw_list.object.new_up_2[ll_row] <> 0 or &
	dw_list.object.new_up_3[ll_row] <> 0 or &
	dw_list.object.new_up_4[ll_row] <> 0 or &
	dw_list.object.new_up_5[ll_row] <> 0 then
		dw_list.setredraw(true)
		exit
	end if
	// 一つ上の行のデータをコピー
	dw_list.object.new_baika1_dsp[ll_row] = dw_list.object.new_baika1_dsp[ll_currentrow]
	dw_list.object.aite_hinban[ll_row] = dw_list.object.aite_hinban[ll_currentrow]
	dw_list.object.new_baika2_dsp[ll_row] = dw_list.object.new_baika2_dsp[ll_currentrow]
	dw_list.object.new_up_1[ll_row] = dw_list.object.new_up_1[ll_currentrow]
	dw_list.object.new_up_2[ll_row] = dw_list.object.new_up_2[ll_currentrow]
	dw_list.object.new_up_3[ll_row] = dw_list.object.new_up_3[ll_currentrow]
	dw_list.object.new_up_4[ll_row] = dw_list.object.new_up_4[ll_currentrow]
	dw_list.object.new_up_5[ll_row] = dw_list.object.new_up_5[ll_currentrow]
next

// 処理完了後、データウィンドウを更新
dw_list.setredraw(true)
end event

