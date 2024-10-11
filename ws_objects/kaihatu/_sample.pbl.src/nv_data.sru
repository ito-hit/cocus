$PBExportHeader$nv_data.sru
$PBExportComments$データ取得をするノンビジュアルオブジェクト
forward
global type nv_data from inv_object
end type
end forward

global type nv_data from inv_object autoinstantiate
end type

type variables

end variables

forward prototypes
private function str_dpara get_data (string p_dwo, str_dpara p_dpara)
public function str_dpara of_get_tanto (long p_tanto_code)
public function str_dpara of_get_menu (string p_menu_id)
public function str_dpara of_get_tab (string p_menu_id, string p_tab_id)
public function str_dpara of_get_meisyo_parent (string p_meisyo_code)
public function str_dpara of_get_tokui (long p_tokui_code)
public function str_dpara of_get_mise (long p_tokui_code, long p_mise_code)
end prototypes

private function str_dpara get_data (string p_dwo, str_dpara p_dpara);
// of_get_***(呼び出し元)へ、nv_modalのof_get_dataからの戻り値をバイパスする関数

str_dpara	l_ret	// バイパスしてreturnする用の変数

l_ret	= mdl.of_get_data( p_dwo, p_dpara )

return l_ret
end function

public function str_dpara of_get_tanto (long p_tanto_code);
// p_tanto_codeをwhere句へ生成してget_dataへ渡す。そのtanto_codeで検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// p_tanto_codeがあればwhere句を生成
if p_tanto_code <> 0 then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "tanto_code = " + string( p_tanto_code )
end if

l_dpara	= get_data( "dsm_tanto", l_dpara )

return l_dpara
end function

public function str_dpara of_get_menu (string p_menu_id);
// p_menu_idをwhere句へ生成してget_dataへ渡す。そのmenu_idで検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// p_menu_idがあればwhere句を生成
if p_menu_id <> "" then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "menu_id = '" + p_menu_id + "'"
end if

l_dpara	= get_data( "dsm_menu", l_dpara )

return l_dpara
end function

public function str_dpara of_get_tab (string p_menu_id, string p_tab_id);
// p_menu_id, p_tab_idをwhere句へ生成してget_dataへ渡す。検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// where句を生成
if p_menu_id <> "" then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "menu_id = '" + p_menu_id + "'"
	l_dpara.in_para[upperbound(l_dpara.in_para) + 1]				= string( p_menu_id )	// mulitpleでmodal表示するときにセット必要
end if

if p_tab_id <> "" then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "tab_id = '" + p_tab_id + "'"
end if

l_dpara	= get_data( "dsm_tab", l_dpara )

return l_dpara
end function

public function str_dpara of_get_meisyo_parent (string p_meisyo_code);
// p_meisyo_codeをwhere句へ生成してget_dataへ渡す。そのmeisyo_codeで検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// p_meisyo_codeがあればwhere句を生成
if p_meisyo_code <> "" then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "meisyo_code = '" + p_meisyo_code + "'"
end if

l_dpara	= get_data( "dsm_meisyo_parent", l_dpara )

return l_dpara
end function

public function str_dpara of_get_tokui (long p_tokui_code);
// p_tokui_codeをwhere句へ生成してget_dataへ渡す。そのtokui_codeで検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// p_tokui_codeがあればwhere句を生成
if p_tokui_code <> 0 then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "tokui_code = " + string( p_tokui_code )
end if

l_dpara	= get_data( "dsm_tokui", l_dpara )

return l_dpara
end function

public function str_dpara of_get_mise (long p_tokui_code, long p_mise_code);
// p_tokui_code, p_mise_codeをwhere句へ生成してget_dataへ渡す。検索されたレコードがstr_dpara.dsに格納されてreturnされるので、そのままreturnする。

str_dpara	l_dpara

// where句を生成
if p_tokui_code <> 0 then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "tokui_code = " + string( p_tokui_code )
	l_dpara.in_para[upperbound(l_dpara.in_para) + 1]				= string( p_tokui_code )	// mulitpleでmodal表示するときにセット必要
end if

if p_mise_code <> 0 then
	l_dpara.where_string[upperbound( l_dpara.where_string ) + 1]	= "mise_code = " + string( p_mise_code )
end if

l_dpara	= get_data( "dsm_mise", l_dpara )

return l_dpara
end function

on nv_data.create
call super::create
end on

on nv_data.destroy
call super::destroy
end on

