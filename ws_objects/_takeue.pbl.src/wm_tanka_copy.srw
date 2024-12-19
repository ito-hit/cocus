$PBExportHeader$wm_tanka_copy.srw
$PBExportComments$単価一括複写
forward
global type wm_tanka_copy from iw_main_window
end type
type st_syohin_target from ivo_statictext within wm_tanka_copy
end type
type rb_haiban_2 from ivo_radiobutton within wm_tanka_copy
end type
type rb_haiban_1 from ivo_radiobutton within wm_tanka_copy
end type
type st_haiban_kbn from ivo_statictext within wm_tanka_copy
end type
type rb_uwagaki_no from ivo_radiobutton within wm_tanka_copy
end type
type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_copy
end type
type st_uwagaki from ivo_statictext within wm_tanka_copy
end type
type dw_list from ivo_datawindow within wm_tanka_copy
end type
type uo_tokui from cv_input_tokui_tanto within wm_tanka_copy
end type
type rb_haiban_3 from ivo_radiobutton within wm_tanka_copy
end type
type rb_haiban_9 from ivo_radiobutton within wm_tanka_copy
end type
type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_copy
end type
type st_syohizei_kbn from sv_st_meisyo within wm_tanka_copy
end type
type st_copy_target from ivo_statictext within wm_tanka_copy
end type
type uo_copy_nayose from cv_input_tokui within wm_tanka_copy
end type
type uo_copy_tokui from cv_input_tokui within wm_tanka_copy
end type
type uo_daibunrui from cv_input_bunrui within wm_tanka_copy
end type
type uo_tyubunrui from cv_input_bunrui within wm_tanka_copy
end type
type uo_syobunrui from cv_input_bunrui within wm_tanka_copy
end type
type uo_group from cv_input_group within wm_tanka_copy
end type
type uo_brand from cv_input_brand within wm_tanka_copy
end type
type uo_season from cv_input_meisyo within wm_tanka_copy
end type
type uo_kojyo from cv_input_kojyo within wm_tanka_copy
end type
type uo_bumon from cv_input_meisyo within wm_tanka_copy
end type
type st_touroku_date from ivo_statictext within wm_tanka_copy
end type
type sle_touroku_date_from from ivo_singlelineedit within wm_tanka_copy
end type
type st_touroku_date_namidashu from ivo_statictext within wm_tanka_copy
end type
type sle_touroku_date_to from ivo_singlelineedit within wm_tanka_copy
end type
type st_saisyu_henkou_date from ivo_statictext within wm_tanka_copy
end type
type sle_saisyu_henkou_date_from from ivo_singlelineedit within wm_tanka_copy
end type
type st_saisyu_henkou_date_namidashu from ivo_statictext within wm_tanka_copy
end type
type sle_saisyu_henkou_date_to from ivo_singlelineedit within wm_tanka_copy
end type
type rb_yoyaku_copy_no from ivo_radiobutton within wm_tanka_copy
end type
type rb_yoyaku_copy_yes from ivo_radiobutton within wm_tanka_copy
end type
type st_yoyaku_naiyou from ivo_statictext within wm_tanka_copy
end type
type rb_torihiki_teisi_no from ivo_radiobutton within wm_tanka_copy
end type
type rb_torihiki_teisi_yes from ivo_radiobutton within wm_tanka_copy
end type
type st_torihiki_teisi from ivo_statictext within wm_tanka_copy
end type
type gb_uwagaki from ivo_groupbox within wm_tanka_copy
end type
type gb_haiban_kbn from ivo_groupbox within wm_tanka_copy
end type
type gb_yoyaku from ivo_groupbox within wm_tanka_copy
end type
type gb_1 from ivo_groupbox within wm_tanka_copy
end type
end forward

global type wm_tanka_copy from iw_main_window
string title = "単価一括複写"
boolean f12_key = true
st_syohin_target st_syohin_target
rb_haiban_2 rb_haiban_2
rb_haiban_1 rb_haiban_1
st_haiban_kbn st_haiban_kbn
rb_uwagaki_no rb_uwagaki_no
rb_uwagaki_yes rb_uwagaki_yes
st_uwagaki st_uwagaki
dw_list dw_list
uo_tokui uo_tokui
rb_haiban_3 rb_haiban_3
rb_haiban_9 rb_haiban_9
st_tanka_touroku_flg st_tanka_touroku_flg
st_syohizei_kbn st_syohizei_kbn
st_copy_target st_copy_target
uo_copy_nayose uo_copy_nayose
uo_copy_tokui uo_copy_tokui
uo_daibunrui uo_daibunrui
uo_tyubunrui uo_tyubunrui
uo_syobunrui uo_syobunrui
uo_group uo_group
uo_brand uo_brand
uo_season uo_season
uo_kojyo uo_kojyo
uo_bumon uo_bumon
st_touroku_date st_touroku_date
sle_touroku_date_from sle_touroku_date_from
st_touroku_date_namidashu st_touroku_date_namidashu
sle_touroku_date_to sle_touroku_date_to
st_saisyu_henkou_date st_saisyu_henkou_date
sle_saisyu_henkou_date_from sle_saisyu_henkou_date_from
st_saisyu_henkou_date_namidashu st_saisyu_henkou_date_namidashu
sle_saisyu_henkou_date_to sle_saisyu_henkou_date_to
rb_yoyaku_copy_no rb_yoyaku_copy_no
rb_yoyaku_copy_yes rb_yoyaku_copy_yes
st_yoyaku_naiyou st_yoyaku_naiyou
rb_torihiki_teisi_no rb_torihiki_teisi_no
rb_torihiki_teisi_yes rb_torihiki_teisi_yes
st_torihiki_teisi st_torihiki_teisi
gb_uwagaki gb_uwagaki
gb_haiban_kbn gb_haiban_kbn
gb_yoyaku gb_yoyaku
gb_1 gb_1
end type
global wm_tanka_copy wm_tanka_copy

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

	// 単価マスタ用データストア ※ivo_datawindowでは読み込みエラーが発生するため
	datastore	dw_tanka

end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_update ()
public function integer of_datastore ()
public subroutine of_dsp_reset ()
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);// p_controlによって、ロックやフォーカスを制御する
long	l_row

choose case p_control
	case "callsection"
		// 呼び出し部のロック状態を制御する
		uo_tokui.of_set_enabled( p_enabled )

	case "detailsection"
		// 明細部
		uo_copy_nayose.of_set_enabled( p_enabled )
		uo_copy_tokui.of_set_enabled( p_enabled )
		rb_torihiki_teisi_yes.enabled						= p_enabled
		rb_torihiki_teisi_no.enabled						= p_enabled
		dw_list.enabled							= p_enabled

		uo_daibunrui.of_set_enabled( p_enabled )
		uo_tyubunrui.of_set_enabled( p_enabled )
		uo_syobunrui.of_set_enabled( p_enabled )
		uo_group.of_set_enabled( p_enabled )
		uo_kojyo.of_set_enabled( p_enabled )
		uo_brand.of_set_enabled( p_enabled )
		uo_season.of_set_enabled( p_enabled )
		uo_bumon.of_set_enabled( p_enabled )

		sle_touroku_date_from.enabled			= p_enabled
		sle_touroku_date_to.enabled			= p_enabled
		sle_saisyu_henkou_date_from.enabled	= p_enabled
		sle_saisyu_henkou_date_to.enabled	= p_enabled

		gb_haiban_kbn.enabled					= p_enabled
		rb_haiban_1.enabled						= p_enabled
		rb_haiban_2.enabled						= p_enabled
		rb_haiban_3.enabled						= p_enabled
		rb_haiban_9.enabled						= p_enabled

		gb_yoyaku.enabled							= p_enabled
		rb_yoyaku_copy_yes.enabled				= p_enabled
		rb_yoyaku_copy_no.enabled				= p_enabled

		gb_uwagaki.enabled						= p_enabled
		rb_uwagaki_yes.enabled					= p_enabled
		rb_uwagaki_no.enabled					= p_enabled

end choose

end subroutine

public function boolean of_update ();// 更新登録処理
long		l_loop
long		l_row
long		l_row_count
integer	l_haita_flg
boolean	l_lock
datetime	l_sysdate
long		l_ret
string	l_m_tanka_rowid

string	ls_message, ls_message2, ls_message3

string	l_kousin_user_id, l_kousin_client_id, l_kousin_pg_id
string	l_user_mei,l_window_mei

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

long		l_syohin_code
long		l_tokui_code
long		l_tokui_code2
/*
long		l_kakaku_group_kbn
decimal	l_kakeritu
long		l_upkomi_kbn
decimal	l_tanka
decimal	l_old_tanka
decimal	l_new_tanka
decimal	l_jyoudai
*/


// 上書きする場合のみ更新をする
if rb_uwagaki_yes.checked then
	// フィルタを全件(更新対象と登録対象)とする
	dw_tanka.setfilter("")
	dw_tanka.filter()




long		l_copy_nayose_code
long		l_copy_tokui_code
long		l_torihiki_tetsi_kbn
string	l_kakaku_group_kbn
long		l_daibunrui
long		l_tyubunrui
long		l_syobunrui
long		l_group
long		l_kojyo
long		l_brand
long		l_season
long		l_bumon
long		l_syohin_code2

string	l_touroku_date_from
string	l_touroku_date_to
string	l_saisyu_henkou_date_from
string	l_saisyu_henkou_date_to

long		l_haiban_kbn
string	l_code

// 得意先コード
l_tokui_code = long( trim( uo_tokui.of_get_input() ) )
// 複写先
l_copy_nayose_code = long( trim( uo_copy_nayose.of_get_input() ) )
l_copy_tokui_code = long( trim( uo_copy_tokui.of_get_input() ) )
if rb_torihiki_teisi_no.checked then
	l_torihiki_tetsi_kbn = 0
else
	l_torihiki_tetsi_kbn = 1
end if
// 対象商品
// 価格グループ区分
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
// 区分類
l_daibunrui = long( trim( uo_daibunrui.of_get_input() ) )
l_tyubunrui = long( trim( uo_tyubunrui.of_get_input() ) )
l_syobunrui = long( trim( uo_syobunrui.of_get_input() ) )
l_group = long( trim( uo_group.of_get_input() ) )
l_kojyo = long( trim( uo_kojyo.of_get_input() ) )
l_brand = long( trim( uo_brand.of_get_input() ) )
l_season = long( trim( uo_season.of_get_input() ) )
l_bumon = long( trim( uo_bumon.of_get_input() ) )
// 日付類
l_touroku_date_from = sle_touroku_date_from.text
l_touroku_date_to = sle_touroku_date_to.text
l_saisyu_henkou_date_from = sle_saisyu_henkou_date_from.text
l_saisyu_henkou_date_to = sle_saisyu_henkou_date_to.text

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

declare cur_haita cursor for
select
        nvl(m_tanka.kousin_user_id,'???'),
		nvl(m_tanka.kousin_client_id,'???'),
        nvl(m_tanka.SYOHIN_CODE,0),
		m_tanka.haita_flg
from	m_tanka
,		m_syohin
,		(
		select	tokui_code
		from		m_tokui
		where		(
					:l_copy_nayose_code	> 0
			and	:l_copy_nayose_code	= m_tokui.nayose_code
			and	:l_tokui_code			<> m_tokui.tokui_code
			and	( ( :l_torihiki_tetsi_kbn = 0 and m_tokui.torihiki_teisi_kbn <> '3' ) or :l_torihiki_tetsi_kbn = 1 )
		)	or		(
					:l_copy_tokui_code	> 0
			and	:l_copy_tokui_code	= m_tokui.tokui_code
		)
)			m_tokui
,			(
			select	*
			from		m_tanka
			where		m_tanka.tokui_code	= :l_tokui_code
)			m_tanka_from
where   m_tanka_from.syohin_code = m_syohin.syohin_code
and     m_syohin.syohin_code = m_tanka.syohin_code(+)
and     :l_copy_tokui_code = m_tanka.tokui_code(+)

and		(
		:l_kakaku_group_kbn			is null
	or
		:l_kakaku_group_kbn			like '%' || m_syohin.kakaku_group_kbn || '%'
	)														
and		(:l_daibunrui = 0 or :l_daibunrui = m_syohin.daibunrui_code)
and		(:l_tyubunrui = 0 or :l_tyubunrui = m_syohin.tyubunrui_code)
and		(:l_syobunrui = 0 or :l_syobunrui = m_syohin.syobunrui_code)
and		(:l_group = 0 or :l_group = m_syohin.group_code)
and		(:l_kojyo = 0 or :l_kojyo = m_syohin.siiresaki_code)
and		(:l_brand = 0 or :l_brand = m_syohin.brand_code)
and		(:l_season = 0 or :l_season = m_syohin.season_code)
and		(:l_bumon = 0 or :l_bumon = m_syohin.bumon_code)
and		(:l_touroku_date_from is null or TO_DATE(:l_touroku_date_from,'YYYY/MM/DD') <= m_syohin.touroku_date)
and		(:l_touroku_date_to is null or TO_DATE(:l_touroku_date_to,'YYYY/MM/DD') >= m_syohin.touroku_date)
and		(:l_saisyu_henkou_date_from is null or TO_DATE(:l_saisyu_henkou_date_from,'YYYY/MM/DD') <= m_syohin.henkou_date)
and		(:l_saisyu_henkou_date_to is null or TO_DATE(:l_saisyu_henkou_date_to,'YYYY/MM/DD') >= m_syohin.henkou_date)
and		exists (
			select	m_sub.haiban_kbn
			from		m_syohin m_sub
			where		m_sub.syohin_code			= m_syohin.syohin_code
			and		m_sub.syusoku_flg			= 0
			and		m_sub.tanka_touroku_flg	= 1
			and		m_sub.jyoudai				<> 0
			and		m_sub.haiban_kbn			= :l_haiban_kbn
	)
	and		not exists (
			select	m_sub.haiban_kbn
			from		m_syohin m_sub
			where		m_sub.syohin_code			= m_syohin.syohin_code
			and		m_sub.syusoku_flg			= 0
			and		m_sub.tanka_touroku_flg	= 1
			and		m_sub.jyoudai				<> 0
			and		m_sub.haiban_kbn			< :l_haiban_kbn
	)
		order by m_tanka.haita_flg desc
		for update nowait
		using cocos;
		
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
				  :l_syohin_code2,
              :l_haita_flg;

        do while cocos.sqlcode = 0
            // 排他チェック
            if l_haita_flg <> 0 then
                msg.of_error(fnc.strg.of_format("対象データは他の端末で変更中です。{1}（端末ID:{2} ユーザーID:{3}）",code.crlf,l_kousin_client_id,l_kousin_user_id))
                
                // 排他チェックに失敗
                close cur_haita;
                rollback using cocos;
                return false;
            end if
            
            // 次行取得
            fetch next cur_haita
             into :l_kousin_user_id,
                  :l_kousin_client_id,
						:l_syohin_code2,
                  :l_haita_flg;
        loop
        close cur_haita;
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
		l_syohin_code = dw_tanka.GetItemDecimal(l_loop,"m_syohin_syohin_code")
		dw_tanka.SetItem(l_row,"syohin_code"			,l_syohin_code)

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
		dw_tanka.SetItem(l_row,"kousin_user_id"		,user.user_id)
		dw_tanka.SetItem(l_row,"kousin_pg_id"			,i_pg_id)
	end if

	l_tokui_code = dw_tanka.GetItemDecimal(l_row,"tokui_code")
	l_syohin_code = dw_tanka.GetItemDecimal(l_row,"syohin_code")


	dw_tanka.SetItem(l_row,"old_tanka",dw_tanka.getItemDecimal(l_loop,"tanka"))
	dw_tanka.SetItem(l_row,"tanka"		,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_tanka"))
	dw_tanka.SetItem(l_row,"up_1"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_up_1"))
	dw_tanka.SetItem(l_row,"up_2"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_up_2"))
	dw_tanka.SetItem(l_row,"up_3"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_up_3"))
	dw_tanka.SetItem(l_row,"up_4"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_up_4"))
	dw_tanka.SetItem(l_row,"up_5"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_up_5"))
	dw_tanka.SetItem(l_row,"tanka_henkou_date",fo_num_today())
	dw_tanka.SetItem(l_row,"zei_kbn"		,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_zei_kbn"))
	dw_tanka.SetItem(l_row,"zeiritu"		,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_zeiritu"))

	// 予約内容が「複写する」の場合
	if rb_yoyaku_copy_yes.checked then
		dw_tanka.SetItem(l_row,"new_tanka"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_tanka"))
		dw_tanka.SetItem(l_row,"new_up_1"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_up_1"))
		dw_tanka.SetItem(l_row,"new_up_2"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_up_2"))
		dw_tanka.SetItem(l_row,"new_up_3"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_up_3"))
		dw_tanka.SetItem(l_row,"new_up_4"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_up_4"))
		dw_tanka.SetItem(l_row,"new_up_5"			,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_up_5"))
		dw_tanka.SetItem(l_row,"new_zei_kbn"		,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_zei_kbn"))
		dw_tanka.SetItem(l_row,"new_zeiritu"		,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_new_zeiritu"))
		// 新上代と新掛率は更新をしないので0も入れない
		// dw_tanka.SetItem(l_row,"new_jyodai"			,0)
		// dw_tanka.SetItem(l_row,"new_kakeritu"		,0)
		dw_tanka.SetItem(l_row,"tekiyo_date_str"	,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_tekiyo_date_str"))
		dw_tanka.SetItem(l_row,"tekiyo_date_end"	,dw_tanka.getItemDecimal(l_loop,"m_tanka_from_tekiyo_date_end"))
	end if

next


// 20241209.ito操作ログ処理実装

string torihiki_teisi_msg
// 取引停止先の処理
if rb_torihiki_teisi_yes.checked then
    torihiki_teisi_msg = rb_torihiki_teisi_yes.text
else
	torihiki_teisi_msg = rb_torihiki_teisi_no.text
end if

ls_message = st_title.text + "[複写元得意先=" + &
             string(uo_tokui.sle_input.text) + " " + &
             trim(string(uo_tokui.st_meisyo.text)) + " " + &
				 "複写先名寄せ先=" + &
             string(uo_copy_nayose.sle_input.text) + " " + &
             trim(string(uo_copy_nayose.st_meisyo.text)) + " " + &
				 "取引停止=" + &
             torihiki_teisi_msg + " " + &
				 "複写先得意先=" + &
             string(uo_copy_tokui.sle_input.text) + " " + &
             trim(string(uo_copy_tokui.st_meisyo.text))
ls_message += "]"

of_add_db_log("update_event", 0, ls_message)


// 対象商品
string ls_taisyo_syohin
long l_count, l_i
boolean lb_first = true  // 最初の項目かどうかのフラグ

l_count = dw_list.RowCount()
for l_i = 1 to l_count
    if dw_list.object.chkbox[l_i] = "1" then
        // 2番目以降の項目の場合は&を追加
        if not lb_first then
            ls_taisyo_syohin += "&"
        else
            lb_first = false
        end if
        ls_taisyo_syohin += dw_list.object.kakaku_group_kbn_mei[l_i]
    end if
next

ls_message2 = st_title.text + "[対象商品=" + &
				  ls_taisyo_syohin + " " + &
				  "大分類=" + &
				  string(uo_daibunrui.sle_input.text) + " " + &
              trim(string(uo_daibunrui.st_meisyo.text)) + " " + &
				  "中分類=" + &
				  string(uo_tyubunrui.sle_input.text) + " " + &
              trim(string(uo_tyubunrui.st_meisyo.text)) + " " + &
				  "小分類=" + &
				  string(uo_syobunrui.sle_input.text) + " " + &
              trim(string(uo_syobunrui.st_meisyo.text)) + " " + &
				  "グループ=" + &
				  string(uo_group.sle_input.text) + " " + &
              trim(string(uo_group.st_meisyo.text)) + " " + &
				  "工場仕入先=" + &
				  string(uo_kojyo.sle_input.text) + " " + &
              trim(string(uo_kojyo.st_meisyo.text)) + " " + &
				  "ブランド=" + &
				  string(uo_brand.sle_input.text) + " " + &
              trim(string(uo_brand.st_meisyo.text)) + " " + &
				  "シーズン=" + &
				  string(uo_season.sle_input.text) + " " + &
              trim(string(uo_season.st_meisyo.text)) + " " + &
				  "部門=" + &
				  string(uo_bumon.sle_input.text) + " " + &
              trim(string(uo_bumon.st_meisyo.text)) + "]"

of_add_db_log("update_event", 0, ls_message2)

// 廃番区分
string ls_haiban
if rb_haiban_1.checked then
	ls_haiban = rb_haiban_1.text
elseif rb_haiban_2.checked then
	ls_haiban = rb_haiban_2.text
elseif rb_haiban_3.checked then
	ls_haiban = rb_haiban_3.text
elseif rb_haiban_9.checked then
	ls_haiban = rb_haiban_9.text
end if

// 予約内容
string ls_yoyaku
if rb_yoyaku_copy_yes.checked then
	ls_yoyaku = rb_yoyaku_copy_yes.text
else
	ls_yoyaku = rb_yoyaku_copy_no.text
end if

// 上書き
string ls_uwagaki
if rb_uwagaki_yes.checked then
    ls_uwagaki = rb_uwagaki_yes.text
else
    ls_uwagaki = rb_uwagaki_no.text
end if

ls_message3 = st_title.text + "[" + &
				  "登録日=" + &
				  string(sle_touroku_date_from) + "～" + &
				  string(sle_touroku_date_to) + " " + &
				  "最終変更日=" + &
				  string(sle_saisyu_henkou_date_from) + "～" + &
				  string(sle_saisyu_henkou_date_to) + " " + &
				  "廃番区分=" + ls_haiban + " " + &
				  "予約内容=" + ls_yoyaku + " " + &
				  "上書き=" + ls_uwagaki + &
				  "]" + i_syori_kbn

of_add_db_log("update_event", 0, ls_message3)


l_ret = dw_tanka.update()
if l_ret = 1 then
	commit using cocos;
	// ランプの色を制御する
	uo_signal.of_on_signal( l_lock )
else
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

return true

end function

public function integer of_datastore ();// 単価マスタデータストアの条件を設定し読み込む
long		l_row
long		l_tokui_code
long		l_copy_nayose_code
long		l_copy_tokui_code
long		l_torihiki_tetsi_kbn
string	l_kakaku_group_kbn
long		l_daibunrui
long		l_tyubunrui
long		l_syobunrui
long		l_group
long		l_kojyo
long		l_brand
long		l_season
long		l_bumon

string	l_touroku_date_from
string	l_touroku_date_to
string	l_saisyu_henkou_date_from
string	l_saisyu_henkou_date_to

long		l_haiban_kbn
string	l_code
long		l_count

// 得意先コード
l_tokui_code = long( trim( uo_tokui.of_get_input() ) )
// 複写先
l_copy_nayose_code = long( trim( uo_copy_nayose.of_get_input() ) )
l_copy_tokui_code = long( trim( uo_copy_tokui.of_get_input() ) )
if rb_torihiki_teisi_no.checked then
	l_torihiki_tetsi_kbn = 0
else
	l_torihiki_tetsi_kbn = 1
end if
// 対象商品
// 価格グループ区分
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
// 区分類
l_daibunrui = long( trim( uo_daibunrui.of_get_input() ) )
l_tyubunrui = long( trim( uo_tyubunrui.of_get_input() ) )
l_syobunrui = long( trim( uo_syobunrui.of_get_input() ) )
l_group = long( trim( uo_group.of_get_input() ) )
l_kojyo = long( trim( uo_kojyo.of_get_input() ) )
l_brand = long( trim( uo_brand.of_get_input() ) )
l_season = long( trim( uo_season.of_get_input() ) )
l_bumon = long( trim( uo_bumon.of_get_input() ) )
// 日付類
l_touroku_date_from = sle_touroku_date_from.text
l_touroku_date_to = sle_touroku_date_to.text
l_saisyu_henkou_date_from = sle_saisyu_henkou_date_from.text
l_saisyu_henkou_date_to = sle_saisyu_henkou_date_to.text

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
l_count = dw_tanka.retrieve(			&
		l_tokui_code						&
	,	l_copy_nayose_code				&
	,	l_copy_tokui_code					&
	,	l_torihiki_tetsi_kbn				&
	,	l_kakaku_group_kbn				&
	,	l_daibunrui							&
	,	l_tyubunrui							&
	,	l_syobunrui							&
	,	l_group								&
	,	l_kojyo								&
	,	l_brand								&
	,	l_season								&
	,	l_bumon								&
	,	l_touroku_date_from				&
	,	l_touroku_date_to					&
	,	l_saisyu_henkou_date_from		&
	,	l_saisyu_henkou_date_to			&
	,	l_haiban_kbn						&
)

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

public subroutine of_dsp_reset ();// F9：初期表示

i_syori_kbn = "初期"

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
//setredraw( false )

// ヘッダ部
of_dsp_edit( "callsection", true )

uo_tokui.event constructor( )
st_syohizei_kbn.event constructor()
st_tanka_touroku_flg.event constructor()
st_syohizei_kbn.visible = false
st_tanka_touroku_flg.visible = false

// 明細部
of_dsp_edit( "detailsection", false )

uo_copy_nayose.event constructor( )
uo_copy_tokui.event constructor( )

dw_list.reset()

uo_daibunrui.event constructor( )
uo_tyubunrui.event constructor( )
uo_syobunrui.event constructor( )
uo_group.event constructor( )
uo_kojyo.event constructor( )
uo_brand.event constructor( )
uo_season.event constructor( )
uo_bumon.event constructor( )

sle_touroku_date_from.event constructor( )
sle_touroku_date_to.event constructor( )
sle_saisyu_henkou_date_from.event constructor( )
sle_saisyu_henkou_date_to.event constructor( )

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_yoyaku_copy_yes.checked = true
rb_yoyaku_copy_no.checked = false

rb_uwagaki_yes.checked = true
rb_uwagaki_no.checked = false

//setredraw( true )

of_set_firstfocus( )

end subroutine

public subroutine of_dsp_back ();// F6：戻りの処理

setredraw( false )

// 明細部
of_dsp_edit( "detailsection", false )

uo_copy_nayose.event constructor( )
uo_copy_tokui.event constructor( )

dw_list.reset()

uo_daibunrui.event constructor( )
uo_tyubunrui.event constructor( )
uo_syobunrui.event constructor( )
uo_group.event constructor( )
uo_kojyo.event constructor( )
uo_brand.event constructor( )
uo_season.event constructor( )
uo_bumon.event constructor( )

sle_touroku_date_from.event constructor( )
sle_touroku_date_to.event constructor( )
sle_saisyu_henkou_date_from.event constructor( )
sle_saisyu_henkou_date_to.event constructor( )

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_yoyaku_copy_yes.checked = true
rb_yoyaku_copy_no.checked = false

rb_uwagaki_yes.checked = true
rb_uwagaki_no.checked = false

// 呼び出し部
of_dsp_edit( "callsection", true )

setredraw( true )

of_set_firstfocus( )

end subroutine

on wm_tanka_copy.create
int iCurrent
call super::create
this.st_syohin_target=create st_syohin_target
this.rb_haiban_2=create rb_haiban_2
this.rb_haiban_1=create rb_haiban_1
this.st_haiban_kbn=create st_haiban_kbn
this.rb_uwagaki_no=create rb_uwagaki_no
this.rb_uwagaki_yes=create rb_uwagaki_yes
this.st_uwagaki=create st_uwagaki
this.dw_list=create dw_list
this.uo_tokui=create uo_tokui
this.rb_haiban_3=create rb_haiban_3
this.rb_haiban_9=create rb_haiban_9
this.st_tanka_touroku_flg=create st_tanka_touroku_flg
this.st_syohizei_kbn=create st_syohizei_kbn
this.st_copy_target=create st_copy_target
this.uo_copy_nayose=create uo_copy_nayose
this.uo_copy_tokui=create uo_copy_tokui
this.uo_daibunrui=create uo_daibunrui
this.uo_tyubunrui=create uo_tyubunrui
this.uo_syobunrui=create uo_syobunrui
this.uo_group=create uo_group
this.uo_brand=create uo_brand
this.uo_season=create uo_season
this.uo_kojyo=create uo_kojyo
this.uo_bumon=create uo_bumon
this.st_touroku_date=create st_touroku_date
this.sle_touroku_date_from=create sle_touroku_date_from
this.st_touroku_date_namidashu=create st_touroku_date_namidashu
this.sle_touroku_date_to=create sle_touroku_date_to
this.st_saisyu_henkou_date=create st_saisyu_henkou_date
this.sle_saisyu_henkou_date_from=create sle_saisyu_henkou_date_from
this.st_saisyu_henkou_date_namidashu=create st_saisyu_henkou_date_namidashu
this.sle_saisyu_henkou_date_to=create sle_saisyu_henkou_date_to
this.rb_yoyaku_copy_no=create rb_yoyaku_copy_no
this.rb_yoyaku_copy_yes=create rb_yoyaku_copy_yes
this.st_yoyaku_naiyou=create st_yoyaku_naiyou
this.rb_torihiki_teisi_no=create rb_torihiki_teisi_no
this.rb_torihiki_teisi_yes=create rb_torihiki_teisi_yes
this.st_torihiki_teisi=create st_torihiki_teisi
this.gb_uwagaki=create gb_uwagaki
this.gb_haiban_kbn=create gb_haiban_kbn
this.gb_yoyaku=create gb_yoyaku
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_syohin_target
this.Control[iCurrent+2]=this.rb_haiban_2
this.Control[iCurrent+3]=this.rb_haiban_1
this.Control[iCurrent+4]=this.st_haiban_kbn
this.Control[iCurrent+5]=this.rb_uwagaki_no
this.Control[iCurrent+6]=this.rb_uwagaki_yes
this.Control[iCurrent+7]=this.st_uwagaki
this.Control[iCurrent+8]=this.dw_list
this.Control[iCurrent+9]=this.uo_tokui
this.Control[iCurrent+10]=this.rb_haiban_3
this.Control[iCurrent+11]=this.rb_haiban_9
this.Control[iCurrent+12]=this.st_tanka_touroku_flg
this.Control[iCurrent+13]=this.st_syohizei_kbn
this.Control[iCurrent+14]=this.st_copy_target
this.Control[iCurrent+15]=this.uo_copy_nayose
this.Control[iCurrent+16]=this.uo_copy_tokui
this.Control[iCurrent+17]=this.uo_daibunrui
this.Control[iCurrent+18]=this.uo_tyubunrui
this.Control[iCurrent+19]=this.uo_syobunrui
this.Control[iCurrent+20]=this.uo_group
this.Control[iCurrent+21]=this.uo_brand
this.Control[iCurrent+22]=this.uo_season
this.Control[iCurrent+23]=this.uo_kojyo
this.Control[iCurrent+24]=this.uo_bumon
this.Control[iCurrent+25]=this.st_touroku_date
this.Control[iCurrent+26]=this.sle_touroku_date_from
this.Control[iCurrent+27]=this.st_touroku_date_namidashu
this.Control[iCurrent+28]=this.sle_touroku_date_to
this.Control[iCurrent+29]=this.st_saisyu_henkou_date
this.Control[iCurrent+30]=this.sle_saisyu_henkou_date_from
this.Control[iCurrent+31]=this.st_saisyu_henkou_date_namidashu
this.Control[iCurrent+32]=this.sle_saisyu_henkou_date_to
this.Control[iCurrent+33]=this.rb_yoyaku_copy_no
this.Control[iCurrent+34]=this.rb_yoyaku_copy_yes
this.Control[iCurrent+35]=this.st_yoyaku_naiyou
this.Control[iCurrent+36]=this.rb_torihiki_teisi_no
this.Control[iCurrent+37]=this.rb_torihiki_teisi_yes
this.Control[iCurrent+38]=this.st_torihiki_teisi
this.Control[iCurrent+39]=this.gb_uwagaki
this.Control[iCurrent+40]=this.gb_haiban_kbn
this.Control[iCurrent+41]=this.gb_yoyaku
this.Control[iCurrent+42]=this.gb_1
end on

on wm_tanka_copy.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_syohin_target)
destroy(this.rb_haiban_2)
destroy(this.rb_haiban_1)
destroy(this.st_haiban_kbn)
destroy(this.rb_uwagaki_no)
destroy(this.rb_uwagaki_yes)
destroy(this.st_uwagaki)
destroy(this.dw_list)
destroy(this.uo_tokui)
destroy(this.rb_haiban_3)
destroy(this.rb_haiban_9)
destroy(this.st_tanka_touroku_flg)
destroy(this.st_syohizei_kbn)
destroy(this.st_copy_target)
destroy(this.uo_copy_nayose)
destroy(this.uo_copy_tokui)
destroy(this.uo_daibunrui)
destroy(this.uo_tyubunrui)
destroy(this.uo_syobunrui)
destroy(this.uo_group)
destroy(this.uo_brand)
destroy(this.uo_season)
destroy(this.uo_kojyo)
destroy(this.uo_bumon)
destroy(this.st_touroku_date)
destroy(this.sle_touroku_date_from)
destroy(this.st_touroku_date_namidashu)
destroy(this.sle_touroku_date_to)
destroy(this.st_saisyu_henkou_date)
destroy(this.sle_saisyu_henkou_date_from)
destroy(this.st_saisyu_henkou_date_namidashu)
destroy(this.sle_saisyu_henkou_date_to)
destroy(this.rb_yoyaku_copy_no)
destroy(this.rb_yoyaku_copy_yes)
destroy(this.st_yoyaku_naiyou)
destroy(this.rb_torihiki_teisi_no)
destroy(this.rb_torihiki_teisi_yes)
destroy(this.st_torihiki_teisi)
destroy(this.gb_uwagaki)
destroy(this.gb_haiban_kbn)
destroy(this.gb_yoyaku)
destroy(this.gb_1)
end on

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )

end event

event open;call super::open;
// 初期表示
of_dsp_reset()
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
	uo_tokui.of_setfocus()
	return -1
end if

// エラーメッセージ(No3)
if st_syohizei_kbn.text = "2" then
	msg.of_error( "単価税込の得意先は指定できません。" )
	uo_tokui.of_setfocus()
	return -1
end if

// エラーメッセージ(No4)
if st_tanka_touroku_flg.text = "0" then
	msg.of_error( "この得意先は、単価一括登録「しない」に設定されています。" )
	uo_tokui.of_setfocus()
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

dw_list.reset()
//dw_list.modify( "chkbox.Protect='1~tif( kakeritu = 0 , 1 , 0 )'")	// 掛率0は選択不可
dw_list.retrieve(l_tokui_code)
long ll_row
for ll_row = 1 to dw_list.rowcount()
    dw_list.SetItem(ll_row, "chkbox", "1")
next
dw_list.setfocus()

uo_daibunrui.event constructor( )
uo_tyubunrui.event constructor( )
uo_syobunrui.event constructor( )
uo_group.event constructor( )
uo_kojyo.event constructor( )
uo_brand.event constructor( )
uo_season.event constructor( )
uo_bumon.event constructor( )

sle_touroku_date_from.event constructor( )
sle_touroku_date_to.event constructor( )
sle_saisyu_henkou_date_from.event constructor( )
sle_saisyu_henkou_date_to.event constructor( )

rb_haiban_1.checked = true
rb_haiban_2.checked = false
rb_haiban_3.checked = false
rb_haiban_9.checked = false

rb_yoyaku_copy_yes.checked = true
rb_yoyaku_copy_no.checked = false

rb_uwagaki_yes.checked = true
rb_uwagaki_no.checked = false

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

event update_check;call super::update_check;long	l_count
long	l_row


// 入力チェック
if not uo_copy_nayose.event sle_input_check( ) then
	return -1
end if
if not uo_copy_tokui.event sle_input_check( ) then
	return -1
end if

if uo_copy_nayose.of_get_input() = "" and uo_copy_tokui.of_get_input() = "" then
	msg.of_error( "名寄せ先と得意先は、いずれか一方の指定が必須です。" )
	uo_copy_nayose.of_setfocus()
	return -1
end if
if uo_copy_nayose.of_get_tokui_code() = 0 and uo_copy_nayose.of_get_tokui_code() = 0 then
	msg.of_error( "名寄せ先と得意先は、いずれか一方のみ指定可能です。" )
	uo_copy_nayose.of_setfocus()
	return -1
end if

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

if not sle_touroku_date_from.event input_check( ) then
	return -1
end if
if not sle_touroku_date_to.event input_check( ) then
	return -1
end if
if not sle_saisyu_henkou_date_from.event input_check( ) then
	return -1
end if
if not sle_saisyu_henkou_date_to.event input_check( ) then
	return -1
end if

return 0

end event

event update_event;call super::update_event;long	l_ret
long	l_count

l_ret = 0
i_syori_kbn = "更新"

dw_tanka = create datastore
dw_tanka.dataobject 	= "dm_tanka_copy_tanka"
dw_tanka.settransobject(cocos)  

// 対象レコードを検索
if l_ret = 0 then
	l_count = of_datastore()
	if l_count <= 0 then
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
if l_ret = 0 then
	this.of_dsp_back()
end if

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

type uo_signal from iw_main_window`uo_signal within wm_tanka_copy
end type

type st_date from iw_main_window`st_date within wm_tanka_copy
end type

type st_user_mei from iw_main_window`st_user_mei within wm_tanka_copy
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_tanka_copy
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_tanka_copy
end type

type st_title from iw_main_window`st_title within wm_tanka_copy
end type

type st_title_upper from iw_main_window`st_title_upper within wm_tanka_copy
end type

type st_upper from iw_main_window`st_upper within wm_tanka_copy
end type

type st_second_upper from iw_main_window`st_second_upper within wm_tanka_copy
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_tanka_copy
integer taborder = 170
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

type st_syohin_target from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 836
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "●対象商品"
end type

type rb_haiban_2 from ivo_radiobutton within wm_tanka_copy
string tag = "2"
integer x = 1032
integer y = 1973
integer width = 460
long backcolor = 553648127
string text = "F／Oまで"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_haiban_1 from ivo_radiobutton within wm_tanka_copy
string tag = "1"
integer x = 464
integer y = 1973
integer width = 548
long backcolor = 553648127
string text = "現行品のみ"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_haiban_kbn from ivo_statictext within wm_tanka_copy
string tag = "122"
integer x = 32
integer y = 1973
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "廃番区分"
alignment alignment = right!
end type

type rb_uwagaki_no from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 768
integer y = 2290
integer width = 372
long backcolor = 553648127
string text = "しない"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_uwagaki_yes from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 464
integer y = 2290
integer width = 284
long backcolor = 553648127
string text = "する"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_uwagaki from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 2290
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "上書き"
alignment alignment = right!
end type

type dw_list from ivo_datawindow within wm_tanka_copy
string tag = "対象商品"
integer x = 336
integer y = 910
integer width = 668
integer height = 700
integer taborder = 40
boolean bringtotop = true
string dataobject = "dm_tanka_copy_kakeritu"
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

type uo_tokui from cv_input_tokui_tanto within wm_tanka_copy
event destroy ( )
integer x = 76
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean f4_key = false
boolean chk_required = true
string title_text = "複写元"
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
			this.of_setfocus()
			return false
	end choose

end if

return true

end event

event constructor;call super::constructor;this.of_set_enabled( true )
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type rb_haiban_3 from ivo_radiobutton within wm_tanka_copy
string tag = "3"
integer x = 1512
integer y = 1973
integer width = 548
long backcolor = 553648127
string text = "準廃番まで"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_haiban_9 from ivo_radiobutton within wm_tanka_copy
string tag = "9"
integer x = 2080
integer y = 1973
integer width = 460
long backcolor = 553648127
string text = "廃番まで"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_tanka_touroku_flg from sv_st_meisyo within wm_tanka_copy
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

type st_syohizei_kbn from sv_st_meisyo within wm_tanka_copy
integer x = 2696
integer y = 263
integer width = 500
boolean bringtotop = true
string text = "消費税区分"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type st_copy_target from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 459
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "●複写先"
end type

type uo_copy_nayose from cv_input_tokui within wm_tanka_copy
integer x = 32
integer y = 551
integer taborder = 20
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
string title_text = "名寄せ先"
long title_width = 330
end type

on uo_copy_nayose.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code
long		l_syohizei_kbn
long		l_count
long		l_torihiki_teisi_kbn

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	return true
else
	l_tokui_code		= i_para_tokui[1].tokui_code

	// エラーメッセージ(No2)
	if uo_copy_tokui.of_get_tokui_code() <> 0 then
		msg.of_error( "名寄せ先と得意先は、いずれか一方のみ指定可能です。" )
		this.of_setfocus()
		return false
	end if
	// エラーメッセージ(No3)
	if l_tokui_code = uo_tokui.of_get_tokui_code() then
		msg.of_error( "複写元と同じ得意先は指定できません。" )
		this.of_setfocus()
		return false
	end if
	// エラーメッセージ(No4)
	if this.of_get_syusoku_flg() = 1 then
		msg.of_error( "終息の得意先は指定できません。" )
		this.of_setfocus()
		return false
	end if

	// 消費税区分（1＝単価税別2＝単価税込）※名称区分＝104
	l_syohizei_kbn = long(st_syohizei_kbn.text)
	
	if rb_torihiki_teisi_no.checked then
		l_torihiki_teisi_kbn = 1
	else 
		l_torihiki_teisi_kbn = 0
	end if
	
	// 画面.取引停止先＝含めないの場合得意先M.取引停止区分<>3
	select	count(*)
	into		:l_count
	from		m_tokui
	where		m_tokui.nayose_code			= :l_tokui_code
	and		m_tokui.syohizei_kbn			<> :l_syohizei_kbn
	and     (:l_torihiki_teisi_kbn = 0 or m_tokui.torihiki_teisi_kbn <> '3')
	using		cocos;
	
	choose case cocos.sqlcode
		case 0
			// 消費税区分 不一致件数あり
			// エラーメッセージ(No5)
			if l_count > 0 then
				msg.of_error( "複写元と複写先の消費税区分が異なります。" )
				this.of_setfocus()
				return false
			end if

		case 100
			// 消費税区分 不一致件数無し

		case else
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			this.of_setfocus()
			return false
	end choose

end if

return true

end event

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type uo_copy_tokui from cv_input_tokui within wm_tanka_copy
integer x = 32
integer y = 661
integer taborder = 30
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
long title_width = 330
end type

on uo_copy_tokui.destroy
call cv_input_tokui::destroy
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
	return true
else
	l_tokui_code		= i_para_tokui[1].tokui_code

	// エラーメッセージ(No2)
	if uo_copy_nayose.of_get_tokui_code() <> 0 then
		msg.of_error( "名寄せ先と得意先は、いずれか一方のみ指定可能です。" )
		this.of_setfocus()
		return false
	end if
	// エラーメッセージ(No3)
	if l_tokui_code = uo_tokui.of_get_tokui_code() then
		msg.of_error( "複写元と同じ得意先は指定できません。" )
		this.of_setfocus()
		return false
	end if
	// エラーメッセージ(No4)
	if this.of_get_syusoku_flg() = 1 then
		msg.of_error( "終息の得意先は指定できません。" )
		this.of_setfocus()
		return false
	end if

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
			// エラーメッセージ(No5)
			if st_syohizei_kbn.text <> String(l_syohizei_kbn) then
				msg.of_error( "複写元と複写先の消費税区分が異なります。" )
				this.of_setfocus()
				return false
			end if

		case 100
			// データが無い場合

		case else
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			this.of_setfocus()
			return false
	end choose

end if

return true

end event

type uo_daibunrui from cv_input_bunrui within wm_tanka_copy
integer x = 1200
integer y = 910
integer width = 2240
integer taborder = 50
boolean bringtotop = true
boolean f6_key = true
boolean f9_key = false
boolean f12_key = true
string title_text = "大分類"
long title_width = 390
long input_width = 128
long bikou_width = 0
end type

on uo_daibunrui.destroy
call cv_input_bunrui::destroy
end on

type uo_tyubunrui from cv_input_bunrui within wm_tanka_copy
integer x = 1200
integer y = 1020
integer width = 2240
integer taborder = 60
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
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

type uo_syobunrui from cv_input_bunrui within wm_tanka_copy
integer x = 1200
integer y = 1138
integer width = 2280
integer taborder = 70
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
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

type uo_group from cv_input_group within wm_tanka_copy
integer x = 1200
integer y = 1248
integer taborder = 80
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
long title_width = 390
long input_width = 128
long bikou_width = 0
end type

on uo_group.destroy
call cv_input_group::destroy
end on

type uo_brand from cv_input_brand within wm_tanka_copy
integer x = 1200
integer y = 1465
integer taborder = 100
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
long title_width = 390
long input_width = 128
long bikou_width = 0
end type

on uo_brand.destroy
call cv_input_brand::destroy
end on

type uo_season from cv_input_meisyo within wm_tanka_copy
integer x = 1200
integer y = 1575
integer width = 1200
integer taborder = 110
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
string title_text = "シーズン"
long title_width = 390
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 121
end type

on uo_season.destroy
call cv_input_meisyo::destroy
end on

type uo_kojyo from cv_input_kojyo within wm_tanka_copy
integer x = 1200
integer y = 1355
integer taborder = 90
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
long input_width = 128
long bikou_width = 0
end type

on uo_kojyo.destroy
call cv_input_kojyo::destroy
end on

event constructor;call super::constructor;
this.st_title.text = "工場仕入先"

end event

type uo_bumon from cv_input_meisyo within wm_tanka_copy
integer x = 2420
integer y = 1575
integer width = 1200
integer taborder = 120
boolean bringtotop = true
boolean f6_key = true
string title_text = "部門"
long title_width = 390
long input_width = 128
long bikou_width = 0
integer meisyo_kbn = 21
end type

on uo_bumon.destroy
call cv_input_meisyo::destroy
end on

type st_touroku_date from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 1714
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "登録日"
alignment alignment = right!
end type

type sle_touroku_date_from from ivo_singlelineedit within wm_tanka_copy
string tag = "登録日(開始日)"
integer x = 444
integer y = 1714
integer width = 448
integer taborder = 130
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_date = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.text				= ""

end event

event input_check;call super::input_check;//日付チェック

string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		this.setfocus()
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_touroku_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			this.of_msg_error( "登録日の前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type st_touroku_date_namidashu from ivo_statictext within wm_tanka_copy
integer x = 912
integer y = 1721
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_touroku_date_to from ivo_singlelineedit within wm_tanka_copy
string tag = "登録日(終了日)"
integer x = 1080
integer y = 1714
integer width = 448
integer taborder = 140
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_date = true
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.text				= ""

end event

event input_check;call super::input_check;//日付チェック

string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		this.setfocus()
		return false
	end if

	// 日付大小チェック
	l_date_from	= sle_touroku_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date < l_date_from then
			this.of_msg_error( "登録日の前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

type st_saisyu_henkou_date from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 1824
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "最終変更日"
alignment alignment = right!
end type

type sle_saisyu_henkou_date_from from ivo_singlelineedit within wm_tanka_copy
string tag = "最終変更日(開始日)"
integer x = 444
integer y = 1824
integer width = 448
integer taborder = 150
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_date = true
integer i_limit = 10
end type

event input_check;call super::input_check;//日付チェック

string	l_date
string	l_date_to

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		this.setfocus()
		return false
	end if

	// 日付大小チェック
	l_date_to	= sle_saisyu_henkou_date_to.text

	if lena( trim( l_date_to ) ) > 0 then
		if l_date > l_date_to then
			this.of_msg_error( "最終変更日の前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.text				= ""

end event

type st_saisyu_henkou_date_namidashu from ivo_statictext within wm_tanka_copy
integer x = 912
integer y = 1824
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_saisyu_henkou_date_to from ivo_singlelineedit within wm_tanka_copy
string tag = "最終変更日(終了日)"
integer x = 1080
integer y = 1824
integer width = 448
integer taborder = 160
boolean bringtotop = true
integer textsize = -11
string text = "9999/99/99"
integer limit = 10
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_date = true
end type

event input_check;call super::input_check;//日付チェック

string	l_date
string	l_date_from

if lena( trim( this.text ) ) > 0 then

	// 日付フォーマットチェック
	l_date = fnc.db.of_date_format( this.text )
	
	if isnull( l_date ) then
		msg.of_error_sle( this, "不正な日付です。" )
		this.setfocus()
		return false
	end if

	// 日付大小チェック
	l_date_from	= sle_saisyu_henkou_date_from.text

	if lena( trim( l_date_from ) ) > 0 then
		if l_date < l_date_from then
			this.of_msg_error( "最終変更日の前後関係が不正です。" )
			this.setfocus()
			return false
		end if
	end if

	// 値セット
	this.text	= l_date

end if

return true

end event

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.text				= ""

end event

type rb_yoyaku_copy_no from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 944
integer y = 2130
integer width = 548
long backcolor = 553648127
string text = "複写しない"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_yoyaku_copy_yes from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 464
integer y = 2130
integer width = 460
long backcolor = 553648127
string text = "複写する"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_yoyaku_naiyou from ivo_statictext within wm_tanka_copy
integer x = 32
integer y = 2130
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "予約内容"
alignment alignment = right!
end type

type rb_torihiki_teisi_no from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 3280
integer y = 551
integer width = 460
long backcolor = 553648127
string text = "含めない"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_torihiki_teisi_yes from ivo_radiobutton within wm_tanka_copy
string tag = "上書き"
integer x = 2848
integer y = 551
integer width = 372
long backcolor = 553648127
string text = "含める"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_torihiki_teisi from ivo_statictext within wm_tanka_copy
integer x = 2416
integer y = 551
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "取引停止先"
alignment alignment = right!
end type

type gb_uwagaki from ivo_groupbox within wm_tanka_copy
integer x = 444
integer y = 2251
integer width = 720
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_haiban_kbn from ivo_groupbox within wm_tanka_copy
integer x = 444
integer y = 1934
integer width = 2100
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_yoyaku from ivo_groupbox within wm_tanka_copy
integer x = 444
integer y = 2091
integer width = 1072
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_1 from ivo_groupbox within wm_tanka_copy
integer x = 2828
integer y = 512
integer width = 932
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

