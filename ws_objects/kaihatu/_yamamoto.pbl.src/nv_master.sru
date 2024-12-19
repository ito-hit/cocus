$PBExportHeader$nv_master.sru
$PBExportComments$マスタ関連共通関数（チェック／取得）
forward
global type nv_master from inv_object
end type
type lstr_mmeisyo1 from structure within nv_master
end type
end forward

type lstr_mmeisyo1 from structure
	string		aaa
end type

global type nv_master from inv_object autoinstantiate
end type

type prototypes

end prototypes

type variables

end variables

forward prototypes
private function boolean create_syntax (ref datastore p_ds, string p_sql)
public function integer of_meisyo_check (integer p_meisyo_kbn)
public function integer of_meisyo_check (integer p_meisyo_kbn, string p_meisyo_code)
public function integer of_meisyo_get (integer p_meisyo_kbn, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get2 (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get_full (integer p_meisyo_kbn, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get_full (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[])
public function integer of_menu_check (string p_menu_id)
public function integer of_menu_check (string p_menu_id, string p_tab_id)
public function integer of_menu_checkw (string p_window_id)
public function integer of_mise_check (long p_tokui_code)
public function integer of_mise_check (long p_tokui_code, long p_mise_code)
public function integer of_mise_get (long p_tokui_code, ref str_mmise p_recs[])
public function integer of_mise_get (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[])
public function integer of_mise_get_full (long p_tokui_code, ref str_mmise p_recs[])
public function integer of_mise_get_full (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[])
public function integer of_tanto_check (long p_tanto_code)
public function integer of_tokui_check (long p_tokui_code)
public function integer of_menu_get (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[])
public function integer of_menu_getw (string p_window_id, ref str_mmenu p_recs[])
public function integer of_menu_get_full (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[])
public function integer of_menu_getw_full (string p_window_id, ref str_mmenu p_recs[])
public function integer of_menu_get_full (string p_menu_id, ref str_mmenu p_recs[])
public function integer of_menu_get (string p_menu_id, ref str_mmenu p_recs[])
public function integer of_tanto_get (long p_tanto_code, ref str_mtanto p_recs[])
public function integer of_tanto_get_full (long p_tanto_code, ref str_mtanto p_recs[])
public function integer of_tokui_get (long p_tokui_code, ref str_mtokui p_recs[])
public function integer of_tokui_get_full (long p_tokui_code, ref str_mtokui p_recs[])
public function integer of_kyoten_check (long p_kyoten_code)
public function integer of_kyoten_get (long p_kyoten_code, ref str_mkyoten p_recs[])
public function integer of_kyoten_get_full (long p_kyoten_code, ref str_mkyoten p_recs[])
public function integer of_kyoten_group_check (long p_kyoten_group_code)
public function integer of_kyoten_group_get_full (long p_kyoten_group_code, ref str_mkyoten_group p_recs[])
public function integer of_kyoten_group_get (long p_kyoten_group_code, ref str_mkyoten_group p_recs[])
public function integer of_kihon_check (long p_kanri_code)
public function integer of_kihon_get (long p_kanri_code, ref str_mkihon p_recs[])
public function integer of_kihon_get_full (long p_kanri_code, ref str_mkihon p_recs[])
public function integer of_user_check (string p_user_id)
public function integer of_user_get (string p_user_id, ref str_muser p_recs[])
public function integer of_user_get_full (string p_user_id, ref str_muser p_recs[])
public function integer of_yubin_check (string p_yubin_no)
public function integer of_yubin_get (string p_yubin_no, ref str_myubin p_recs[])
public function integer of_nendo_check (long p_nendo_code)
public function integer of_nendo_get (long p_nendo_code, ref str_mnendo p_recs[])
public function integer of_nendo_get_full (long p_nendo_code, ref str_mnendo p_recs[])
public function integer of_syohin_check (long p_syohin_code, long p_iro_no)
public function integer of_syohin_check (long p_syohin_code)
public function integer of_syohin_get (long p_syohin_code, long p_iro_no, ref str_msyohin p_recs[])
public function integer of_syohin_get (long p_syohin_code, ref str_msyohin p_recs[])
public function integer of_syohin_get_full (long p_syohin_code, ref str_msyohin p_recs[])
public function integer of_syohin_get_full (long p_syohin_code, long p_iro_no, ref str_msyohin p_recs[])
public function integer of_tanka_check (long p_tokui_code, long p_syohin_code)
public function integer of_tanka_get_full (long p_tokui_code, long p_syohin_code, ref str_mtanka p_recs[])
public function integer of_tanka_get (long p_tokui_code, long p_syohin_code, ref str_mtanka p_recs[])
public function integer of_unso_check (long p_unso_code)
public function integer of_unso_get_full (long p_unso_code, ref str_munso p_recs[])
public function integer of_unso_get (long p_unso_code, ref str_munso p_recs[])
public function integer of_syohin_check (long p_syohin_code, long p_iro_no, string p_size_code)
public function integer of_syohin_get (long p_syohin_code, long p_iro_no, string p_size_code, ref str_msyohin p_recs[])
public function integer of_syohin_get_full (long p_syohin_code, long p_iro_no, string p_size_code, ref str_msyohin p_recs[])
public function integer of_tokui_checks (long p_seikyu_code)
public function integer of_tokui_gets (long p_seikyu_code, ref str_mtokui p_recs[])
public function integer of_tokui_gets_full (long p_seikyu_code, ref str_mtokui p_recs[])
public function integer of_bunrui_check (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code)
public function integer of_bunrui_check (long p_daibunrui_code, long p_tyubunrui_code)
public function integer of_bunrui_check (long p_daibunrui_code)
public function integer of_bunrui_get_full (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_get_full (long p_daibunrui_code, long p_tyubunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_get_full (long p_daibunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_get (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_get (long p_daibunrui_code, long p_tyubunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_get (long p_daibunrui_code, ref str_mbunrui p_recs[])
public function integer of_bukken_check (long p_bukken_code)
public function integer of_bukken_get_full (long p_bukken_code, ref str_mbukken p_recs[])
public function integer of_bukken_get (long p_bukken_code, ref str_mbukken p_recs[])
public function integer of_group_check (long p_group_code)
public function integer of_group_get_full (long p_group_code, ref str_mgroup p_recs[])
public function integer of_group_get (long p_group_code, ref str_mgroup p_recs[])
public function integer of_brand_check (long p_brand_code)
public function integer of_brand_get_full (long p_brand_code, ref str_mbrand p_recs[])
public function integer of_brand_get (long p_brand_code, ref str_mbrand p_recs[])
public function integer of_niokurinin_check (long p_niokurinin_code)
public function integer of_niokurinin_get (long p_niokurinin_code, ref str_mniokurinin p_recs[])
public function integer of_niokurinin_get_full (long p_niokurinin_code, ref str_mniokurinin p_recs[])
public function integer of_yubin_get_full (string p_yubin_no, ref str_myubin p_recs[])
public function integer of_bunrui_gett (long p_tyubunrui_code, ref str_mbunrui p_recs[])
public function integer of_bunrui_gets (long p_syobunrui_code, ref str_mbunrui p_recs[])
public function integer of_tokui_checkn (long p_nayose_code)
public function integer of_tokui_getn (long p_nayose_code, ref str_mtokui p_recs[])
public function integer of_tokui_getn_full (long p_nayose_code, ref str_mtokui p_recs[])
public function integer of_untin_kijyun_check (string p_kijyun_code)
public function integer of_untin_kijyun_get_full (string p_kijyun_code, ref str_muntin_kijyun p_recs[])
public function integer of_untin_kijyun_get (string p_kijyun_code, ref str_muntin_kijyun p_recs[])
public function integer of_gtin_kanri_check (string p_jigyosya_code)
public function integer of_gtin_kanri_get (string p_jigyosya_code, ref str_mgtin_kanri p_recs[])
public function integer of_gtin_kanri_get_full (string p_jigyosya_code, ref str_mgtin_kanri p_recs[])
public function integer of_kamoku_check (long p_kamoku_code, long p_hojyo_kamoku_code)
public function integer of_kamoku_check (long p_kamoku_code)
public function integer of_kamoku_get_full (long p_kamoku_code, long p_hojyo_kamoku_code, ref str_mkamoku p_recs[])
public function integer of_kamoku_get_full (long p_kamoku_code, ref str_mkamoku p_recs[])
public function integer of_kamoku_get (long p_kamoku_code, long p_hojyo_kamoku_code, ref str_mkamoku p_recs[])
public function integer of_kamoku_get (long p_kamoku_code, ref str_mkamoku p_recs[])
public function integer of_tyakuten_check (integer p_unso_code, string p_yubin_no, string p_tyakuten_code)
public function integer of_tyakuten_check (integer p_unso_code, string p_yubin_no)
public function integer of_tyakuten_check (integer p_unso_code)
public function integer of_tyakuten_get_full (integer p_unso_code, string p_yubin_no, string p_tyakuten_code, ref str_mtyakuten p_recs[])
public function integer of_tyakuten_get_full (integer p_unso_code, string p_yubin_no, ref str_mtyakuten p_recs[])
public function integer of_tyakuten_get_full (integer p_unso_code, ref str_mtyakuten p_recs[])
public function integer of_tyakuten_get (integer p_unso_code, string p_yubin_no, string p_tyakuten_code, ref str_mtyakuten p_recs[])
public function integer of_tyakuten_get (integer p_unso_code, string p_yubin_no, ref str_mtyakuten p_recs[])
public function integer of_tyakuten_get (integer p_unso_code, ref str_mtyakuten p_recs[])
public function integer of_mymenu_check (string p_user_id)
public function integer of_mymenu_get_full (string p_user_id, ref str_mmymenu p_recs[])
public function integer of_mymenu_get (string p_user_id, ref str_mmymenu p_recs[])
public function integer of_zeiritu_check (integer p_torihiki_kbn, integer p_zeiritu_kbn)
public function integer of_zeiritu_get_full (integer p_torihiki_kbn, integer p_zeiritu_kbn, ref str_mzeiritu p_recs[])
public function integer of_zeiritu_get (integer p_torihiki_kbn, integer p_zeiritu_kbn, ref str_mzeiritu p_recs[])
public function integer of_syozoku_check (long p_tanto_code, long p_nengetu)
public function integer of_syozoku_get_full (long p_tanto_code, long p_nengetu, ref str_msyozoku p_recs[])
public function integer of_syozoku_get (long p_tanto_code, long p_nengetu, ref str_msyozoku p_recs[])
public function integer of_tokui_tanto_check (long p_tokui_code, long p_nengetu)
public function integer of_tokui_tanto_get_full (long p_tokui_code, long p_nengetu, ref str_mtokui_tanto p_recs[])
public function integer of_tokui_tanto_get (long p_tokui_code, long p_nengetu, ref str_mtokui_tanto p_recs[])
public function integer of_tokui_atesaki_check (long p_tokui_code, integer p_atesaki_kbn)
public function integer of_tokui_atesaki_get_full (long p_tokui_code, integer p_atesaki_kbn, ref str_mtokui_atesaki p_recs[])
public function integer of_tokui_atesaki_get (long p_tokui_code, integer p_atesaki_kbn, ref str_mtokui_atesaki p_recs[])
public function integer of_kakeritu_check (long p_tokui_code, integer p_kakaku_group_kbn)
public function integer of_kakeritu_get_full (long p_tokui_code, integer p_kakaku_group_kbn, ref str_mkakeritu p_recs[])
public function integer of_kakeritu_get (long p_tokui_code, integer p_kakaku_group_kbn, ref str_mkakeritu p_recs[])
public function integer of_gtin_check (string p_gtin_code)
public function integer of_gtin_get_full (string p_gtin_code, ref str_mgtin p_recs[])
public function integer of_gtin_get (string p_gtin_code, ref str_mgtin p_recs[])
public function integer of_aite_hinban_check (long p_tokui_code, longlong p_sku_code)
public function integer of_aite_hinban_get_full (long p_tokui_code, longlong p_sku_code, ref str_maite_hinban p_recs[])
public function integer of_aite_hinban_get (long p_tokui_code, longlong p_sku_code, ref str_maite_hinban p_recs[])
public function integer of_untin_get_full (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn, ref str_muntin p_recs[])
public function integer of_untin_check (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn)
public function integer of_untin_get (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn, ref str_muntin p_recs[])
public function integer of_tokui_syohin_check (long p_syohin_code, long p_iro_no, long p_tokui_code)
public function integer of_tokui_syohin_get_full (long p_syohin_code, long p_iro_no, long p_tokui_code, ref str_mtokui_syohin p_recs[])
public function integer of_tokui_syohin_get (long p_syohin_code, long p_iro_no, long p_tokui_code, ref str_mtokui_syohin p_recs[])
public function integer of_calendar_check (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke)
public function integer of_calendar_get_full (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke, ref str_mcalendar p_recs[])
public function integer of_calendar_get (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke, ref str_mcalendar p_recs[])
public function integer of_tyohyo_printer_check (string p_tyohyo_id, string p_client_id)
public function integer of_tyohyo_printer_get_full (string p_tyohyo_id, string p_client_id, ref str_mtyohyo_printer p_recs[])
public function integer of_tyohyo_printer_get (string p_tyohyo_id, string p_client_id, ref str_mtyohyo_printer p_recs[])
public function integer of_senden_kanri_check (long p_tokui_code)
public function integer of_senden_kanri_get_full (long p_tokui_code, ref str_msenden_kanri p_recs[])
public function integer of_senden_kanri_get (long p_tokui_code, ref str_msenden_kanri p_recs[])
public function integer of_senden_tyohyo_check (string p_tyohyo_id)
public function integer of_senden_tyohyo_get_full (string p_tyohyo_id, ref str_msenden_tyohyo p_recs[])
public function integer of_senden_tyohyo_get (string p_tyohyo_id, ref str_msenden_tyohyo p_recs[])
public function integer of_kojyo_check (long p_kojyo_code, integer p_bumon_code)
public function integer of_kojyo_check (long p_kojyo_code)
public function integer of_kojyo_get (long p_kojyo_code, integer p_bumon_code, ref str_symkojyo p_recs[])
public function integer of_kojyo_get (long p_kojyo_code, ref str_symkojyo p_recs[])
end prototypes

private function boolean create_syntax (ref datastore p_ds, string p_sql);
string	l_syntax
string	l_err

l_syntax	= cocos.syntaxfromsql( p_sql, "style(type=form)", l_err )

if len( l_err ) > 0 then
	 msg.of_error( l_err )
	 return false
else
	p_ds.create( l_syntax, l_err )

	if len( l_err ) > 0 then
		msg.of_error( l_err )
		return false
	end if
end if

p_ds.settransobject( cocos )

return true
end function

public function integer of_meisyo_check (integer p_meisyo_kbn);
string	l_meisyo_code

setnull( l_meisyo_code )

return of_meisyo_check( p_meisyo_kbn, l_meisyo_code )

end function

public function integer of_meisyo_check (integer p_meisyo_kbn, string p_meisyo_code);
integer	l_ret

declare orafunc procedure for mmeisyo.chk( :p_meisyo_kbn, :p_meisyo_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_meisyo_get (integer p_meisyo_kbn, ref str_mmeisyo p_recs[]);
string	l_meisyo_code

setnull( l_meisyo_code )

return of_meisyo_get( p_meisyo_kbn, l_meisyo_code, p_recs )
end function

public function integer of_meisyo_get (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[]);
integer		l_cnt
str_mmeisyo	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select meisyo_kbn,meisyo_mei," )
fnc.strg.of_append_line( l_sql, "       meisyo_code," )
fnc.strg.of_append_line( l_sql, "       meisyo_1,meisyo_2,meisyo_3" )

// 名称コードが未設定の場合は条件に加えない
if isnull( p_meisyo_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmeisyo.get( {1} ) )", string( p_meisyo_kbn ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmeisyo.get( {1}, '{2}' ) )", string( p_meisyo_kbn ), p_meisyo_code ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].meisyo_kbn	= l_ds.object.meisyo_kbn[l_cnt]
			l_recs[l_cnt].meisyo_mei	= l_ds.object.meisyo_mei[l_cnt]
			l_recs[l_cnt].meisyo_code	= l_ds.object.meisyo_code[l_cnt]
			l_recs[l_cnt].meisyo_1		= l_ds.object.meisyo_1[l_cnt]
			l_recs[l_cnt].meisyo_2		= l_ds.object.meisyo_2[l_cnt]
			l_recs[l_cnt].meisyo_3		= l_ds.object.meisyo_3[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_meisyo_get2 (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[]);
integer		l_cnt
str_mmeisyo	l_rec, l_rec_null

declare cur cursor for
	select meisyo_kbn,meisyo_mei,
		   meisyo_code,
		   meisyo_1,meisyo_2,meisyo_3
	  from table( meisyo.get( :p_meisyo_kbn, :p_meisyo_code ) )
using cocos;

open cur;
if cocos.sqlcode <> 0 then
	msg.of_error_db( "名称取得関数(of_meisyo_get)の実行(open)でエラーが発生しました。", cocos )
	return -1
else
	do until cocos.sqlcode <> 0
		fetch cur into :l_rec.meisyo_kbn,:l_rec.meisyo_mei,
					   :l_rec.meisyo_code,
					   :l_rec.meisyo_1,:l_rec.meisyo_2,:l_rec.meisyo_3;

		choose case cocos.sqlcode
			case 0
				p_recs[upperbound( p_recs )+1]	= l_rec
				l_rec							= l_rec_null

				l_cnt	= l_cnt + 1
			case 100
			case else
				msg.of_error_db( "名称取得関数(of_meisyo_get)の実行(fetch)でエラーが発生しました。", cocos )
				l_cnt	= -1
		end choose
	loop
end if

close cur;

return l_cnt
end function

public function integer of_meisyo_get_full (integer p_meisyo_kbn, ref str_mmeisyo p_recs[]);
string	l_meisyo_code

setnull( l_meisyo_code )

return of_meisyo_get_full( p_meisyo_kbn, l_meisyo_code, p_recs[] )
end function

public function integer of_meisyo_get_full (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[]);
integer		l_cnt
str_mmeisyo	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select meisyo_kbn,meisyo_mei," )
fnc.strg.of_append_line( l_sql, "       meisyo_code," )
fnc.strg.of_append_line( l_sql, "       meisyo_code," )
fnc.strg.of_append_line( l_sql, "       meisyo_1,meisyo_2,meisyo_3," )
fnc.strg.of_append_line( l_sql, "       setumei," )
fnc.strg.of_append_line( l_sql, "       code_ketasu," )
fnc.strg.of_append_line( l_sql, "       code_zokusei_flg," )
fnc.strg.of_append_line( l_sql, "       kousin_kengen," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 名称コードが未設定の場合は条件に加えない
if isnull( p_meisyo_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmeisyo.get_full( {1} ) )", string( p_meisyo_kbn ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmeisyo.get_full( {1}, '{2}' ) )", string( p_meisyo_kbn ), p_meisyo_code ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].meisyo_kbn		= l_ds.object.meisyo_kbn[l_cnt]
			l_recs[l_cnt].meisyo_mei		= l_ds.object.meisyo_mei[l_cnt]
			l_recs[l_cnt].meisyo_code		= l_ds.object.meisyo_code[l_cnt]
			l_recs[l_cnt].meisyo_1			= l_ds.object.meisyo_1[l_cnt]
			l_recs[l_cnt].meisyo_2			= l_ds.object.meisyo_2[l_cnt]
			l_recs[l_cnt].meisyo_3			= l_ds.object.meisyo_3[l_cnt]
			l_recs[l_cnt].setumei			= l_ds.object.setumei[l_cnt]
			l_recs[l_cnt].code_ketasu		= l_ds.object.code_ketasu[l_cnt]
			l_recs[l_cnt].code_zokusei_flg	= l_ds.object.code_zokusei_flg[l_cnt]
			l_recs[l_cnt].kousin_kengen		= l_ds.object.kousin_kengen[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt

end function

public function integer of_menu_check (string p_menu_id);
string	l_tab_id

setnull( l_tab_id )

return of_menu_check( p_menu_id, l_tab_id )

end function

public function integer of_menu_check (string p_menu_id, string p_tab_id);
integer	l_ret

declare orafunc procedure for mmenu.chk( :p_menu_id, :p_tab_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_menu_checkw (string p_window_id);
integer	l_ret

declare orafunc procedure for mmenu.chkw( :p_window_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	msg.of_error( cocos.sqlerrtext )
	return 0
end if

return l_ret

end function

public function integer of_mise_check (long p_tokui_code);
long	l_mise_code

setnull( l_mise_code )

return of_mise_check( p_tokui_code, l_mise_code )

end function

public function integer of_mise_check (long p_tokui_code, long p_mise_code);
integer	l_ret

declare orafunc procedure for mmise.chk( :p_tokui_code, :p_mise_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_mise_get (long p_tokui_code, ref str_mmise p_recs[]);
long	l_mise_code

setnull( l_mise_code )

return of_mise_get( p_tokui_code, l_mise_code, p_recs )

end function

public function integer of_mise_get (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[]);
integer		l_cnt
str_mmise	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code,mise_code," )
fnc.strg.of_append_line( l_sql, "       mise_kbn," )
fnc.strg.of_append_line( l_sql, "       mise_mei_full,mise_mei,mise_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       heiten_flg," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo1,jyusyo2,jyusyo3," )
fnc.strg.of_append_line( l_sql, "       okuri_mei1,okuri_mei2," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       okuri_tokui_code,okuri_mise_code,okuri_center_code" )

// 名称コードが未設定の場合は条件に加えない
if isnull( p_mise_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmise.get( {1} ) )", string( p_tokui_code ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmise.get( {1}, {2} ) )", string( p_tokui_code ), string( p_mise_code ) ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].mise_code			= l_ds.object.mise_code[l_cnt]
			l_recs[l_cnt].mise_kbn			= l_ds.object.mise_kbn[l_cnt]
			l_recs[l_cnt].mise_mei_full		= l_ds.object.mise_mei_full[l_cnt]
			l_recs[l_cnt].mise_mei			= l_ds.object.mise_mei[l_cnt]
			l_recs[l_cnt].mise_mei_ryaku	= l_ds.object.mise_mei_ryaku[l_cnt]
			l_recs[l_cnt].heiten_flg		= l_ds.object.heiten_flg[l_cnt]
			l_recs[l_cnt].syusoku_flg		= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].todofuken_code	= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code	= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo1			= l_ds.object.jyusyo1[l_cnt]
			l_recs[l_cnt].jyusyo2			= l_ds.object.jyusyo2[l_cnt]
			l_recs[l_cnt].jyusyo3			= l_ds.object.jyusyo3[l_cnt]
			l_recs[l_cnt].okuri_mei1		= l_ds.object.okuri_mei1[l_cnt]
			l_recs[l_cnt].okuri_mei2		= l_ds.object.okuri_mei2[l_cnt]
			l_recs[l_cnt].tel_no			= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no			= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].okuri_tokui_code	= l_ds.object.okuri_tokui_code[l_cnt]
			l_recs[l_cnt].okuri_mise_code	= l_ds.object.okuri_mise_code[l_cnt]
			l_recs[l_cnt].okuri_center_code	= l_ds.object.okuri_center_code[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_mise_get_full (long p_tokui_code, ref str_mmise p_recs[]);
long	l_mise_code

setnull( l_mise_code )

return of_mise_get_full( p_tokui_code, l_mise_code, p_recs )

end function

public function integer of_mise_get_full (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[]);
integer		l_cnt
str_mmise	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code,mise_code," )
fnc.strg.of_append_line( l_sql, "       mise_kbn," )
fnc.strg.of_append_line( l_sql, "       mise_mei_full,mise_mei,mise_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       mise_mei_label,mise_mei_kana," )
fnc.strg.of_append_line( l_sql, "       heiten_flg," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo1,jyusyo2,jyusyo3," )
fnc.strg.of_append_line( l_sql, "       okuri_mei1,okuri_mei2," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       hensin_flg," )
fnc.strg.of_append_line( l_sql, "       meisai_kbn," )
fnc.strg.of_append_line( l_sql, "       layout_kbn," )
fnc.strg.of_append_line( l_sql, "       haisin_houhou,hensin_fax_no,hensin_address,hensin_mise_code," )
fnc.strg.of_append_line( l_sql, "       nohinsyo_hakkou_kbn,nohinsyo_kingaku_flg,nohinsyo_kousou_kbn," )
fnc.strg.of_append_line( l_sql, "       iraimoto_flg,iraimoto_mei," )
fnc.strg.of_append_line( l_sql, "       aite_kaisya_code,aite_mise_code," )
fnc.strg.of_append_line( l_sql, "       okuri_tokui_code,okuri_mise_code,okuri_center_code," )
fnc.strg.of_append_line( l_sql, "       syukka_kyoten_sitei_kbn,syukka_kyoten_code," )
fnc.strg.of_append_line( l_sql, "       uriage_tokui_code" )
fnc.strg.of_append_line( l_sql, "       unso_code,tyakuten_code,tyakuten_tome_flg," )
fnc.strg.of_append_line( l_sql, "       kobetu_haiso_flg," )
fnc.strg.of_append_line( l_sql, "       leadtime_kbn,leadtime_keisan_kbn," )
fnc.strg.of_append_line( l_sql, "       nouhinbi_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       haitatu_sitei_flg,haitatu_sitei_jikoku," )
fnc.strg.of_append_line( l_sql, "       nifuda_bikou,niokurinin_code,untin_seikyu_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 名称コードが未設定の場合は条件に加えない
if isnull( p_mise_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmise.get_full( {1} ) )", string( p_tokui_code ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmise.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_mise_code ) ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].mise_code					= l_ds.object.mise_code[l_cnt]
			l_recs[l_cnt].mise_kbn					= l_ds.object.mise_kbn[l_cnt]
			l_recs[l_cnt].mise_mei_full				= l_ds.object.mise_mei_full[l_cnt]
			l_recs[l_cnt].mise_mei					= l_ds.object.mise_mei[l_cnt]
			l_recs[l_cnt].mise_mei_ryaku			= l_ds.object.mise_mei_ryaku[l_cnt]
			l_recs[l_cnt].mise_mei_label			= l_ds.object.mise_mei_label[l_cnt]
			l_recs[l_cnt].mise_mei_kana				= l_ds.object.mise_mei_kana[l_cnt]
			l_recs[l_cnt].heiten_flg				= l_ds.object.heiten_flg[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].todofuken_code			= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code			= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo1					= l_ds.object.jyusyo1[l_cnt]
			l_recs[l_cnt].jyusyo2					= l_ds.object.jyusyo2[l_cnt]
			l_recs[l_cnt].jyusyo3					= l_ds.object.jyusyo3[l_cnt]
			l_recs[l_cnt].okuri_mei1				= l_ds.object.okuri_mei1[l_cnt]
			l_recs[l_cnt].okuri_mei2				= l_ds.object.okuri_mei2[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].hensin_flg				= l_ds.object.hensin_flg[l_cnt]
			l_recs[l_cnt].meisai_kbn				= l_ds.object.meisai_kbn[l_cnt]
			l_recs[l_cnt].layout_kbn				= l_ds.object.layout_kbn[l_cnt]
			l_recs[l_cnt].haisin_houhou				= l_ds.object.haisin_houhou[l_cnt]
			l_recs[l_cnt].hensin_fax_no				= l_ds.object.hensin_fax_no[l_cnt]
			l_recs[l_cnt].hensin_address			= l_ds.object.hensin_address[l_cnt]
			l_recs[l_cnt].hensin_mise_code			= l_ds.object.hensin_mise_code[l_cnt]
			l_recs[l_cnt].nohinsyo_hakkou_kbn		= l_ds.object.nohinsyo_hakkou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kingaku_flg		= l_ds.object.nohinsyo_kingaku_flg[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_kbn		= l_ds.object.nohinsyo_kousou_kbn[l_cnt]
			l_recs[l_cnt].iraimoto_flg				= l_ds.object.iraimoto_flg[l_cnt]
			l_recs[l_cnt].iraimoto_mei				= l_ds.object.iraimoto_mei[l_cnt]
			l_recs[l_cnt].aite_kaisya_code			= l_ds.object.aite_kaisya_code[l_cnt]
			l_recs[l_cnt].aite_mise_code			= l_ds.object.aite_mise_code[l_cnt]
			l_recs[l_cnt].okuri_tokui_code			= l_ds.object.okuri_tokui_code[l_cnt]
			l_recs[l_cnt].okuri_mise_code			= l_ds.object.okuri_mise_code[l_cnt]
			l_recs[l_cnt].okuri_center_code			= l_ds.object.okuri_center_code[l_cnt]
			l_recs[l_cnt].syukka_kyoten_sitei_kbn	= l_ds.object.syukka_kyoten_sitei_kbn[l_cnt]
			l_recs[l_cnt].syukka_kyoten_code		= l_ds.object.syukka_kyoten_code[l_cnt]
			l_recs[l_cnt].uriage_tokui_code			= l_ds.object.uriage_tokui_code[l_cnt]
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].tyakuten_code				= l_ds.object.tyakuten_code[l_cnt]
			l_recs[l_cnt].tyakuten_tome_flg			= l_ds.object.tyakuten_tome_flg[l_cnt]
			l_recs[l_cnt].kobetu_haiso_flg			= l_ds.object.kobetu_haiso_flg[l_cnt]
			l_recs[l_cnt].leadtime_kbn				= l_ds.object.leadtime_kbn[l_cnt]
			l_recs[l_cnt].leadtime_keisan_kbn		= l_ds.object.leadtime_keisan_kbn[l_cnt]
			l_recs[l_cnt].nouhinbi_hyoji_flg		= l_ds.object.nouhinbi_hyoji_flg[l_cnt]
			l_recs[l_cnt].haitatu_sitei_flg			= l_ds.object.haitatu_sitei_flg[l_cnt]
			l_recs[l_cnt].haitatu_sitei_jikoku		= l_ds.object.haitatu_sitei_jikoku[l_cnt]
			l_recs[l_cnt].nifuda_bikou				= l_ds.object.nifuda_bikou[l_cnt]
			l_recs[l_cnt].niokurinin_code			= l_ds.object.niokurinin_code[l_cnt]
			l_recs[l_cnt].untin_seikyu_flg			= l_ds.object.untin_seikyu_flg[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tanto_check (long p_tanto_code);
integer	l_ret

declare orafunc procedure for mtanto.chk( :p_tanto_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_tokui_check (long p_tokui_code);
integer	l_ret

declare orafunc procedure for mtokui.chk( :p_tokui_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_menu_get (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[]);
integer		l_cnt
str_mmenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select menu_id,tab_id," )
fnc.strg.of_append_line( l_sql, "       button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       siyo_kanou_flg," )
fnc.strg.of_append_line( l_sql, "       param" )

// タブIDが未設定の場合は条件に加えない
if isnull( p_tab_id ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.get( '{1}' ) )", p_menu_id ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.get( '{1}', '{2}' ) )", p_menu_id, p_tab_id ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].menu_id			= l_ds.object.menu_id[l_cnt]
			l_recs[l_cnt].tab_id			= l_ds.object.tab_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].siyo_kanou_flg	= l_ds.object.siyo_kanou_flg[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_menu_getw (string p_window_id, ref str_mmenu p_recs[]);
integer		l_cnt
str_mmenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select menu_id,tab_id" )
fnc.strg.of_append_line( l_sql, "       button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       siyo_kanou_flg," )
fnc.strg.of_append_line( l_sql, "       param" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.getw( '{1}' ) )", p_window_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].menu_id			= l_ds.object.menu_id[l_cnt]
			l_recs[l_cnt].tab_id			= l_ds.object.tab_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].siyo_kanou_flg	= l_ds.object.siyo_kanou_flg[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_menu_get_full (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[]);
integer		l_cnt
str_mmenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select menu_id,tab_id," )
fnc.strg.of_append_line( l_sql, "       button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       siyo_kanou_flg," )
fnc.strg.of_append_line( l_sql, "       param," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// タブIDが未設定の場合は条件に加えない
if isnull( p_tab_id ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.get_full( '{1}' ) )", p_menu_id ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.get_full( '{1}', '{2}' ) )", p_menu_id, p_tab_id ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].menu_id			= l_ds.object.menu_id[l_cnt]
			l_recs[l_cnt].tab_id			= l_ds.object.tab_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].siyo_kanou_flg	= l_ds.object.siyo_kanou_flg[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_menu_getw_full (string p_window_id, ref str_mmenu p_recs[]);
integer		l_cnt
str_mmenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select menu_id,tab_id," )
fnc.strg.of_append_line( l_sql, "       button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       siyo_kanou_flg," )
fnc.strg.of_append_line( l_sql, "       param," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmenu.getw_full( '{1}' ) )", p_window_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].menu_id			= l_ds.object.menu_id[l_cnt]
			l_recs[l_cnt].tab_id			= l_ds.object.tab_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].siyo_kanou_flg	= l_ds.object.siyo_kanou_flg[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_menu_get_full (string p_menu_id, ref str_mmenu p_recs[]);
string	l_tab_id

setnull( l_tab_id )

return of_menu_get_full( p_menu_id, l_tab_id, p_recs )

end function

public function integer of_menu_get (string p_menu_id, ref str_mmenu p_recs[]);
string	l_tab_id

setnull( l_tab_id )

return of_menu_get( p_menu_id, l_tab_id, p_recs )

end function

public function integer of_tanto_get (long p_tanto_code, ref str_mtanto p_recs[]);
integer		l_cnt
str_mtanto	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tanto_code," )
fnc.strg.of_append_line( l_sql, "       tanto_mei,tanto_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       nayose_code," )
fnc.strg.of_append_line( l_sql, "       bumon_code,eigyosyo_code,ka_code," )
fnc.strg.of_append_line( l_sql, "       user_id," )
fnc.strg.of_append_line( l_sql, "       haiban_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtanto.get( {1} ) )", string( p_tanto_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].tanto_mei			= l_ds.object.tanto_mei[l_cnt]
			l_recs[l_cnt].tanto_mei_ryaku	= l_ds.object.tanto_mei_ryaku[l_cnt]
			l_recs[l_cnt].nayose_code		= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].bumon_code		= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].eigyosyo_code		= l_ds.object.eigyosyo_code[l_cnt]
			l_recs[l_cnt].ka_code			= l_ds.object.ka_code[l_cnt]
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].haiban_flg		= l_ds.object.haiban_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tanto_get_full (long p_tanto_code, ref str_mtanto p_recs[]);
integer		l_cnt
str_mtanto	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tanto_code," )
fnc.strg.of_append_line( l_sql, "       tanto_mei,tanto_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       nayose_code," )
fnc.strg.of_append_line( l_sql, "       bumon_code,eigyosyo_code,ka_code," )
fnc.strg.of_append_line( l_sql, "       user_id," )
fnc.strg.of_append_line( l_sql, "       haiban_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtanto.get_full( {1} ) )", string( p_tanto_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].tanto_mei			= l_ds.object.tanto_mei[l_cnt]
			l_recs[l_cnt].tanto_mei_ryaku	= l_ds.object.tanto_mei_ryaku[l_cnt]
			l_recs[l_cnt].nayose_code		= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].bumon_code		= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].eigyosyo_code		= l_ds.object.eigyosyo_code[l_cnt]
			l_recs[l_cnt].ka_code			= l_ds.object.ka_code[l_cnt]
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].haiban_flg		= l_ds.object.haiban_flg[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_get (long p_tokui_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku,tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code," )
fnc.strg.of_append_line( l_sql, "       nayose_code,seikyu_code," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.get( {1} ) )", string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code			= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full		= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei				= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai		= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku		= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana		= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].bumon_code			= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code			= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].nayose_code			= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].seikyu_code			= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].syohizei_kbn			= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn	= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].syusoku_flg			= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].unso_code				= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].todofuken_code		= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code		= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no				= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo				= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no				= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no				= l_ds.object.fax_no[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_get_full (long p_tokui_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       tokui_kbn,gyotai_kbn," )
fnc.strg.of_append_line( l_sql, "       syokuti_flg," )
fnc.strg.of_append_line( l_sql, "       torihiki_code,jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       houjin_no," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code,tanto_code_new," )
fnc.strg.of_append_line( l_sql, "       nayose_code,nayose_eda," )
fnc.strg.of_append_line( l_sql, "       seikyu_code,seikyu_eda," )
fnc.strg.of_append_line( l_sql, "       torihiki_jyoken_kbn," )
fnc.strg.of_append_line( l_sql, "       yosin_gendo_gaku," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn,zei_hasu_kbn," )
fnc.strg.of_append_line( l_sql, "       untin_kbn_fax,untin_kbn_net,untin_kbn_edi,untin_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn,torihiki_teisi_riyu," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       kesikomi_flg," )
fnc.strg.of_append_line( l_sql, "       kaisyu_flg,kaisyu_keikoku_flg," )
fnc.strg.of_append_line( l_sql, "       nohinsyo_kbn,nohinsyo_hakkou_kbn,nohinsyo_kingaku_kbn,nohinsyo_kousou_kbn,nohinsyo_kousou_jyun," )
fnc.strg.of_append_line( l_sql, "       seikyusyo_kbn,seikyu_meisai_kbn,seikyu_tanni_kbn," )
fnc.strg.of_append_line( l_sql, "       siharai_kijitu_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       jikai_siharai_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       seikyu_data_kbn," )
fnc.strg.of_append_line( l_sql, "       kijyun_kingaku," )
fnc.strg.of_append_line( l_sql, "       simebi_1,nyukin_tuki_1,nyukin_date_1,nyukin_houhou_1,tegata_site_1," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_1m,nyukin_date_1m,nyukin_houhou_1m,tegata_site_1m," )
fnc.strg.of_append_line( l_sql, "       simebi_2,nyukin_tuki_2,nyukin_date_2,nyukin_houhou_2,tegata_site_2," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_2m,nyukin_date_2m,nyukin_houhou_2m,tegata_site_2m," )
fnc.strg.of_append_line( l_sql, "       tanka_touroku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       leadtime_flg," )
fnc.strg.of_append_line( l_sql, "       saiken_doukou_flg," )
fnc.strg.of_append_line( l_sql, "       jyuten_kbn," )
fnc.strg.of_append_line( l_sql, "       rank," )
fnc.strg.of_append_line( l_sql, "       syukka_yusen_jyun," )
fnc.strg.of_append_line( l_sql, "       syukka_siji_kingaku," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       url," )
fnc.strg.of_append_line( l_sql, "       daihyo_yakusyoku," )
fnc.strg.of_append_line( l_sql, "       daihyo_simei," )
fnc.strg.of_append_line( l_sql, "       sogyo_kbn,sogyo_nen,sogyo_tuki," )
fnc.strg.of_append_line( l_sql, "       kessan_tuki," )
fnc.strg.of_append_line( l_sql, "       gyosyu," )
fnc.strg.of_append_line( l_sql, "       sihonkin," )
fnc.strg.of_append_line( l_sql, "       jyugyoin_su," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_1,torihiki_ginkou_siten_1," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_2,torihiki_ginkou_siten_2," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_3,torihiki_ginkou_siten_3," )
fnc.strg.of_append_line( l_sql, "       siten_su,kojyo_su," )
fnc.strg.of_append_line( l_sql, "       hanbai_saki,siire_saki," )
fnc.strg.of_append_line( l_sql, "       jigyo_naiyo," )
fnc.strg.of_append_line( l_sql, "       gyokai_tii," )
fnc.strg.of_append_line( l_sql, "       torihiki_keii,torihiki_keii_bikou," )
fnc.strg.of_append_line( l_sql, "       baibai_keiyaku_flg," )
fnc.strg.of_append_line( l_sql, "       hosyonin_umu,hosyonin_mei,hosyonin_kankei,hosyokin," )
fnc.strg.of_append_line( l_sql, "       ryoritu_1,ryoritu_tani_1,ryoritu_2,ryoritu_tani_2,ryoritu_3,ryoritu_tani_3,ryoritu_4,ryoritu_tani_4,ryoritu_5,ryoritu_tani_5," )
fnc.strg.of_append_line( l_sql, "       tesuryo_1,tesuryo_tani_1,tesuryo_2,tesuryo_tani_2,tesuryo_3,tesuryo_tani_3,tesuryo_4,tesuryo_tani_4,tesuryo_5,tesuryo_tani_5," )
fnc.strg.of_append_line( l_sql, "       memo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.get_full( {1} ) )", string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full			= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei					= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai			= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku			= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana			= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].tokui_kbn					= l_ds.object.tokui_kbn[l_cnt]
			l_recs[l_cnt].gyotai_kbn				= l_ds.object.gyotai_kbn[l_cnt]
			l_recs[l_cnt].syokuti_flg				= l_ds.object.syokuti_flg[l_cnt]
			l_recs[l_cnt].torihiki_code				= l_ds.object.torihiki_code[l_cnt]
			l_recs[l_cnt].jigyosya_code				= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].houjin_no					= l_ds.object.houjin_no[l_cnt]
			l_recs[l_cnt].bumon_code				= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code				= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].tanto_code_new			= l_ds.object.tanto_code_new[l_cnt]
			l_recs[l_cnt].nayose_code				= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].nayose_eda				= l_ds.object.nayose_eda[l_cnt]
			l_recs[l_cnt].seikyu_code				= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].seikyu_eda				= l_ds.object.seikyu_eda[l_cnt]
			l_recs[l_cnt].torihiki_jyoken_kbn		= l_ds.object.torihiki_jyoken_kbn[l_cnt]
			l_recs[l_cnt].yosin_gendo_gaku			= l_ds.object.yosin_gendo_gaku[l_cnt]
			l_recs[l_cnt].syohizei_kbn				= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].zei_hasu_kbn				= l_ds.object.zei_hasu_kbn[l_cnt]
			l_recs[l_cnt].untin_kbn_fax				= l_ds.object.untin_kbn_fax[l_cnt]
			l_recs[l_cnt].untin_kbn_net				= l_ds.object.untin_kbn_net[l_cnt]
			l_recs[l_cnt].untin_kbn_edi				= l_ds.object.untin_kbn_edi[l_cnt]
			l_recs[l_cnt].untin_kbn					= l_ds.object.untin_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn		= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_riyu		= l_ds.object.torihiki_teisi_riyu[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].kesikomi_flg				= l_ds.object.kesikomi_flg[l_cnt]
			l_recs[l_cnt].kaisyu_flg				= l_ds.object.kaisyu_flg[l_cnt]
			l_recs[l_cnt].kaisyu_keikoku_flg		= l_ds.object.kaisyu_keikoku_flg[l_cnt]
			l_recs[l_cnt].nohinsyo_kbn				= l_ds.object.nohinsyo_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_hakkou_kbn		= l_ds.object.nohinsyo_hakkou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kingaku_kbn		= l_ds.object.nohinsyo_kingaku_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_kbn		= l_ds.object.nohinsyo_kousou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_jyun		= l_ds.object.nohinsyo_kousou_jyun[l_cnt]
			l_recs[l_cnt].seikyusyo_kbn				= l_ds.object.seikyusyo_kbn[l_cnt]
			l_recs[l_cnt].seikyu_meisai_kbn			= l_ds.object.seikyu_meisai_kbn[l_cnt]
			l_recs[l_cnt].seikyu_tanni_kbn			= l_ds.object.seikyu_tanni_kbn[l_cnt]
			l_recs[l_cnt].siharai_kijitu_hyoji_flg	= l_ds.object.siharai_kijitu_hyoji_flg[l_cnt]
			l_recs[l_cnt].jikai_siharai_hyoji_flg	= l_ds.object.jikai_siharai_hyoji_flg[l_cnt]
			l_recs[l_cnt].seikyu_data_kbn			= l_ds.object.seikyu_data_kbn[l_cnt]
			l_recs[l_cnt].kijyun_kingaku			= l_ds.object.kijyun_kingaku[l_cnt]
			l_recs[l_cnt].simebi_1					= l_ds.object.simebi_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1				= l_ds.object.nyukin_tuki_1[l_cnt]
			l_recs[l_cnt].nyukin_date_1				= l_ds.object.nyukin_date_1[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1			= l_ds.object.nyukin_houhou_1[l_cnt]
			l_recs[l_cnt].tegata_site_1				= l_ds.object.tegata_site_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1m			= l_ds.object.nyukin_tuki_1m[l_cnt]
			l_recs[l_cnt].nyukin_date_1m			= l_ds.object.nyukin_date_1m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1m			= l_ds.object.nyukin_houhou_1m[l_cnt]
			l_recs[l_cnt].tegata_site_1m			= l_ds.object.tegata_site_1m[l_cnt]
			l_recs[l_cnt].simebi_2					= l_ds.object.simebi_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2				= l_ds.object.nyukin_tuki_2[l_cnt]
			l_recs[l_cnt].nyukin_date_2				= l_ds.object.nyukin_date_2[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2			= l_ds.object.nyukin_houhou_2[l_cnt]
			l_recs[l_cnt].tegata_site_2				= l_ds.object.tegata_site_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2m			= l_ds.object.nyukin_tuki_2m[l_cnt]
			l_recs[l_cnt].nyukin_date_2m			= l_ds.object.nyukin_date_2m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2m			= l_ds.object.nyukin_houhou_2m[l_cnt]
			l_recs[l_cnt].tegata_site_2m			= l_ds.object.tegata_site_2m[l_cnt]
			l_recs[l_cnt].tanka_touroku_flg			= l_ds.object.tanka_touroku_flg[l_cnt]
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].leadtime_flg				= l_ds.object.leadtime_flg[l_cnt]
			l_recs[l_cnt].saiken_doukou_flg			= l_ds.object.saiken_doukou_flg[l_cnt]
			l_recs[l_cnt].jyuten_kbn				= l_ds.object.jyuten_kbn[l_cnt]
			l_recs[l_cnt].rank						= l_ds.object.rank[l_cnt]
			l_recs[l_cnt].syukka_yusen_jyun			= l_ds.object.syukka_yusen_jyun[l_cnt]
			l_recs[l_cnt].syukka_siji_kingaku		= l_ds.object.syukka_siji_kingaku[l_cnt]
			l_recs[l_cnt].todofuken_code			= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code			= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo					= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].url						= l_ds.object.url[l_cnt]
			l_recs[l_cnt].daihyo_yakusyoku			= l_ds.object.daihyo_yakusyoku[l_cnt]
			l_recs[l_cnt].daihyo_simei				= l_ds.object.daihyo_simei[l_cnt]
			l_recs[l_cnt].sogyo_kbn					= l_ds.object.sogyo_kbn[l_cnt]
			l_recs[l_cnt].sogyo_nen					= l_ds.object.sogyo_nen[l_cnt]
			l_recs[l_cnt].sogyo_tuki				= l_ds.object.sogyo_tuki[l_cnt]
			l_recs[l_cnt].kessan_tuki				= l_ds.object.kessan_tuki[l_cnt]
			l_recs[l_cnt].gyosyu					= l_ds.object.gyosyu[l_cnt]
			l_recs[l_cnt].sihonkin					= l_ds.object.sihonkin[l_cnt]
			l_recs[l_cnt].jyugyoin_su				= l_ds.object.jyugyoin_su[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_1			= l_ds.object.torihiki_ginkou_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_1	= l_ds.object.torihiki_ginkou_siten_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_2			= l_ds.object.torihiki_ginkou_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_2	= l_ds.object.torihiki_ginkou_siten_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_3			= l_ds.object.torihiki_ginkou_3[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_3	= l_ds.object.torihiki_ginkou_siten_3[l_cnt]
			l_recs[l_cnt].siten_su					= l_ds.object.siten_su[l_cnt]
			l_recs[l_cnt].kojyo_su					= l_ds.object.kojyo_su[l_cnt]
			l_recs[l_cnt].hanbai_saki				= l_ds.object.hanbai_saki[l_cnt]
			l_recs[l_cnt].siire_saki				= l_ds.object.siire_saki[l_cnt]
			l_recs[l_cnt].jigyo_naiyo				= l_ds.object.jigyo_naiyo[l_cnt]
			l_recs[l_cnt].gyokai_tii				= l_ds.object.gyokai_tii[l_cnt]
			l_recs[l_cnt].torihiki_keii				= l_ds.object.torihiki_keii[l_cnt]
			l_recs[l_cnt].torihiki_keii_bikou		= l_ds.object.torihiki_keii_bikou[l_cnt]
			l_recs[l_cnt].baibai_keiyaku_flg		= l_ds.object.baibai_keiyaku_flg[l_cnt]
			l_recs[l_cnt].hosyonin_umu				= l_ds.object.hosyonin_umu[l_cnt]
			l_recs[l_cnt].hosyonin_mei				= l_ds.object.hosyonin_mei[l_cnt]
			l_recs[l_cnt].hosyonin_kankei			= l_ds.object.hosyonin_kankei[l_cnt]
			l_recs[l_cnt].hosyokin					= l_ds.object.hosyokin[l_cnt]
			l_recs[l_cnt].ryoritu_1					= l_ds.object.ryoritu_1[l_cnt]
			l_recs[l_cnt].ryoritu_tani_1			= l_ds.object.ryoritu_tani_1[l_cnt]
			l_recs[l_cnt].ryoritu_2					= l_ds.object.ryoritu_2[l_cnt]
			l_recs[l_cnt].ryoritu_tani_2			= l_ds.object.ryoritu_tani_2[l_cnt]
			l_recs[l_cnt].ryoritu_3					= l_ds.object.ryoritu_3[l_cnt]
			l_recs[l_cnt].ryoritu_tani_3			= l_ds.object.ryoritu_tani_3[l_cnt]
			l_recs[l_cnt].ryoritu_4					= l_ds.object.ryoritu_4[l_cnt]
			l_recs[l_cnt].ryoritu_tani_4			= l_ds.object.ryoritu_tani_4[l_cnt]
			l_recs[l_cnt].ryoritu_5					= l_ds.object.ryoritu_5[l_cnt]
			l_recs[l_cnt].ryoritu_tani_5			= l_ds.object.ryoritu_tani_5[l_cnt]
			l_recs[l_cnt].tesuryo_1					= l_ds.object.tesuryo_1[l_cnt]
			l_recs[l_cnt].tesuryo_tani_1			= l_ds.object.tesuryo_tani_1[l_cnt]
			l_recs[l_cnt].tesuryo_2					= l_ds.object.tesuryo_2[l_cnt]
			l_recs[l_cnt].tesuryo_tani_2			= l_ds.object.tesuryo_tani_2[l_cnt]
			l_recs[l_cnt].tesuryo_3					= l_ds.object.tesuryo_3[l_cnt]
			l_recs[l_cnt].tesuryo_tani_3			= l_ds.object.tesuryo_tani_3[l_cnt]
			l_recs[l_cnt].tesuryo_4					= l_ds.object.tesuryo_4[l_cnt]
			l_recs[l_cnt].tesuryo_tani_4			= l_ds.object.tesuryo_tani_4[l_cnt]
			l_recs[l_cnt].tesuryo_5					= l_ds.object.tesuryo_5[l_cnt]
			l_recs[l_cnt].tesuryo_tani_5			= l_ds.object.tesuryo_tani_5[l_cnt]
			l_recs[l_cnt].memo						= l_ds.object.memo[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kyoten_check (long p_kyoten_code);
integer	l_ret

declare orafunc procedure for mkyoten.chk( :p_kyoten_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_kyoten_get (long p_kyoten_code, ref str_mkyoten p_recs[]);
integer		l_cnt
str_mkyoten	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_mei,kyoten_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       kyoten_kbn" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkyoten.get( {1} ) )", string( p_kyoten_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_mei		= l_ds.object.kyoten_mei[l_cnt]
			l_recs[l_cnt].kyoten_mei_ryaku	= l_ds.object.kyoten_mei_ryaku[l_cnt]
			l_recs[l_cnt].kyoten_kbn		= l_ds.object.kyoten_kbn[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kyoten_get_full (long p_kyoten_code, ref str_mkyoten p_recs[]);
integer		l_cnt
str_mkyoten	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_mei,kyoten_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       kyoten_kbn," )
fnc.strg.of_append_line( l_sql, "       kensaku_seq," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       zaiko_kanri_flg," )
fnc.strg.of_append_line( l_sql, "       wms_kadou_kbn,wms_nouhinsyo_flg," )
fnc.strg.of_append_line( l_sql, "       syukka_date,yoku_syukka_date," )
fnc.strg.of_append_line( l_sql, "       jyutyu_sime_jikoku1,jyutyu_sime_jikoku2,jyutyu_sime_jikoku3," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkyoten.get_full( {1} ) )", string( p_kyoten_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code				= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_mei				= l_ds.object.kyoten_mei[l_cnt]
			l_recs[l_cnt].kyoten_mei_ryaku			= l_ds.object.kyoten_mei_ryaku[l_cnt]
			l_recs[l_cnt].kyoten_kbn				= l_ds.object.kyoten_kbn[l_cnt]
			l_recs[l_cnt].kensaku_seq				= l_ds.object.kensaku_seq[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo					= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].zaiko_kanri_flg			= l_ds.object.zaiko_kanri_flg[l_cnt]
			l_recs[l_cnt].wms_kadou_kbn				= l_ds.object.wms_kadou_kbn[l_cnt]
			l_recs[l_cnt].wms_nouhinsyo_flg			= l_ds.object.wms_nouhinsyo_flg[l_cnt]
			l_recs[l_cnt].syukka_date				= l_ds.object.syukka_date[l_cnt]
			l_recs[l_cnt].yoku_syukka_date			= l_ds.object.yoku_syukka_date[l_cnt]
			l_recs[l_cnt].jyutyu_sime_jikoku1		= l_ds.object.jyutyu_sime_jikoku1[l_cnt]
			l_recs[l_cnt].jyutyu_sime_jikoku2		= l_ds.object.jyutyu_sime_jikoku2[l_cnt]
			l_recs[l_cnt].jyutyu_sime_jikoku3		= l_ds.object.jyutyu_sime_jikoku3[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kyoten_group_check (long p_kyoten_group_code);
integer	l_ret

declare orafunc procedure for mkyoten_group.chk( :p_kyoten_group_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_kyoten_group_get_full (long p_kyoten_group_code, ref str_mkyoten_group p_recs[]);
integer				l_cnt
str_mkyoten_group	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_group_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_sort_no," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkyoten_group.get_full( {1} ) )", string( p_kyoten_group_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_group_code		= l_ds.object.kyoten_group_code[l_cnt]
			l_recs[l_cnt].kyoten_code			= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_sort_no		= l_ds.object.kyoten_sort_no[l_cnt]
			l_recs[l_cnt].touroku_date			= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id		= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id		= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id			= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date			= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id		= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id		= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id			= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date			= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id		= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id		= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id			= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg				= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kyoten_group_get (long p_kyoten_group_code, ref str_mkyoten_group p_recs[]);
integer				l_cnt
str_mkyoten_group	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_group_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_code," )
fnc.strg.of_append_line( l_sql, "       kyoten_sort_no" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkyoten_group.get( {1} ) )", string( p_kyoten_group_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_group_code		= l_ds.object.kyoten_group_code[l_cnt]
			l_recs[l_cnt].kyoten_code			= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_sort_no		= l_ds.object.kyoten_sort_no[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kihon_check (long p_kanri_code);
integer	l_ret

declare orafunc procedure for mkihon.chk( :p_kanri_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_kihon_get (long p_kanri_code, ref str_mkihon p_recs[]);
integer		l_cnt
str_mkihon	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kanri_code," )
fnc.strg.of_append_line( l_sql, "       kaisya_mei,kaisya_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       jigyosya_code,houjin_no," )
fnc.strg.of_append_line( l_sql, "       jigyo_nendo" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkihon.get( {1} ) )", string( p_kanri_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kanri_code		= l_ds.object.kanri_code[l_cnt]
			l_recs[l_cnt].kaisya_mei		= l_ds.object.kaisya_mei[l_cnt]
			l_recs[l_cnt].kaisya_mei_ryaku	= l_ds.object.kaisya_mei_ryaku[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo			= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no			= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no			= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].jigyosya_code		= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].houjin_no			= l_ds.object.houjin_no[l_cnt]
			l_recs[l_cnt].jigyo_nendo		= l_ds.object.jigyo_nendo[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kihon_get_full (long p_kanri_code, ref str_mkihon p_recs[]);
integer		l_cnt
str_mkihon	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kanri_code," )
fnc.strg.of_append_line( l_sql, "       kaisya_mei,kaisya_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       jigyosya_code,houjin_no," )
fnc.strg.of_append_line( l_sql, "       syori_date," )
fnc.strg.of_append_line( l_sql, "       jigyo_nendo," )
fnc.strg.of_append_line( l_sql, "       uriage_sime_date,siire_sime_date,genka_sime_nengetu," )
fnc.strg.of_append_line( l_sql, "       sime_jyotai_kbn," )
fnc.strg.of_append_line( l_sql, "       tougetu_str_date,tougetu_end_date," )
fnc.strg.of_append_line( l_sql, "       yokugetu_str_date,yokugetu_end_date," )
fnc.strg.of_append_line( l_sql, "       zeiritu_henpin_str_date,zeiritu_henpin_end_date," )
fnc.strg.of_append_line( l_sql, "       zei_hasuu_uriage,zei_hasuu_siire," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkihon.get_full( {1} ) )", string( p_kanri_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kanri_code				= l_ds.object.kanri_code[l_cnt]
			l_recs[l_cnt].kaisya_mei				= l_ds.object.kaisya_mei[l_cnt]
			l_recs[l_cnt].kaisya_mei_ryaku			= l_ds.object.kaisya_mei_ryaku[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo					= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].jigyosya_code				= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].houjin_no					= l_ds.object.houjin_no[l_cnt]
			l_recs[l_cnt].syori_date				= l_ds.object.syori_date[l_cnt]
			l_recs[l_cnt].jigyo_nendo				= l_ds.object.jigyo_nendo[l_cnt]
			l_recs[l_cnt].uriage_sime_date			= l_ds.object.uriage_sime_date[l_cnt]
			l_recs[l_cnt].siire_sime_date			= l_ds.object.siire_sime_date[l_cnt]
			l_recs[l_cnt].genka_sime_nengetu		= l_ds.object.genka_sime_nengetu[l_cnt]
			l_recs[l_cnt].sime_jyotai_kbn			= l_ds.object.sime_jyotai_kbn[l_cnt]
			l_recs[l_cnt].tougetu_str_date			= l_ds.object.tougetu_str_date[l_cnt]
			l_recs[l_cnt].tougetu_end_date			= l_ds.object.tougetu_end_date[l_cnt]
			l_recs[l_cnt].yokugetu_str_date			= l_ds.object.yokugetu_str_date[l_cnt]
			l_recs[l_cnt].yokugetu_end_date			= l_ds.object.yokugetu_end_date[l_cnt]
			l_recs[l_cnt].zeiritu_henpin_str_date	= l_ds.object.zeiritu_henpin_str_date[l_cnt]
			l_recs[l_cnt].zeiritu_henpin_end_date	= l_ds.object.zeiritu_henpin_end_date[l_cnt]
			l_recs[l_cnt].zei_hasuu_uriage			= l_ds.object.zei_hasuu_uriage[l_cnt]
			l_recs[l_cnt].zei_hasuu_siire			= l_ds.object.zei_hasuu_siire[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_user_check (string p_user_id);
integer	l_ret

declare orafunc procedure for muser.chk( :p_user_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_user_get (string p_user_id, ref str_muser p_recs[]);
integer		l_cnt
str_muser	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select user_id," )
fnc.strg.of_append_line( l_sql, "       user_mei,user_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       kyoten_code,kyoten_code_2,kyoten_group_code," )
fnc.strg.of_append_line( l_sql, "       login_kengen" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muser.get( '{1}' ) )", string( p_user_id ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].user_mei			= l_ds.object.user_mei[l_cnt]
			l_recs[l_cnt].user_mei_ryaku	= l_ds.object.user_mei_ryaku[l_cnt]
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_code_2		= l_ds.object.kyoten_code_2[l_cnt]
			l_recs[l_cnt].kyoten_group_code	= l_ds.object.kyoten_group_code[l_cnt]
			l_recs[l_cnt].login_kengen		= l_ds.object.login_kengen[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_user_get_full (string p_user_id, ref str_muser p_recs[]);
integer		l_cnt
str_muser	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select user_id," )
fnc.strg.of_append_line( l_sql, "       user_mei,user_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       password," )
fnc.strg.of_append_line( l_sql, "       password_new,password_new_date," )
fnc.strg.of_append_line( l_sql, "       mail_address," )
fnc.strg.of_append_line( l_sql, "       busyo_code," )
fnc.strg.of_append_line( l_sql, "       class," )
fnc.strg.of_append_line( l_sql, "       init_menu_id,init_tab_id," )
fnc.strg.of_append_line( l_sql, "       kyoten_code,kyoten_code_2,kyoten_group_code," )
fnc.strg.of_append_line( l_sql, "       login_kengen," )
fnc.strg.of_append_line( l_sql, "       riyou_str_date,riyou_end_date," )
fnc.strg.of_append_line( l_sql, "       sid,serial," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muser.get_full( '{1}' ) )", string( p_user_id ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].user_mei			= l_ds.object.user_mei[l_cnt]
			l_recs[l_cnt].user_mei_ryaku	= l_ds.object.user_mei_ryaku[l_cnt]
			l_recs[l_cnt].password			= l_ds.object.password[l_cnt]
			l_recs[l_cnt].password_new		= l_ds.object.password_new[l_cnt]
			l_recs[l_cnt].password_new_date	= l_ds.object.password_new_date[l_cnt]
			l_recs[l_cnt].mail_address		= l_ds.object.mail_address[l_cnt]
			l_recs[l_cnt].busyo_code		= l_ds.object.busyo_code[l_cnt]
			l_recs[l_cnt].class				= l_ds.object.class[l_cnt]
			l_recs[l_cnt].init_menu_id		= l_ds.object.init_menu_id[l_cnt]
			l_recs[l_cnt].init_tab_id		= l_ds.object.init_tab_id[l_cnt]
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].kyoten_code_2		= l_ds.object.kyoten_code_2[l_cnt]
			l_recs[l_cnt].kyoten_group_code	= l_ds.object.kyoten_group_code[l_cnt]
			l_recs[l_cnt].login_kengen		= l_ds.object.login_kengen[l_cnt]
			l_recs[l_cnt].riyou_str_date	= l_ds.object.riyou_str_date[l_cnt]
			l_recs[l_cnt].riyou_end_date	= l_ds.object.riyou_end_date[l_cnt]
			l_recs[l_cnt].sid				= l_ds.object.sid[l_cnt]
			l_recs[l_cnt].serial			= l_ds.object.serial[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_yubin_check (string p_yubin_no);
integer	l_ret

declare orafunc procedure for myubin.chk( :p_yubin_no ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_yubin_get (string p_yubin_no, ref str_myubin p_recs[]);
integer		l_cnt
str_myubin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select yubin_no," )
fnc.strg.of_append_line( l_sql, "       full_mei" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( myubin.get( '{1}' ) )", string( p_yubin_no ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].yubin_no	= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].full_mei	= l_ds.object.full_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_nendo_check (long p_nendo_code);
integer	l_ret

declare orafunc procedure for mnendo.chk( :p_nendo_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_nendo_get (long p_nendo_code, ref str_mnendo p_recs[]);
integer		l_cnt
str_mnendo	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select nendo_code,nendo_mei," )
fnc.strg.of_append_line( l_sql, "       kisyo_date,kimatu_date" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mnendo.get( {1} ) )", string( p_nendo_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].nendo_code		= l_ds.object.nendo_code[l_cnt]
			l_recs[l_cnt].nendo_mei			= l_ds.object.nendo_mei[l_cnt]
			l_recs[l_cnt].kisyo_date		= l_ds.object.kisyo_date[l_cnt]
			l_recs[l_cnt].kimatu_date		= l_ds.object.kimatu_date[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_nendo_get_full (long p_nendo_code, ref str_mnendo p_recs[]);
integer		l_cnt
str_mnendo	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select nendo_code,nendo_mei," )
fnc.strg.of_append_line( l_sql, "       kisyo_nengetu,kimatu_nengetu," )
fnc.strg.of_append_line( l_sql, "       kisyo_date,kimatu_date," )
fnc.strg.of_append_line( l_sql, "       tuki_1q,tuki_2q,tuki_3q,tuki_4q," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mnendo.get_full( {1} ) )", string( p_nendo_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].nendo_code		= l_ds.object.nendo_code[l_cnt]
			l_recs[l_cnt].nendo_mei			= l_ds.object.nendo_mei[l_cnt]
			l_recs[l_cnt].kisyo_nengetu		= l_ds.object.kisyo_nengetu[l_cnt]
			l_recs[l_cnt].kimatu_nengetu	= l_ds.object.kimatu_nengetu[l_cnt]
			l_recs[l_cnt].kisyo_date		= l_ds.object.kisyo_date[l_cnt]
			l_recs[l_cnt].kimatu_date		= l_ds.object.kimatu_date[l_cnt]
			l_recs[l_cnt].tuki_1q			= l_ds.object.tuki_1q[l_cnt]
			l_recs[l_cnt].tuki_2q			= l_ds.object.tuki_2q[l_cnt]
			l_recs[l_cnt].tuki_3q			= l_ds.object.tuki_3q[l_cnt]
			l_recs[l_cnt].tuki_4q			= l_ds.object.tuki_4q[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_syohin_check (long p_syohin_code, long p_iro_no);
string	l_size_code

setnull( l_size_code )

return of_syohin_check( p_syohin_code, p_iro_no, l_size_code )

end function

public function integer of_syohin_check (long p_syohin_code);
long	l_iro_no
string	l_size_code

setnull( l_iro_no )
setnull( l_size_code )

return of_syohin_check( p_syohin_code, l_iro_no, l_size_code )

end function

public function integer of_syohin_get (long p_syohin_code, long p_iro_no, ref str_msyohin p_recs[]);
string	l_size_code

setnull( l_size_code )

return of_syohin_get( p_syohin_code, p_iro_no, l_size_code, p_recs )

end function

public function integer of_syohin_get (long p_syohin_code, ref str_msyohin p_recs[]);
long	l_iro_no
string	l_size_code

setnull( l_iro_no )
setnull( l_size_code )

return of_syohin_get( p_syohin_code, l_iro_no, l_size_code, p_recs )

end function

public function integer of_syohin_get_full (long p_syohin_code, ref str_msyohin p_recs[]);
long	l_iro_no
string	l_size_code

setnull( l_iro_no )
setnull( l_size_code )

return of_syohin_get_full( p_syohin_code, l_iro_no, l_size_code, p_recs )

end function

public function integer of_syohin_get_full (long p_syohin_code, long p_iro_no, ref str_msyohin p_recs[]);
string	l_size_code

setnull( l_size_code )

return of_syohin_get_full( p_syohin_code, p_iro_no, l_size_code, p_recs )

end function

public function integer of_tanka_check (long p_tokui_code, long p_syohin_code);
integer	l_ret

declare orafunc procedure for mtanka.chk( :p_tokui_code, :p_syohin_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_tanka_get_full (long p_tokui_code, long p_syohin_code, ref str_mtanka p_recs[]);
integer		l_cnt
str_mtanka	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code,syohin_code," )
fnc.strg.of_append_line( l_sql, "       tanka," )
fnc.strg.of_append_line( l_sql, "       up_1,up_2,up_3,up_4,up_5," )
fnc.strg.of_append_line( l_sql, "       tanka_henkou_date," )
fnc.strg.of_append_line( l_sql, "       old_tanka," )
fnc.strg.of_append_line( l_sql, "       zei_kbn,zeiritu,zeibetu_tanka," )
fnc.strg.of_append_line( l_sql, "       zeibetu_up_1,zeibetu_up_2,zeibetu_up_3,zeibetu_up_4,zeibetu_up_5," )
fnc.strg.of_append_line( l_sql, "       jyoudai,kakeritu," )
fnc.strg.of_append_line( l_sql, "       tokune_flg," )
fnc.strg.of_append_line( l_sql, "       new_tanka," )
fnc.strg.of_append_line( l_sql, "       new_up_1,new_up_2,new_up_3,new_up_4,new_up_5," )
fnc.strg.of_append_line( l_sql, "       new_zei_kbn," )
fnc.strg.of_append_line( l_sql, "       new_zeiritu," )
fnc.strg.of_append_line( l_sql, "       new_jyodai,new_kakeritu," )
fnc.strg.of_append_line( l_sql, "       tekiyo_date_str,tekiyo_date_end," )
fnc.strg.of_append_line( l_sql, "       note," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 得意先コードもしくは商品コードがnullでもそのまま渡す nullになってる値はPL側では検索条件には入らない
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtanka.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_syohin_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].tanka				= l_ds.object.tanka[l_cnt]
			l_recs[l_cnt].up_1				= l_ds.object.up_1[l_cnt]
			l_recs[l_cnt].up_2				= l_ds.object.up_2[l_cnt]
			l_recs[l_cnt].up_3				= l_ds.object.up_3[l_cnt]
			l_recs[l_cnt].up_4				= l_ds.object.up_4[l_cnt]
			l_recs[l_cnt].up_5				= l_ds.object.up_5[l_cnt]
			l_recs[l_cnt].tanka_henkou_date	= l_ds.object.tanka_henkou_date[l_cnt]
			l_recs[l_cnt].old_tanka			= l_ds.object.old_tanka[l_cnt]
			l_recs[l_cnt].zei_kbn			= l_ds.object.zei_kbn[l_cnt]
			l_recs[l_cnt].zeiritu			= l_ds.object.zeiritu[l_cnt]
			l_recs[l_cnt].zeibetu_tanka		= l_ds.object.zeibetu_tanka[l_cnt]
			l_recs[l_cnt].zeibetu_up_1		= l_ds.object.zeibetu_up_1[l_cnt]
			l_recs[l_cnt].zeibetu_up_2		= l_ds.object.zeibetu_up_2[l_cnt]
			l_recs[l_cnt].zeibetu_up_3		= l_ds.object.zeibetu_up_3[l_cnt]
			l_recs[l_cnt].zeibetu_up_4		= l_ds.object.zeibetu_up_4[l_cnt]
			l_recs[l_cnt].zeibetu_up_5		= l_ds.object.zeibetu_up_5[l_cnt]
			l_recs[l_cnt].jyoudai			= l_ds.object.jyoudai[l_cnt]
			l_recs[l_cnt].kakeritu			= l_ds.object.kakeritu[l_cnt]
			l_recs[l_cnt].tokune_flg		= l_ds.object.tokune_flg[l_cnt]
			l_recs[l_cnt].new_tanka			= l_ds.object.new_tanka[l_cnt]
			l_recs[l_cnt].new_up_1			= l_ds.object.new_up_1[l_cnt]
			l_recs[l_cnt].new_up_2			= l_ds.object.new_up_2[l_cnt]
			l_recs[l_cnt].new_up_3			= l_ds.object.new_up_3[l_cnt]
			l_recs[l_cnt].new_up_4			= l_ds.object.new_up_4[l_cnt]
			l_recs[l_cnt].new_up_5			= l_ds.object.new_up_5[l_cnt]
			l_recs[l_cnt].new_zei_kbn		= l_ds.object.new_zei_kbn[l_cnt]
			l_recs[l_cnt].new_zeiritu		= l_ds.object.new_zeiritu[l_cnt]
			l_recs[l_cnt].new_jyodai		= l_ds.object.new_jyodai[l_cnt]
			l_recs[l_cnt].new_kakeritu		= l_ds.object.new_kakeritu[l_cnt]
			l_recs[l_cnt].tekiyo_date_str	= l_ds.object.tekiyo_date_str[l_cnt]
			l_recs[l_cnt].tekiyo_date_end	= l_ds.object.tekiyo_date_end[l_cnt]
			l_recs[l_cnt].note				= l_ds.object.note[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tanka_get (long p_tokui_code, long p_syohin_code, ref str_mtanka p_recs[]);
integer		l_cnt
str_mtanka	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code,syohin_code," )
fnc.strg.of_append_line( l_sql, "       tanka," )
fnc.strg.of_append_line( l_sql, "       up_1,up_2,up_3,up_4,up_5," )
fnc.strg.of_append_line( l_sql, "       new_tanka," )
fnc.strg.of_append_line( l_sql, "       new_up_1,new_up_2,new_up_3,new_up_4,new_up_5," )
fnc.strg.of_append_line( l_sql, "       tekiyo_date_str,tekiyo_date_end" )

// 得意先コードもしくは商品コードがnullでもそのまま渡す nullになってる値はPL側では検索条件には入らない
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtanka.get( {1}, {2} ) )", string( p_tokui_code ), string( p_syohin_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].tanka				= l_ds.object.tanka[l_cnt]
			l_recs[l_cnt].up_1				= l_ds.object.up_1[l_cnt]
			l_recs[l_cnt].up_2				= l_ds.object.up_2[l_cnt]
			l_recs[l_cnt].up_3				= l_ds.object.up_3[l_cnt]
			l_recs[l_cnt].up_4				= l_ds.object.up_4[l_cnt]
			l_recs[l_cnt].up_5				= l_ds.object.up_5[l_cnt]
			l_recs[l_cnt].new_tanka			= l_ds.object.new_tanka[l_cnt]
			l_recs[l_cnt].new_up_1			= l_ds.object.new_up_1[l_cnt]
			l_recs[l_cnt].new_up_2			= l_ds.object.new_up_2[l_cnt]
			l_recs[l_cnt].new_up_3			= l_ds.object.new_up_3[l_cnt]
			l_recs[l_cnt].new_up_4			= l_ds.object.new_up_4[l_cnt]
			l_recs[l_cnt].new_up_5			= l_ds.object.new_up_5[l_cnt]
			l_recs[l_cnt].tekiyo_date_str	= l_ds.object.tekiyo_date_str[l_cnt]
			l_recs[l_cnt].tekiyo_date_end	= l_ds.object.tekiyo_date_end[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_unso_check (long p_unso_code);
integer	l_ret

declare orafunc procedure for munso.chk( :p_unso_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_unso_get_full (long p_unso_code, ref str_munso p_recs[]);
integer		l_cnt
str_munso	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select unso_code," )
fnc.strg.of_append_line( l_sql, "       unso_mei,unso_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       air_flg,untin_flg," )
fnc.strg.of_append_line( l_sql, "       keisan_code," )
fnc.strg.of_append_line( l_sql, "       okurijyo_flg,okurijyo_code," )
fnc.strg.of_append_line( l_sql, "       tyakubarai_furikae_flg,tyakubarai_unso_code," )
fnc.strg.of_append_line( l_sql, "       haiban_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( munso.get_full( {1} ) )", string( p_unso_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].unso_mei					= l_ds.object.unso_mei[l_cnt]
			l_recs[l_cnt].unso_mei_ryaku			= l_ds.object.unso_mei_ryaku[l_cnt]
			l_recs[l_cnt].air_flg					= l_ds.object.air_flg[l_cnt]
			l_recs[l_cnt].untin_flg					= l_ds.object.untin_flg[l_cnt]
			l_recs[l_cnt].keisan_code				= l_ds.object.keisan_code[l_cnt]
			l_recs[l_cnt].okurijyo_flg				= l_ds.object.okurijyo_flg[l_cnt]
			l_recs[l_cnt].okurijyo_code				= l_ds.object.okurijyo_code[l_cnt]
			l_recs[l_cnt].tyakubarai_furikae_flg	= l_ds.object.tyakubarai_furikae_flg[l_cnt]
			l_recs[l_cnt].tyakubarai_unso_code		= l_ds.object.tyakubarai_unso_code[l_cnt]
			l_recs[l_cnt].haiban_flg				= l_ds.object.haiban_flg[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_unso_get (long p_unso_code, ref str_munso p_recs[]);
integer		l_cnt
str_munso	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select unso_code," )
fnc.strg.of_append_line( l_sql, "       unso_mei,unso_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       haiban_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( munso.get( {1} ) )", string( p_unso_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].unso_code			= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].unso_mei			= l_ds.object.unso_mei[l_cnt]
			l_recs[l_cnt].unso_mei_ryaku	= l_ds.object.unso_mei_ryaku[l_cnt]
			l_recs[l_cnt].haiban_flg		= l_ds.object.haiban_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_syohin_check (long p_syohin_code, long p_iro_no, string p_size_code);
integer	l_ret

declare orafunc procedure for msyohin.chk( :p_syohin_code, :p_iro_no, :p_size_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_syohin_get (long p_syohin_code, long p_iro_no, string p_size_code, ref str_msyohin p_recs[]);
integer		l_cnt
str_msyohin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select syohin_code,iro_no,eda_no," )
fnc.strg.of_append_line( l_sql, "       size_iti,size_code," )
fnc.strg.of_append_line( l_sql, "       sku_code," )
fnc.strg.of_append_line( l_sql, "       hin_ban," )
fnc.strg.of_append_line( l_sql, "       hin_mei_kana,iro_mei_kana," )
fnc.strg.of_append_line( l_sql, "       hin_mei,iro_mei,size_mei," )
fnc.strg.of_append_line( l_sql, "       haiban_kbn," )
fnc.strg.of_append_line( l_sql, "       haiban_flg,syusoku_flg,bettyu_flg," )
fnc.strg.of_append_line( l_sql, "       tokui_code,bukken_code," )
fnc.strg.of_append_line( l_sql, "       bhin_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_kbn" )

// 色番とサイズコードが未設定の場合は条件に加えない
if isnull( p_iro_no ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get( {1} ) )", string( p_syohin_code ) ) )
else
	if isnull( p_size_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get( {1}, {2} ) )", string( p_syohin_code ), string( p_iro_no ) ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get( {1}, {2}, '{3}' ) )", string( p_syohin_code ), string( p_iro_no ), p_size_code ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].syohin_code				= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no					= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].eda_no					= l_ds.object.eda_no[l_cnt]
			l_recs[l_cnt].size_iti					= l_ds.object.size_iti[l_cnt]
			l_recs[l_cnt].size_code					= l_ds.object.size_code[l_cnt]
			l_recs[l_cnt].sku_code					= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].hin_ban					= l_ds.object.hin_ban[l_cnt]
			l_recs[l_cnt].hin_mei_kana				= l_ds.object.hin_mei_kana[l_cnt]
			l_recs[l_cnt].iro_mei_kana				= l_ds.object.iro_mei_kana[l_cnt]
			l_recs[l_cnt].hin_mei					= l_ds.object.hin_mei[l_cnt]
			l_recs[l_cnt].iro_mei					= l_ds.object.iro_mei[l_cnt]
			l_recs[l_cnt].size_mei					= l_ds.object.size_mei[l_cnt]
			l_recs[l_cnt].haiban_kbn				= l_ds.object.haiban_kbn[l_cnt]
			l_recs[l_cnt].haiban_flg				= l_ds.object.haiban_flg[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].bettyu_flg				= l_ds.object.bettyu_flg[l_cnt]
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].bukken_code				= l_ds.object.bukken_code[l_cnt]
			l_recs[l_cnt].bhin_flg					= l_ds.object.bhin_flg[l_cnt]
			l_recs[l_cnt].touroku_kbn				= l_ds.object.touroku_kbn[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_syohin_get_full (long p_syohin_code, long p_iro_no, string p_size_code, ref str_msyohin p_recs[]);
integer		l_cnt
str_msyohin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select syohin_code,iro_no,eda_no," )
fnc.strg.of_append_line( l_sql, "       size_iti,size_code," )
fnc.strg.of_append_line( l_sql, "       sku_code," )
fnc.strg.of_append_line( l_sql, "       hin_ban," )
fnc.strg.of_append_line( l_sql, "       hin_mei_kana,iro_mei_kana," )
fnc.strg.of_append_line( l_sql, "       hin_mei,iro_mei,size_mei," )
fnc.strg.of_append_line( l_sql, "       hi_toriatukai_flg," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       kyoyo_flg," )
fnc.strg.of_append_line( l_sql, "       brand_code,subbrand_code," )
fnc.strg.of_append_line( l_sql, "       season_code," )
fnc.strg.of_append_line( l_sql, "       daibunrui_code,tyubunrui_code,syobunrui_code," )
fnc.strg.of_append_line( l_sql, "       group_code,seriese_code,iro_keitou_code," )
fnc.strg.of_append_line( l_sql, "       category_code_1,category_code_2,category_code_3,category_code_4,category_code_5," )
fnc.strg.of_append_line( l_sql, "       hatubai_date," )
fnc.strg.of_append_line( l_sql, "       haiban_kbn," )
fnc.strg.of_append_line( l_sql, "       haiban_flg," )
fnc.strg.of_append_line( l_sql, "       haiban_date," )
fnc.strg.of_append_line( l_sql, "       haiban_riyu_kbn," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       syobunhin_flg,jyutenhin_flg," )
fnc.strg.of_append_line( l_sql, "       jyoudai,jyoudai_koukai_flg," )
fnc.strg.of_append_line( l_sql, "       kakaku_group_kbn," )
fnc.strg.of_append_line( l_sql, "       up_iti,up_gaku,up_gaku_j," )
fnc.strg.of_append_line( l_sql, "       tanka_touroku_flg," )
fnc.strg.of_append_line( l_sql, "       kyuu_jyoudai," )
fnc.strg.of_append_line( l_sql, "       jyoudai_henkou_date," )
fnc.strg.of_append_line( l_sql, "       sin_jyoudai,sin_jyoudai_tekiyou_date," )
fnc.strg.of_append_line( l_sql, "       kibou_kouri_kakaku," )
fnc.strg.of_append_line( l_sql, "       yotei_genka,hyojyun_genka,jissai_genka," )
fnc.strg.of_append_line( l_sql, "       siiresaki_code," )
fnc.strg.of_append_line( l_sql, "       maker_hinban," )
fnc.strg.of_append_line( l_sql, "       syohin_kukaku_kbn," )
fnc.strg.of_append_line( l_sql, "       bettyu_flg,bettyu_running_flg," )
fnc.strg.of_append_line( l_sql, "       tokui_code,bukken_code," )
fnc.strg.of_append_line( l_sql, "       tokutei_tokui_kbn," )
fnc.strg.of_append_line( l_sql, "       irisu,ball_irisu," )
fnc.strg.of_append_line( l_sql, "       tani_kbn," )
fnc.strg.of_append_line( l_sql, "       hatyu_tanni_su,hanbai_tanni_su," )
fnc.strg.of_append_line( l_sql, "       rank," )
fnc.strg.of_append_line( l_sql, "       seihin_syohin_kbn,irisu_hyoji_kbn," )
fnc.strg.of_append_line( l_sql, "       keikaku_kbn," )
fnc.strg.of_append_line( l_sql, "       hatyu_kbn,hatyusaki_kbn," )
fnc.strg.of_append_line( l_sql, "       syozai_kbn," )
fnc.strg.of_append_line( l_sql, "       syokuti_flg,zaiko_kanri_flg," )
fnc.strg.of_append_line( l_sql, "       suryo_keisan_flg,kingaku_keisan_flg,arari_keisan_flg,hako_keisan_flg," )
fnc.strg.of_append_line( l_sql, "       kenpin_taisyo_flg,muryo_kyoka_flg," )
fnc.strg.of_append_line( l_sql, "       bhin_flg," )
fnc.strg.of_append_line( l_sql, "       tankahyo_hakkou_kbn," )
fnc.strg.of_append_line( l_sql, "       kankyo_hairyo_flg," )
fnc.strg.of_append_line( l_sql, "       zeiritu_kbn," )
fnc.strg.of_append_line( l_sql, "       siirehin_flg,kuuyu_kinsi_flg," )
fnc.strg.of_append_line( l_sql, "       sozai," )
fnc.strg.of_append_line( l_sql, "       konritu_1,konritu_2,konritu_3,konritu_4,konritu_5," )
fnc.strg.of_append_line( l_sql, "       konritu_6,konritu_7,konritu_8,konritu_9,konritu_10," )
fnc.strg.of_append_line( l_sql, "       seisankoku_code," )
fnc.strg.of_append_line( l_sql, "       yoki_kami,yoki_pla," )
fnc.strg.of_append_line( l_sql, "       housou_kami,housou_pla," )
fnc.strg.of_append_line( l_sql, "       sunpo_tate,sunpo_yoko,sunpo_takasa," )
fnc.strg.of_append_line( l_sql, "       jyuryo,tijimi_ritu," )
fnc.strg.of_append_line( l_sql, "       flg_1,flg_2,flg_3,flg_4,flg_5," )
fnc.strg.of_append_line( l_sql, "       kbn_1,kbn_2,kbn_3,kbn_4,kbn_5," )
fnc.strg.of_append_line( l_sql, "       touroku_kbn," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 色番とサイズコードが未設定の場合は条件に加えない
if isnull( p_iro_no ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get_full( {1} ) )", string( p_syohin_code ) ) )
else
	if isnull( p_size_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get_full( {1}, {2} ) )", string( p_syohin_code ), string( p_iro_no ) ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyohin.get_full( {1}, {2}, '{3}' ) )", string( p_syohin_code ), string( p_iro_no ), p_size_code ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].syohin_code				= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no					= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].eda_no					= l_ds.object.eda_no[l_cnt]
			l_recs[l_cnt].size_iti					= l_ds.object.size_iti[l_cnt]
			l_recs[l_cnt].size_code					= l_ds.object.size_code[l_cnt]
			l_recs[l_cnt].sku_code					= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].hin_ban					= l_ds.object.hin_ban[l_cnt]
			l_recs[l_cnt].hin_mei_kana				= l_ds.object.hin_mei_kana[l_cnt]
			l_recs[l_cnt].iro_mei_kana				= l_ds.object.iro_mei_kana[l_cnt]
			l_recs[l_cnt].hin_mei					= l_ds.object.hin_mei[l_cnt]
			l_recs[l_cnt].iro_mei					= l_ds.object.iro_mei[l_cnt]
			l_recs[l_cnt].size_mei					= l_ds.object.size_mei[l_cnt]
			l_recs[l_cnt].hi_toriatukai_flg			= l_ds.object.hi_toriatukai_flg[l_cnt]
			l_recs[l_cnt].bumon_code				= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].kyoyo_flg					= l_ds.object.kyoyo_flg[l_cnt]
			l_recs[l_cnt].brand_code				= l_ds.object.brand_code[l_cnt]
			l_recs[l_cnt].subbrand_code				= l_ds.object.subbrand_code[l_cnt]
			l_recs[l_cnt].season_code				= l_ds.object.season_code[l_cnt]
			l_recs[l_cnt].daibunrui_code			= l_ds.object.daibunrui_code[l_cnt]
			l_recs[l_cnt].tyubunrui_code			= l_ds.object.tyubunrui_code[l_cnt]
			l_recs[l_cnt].syobunrui_code			= l_ds.object.syobunrui_code[l_cnt]
			l_recs[l_cnt].group_code				= l_ds.object.group_code[l_cnt]
			l_recs[l_cnt].seriese_code				= l_ds.object.seriese_code[l_cnt]
			l_recs[l_cnt].iro_keitou_code			= l_ds.object.iro_keitou_code[l_cnt]
			l_recs[l_cnt].category_code_1			= l_ds.object.category_code_1[l_cnt]
			l_recs[l_cnt].category_code_2			= l_ds.object.category_code_2[l_cnt]
			l_recs[l_cnt].category_code_3			= l_ds.object.category_code_3[l_cnt]
			l_recs[l_cnt].category_code_4			= l_ds.object.category_code_4[l_cnt]
			l_recs[l_cnt].category_code_5			= l_ds.object.category_code_5[l_cnt]
			l_recs[l_cnt].hatubai_date				= l_ds.object.hatubai_date[l_cnt]
			l_recs[l_cnt].haiban_kbn				= l_ds.object.haiban_kbn[l_cnt]
			l_recs[l_cnt].haiban_flg				= l_ds.object.haiban_flg[l_cnt]
			l_recs[l_cnt].haiban_date				= l_ds.object.haiban_date[l_cnt]
			l_recs[l_cnt].haiban_riyu_kbn			= l_ds.object.haiban_riyu_kbn[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].syobunhin_flg				= l_ds.object.syobunhin_flg[l_cnt]
			l_recs[l_cnt].jyutenhin_flg				= l_ds.object.jyutenhin_flg[l_cnt]
			l_recs[l_cnt].jyoudai					= l_ds.object.jyoudai[l_cnt]
			l_recs[l_cnt].jyoudai_koukai_flg		= l_ds.object.jyoudai_koukai_flg[l_cnt]
			l_recs[l_cnt].kakaku_group_kbn			= l_ds.object.kakaku_group_kbn[l_cnt]
			l_recs[l_cnt].up_iti					= l_ds.object.up_iti[l_cnt]
			l_recs[l_cnt].up_gaku					= l_ds.object.up_gaku[l_cnt]
			l_recs[l_cnt].up_gaku_j					= l_ds.object.up_gaku_j[l_cnt]
			l_recs[l_cnt].tanka_touroku_flg			= l_ds.object.tanka_touroku_flg[l_cnt]
			l_recs[l_cnt].kyuu_jyoudai				= l_ds.object.kyuu_jyoudai[l_cnt]
			l_recs[l_cnt].jyoudai_henkou_date		= l_ds.object.jyoudai_henkou_date[l_cnt]
			l_recs[l_cnt].sin_jyoudai				= l_ds.object.sin_jyoudai[l_cnt]
			l_recs[l_cnt].sin_jyoudai_tekiyou_date	= l_ds.object.sin_jyoudai_tekiyou_date[l_cnt]
			l_recs[l_cnt].kibou_kouri_kakaku		= l_ds.object.kibou_kouri_kakaku[l_cnt]
			l_recs[l_cnt].yotei_genka				= l_ds.object.yotei_genka[l_cnt]
			l_recs[l_cnt].hyojyun_genka				= l_ds.object.hyojyun_genka[l_cnt]
			l_recs[l_cnt].jissai_genka				= l_ds.object.jissai_genka[l_cnt]
			l_recs[l_cnt].siiresaki_code			= l_ds.object.siiresaki_code[l_cnt]
			l_recs[l_cnt].maker_hinban				= l_ds.object.maker_hinban[l_cnt]
			l_recs[l_cnt].syohin_kukaku_kbn			= l_ds.object.syohin_kukaku_kbn[l_cnt]
			l_recs[l_cnt].bettyu_flg				= l_ds.object.bettyu_flg[l_cnt]
			l_recs[l_cnt].bettyu_running_flg		= l_ds.object.bettyu_running_flg[l_cnt]
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].bukken_code				= l_ds.object.bukken_code[l_cnt]
			l_recs[l_cnt].tokutei_tokui_kbn			= l_ds.object.tokutei_tokui_kbn[l_cnt]
			l_recs[l_cnt].irisu						= l_ds.object.irisu[l_cnt]
			l_recs[l_cnt].ball_irisu				= l_ds.object.ball_irisu[l_cnt]
			l_recs[l_cnt].tani_kbn					= l_ds.object.tani_kbn[l_cnt]
			l_recs[l_cnt].hatyu_tanni_su			= l_ds.object.hatyu_tanni_su[l_cnt]
			l_recs[l_cnt].hanbai_tanni_su			= l_ds.object.hanbai_tanni_su[l_cnt]
			l_recs[l_cnt].rank						= l_ds.object.rank[l_cnt]
			l_recs[l_cnt].seihin_syohin_kbn			= l_ds.object.seihin_syohin_kbn[l_cnt]
			l_recs[l_cnt].irisu_hyoji_kbn			= l_ds.object.irisu_hyoji_kbn[l_cnt]
			l_recs[l_cnt].keikaku_kbn				= l_ds.object.keikaku_kbn[l_cnt]
			l_recs[l_cnt].hatyu_kbn					= l_ds.object.hatyu_kbn[l_cnt]
			l_recs[l_cnt].hatyusaki_kbn				= l_ds.object.hatyusaki_kbn[l_cnt]
			l_recs[l_cnt].syozai_kbn				= l_ds.object.syozai_kbn[l_cnt]
			l_recs[l_cnt].syokuti_flg				= l_ds.object.syokuti_flg[l_cnt]
			l_recs[l_cnt].zaiko_kanri_flg			= l_ds.object.zaiko_kanri_flg[l_cnt]
			l_recs[l_cnt].suryo_keisan_flg			= l_ds.object.suryo_keisan_flg[l_cnt]
			l_recs[l_cnt].kingaku_keisan_flg		= l_ds.object.kingaku_keisan_flg[l_cnt]
			l_recs[l_cnt].arari_keisan_flg			= l_ds.object.arari_keisan_flg[l_cnt]
			l_recs[l_cnt].hako_keisan_flg			= l_ds.object.hako_keisan_flg[l_cnt]
			l_recs[l_cnt].kenpin_taisyo_flg			= l_ds.object.kenpin_taisyo_flg[l_cnt]
			l_recs[l_cnt].muryo_kyoka_flg			= l_ds.object.muryo_kyoka_flg[l_cnt]
			l_recs[l_cnt].bhin_flg					= l_ds.object.bhin_flg[l_cnt]
			l_recs[l_cnt].tankahyo_hakkou_kbn		= l_ds.object.tankahyo_hakkou_kbn[l_cnt]
			l_recs[l_cnt].kankyo_hairyo_flg			= l_ds.object.kankyo_hairyo_flg[l_cnt]
			l_recs[l_cnt].zeiritu_kbn				= l_ds.object.zeiritu_kbn[l_cnt]
			l_recs[l_cnt].siirehin_flg				= l_ds.object.siirehin_flg[l_cnt]
			l_recs[l_cnt].kuuyu_kinsi_flg			= l_ds.object.kuuyu_kinsi_flg[l_cnt]
			l_recs[l_cnt].sozai						= l_ds.object.sozai[l_cnt]
			l_recs[l_cnt].konritu_1					= l_ds.object.konritu_1[l_cnt]
			l_recs[l_cnt].konritu_2					= l_ds.object.konritu_2[l_cnt]
			l_recs[l_cnt].konritu_3					= l_ds.object.konritu_3[l_cnt]
			l_recs[l_cnt].konritu_4					= l_ds.object.konritu_4[l_cnt]
			l_recs[l_cnt].konritu_5					= l_ds.object.konritu_5[l_cnt]
			l_recs[l_cnt].konritu_6					= l_ds.object.konritu_6[l_cnt]
			l_recs[l_cnt].konritu_7					= l_ds.object.konritu_7[l_cnt]
			l_recs[l_cnt].konritu_8					= l_ds.object.konritu_8[l_cnt]
			l_recs[l_cnt].konritu_9					= l_ds.object.konritu_9[l_cnt]
			l_recs[l_cnt].konritu_10				= l_ds.object.konritu_10[l_cnt]
			l_recs[l_cnt].seisankoku_code			= l_ds.object.seisankoku_code[l_cnt]
			l_recs[l_cnt].yoki_kami					= l_ds.object.yoki_kami[l_cnt]
			l_recs[l_cnt].yoki_pla					= l_ds.object.yoki_pla[l_cnt]
			l_recs[l_cnt].housou_kami				= l_ds.object.housou_kami[l_cnt]
			l_recs[l_cnt].housou_pla				= l_ds.object.housou_pla[l_cnt]
			l_recs[l_cnt].sunpo_tate				= l_ds.object.sunpo_tate[l_cnt]
			l_recs[l_cnt].sunpo_yoko				= l_ds.object.sunpo_yoko[l_cnt]
			l_recs[l_cnt].sunpo_takasa				= l_ds.object.sunpo_takasa[l_cnt]
			l_recs[l_cnt].jyuryo					= l_ds.object.jyuryo[l_cnt]
			l_recs[l_cnt].tijimi_ritu				= l_ds.object.tijimi_ritu[l_cnt]
			l_recs[l_cnt].flg_1						= l_ds.object.flg_1[l_cnt]
			l_recs[l_cnt].flg_2						= l_ds.object.flg_2[l_cnt]
			l_recs[l_cnt].flg_3						= l_ds.object.flg_3[l_cnt]
			l_recs[l_cnt].flg_4						= l_ds.object.flg_4[l_cnt]
			l_recs[l_cnt].flg_5						= l_ds.object.flg_5[l_cnt]
			l_recs[l_cnt].kbn_1						= l_ds.object.kbn_1[l_cnt]
			l_recs[l_cnt].kbn_2						= l_ds.object.kbn_2[l_cnt]
			l_recs[l_cnt].kbn_3						= l_ds.object.kbn_3[l_cnt]
			l_recs[l_cnt].kbn_4						= l_ds.object.kbn_4[l_cnt]
			l_recs[l_cnt].kbn_5						= l_ds.object.kbn_5[l_cnt]
			l_recs[l_cnt].touroku_kbn				= l_ds.object.touroku_kbn[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_checks (long p_seikyu_code);
integer	l_ret

declare orafunc procedure for mtokui.chks( :p_seikyu_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_tokui_gets (long p_seikyu_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku,tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code," )
fnc.strg.of_append_line( l_sql, "       nayose_code,seikyu_code," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.gets( {1} ) )", string( p_seikyu_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code			= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full		= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei				= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai		= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku		= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana		= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].bumon_code			= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code			= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].nayose_code			= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].seikyu_code			= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].syohizei_kbn			= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn	= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].syusoku_flg			= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].unso_code				= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].todofuken_code		= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code		= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no				= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo				= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no				= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no				= l_ds.object.fax_no[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_gets_full (long p_seikyu_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       tokui_kbn,gyotai_kbn," )
fnc.strg.of_append_line( l_sql, "       syokuti_flg," )
fnc.strg.of_append_line( l_sql, "       torihiki_code,jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       houjin_no," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code,tanto_code_new," )
fnc.strg.of_append_line( l_sql, "       nayose_code,nayose_eda," )
fnc.strg.of_append_line( l_sql, "       seikyu_code,seikyu_eda," )
fnc.strg.of_append_line( l_sql, "       torihiki_jyoken_kbn," )
fnc.strg.of_append_line( l_sql, "       yosin_gendo_gaku," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn,zei_hasu_kbn," )
fnc.strg.of_append_line( l_sql, "       untin_kbn_fax,untin_kbn_net,untin_kbn_edi,untin_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn,torihiki_teisi_riyu," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       kesikomi_flg," )
fnc.strg.of_append_line( l_sql, "       kaisyu_flg,kaisyu_keikoku_flg," )
fnc.strg.of_append_line( l_sql, "       nohinsyo_kbn,nohinsyo_hakkou_kbn,nohinsyo_kingaku_kbn,nohinsyo_kousou_kbn,nohinsyo_kousou_jyun," )
fnc.strg.of_append_line( l_sql, "       seikyusyo_kbn,seikyu_meisai_kbn,seikyu_tanni_kbn," )
fnc.strg.of_append_line( l_sql, "       siharai_kijitu_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       jikai_siharai_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       seikyu_data_kbn," )
fnc.strg.of_append_line( l_sql, "       kijyun_kingaku," )
fnc.strg.of_append_line( l_sql, "       simebi_1,nyukin_tuki_1,nyukin_date_1,nyukin_houhou_1,tegata_site_1," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_1m,nyukin_date_1m,nyukin_houhou_1m,tegata_site_1m," )
fnc.strg.of_append_line( l_sql, "       simebi_2,nyukin_tuki_2,nyukin_date_2,nyukin_houhou_2,tegata_site_2," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_2m,nyukin_date_2m,nyukin_houhou_2m,tegata_site_2m," )
fnc.strg.of_append_line( l_sql, "       tanka_touroku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       leadtime_flg," )
fnc.strg.of_append_line( l_sql, "       saiken_doukou_flg," )
fnc.strg.of_append_line( l_sql, "       jyuten_kbn," )
fnc.strg.of_append_line( l_sql, "       rank," )
fnc.strg.of_append_line( l_sql, "       syukka_yusen_jyun," )
fnc.strg.of_append_line( l_sql, "       syukka_siji_kingaku," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       url," )
fnc.strg.of_append_line( l_sql, "       daihyo_yakusyoku," )
fnc.strg.of_append_line( l_sql, "       daihyo_simei," )
fnc.strg.of_append_line( l_sql, "       sogyo_kbn,sogyo_nen,sogyo_tuki," )
fnc.strg.of_append_line( l_sql, "       kessan_tuki," )
fnc.strg.of_append_line( l_sql, "       gyosyu," )
fnc.strg.of_append_line( l_sql, "       sihonkin," )
fnc.strg.of_append_line( l_sql, "       jyugyoin_su," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_1,torihiki_ginkou_siten_1," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_2,torihiki_ginkou_siten_2," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_3,torihiki_ginkou_siten_3," )
fnc.strg.of_append_line( l_sql, "       siten_su,kojyo_su," )
fnc.strg.of_append_line( l_sql, "       hanbai_saki,siire_saki," )
fnc.strg.of_append_line( l_sql, "       jigyo_naiyo," )
fnc.strg.of_append_line( l_sql, "       gyokai_tii," )
fnc.strg.of_append_line( l_sql, "       torihiki_keii,torihiki_keii_bikou," )
fnc.strg.of_append_line( l_sql, "       baibai_keiyaku_flg," )
fnc.strg.of_append_line( l_sql, "       hosyonin_umu,hosyonin_mei,hosyonin_kankei,hosyokin," )
fnc.strg.of_append_line( l_sql, "       ryoritu_1,ryoritu_tani_1,ryoritu_2,ryoritu_tani_2,ryoritu_3,ryoritu_tani_3,ryoritu_4,ryoritu_tani_4,ryoritu_5,ryoritu_tani_5," )
fnc.strg.of_append_line( l_sql, "       tesuryo_1,tesuryo_tani_1,tesuryo_2,tesuryo_tani_2,tesuryo_3,tesuryo_tani_3,tesuryo_4,tesuryo_tani_4,tesuryo_5,tesuryo_tani_5," )
fnc.strg.of_append_line( l_sql, "       memo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.gets_full( {1} ) )", string( p_seikyu_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full			= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei					= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai			= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku			= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana			= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].tokui_kbn					= l_ds.object.tokui_kbn[l_cnt]
			l_recs[l_cnt].gyotai_kbn				= l_ds.object.gyotai_kbn[l_cnt]
			l_recs[l_cnt].syokuti_flg				= l_ds.object.syokuti_flg[l_cnt]
			l_recs[l_cnt].torihiki_code				= l_ds.object.torihiki_code[l_cnt]
			l_recs[l_cnt].jigyosya_code				= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].houjin_no					= l_ds.object.houjin_no[l_cnt]
			l_recs[l_cnt].bumon_code				= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code				= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].tanto_code_new			= l_ds.object.tanto_code_new[l_cnt]
			l_recs[l_cnt].nayose_code				= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].nayose_eda				= l_ds.object.nayose_eda[l_cnt]
			l_recs[l_cnt].seikyu_code				= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].seikyu_eda				= l_ds.object.seikyu_eda[l_cnt]
			l_recs[l_cnt].torihiki_jyoken_kbn		= l_ds.object.torihiki_jyoken_kbn[l_cnt]
			l_recs[l_cnt].yosin_gendo_gaku			= l_ds.object.yosin_gendo_gaku[l_cnt]
			l_recs[l_cnt].syohizei_kbn				= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].zei_hasu_kbn				= l_ds.object.zei_hasu_kbn[l_cnt]
			l_recs[l_cnt].untin_kbn_fax				= l_ds.object.untin_kbn_fax[l_cnt]
			l_recs[l_cnt].untin_kbn_net				= l_ds.object.untin_kbn_net[l_cnt]
			l_recs[l_cnt].untin_kbn_edi				= l_ds.object.untin_kbn_edi[l_cnt]
			l_recs[l_cnt].untin_kbn					= l_ds.object.untin_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn		= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_riyu		= l_ds.object.torihiki_teisi_riyu[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].kesikomi_flg				= l_ds.object.kesikomi_flg[l_cnt]
			l_recs[l_cnt].kaisyu_flg				= l_ds.object.kaisyu_flg[l_cnt]
			l_recs[l_cnt].kaisyu_keikoku_flg		= l_ds.object.kaisyu_keikoku_flg[l_cnt]
			l_recs[l_cnt].nohinsyo_kbn				= l_ds.object.nohinsyo_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_hakkou_kbn		= l_ds.object.nohinsyo_hakkou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kingaku_kbn		= l_ds.object.nohinsyo_kingaku_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_kbn		= l_ds.object.nohinsyo_kousou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_jyun		= l_ds.object.nohinsyo_kousou_jyun[l_cnt]
			l_recs[l_cnt].seikyusyo_kbn				= l_ds.object.seikyusyo_kbn[l_cnt]
			l_recs[l_cnt].seikyu_meisai_kbn			= l_ds.object.seikyu_meisai_kbn[l_cnt]
			l_recs[l_cnt].seikyu_tanni_kbn			= l_ds.object.seikyu_tanni_kbn[l_cnt]
			l_recs[l_cnt].siharai_kijitu_hyoji_flg	= l_ds.object.siharai_kijitu_hyoji_flg[l_cnt]
			l_recs[l_cnt].jikai_siharai_hyoji_flg	= l_ds.object.jikai_siharai_hyoji_flg[l_cnt]
			l_recs[l_cnt].seikyu_data_kbn			= l_ds.object.seikyu_data_kbn[l_cnt]
			l_recs[l_cnt].kijyun_kingaku			= l_ds.object.kijyun_kingaku[l_cnt]
			l_recs[l_cnt].simebi_1					= l_ds.object.simebi_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1				= l_ds.object.nyukin_tuki_1[l_cnt]
			l_recs[l_cnt].nyukin_date_1				= l_ds.object.nyukin_date_1[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1			= l_ds.object.nyukin_houhou_1[l_cnt]
			l_recs[l_cnt].tegata_site_1				= l_ds.object.tegata_site_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1m			= l_ds.object.nyukin_tuki_1m[l_cnt]
			l_recs[l_cnt].nyukin_date_1m			= l_ds.object.nyukin_date_1m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1m			= l_ds.object.nyukin_houhou_1m[l_cnt]
			l_recs[l_cnt].tegata_site_1m			= l_ds.object.tegata_site_1m[l_cnt]
			l_recs[l_cnt].simebi_2					= l_ds.object.simebi_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2				= l_ds.object.nyukin_tuki_2[l_cnt]
			l_recs[l_cnt].nyukin_date_2				= l_ds.object.nyukin_date_2[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2			= l_ds.object.nyukin_houhou_2[l_cnt]
			l_recs[l_cnt].tegata_site_2				= l_ds.object.tegata_site_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2m			= l_ds.object.nyukin_tuki_2m[l_cnt]
			l_recs[l_cnt].nyukin_date_2m			= l_ds.object.nyukin_date_2m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2m			= l_ds.object.nyukin_houhou_2m[l_cnt]
			l_recs[l_cnt].tegata_site_2m			= l_ds.object.tegata_site_2m[l_cnt]
			l_recs[l_cnt].tanka_touroku_flg			= l_ds.object.tanka_touroku_flg[l_cnt]
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].leadtime_flg				= l_ds.object.leadtime_flg[l_cnt]
			l_recs[l_cnt].saiken_doukou_flg			= l_ds.object.saiken_doukou_flg[l_cnt]
			l_recs[l_cnt].jyuten_kbn				= l_ds.object.jyuten_kbn[l_cnt]
			l_recs[l_cnt].rank						= l_ds.object.rank[l_cnt]
			l_recs[l_cnt].syukka_yusen_jyun			= l_ds.object.syukka_yusen_jyun[l_cnt]
			l_recs[l_cnt].syukka_siji_kingaku		= l_ds.object.syukka_siji_kingaku[l_cnt]
			l_recs[l_cnt].todofuken_code			= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code			= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo					= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].url						= l_ds.object.url[l_cnt]
			l_recs[l_cnt].daihyo_yakusyoku			= l_ds.object.daihyo_yakusyoku[l_cnt]
			l_recs[l_cnt].daihyo_simei				= l_ds.object.daihyo_simei[l_cnt]
			l_recs[l_cnt].sogyo_kbn					= l_ds.object.sogyo_kbn[l_cnt]
			l_recs[l_cnt].sogyo_nen					= l_ds.object.sogyo_nen[l_cnt]
			l_recs[l_cnt].sogyo_tuki				= l_ds.object.sogyo_tuki[l_cnt]
			l_recs[l_cnt].kessan_tuki				= l_ds.object.kessan_tuki[l_cnt]
			l_recs[l_cnt].gyosyu					= l_ds.object.gyosyu[l_cnt]
			l_recs[l_cnt].sihonkin					= l_ds.object.sihonkin[l_cnt]
			l_recs[l_cnt].jyugyoin_su				= l_ds.object.jyugyoin_su[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_1			= l_ds.object.torihiki_ginkou_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_1	= l_ds.object.torihiki_ginkou_siten_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_2			= l_ds.object.torihiki_ginkou_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_2	= l_ds.object.torihiki_ginkou_siten_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_3			= l_ds.object.torihiki_ginkou_3[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_3	= l_ds.object.torihiki_ginkou_siten_3[l_cnt]
			l_recs[l_cnt].siten_su					= l_ds.object.siten_su[l_cnt]
			l_recs[l_cnt].kojyo_su					= l_ds.object.kojyo_su[l_cnt]
			l_recs[l_cnt].hanbai_saki				= l_ds.object.hanbai_saki[l_cnt]
			l_recs[l_cnt].siire_saki				= l_ds.object.siire_saki[l_cnt]
			l_recs[l_cnt].jigyo_naiyo				= l_ds.object.jigyo_naiyo[l_cnt]
			l_recs[l_cnt].gyokai_tii				= l_ds.object.gyokai_tii[l_cnt]
			l_recs[l_cnt].torihiki_keii				= l_ds.object.torihiki_keii[l_cnt]
			l_recs[l_cnt].torihiki_keii_bikou		= l_ds.object.torihiki_keii_bikou[l_cnt]
			l_recs[l_cnt].baibai_keiyaku_flg		= l_ds.object.baibai_keiyaku_flg[l_cnt]
			l_recs[l_cnt].hosyonin_umu				= l_ds.object.hosyonin_umu[l_cnt]
			l_recs[l_cnt].hosyonin_mei				= l_ds.object.hosyonin_mei[l_cnt]
			l_recs[l_cnt].hosyonin_kankei			= l_ds.object.hosyonin_kankei[l_cnt]
			l_recs[l_cnt].hosyokin					= l_ds.object.hosyokin[l_cnt]
			l_recs[l_cnt].ryoritu_1					= l_ds.object.ryoritu_1[l_cnt]
			l_recs[l_cnt].ryoritu_tani_1			= l_ds.object.ryoritu_tani_1[l_cnt]
			l_recs[l_cnt].ryoritu_2					= l_ds.object.ryoritu_2[l_cnt]
			l_recs[l_cnt].ryoritu_tani_2			= l_ds.object.ryoritu_tani_2[l_cnt]
			l_recs[l_cnt].ryoritu_3					= l_ds.object.ryoritu_3[l_cnt]
			l_recs[l_cnt].ryoritu_tani_3			= l_ds.object.ryoritu_tani_3[l_cnt]
			l_recs[l_cnt].ryoritu_4					= l_ds.object.ryoritu_4[l_cnt]
			l_recs[l_cnt].ryoritu_tani_4			= l_ds.object.ryoritu_tani_4[l_cnt]
			l_recs[l_cnt].ryoritu_5					= l_ds.object.ryoritu_5[l_cnt]
			l_recs[l_cnt].ryoritu_tani_5			= l_ds.object.ryoritu_tani_5[l_cnt]
			l_recs[l_cnt].tesuryo_1					= l_ds.object.tesuryo_1[l_cnt]
			l_recs[l_cnt].tesuryo_tani_1			= l_ds.object.tesuryo_tani_1[l_cnt]
			l_recs[l_cnt].tesuryo_2					= l_ds.object.tesuryo_2[l_cnt]
			l_recs[l_cnt].tesuryo_tani_2			= l_ds.object.tesuryo_tani_2[l_cnt]
			l_recs[l_cnt].tesuryo_3					= l_ds.object.tesuryo_3[l_cnt]
			l_recs[l_cnt].tesuryo_tani_3			= l_ds.object.tesuryo_tani_3[l_cnt]
			l_recs[l_cnt].tesuryo_4					= l_ds.object.tesuryo_4[l_cnt]
			l_recs[l_cnt].tesuryo_tani_4			= l_ds.object.tesuryo_tani_4[l_cnt]
			l_recs[l_cnt].tesuryo_5					= l_ds.object.tesuryo_5[l_cnt]
			l_recs[l_cnt].tesuryo_tani_5			= l_ds.object.tesuryo_tani_5[l_cnt]
			l_recs[l_cnt].memo						= l_ds.object.memo[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bunrui_check (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code);
integer	l_ret

declare orafunc procedure for mbunrui.chk( :p_daibunrui_code, :p_tyubunrui_code, :p_syobunrui_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_bunrui_check (long p_daibunrui_code, long p_tyubunrui_code);
long	l_syobunrui_code

setnull( l_syobunrui_code )

return of_bunrui_check( p_daibunrui_code, p_tyubunrui_code, l_syobunrui_code )

end function

public function integer of_bunrui_check (long p_daibunrui_code);
long	l_null

setnull( l_null )

return of_bunrui_check( p_daibunrui_code, l_null, l_null )

end function

public function integer of_bunrui_get_full (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, ref str_mbunrui p_recs[]);
integer		l_cnt
str_mbunrui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select daibunrui_code,tyubunrui_code,syobunrui_code," )
fnc.strg.of_append_line( l_sql, "       daibunrui_mei,tyubunrui_mei,syobunrui_mei," )
fnc.strg.of_append_line( l_sql, "       zaiko_kanri_flg,suryo_keisan_flg,kingaku_keisan_flg," )
fnc.strg.of_append_line( l_sql, "       arari_keisan_flg,hako_keisan_flg,kenpin_taisyo_flg," )
fnc.strg.of_append_line( l_sql, "       muryo_kyoka_flg,bhin_flg," )
fnc.strg.of_append_line( l_sql, "       group_code,brand_code," )
fnc.strg.of_append_line( l_sql, "       bikou," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 中分類コードと小分類コードが未設定の場合は条件に加えない
if isnull( p_tyubunrui_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get_full( {1} ) )", string( p_daibunrui_code ) ) )
else
	if isnull( p_syobunrui_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get_full( {1}, {2} ) )", string( p_daibunrui_code ), string( p_tyubunrui_code ) ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get_full( {1}, {2}, {3} ) )", string( p_daibunrui_code ), string( p_tyubunrui_code ), string( p_syobunrui_code ) ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].daibunrui_code		= l_ds.object.daibunrui_code[l_cnt]
			l_recs[l_cnt].tyubunrui_code		= l_ds.object.tyubunrui_code[l_cnt]
			l_recs[l_cnt].syobunrui_code		= l_ds.object.syobunrui_code[l_cnt]
			l_recs[l_cnt].daibunrui_mei			= l_ds.object.daibunrui_mei[l_cnt]
			l_recs[l_cnt].tyubunrui_mei			= l_ds.object.tyubunrui_mei[l_cnt]
			l_recs[l_cnt].syobunrui_mei			= l_ds.object.syobunrui_mei[l_cnt]
			l_recs[l_cnt].zaiko_kanri_flg		= l_ds.object.zaiko_kanri_flg[l_cnt]
			l_recs[l_cnt].suryo_keisan_flg		= l_ds.object.suryo_keisan_flg[l_cnt]
			l_recs[l_cnt].kingaku_keisan_flg	= l_ds.object.kingaku_keisan_flg[l_cnt]
			l_recs[l_cnt].arari_keisan_flg		= l_ds.object.arari_keisan_flg[l_cnt]
			l_recs[l_cnt].hako_keisan_flg		= l_ds.object.hako_keisan_flg[l_cnt]
			l_recs[l_cnt].kenpin_taisyo_flg		= l_ds.object.kenpin_taisyo_flg[l_cnt]
			l_recs[l_cnt].muryo_kyoka_flg		= l_ds.object.muryo_kyoka_flg[l_cnt]
			l_recs[l_cnt].bhin_flg				= l_ds.object.bhin_flg[l_cnt]
			l_recs[l_cnt].group_code			= l_ds.object.group_code[l_cnt]
			l_recs[l_cnt].brand_code			= l_ds.object.brand_code[l_cnt]
			l_recs[l_cnt].bikou					= l_ds.object.bikou[l_cnt]
			l_recs[l_cnt].touroku_date			= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id		= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id		= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id			= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date			= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id		= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id		= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id			= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date			= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id		= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id		= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id			= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg				= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bunrui_get_full (long p_daibunrui_code, long p_tyubunrui_code, ref str_mbunrui p_recs[]);
long	l_syobunrui_code

setnull( l_syobunrui_code )

return of_bunrui_get_full( p_daibunrui_code, p_tyubunrui_code, l_syobunrui_code, p_recs )
end function

public function integer of_bunrui_get_full (long p_daibunrui_code, ref str_mbunrui p_recs[]);
long	l_tyubunrui_code, l_syobunrui_code

setnull( l_tyubunrui_code )
setnull( l_syobunrui_code )

return of_bunrui_get_full( p_daibunrui_code, l_tyubunrui_code, l_syobunrui_code, p_recs )
end function

public function integer of_bunrui_get (long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, ref str_mbunrui p_recs[]);
integer		l_cnt
str_mbunrui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select daibunrui_code,tyubunrui_code,syobunrui_code," )
fnc.strg.of_append_line( l_sql, "       daibunrui_mei,tyubunrui_mei,syobunrui_mei" )

// 中分類コードと小分類コードが未設定の場合は条件に加えない
if isnull( p_tyubunrui_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get( {1} ) )", string( p_daibunrui_code ) ) )
else
	if isnull( p_syobunrui_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get( {1}, {2} ) )", string( p_daibunrui_code ), string( p_tyubunrui_code ) ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.get( {1}, {2}, {3} ) )", string( p_daibunrui_code ), string( p_tyubunrui_code ), string( p_syobunrui_code ) ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].daibunrui_code		= l_ds.object.daibunrui_code[l_cnt]
			l_recs[l_cnt].tyubunrui_code		= l_ds.object.tyubunrui_code[l_cnt]
			l_recs[l_cnt].syobunrui_code		= l_ds.object.syobunrui_code[l_cnt]
			l_recs[l_cnt].daibunrui_mei			= l_ds.object.daibunrui_mei[l_cnt]
			l_recs[l_cnt].tyubunrui_mei			= l_ds.object.tyubunrui_mei[l_cnt]
			l_recs[l_cnt].syobunrui_mei			= l_ds.object.syobunrui_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bunrui_get (long p_daibunrui_code, long p_tyubunrui_code, ref str_mbunrui p_recs[]);
long	l_syobunrui_code

setnull( l_syobunrui_code )

return of_bunrui_get( p_daibunrui_code, p_tyubunrui_code, l_syobunrui_code, p_recs )
end function

public function integer of_bunrui_get (long p_daibunrui_code, ref str_mbunrui p_recs[]);
long	l_tyubunrui_code, l_syobunrui_code

setnull( l_tyubunrui_code )
setnull( l_syobunrui_code )

return of_bunrui_get( p_daibunrui_code, l_tyubunrui_code, l_syobunrui_code, p_recs )
end function

public function integer of_bukken_check (long p_bukken_code);
integer	l_ret

declare orafunc procedure for mbukken.chk( :p_bukken_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_bukken_get_full (long p_bukken_code, ref str_mbukken p_recs[]);
integer		l_cnt
str_mbukken	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select bukken_code,bukken_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_code," )
fnc.strg.of_append_line( l_sql, "       bukken_jyouhou," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbukken.get_full( {1} ) )", string( p_bukken_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].bukken_code		= l_ds.object.bukken_code[l_cnt]
			l_recs[l_cnt].bukken_mei		= l_ds.object.bukken_mei[l_cnt]
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].bukken_jyouhou	= l_ds.object.bukken_jyouhou[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bukken_get (long p_bukken_code, ref str_mbukken p_recs[]);
integer		l_cnt
str_mbukken	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select bukken_code,bukken_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_code," )
fnc.strg.of_append_line( l_sql, "       bukken_jyouhou" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbukken.get( {1} ) )", string( p_bukken_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].bukken_code		= l_ds.object.bukken_code[l_cnt]
			l_recs[l_cnt].bukken_mei		= l_ds.object.bukken_mei[l_cnt]
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].bukken_jyouhou	= l_ds.object.bukken_jyouhou[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_group_check (long p_group_code);
integer	l_ret

declare orafunc procedure for mgroup.chk( :p_group_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_group_get_full (long p_group_code, ref str_mgroup p_recs[]);
integer		l_cnt
str_mgroup	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select group_code," )
fnc.strg.of_append_line( l_sql, "       group_mei,group_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgroup.get_full( {1} ) )", string( p_group_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].group_code		= l_ds.object.group_code[l_cnt]
			l_recs[l_cnt].group_mei			= l_ds.object.group_mei[l_cnt]
			l_recs[l_cnt].group_mei_ryaku	= l_ds.object.group_mei_ryaku[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_group_get (long p_group_code, ref str_mgroup p_recs[]);
integer		l_cnt
str_mgroup	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select group_code," )
fnc.strg.of_append_line( l_sql, "       group_mei,group_mei_ryaku" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgroup.get( {1} ) )", string( p_group_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].group_code		= l_ds.object.group_code[l_cnt]
			l_recs[l_cnt].group_mei			= l_ds.object.group_mei[l_cnt]
			l_recs[l_cnt].group_mei_ryaku	= l_ds.object.group_mei_ryaku[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_brand_check (long p_brand_code);
integer	l_ret

declare orafunc procedure for mbrand.chk( :p_brand_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_brand_get_full (long p_brand_code, ref str_mbrand p_recs[]);
integer		l_cnt
str_mbrand	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select brand_code," )
fnc.strg.of_append_line( l_sql, "       brand_mei,brand_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbrand.get_full( {1} ) )", string( p_brand_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].brand_code		= l_ds.object.brand_code[l_cnt]
			l_recs[l_cnt].brand_mei			= l_ds.object.brand_mei[l_cnt]
			l_recs[l_cnt].brand_mei_ryaku	= l_ds.object.brand_mei_ryaku[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_brand_get (long p_brand_code, ref str_mbrand p_recs[]);
integer		l_cnt
str_mbrand	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select brand_code," )
fnc.strg.of_append_line( l_sql, "       brand_mei,brand_mei_ryaku" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbrand.get( {1} ) )", string( p_brand_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].brand_code		= l_ds.object.brand_code[l_cnt]
			l_recs[l_cnt].brand_mei			= l_ds.object.brand_mei[l_cnt]
			l_recs[l_cnt].brand_mei_ryaku	= l_ds.object.brand_mei_ryaku[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_niokurinin_check (long p_niokurinin_code);
integer	l_ret

declare orafunc procedure for mniokurinin.chk( :p_niokurinin_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_niokurinin_get (long p_niokurinin_code, ref str_mniokurinin p_recs[]);
integer			l_cnt
str_mniokurinin	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select niokurinin_code," )
fnc.strg.of_append_line( l_sql, "       kanri_mei," )
fnc.strg.of_append_line( l_sql, "       niokurinin_mei" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mniokurinin.get( {1} ) )", string( p_niokurinin_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].niokurinin_code	= l_ds.object.niokurinin_code[l_cnt]
			l_recs[l_cnt].kanri_mei			= l_ds.object.kanri_mei[l_cnt]
			l_recs[l_cnt].niokurinin_mei	= l_ds.object.niokurinin_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_niokurinin_get_full (long p_niokurinin_code, ref str_mniokurinin p_recs[]);
integer			l_cnt
str_mniokurinin	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select niokurinin_code," )
fnc.strg.of_append_line( l_sql, "       kanri_mei," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo1,jyusyo2," )
fnc.strg.of_append_line( l_sql, "       niokurinin_mei," )
fnc.strg.of_append_line( l_sql, "       tel_no," )
fnc.strg.of_append_line( l_sql, "       memo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mniokurinin.get_full( {1} ) )", string( p_niokurinin_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].niokurinin_code	= l_ds.object.niokurinin_code[l_cnt]
			l_recs[l_cnt].kanri_mei			= l_ds.object.kanri_mei[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo1			= l_ds.object.jyusyo1[l_cnt]
			l_recs[l_cnt].jyusyo2			= l_ds.object.jyusyo2[l_cnt]
			l_recs[l_cnt].niokurinin_mei	= l_ds.object.niokurinin_mei[l_cnt]
			l_recs[l_cnt].tel_no			= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].memo				= l_ds.object.memo[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_yubin_get_full (string p_yubin_no, ref str_myubin p_recs[]);
integer		l_cnt
str_myubin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select data_kbn," )
fnc.strg.of_append_line( l_sql, "       jis_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no_old,yubin_no," )
fnc.strg.of_append_line( l_sql, "       todofu_kana,sikutyo_kana,tyoiki_kana," )
fnc.strg.of_append_line( l_sql, "       todofu_mei,sikutyo_mei,tyoiki_mei," )
fnc.strg.of_append_line( l_sql, "       tyome," )
fnc.strg.of_append_line( l_sql, "       jigyosyo_mei," )
fnc.strg.of_append_line( l_sql, "       full_mei," )
fnc.strg.of_append_line( l_sql, "       kbn_1,kbn_2,kbn_3,kbn_4,kbn_5," )
fnc.strg.of_append_line( l_sql, "       kbn_6,kbn_7,kbn_8,kbn_9," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( myubin.get_full( '{1}' ) )", string( p_yubin_no ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].data_kbn			= l_ds.object.data_kbn[l_cnt]
			l_recs[l_cnt].jis_code			= l_ds.object.jis_code[l_cnt]
			l_recs[l_cnt].yubin_no_old		= l_ds.object.yubin_no_old[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].todofu_kana		= l_ds.object.todofu_kana[l_cnt]
			l_recs[l_cnt].sikutyo_kana		= l_ds.object.sikutyo_kana[l_cnt]
			l_recs[l_cnt].tyoiki_kana		= l_ds.object.tyoiki_kana[l_cnt]
			l_recs[l_cnt].todofu_mei		= l_ds.object.todofu_mei[l_cnt]
			l_recs[l_cnt].sikutyo_mei		= l_ds.object.sikutyo_mei[l_cnt]
			l_recs[l_cnt].tyoiki_mei		= l_ds.object.tyoiki_mei[l_cnt]
			l_recs[l_cnt].tyome				= l_ds.object.tyome[l_cnt]
			l_recs[l_cnt].jigyosyo_mei		= l_ds.object.jigyosyo_mei[l_cnt]
			l_recs[l_cnt].full_mei			= l_ds.object.full_mei[l_cnt]
			l_recs[l_cnt].kbn_1				= l_ds.object.kbn_1[l_cnt]
			l_recs[l_cnt].kbn_2				= l_ds.object.kbn_2[l_cnt]
			l_recs[l_cnt].kbn_3				= l_ds.object.kbn_3[l_cnt]
			l_recs[l_cnt].kbn_4				= l_ds.object.kbn_4[l_cnt]
			l_recs[l_cnt].kbn_5				= l_ds.object.kbn_5[l_cnt]
			l_recs[l_cnt].kbn_6				= l_ds.object.kbn_6[l_cnt]
			l_recs[l_cnt].kbn_7				= l_ds.object.kbn_7[l_cnt]
			l_recs[l_cnt].kbn_8				= l_ds.object.kbn_8[l_cnt]
			l_recs[l_cnt].kbn_9				= l_ds.object.kbn_9[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bunrui_gett (long p_tyubunrui_code, ref str_mbunrui p_recs[]);
integer		l_cnt
str_mbunrui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select daibunrui_code,tyubunrui_code,syobunrui_code," )
fnc.strg.of_append_line( l_sql, "       daibunrui_mei,tyubunrui_mei,syobunrui_mei" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.gett( {1} ) )", string( p_tyubunrui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].daibunrui_code		= l_ds.object.daibunrui_code[l_cnt]
			l_recs[l_cnt].tyubunrui_code		= l_ds.object.tyubunrui_code[l_cnt]
			l_recs[l_cnt].syobunrui_code		= l_ds.object.syobunrui_code[l_cnt]
			l_recs[l_cnt].daibunrui_mei			= l_ds.object.daibunrui_mei[l_cnt]
			l_recs[l_cnt].tyubunrui_mei			= l_ds.object.tyubunrui_mei[l_cnt]
			l_recs[l_cnt].syobunrui_mei			= l_ds.object.syobunrui_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_bunrui_gets (long p_syobunrui_code, ref str_mbunrui p_recs[]);
integer		l_cnt
str_mbunrui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select daibunrui_code,tyubunrui_code,syobunrui_code," )
fnc.strg.of_append_line( l_sql, "       daibunrui_mei,tyubunrui_mei,syobunrui_mei" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mbunrui.gets( {1} ) )", string( p_syobunrui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].daibunrui_code		= l_ds.object.daibunrui_code[l_cnt]
			l_recs[l_cnt].tyubunrui_code		= l_ds.object.tyubunrui_code[l_cnt]
			l_recs[l_cnt].syobunrui_code		= l_ds.object.syobunrui_code[l_cnt]
			l_recs[l_cnt].daibunrui_mei			= l_ds.object.daibunrui_mei[l_cnt]
			l_recs[l_cnt].tyubunrui_mei			= l_ds.object.tyubunrui_mei[l_cnt]
			l_recs[l_cnt].syobunrui_mei			= l_ds.object.syobunrui_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_checkn (long p_nayose_code);
integer	l_ret

declare orafunc procedure for mtokui.chkn( :p_nayose_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_tokui_getn (long p_nayose_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku,tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code," )
fnc.strg.of_append_line( l_sql, "       nayose_code,seikyu_code," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.getn( {1} ) )", string( p_nayose_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code			= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full		= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei				= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai		= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku		= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana		= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].bumon_code			= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code			= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].nayose_code			= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].seikyu_code			= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].syohizei_kbn			= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn	= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].syusoku_flg			= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].unso_code				= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].todofuken_code		= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code		= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no				= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo				= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no				= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no				= l_ds.object.fax_no[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_getn_full (long p_nayose_code, ref str_mtokui p_recs[]);
integer		l_cnt
str_mtokui	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_full,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_syagai,tokui_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_kana," )
fnc.strg.of_append_line( l_sql, "       tokui_kbn,gyotai_kbn," )
fnc.strg.of_append_line( l_sql, "       syokuti_flg," )
fnc.strg.of_append_line( l_sql, "       torihiki_code,jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       houjin_no," )
fnc.strg.of_append_line( l_sql, "       bumon_code," )
fnc.strg.of_append_line( l_sql, "       tanto_code,tanto_code_new," )
fnc.strg.of_append_line( l_sql, "       nayose_code,nayose_eda," )
fnc.strg.of_append_line( l_sql, "       seikyu_code,seikyu_eda," )
fnc.strg.of_append_line( l_sql, "       torihiki_jyoken_kbn," )
fnc.strg.of_append_line( l_sql, "       yosin_gendo_gaku," )
fnc.strg.of_append_line( l_sql, "       syohizei_kbn,zei_hasu_kbn," )
fnc.strg.of_append_line( l_sql, "       untin_kbn_fax,untin_kbn_net,untin_kbn_edi,untin_kbn," )
fnc.strg.of_append_line( l_sql, "       torihiki_teisi_kbn,torihiki_teisi_riyu," )
fnc.strg.of_append_line( l_sql, "       syusoku_flg," )
fnc.strg.of_append_line( l_sql, "       kesikomi_flg," )
fnc.strg.of_append_line( l_sql, "       kaisyu_flg,kaisyu_keikoku_flg," )
fnc.strg.of_append_line( l_sql, "       nohinsyo_kbn,nohinsyo_hakkou_kbn,nohinsyo_kingaku_kbn,nohinsyo_kousou_kbn,nohinsyo_kousou_jyun," )
fnc.strg.of_append_line( l_sql, "       seikyusyo_kbn,seikyu_meisai_kbn,seikyu_tanni_kbn," )
fnc.strg.of_append_line( l_sql, "       siharai_kijitu_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       jikai_siharai_hyoji_flg," )
fnc.strg.of_append_line( l_sql, "       seikyu_data_kbn," )
fnc.strg.of_append_line( l_sql, "       kijyun_kingaku," )
fnc.strg.of_append_line( l_sql, "       simebi_1,nyukin_tuki_1,nyukin_date_1,nyukin_houhou_1,tegata_site_1," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_1m,nyukin_date_1m,nyukin_houhou_1m,tegata_site_1m," )
fnc.strg.of_append_line( l_sql, "       simebi_2,nyukin_tuki_2,nyukin_date_2,nyukin_houhou_2,tegata_site_2," )
fnc.strg.of_append_line( l_sql, "       nyukin_tuki_2m,nyukin_date_2m,nyukin_houhou_2m,tegata_site_2m," )
fnc.strg.of_append_line( l_sql, "       tanka_touroku_flg," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       leadtime_flg," )
fnc.strg.of_append_line( l_sql, "       saiken_doukou_flg," )
fnc.strg.of_append_line( l_sql, "       jyuten_kbn," )
fnc.strg.of_append_line( l_sql, "       rank," )
fnc.strg.of_append_line( l_sql, "       syukka_yusen_jyun," )
fnc.strg.of_append_line( l_sql, "       syukka_siji_kingaku," )
fnc.strg.of_append_line( l_sql, "       todofuken_code,sikutyoson_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       url," )
fnc.strg.of_append_line( l_sql, "       daihyo_yakusyoku," )
fnc.strg.of_append_line( l_sql, "       daihyo_simei," )
fnc.strg.of_append_line( l_sql, "       sogyo_kbn,sogyo_nen,sogyo_tuki," )
fnc.strg.of_append_line( l_sql, "       kessan_tuki," )
fnc.strg.of_append_line( l_sql, "       gyosyu," )
fnc.strg.of_append_line( l_sql, "       sihonkin," )
fnc.strg.of_append_line( l_sql, "       jyugyoin_su," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_1,torihiki_ginkou_siten_1," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_2,torihiki_ginkou_siten_2," )
fnc.strg.of_append_line( l_sql, "       torihiki_ginkou_3,torihiki_ginkou_siten_3," )
fnc.strg.of_append_line( l_sql, "       siten_su,kojyo_su," )
fnc.strg.of_append_line( l_sql, "       hanbai_saki,siire_saki," )
fnc.strg.of_append_line( l_sql, "       jigyo_naiyo," )
fnc.strg.of_append_line( l_sql, "       gyokai_tii," )
fnc.strg.of_append_line( l_sql, "       torihiki_keii,torihiki_keii_bikou," )
fnc.strg.of_append_line( l_sql, "       baibai_keiyaku_flg," )
fnc.strg.of_append_line( l_sql, "       hosyonin_umu,hosyonin_mei,hosyonin_kankei,hosyokin," )
fnc.strg.of_append_line( l_sql, "       ryoritu_1,ryoritu_tani_1,ryoritu_2,ryoritu_tani_2,ryoritu_3,ryoritu_tani_3,ryoritu_4,ryoritu_tani_4,ryoritu_5,ryoritu_tani_5," )
fnc.strg.of_append_line( l_sql, "       tesuryo_1,tesuryo_tani_1,tesuryo_2,tesuryo_tani_2,tesuryo_3,tesuryo_tani_3,tesuryo_4,tesuryo_tani_4,tesuryo_5,tesuryo_tani_5," )
fnc.strg.of_append_line( l_sql, "       memo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui.getn_full( {1} ) )", string( p_nayose_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tokui_mei_full			= l_ds.object.tokui_mei_full[l_cnt]
			l_recs[l_cnt].tokui_mei					= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].tokui_mei_syagai			= l_ds.object.tokui_mei_syagai[l_cnt]
			l_recs[l_cnt].tokui_mei_ryaku			= l_ds.object.tokui_mei_ryaku[l_cnt]
			l_recs[l_cnt].tokui_mei_kana			= l_ds.object.tokui_mei_kana[l_cnt]
			l_recs[l_cnt].tokui_kbn					= l_ds.object.tokui_kbn[l_cnt]
			l_recs[l_cnt].gyotai_kbn				= l_ds.object.gyotai_kbn[l_cnt]
			l_recs[l_cnt].syokuti_flg				= l_ds.object.syokuti_flg[l_cnt]
			l_recs[l_cnt].torihiki_code				= l_ds.object.torihiki_code[l_cnt]
			l_recs[l_cnt].jigyosya_code				= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].houjin_no					= l_ds.object.houjin_no[l_cnt]
			l_recs[l_cnt].bumon_code				= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].tanto_code				= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].tanto_code_new			= l_ds.object.tanto_code_new[l_cnt]
			l_recs[l_cnt].nayose_code				= l_ds.object.nayose_code[l_cnt]
			l_recs[l_cnt].nayose_eda				= l_ds.object.nayose_eda[l_cnt]
			l_recs[l_cnt].seikyu_code				= l_ds.object.seikyu_code[l_cnt]
			l_recs[l_cnt].seikyu_eda				= l_ds.object.seikyu_eda[l_cnt]
			l_recs[l_cnt].torihiki_jyoken_kbn		= l_ds.object.torihiki_jyoken_kbn[l_cnt]
			l_recs[l_cnt].yosin_gendo_gaku			= l_ds.object.yosin_gendo_gaku[l_cnt]
			l_recs[l_cnt].syohizei_kbn				= l_ds.object.syohizei_kbn[l_cnt]
			l_recs[l_cnt].zei_hasu_kbn				= l_ds.object.zei_hasu_kbn[l_cnt]
			l_recs[l_cnt].untin_kbn_fax				= l_ds.object.untin_kbn_fax[l_cnt]
			l_recs[l_cnt].untin_kbn_net				= l_ds.object.untin_kbn_net[l_cnt]
			l_recs[l_cnt].untin_kbn_edi				= l_ds.object.untin_kbn_edi[l_cnt]
			l_recs[l_cnt].untin_kbn					= l_ds.object.untin_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_kbn		= l_ds.object.torihiki_teisi_kbn[l_cnt]
			l_recs[l_cnt].torihiki_teisi_riyu		= l_ds.object.torihiki_teisi_riyu[l_cnt]
			l_recs[l_cnt].syusoku_flg				= l_ds.object.syusoku_flg[l_cnt]
			l_recs[l_cnt].kesikomi_flg				= l_ds.object.kesikomi_flg[l_cnt]
			l_recs[l_cnt].kaisyu_flg				= l_ds.object.kaisyu_flg[l_cnt]
			l_recs[l_cnt].kaisyu_keikoku_flg		= l_ds.object.kaisyu_keikoku_flg[l_cnt]
			l_recs[l_cnt].nohinsyo_kbn				= l_ds.object.nohinsyo_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_hakkou_kbn		= l_ds.object.nohinsyo_hakkou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kingaku_kbn		= l_ds.object.nohinsyo_kingaku_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_kbn		= l_ds.object.nohinsyo_kousou_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_kousou_jyun		= l_ds.object.nohinsyo_kousou_jyun[l_cnt]
			l_recs[l_cnt].seikyusyo_kbn				= l_ds.object.seikyusyo_kbn[l_cnt]
			l_recs[l_cnt].seikyu_meisai_kbn			= l_ds.object.seikyu_meisai_kbn[l_cnt]
			l_recs[l_cnt].seikyu_tanni_kbn			= l_ds.object.seikyu_tanni_kbn[l_cnt]
			l_recs[l_cnt].siharai_kijitu_hyoji_flg	= l_ds.object.siharai_kijitu_hyoji_flg[l_cnt]
			l_recs[l_cnt].jikai_siharai_hyoji_flg	= l_ds.object.jikai_siharai_hyoji_flg[l_cnt]
			l_recs[l_cnt].seikyu_data_kbn			= l_ds.object.seikyu_data_kbn[l_cnt]
			l_recs[l_cnt].kijyun_kingaku			= l_ds.object.kijyun_kingaku[l_cnt]
			l_recs[l_cnt].simebi_1					= l_ds.object.simebi_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1				= l_ds.object.nyukin_tuki_1[l_cnt]
			l_recs[l_cnt].nyukin_date_1				= l_ds.object.nyukin_date_1[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1			= l_ds.object.nyukin_houhou_1[l_cnt]
			l_recs[l_cnt].tegata_site_1				= l_ds.object.tegata_site_1[l_cnt]
			l_recs[l_cnt].nyukin_tuki_1m			= l_ds.object.nyukin_tuki_1m[l_cnt]
			l_recs[l_cnt].nyukin_date_1m			= l_ds.object.nyukin_date_1m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_1m			= l_ds.object.nyukin_houhou_1m[l_cnt]
			l_recs[l_cnt].tegata_site_1m			= l_ds.object.tegata_site_1m[l_cnt]
			l_recs[l_cnt].simebi_2					= l_ds.object.simebi_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2				= l_ds.object.nyukin_tuki_2[l_cnt]
			l_recs[l_cnt].nyukin_date_2				= l_ds.object.nyukin_date_2[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2			= l_ds.object.nyukin_houhou_2[l_cnt]
			l_recs[l_cnt].tegata_site_2				= l_ds.object.tegata_site_2[l_cnt]
			l_recs[l_cnt].nyukin_tuki_2m			= l_ds.object.nyukin_tuki_2m[l_cnt]
			l_recs[l_cnt].nyukin_date_2m			= l_ds.object.nyukin_date_2m[l_cnt]
			l_recs[l_cnt].nyukin_houhou_2m			= l_ds.object.nyukin_houhou_2m[l_cnt]
			l_recs[l_cnt].tegata_site_2m			= l_ds.object.tegata_site_2m[l_cnt]
			l_recs[l_cnt].tanka_touroku_flg			= l_ds.object.tanka_touroku_flg[l_cnt]
			l_recs[l_cnt].unso_code					= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].leadtime_flg				= l_ds.object.leadtime_flg[l_cnt]
			l_recs[l_cnt].saiken_doukou_flg			= l_ds.object.saiken_doukou_flg[l_cnt]
			l_recs[l_cnt].jyuten_kbn				= l_ds.object.jyuten_kbn[l_cnt]
			l_recs[l_cnt].rank						= l_ds.object.rank[l_cnt]
			l_recs[l_cnt].syukka_yusen_jyun			= l_ds.object.syukka_yusen_jyun[l_cnt]
			l_recs[l_cnt].syukka_siji_kingaku		= l_ds.object.syukka_siji_kingaku[l_cnt]
			l_recs[l_cnt].todofuken_code			= l_ds.object.todofuken_code[l_cnt]
			l_recs[l_cnt].sikutyoson_code			= l_ds.object.sikutyoson_code[l_cnt]
			l_recs[l_cnt].yubin_no					= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo					= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tel_no					= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no					= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].url						= l_ds.object.url[l_cnt]
			l_recs[l_cnt].daihyo_yakusyoku			= l_ds.object.daihyo_yakusyoku[l_cnt]
			l_recs[l_cnt].daihyo_simei				= l_ds.object.daihyo_simei[l_cnt]
			l_recs[l_cnt].sogyo_kbn					= l_ds.object.sogyo_kbn[l_cnt]
			l_recs[l_cnt].sogyo_nen					= l_ds.object.sogyo_nen[l_cnt]
			l_recs[l_cnt].sogyo_tuki				= l_ds.object.sogyo_tuki[l_cnt]
			l_recs[l_cnt].kessan_tuki				= l_ds.object.kessan_tuki[l_cnt]
			l_recs[l_cnt].gyosyu					= l_ds.object.gyosyu[l_cnt]
			l_recs[l_cnt].sihonkin					= l_ds.object.sihonkin[l_cnt]
			l_recs[l_cnt].jyugyoin_su				= l_ds.object.jyugyoin_su[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_1			= l_ds.object.torihiki_ginkou_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_1	= l_ds.object.torihiki_ginkou_siten_1[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_2			= l_ds.object.torihiki_ginkou_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_2	= l_ds.object.torihiki_ginkou_siten_2[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_3			= l_ds.object.torihiki_ginkou_3[l_cnt]
			l_recs[l_cnt].torihiki_ginkou_siten_3	= l_ds.object.torihiki_ginkou_siten_3[l_cnt]
			l_recs[l_cnt].siten_su					= l_ds.object.siten_su[l_cnt]
			l_recs[l_cnt].kojyo_su					= l_ds.object.kojyo_su[l_cnt]
			l_recs[l_cnt].hanbai_saki				= l_ds.object.hanbai_saki[l_cnt]
			l_recs[l_cnt].siire_saki				= l_ds.object.siire_saki[l_cnt]
			l_recs[l_cnt].jigyo_naiyo				= l_ds.object.jigyo_naiyo[l_cnt]
			l_recs[l_cnt].gyokai_tii				= l_ds.object.gyokai_tii[l_cnt]
			l_recs[l_cnt].torihiki_keii				= l_ds.object.torihiki_keii[l_cnt]
			l_recs[l_cnt].torihiki_keii_bikou		= l_ds.object.torihiki_keii_bikou[l_cnt]
			l_recs[l_cnt].baibai_keiyaku_flg		= l_ds.object.baibai_keiyaku_flg[l_cnt]
			l_recs[l_cnt].hosyonin_umu				= l_ds.object.hosyonin_umu[l_cnt]
			l_recs[l_cnt].hosyonin_mei				= l_ds.object.hosyonin_mei[l_cnt]
			l_recs[l_cnt].hosyonin_kankei			= l_ds.object.hosyonin_kankei[l_cnt]
			l_recs[l_cnt].hosyokin					= l_ds.object.hosyokin[l_cnt]
			l_recs[l_cnt].ryoritu_1					= l_ds.object.ryoritu_1[l_cnt]
			l_recs[l_cnt].ryoritu_tani_1			= l_ds.object.ryoritu_tani_1[l_cnt]
			l_recs[l_cnt].ryoritu_2					= l_ds.object.ryoritu_2[l_cnt]
			l_recs[l_cnt].ryoritu_tani_2			= l_ds.object.ryoritu_tani_2[l_cnt]
			l_recs[l_cnt].ryoritu_3					= l_ds.object.ryoritu_3[l_cnt]
			l_recs[l_cnt].ryoritu_tani_3			= l_ds.object.ryoritu_tani_3[l_cnt]
			l_recs[l_cnt].ryoritu_4					= l_ds.object.ryoritu_4[l_cnt]
			l_recs[l_cnt].ryoritu_tani_4			= l_ds.object.ryoritu_tani_4[l_cnt]
			l_recs[l_cnt].ryoritu_5					= l_ds.object.ryoritu_5[l_cnt]
			l_recs[l_cnt].ryoritu_tani_5			= l_ds.object.ryoritu_tani_5[l_cnt]
			l_recs[l_cnt].tesuryo_1					= l_ds.object.tesuryo_1[l_cnt]
			l_recs[l_cnt].tesuryo_tani_1			= l_ds.object.tesuryo_tani_1[l_cnt]
			l_recs[l_cnt].tesuryo_2					= l_ds.object.tesuryo_2[l_cnt]
			l_recs[l_cnt].tesuryo_tani_2			= l_ds.object.tesuryo_tani_2[l_cnt]
			l_recs[l_cnt].tesuryo_3					= l_ds.object.tesuryo_3[l_cnt]
			l_recs[l_cnt].tesuryo_tani_3			= l_ds.object.tesuryo_tani_3[l_cnt]
			l_recs[l_cnt].tesuryo_4					= l_ds.object.tesuryo_4[l_cnt]
			l_recs[l_cnt].tesuryo_tani_4			= l_ds.object.tesuryo_tani_4[l_cnt]
			l_recs[l_cnt].tesuryo_5					= l_ds.object.tesuryo_5[l_cnt]
			l_recs[l_cnt].tesuryo_tani_5			= l_ds.object.tesuryo_tani_5[l_cnt]
			l_recs[l_cnt].memo						= l_ds.object.memo[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_untin_kijyun_check (string p_kijyun_code);
integer	l_ret

declare orafunc procedure for muntin_kijyun.chk( :p_kijyun_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_untin_kijyun_get_full (string p_kijyun_code, ref str_muntin_kijyun p_recs[]);
integer				l_cnt
str_muntin_kijyun	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select kijyun_code," )
fnc.strg.of_append_line( l_sql, "       kijyun_mei,kijyun_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       seikyu_kbn," )
fnc.strg.of_append_line( l_sql, "       keisan_kijyun,keisan_kijyunti," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muntin_kijyun.get_full( {1} ) )", string( p_kijyun_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kijyun_code		= l_ds.object.kijyun_code[l_cnt]
			l_recs[l_cnt].kijyun_mei		= l_ds.object.kijyun_mei[l_cnt]
			l_recs[l_cnt].kijyun_mei_ryaku	= l_ds.object.kijyun_mei_ryaku[l_cnt]
			l_recs[l_cnt].seikyu_kbn		= l_ds.object.seikyu_kbn[l_cnt]
			l_recs[l_cnt].keisan_kijyun		= l_ds.object.keisan_kijyun[l_cnt]
			l_recs[l_cnt].keisan_kijyunti	= l_ds.object.keisan_kijyunti[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_untin_kijyun_get (string p_kijyun_code, ref str_muntin_kijyun p_recs[]);
integer				l_cnt
str_muntin_kijyun	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select kijyun_code," )
fnc.strg.of_append_line( l_sql, "       kijyun_mei,kijyun_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       seikyu_kbn," )
fnc.strg.of_append_line( l_sql, "       keisan_kijyun,keisan_kijyunti" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muntin_kijyun.get( {1} ) )", string( p_kijyun_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kijyun_code		= l_ds.object.kijyun_code[l_cnt]
			l_recs[l_cnt].kijyun_mei		= l_ds.object.kijyun_mei[l_cnt]
			l_recs[l_cnt].kijyun_mei_ryaku	= l_ds.object.kijyun_mei_ryaku[l_cnt]
			l_recs[l_cnt].seikyu_kbn		= l_ds.object.seikyu_kbn[l_cnt]
			l_recs[l_cnt].keisan_kijyun		= l_ds.object.keisan_kijyun[l_cnt]
			l_recs[l_cnt].keisan_kijyunti	= l_ds.object.keisan_kijyunti[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_gtin_kanri_check (string p_jigyosya_code);
integer	l_ret

declare orafunc procedure for mgtin_kanri.chk( :p_jigyosya_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_gtin_kanri_get (string p_jigyosya_code, ref str_mgtin_kanri p_recs[]);
integer			l_cnt
str_mgtin_kanri	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       jigyosya_mei," )
fnc.strg.of_append_line( l_sql, "       jido_saiban_flg," )
fnc.strg.of_append_line( l_sql, "       item_code_str,item_code_end,item_code_gen," )
fnc.strg.of_append_line( l_sql, "       rep_flg,haiban_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgtin_kanri.get( {1} ) )", string( p_jigyosya_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].jigyosya_code		= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].jigyosya_mei		= l_ds.object.jigyosya_mei[l_cnt]
			l_recs[l_cnt].jido_saiban_flg	= l_ds.object.jido_saiban_flg[l_cnt]
			l_recs[l_cnt].item_code_str		= l_ds.object.item_code_str[l_cnt]
			l_recs[l_cnt].item_code_end		= l_ds.object.item_code_end[l_cnt]
			l_recs[l_cnt].item_code_gen		= l_ds.object.item_code_gen[l_cnt]
			l_recs[l_cnt].rep_flg			= l_ds.object.rep_flg[l_cnt]
			l_recs[l_cnt].haiban_flg		= l_ds.object.haiban_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_gtin_kanri_get_full (string p_jigyosya_code, ref str_mgtin_kanri p_recs[]);
integer			l_cnt
str_mgtin_kanri	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       jigyosya_mei," )
fnc.strg.of_append_line( l_sql, "       jido_saiban_flg," )
fnc.strg.of_append_line( l_sql, "       item_code_str,item_code_end,item_code_gen," )
fnc.strg.of_append_line( l_sql, "       rep_flg,haiban_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgtin_kanri.get_full( {1} ) )", string( p_jigyosya_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].jigyosya_code		= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].jigyosya_mei		= l_ds.object.jigyosya_mei[l_cnt]
			l_recs[l_cnt].jido_saiban_flg	= l_ds.object.jido_saiban_flg[l_cnt]
			l_recs[l_cnt].item_code_str		= l_ds.object.item_code_str[l_cnt]
			l_recs[l_cnt].item_code_end		= l_ds.object.item_code_end[l_cnt]
			l_recs[l_cnt].item_code_gen		= l_ds.object.item_code_gen[l_cnt]
			l_recs[l_cnt].rep_flg			= l_ds.object.rep_flg[l_cnt]
			l_recs[l_cnt].haiban_flg		= l_ds.object.haiban_flg[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kamoku_check (long p_kamoku_code, long p_hojyo_kamoku_code);
integer	l_ret

declare orafunc procedure for mkamoku.chk( :p_kamoku_code, :p_hojyo_kamoku_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_kamoku_check (long p_kamoku_code);
long	l_hojyo_kamoku_code

setnull( l_hojyo_kamoku_code )

return of_kamoku_check( p_kamoku_code, l_hojyo_kamoku_code )
end function

public function integer of_kamoku_get_full (long p_kamoku_code, long p_hojyo_kamoku_code, ref str_mkamoku p_recs[]);
integer		l_cnt
str_mkamoku	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kamoku_code,hojyo_kamoku_code," )
fnc.strg.of_append_line( l_sql, "       kamoku_mei,hojyo_kamoku_mei," )
fnc.strg.of_append_line( l_sql, "       zei_kbn,zei_keisan_kbn," )
fnc.strg.of_append_line( l_sql, "       tegata_nyuryoku_flg,bumon_nyuryoku_flg,siyo_kinsi_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 補助科目コードが未設定の場合は条件に加えない
if isnull( p_hojyo_kamoku_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkamoku.get_full( {1} ) )", string( p_kamoku_code ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkamoku.get_full( {1}, '{2}' ) )", string( p_kamoku_code ), string( p_hojyo_kamoku_code ) ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kamoku_code			= l_ds.object.kamoku_code[l_cnt]
			l_recs[l_cnt].hojyo_kamoku_code		= l_ds.object.hojyo_kamoku_code[l_cnt]
			l_recs[l_cnt].kamoku_mei			= l_ds.object.kamoku_mei[l_cnt]
			l_recs[l_cnt].hojyo_kamoku_mei		= l_ds.object.hojyo_kamoku_mei[l_cnt]
			l_recs[l_cnt].zei_kbn				= l_ds.object.zei_kbn[l_cnt]
			l_recs[l_cnt].zei_keisan_kbn		= l_ds.object.zei_keisan_kbn[l_cnt]
			l_recs[l_cnt].tegata_nyuryoku_flg	= l_ds.object.tegata_nyuryoku_flg[l_cnt]
			l_recs[l_cnt].bumon_nyuryoku_flg	= l_ds.object.bumon_nyuryoku_flg[l_cnt]
			l_recs[l_cnt].siyo_kinsi_flg		= l_ds.object.siyo_kinsi_flg[l_cnt]
			l_recs[l_cnt].touroku_date			= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id		= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id		= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id			= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date			= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id		= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id		= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id			= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date			= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id		= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id		= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id			= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg				= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt

end function

public function integer of_kamoku_get_full (long p_kamoku_code, ref str_mkamoku p_recs[]);
long	l_hojyo_kamoku_code

setnull( l_hojyo_kamoku_code )

return of_kamoku_get_full( p_kamoku_code, l_hojyo_kamoku_code, p_recs[] )
end function

public function integer of_kamoku_get (long p_kamoku_code, long p_hojyo_kamoku_code, ref str_mkamoku p_recs[]);
integer		l_cnt
str_mkamoku	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kamoku_code,hojyo_kamoku_code," )
fnc.strg.of_append_line( l_sql, "       kamoku_mei,hojyo_kamoku_mei" )

// 補助科目コードが未設定の場合は条件に加えない
if isnull( p_hojyo_kamoku_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkamoku.get( {1} ) )", string( p_kamoku_code ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkamoku.get( {1}, '{2}' ) )", string( p_kamoku_code ), string( p_hojyo_kamoku_code ) ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kamoku_code			= l_ds.object.kamoku_code[l_cnt]
			l_recs[l_cnt].hojyo_kamoku_code		= l_ds.object.hojyo_kamoku_code[l_cnt]
			l_recs[l_cnt].kamoku_mei			= l_ds.object.kamoku_mei[l_cnt]
			l_recs[l_cnt].hojyo_kamoku_mei		= l_ds.object.hojyo_kamoku_mei[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt

end function

public function integer of_kamoku_get (long p_kamoku_code, ref str_mkamoku p_recs[]);
long	l_hojyo_kamoku_code

setnull( l_hojyo_kamoku_code )

return of_kamoku_get( p_kamoku_code, l_hojyo_kamoku_code, p_recs[] )
end function

public function integer of_tyakuten_check (integer p_unso_code, string p_yubin_no, string p_tyakuten_code);
integer	l_ret

declare orafunc procedure for mtyakuten.chk( :p_unso_code, :p_yubin_no, :p_tyakuten_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_tyakuten_check (integer p_unso_code, string p_yubin_no);
string	l_tyakuten_code

setnull( l_tyakuten_code )

return of_tyakuten_check( p_unso_code, p_yubin_no, l_tyakuten_code )

end function

public function integer of_tyakuten_check (integer p_unso_code);
string	l_yubin_no, l_tyakuten_code

setnull( l_yubin_no )
setnull( l_tyakuten_code )

return of_tyakuten_check( p_unso_code, l_yubin_no, l_tyakuten_code )

end function

public function integer of_tyakuten_get_full (integer p_unso_code, string p_yubin_no, string p_tyakuten_code, ref str_mtyakuten p_recs[]);
integer			l_cnt
str_mtyakuten	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select data_kbn," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tyakuten_code,tyakuten_code_tome," )
fnc.strg.of_append_line( l_sql, "       hanyo_col_1,hanyo_col_2,hanyo_col_3,hanyo_col_4,hanyo_col_5," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )

// 郵便番号が未設定の場合は条件に加えない
if isnull( p_yubin_no ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get_full( {1} ) )", string( p_unso_code ) ) )
else
	// 着店コードが未設定の場合は条件に加えない
	if isnull( p_tyakuten_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get_full( {1}, '{2}' ) )", string( p_unso_code ), p_yubin_no ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get_full( {1}, '{2}', '{3}' ) )", string( p_unso_code ), p_yubin_no, p_tyakuten_code ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].data_kbn				= l_ds.object.data_kbn[l_cnt]
			l_recs[l_cnt].unso_code				= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].yubin_no				= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo				= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tyakuten_code			= l_ds.object.tyakuten_code[l_cnt]
			l_recs[l_cnt].tyakuten_code_tome	= l_ds.object.tyakuten_code_tome[l_cnt]
			l_recs[l_cnt].hanyo_col_1			= l_ds.object.hanyo_col_1[l_cnt]
			l_recs[l_cnt].hanyo_col_2			= l_ds.object.hanyo_col_2[l_cnt]
			l_recs[l_cnt].hanyo_col_3			= l_ds.object.hanyo_col_3[l_cnt]
			l_recs[l_cnt].hanyo_col_4			= l_ds.object.hanyo_col_4[l_cnt]
			l_recs[l_cnt].hanyo_col_5			= l_ds.object.hanyo_col_5[l_cnt]
			l_recs[l_cnt].touroku_date			= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id		= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id		= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id			= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date			= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id		= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id		= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id			= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date			= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id		= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id		= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id			= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg				= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tyakuten_get_full (integer p_unso_code, string p_yubin_no, ref str_mtyakuten p_recs[]);
string	l_tyakuten_code

setnull( l_tyakuten_code )

return of_tyakuten_get_full( p_unso_code, p_yubin_no, l_tyakuten_code, p_recs )

end function

public function integer of_tyakuten_get_full (integer p_unso_code, ref str_mtyakuten p_recs[]);
string	l_yubin_no, l_tyakuten_code

setnull( l_yubin_no )
setnull( l_tyakuten_code )

return of_tyakuten_get_full( p_unso_code, l_yubin_no, l_tyakuten_code, p_recs )

end function

public function integer of_tyakuten_get (integer p_unso_code, string p_yubin_no, string p_tyakuten_code, ref str_mtyakuten p_recs[]);
integer			l_cnt
str_mtyakuten	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select data_kbn," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       yubin_no,jyusyo," )
fnc.strg.of_append_line( l_sql, "       tyakuten_code,tyakuten_code_tome" )

// 郵便番号が未設定の場合は条件に加えない
if isnull( p_yubin_no ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get( {1} ) )", string( p_unso_code ) ) )
else
	// 着店コードが未設定の場合は条件に加えない
	if isnull( p_tyakuten_code ) then
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get( {1}, '{2}' ) )", string( p_unso_code ), p_yubin_no ) )
	else
		fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyakuten.get( {1}, '{2}', '{3}' ) )", string( p_unso_code ), p_yubin_no, p_tyakuten_code ) )
	end if
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].data_kbn				= l_ds.object.data_kbn[l_cnt]
			l_recs[l_cnt].unso_code				= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].yubin_no				= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo				= l_ds.object.jyusyo[l_cnt]
			l_recs[l_cnt].tyakuten_code			= l_ds.object.tyakuten_code[l_cnt]
			l_recs[l_cnt].tyakuten_code_tome	= l_ds.object.tyakuten_code_tome[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tyakuten_get (integer p_unso_code, string p_yubin_no, ref str_mtyakuten p_recs[]);
string	l_tyakuten_code

setnull( l_tyakuten_code )

return of_tyakuten_get( p_unso_code, p_yubin_no, l_tyakuten_code, p_recs )

end function

public function integer of_tyakuten_get (integer p_unso_code, ref str_mtyakuten p_recs[]);
string	l_yubin_no, l_tyakuten_code

setnull( l_yubin_no )
setnull( l_tyakuten_code )

return of_tyakuten_get( p_unso_code, l_yubin_no, l_tyakuten_code, p_recs )

end function

public function integer of_mymenu_check (string p_user_id);
integer	l_ret

declare orafunc procedure for mmymenu.chk( :p_user_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret

end function

public function integer of_mymenu_get_full (string p_user_id, ref str_mmymenu p_recs[]);
integer		l_cnt
str_mmymenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select user_id, button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       param," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmymenu.get_full( {1} ) )", string( p_user_id ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_mymenu_get (string p_user_id, ref str_mmymenu p_recs[]);
integer		l_cnt
str_mmymenu	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select user_id, button_no," )
fnc.strg.of_append_line( l_sql, "       window_id," )
fnc.strg.of_append_line( l_sql, "       param" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mmymenu.get( {1} ) )", string( p_user_id ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].user_id			= l_ds.object.user_id[l_cnt]
			l_recs[l_cnt].button_no			= l_ds.object.button_no[l_cnt]
			l_recs[l_cnt].window_id			= l_ds.object.window_id[l_cnt]
			l_recs[l_cnt].param				= l_ds.object.param[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_zeiritu_check (integer p_torihiki_kbn, integer p_zeiritu_kbn);
integer	l_ret

declare orafunc procedure for mzeiritu.chk( :p_torihiki_kbn, :p_zeiritu_kbn ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_zeiritu_get_full (integer p_torihiki_kbn, integer p_zeiritu_kbn, ref str_mzeiritu p_recs[]);
integer			l_cnt
str_mzeiritu	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select torihiki_kbn, zeiritu_kbn," )
fnc.strg.of_append_line( l_sql, "       zeiritu_str_date, zeiritu_end_date," )
fnc.strg.of_append_line( l_sql, "       syohizei_ritu," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mzeiritu.get_full( {1}, {2} ) )", string( p_torihiki_kbn ), string( p_zeiritu_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].torihiki_kbn		= l_ds.object.torihiki_kbn[l_cnt]
			l_recs[l_cnt].zeiritu_kbn		= l_ds.object.zeiritu_kbn[l_cnt]
			l_recs[l_cnt].zeiritu_str_date	= l_ds.object.zeiritu_str_date[l_cnt]
			l_recs[l_cnt].zeiritu_end_date	= l_ds.object.zeiritu_end_date[l_cnt]
			l_recs[l_cnt].syohizei_ritu		= l_ds.object.syohizei_ritu[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_zeiritu_get (integer p_torihiki_kbn, integer p_zeiritu_kbn, ref str_mzeiritu p_recs[]);
integer			l_cnt
str_mzeiritu	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select torihiki_kbn, zeiritu_kbn," )
fnc.strg.of_append_line( l_sql, "       zeiritu_str_date, zeiritu_end_date," )
fnc.strg.of_append_line( l_sql, "       syohizei_ritu" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mzeiritu.get( {1}, {2} ) )", string( p_torihiki_kbn ), string( p_zeiritu_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].torihiki_kbn		= l_ds.object.torihiki_kbn[l_cnt]
			l_recs[l_cnt].zeiritu_kbn		= l_ds.object.zeiritu_kbn[l_cnt]
			l_recs[l_cnt].zeiritu_str_date	= l_ds.object.zeiritu_str_date[l_cnt]
			l_recs[l_cnt].zeiritu_end_date	= l_ds.object.zeiritu_end_date[l_cnt]
			l_recs[l_cnt].syohizei_ritu		= l_ds.object.syohizei_ritu[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_syozoku_check (long p_tanto_code, long p_nengetu);
integer	l_ret

declare orafunc procedure for msyozoku.chk( :p_tanto_code, :p_nengetu ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_syozoku_get_full (long p_tanto_code, long p_nengetu, ref str_msyozoku p_recs[]);
integer			l_cnt
str_msyozoku	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select tanto_code," )
fnc.strg.of_append_line( l_sql, "       nengetu,nen,tuki," )
fnc.strg.of_append_line( l_sql, "       bumon_code,eigyosyo_code,ka_code," )
fnc.strg.of_append_line( l_sql, "       uriage_mokuhyo,arari_mokuhyo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyozoku.get_full( {1}, {2} ) )", string( p_tanto_code ), string( p_nengetu ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].nengetu			= l_ds.object.nengetu[l_cnt]
			l_recs[l_cnt].nen				= l_ds.object.nen[l_cnt]
			l_recs[l_cnt].tuki				= l_ds.object.tuki[l_cnt]
			l_recs[l_cnt].bumon_code		= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].eigyosyo_code		= l_ds.object.eigyosyo_code[l_cnt]
			l_recs[l_cnt].ka_code			= l_ds.object.ka_code[l_cnt]
			l_recs[l_cnt].uriage_mokuhyo	= l_ds.object.uriage_mokuhyo[l_cnt]
			l_recs[l_cnt].arari_mokuhyo		= l_ds.object.arari_mokuhyo[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_syozoku_get (long p_tanto_code, long p_nengetu, ref str_msyozoku p_recs[]);
integer			l_cnt
str_msyozoku	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select tanto_code," )
fnc.strg.of_append_line( l_sql, "       nengetu,nen,tuki," )
fnc.strg.of_append_line( l_sql, "       bumon_code,eigyosyo_code,ka_code," )
fnc.strg.of_append_line( l_sql, "       uriage_mokuhyo,arari_mokuhyo" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msyozoku.get( {1}, {2} ) )", string( p_tanto_code ), string( p_nengetu ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].nengetu			= l_ds.object.nengetu[l_cnt]
			l_recs[l_cnt].nen				= l_ds.object.nen[l_cnt]
			l_recs[l_cnt].tuki				= l_ds.object.tuki[l_cnt]
			l_recs[l_cnt].bumon_code		= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].eigyosyo_code		= l_ds.object.eigyosyo_code[l_cnt]
			l_recs[l_cnt].ka_code			= l_ds.object.ka_code[l_cnt]
			l_recs[l_cnt].uriage_mokuhyo	= l_ds.object.uriage_mokuhyo[l_cnt]
			l_recs[l_cnt].arari_mokuhyo		= l_ds.object.arari_mokuhyo[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_tanto_check (long p_tokui_code, long p_nengetu);
integer	l_ret

declare orafunc procedure for mtokui_tanto.chk( :p_tokui_code, :p_nengetu ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_tokui_tanto_get_full (long p_tokui_code, long p_nengetu, ref str_mtokui_tanto p_recs[]);
integer				l_cnt
str_mtokui_tanto	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       nengetu,nen,tuki," )
fnc.strg.of_append_line( l_sql, "       tanto_code," )
fnc.strg.of_append_line( l_sql, "       uriage_mokuhyo,arari_mokuhyo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_tanto.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_nengetu ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].nengetu			= l_ds.object.nengetu[l_cnt]
			l_recs[l_cnt].nen				= l_ds.object.nen[l_cnt]
			l_recs[l_cnt].tuki				= l_ds.object.tuki[l_cnt]
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].uriage_mokuhyo	= l_ds.object.uriage_mokuhyo[l_cnt]
			l_recs[l_cnt].arari_mokuhyo		= l_ds.object.arari_mokuhyo[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_tanto_get (long p_tokui_code, long p_nengetu, ref str_mtokui_tanto p_recs[]);
integer				l_cnt
str_mtokui_tanto	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       nengetu,nen,tuki," )
fnc.strg.of_append_line( l_sql, "       tanto_code," )
fnc.strg.of_append_line( l_sql, "       uriage_mokuhyo,arari_mokuhyo" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_tanto.get( {1}, {2} ) )", string( p_tokui_code ), string( p_nengetu ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].nengetu			= l_ds.object.nengetu[l_cnt]
			l_recs[l_cnt].nen				= l_ds.object.nen[l_cnt]
			l_recs[l_cnt].tuki				= l_ds.object.tuki[l_cnt]
			l_recs[l_cnt].tanto_code		= l_ds.object.tanto_code[l_cnt]
			l_recs[l_cnt].uriage_mokuhyo	= l_ds.object.uriage_mokuhyo[l_cnt]
			l_recs[l_cnt].arari_mokuhyo		= l_ds.object.arari_mokuhyo[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_atesaki_check (long p_tokui_code, integer p_atesaki_kbn);
integer	l_ret

declare orafunc procedure for mtokui_atesaki.chk( :p_tokui_code, :p_atesaki_kbn ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_tokui_atesaki_get_full (long p_tokui_code, integer p_atesaki_kbn, ref str_mtokui_atesaki p_recs[]);
integer				l_cnt
str_mtokui_atesaki	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       atesaki_kbn," )
fnc.strg.of_append_line( l_sql, "       yubin_no," )
fnc.strg.of_append_line( l_sql, "       jyusyo1,jyusyo2,jyusyo3,jyusyo4," )
fnc.strg.of_append_line( l_sql, "       atena1,atena2,atena3,atena4," )
fnc.strg.of_append_line( l_sql, "       tel_no,fax_no," )
fnc.strg.of_append_line( l_sql, "       bikou1,bikou2,bikou3," )
fnc.strg.of_append_line( l_sql, "       note," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_atesaki.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_atesaki_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].atesaki_kbn		= l_ds.object.atesaki_kbn[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo1			= l_ds.object.jyusyo1[l_cnt]
			l_recs[l_cnt].jyusyo2			= l_ds.object.jyusyo2[l_cnt]
			l_recs[l_cnt].jyusyo3			= l_ds.object.jyusyo3[l_cnt]
			l_recs[l_cnt].jyusyo4			= l_ds.object.jyusyo4[l_cnt]
			l_recs[l_cnt].atena1			= l_ds.object.atena1[l_cnt]
			l_recs[l_cnt].atena2			= l_ds.object.atena2[l_cnt]
			l_recs[l_cnt].atena3			= l_ds.object.atena3[l_cnt]
			l_recs[l_cnt].atena4			= l_ds.object.atena4[l_cnt]
			l_recs[l_cnt].tel_no			= l_ds.object.tel_no[l_cnt]
			l_recs[l_cnt].fax_no			= l_ds.object.fax_no[l_cnt]
			l_recs[l_cnt].bikou1			= l_ds.object.bikou1[l_cnt]
			l_recs[l_cnt].bikou2			= l_ds.object.bikou2[l_cnt]
			l_recs[l_cnt].bikou3			= l_ds.object.bikou3[l_cnt]
			l_recs[l_cnt].note				= l_ds.object.note[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_atesaki_get (long p_tokui_code, integer p_atesaki_kbn, ref str_mtokui_atesaki p_recs[]);
integer				l_cnt
str_mtokui_atesaki	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       atesaki_kbn," )
fnc.strg.of_append_line( l_sql, "       yubin_no," )
fnc.strg.of_append_line( l_sql, "       jyusyo1,jyusyo2,jyusyo3,jyusyo4," )
fnc.strg.of_append_line( l_sql, "       atena1,atena2,atena3,atena4" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_atesaki.get( {1}, {2} ) )", string( p_tokui_code ), string( p_atesaki_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].atesaki_kbn		= l_ds.object.atesaki_kbn[l_cnt]
			l_recs[l_cnt].yubin_no			= l_ds.object.yubin_no[l_cnt]
			l_recs[l_cnt].jyusyo1			= l_ds.object.jyusyo1[l_cnt]
			l_recs[l_cnt].jyusyo2			= l_ds.object.jyusyo2[l_cnt]
			l_recs[l_cnt].jyusyo3			= l_ds.object.jyusyo3[l_cnt]
			l_recs[l_cnt].jyusyo4			= l_ds.object.jyusyo4[l_cnt]
			l_recs[l_cnt].atena1			= l_ds.object.atena1[l_cnt]
			l_recs[l_cnt].atena2			= l_ds.object.atena2[l_cnt]
			l_recs[l_cnt].atena3			= l_ds.object.atena3[l_cnt]
			l_recs[l_cnt].atena4			= l_ds.object.atena4[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kakeritu_check (long p_tokui_code, integer p_kakaku_group_kbn);
integer	l_ret

declare orafunc procedure for mkakeritu.chk( :p_tokui_code, :p_kakaku_group_kbn ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_kakeritu_get_full (long p_tokui_code, integer p_kakaku_group_kbn, ref str_mkakeritu p_recs[]);
integer			l_cnt
str_mkakeritu	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       kakaku_group_kbn," )
fnc.strg.of_append_line( l_sql, "       kakeritu," )
fnc.strg.of_append_line( l_sql, "       upkomi_kbn," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkakeritu.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_kakaku_group_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].kakaku_group_kbn	= l_ds.object.kakaku_group_kbn[l_cnt]
			l_recs[l_cnt].kakeritu			= l_ds.object.kakeritu[l_cnt]
			l_recs[l_cnt].upkomi_kbn		= l_ds.object.upkomi_kbn[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kakeritu_get (long p_tokui_code, integer p_kakaku_group_kbn, ref str_mkakeritu p_recs[]);
integer			l_cnt
str_mkakeritu	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       kakaku_group_kbn," )
fnc.strg.of_append_line( l_sql, "       kakeritu," )
fnc.strg.of_append_line( l_sql, "       upkomi_kbn" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mkakeritu.get( {1}, {2} ) )", string( p_tokui_code ), string( p_kakaku_group_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].kakaku_group_kbn	= l_ds.object.kakaku_group_kbn[l_cnt]
			l_recs[l_cnt].kakeritu			= l_ds.object.kakeritu[l_cnt]
			l_recs[l_cnt].upkomi_kbn		= l_ds.object.upkomi_kbn[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_gtin_check (string p_gtin_code);
integer	l_ret

declare orafunc procedure for mgtin.chk( :p_gtin_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_gtin_get_full (string p_gtin_code, ref str_mgtin p_recs[]);
integer		l_cnt
str_mgtin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select gtin_code," )
fnc.strg.of_append_line( l_sql, "       sku_code,syohin_code,iro_no," )
fnc.strg.of_append_line( l_sql, "       code_kbn," )
fnc.strg.of_append_line( l_sql, "       jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       touroku_iti," )
fnc.strg.of_append_line( l_sql, "       indicator," )
fnc.strg.of_append_line( l_sql, "       irisu," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgtin.get_full( '{1}' ) )", p_gtin_code ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].gtin_code			= l_ds.object.gtin_code[l_cnt]
			l_recs[l_cnt].sku_code			= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no			= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].code_kbn			= l_ds.object.code_kbn[l_cnt]
			l_recs[l_cnt].jigyosya_code		= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].touroku_iti		= l_ds.object.touroku_iti[l_cnt]
			l_recs[l_cnt].indicator			= l_ds.object.indicator[l_cnt]
			l_recs[l_cnt].irisu				= l_ds.object.irisu[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_gtin_get (string p_gtin_code, ref str_mgtin p_recs[]);
integer		l_cnt
str_mgtin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select gtin_code," )
fnc.strg.of_append_line( l_sql, "       sku_code,syohin_code,iro_no," )
fnc.strg.of_append_line( l_sql, "       code_kbn," )
fnc.strg.of_append_line( l_sql, "       jigyosya_code," )
fnc.strg.of_append_line( l_sql, "       touroku_iti," )
fnc.strg.of_append_line( l_sql, "       indicator," )
fnc.strg.of_append_line( l_sql, "       irisu" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mgtin.get( '{1}' ) )", p_gtin_code ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].gtin_code			= l_ds.object.gtin_code[l_cnt]
			l_recs[l_cnt].sku_code			= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no			= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].code_kbn			= l_ds.object.code_kbn[l_cnt]
			l_recs[l_cnt].jigyosya_code		= l_ds.object.jigyosya_code[l_cnt]
			l_recs[l_cnt].touroku_iti		= l_ds.object.touroku_iti[l_cnt]
			l_recs[l_cnt].indicator			= l_ds.object.indicator[l_cnt]
			l_recs[l_cnt].irisu				= l_ds.object.irisu[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_aite_hinban_check (long p_tokui_code, longlong p_sku_code);
integer	l_ret

declare orafunc procedure for maite_hinban.chk( :p_tokui_code, :p_sku_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_aite_hinban_get_full (long p_tokui_code, longlong p_sku_code, ref str_maite_hinban p_recs[]);
integer				l_cnt
str_maite_hinban	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       sku_code,syohin_code,iro_no," )
fnc.strg.of_append_line( l_sql, "       aite_hinban,aite_hinmei,aite_iromei,aite_sizemei," )
fnc.strg.of_append_line( l_sql, "       aite_bumon_code,aite_bumon_mei," )
fnc.strg.of_append_line( l_sql, "       aite_baika1,aite_baika2," )
fnc.strg.of_append_line( l_sql, "       new_baika1,new_baika2," )
fnc.strg.of_append_line( l_sql, "       tekiyo_date_str,tekiyo_date_end," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( maite_hinban.get_full( {1}, {2} ) )", string( p_tokui_code ), string( p_sku_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].sku_code			= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no			= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].aite_hinban		= l_ds.object.aite_hinban[l_cnt]
			l_recs[l_cnt].aite_hinmei		= l_ds.object.aite_hinmei[l_cnt]
			l_recs[l_cnt].aite_iromei		= l_ds.object.aite_iromei[l_cnt]
			l_recs[l_cnt].aite_sizemei		= l_ds.object.aite_sizemei[l_cnt]
			l_recs[l_cnt].aite_bumon_code	= l_ds.object.aite_bumon_code[l_cnt]
			l_recs[l_cnt].aite_bumon_mei	= l_ds.object.aite_bumon_mei[l_cnt]
			l_recs[l_cnt].aite_baika1		= l_ds.object.aite_baika1[l_cnt]
			l_recs[l_cnt].aite_baika2		= l_ds.object.aite_baika2[l_cnt]
			l_recs[l_cnt].new_baika1		= l_ds.object.new_baika1[l_cnt]
			l_recs[l_cnt].new_baika2		= l_ds.object.new_baika2[l_cnt]
			l_recs[l_cnt].tekiyo_date_str	= l_ds.object.tekiyo_date_str[l_cnt]
			l_recs[l_cnt].tekiyo_date_end	= l_ds.object.tekiyo_date_end[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_aite_hinban_get (long p_tokui_code, longlong p_sku_code, ref str_maite_hinban p_recs[]);
integer				l_cnt
str_maite_hinban	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       sku_code," )
fnc.strg.of_append_line( l_sql, "       aite_baika1,aite_baika2," )
fnc.strg.of_append_line( l_sql, "       new_baika1,new_baika2," )
fnc.strg.of_append_line( l_sql, "       tekiyo_date_str,tekiyo_date_end" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( maite_hinban.get( {1}, {2} ) )", string( p_tokui_code ), string( p_sku_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].sku_code			= l_ds.object.sku_code[l_cnt]
			l_recs[l_cnt].aite_baika1		= l_ds.object.aite_baika1[l_cnt]
			l_recs[l_cnt].aite_baika2		= l_ds.object.aite_baika2[l_cnt]
			l_recs[l_cnt].new_baika1		= l_ds.object.new_baika1[l_cnt]
			l_recs[l_cnt].new_baika2		= l_ds.object.new_baika2[l_cnt]
			l_recs[l_cnt].tekiyo_date_str	= l_ds.object.tekiyo_date_str[l_cnt]
			l_recs[l_cnt].tekiyo_date_end	= l_ds.object.tekiyo_date_end[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_untin_get_full (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn, ref str_muntin p_recs[]);
integer		l_cnt
str_muntin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       key_syubetu,key_code," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       untin_kbn,untin," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muntin.get_full( {1}, {2}, {3}, {4}, {5} ) )", string( p_kyoten_code ), string( p_key_syubetu ), string( p_key_code ),&
																												  string( p_unso_code ), string( p_untin_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].key_syubetu		= l_ds.object.key_syubetu[l_cnt]
			l_recs[l_cnt].key_code			= l_ds.object.key_code[l_cnt]
			l_recs[l_cnt].unso_code			= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].untin_kbn			= l_ds.object.untin_kbn[l_cnt]
			l_recs[l_cnt].untin				= l_ds.object.untin[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_untin_check (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn);
integer	l_ret

declare orafunc procedure for muntin.chk( :p_kyoten_code, :p_key_syubetu, :p_key_code, :p_unso_code, :p_untin_kbn ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_untin_get (long p_kyoten_code, integer p_key_syubetu, long p_key_code, integer p_unso_code, integer p_untin_kbn, ref str_muntin p_recs[]);
integer		l_cnt
str_muntin	l_recs[]

string		l_sql
datastore	l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       key_syubetu,key_code," )
fnc.strg.of_append_line( l_sql, "       unso_code," )
fnc.strg.of_append_line( l_sql, "       untin_kbn,untin" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( muntin.get( {1}, {2}, {3}, {4}, {5} ) )", string( p_kyoten_code ), string( p_key_syubetu ), string( p_key_code ),&
																											 string( p_unso_code ), string( p_untin_kbn ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].key_syubetu		= l_ds.object.key_syubetu[l_cnt]
			l_recs[l_cnt].key_code			= l_ds.object.key_code[l_cnt]
			l_recs[l_cnt].unso_code			= l_ds.object.unso_code[l_cnt]
			l_recs[l_cnt].untin_kbn			= l_ds.object.untin_kbn[l_cnt]
			l_recs[l_cnt].untin				= l_ds.object.untin[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_syohin_check (long p_syohin_code, long p_iro_no, long p_tokui_code);
integer	l_ret

declare orafunc procedure for mtokui_syohin.chk( :p_syohin_code, :p_iro_no, :p_tokui_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_tokui_syohin_get_full (long p_syohin_code, long p_iro_no, long p_tokui_code, ref str_mtokui_syohin p_recs[]);
integer				l_cnt
str_mtokui_syohin	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select syohin_code,iro_no," )
fnc.strg.of_append_line( l_sql, "       tokui_code," )
fnc.strg.of_append_line( l_sql, "       kahi_kbn,houhou_kbn,riyu_kbn," )
fnc.strg.of_append_line( l_sql, "       str_date,end_date," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_syohin.get_full( {1}, {2}, {3} ) )", string( p_syohin_code ), string( p_iro_no ), string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no			= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].kahi_kbn			= l_ds.object.kahi_kbn[l_cnt]
			l_recs[l_cnt].houhou_kbn		= l_ds.object.houhou_kbn[l_cnt]
			l_recs[l_cnt].riyu_kbn			= l_ds.object.riyu_kbn[l_cnt]
			l_recs[l_cnt].str_date			= l_ds.object.str_date[l_cnt]
			l_recs[l_cnt].end_date			= l_ds.object.end_date[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tokui_syohin_get (long p_syohin_code, long p_iro_no, long p_tokui_code, ref str_mtokui_syohin p_recs[]);
integer				l_cnt
str_mtokui_syohin	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select syohin_code,iro_no," )
fnc.strg.of_append_line( l_sql, "       tokui_code," )
fnc.strg.of_append_line( l_sql, "       kahi_kbn,houhou_kbn,riyu_kbn," )
fnc.strg.of_append_line( l_sql, "       str_date,end_date" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtokui_syohin.get( {1}, {2}, {3} ) )", string( p_syohin_code ), string( p_iro_no ), string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].syohin_code		= l_ds.object.syohin_code[l_cnt]
			l_recs[l_cnt].iro_no			= l_ds.object.iro_no[l_cnt]
			l_recs[l_cnt].tokui_code		= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].kahi_kbn			= l_ds.object.kahi_kbn[l_cnt]
			l_recs[l_cnt].houhou_kbn		= l_ds.object.houhou_kbn[l_cnt]
			l_recs[l_cnt].riyu_kbn			= l_ds.object.riyu_kbn[l_cnt]
			l_recs[l_cnt].str_date			= l_ds.object.str_date[l_cnt]
			l_recs[l_cnt].end_date			= l_ds.object.end_date[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_calendar_check (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke);
integer	l_ret

declare orafunc procedure for mcalendar.chk( :p_kyoten_code, :p_calendar_kbn, :p_hizuke ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_calendar_get_full (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke, ref str_mcalendar p_recs[]);
integer			l_cnt
str_mcalendar	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       calendar_kbn," )
fnc.strg.of_append_line( l_sql, "       hizuke," )
fnc.strg.of_append_line( l_sql, "       nen,tuki,hi," )
fnc.strg.of_append_line( l_sql, "       youbi," )
fnc.strg.of_append_line( l_sql, "       taisyo_flg," )
fnc.strg.of_append_line( l_sql, "       tekiyo," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mcalendar.get_full( {1}, {2}, {3} ) )", string( p_kyoten_code ), string( p_calendar_kbn ), string( p_hizuke ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].calendar_kbn		= l_ds.object.calendar_kbn[l_cnt]
			l_recs[l_cnt].hizuke			= l_ds.object.hizuke[l_cnt]
			l_recs[l_cnt].nen				= l_ds.object.nen[l_cnt]
			l_recs[l_cnt].tuki				= l_ds.object.tuki[l_cnt]
			l_recs[l_cnt].hi				= l_ds.object.hi[l_cnt]
			l_recs[l_cnt].youbi				= l_ds.object.youbi[l_cnt]
			l_recs[l_cnt].taisyo_flg		= l_ds.object.taisyo_flg[l_cnt]
			l_recs[l_cnt].tekiyo			= l_ds.object.tekiyo[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_calendar_get (long p_kyoten_code, integer p_calendar_kbn, long p_hizuke, ref str_mcalendar p_recs[]);
integer			l_cnt
str_mcalendar	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select kyoten_code," )
fnc.strg.of_append_line( l_sql, "       calendar_kbn," )
fnc.strg.of_append_line( l_sql, "       hizuke" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mcalendar.get( {1}, {2}, {3} ) )", string( p_kyoten_code ), string( p_calendar_kbn ), string( p_hizuke ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kyoten_code		= l_ds.object.kyoten_code[l_cnt]
			l_recs[l_cnt].calendar_kbn		= l_ds.object.calendar_kbn[l_cnt]
			l_recs[l_cnt].hizuke			= l_ds.object.hizuke[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tyohyo_printer_check (string p_tyohyo_id, string p_client_id);
integer	l_ret

declare orafunc procedure for mtyohyo_printer.chk( :p_tyohyo_id, :p_client_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_tyohyo_printer_get_full (string p_tyohyo_id, string p_client_id, ref str_mtyohyo_printer p_recs[]);
integer				l_cnt
str_mtyohyo_printer	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tyohyo_id," )
fnc.strg.of_append_line( l_sql, "       client_id,client_name," )
fnc.strg.of_append_line( l_sql, "       kyoten_cd," )
fnc.strg.of_append_line( l_sql, "       printer_mei,printer_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       printer_syubetu," )
fnc.strg.of_append_line( l_sql, "       use_flg," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyohyo_printer.get_full( '{1}', '{2}' ) )", p_tyohyo_id, p_client_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tyohyo_id			= l_ds.object.tyohyo_id[l_cnt]
			l_recs[l_cnt].client_id			= l_ds.object.client_id[l_cnt]
			l_recs[l_cnt].client_name		= l_ds.object.client_name[l_cnt]
			l_recs[l_cnt].kyoten_cd			= l_ds.object.kyoten_cd[l_cnt]
			l_recs[l_cnt].printer_mei		= l_ds.object.printer_mei[l_cnt]
			l_recs[l_cnt].printer_mei_ryaku	= l_ds.object.printer_mei_ryaku[l_cnt]
			l_recs[l_cnt].printer_syubetu	= l_ds.object.printer_syubetu[l_cnt]
			l_recs[l_cnt].use_flg			= l_ds.object.use_flg[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_tyohyo_printer_get (string p_tyohyo_id, string p_client_id, ref str_mtyohyo_printer p_recs[]);
integer				l_cnt
str_mtyohyo_printer	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tyohyo_id," )
fnc.strg.of_append_line( l_sql, "       client_id,client_name," )
fnc.strg.of_append_line( l_sql, "       kyoten_cd," )
fnc.strg.of_append_line( l_sql, "       printer_mei,printer_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       printer_syubetu," )
fnc.strg.of_append_line( l_sql, "       use_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( mtyohyo_printer.get( '{1}', '{2}' ) )", p_tyohyo_id, p_client_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tyohyo_id			= l_ds.object.tyohyo_id[l_cnt]
			l_recs[l_cnt].client_id			= l_ds.object.client_id[l_cnt]
			l_recs[l_cnt].client_name		= l_ds.object.client_name[l_cnt]
			l_recs[l_cnt].kyoten_cd			= l_ds.object.kyoten_cd[l_cnt]
			l_recs[l_cnt].printer_mei		= l_ds.object.printer_mei[l_cnt]
			l_recs[l_cnt].printer_mei_ryaku	= l_ds.object.printer_mei_ryaku[l_cnt]
			l_recs[l_cnt].printer_syubetu	= l_ds.object.printer_syubetu[l_cnt]
			l_recs[l_cnt].use_flg			= l_ds.object.use_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_senden_kanri_check (long p_tokui_code);
integer	l_ret

declare orafunc procedure for msenden_kanri.chk( :p_tokui_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_senden_kanri_get_full (long p_tokui_code, ref str_msenden_kanri p_recs[]);
integer				l_cnt
str_msenden_kanri	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tyohyo_id1,tyohyo_id2,tyohyo_id3," )
fnc.strg.of_append_line( l_sql, "       senden_hakkou_flg_1,senden_hakkou_flg_2,senden_hakkou_flg_3," )
fnc.strg.of_append_line( l_sql, "       zei_hyoji_kbn1,zei_hyoji_kbn2,zei_hyoji_kbn3," )
fnc.strg.of_append_line( l_sql, "       meisai_gyo_su1,meisai_gyo_su2,meisai_gyo_su3," )
fnc.strg.of_append_line( l_sql, "       senden_no_kbn1,senden_no_kbn2,senden_no_kbn3," )
fnc.strg.of_append_line( l_sql, "       genzai_no,kaisi_no,syuryo_no," )
fnc.strg.of_append_line( l_sql, "       cd_kbn," )
fnc.strg.of_append_line( l_sql, "       tokui_mei_hyoji_kbn,tokui_mei," )
fnc.strg.of_append_line( l_sql, "       torihiki_code_hyoji_kbn,torihiki_code," )
fnc.strg.of_append_line( l_sql, "       torihiki_hyoji_kbn,torihiki_kaisya_mei,torihiki_yubin_no,torihiki_jyusyo,torihiki_tel_no," )
fnc.strg.of_append_line( l_sql, "       touroku_no," )
fnc.strg.of_append_line( l_sql, "       mise_mei_hyoji_kbn,mise_mei," )
fnc.strg.of_append_line( l_sql, "       mise_code_hyoji_kbn,mise_code," )
fnc.strg.of_append_line( l_sql, "       bumon_code_hyoji_kbn,bumon_code," )
fnc.strg.of_append_line( l_sql, "       denpyo_kbn_hyoji_kbn,denpyo_kbn," )
fnc.strg.of_append_line( l_sql, "       suryo_hyoji_kbn,genka_hyoji_kbn,baika_hyoji_kbn,nen_hyoji_kbn,nengappi_hyoji_kbn," )
fnc.strg.of_append_line( l_sql, "       teisei_kbn,tekiyo_hyoji_kbn,aite_hinban_kbn,aite_hinban_gokei_kbn,nohinsyo_no_hyoji_kbn," )
fnc.strg.of_append_line( l_sql, "       aite_hatyu_no_hyoji_kbn,jyutyu_no_hyoji_kbn," )
fnc.strg.of_append_line( l_sql, "       tyui_jikou_senden," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msenden_kanri.get_full( {1} ) )", string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tyohyo_id1				= l_ds.object.tyohyo_id1[l_cnt]
			l_recs[l_cnt].tyohyo_id2				= l_ds.object.tyohyo_id2[l_cnt]
			l_recs[l_cnt].tyohyo_id3				= l_ds.object.tyohyo_id3[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_1		= l_ds.object.senden_hakkou_flg_1[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_2		= l_ds.object.senden_hakkou_flg_2[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_3		= l_ds.object.senden_hakkou_flg_3[l_cnt]
			l_recs[l_cnt].zei_hyoji_kbn1			= l_ds.object.zei_hyoji_kbn1[l_cnt]
			l_recs[l_cnt].zei_hyoji_kbn2			= l_ds.object.zei_hyoji_kbn2[l_cnt]
			l_recs[l_cnt].zei_hyoji_kbn3			= l_ds.object.zei_hyoji_kbn3[l_cnt]
			l_recs[l_cnt].meisai_gyo_su1			= l_ds.object.meisai_gyo_su1[l_cnt]
			l_recs[l_cnt].meisai_gyo_su2			= l_ds.object.meisai_gyo_su2[l_cnt]
			l_recs[l_cnt].meisai_gyo_su3			= l_ds.object.meisai_gyo_su3[l_cnt]
			l_recs[l_cnt].senden_no_kbn1			= l_ds.object.senden_no_kbn1[l_cnt]
			l_recs[l_cnt].senden_no_kbn2			= l_ds.object.senden_no_kbn2[l_cnt]
			l_recs[l_cnt].senden_no_kbn3			= l_ds.object.senden_no_kbn3[l_cnt]
			l_recs[l_cnt].genzai_no					= l_ds.object.genzai_no[l_cnt]
			l_recs[l_cnt].kaisi_no					= l_ds.object.kaisi_no[l_cnt]
			l_recs[l_cnt].syuryo_no					= l_ds.object.syuryo_no[l_cnt]
			l_recs[l_cnt].cd_kbn					= l_ds.object.cd_kbn[l_cnt]
			l_recs[l_cnt].tokui_mei_hyoji_kbn		= l_ds.object.tokui_mei_hyoji_kbn[l_cnt]
			l_recs[l_cnt].tokui_mei					= l_ds.object.tokui_mei[l_cnt]
			l_recs[l_cnt].torihiki_code_hyoji_kbn	= l_ds.object.torihiki_code_hyoji_kbn[l_cnt]
			l_recs[l_cnt].torihiki_code				= l_ds.object.torihiki_code[l_cnt]
			l_recs[l_cnt].torihiki_hyoji_kbn		= l_ds.object.torihiki_hyoji_kbn[l_cnt]
			l_recs[l_cnt].torihiki_kaisya_mei		= l_ds.object.torihiki_kaisya_mei[l_cnt]
			l_recs[l_cnt].torihiki_yubin_no			= l_ds.object.torihiki_yubin_no[l_cnt]
			l_recs[l_cnt].torihiki_jyusyo			= l_ds.object.torihiki_jyusyo[l_cnt]
			l_recs[l_cnt].torihiki_tel_no			= l_ds.object.torihiki_tel_no[l_cnt]
			l_recs[l_cnt].touroku_no				= l_ds.object.touroku_no[l_cnt]
			l_recs[l_cnt].mise_mei_hyoji_kbn		= l_ds.object.mise_mei_hyoji_kbn[l_cnt]
			l_recs[l_cnt].mise_mei					= l_ds.object.mise_mei[l_cnt]
			l_recs[l_cnt].mise_code_hyoji_kbn		= l_ds.object.mise_code_hyoji_kbn[l_cnt]
			l_recs[l_cnt].mise_code					= l_ds.object.mise_code[l_cnt]
			l_recs[l_cnt].bumon_code_hyoji_kbn		= l_ds.object.bumon_code_hyoji_kbn[l_cnt]
			l_recs[l_cnt].bumon_code				= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].denpyo_kbn_hyoji_kbn		= l_ds.object.denpyo_kbn_hyoji_kbn[l_cnt]
			l_recs[l_cnt].denpyo_kbn				= l_ds.object.denpyo_kbn[l_cnt]
			l_recs[l_cnt].suryo_hyoji_kbn			= l_ds.object.suryo_hyoji_kbn[l_cnt]
			l_recs[l_cnt].genka_hyoji_kbn			= l_ds.object.genka_hyoji_kbn[l_cnt]
			l_recs[l_cnt].baika_hyoji_kbn			= l_ds.object.baika_hyoji_kbn[l_cnt]
			l_recs[l_cnt].nen_hyoji_kbn				= l_ds.object.nen_hyoji_kbn[l_cnt]
			l_recs[l_cnt].nengappi_hyoji_kbn		= l_ds.object.nengappi_hyoji_kbn[l_cnt]
			l_recs[l_cnt].teisei_kbn				= l_ds.object.teisei_kbn[l_cnt]
			l_recs[l_cnt].tekiyo_hyoji_kbn			= l_ds.object.tekiyo_hyoji_kbn[l_cnt]
			l_recs[l_cnt].aite_hinban_kbn			= l_ds.object.aite_hinban_kbn[l_cnt]
			l_recs[l_cnt].aite_hinban_gokei_kbn		= l_ds.object.aite_hinban_gokei_kbn[l_cnt]
			l_recs[l_cnt].nohinsyo_no_hyoji_kbn		= l_ds.object.nohinsyo_no_hyoji_kbn[l_cnt]
			l_recs[l_cnt].aite_hatyu_no_hyoji_kbn	= l_ds.object.aite_hatyu_no_hyoji_kbn[l_cnt]
			l_recs[l_cnt].jyutyu_no_hyoji_kbn		= l_ds.object.jyutyu_no_hyoji_kbn[l_cnt]
			l_recs[l_cnt].tyui_jikou_senden			= l_ds.object.tyui_jikou_senden[l_cnt]
			l_recs[l_cnt].touroku_date				= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id			= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id			= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id				= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date				= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id			= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id			= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id				= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date				= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id			= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id			= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id				= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg					= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_senden_kanri_get (long p_tokui_code, ref str_msenden_kanri p_recs[]);
integer				l_cnt
str_msenden_kanri	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tokui_code," )
fnc.strg.of_append_line( l_sql, "       tyohyo_id1,tyohyo_id2,tyohyo_id3," )
fnc.strg.of_append_line( l_sql, "       senden_hakkou_flg_1,senden_hakkou_flg_2,senden_hakkou_flg_3" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msenden_kanri.get( {1} ) )", string( p_tokui_code ) ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tokui_code				= l_ds.object.tokui_code[l_cnt]
			l_recs[l_cnt].tyohyo_id1				= l_ds.object.tyohyo_id1[l_cnt]
			l_recs[l_cnt].tyohyo_id2				= l_ds.object.tyohyo_id2[l_cnt]
			l_recs[l_cnt].tyohyo_id3				= l_ds.object.tyohyo_id3[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_1		= l_ds.object.senden_hakkou_flg_1[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_2		= l_ds.object.senden_hakkou_flg_2[l_cnt]
			l_recs[l_cnt].senden_hakkou_flg_3		= l_ds.object.senden_hakkou_flg_3[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_senden_tyohyo_check (string p_tyohyo_id);
integer	l_ret

declare orafunc procedure for msenden_tyohyo.chk( :p_tyohyo_id ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_senden_tyohyo_get_full (string p_tyohyo_id, ref str_msenden_tyohyo p_recs[]);
integer				l_cnt
str_msenden_tyohyo	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tyohyo_id," )
fnc.strg.of_append_line( l_sql, "       tyohyo_mei,tyohyo_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       tyohyo_syubetu," )
fnc.strg.of_append_line( l_sql, "       max_gyo_su," )
fnc.strg.of_append_line( l_sql, "       syori_jyun," )
fnc.strg.of_append_line( l_sql, "       guide_message," )
fnc.strg.of_append_line( l_sql, "       touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id," )
fnc.strg.of_append_line( l_sql, "       henkou_date,henkou_user_id,henkou_client_id,henkou_pg_id," )
fnc.strg.of_append_line( l_sql, "       kousin_date,kousin_user_id,kousin_client_id,kousin_pg_id," )
fnc.strg.of_append_line( l_sql, "       haita_flg" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msenden_tyohyo.get_full( '{1}' ) )", p_tyohyo_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tyohyo_id			= l_ds.object.tyohyo_id[l_cnt]
			l_recs[l_cnt].tyohyo_mei		= l_ds.object.tyohyo_mei[l_cnt]
			l_recs[l_cnt].tyohyo_mei_ryaku	= l_ds.object.tyohyo_mei_ryaku[l_cnt]
			l_recs[l_cnt].tyohyo_syubetu	= l_ds.object.tyohyo_syubetu[l_cnt]
			l_recs[l_cnt].max_gyo_su		= l_ds.object.max_gyo_su[l_cnt]
			l_recs[l_cnt].syori_jyun		= l_ds.object.syori_jyun[l_cnt]
			l_recs[l_cnt].guide_message		= l_ds.object.guide_message[l_cnt]
			l_recs[l_cnt].touroku_date		= l_ds.object.touroku_date[l_cnt]
			l_recs[l_cnt].touroku_user_id	= l_ds.object.touroku_user_id[l_cnt]
			l_recs[l_cnt].touroku_client_id	= l_ds.object.touroku_client_id[l_cnt]
			l_recs[l_cnt].touroku_pg_id		= l_ds.object.touroku_pg_id[l_cnt]
			l_recs[l_cnt].henkou_date		= l_ds.object.henkou_date[l_cnt]
			l_recs[l_cnt].henkou_user_id	= l_ds.object.henkou_user_id[l_cnt]
			l_recs[l_cnt].henkou_client_id	= l_ds.object.henkou_client_id[l_cnt]
			l_recs[l_cnt].henkou_pg_id		= l_ds.object.henkou_pg_id[l_cnt]
			l_recs[l_cnt].kousin_date		= l_ds.object.kousin_date[l_cnt]
			l_recs[l_cnt].kousin_user_id	= l_ds.object.kousin_user_id[l_cnt]
			l_recs[l_cnt].kousin_client_id	= l_ds.object.kousin_client_id[l_cnt]
			l_recs[l_cnt].kousin_pg_id		= l_ds.object.kousin_pg_id[l_cnt]
			l_recs[l_cnt].haita_flg			= l_ds.object.haita_flg[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_senden_tyohyo_get (string p_tyohyo_id, ref str_msenden_tyohyo p_recs[]);
integer				l_cnt
str_msenden_tyohyo	l_recs[]

string				l_sql
datastore			l_ds

fnc.strg.of_append_line( l_sql, "select tyohyo_id," )
fnc.strg.of_append_line( l_sql, "       tyohyo_mei,tyohyo_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       tyohyo_syubetu," )
fnc.strg.of_append_line( l_sql, "       max_gyo_su," )
fnc.strg.of_append_line( l_sql, "       syori_jyun," )
fnc.strg.of_append_line( l_sql, "       guide_message" )
fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( msenden_tyohyo.get( '{1}' ) )", p_tyohyo_id ) )

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].tyohyo_id			= l_ds.object.tyohyo_id[l_cnt]
			l_recs[l_cnt].tyohyo_mei		= l_ds.object.tyohyo_mei[l_cnt]
			l_recs[l_cnt].tyohyo_mei_ryaku	= l_ds.object.tyohyo_mei_ryaku[l_cnt]
			l_recs[l_cnt].tyohyo_syubetu	= l_ds.object.tyohyo_syubetu[l_cnt]
			l_recs[l_cnt].max_gyo_su		= l_ds.object.max_gyo_su[l_cnt]
			l_recs[l_cnt].syori_jyun		= l_ds.object.syori_jyun[l_cnt]
			l_recs[l_cnt].guide_message		= l_ds.object.guide_message[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt
end function

public function integer of_kojyo_check (long p_kojyo_code, integer p_bumon_code);
integer	l_ret

declare orafunc procedure for symkojyo.chk( :p_kojyo_code, :p_bumon_code ) using cocos;
execute orafunc;
fetch orafunc into :l_ret;
close orafunc;

if cocos.sqlcode <> 0 then
	return -1
end if

return l_ret
end function

public function integer of_kojyo_check (long p_kojyo_code);
integer	l_bumon_code

setnull( l_bumon_code )

return of_kojyo_check( p_kojyo_code, l_bumon_code )

end function

public function integer of_kojyo_get (long p_kojyo_code, integer p_bumon_code, ref str_symkojyo p_recs[]);
// PL/SQLで%rowtypeが使えないため、全カラム取得は無し

integer			l_cnt
str_symkojyo	l_recs[]

string			l_sql
datastore		l_ds

fnc.strg.of_append_line( l_sql, "select kojyo_code,bumon_code," )
fnc.strg.of_append_line( l_sql, "       kojyo_mei, kojyo_mei_ryaku," )
fnc.strg.of_append_line( l_sql, "       kojyo_kbn," )
fnc.strg.of_append_line( l_sql, "       tuka_code" )

// 工場コードが未設定の場合は条件に加えない
if isnull( p_bumon_code ) then
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( symkojyo.get( {1} ) )", string( p_kojyo_code ) ) )
else
	fnc.strg.of_append_line( l_sql, fnc.strg.of_format( "  from table( symkojyo.get( {1}, {2} ) )", string( p_kojyo_code ), string( p_bumon_code ) ) )
end if

l_cnt	= 0
l_ds	= create datastore

if create_syntax( l_ds, l_sql ) then
	if l_ds.retrieve() > 0 then
		for l_cnt = 1 to l_ds.rowcount()
			l_recs[l_cnt].kojyo_code		= l_ds.object.kojyo_code[l_cnt]
			l_recs[l_cnt].bumon_code		= l_ds.object.bumon_code[l_cnt]
			l_recs[l_cnt].kojyo_mei			= l_ds.object.kojyo_mei[l_cnt]
			l_recs[l_cnt].kojyo_mei_ryaku	= l_ds.object.kojyo_mei_ryaku[l_cnt]
			l_recs[l_cnt].kojyo_kbn			= l_ds.object.kojyo_kbn[l_cnt]
			l_recs[l_cnt].tuka_code			= l_ds.object.tuka_code[l_cnt]
		next
	end if
else
	l_cnt	= -1
end if

destroy l_ds

p_recs	= l_recs

return l_cnt

end function

public function integer of_kojyo_get (long p_kojyo_code, ref str_symkojyo p_recs[]);
integer	l_bumon_code

setnull( l_bumon_code )

return of_kojyo_get( p_kojyo_code, l_bumon_code, p_recs )
end function

on nv_master.create
call super::create
end on

on nv_master.destroy
call super::destroy
end on

