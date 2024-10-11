$PBExportHeader$nv_lock.sru
$PBExportComments$悲観ロックに関する共通関数
forward
global type nv_lock from inv_object
end type
end forward

global type nv_lock from inv_object autoinstantiate
end type

forward prototypes
public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, string p_meisyo_code)
public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn)
public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, boolean p_lock)
public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, string p_meisyo_code, boolean p_lock)
public function boolean of_menu_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_menu_id, string p_tab_id, boolean p_lock)
public function boolean of_menu_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_menu_id, string p_tab_id)
public function boolean of_brand_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_brand_code)
public function boolean of_brand_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_brand_code, boolean p_lock)
public function boolean of_bukken_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_bukken_code, boolean p_lock)
public function boolean of_bukken_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_bukken_code)
public function boolean of_bunrui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, boolean p_lock)
public function boolean of_bunrui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code)
public function boolean of_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_group_code, boolean p_lock)
public function boolean of_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_group_code)
public function boolean of_kihon_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kanri_code, boolean p_lock)
public function boolean of_kihon_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kanri_code)
public function boolean of_kyoten_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_code, boolean p_lock)
public function boolean of_kyoten_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_code)
public function boolean of_kyoten_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_group_code, boolean p_lock)
public function boolean of_kyoten_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_group_code)
public function boolean of_mise_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_mise_code, boolean p_lock)
public function boolean of_mise_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_mise_code)
public function boolean of_nendo_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_nendo_code, boolean p_lock)
public function boolean of_nendo_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_nendo_code)
public function boolean of_niokurinin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_niokurinin_code, boolean p_lock)
public function boolean of_niokurinin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_niokurinin_code)
public function boolean of_tanka_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_syohin_code, boolean p_lock)
public function boolean of_tanka_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_syohin_code)
public function boolean of_tanto_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tanto_code, boolean p_lock)
public function boolean of_tanto_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tanto_code)
public function boolean of_unso_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_unso_code, boolean p_lock)
public function boolean of_unso_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_unso_code)
public function boolean of_syohin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_syohin_code, long p_iro_no, boolean p_lock)
public function boolean of_syohin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_syohin_code, long p_iro_no)
public function boolean of_tokui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, boolean p_lock)
public function boolean of_tokui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code)
public function boolean of_user_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_user_id, boolean p_lock)
public function boolean of_user_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_user_id)
public function boolean of_yubin_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_yubin_no, boolean p_lock)
public function boolean of_yubin_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_yubin_no)
public function boolean of_untin_kijyun_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_kijyun_code, boolean p_lock)
public function boolean of_untin_kijyun_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_kijyun_code)
public function boolean of_gtin_kanri_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_jigyosya_code, boolean p_lock)
public function boolean of_gtin_kanri_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_jigyosya_code)
public function boolean of_kamoku_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kamoku_code, long p_hojyo_kamoku_code, boolean p_lock)
public function boolean of_kamoku_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kamoku_code, long p_hojyo_kamoku_code)
public function boolean of_tyakuten_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_unso_code, string p_yubin_no, string p_tyakuten_code, boolean p_lock)
end prototypes

public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, string p_meisyo_code);
return of_meisyo_lock( p_kousin_user_id, p_kousin_pg_id, p_meisyo_kbn, p_meisyo_code, true )
end function

public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn);
return of_meisyo_lock( p_kousin_user_id, p_kousin_pg_id, p_meisyo_kbn, true )
end function

public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, boolean p_lock);
// 名称マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mmeisyo.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_meisyo_kbn, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_meisyo_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_meisyo_kbn, string p_meisyo_code, boolean p_lock);
// 名称マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mmeisyo.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_meisyo_kbn, :p_meisyo_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_menu_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_menu_id, string p_tab_id, boolean p_lock);
// メニューマスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mmenu.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_menu_id, :p_tab_id, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_menu_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_menu_id, string p_tab_id);
return of_menu_lock( p_kousin_user_id, p_kousin_pg_id, p_menu_id, p_tab_id, true )
end function

public function boolean of_brand_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_brand_code);
return of_brand_lock( p_kousin_user_id, p_kousin_pg_id, p_brand_code, true )
end function

public function boolean of_brand_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_brand_code, boolean p_lock);
// ブランドマスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mbrand.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_brand_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_bukken_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_bukken_code, boolean p_lock);
// 物件マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mbukken.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_bukken_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_bukken_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_bukken_code);
return of_bukken_lock( p_kousin_user_id, p_kousin_pg_id, p_bukken_code, true )
end function

public function boolean of_bunrui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code, boolean p_lock);
// 分類マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mbunrui.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_daibunrui_code, :p_tyubunrui_code, :p_syobunrui_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_bunrui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_daibunrui_code, long p_tyubunrui_code, long p_syobunrui_code);
return of_bunrui_lock( p_kousin_user_id, p_kousin_pg_id, p_daibunrui_code, p_tyubunrui_code, p_syobunrui_code, true )
end function

public function boolean of_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_group_code, boolean p_lock);
// グループマスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mgroup.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_group_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_group_code);
return of_group_lock( p_kousin_user_id, p_kousin_pg_id, p_group_code, true )
end function

public function boolean of_kihon_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kanri_code, boolean p_lock);
// 基本情報マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mkihon.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_kanri_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_kihon_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kanri_code);
return of_kihon_lock( p_kousin_user_id, p_kousin_pg_id, p_kanri_code, true )
end function

public function boolean of_kyoten_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_code, boolean p_lock);
// 拠点マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mkyoten.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_kyoten_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_kyoten_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_code);
return of_kyoten_lock( p_kousin_user_id, p_kousin_pg_id, p_kyoten_code, true )
end function

public function boolean of_kyoten_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_group_code, boolean p_lock);
// 拠点グループマスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mkyoten_group.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_kyoten_group_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_kyoten_group_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kyoten_group_code);
return of_kyoten_group_lock( p_kousin_user_id, p_kousin_pg_id, p_kyoten_group_code, true )
end function

public function boolean of_mise_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_mise_code, boolean p_lock);
// 店マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mmise.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_tokui_code, :p_mise_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_mise_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_mise_code);
return of_mise_lock( p_kousin_user_id, p_kousin_pg_id, p_tokui_code, p_mise_code, true )
end function

public function boolean of_nendo_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_nendo_code, boolean p_lock);
// 事業年度マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mnendo.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_nendo_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_nendo_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_nendo_code);
return of_nendo_lock( p_kousin_user_id, p_kousin_pg_id, p_nendo_code, true )
end function

public function boolean of_niokurinin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_niokurinin_code, boolean p_lock);
// 荷送人マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mniokurinin.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_niokurinin_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_niokurinin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_niokurinin_code);
return of_niokurinin_lock( p_kousin_user_id, p_kousin_pg_id, p_niokurinin_code, true )
end function

public function boolean of_tanka_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_syohin_code, boolean p_lock);
// 単価マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mtanka.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_tokui_code, :p_syohin_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_tanka_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, long p_syohin_code);
return of_tanka_lock( p_kousin_user_id, p_kousin_pg_id, p_tokui_code, p_syohin_code, true )
end function

public function boolean of_tanto_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tanto_code, boolean p_lock);
// 担当者マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mtanto.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_tanto_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_tanto_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tanto_code);
return of_tanto_lock( p_kousin_user_id, p_kousin_pg_id, p_tanto_code, true )
end function

public function boolean of_unso_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_unso_code, boolean p_lock);
// 運送便マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for munso.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_unso_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_unso_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_unso_code);
return of_unso_lock( p_kousin_user_id, p_kousin_pg_id, p_unso_code, true )
end function

public function boolean of_syohin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_syohin_code, long p_iro_no, boolean p_lock);
// 商品マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

// ↓こういうやり方もある
//declare oraproc procedure for msyohin.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_syohin_code, p_iro_no => :p_iro_no, p_lock => :l_lock ) using cocos;

declare oraproc procedure for msyohin.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_syohin_code, :p_iro_no, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_syohin_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_syohin_code, long p_iro_no);
return of_syohin_lock( p_kousin_user_id, p_kousin_pg_id, p_syohin_code, p_iro_no, true )
end function

public function boolean of_tokui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code, boolean p_lock);
// 得意先マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mtokui.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_tokui_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_tokui_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_tokui_code);
return of_tokui_lock( p_kousin_user_id, p_kousin_pg_id, p_tokui_code, true )
end function

public function boolean of_user_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_user_id, boolean p_lock);
// ユーザーマスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for muser.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_user_id, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_user_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_user_id);
return of_user_lock( p_kousin_user_id, p_kousin_pg_id, p_user_id, true )
end function

public function boolean of_yubin_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_yubin_no, boolean p_lock);
// 郵便番号マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for myubin.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_yubin_no, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_yubin_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_yubin_no);
return of_yubin_lock( p_kousin_user_id, p_kousin_pg_id, p_yubin_no, true )
end function

public function boolean of_untin_kijyun_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_kijyun_code, boolean p_lock);
// 運賃基準マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for muntin_kijyun.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_kijyun_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_untin_kijyun_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_kijyun_code);
return of_untin_kijyun_lock( p_kousin_user_id, p_kousin_pg_id, p_kijyun_code, true )
end function

public function boolean of_gtin_kanri_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_jigyosya_code, boolean p_lock);
// GTIN管理マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mgtin_kanri.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_jigyosya_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_gtin_kanri_lock (string p_kousin_user_id, string p_kousin_pg_id, string p_jigyosya_code);
return of_gtin_kanri_lock( p_kousin_user_id, p_kousin_pg_id, p_jigyosya_code, true )
end function

public function boolean of_kamoku_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kamoku_code, long p_hojyo_kamoku_code, boolean p_lock);
// 勘定科目マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mkamoku.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_kamoku_code, :p_hojyo_kamoku_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

public function boolean of_kamoku_lock (string p_kousin_user_id, string p_kousin_pg_id, long p_kamoku_code, long p_hojyo_kamoku_code);
return of_kamoku_lock( p_kousin_user_id, p_kousin_pg_id, p_kamoku_code, p_hojyo_kamoku_code, true )
end function

public function boolean of_tyakuten_lock (string p_kousin_user_id, string p_kousin_pg_id, integer p_unso_code, string p_yubin_no, string p_tyakuten_code, boolean p_lock);
// 着店マスターへ排他ロックをかける関数(排他フラグに1を立てる)
// True：ロックに成功(呼び出し元ではcommitが必要)　False：ロックに失敗(PL/SQL内でrollbackするけど呼び出し元でrollbackしてもいい)

integer	l_ret
integer	l_lock

if p_lock then
	l_lock	= 1
else
	l_lock	= 0
end if

declare oraproc procedure for mtyakuten.plock( :p_kousin_user_id, :p_kousin_pg_id, :p_unso_code, :p_yubin_no, :p_tyakuten_code, :l_lock ) using cocos;
execute oraproc;

// procedureは戻り値がないので、正常に実行されたらsqlcode=100が返ってくる
if cocos.sqlcode <> 0 and cocos.sqlcode <> 100 then
	return false
end if

return true
end function

on nv_lock.create
call super::create
end on

on nv_lock.destroy
call super::destroy
end on

