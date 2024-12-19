$PBExportHeader$wm_mise.srw
$PBExportComments$店一括変更
forward
global type wm_mise from iw_main_window
end type
type rb_tuneni from ivo_radiobutton within wm_mise
end type
type rb_tujyo from ivo_radiobutton within wm_mise
end type
type st_kousounohinsyo from ivo_statictext within wm_mise
end type
type dw_list from ivo_datawindow within wm_mise
end type
type uo_tokui from cv_input_tokui within wm_mise
end type
type uo_okuritokuisaki from cv_input_tokui within wm_mise
end type
type rb_hakko_no from ivo_radiobutton within wm_mise
end type
type rb_hakko_yes from ivo_radiobutton within wm_mise
end type
type st_dosonohinsyo from ivo_statictext within wm_mise
end type
type st_mise from ivo_statictext within wm_mise
end type
type sle_mise_from from ivo_singlelineedit within wm_mise
end type
type st_mise_namidash from ivo_statictext within wm_mise
end type
type sle_mise_to from ivo_singlelineedit within wm_mise
end type
type cbx_heiten_flg from ivo_checkbox within wm_mise
end type
type uo_unso from cv_input_unso within wm_mise
end type
type uo_eosnohinsaki from cv_input_mise within wm_mise
end type
type st_nissukeisan from ivo_statictext within wm_mise
end type
type sle_iraimotohyoji from ivo_singlelineedit within wm_mise
end type
type cbx_iraimotohyoji from ivo_checkbox within wm_mise
end type
type cbx_iraimotohyojisuru from ivo_checkbox within wm_mise
end type
type cbx_eosnohinsaki from ivo_checkbox within wm_mise
end type
type cbx_okuritokuisaki from ivo_checkbox within wm_mise
end type
type cbx_unsobin from ivo_checkbox within wm_mise
end type
type uo_unsobin from cv_input_unso within wm_mise
end type
type cbx_leadtime from ivo_checkbox within wm_mise
end type
type cbx_haitatusiteibi from ivo_checkbox within wm_mise
end type
type cbx_haitatusiteibihyoji from ivo_checkbox within wm_mise
end type
type cbx_nifudabikou from ivo_checkbox within wm_mise
end type
type sle_nifudabikou from ivo_singlelineedit within wm_mise
end type
type ddplb_leadtime from sv_ddplb_meisyo within wm_mise
end type
type ddplb_nissukeisan from sv_ddplb_meisyo within wm_mise
end type
type ddplb_haitatusiteijikoku from sv_ddplb_meisyo within wm_mise
end type
type st_haitatusiteijikoku from ivo_statictext within wm_mise
end type
type uo_niokurinin from cv_input_niokurinin within wm_mise
end type
type cbx_niokurinin from ivo_checkbox within wm_mise
end type
type cbx_nihonsyo from ivo_checkbox within wm_mise
end type
type cbx_faxsosin from ivo_checkbox within wm_mise
end type
type cbx_faxsosinsaki from ivo_checkbox within wm_mise
end type
type cbx_tyumon from ivo_checkbox within wm_mise
end type
type st_haisinmeisai from ivo_statictext within wm_mise
end type
type ddplb_haisinmeisai from sv_ddplb_meisyo within wm_mise
end type
type st_layout from ivo_statictext within wm_mise
end type
type ddplb_layout from sv_ddplb_meisyo within wm_mise
end type
type st_haisinhouhou from ivo_statictext within wm_mise
end type
type ddplb_haisinhouhou from sv_ddplb_meisyo within wm_mise
end type
type uo_faxsosinsaki from cv_input_mise within wm_mise
end type
type st_faxno from sv_st_meisyo within wm_mise
end type
type gb_kousou from ivo_groupbox within wm_mise
end type
type gb_hakko from ivo_groupbox within wm_mise
end type
end forward

global type wm_mise from iw_main_window
string title = "店一括変更"
boolean f12_key = true
rb_tuneni rb_tuneni
rb_tujyo rb_tujyo
st_kousounohinsyo st_kousounohinsyo
dw_list dw_list
uo_tokui uo_tokui
uo_okuritokuisaki uo_okuritokuisaki
rb_hakko_no rb_hakko_no
rb_hakko_yes rb_hakko_yes
st_dosonohinsyo st_dosonohinsyo
st_mise st_mise
sle_mise_from sle_mise_from
st_mise_namidash st_mise_namidash
sle_mise_to sle_mise_to
cbx_heiten_flg cbx_heiten_flg
uo_unso uo_unso
uo_eosnohinsaki uo_eosnohinsaki
st_nissukeisan st_nissukeisan
sle_iraimotohyoji sle_iraimotohyoji
cbx_iraimotohyoji cbx_iraimotohyoji
cbx_iraimotohyojisuru cbx_iraimotohyojisuru
cbx_eosnohinsaki cbx_eosnohinsaki
cbx_okuritokuisaki cbx_okuritokuisaki
cbx_unsobin cbx_unsobin
uo_unsobin uo_unsobin
cbx_leadtime cbx_leadtime
cbx_haitatusiteibi cbx_haitatusiteibi
cbx_haitatusiteibihyoji cbx_haitatusiteibihyoji
cbx_nifudabikou cbx_nifudabikou
sle_nifudabikou sle_nifudabikou
ddplb_leadtime ddplb_leadtime
ddplb_nissukeisan ddplb_nissukeisan
ddplb_haitatusiteijikoku ddplb_haitatusiteijikoku
st_haitatusiteijikoku st_haitatusiteijikoku
uo_niokurinin uo_niokurinin
cbx_niokurinin cbx_niokurinin
cbx_nihonsyo cbx_nihonsyo
cbx_faxsosin cbx_faxsosin
cbx_faxsosinsaki cbx_faxsosinsaki
cbx_tyumon cbx_tyumon
st_haisinmeisai st_haisinmeisai
ddplb_haisinmeisai ddplb_haisinmeisai
st_layout st_layout
ddplb_layout ddplb_layout
st_haisinhouhou st_haisinhouhou
ddplb_haisinhouhou ddplb_haisinhouhou
uo_faxsosinsaki uo_faxsosinsaki
st_faxno st_faxno
gb_kousou gb_kousou
gb_hakko gb_hakko
end type
global wm_mise wm_mise

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

end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_update ()
public function boolean of_record_lock (boolean p_lock)
public subroutine of_dsp_reset ()
public function boolean of_db_update (any p_rec)
public subroutine of_dsp_back ()
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);// p_controlによって、ロックやフォーカスを制御する
long	l_row

choose case p_control
	case "callsection"
		cb_retrieve.enabled		= p_enabled
		// 呼び出し部のロック状態を制御する
		uo_tokui.of_set_enabled( p_enabled )
		// 得意先
		uo_tokui.of_set_enabled( p_enabled )
		// 店
		sle_mise_from.enabled					= p_enabled
		sle_mise_to.enabled						= p_enabled
		cbx_heiten_flg.enabled					= p_enabled
		// 運送便
		uo_unso.of_set_enabled( p_enabled )

	case "detailsection"
		// 明細部
		// 依頼元表示
		cbx_iraimotohyoji.enabled				= p_enabled
		//sle_iraimotohyoji.enabled				= p_enabled
		//cbx_iraimotohyojisuru.enabled			= p_enabled
		// EOS納品先
		cbx_eosnohinsaki.enabled				= p_enabled
		//uo_eosnohinsaki.of_set_enabled( p_enabled )
		// 送り得意先
		cbx_okuritokuisaki.enabled				= p_enabled
		//uo_okutitokuisaki.of_set_enabled( p_enabled )
		// 運送便
		cbx_unsobin.enabled						= p_enabled
		//uo_unsobin.of_set_enabled( p_enabled )
		// リードタイム、日数計算
		cbx_leadtime.enabled						= p_enabled
		//ddplb_leadtime.enabled					= p_enabled
		//ddplb_nissukeisan.enabled				= p_enabled
		// 配達指定日
		cbx_haitatusiteibi.enabled				= p_enabled
		//cbx_haitatusiteibihyoji.enabled		= p_enabled
		//ddplb_haitatusiteijikoku.enabled		= p_enabled
		// 荷札備考
		cbx_nifudabikou.enabled					= p_enabled
		//sle_nifudabikou.enabled					= p_enabled
		// 荷送人
		cbx_niokurinin.enabled					= p_enabled
		//uo_niokurinin.of_set_enabled( p_enabled )
		// 納品書、同送納品書、後送納品書
		cbx_nihonsyo.enabled						= p_enabled
		//gb_hakko.enabled							= p_enabled
		//rb_hakko_yes.enabled						= p_enabled
		//rb_hakko_no.enabled						= p_enabled
		//gb_goso.enabled							= p_enabled
		//rb_tujyo.enabled							= p_enabled
		//rb_tuneni.enabled							= p_enabled
		// FAX送信、配信明細、レイアウト、配信方法
		cbx_faxsosin.enabled						= p_enabled
		//cbx_tyumon.enabled						= p_enabled
		//ddplb_haisinmeisai.enabled				= p_enabled
		//ddplb_layout.enabled						= p_enabled
		//ddplb_haisinhouhou.enabled				= p_enabled
		// FAX送信先
		cbx_faxsosinsaki.enabled				= p_enabled
		//uo_faxsosinsaki.of_set_enabled( p_enabled )
		//sle_faxno.enabled							= p_enabled
		// 明細
		dw_list.enabled							= p_enabled

end choose

end subroutine

public function boolean of_update ();// 更新登録処理
long		l_loop
long		l_row
long		l_row_count
datetime	l_sysdate
long		l_ret

long		l_tokui_code
long		l_mise_code
long		l_haisin_houhou
long		l_count
long		l_null
boolean	l_return

string l_yubin_no
long l_tyakuten_tome_flg
nv_master				mst
str_mtyakuten			l_tyakuten[]
str_mdlpara_mtyakuten 	l_mdl_tyakuten

setnull(l_null)

// 店マスタ用データストア
datastore	dw_update

dw_update = create datastore
dw_update.dataobject 	= "dm_mise"
dw_update.settransobject(cocos)  

l_ret = 1

select sysdate
  into :l_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

l_row_count = dw_list.rowcount()
for l_row = 1 to l_row_count
	if dw_list.GetItemString(l_row,"chkbox") = "0" then
		continue
	end if

	l_tokui_code = dw_list.GetItemDecimal(l_row,"tokui_code")
	l_mise_code = dw_list.GetItemDecimal(l_row,"mise_code")

	// データ読み込み
	l_count = dw_update.retrieve(l_tokui_code,l_mise_code,l_mise_code,1,l_null)
	
	if l_count < 0 then
		msg.of_error_db( "更新対象の読み込みでエラーが発生しました。", cocos )
		l_ret = 0
		exit
	end if


	// 2024.11.29ito　更新チェック実装
	// 店M排他チェック
	// 変数宣言
	string	l_kousin_user_id, l_kousin_client_id, l_kousin_pg_id
	long l_haita_exists_flg
	
	select nvl( mm.kousin_user_id, '???' ),
			  nvl( mm.kousin_client_id, '???' ),
			  nvl( mm.haita_flg, 0 )
	  into :l_kousin_user_id,
	  		 :l_kousin_client_id,
			 :l_haita_exists_flg
	  from m_mise mm
	  where mm.tokui_code = :l_tokui_code
		 and mm.mise_code = :l_mise_code
		for update nowait
	using cocos;

	choose case cocos.sqlcode
	case 0
		if l_haita_exists_flg = 1 then
			rollback using cocos;
			// メッセージをof_record_lockの排他エラーと合わす、端末IDの方は全角コロン、ユーザーIDの方は半角コロン。どうでもいいっちゃどうでもいいけど変更必要になるかも
			msg.of_error( fnc.strg.of_format( "対象データは他の端末で変更中です。{1}（端末ID：{2} ユーザーID:{3}）", code.crlf, l_kousin_client_id, l_kousin_user_id ) )
			return false
		end if		
	case 100
		// 取得できなかった場合何もしない
	case else
		if cocos.sqldbcode = 54 then
			rollback using cocos;
			msg.of_error("対象データは他の端末で更新処理中です。")
			return false
		end if
		rollback using cocos;
		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
		return false
	end choose




	// 依頼元表示
	if cbx_iraimotohyoji.checked then
		dw_update.setitem(1,"iraimoto_mei",sle_iraimotohyoji.text)
		if cbx_iraimotohyojisuru.checked then
			dw_update.setitem(1,"iraimoto_flg",1)
		else
			dw_update.setitem(1,"iraimoto_flg",0)
		end if
	end if
	// EOS納品先
	if cbx_eosnohinsaki.checked then
		dw_update.setitem(1,"okuri_center_code",long( trim( uo_eosnohinsaki.of_get_input( ) ) ) )
	end if
	// 送り得意先
	if cbx_okuritokuisaki.checked then
		dw_update.setitem(1,"okuri_tokui_code",long( trim( uo_okuritokuisaki.of_get_input( ) ) ) )
	end if
	// 運送便
	if cbx_unsobin.checked then
		dw_update.setitem(1,"unso_code",long( trim( uo_unsobin.of_get_input( ) ) ) )
		
		//ここで着点マスタ見に行く、参照ポップ出す
		
		l_yubin_no = dw_list.GetItemString(l_row,"yubin_no")
		l_tyakuten_tome_flg = dw_list.GetItemDecimal(l_row,"tyakuten_tome_flg")
		
		l_ret = mst.of_tyakuten_get( long( trim( uo_unsobin.of_get_input( ) ) ), l_yubin_no, l_tyakuten )
		// 着店Mに存在しない場合
		if l_ret = 0 then
		// this.object.tyakuten_code[row] = l_null_string
		// 着店Mに複数存在する場合
		elseif l_ret > 2 then
			// 着店選択画面を表示
			l_mdl_tyakuten.in_tokui_code 	= l_tokui_code
			l_mdl_tyakuten.in_mise_code 	= l_mise_code
			l_mdl_tyakuten.in_unso_code 	= long( trim( uo_unsobin.of_get_input( ) ) )
			l_mdl_tyakuten.in_yubin_no 		= l_yubin_no
			l_mdl_tyakuten	= mdl.of_open_modal( "wsm_tyakuten", l_mdl_tyakuten )
			if upperbound( l_mdl_tyakuten.ret ) > 0 then
				dw_update.setitem(1,"tyakuten_code",l_mdl_tyakuten.ret[1].tyakuten_code)
			end if
		// 着店Mに1件存在する場合
		else
			// 営業店止め
			if l_tyakuten_tome_flg = 1 then
				// チェックあり
				dw_update.setitem(1,"tyakuten_code",l_mdl_tyakuten.ret[1].tyakuten_code_tome)
			else
				// チェックなし
				dw_update.setitem(1,"tyakuten_code",l_mdl_tyakuten.ret[1].tyakuten_code)
			end if
			
		end if

	end if
	// リードタイム、日数計算
	if cbx_leadtime.checked then
		dw_update.setitem(1,"leadtime_kbn",ddplb_leadtime.of_get_code_num())
		dw_update.setitem(1,"leadtime_keisan_kbn",ddplb_nissukeisan.of_get_code_num())
	end if
	// 配達指定日
	if cbx_haitatusiteibi.checked then
		if cbx_haitatusiteibihyoji.checked then
			dw_update.setitem(1,"haitatu_sitei_flg",1)
		else
			dw_update.setitem(1,"haitatu_sitei_flg",0)
		end if
		dw_update.setitem(1,"haitatu_sitei_jikoku",ddplb_haitatusiteijikoku.of_get_code())
	end if
	// 荷札備考
	if cbx_nifudabikou.checked then
		dw_update.setitem(1,"nifuda_bikou",sle_nifudabikou.text)
	end if
	// 荷送人
	if cbx_niokurinin.checked then
		dw_update.setitem(1,"niokurinin_code",long( trim( uo_niokurinin.of_get_input( ) ) ) )
	end if
	// 納品書、同送納品書、後送納品書
	if cbx_nihonsyo.checked then
		// 同送納品書発行区分（1＝不要2＝通常発行4＝内容明細書単位）※名称区分＝118
		if rb_hakko_yes.checked then
			dw_update.setitem(1,"nohinsyo_hakkou_kbn",2)
		end if
		if rb_hakko_no.checked then
			dw_update.setitem(1,"nohinsyo_hakkou_kbn",1)
		end if
		// 後送納品書発行区分（1＝通常2＝常に発行（同送納品書に金額表示しても日次処理発行対象とする））※名称区分＝117
		if rb_tujyo.checked then
			dw_update.setitem(1,"nohinsyo_kousou_kbn",1)
		end if
		if rb_tuneni.checked then
			dw_update.setitem(1,"nohinsyo_kousou_kbn",2)
		end if
	end if
	// FAX送信、配信明細、レイアウト、配信方法
	if cbx_faxsosin.checked then
		if cbx_tyumon.checked then
			dw_update.setitem(1,"hensin_flg",1)
		else
			dw_update.setitem(1,"hensin_flg",0)
		end if
		dw_update.setitem(1,"meisai_kbn",ddplb_haisinmeisai.of_get_code_num())
		dw_update.setitem(1,"layout_kbn",ddplb_layout.of_get_code_num())
		dw_update.setitem(1,"haisin_houhou",ddplb_haisinhouhou.of_get_code_num())
	end if
	// FAX送信先
	if cbx_faxsosinsaki.checked then
		dw_update.setitem(1,"hensin_mise_code",long( trim( uo_faxsosinsaki.of_get_input( ) ) ) )
		// 配信方法（1＝FAX2＝メール3＝I-FAX4＝印刷5＝PDF）※名称区分＝222
		l_haisin_houhou = long(st_faxno.tag)		// 読み込んだ配信方法
		if cbx_faxsosin.checked then					// FAX送信で配信方法を指定している場合
			l_haisin_houhou = ddplb_haisinhouhou.of_get_code_num()
		end if
		if l_haisin_houhou = 1 then
			dw_update.setitem(1,"hensin_fax_no",st_faxno.text)
		end if
		if l_haisin_houhou = 2 then
			dw_update.setitem(1,"hensin_address",st_faxno.text)
		end if
	end if

	dw_update.SetItem(1,"henkou_date"			,l_sysdate)
	dw_update.SetItem(1,"henkou_user_id"		,user.user_id)
	dw_update.SetItem(1,"henkou_client_id"		,device.name)
	dw_update.SetItem(1,"henkou_pg_id"			,i_pg_id)
	
	dw_update.SetItem(1,"kousin_user_id"		,user.user_id)
	dw_update.SetItem(1,"kousin_pg_id"			,i_pg_id)

	// 更新
	l_ret = dw_update.update()
	if l_ret = 0 then
		exit
	end if
	
	// 20241121.ito操作ログ処理実装
	of_add_db_log( "update_event", 0, st_title.text +  "[得意先=" + &
	string(l_tokui_code)  + " " + &
	"店=" + &
	trim(string(l_mise_code))+ " " + &
	trim(string(dw_list.GetItemString(l_row,"mise_mei"))) + " " + &
	"]" + i_syori_kbn )
next



// テスト用
//sleep(10)





if l_ret = 1 then
	commit using cocos;
	l_return = true
else
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	l_return = false
end if

destroy dw_update

return l_return

end function

public function boolean of_record_lock (boolean p_lock);
long l_i, l_count, l_tokui_code, l_mise_code

l_count = dw_list.RowCount()

// 悲観ロック＆ロック解除関数
if p_lock then
	for l_i = 1 to l_count
		/*
		if dw_list.GetItemString(l_i,"chkbox") = "0" then
			continue
		end if
		*/
		l_tokui_code = dw_list.GetItemDecimal(l_i,"tokui_code")
		l_mise_code = dw_list.GetItemDecimal(l_i,"mise_code")
		if lck.of_mise_lock( i_pg_id, l_tokui_code, l_mise_code) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
	next
else
	for l_i = 1 to l_count
		/*
		if dw_list.GetItemString(l_i,"chkbox") = "0" then
			continue
		end if
		*/
		l_tokui_code = dw_list.GetItemDecimal(l_i,"tokui_code")
		l_mise_code = dw_list.GetItemDecimal(l_i,"mise_code")
		if lck.of_mise_unlock( i_pg_id, l_tokui_code, l_mise_code) then
			commit using cocos;  // commitは子孫側で行う
		else
			return false
		end if
	next
	
end if

uo_signal.of_on_signal( p_lock )

return true
end function

public subroutine of_dsp_reset ();// F9：初期表示

i_syori_kbn = "初期"

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）

// ヘッダ部
// 得意先
dw_list.event constructor( )
uo_tokui.event constructor( )
// 店
sle_mise_from.event constructor( )
sle_mise_to.event constructor( )
cbx_heiten_flg.checked = false
// 運送便
uo_unso.event constructor( )
// ヘッダ部
of_dsp_edit( "callsection", true )

// 明細部
// 依頼元表示
cbx_iraimotohyoji.checked = false
sle_iraimotohyoji.event constructor( )
cbx_iraimotohyojisuru.checked = false
cbx_iraimotohyoji.event clicked()
// EOS納品先
cbx_eosnohinsaki.checked = false
uo_eosnohinsaki.event constructor( )
cbx_eosnohinsaki.event clicked()
// 送り得意先
cbx_okuritokuisaki.checked = false
uo_okuritokuisaki.event constructor( )
cbx_okuritokuisaki.event clicked()
// 運送便
cbx_unsobin.checked = false
uo_unsobin.event constructor( )
cbx_unsobin.event clicked()
// リードタイム、日数計算 
cbx_leadtime.checked = false
ddplb_leadtime.event constructor( )			// constructorでenabledになるため注意
ddplb_nissukeisan.event constructor( )		// constructorでenabledになるため注意
cbx_leadtime.event clicked()
// 配達指定日
cbx_haitatusiteibi.checked = false
cbx_haitatusiteibihyoji.checked = false
ddplb_haitatusiteijikoku.event constructor( )
cbx_haitatusiteibi.event clicked()
// 荷札備考
cbx_nifudabikou.checked = false
sle_nifudabikou.event constructor( )
cbx_nifudabikou.event clicked()
// 荷送人
cbx_niokurinin.checked = false
uo_niokurinin.event constructor( )
cbx_niokurinin.event clicked()
// 納品書、同送納品書、後送納品書
cbx_nihonsyo.checked = false
rb_hakko_yes.checked = true
rb_hakko_no.checked = true
rb_tujyo.checked = true
rb_tuneni.checked = false
cbx_nihonsyo.event clicked()
// FAX送信、配信明細、レイアウト、配信方法
cbx_faxsosin.checked = false
cbx_tyumon.checked = false
ddplb_haisinmeisai.event constructor( )	// constructorでenabledになるため注意
ddplb_layout.event constructor( )			// constructorでenabledになるため注意
ddplb_haisinhouhou.event constructor( )	// constructorでenabledになるため注意
cbx_faxsosin.event clicked()
// FAX送信先
cbx_faxsosinsaki.checked = false
uo_faxsosinsaki.event constructor( )
st_faxno.event constructor( )
cbx_faxsosinsaki.event clicked()
// 明細
dw_list.reset()
// 明細部
of_dsp_edit( "detailsection", false )

of_set_firstfocus( )

end subroutine

public function boolean of_db_update (any p_rec);// 更新登録処理
long		l_loop
long		l_row
long		l_row_count
integer	l_haita_flg
boolean	l_lock
datetime	l_sysdate
long		l_ret

long		l_tokui_code
long		l_mise_code
long		l_haisin_houhou
long		l_count
long		l_null
boolean	l_return

setnull(l_null)

// 店マスタ用データストア
datastore	dw_update

dw_update = create datastore
dw_update.dataobject 	= "dm_mise"
dw_update.settransobject(cocos)  

l_lock = false
l_haita_flg	= 0
l_ret = 1

select sysdate
  into :l_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-1", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	return false
end if

l_row_count = dw_list.rowcount()
for l_row = 1 to l_row_count
	if dw_list.GetItemString(l_row,"chkbox") = "0" then
		continue
	end if

	l_tokui_code = dw_list.GetItemDecimal(l_row,"tokui_code")
	l_mise_code = dw_list.GetItemDecimal(l_row,"mise_code")

	// データ読み込み
	l_count = dw_update.retrieve(l_tokui_code,l_mise_code,l_mise_code,1,l_null)
	
	if l_count < 0 then
		msg.of_error_db( "更新対象の読み込みでエラーが発生しました。", cocos )
		l_ret = 0
		exit
	end if

	// 依頼元表示
	if cbx_iraimotohyoji.checked then
		dw_update.setitem(1,"iraimoto_mei",sle_iraimotohyoji.text)
		if cbx_iraimotohyojisuru.checked then
			dw_update.setitem(1,"iraimoto_flg",1)
		else
			dw_update.setitem(1,"iraimoto_flg",0)
		end if
	end if
	// EOS納品先
	if cbx_eosnohinsaki.checked then
		dw_update.setitem(1,"okuri_center_code",long( trim( uo_eosnohinsaki.of_get_input( ) ) ) )
	end if
	// 送り得意先
	if cbx_okuritokuisaki.checked then
		dw_update.setitem(1,"okuri_tokui_code",long( trim( uo_okuritokuisaki.of_get_input( ) ) ) )
	end if
	// 運送便
	if cbx_unsobin.checked then
		dw_update.setitem(1,"unso_code",long( trim( uo_unsobin.of_get_input( ) ) ) )
	end if
	// リードタイム、日数計算
	if cbx_leadtime.checked then
		dw_update.setitem(1,"leadtime_kbn",ddplb_leadtime.of_get_code_num())
		dw_update.setitem(1,"leadtime_keisan_kbn",ddplb_nissukeisan.of_get_code_num())
	end if
	// 配達指定日
	if cbx_haitatusiteibi.checked then
		if cbx_haitatusiteibihyoji.checked then
			dw_update.setitem(1,"haitatu_sitei_flg",1)
		else
			dw_update.setitem(1,"haitatu_sitei_flg",0)
		end if
		
		dw_update.setitem(1,"haitatu_sitei_jikoku",ddplb_haitatusiteijikoku.of_get_code())
	end if
	// 荷札備考
	if cbx_nifudabikou.checked then
		dw_update.setitem(1,"nifuda_bikou",sle_nifudabikou.text)
	end if
	// 荷送人
	if cbx_niokurinin.checked then
		dw_update.setitem(1,"niokurinin_code",long( trim( uo_niokurinin.of_get_input( ) ) ) )
	end if
	// 納品書、同送納品書、後送納品書
	if cbx_nihonsyo.checked then
		// 同送納品書発行区分（1＝不要2＝通常発行4＝内容明細書単位）※名称区分＝118
		if rb_hakko_yes.checked then
			dw_update.setitem(1,"nohinsyo_hakkou_kbn",2)
		end if
		if rb_hakko_no.checked then
			dw_update.setitem(1,"nohinsyo_hakkou_kbn",1)
		end if
		// 後送納品書発行区分（1＝通常2＝常に発行（同送納品書に金額表示しても日次処理発行対象とする））※名称区分＝117
		if rb_tujyo.checked then
			dw_update.setitem(1,"nohinsyo_kousou_kbn",1)
		end if
		if rb_tuneni.checked then
			dw_update.setitem(1,"nohinsyo_kousou_kbn",2)
		end if
	end if
	// FAX送信、配信明細、レイアウト、配信方法
	if cbx_faxsosin.checked then
		if cbx_tyumon.checked then
			dw_update.setitem(1,"hensin_flg",1)
		else
			dw_update.setitem(1,"hensin_flg",0)
		end if
		dw_update.setitem(1,"meisai_kbn",ddplb_haisinmeisai.of_get_code_num())
		dw_update.setitem(1,"layout_kbn",ddplb_layout.of_get_code_num())
		dw_update.setitem(1,"haisin_houhou",ddplb_haisinhouhou.of_get_code_num())
	end if
	// FAX送信先
	if cbx_faxsosinsaki.checked then
		dw_update.setitem(1,"hensin_mise_code",long( trim( uo_faxsosinsaki.of_get_input( ) ) ) )
		// 配信方法（1＝FAX2＝メール3＝I-FAX4＝印刷5＝PDF）※名称区分＝222
		l_haisin_houhou = long(st_faxno.tag)		// 読み込んだ配信方法
		if cbx_faxsosin.checked then					// FAX送信で配信方法を指定している場合
			l_haisin_houhou = ddplb_haisinhouhou.of_get_code_num()
		end if
		if l_haisin_houhou = 1 then
			dw_update.setitem(1,"hensin_fax_no",st_faxno.text)
		end if
		if l_haisin_houhou = 2 then
			dw_update.setitem(1,"hensin_address",st_faxno.text)
		end if
	end if

	dw_update.SetItem(1,"henkou_date"			,l_sysdate)
	dw_update.SetItem(1,"henkou_user_id"		,user.user_id)
	dw_update.SetItem(1,"henkou_client_id"		,device.name)
	dw_update.SetItem(1,"henkou_pg_id"			,i_pg_id)
	dw_update.SetItem(1,"kousin_date"			,l_sysdate)
	dw_update.SetItem(1,"kousin_user_id"		,user.user_id)
	dw_update.SetItem(1,"kousin_client_id"		,device.name)
	dw_update.SetItem(1,"kousin_pg_id"			,i_pg_id)
	dw_update.SetItem(1,"haita_flg"				,l_haita_flg)

	// 更新
	l_ret = dw_update.update()
	if l_ret = 0 then
		exit
	end if
	
	// 20241121.ito操作ログ処理実装
	of_add_db_log( "update_event", 0, st_title.text +  "[" + &
	string(l_tokui_code)  + " " + &
	trim(string(l_mise_code))+ " " + &
	trim(string(dw_list.GetItemString(l_row,"mise_mei"))) + " " + &
	"]" + i_syori_kbn )
next

if l_ret = 1 then
	commit using cocos;
	// ランプの色を制御する
	uo_signal.of_on_signal( l_lock )
	l_return = true
else
	rollback using cocos;
	msg.of_error( fnc.strg.of_format( "店マスタの更新処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
	of_add_db_log( "of_update-2", cocos.last_sqlerrcode, cocos.last_sqlerrtext )	// ログを出力
	l_return = false
end if

destroy dw_update

return l_return

end function

public subroutine of_dsp_back ();// F6：戻りの処理

dw_list.setredraw( false )
dw_list.event constructor( )
// 明細部
of_dsp_edit( "detailsection", false )
// 依頼元表示
cbx_iraimotohyoji.checked = false
sle_iraimotohyoji.event constructor( )
cbx_iraimotohyojisuru.checked = false
cbx_iraimotohyoji.event clicked()
// EOS納品先
cbx_eosnohinsaki.checked = false
uo_eosnohinsaki.event constructor( )
cbx_eosnohinsaki.event clicked()
// 送り得意先
cbx_okuritokuisaki.checked = false
uo_okuritokuisaki.event constructor( )
cbx_okuritokuisaki.event clicked()
// 運送便
cbx_unsobin.checked = false
uo_unsobin.event constructor( )
cbx_unsobin.event clicked()
// リードタイム、日数計算 
cbx_leadtime.checked = false
ddplb_leadtime.event constructor( )			// constructorでenabledになるため注意
ddplb_nissukeisan.event constructor( )		// constructorでenabledになるため注意
cbx_leadtime.event clicked()
// 配達指定日
cbx_haitatusiteibi.checked = false
cbx_haitatusiteibihyoji.checked = false
ddplb_haitatusiteijikoku.event constructor( )
cbx_haitatusiteibi.event clicked()
// 荷札備考
cbx_nifudabikou.checked = false
sle_nifudabikou.event constructor( )
cbx_nifudabikou.event clicked()
// 荷送人
cbx_niokurinin.checked = false
uo_niokurinin.event constructor( )
cbx_niokurinin.event clicked()
// 納品書、同送納品書、後送納品書
cbx_nihonsyo.checked = false
rb_hakko_yes.checked = true
rb_hakko_no.checked = true
rb_tujyo.checked = true
rb_tuneni.checked = false
cbx_nihonsyo.event clicked()
// FAX送信、配信明細、レイアウト、配信方法
cbx_faxsosin.checked = false
cbx_tyumon.checked = false
ddplb_haisinmeisai.event constructor( )	// constructorでenabledになるため注意
ddplb_layout.event constructor( )			// constructorでenabledになるため注意
ddplb_haisinhouhou.event constructor( )	// constructorでenabledになるため注意
cbx_faxsosin.event clicked()
// FAX送信先
cbx_faxsosinsaki.checked = false
uo_faxsosinsaki.event constructor( )
st_faxno.event constructor( )
cbx_faxsosinsaki.event clicked()
// 明細
dw_list.reset()

// 呼び出し部
of_dsp_edit( "callsection", true )

dw_list.setredraw( true )

of_set_firstfocus( )

end subroutine

on wm_mise.create
int iCurrent
call super::create
this.rb_tuneni=create rb_tuneni
this.rb_tujyo=create rb_tujyo
this.st_kousounohinsyo=create st_kousounohinsyo
this.dw_list=create dw_list
this.uo_tokui=create uo_tokui
this.uo_okuritokuisaki=create uo_okuritokuisaki
this.rb_hakko_no=create rb_hakko_no
this.rb_hakko_yes=create rb_hakko_yes
this.st_dosonohinsyo=create st_dosonohinsyo
this.st_mise=create st_mise
this.sle_mise_from=create sle_mise_from
this.st_mise_namidash=create st_mise_namidash
this.sle_mise_to=create sle_mise_to
this.cbx_heiten_flg=create cbx_heiten_flg
this.uo_unso=create uo_unso
this.uo_eosnohinsaki=create uo_eosnohinsaki
this.st_nissukeisan=create st_nissukeisan
this.sle_iraimotohyoji=create sle_iraimotohyoji
this.cbx_iraimotohyoji=create cbx_iraimotohyoji
this.cbx_iraimotohyojisuru=create cbx_iraimotohyojisuru
this.cbx_eosnohinsaki=create cbx_eosnohinsaki
this.cbx_okuritokuisaki=create cbx_okuritokuisaki
this.cbx_unsobin=create cbx_unsobin
this.uo_unsobin=create uo_unsobin
this.cbx_leadtime=create cbx_leadtime
this.cbx_haitatusiteibi=create cbx_haitatusiteibi
this.cbx_haitatusiteibihyoji=create cbx_haitatusiteibihyoji
this.cbx_nifudabikou=create cbx_nifudabikou
this.sle_nifudabikou=create sle_nifudabikou
this.ddplb_leadtime=create ddplb_leadtime
this.ddplb_nissukeisan=create ddplb_nissukeisan
this.ddplb_haitatusiteijikoku=create ddplb_haitatusiteijikoku
this.st_haitatusiteijikoku=create st_haitatusiteijikoku
this.uo_niokurinin=create uo_niokurinin
this.cbx_niokurinin=create cbx_niokurinin
this.cbx_nihonsyo=create cbx_nihonsyo
this.cbx_faxsosin=create cbx_faxsosin
this.cbx_faxsosinsaki=create cbx_faxsosinsaki
this.cbx_tyumon=create cbx_tyumon
this.st_haisinmeisai=create st_haisinmeisai
this.ddplb_haisinmeisai=create ddplb_haisinmeisai
this.st_layout=create st_layout
this.ddplb_layout=create ddplb_layout
this.st_haisinhouhou=create st_haisinhouhou
this.ddplb_haisinhouhou=create ddplb_haisinhouhou
this.uo_faxsosinsaki=create uo_faxsosinsaki
this.st_faxno=create st_faxno
this.gb_kousou=create gb_kousou
this.gb_hakko=create gb_hakko
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tuneni
this.Control[iCurrent+2]=this.rb_tujyo
this.Control[iCurrent+3]=this.st_kousounohinsyo
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.uo_tokui
this.Control[iCurrent+6]=this.uo_okuritokuisaki
this.Control[iCurrent+7]=this.rb_hakko_no
this.Control[iCurrent+8]=this.rb_hakko_yes
this.Control[iCurrent+9]=this.st_dosonohinsyo
this.Control[iCurrent+10]=this.st_mise
this.Control[iCurrent+11]=this.sle_mise_from
this.Control[iCurrent+12]=this.st_mise_namidash
this.Control[iCurrent+13]=this.sle_mise_to
this.Control[iCurrent+14]=this.cbx_heiten_flg
this.Control[iCurrent+15]=this.uo_unso
this.Control[iCurrent+16]=this.uo_eosnohinsaki
this.Control[iCurrent+17]=this.st_nissukeisan
this.Control[iCurrent+18]=this.sle_iraimotohyoji
this.Control[iCurrent+19]=this.cbx_iraimotohyoji
this.Control[iCurrent+20]=this.cbx_iraimotohyojisuru
this.Control[iCurrent+21]=this.cbx_eosnohinsaki
this.Control[iCurrent+22]=this.cbx_okuritokuisaki
this.Control[iCurrent+23]=this.cbx_unsobin
this.Control[iCurrent+24]=this.uo_unsobin
this.Control[iCurrent+25]=this.cbx_leadtime
this.Control[iCurrent+26]=this.cbx_haitatusiteibi
this.Control[iCurrent+27]=this.cbx_haitatusiteibihyoji
this.Control[iCurrent+28]=this.cbx_nifudabikou
this.Control[iCurrent+29]=this.sle_nifudabikou
this.Control[iCurrent+30]=this.ddplb_leadtime
this.Control[iCurrent+31]=this.ddplb_nissukeisan
this.Control[iCurrent+32]=this.ddplb_haitatusiteijikoku
this.Control[iCurrent+33]=this.st_haitatusiteijikoku
this.Control[iCurrent+34]=this.uo_niokurinin
this.Control[iCurrent+35]=this.cbx_niokurinin
this.Control[iCurrent+36]=this.cbx_nihonsyo
this.Control[iCurrent+37]=this.cbx_faxsosin
this.Control[iCurrent+38]=this.cbx_faxsosinsaki
this.Control[iCurrent+39]=this.cbx_tyumon
this.Control[iCurrent+40]=this.st_haisinmeisai
this.Control[iCurrent+41]=this.ddplb_haisinmeisai
this.Control[iCurrent+42]=this.st_layout
this.Control[iCurrent+43]=this.ddplb_layout
this.Control[iCurrent+44]=this.st_haisinhouhou
this.Control[iCurrent+45]=this.ddplb_haisinhouhou
this.Control[iCurrent+46]=this.uo_faxsosinsaki
this.Control[iCurrent+47]=this.st_faxno
this.Control[iCurrent+48]=this.gb_kousou
this.Control[iCurrent+49]=this.gb_hakko
end on

on wm_mise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_tuneni)
destroy(this.rb_tujyo)
destroy(this.st_kousounohinsyo)
destroy(this.dw_list)
destroy(this.uo_tokui)
destroy(this.uo_okuritokuisaki)
destroy(this.rb_hakko_no)
destroy(this.rb_hakko_yes)
destroy(this.st_dosonohinsyo)
destroy(this.st_mise)
destroy(this.sle_mise_from)
destroy(this.st_mise_namidash)
destroy(this.sle_mise_to)
destroy(this.cbx_heiten_flg)
destroy(this.uo_unso)
destroy(this.uo_eosnohinsaki)
destroy(this.st_nissukeisan)
destroy(this.sle_iraimotohyoji)
destroy(this.cbx_iraimotohyoji)
destroy(this.cbx_iraimotohyojisuru)
destroy(this.cbx_eosnohinsaki)
destroy(this.cbx_okuritokuisaki)
destroy(this.cbx_unsobin)
destroy(this.uo_unsobin)
destroy(this.cbx_leadtime)
destroy(this.cbx_haitatusiteibi)
destroy(this.cbx_haitatusiteibihyoji)
destroy(this.cbx_nifudabikou)
destroy(this.sle_nifudabikou)
destroy(this.ddplb_leadtime)
destroy(this.ddplb_nissukeisan)
destroy(this.ddplb_haitatusiteijikoku)
destroy(this.st_haitatusiteijikoku)
destroy(this.uo_niokurinin)
destroy(this.cbx_niokurinin)
destroy(this.cbx_nihonsyo)
destroy(this.cbx_faxsosin)
destroy(this.cbx_faxsosinsaki)
destroy(this.cbx_tyumon)
destroy(this.st_haisinmeisai)
destroy(this.ddplb_haisinmeisai)
destroy(this.st_layout)
destroy(this.ddplb_layout)
destroy(this.st_haisinhouhou)
destroy(this.ddplb_haisinhouhou)
destroy(this.uo_faxsosinsaki)
destroy(this.st_faxno)
destroy(this.gb_kousou)
destroy(this.gb_hakko)
end on

event openquery;call super::openquery;
// システム管理者権限を保有状況確認
i_admin	= kengen.of_check_admin( )

end event

event open;call super::open;
// 初期表示
of_dsp_reset()
//of_set_firstfocus( )

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
if not sle_mise_from.event input_check( ) then
	return -1
end if
if not sle_mise_to.event input_check( ) then
	return -1
end if
if not uo_unso.event sle_input_check( ) then
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

return 0

end event

event retrieve_event;call super::retrieve_event;
long	l_tokui_code
long	l_mise_from
long	l_mise_to
long	l_heiten_flg
long	l_unso_code
long	l_row

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= "表示"

dw_list.setredraw( false )

// 呼出部をロックする
of_dsp_edit( "callsection", false )

// 明細部
// 画面より条件を取得
l_tokui_code = long( trim( uo_tokui.of_get_input( ) ) )
l_mise_from = long( trim( sle_mise_from.text ) )
if isnull(l_mise_from) or trim( sle_mise_from.text ) = "" then
	l_mise_from = 0
end if
l_mise_to = long( trim( sle_mise_to.text ) )
if isnull(l_mise_to) or trim( sle_mise_to.text ) = "" then
	l_mise_to = 99999
end if
l_heiten_flg = 0
if cbx_heiten_flg.checked then
	l_heiten_flg = 1
end if
l_unso_code = long( trim( uo_unso.of_get_input( ) ) )
if trim( uo_unso.of_get_input( ) ) = "" then
	setnull(l_unso_code)
end if

// 明細
dw_list.reset()
dw_list.retrieve(l_tokui_code,l_mise_from,l_mise_to,l_heiten_flg,l_unso_code)

// 明細部
of_dsp_edit( "detailsection", true )

dw_list.setredraw( true )

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
long		l_count, l_row_count, l_tokui_code, l_mise_code
long		l_row
boolean	l_checked

// 入力チェック
l_checked = false
// 依頼元表示
if cbx_iraimotohyoji.checked then
	l_checked = true	
	// 20241121.ito依頼元表示は必須ではない
	/*
	if sle_iraimotohyoji.text = "" then
//		msg.of_error( sle_iraimotohyoji.tag + "は必須入力です。" )
		msg.of_error_sle(sle_iraimotohyoji, sle_iraimotohyoji.tag + "は必須入力です。")
		sle_iraimotohyoji.setfocus()
		return -1
	end if
	*/
end if
// EOS納品先
if cbx_eosnohinsaki.checked then
	l_checked = true
	if uo_eosnohinsaki.of_get_input() = "" then
//		msg.of_error( uo_eosnohinsaki.tag + "は必須入力です。" )
		msg.of_error_sle(uo_eosnohinsaki.sle_input, uo_eosnohinsaki.tag + "は必須入力です。")
		uo_eosnohinsaki.of_setfocus()
		return -1
	end if
end if
// 送り得意先
if cbx_okuritokuisaki.checked then
	l_checked = true
	if not uo_okuritokuisaki.event sle_input_check() then
		return -1
	end if
	/*
	if uo_okuritokuisaki.of_get_input() = "" then
//		msg.of_error( uo_okuritokuisaki.tag + "は必須入力です。" )
		msg.of_error_sle(uo_okuritokuisaki.sle_input, uo_okuritokuisaki.tag + "は必須入力です。")
		uo_okuritokuisaki.of_setfocus()
		return -1
	end if
	*/
end if
// 運送便
if cbx_unsobin.checked then
	l_checked = true
	if uo_unsobin.of_get_input() = "" then
//		msg.of_error( uo_unsobin.tag + "は必須入力です。" )
		msg.of_error_sle(uo_unsobin.sle_input, uo_unsobin.tag + "は必須入力です。")
		uo_unsobin.of_setfocus()
		return -1
	end if
end if
// リードタイム、日数計算
if cbx_leadtime.checked then
	l_checked = true
end if
// 配達指定日
if cbx_haitatusiteibi.checked then
	l_checked = true
end if
// 荷札備考
if cbx_nifudabikou.checked then
	l_checked = true
	/* 備考は消す動作も可とする
	if sle_nifudabikou.text = "" then
		msg.of_error( sle_nifudabikou.tag + "は必須入力です。" )
		sle_nifudabikou.setfocus()
		return -1
	end if
	*/
end if
// 荷送人
if cbx_niokurinin.checked then
	l_checked = true
	if uo_niokurinin.of_get_input() = "" then
//		msg.of_error( uo_niokurinin.tag + "は必須入力です。" )
		msg.of_error_sle(uo_niokurinin.sle_input, uo_niokurinin.tag + "は必須入力です。")
		uo_niokurinin.of_setfocus()
		return -1
	end if
end if
// 納品書、同送納品書、後送納品書
if cbx_nihonsyo.checked then
	l_checked = true
end if
// FAX送信、配信明細、レイアウト、配信方法
if cbx_faxsosin.checked then
	l_checked = true
end if
// FAX送信先
if cbx_faxsosinsaki.checked then
	l_checked = true
	if uo_faxsosinsaki.of_get_input() = "" then
//		msg.of_error( uo_faxsosinsaki.tag + "は必須入力です。" )
		msg.of_error_sle(uo_faxsosinsaki.sle_input, uo_faxsosinsaki.tag + "は必須入力です。")
		uo_faxsosinsaki.of_setfocus()
		return -1
	end if
end if

if l_checked = false then
	msg.of_error( "更新するデータが選択されていません。この処理は実行できません。" )
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
	msg.of_error( "更新するデータが選択されていません。この処理は実行できません。" )
	dw_list.setfocus()
	return -1
end if

// 2024.11.28ito　更新チェック実装
// 店M排他チェック
// 変数宣言
l_row_count = dw_list.rowcount()
for l_row = 1 to l_row_count
	if dw_list.GetItemString(l_row,"chkbox") = "0" then
		continue
	end if

	l_tokui_code = dw_list.GetItemDecimal(l_row,"tokui_code")
	l_mise_code = dw_list.GetItemDecimal(l_row,"mise_code")

string	l_kousin_user_id, l_kousin_client_id, l_kousin_pg_id
long l_haita_exists_flg

select nvl( mm.kousin_user_id, '???' ),
		  nvl( mm.kousin_client_id, '???' ),
		  nvl( mm.haita_flg, 0 )
  into :l_kousin_user_id,
		 :l_kousin_client_id,
		 :l_haita_exists_flg
  from m_mise mm
  where mm.tokui_code = :l_tokui_code
	 and mm.mise_code = :l_mise_code
//	for update nowait
using cocos;
choose case cocos.sqlcode
case 0
	if l_haita_exists_flg = 1 then
		rollback using cocos;
		// メッセージをof_record_lockの排他エラーと合わす、端末IDの方は全角コロン、ユーザーIDの方は半角コロン。
		msg.of_error( fnc.strg.of_format( "対象データは他の端末で変更中です。{1}（端末ID：{2} ユーザーID:{3}）", code.crlf, l_kousin_client_id, l_kousin_user_id ) )
		return -1
	end if		
case 100
	// 取得できなかった場合何もしない
case else
	rollback using cocos;
	msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
	return -1
end choose
next

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

/*
of_add_db_log( "update_event", 0, st_title.text +  "[" + &
string(i_tokui_code)  + " " + &
trim(string(uo_tokui.st_meisyo.text))+ " " + &
string(i_syohin_code) + " " + &
trim(string(uo_syohin_iro.st_meisyo.text)) + " " + &
trim(string(uo_syohin_iro.st_meisyo_hin_mei.text)) + " "+ &
"]" + i_syori_kbn )
*/

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

event key_f05;call super::key_f05;// Excel出力

string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "店一括変更_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )
if not dw_list.of_saveas_excel( l_file ) then
	return -1
end if

return 0

end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
end if

end event

type uo_signal from iw_main_window`uo_signal within wm_mise
end type

type st_date from iw_main_window`st_date within wm_mise
end type

type st_user_mei from iw_main_window`st_user_mei within wm_mise
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_mise
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_mise
end type

type st_title from iw_main_window`st_title within wm_mise
end type

type st_title_upper from iw_main_window`st_title_upper within wm_mise
end type

type st_upper from iw_main_window`st_upper within wm_mise
end type

type st_second_upper from iw_main_window`st_second_upper within wm_mise
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_mise
integer taborder = 190
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;// 初期状態
this.enabled	= true
end event

type rb_tuneni from ivo_radiobutton within wm_mise
string tag = "常に発行する"
integer x = 2908
integer y = 1212
integer width = 636
long backcolor = 553648127
string text = "常に発行する"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_tujyo from ivo_radiobutton within wm_mise
string tag = "通常"
integer x = 2604
integer y = 1212
integer width = 284
long backcolor = 553648127
string text = "通常"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_kousounohinsyo from ivo_statictext within wm_mise
string tag = "後送納品書"
integer x = 2180
integer y = 1212
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "後送納品書"
alignment alignment = right!
end type

type dw_list from ivo_datawindow within wm_mise
integer x = 32
integer y = 1529
integer width = 5000
integer height = 1301
integer taborder = 180
boolean bringtotop = true
string title = ""
string dataobject = "dm_mise"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f5_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }

dw_list.settransobject(cocos)
dw_list.reset()

end event

type uo_tokui from cv_input_tokui within wm_mise
event destroy ( )
integer x = 76
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean f4_key = false
boolean f12_key = true
boolean chk_required = true
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;
long l_tokui_code, li_ret, l_nohinsyo_hakkou_kbn
str_mtokui l_tokui[]

if ancestorreturnvalue = false then
	return false
end if

// 得意先CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	return false
else
	// エラーメッセージ(No2)
	if this.of_get_syusoku_flg() = 1 then
		msg.of_error_sle(this.sle_input, "得意先が終息の場合、この処理は実行できません。")
		this.of_setfocus()
		return false
	end if
end if

li_ret = mst.of_tokui_get_full( long(of_get_input( )), l_tokui)

// 結果を確認
if li_ret > 0 then
	l_nohinsyo_hakkou_kbn = l_tokui[1].nohinsyo_hakkou_kbn
else
end if

if l_nohinsyo_hakkou_kbn = 1 then
	rb_hakko_yes.checked = false
	rb_hakko_no.checked = true
else
	rb_hakko_yes.checked = true
	rb_hakko_no.checked = false
end if

return true

end event

event constructor;call super::constructor;
this.of_set_enabled( true )
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type uo_okuritokuisaki from cv_input_tokui within wm_mise
string tag = "送り得意先"
integer x = 668
integer y = 572
integer taborder = 70
boolean bringtotop = true
long backcolor = 67108864
boolean f4_key = false
boolean f6_key = true
boolean f12_key = true
string title_text = "送り得意先"
long title_width = 0
boolean bikou_visible = false
boolean syusoku_hyoji = false
end type

on uo_okuritokuisaki.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

// CD入力後の処理
if uo_okuritokuisaki.of_get_input() = "" then
//	msg.of_error( uo_okuritokuisaki.tag + "は必須入力です。" )
	msg.of_error_sle(this.sle_input, this.tag + "は必須入力です。")
	uo_okuritokuisaki.of_setfocus()
	return false
end if

if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	return true
else
	// エラーメッセージ(No14)
	if this.of_get_syusoku_flg() = 1 then
		msg.of_error_sle(this.sle_input, "終息の得意先は指定できません。")
		this.of_setfocus()
		return false
	end if

end if

return true

end event

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "参照", "", "", "", "" }

end event

event destructor;call super::destructor;call cv_input_tokui::destroy

end event

type rb_hakko_no from ivo_radiobutton within wm_mise
string tag = "上書き"
integer x = 1592
integer y = 1212
integer width = 548
long backcolor = 553648127
string text = "発行しない"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type rb_hakko_yes from ivo_radiobutton within wm_mise
string tag = "上書き"
integer x = 1112
integer y = 1212
integer width = 460
long backcolor = 553648127
string text = "発行する"
boolean checked = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_dosonohinsyo from ivo_statictext within wm_mise
string tag = "同送納品書"
integer x = 684
integer y = 1212
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "同送納品書"
end type

type st_mise from ivo_statictext within wm_mise
integer x = 76
integer y = 263
boolean bringtotop = true
long backcolor = 553648127
string text = "店"
alignment alignment = right!
end type

type sle_mise_from from ivo_singlelineedit within wm_mise
string tag = "登録日(開始日)"
integer x = 396
integer y = 263
integer width = 240
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
string text = "12345"
integer limit = 5
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_num = true
integer i_limit = 10
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.text				= "0"

end event

event key_f08;call super::key_f08;
str_mdlpara_mmise	l_mdl_mise
str_mmise			l_para_mise[]			// データの受け渡しをする構造体
str_mmise			l_para_reset[]			// i_mdl_mise.retの初期化用

if lena( trim( uo_tokui.of_get_input() ) ) > 0 then
	l_mdl_mise.in_tokui_code = long( trim( uo_tokui.of_get_input() ) )
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
end if

return true

end event

type st_mise_namidash from ivo_statictext within wm_mise
integer x = 652
integer y = 263
integer width = 152
integer height = 75
boolean bringtotop = true
long backcolor = 553648127
string text = "～"
alignment alignment = center!
end type

type sle_mise_to from ivo_singlelineedit within wm_mise
string tag = "登録日(終了日)"
integer x = 820
integer y = 263
integer width = 240
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
string text = "12345"
integer limit = 5
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf12_key = true
boolean chk_type_num = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }
this.text				= "99999"

end event

event key_f08;call super::key_f08;
str_mdlpara_mmise	l_mdl_mise
str_mmise			l_para_mise[]			// データの受け渡しをする構造体
str_mmise			l_para_reset[]			// i_mdl_mise.retの初期化用

if lena( trim( uo_tokui.of_get_input() ) ) > 0 then
	l_mdl_mise.in_tokui_code = long( trim( uo_tokui.of_get_input() ) )
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
end if

return true

end event

type cbx_heiten_flg from ivo_checkbox within wm_mise
string tag = "閉店を含む"
integer x = 1076
integer y = 263
integer width = 548
long backcolor = 553648127
string text = "閉店を含む"
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked	= false
end event

type uo_unso from cv_input_unso within wm_mise
event destroy ( )
integer x = 1640
integer y = 263
integer taborder = 40
boolean bringtotop = true
boolean f12_key = true
end type

on uo_unso.destroy
call cv_input_unso::destroy
end on

event constructor;call super::constructor;
this.of_set_enabled( true )
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

type uo_eosnohinsaki from cv_input_mise within wm_mise
string tag = "EOS納品先"
integer x = 668
integer y = 473
integer width = 2224
integer taborder = 60
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
string title_text = "EOS納品先"
long title_width = 0
long input_width = 228
boolean bikou_visible = false
end type

on uo_eosnohinsaki.destroy
call cv_input_mise::destroy
end on

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "参照", "", "", "", "" }

end event

event destructor;call super::destructor;call cv_input_mise::destroy

end event

event sle_input_check;call super::sle_input_check;if uo_eosnohinsaki.of_get_input() = "" then
//	msg.of_error( uo_eosnohinsaki.tag + "は必須入力です。" )
	msg.of_error_sle(uo_eosnohinsaki.sle_input, uo_eosnohinsaki.tag + "は必須入力です。")
	uo_eosnohinsaki.of_setfocus()
	return false
end if

return true
end event

type st_nissukeisan from ivo_statictext within wm_mise
integer x = 1248
integer y = 772
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "日数計算"
alignment alignment = right!
end type

type sle_iraimotohyoji from ivo_singlelineedit within wm_mise
string tag = "依頼元表示"
integer x = 684
integer y = 373
integer width = 1768
integer taborder = 50
boolean bringtotop = true
integer limit = 40
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }
this.text				= ""

end event

type cbx_iraimotohyoji from ivo_checkbox within wm_mise
string tag = "依頼元表示"
integer x = 32
integer y = 373
integer width = 636
long backcolor = 553648127
string text = "依頼元表示"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
sle_iraimotohyoji.enabled = l_checked
cbx_iraimotohyojisuru.enabled = l_checked
sle_iraimotohyoji.setfocus()

end event

type cbx_iraimotohyojisuru from ivo_checkbox within wm_mise
string tag = "表示する"
integer x = 2468
integer y = 373
integer width = 548
long backcolor = 553648127
string text = "表示する"
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type cbx_eosnohinsaki from ivo_checkbox within wm_mise
string tag = "依頼元表示"
integer x = 32
integer y = 473
integer width = 636
long backcolor = 553648127
string text = "EOS納品先"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.checked = false

end event

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
uo_eosnohinsaki.enabled = l_checked
uo_eosnohinsaki.of_setfocus()

end event

type cbx_okuritokuisaki from ivo_checkbox within wm_mise
string tag = "送り得意先"
integer x = 32
integer y = 572
integer width = 636
long backcolor = 553648127
string text = "送り得意先"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
uo_okuritokuisaki.enabled = l_checked
uo_okuritokuisaki.of_setfocus()

end event

type cbx_unsobin from ivo_checkbox within wm_mise
string tag = "運送便"
integer x = 32
integer y = 672
integer width = 636
long backcolor = 553648127
string text = "運送便"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
uo_unsobin.enabled = l_checked
uo_unsobin.of_setfocus()

end event

type uo_unsobin from cv_input_unso within wm_mise
event destroy ( )
string tag = "運送便"
integer x = 668
integer y = 672
integer taborder = 80
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
long title_width = 0
end type

on uo_unsobin.destroy
call cv_input_unso::destroy
end on

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "参照", "", "", "", "" }

end event

event sle_input_check;call super::sle_input_check;
if uo_unsobin.of_get_input() = "" then
//	msg.of_error( uo_unsobin.tag + "は必須入力です。" )
	msg.of_error_sle(uo_unsobin.sle_input, uo_unsobin.tag + "は必須入力です。")
	uo_unsobin.of_setfocus()
	return false
end if

return true

end event

type cbx_leadtime from ivo_checkbox within wm_mise
string tag = "リードタイム"
integer x = 32
integer y = 772
integer width = 636
long backcolor = 553648127
string text = "リードタイム"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
ddplb_leadtime.enabled = l_checked
ddplb_nissukeisan.enabled = l_checked
ddplb_leadtime.setfocus()

end event

type cbx_haitatusiteibi from ivo_checkbox within wm_mise
string tag = "配達指定日"
integer x = 32
integer y = 875
integer width = 636
long backcolor = 553648127
string text = "配達指定日"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
cbx_haitatusiteibihyoji.enabled = l_checked
ddplb_haitatusiteijikoku.enabled = l_checked
ddplb_haitatusiteijikoku.setfocus()

end event

type cbx_haitatusiteibihyoji from ivo_checkbox within wm_mise
string tag = "配達指定日表示"
integer x = 684
integer y = 875
integer width = 724
long backcolor = 553648127
string text = "配達指定日表示"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type cbx_nifudabikou from ivo_checkbox within wm_mise
string tag = "荷札備考"
integer x = 32
integer y = 974
integer width = 636
long backcolor = 553648127
string text = "荷札備考"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
sle_nifudabikou.enabled = l_checked
sle_nifudabikou.setfocus()

end event

type sle_nifudabikou from ivo_singlelineedit within wm_mise
string tag = "荷札備考"
integer x = 684
integer y = 974
integer width = 2648
integer taborder = 120
boolean bringtotop = true
integer limit = 128
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }
this.text				= ""

end event

type ddplb_leadtime from sv_ddplb_meisyo within wm_mise
string tag = "リードタイム"
integer x = 684
integer y = 772
integer width = 548
integer taborder = 90
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 154
string init_code = "1"
end type

type ddplb_nissukeisan from sv_ddplb_meisyo within wm_mise
string tag = "日数計算"
integer x = 1596
integer y = 772
integer width = 548
integer taborder = 100
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 155
string init_code = "1"
end type

type ddplb_haitatusiteijikoku from sv_ddplb_meisyo within wm_mise
string tag = "配達指定時刻"
integer x = 1892
integer y = 875
integer width = 548
integer height = 903
integer taborder = 110
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 182
string init_code = "1"
boolean enabled_null = true
end type

event constructor;call super::constructor;
//this.init_code = ''
//this.i_idx = 0
//this.
end event

type st_haitatusiteijikoku from ivo_statictext within wm_mise
integer x = 1424
integer y = 875
integer width = 452
boolean bringtotop = true
long backcolor = 553648127
string text = "配達指定時刻"
alignment alignment = right!
end type

type uo_niokurinin from cv_input_niokurinin within wm_mise
event destroy ( )
string tag = "荷送人"
integer x = 668
integer y = 1074
integer width = 2292
integer taborder = 130
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
boolean chk_required = true
string title_text = "荷送人"
long title_width = 0
long input_width = 208
long bikou_width = 0
end type

on uo_niokurinin.destroy
call cv_input_niokurinin::destroy
end on

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "参照", "", "", "", "" }

end event

event sle_input_check;call super::sle_input_check;
if uo_niokurinin.of_get_input() = "" then
//	msg.of_error( uo_niokurinin.tag + "は必須入力です。" )
	msg.of_error_sle(uo_niokurinin.sle_input, uo_niokurinin.tag + "は必須入力です。")
	uo_niokurinin.of_setfocus()
	return false
end if

return true
end event

type cbx_niokurinin from ivo_checkbox within wm_mise
string tag = "荷送人"
integer x = 32
integer y = 1074
integer width = 636
long backcolor = 553648127
string text = "荷送人"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
uo_niokurinin.enabled = l_checked
uo_niokurinin.of_setfocus()

end event

type cbx_nihonsyo from ivo_checkbox within wm_mise
string tag = "納品書"
integer x = 32
integer y = 1212
integer width = 636
long backcolor = 553648127
string text = "納品書"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
gb_hakko.enabled = l_checked
rb_hakko_yes.enabled = l_checked
rb_hakko_no.enabled = l_checked
gb_kousou.enabled = l_checked
rb_tujyo.enabled = l_checked
rb_tuneni.enabled = l_checked
gb_hakko.setfocus()

end event

type cbx_faxsosin from ivo_checkbox within wm_mise
string tag = "FAX返信"
integer x = 32
integer y = 1330
integer width = 636
long backcolor = 553648127
string text = "FAX返信"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
cbx_tyumon.enabled = l_checked
ddplb_haisinmeisai.enabled = l_checked
ddplb_layout.enabled = l_checked
ddplb_haisinhouhou.enabled = l_checked
ddplb_haisinmeisai.setfocus()

end event

type cbx_faxsosinsaki from ivo_checkbox within wm_mise
string tag = "FAX返信先"
integer x = 32
integer y = 1429
integer width = 636
long backcolor = 553648127
string text = "FAX返信先"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event clicked;call super::clicked;
// チェックに連動し項目を有効/無効にする
boolean	l_checked
l_checked = this.checked
uo_faxsosinsaki.enabled = l_checked
uo_faxsosinsaki.of_setfocus()

end event

type cbx_tyumon from ivo_checkbox within wm_mise
string tag = "注文受入確認書を返信する"
integer x = 684
integer y = 1330
integer width = 1164
long backcolor = 553648127
string text = "注文受入確認書を返信する"
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

type st_haisinmeisai from ivo_statictext within wm_mise
string tag = "配信明細"
integer x = 1864
integer y = 1330
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "配信明細"
alignment alignment = right!
end type

type ddplb_haisinmeisai from sv_ddplb_meisyo within wm_mise
string tag = "配信明細"
integer x = 2212
integer y = 1330
integer width = 548
integer taborder = 140
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 221
string init_code = "1"
end type

type st_layout from ivo_statictext within wm_mise
string tag = "レイアウト"
integer x = 2776
integer y = 1330
integer width = 392
boolean bringtotop = true
long backcolor = 553648127
string text = "レイアウト"
alignment alignment = right!
end type

type ddplb_layout from sv_ddplb_meisyo within wm_mise
string tag = "日数計算"
integer x = 3180
integer y = 1330
integer width = 548
integer taborder = 150
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 225
string init_code = "1"
end type

type st_haisinhouhou from ivo_statictext within wm_mise
string tag = "配信方法"
integer x = 3744
integer y = 1330
integer width = 332
boolean bringtotop = true
long backcolor = 553648127
string text = "配信方法"
alignment alignment = right!
end type

type ddplb_haisinhouhou from sv_ddplb_meisyo within wm_mise
string tag = "日数計算"
integer x = 4092
integer y = 1330
integer width = 548
integer height = 444
integer taborder = 160
boolean bringtotop = true
integer textsize = -11
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
integer meisyo_kbn = 222
string init_code = "1"
end type

type uo_faxsosinsaki from cv_input_mise within wm_mise
event destroy ( )
string tag = "FAX送信先"
integer x = 668
integer y = 1429
integer width = 2224
integer taborder = 170
boolean bringtotop = true
boolean f6_key = true
boolean f12_key = true
string title_text = "FAX送信先"
long title_width = 0
long input_width = 228
boolean bikou_visible = false
end type

on uo_faxsosinsaki.destroy
call cv_input_mise::destroy
end on

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

end event

event sle_input_check;call super::sle_input_check;if ancestorreturnvalue = false then
	return false
end if

long		l_tokui_code
long		l_mise_code
long		l_haisinhouhou
string	l_hensin_address, l_hensin_fax_no

if uo_faxsosinsaki.of_get_input() = "" then
//		msg.of_error( uo_faxsosinsaki.tag + "は必須入力です。" )
	msg.of_error_sle(uo_faxsosinsaki.sle_input, uo_faxsosinsaki.tag + "は必須入力です。")
	uo_faxsosinsaki.of_setfocus()
	return false
end if

// CD入力後の処理
if trim( of_get_input( ) ) = "" then
	// 空にされた場合は初期化
	st_faxno.event constructor( )
	return false
else
	// 配信方法
	l_haisinhouhou = this.i_para_mise[1].haisin_houhou		// 1:FAX 2:email 3:i-FAX 4:印刷 5:PDF
	// 配列にはセットされていないため、自身で取得する
	l_tokui_code = this.i_para_mise[1].tokui_code
	l_mise_code = this.i_para_mise[1].mise_code
	// 配信方法
	select	haisin_houhou
	,			hensin_address
	,			hensin_fax_no
	into		:l_haisinhouhou
	,			:l_hensin_address
	,			:l_hensin_fax_no
	from		m_mise
	where		m_mise.tokui_code			= :l_tokui_code
	and		m_mise.mise_code			= :l_mise_code
	using		cocos;
	
	choose case cocos.sqlcode
		case 0

		case 100
			// データが無い場合は初期化
			l_haisinhouhou = 0

		case else
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			this.of_setfocus()
			return false
	end choose

	st_faxno.event constructor( )
	st_faxno.tag = string(l_haisinhouhou)		// 配信方法を記憶する
	choose case l_haisinhouhou
		case 1
//			st_faxno.text = this.of_get_fax_no()
			st_faxno.text = trim(l_hensin_fax_no)
			// エラーメッセージ(No13)
			if st_faxno.text = "" or isnull(st_faxno.text)  then
				msg.of_error_sle(this.sle_input, "FAX番号／メールアドレスが未登録です。")
				this.of_setfocus()
				return false
			end if
		case 2
			// st_faxno.text = this.i_para_mise[1].hensin_address
			st_faxno.text =  trim(l_hensin_address)
			// エラーメッセージ(No13)
			if st_faxno.text = ""  or isnull(st_faxno.text) then
				msg.of_error_sle(this.sle_input, "FAX番号／メールアドレスが未登録です。")
				this.of_setfocus()
				return false
			end if
	end choose

end if

return true

end event

type st_faxno from sv_st_meisyo within wm_mise
string tag = "配送方法"
integer x = 2908
integer y = 1429
integer width = 1768
integer height = 89
boolean bringtotop = true
boolean enabled = false
string text = "FAX番号"
boolean f3_key = true
end type

event constructor;call super::constructor;
// 初期状態
this.text	= ""

end event

type gb_kousou from ivo_groupbox within wm_mise
string tag = "後送納品書"
integer x = 2584
integer y = 1173
integer width = 976
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

type gb_hakko from ivo_groupbox within wm_mise
string tag = "同送納品書"
integer x = 1092
integer y = 1173
integer width = 1072
integer height = 139
boolean bringtotop = false
long backcolor = 553648127
string text = ""
boolean f12_key = true
end type

