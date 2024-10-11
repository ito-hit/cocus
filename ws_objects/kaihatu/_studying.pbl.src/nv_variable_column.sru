$PBExportHeader$nv_variable_column.sru
forward
global type nv_variable_column from nonvisualobject
end type
type str_separate_syntax from structure within nv_variable_column
end type
end forward

type str_separate_syntax from structure
	string		heads[]
	string		cols[]
	string		sqls[]
	string		paras[]
	string		body_txts[]
	string		body_cols[]
	string		foots[]
end type

global type nv_variable_column from nonvisualobject
end type
global nv_variable_column nv_variable_column

type variables

public:
	long			i_syohin_code
	long			i_iro_ban


protected:
	inv_datastore	i_head_ds
	inv_datastore	i_body_ds
	ivo_datawindow	i_body_dw


private:
	string			dataobject
	string			syntaxsql
	string			target[]
	string			custom_syntaxsql
	
	string			bswitch[]	= { "text(", "column(" }

end variables

forward prototypes
private function boolean get_available_size (long p_syohin_code, long p_iro_ban, ref integer p_size_iti[])
public function ivo_datawindow of_get_dw (long p_syohin_code, long p_iro_ban)
public function string create_cusrom_syntax (string p_base_syntax, integer p_size_iti[])
private function integer split_syntax (string p_syntaxs[], ref string p_array[], string p_conditions[], integer p_start_row, integer p_id)
private function boolean separate_syntax (string p_syntaxs[], ref str_separate_syntax p_separate)
public function long cnv_str2num (string p_string)
public subroutine of_test ()
private function boolean isexists (integer p_value, integer p_chklists[], ref integer p_col)
private function boolean isexists (string p_value, string p_chklists[], ref integer p_col)
private function string sql_cleansing (string p_value, string p_chkcols[], integer p_chknos[])
public subroutine of_init (string p_dataobject, string p_finds[])
private function boolean regenerate (string p_before_syntaxs[], integer p_target_no[], boolean p_sql, ref string p_after_syntax[])
private function boolean get_zaiko (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt)
public function inv_datastore of_get_ds (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt)
public function string of_get_custom_syntax (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt)
private subroutine recolumnid (string p_cols[], ref string p_body_cols[])
end prototypes

private function boolean get_available_size (long p_syohin_code, long p_iro_ban, ref integer p_size_iti[]);
integer	l_size_iti

declare iti_cur cursor for
	select size_iti
	  from m_syohin
	 where syohin_code	= :p_syohin_code
	   and iro_no		= :p_iro_ban
	order by size_iti
using cocos;

open iti_cur;
if cocos.sqlcode <> 0 then
	msg.of_error( "サイズ位置取得のための処理（OpenCursor）に失敗しました。" )
	return false
else
	fetch iti_cur into :l_size_iti;

	choose case cocos.sqlcode 
	case 0
	case 100
		msg.of_error( fnc.strg.of_format( "入力された商品のサイズ情報がありません。（商品：{1}-{2}）", string( p_syohin_code ), string( p_iro_ban ) ) )
		close iti_cur;
		return false
	case else
		msg.of_error_db( "サイズ位置取得のための処理でエラーが発生しました。", cocos )
		close iti_cur;
		return false
	end choose
end if

do until cocos.sqlcode <> 0
	p_size_iti[upperbound( p_size_iti ) + 1]	= l_size_iti
	
	fetch iti_cur into :l_size_iti;
loop

close iti_cur;

return true
end function

public function ivo_datawindow of_get_dw (long p_syohin_code, long p_iro_ban);
integer	l_cnt

get_zaiko( p_syohin_code, p_iro_ban, l_cnt )

string	l_err

if i_body_dw.create( syntaxsql, l_err ) <> 1 then
	msg.of_error( l_err )
end if
i_body_dw.settransobject( cocos )


return i_body_dw
end function

public function string create_cusrom_syntax (string p_base_syntax, integer p_size_iti[]);
// 指定の場所で分離したSyntaxの文字列配列
str_separate_syntax	l_sep

integer	l_row
string	l_custom_syntax
string	l_syntaxs[]

// 元のSyntax（DWソース）をCRLFを区切りに配列にぶち込む
l_syntaxs	= fnc.strg.of_split( p_base_syntax, code.crlf )

// 区切りとする文字列を基準にそれぞれの配列に分ける
if not separate_syntax( l_syntaxs, l_sep ) then
	return ""
end if

string	l_msg

fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "syntaxs：{1}", string( upperbound( l_syntaxs ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "head:{1}", 	string( upperbound( l_sep.heads ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "col:{1}", 		string( upperbound( l_sep.cols ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "sql:{1}", 		string( upperbound( l_sep.sqls ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "para:{1}", 	string( upperbound( l_sep.paras ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "body_txt:{1}", string( upperbound( l_sep.body_txts ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "body_col:{1}", string( upperbound( l_sep.body_cols ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "foot:{1}", 	string( upperbound( l_sep.foots ) ) ) )
fnc.strg.of_append_line( l_msg, fnc.strg.of_format( "total:{1}", 	string( upperbound( l_sep.heads ) + upperbound( l_sep.cols ) + upperbound( l_sep.sqls ) + upperbound( l_sep.paras ) + upperbound( l_sep.body_txts ) + upperbound( l_sep.body_cols ) + upperbound( l_sep.foots ) ) ) )

//msg.of_info( l_msg )

// 各配列ごとに不要行を削除するとともに位置（X値）も更新していく
integer	l_x	= 12	// X値に付加する係数

// なにもしなくていいやつ
/* l_sep.heads, l_sep.paras, l_sep.foots */
//integer	l_spos, l_epos, l_col
//long	l_no
//string	l_sword, l_eword, l_no_string
//string	l_target[], l_lists[], l_dummy[]

string	l_new_cols[], l_new_sqls[], l_new_body_txts[], l_new_body_cols[]
regenerate( l_sep.cols, p_size_iti, false, l_new_cols )
regenerate( l_sep.sqls, p_size_iti, true, l_new_sqls )
regenerate( l_sep.body_txts, p_size_iti, false, l_new_body_txts )
regenerate( l_sep.body_cols, p_size_iti, false, l_new_body_cols )

// DWのカラムIDを振りなおし（エラーになるので）
recolumnid( l_new_cols, l_new_body_cols )

string	l_head,l_col,l_sql,l_para,l_body_txt,l_body_col,l_foot
 
l_head		= fnc.strg.of_join( l_sep.heads, code.crlf )
//l_col		= fnc.strg.of_join( l_sep.cols, code.crlf )
l_col		= fnc.strg.of_join( l_new_cols, code.crlf )
//l_sql		= fnc.strg.of_join( l_sep.sqls, code.crlf )
l_sql		= fnc.strg.of_join( l_new_sqls, code.crlf )
l_para		= fnc.strg.of_join( l_sep.paras, code.crlf )
//l_body_txt	= fnc.strg.of_join( l_sep.body_txts, code.crlf )
l_body_txt	= fnc.strg.of_join( l_new_body_txts, code.crlf )
//l_body_col	= fnc.strg.of_join( l_sep.body_cols, code.crlf )
l_body_col	= fnc.strg.of_join( l_new_body_cols, code.crlf )
l_foot		= fnc.strg.of_join( l_sep.foots, code.crlf )

l_custom_syntax	= l_head

//fnc.strg.of_append_line( l_custom_syntax, l_head )
fnc.strg.of_append_line( l_custom_syntax, l_col )
fnc.strg.of_append_line( l_custom_syntax, l_sql )
fnc.strg.of_append_line( l_custom_syntax, l_para )
fnc.strg.of_append_line( l_custom_syntax, l_body_txt )
fnc.strg.of_append_line( l_custom_syntax, l_body_col )
fnc.strg.of_append_line( l_custom_syntax, l_foot )


////l_sep.cols -- start
//l_sword		= "dbname="
//l_eword		= code.dquote
//l_target	= { "size_iti", "sku_code", "size_code", "zaiko_su" }
//
//l_lists		= l_dummy
//for l_row = 1 to upperbound( l_sep.cols )
//	l_spos		= pos( l_sep.cols[l_row], l_sword )
//
//	if l_spos > 0 then
//		l_spos	= l_spos + len( l_sword ) + 1
//		l_epos		= pos( l_sep.cols[l_row], l_eword, l_spos )
//		l_no_string	= mid( l_sep.cols[l_row], l_spos, l_epos - l_spos )
//
//		if isexists( l_no_string, l_target, l_col ) then
//			l_no	= cnv_str2num( l_no_string )
//			
//			if not isnull( l_no ) then
//				if isexists( l_no, p_size_iti, l_col ) then
//					l_lists[upperbound(l_lists)+1]	= l_sep.cols[l_row]
//				end if
//			end if
//		else
//			l_lists[upperbound(l_lists)+1]	= l_sep.cols[l_row]
//		end if
//	else
//		l_lists[upperbound(l_lists)+1]	= l_sep.cols[l_row]
//	end if
//
//	if pos( l_lists[upperbound(l_lists)], "from" ) > 0 then
//		if right( l_lists[upperbound(l_lists)-1], 1 ) = "," then
//			l_lists[upperbound(l_lists)-1]	= left( l_lists[upperbound(l_lists)-1], len( l_lists[upperbound(l_lists)-1] ) - 1 )
//		end if
//	end if
//next
//
////l_sep.sqls -- start
//l_sword		= ") )"
//l_eword		= ","
//l_target	= { "size_iti", "sku_code", "size_code", "zaiko_su" }
//
//l_lists		= l_dummy
//for l_row = 1 to upperbound( l_sep.sqls )
//	l_spos		= pos( l_sep.sqls[l_row], l_sword )
//
//	if l_spos > 0 then
//		l_spos	= l_spos + len( l_sword ) + 1
//		l_epos		= pos( l_sep.sqls[l_row], l_eword, l_spos )
//
//		if l_epos = 0 then
//			l_epos	= len( l_sep.sqls[l_row] ) + 1
//		end if
//
//		l_no_string	= mid( l_sep.sqls[l_row], l_spos, l_epos - l_spos )
//
//		if isexists( l_no_string, l_target, l_col ) then
//			l_no	= cnv_str2num( l_no_string )
//			
//			if not isnull( l_no ) then
//				if isexists( l_no, p_size_iti, l_col ) then
//					l_lists[upperbound(l_lists)+1]	= l_sep.sqls[l_row]
//				end if
//			end if
//		else
//			l_lists[upperbound(l_lists)+1]	= l_sep.sqls[l_row]
//		end if
//	else
//		l_lists[upperbound(l_lists)+1]	= l_sep.sqls[l_row]
//	end if
//
//	if pos( l_lists[upperbound(l_lists)], "from" ) > 0 then
//		if right( l_lists[upperbound(l_lists)-1], 1 ) = "," then
//			l_lists[upperbound(l_lists)-1]	= left( l_lists[upperbound(l_lists)-1], len( l_lists[upperbound(l_lists)-1] ) - 1 )
//		end if
//	end if
//next
//
////l_sep.body_txts -- start
//// "text="
//
////l_sep.body_cols -- start
//// "name="

return l_custom_syntax
end function

private function integer split_syntax (string p_syntaxs[], ref string p_array[], string p_conditions[], integer p_start_row, integer p_id);
// p_idはbody（text or column）を識別するための識別子の目的で

integer	l_row, l_crow
integer	l_epos, l_cpos

for l_row = p_start_row to upperbound( p_syntaxs )
	for l_crow = 1 to upperbound( p_conditions )
		l_epos	= pos( p_syntaxs[l_row], p_conditions[l_crow], 1 )
		
		if l_epos > 0 then
			exit
		end if
	next

	if l_epos > 0 then
		exit
	else
		// 0以上はbody( text or column )で、bswitchの添え字で使用
		if p_id > 0 then
			if pos( p_syntaxs[l_row], bswitch[p_id] ) > 0 then
				p_array[upperbound( p_array ) + 1]	= p_syntaxs[l_row]
			end if
		else
			p_array[upperbound( p_array ) + 1]	= p_syntaxs[l_row]
		end if
	end if
next

return l_row
end function

private function boolean separate_syntax (string p_syntaxs[], ref str_separate_syntax p_separate);
string	l_switch[]	= { "table(column=", "retrieve=", "arguments=(", "*body", "htmltable", "*foot" }

integer	l_row, l_spos, l_spos_bk
string	l_pswitch[], l_sdummy[]

l_spos		= 1

for l_row = 1 to upperbound( l_switch )
	l_pswitch	= l_sdummy

	// 最後の引数はbody（text or column）を識別するために必要なもので、他のところでは意味なし
	// l_switchの文字列が見つかったらその行は次の配列となる区切り文字になる
	choose case l_row
		case 1	// head
			l_pswitch[1]	= l_switch[l_row]
			l_spos			= split_syntax( p_syntaxs, p_separate.heads, l_pswitch, l_spos, 0 )
		case 2	// column
			l_pswitch[1]	= l_switch[l_row]
			l_spos			= split_syntax( p_syntaxs, p_separate.cols, l_pswitch, l_spos, 0 )
		case 3	// sql
			l_pswitch[1]	= l_switch[l_row]
			l_spos			= split_syntax( p_syntaxs, p_separate.sqls, l_pswitch, l_spos, 0 )
		case 4	// argment
			// textかcolumnかわからないのでどちらかが出現するまで
			l_pswitch		= bswitch
			l_spos			= split_syntax( p_syntaxs, p_separate.paras, l_pswitch, l_spos, 0 )
		case 5	// text or column
			l_pswitch[1]	= l_switch[l_row]
			l_spos_bk		= l_spos

			l_spos			= split_syntax( p_syntaxs, p_separate.body_txts, l_pswitch, l_spos_bk, 1 )
			l_spos			= split_syntax( p_syntaxs, p_separate.body_cols, l_pswitch, l_spos_bk, 2 )
		case 6	// foot
			l_pswitch[1]	= l_switch[l_row]	// これは意味をなさない（最後まで読み切るので）
			l_spos			= split_syntax( p_syntaxs, p_separate.foots, l_pswitch, l_spos, 0 )
		case else
			msg.of_error( "SyntaxSQLでエラーが発生しました。" )
			return false
	end choose
next

return true
end function

public function long cnv_str2num (string p_string);
integer	l_row
string	l_cnv,l_char

for l_row = 1 to len( p_string )
	l_char	= mid( p_string, l_row, 1 )
	if isnumber( l_char ) then
		fnc.strg.of_append_line( l_cnv, l_char, false )
	end if
next

if len( l_cnv ) = 0 then
	setnull( l_cnv )
end if

return long( l_cnv )
end function

public subroutine of_test ();
string	l_test[], l_test2[],l_ans[], l_ans2[]

l_test	= { &
	" column=(type=number updatewhereclause=yes name=size_iti_1 dbname=~"size_iti_1~" )", &
	" column=(type=number updatewhereclause=yes name=size_iti_2 dbname=~"size_iti_2~" )", &
	" column=(type=number updatewhereclause=yes name=size_iti_16 dbname=~"size_iti_16~" )", &
	"text(band=header alignment=~"2~" text=~"zaiko_01~" border=~"0~" color=~"33554432~" x=~"2608~"  y=~"7~" height=~"43~" width=~"480~" html.valueishtml=~"0~"  name=zaiko_su_1_t visible=~"1~"  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )", &
	"text(band=header alignment=~"2~" text=~"zaiko_02~" border=~"0~" color=~"33554432~" x=~"3100~"  y=~"7~" height=~"43~" width=~"480~" html.valueishtml=~"0~"  name=zaiko_su_2_t visible=~"1~"  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )", &
	"text(band=header alignment=~"2~" text=~"zaiko_16~" border=~"0~" color=~"33554432~" x=~"3100~"  y=~"7~" height=~"43~" width=~"480~" html.valueishtml=~"0~"  name=zaiko_su_16_t visible=~"1~"  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )", &
	"column(band=detail id=109 alignment=~"1~" tabsequence=32766 border=~"0~" color=~"33554432~" x=~"8020~"  y=~"7~" height=~"53~" width=~"480~" format=~"[general]~" html.valueishtml=~"0~"  name=zaiko_su_1 visible=~"1~" edit.limit=0 edit.case=any edit.focusrectangle=no edit.autoselect=yes edit.autohscroll=yes edit.imemode=0  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )", &
	"column(band=detail id=110 alignment=~"1~" tabsequence=32766 border=~"0~" color=~"33554432~" x=~"8512~"  y=~"7~" height=~"53~" width=~"480~" format=~"[general]~" html.valueishtml=~"0~"  name=zaiko_su_2 visible=~"1~" edit.limit=0 edit.case=any edit.focusrectangle=no edit.autoselect=yes edit.autohscroll=yes edit.imemode=0  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )", &
	"column(band=detail id=110 alignment=~"1~" tabsequence=32766 border=~"0~" color=~"33554432~" x=~"8512~"  y=~"7~" height=~"53~" width=~"480~" format=~"[general]~" html.valueishtml=~"0~"  name=zaiko_su_16 visible=~"1~" edit.limit=0 edit.case=any edit.focusrectangle=no edit.autoselect=yes edit.autohscroll=yes edit.imemode=0  font.face=~"MS UI Gothic~" font.height=~"-9~" font.weight=~"400~"  font.family=~"3~" font.pitch=~"2~" font.charset=~"128~" background.mode=~"1~" background.color=~"536870912~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )" &
}

l_test2	= { &
	" size_iti_1,size_iti_2,size_iti_3,size_iti_16", &
	"       max( decode( size_iti,  1, size_iti, 0 ) ) size_iti_1,", &
	"       max( decode( size_iti,  2, size_iti, 0 ) ) size_iti_2,", &
	"       max( decode( size_iti, 16, size_iti, 0 ) ) size_iti_16," &
}


string	l_find[]	= { "size_iti_", "zaiko_su_" }
integer	l_iti[]		= { 1, 2 }

string	l_text
integer	l_row, l_col
integer	l_spos,l_len
integer	l_no,l_cnt

l_len=2

// SQL以外の部分
for l_row = 1 to upperbound( l_test )
		l_text	= l_test[l_row]
		if isexists( l_text, l_find, l_col ) then
			l_spos	= pos( l_text, l_find[l_col] ) + len( l_find[l_col] )
			l_no	= long( fnc.strg.of_replace( trim( mid( l_text, l_spos, l_len ) ), "_", "" ) )
			
			if isexists( l_no, l_iti, l_col ) then
				l_ans[upperbound(l_ans)+1]	= l_test[l_row]
				l_cnt	= l_cnt + 1
			end if
		else
			l_ans[upperbound(l_ans)+1]	= l_test[l_row]
		end if
next

// SQLの部分
string	l_new
for l_row = 1 to upperbound( l_test2 )
	l_text	= l_test2[l_row]
		
	// l_findの文字に合致する行かチェック
	if isexists( l_text, l_find, l_col ) then
		l_spos	= pos( l_text, l_find[l_col] ) + len( l_find[l_col] )
		l_no	= long( fnc.strg.of_replace( trim( mid( l_text, l_spos, l_len ) ), "_", "" ) )
			
		// サイズ位置にあたるものが存在するかチェック
		if isexists( l_no, l_iti, l_col ) then
			// 一つでも合致したなら複数パターンで合致するかチェックして複数ヒットするなら対象項目のみ抽出する
			l_new	= sql_cleansing( l_text, l_find, l_iti )
			//l_ans2[upperbound(l_ans)+1]	= l_test2[l_row]
			l_ans2[upperbound(l_ans2)+1]	= l_new
			l_cnt	= l_cnt + 1
		end if
	else
		l_ans2[upperbound(l_ans2)+1]	= l_test2[l_row]
	end if
next

l_len=2

end subroutine

private function boolean isexists (integer p_value, integer p_chklists[], ref integer p_col);
integer	l_row

for l_row = 1 to upperbound( p_chklists )
	if p_chklists[l_row] = p_value then
		p_col	= l_row

		return true
	end if
next

p_col	= 0

return false

end function

private function boolean isexists (string p_value, string p_chklists[], ref integer p_col);
integer	l_row

for l_row = 1 to upperbound( p_chklists )
	if pos( p_value, p_chklists[l_row] ) > 0 then
		p_col	= l_row

		return true 
	end if
next

p_col	= 0

return false

end function

private function string sql_cleansing (string p_value, string p_chkcols[], integer p_chknos[]);
integer	l_row,l_row1,l_row2
integer	l_cnt,l_cnt2
string	l_pattern[]
string	l_cols[],l_new[]
string	l_ret

integer	l_kcnt
integer	l_spos,l_len

// 区切りとなるカンマで配列へセット
l_spos	= 1
for l_cnt = l_spos to len( p_value )
	for l_cnt2 = 0 to len( p_value )
		choose case mid( p_value, l_cnt+l_cnt2, 1 )
			case "("
				l_kcnt	= l_kcnt + 1
			case ")"
				l_kcnt	= l_kcnt - 1
			case ","
				if l_kcnt = 0 then
					l_len	= l_cnt2
					exit
				end if
			case else
		end choose 
	next

	l_cols[upperbound(l_cols)+1]	= mid( p_value,l_spos, l_len + 1 )
	l_cnt	= l_cnt + l_len
	l_spos	= l_cnt + 1
next

// パターン生成
for l_row1 = 1 to upperbound( p_chkcols )
	for l_row2 = 1 to upperbound( p_chknos )
		l_pattern[upperbound( l_pattern )+1]	= p_chkcols[l_row1] + string( p_chknos[l_row2] )
		l_pattern[upperbound( l_pattern )+1]	= p_chkcols[l_row1] + string( p_chknos[l_row2], "00" )
	next
next

// 対象抽出
string	l_inspect
for l_row1 = 1 to upperbound( l_cols )
	l_inspect	= trim( l_cols[l_row1] )
	if lastpos( l_inspect, "," ) = len( l_inspect ) then
		l_inspect	= trim( left( l_inspect, len( l_inspect ) - 1 ) )
	end if

	for l_row2 = 1 to upperbound( l_pattern )
		if lastpos( l_inspect, l_pattern[l_row2] ) > 0 and len( mid( l_inspect, lastpos( l_inspect, l_pattern[l_row2] ) ) ) = len( l_pattern[l_row2] ) then
			l_new[upperbound(l_new)+1]	= l_cols[l_row1]
			exit
		end if
	next
next

l_ret	= fnc.strg.of_join( l_new, "" )

// 元の文字列の最後にカンマがあるか確認して成型後の文字の最後にカンマがなければ追加する
if right( p_value, 1 ) = "," then
	if right( l_ret, 1 ) <> "," then
		l_ret	= l_ret	+ ","
	end if
else
	if right( l_ret, 1 ) = "," then
		l_ret	= left( l_ret, len( l_ret ) - 1 )
	end if
end if

return l_ret

end function

public subroutine of_init (string p_dataobject, string p_finds[]);
dataobject				= p_dataobject

i_head_ds.dataobject	= dataobject
i_body_ds.dataobject	= dataobject
//i_body_dw.dataobject	= dataobject

// 可変にするカラム文字列（共通部）
target				= p_finds

// DWソースを取得
syntaxsql				= i_head_ds.object.datawindow.syntax
end subroutine

private function boolean regenerate (string p_before_syntaxs[], integer p_target_no[], boolean p_sql, ref string p_after_syntax[]);
string	l_text
integer	l_row, l_col
integer	l_spos
integer	l_no,l_cnt

string	l_ans[]

constant integer	l_len	= 2

if not p_sql then
	for l_row = 1 to upperbound( p_before_syntaxs )
			l_text	= p_before_syntaxs[l_row]
			if isexists( l_text, target, l_col ) then
				l_spos	= pos( l_text, target[l_col] ) + len( target[l_col] )
				l_no	= long( fnc.strg.of_replace( trim( mid( l_text, l_spos, l_len ) ), "_", "" ) )
				
				if isexists( l_no, p_target_no, l_col ) then
					p_after_syntax[upperbound(p_after_syntax)+1]	= p_before_syntaxs[l_row]
					l_cnt	= l_cnt + 1
				end if
			else
				p_after_syntax[upperbound(p_after_syntax)+1]	= p_before_syntaxs[l_row]
			end if
	next
else
	string	l_new

	for l_row = 1 to upperbound( p_before_syntaxs )
		l_text	= p_before_syntaxs[l_row]
			
		// l_findの文字に合致する行かチェック
		if isexists( l_text, target, l_col ) then
			l_spos	= pos( l_text, target[l_col] ) + len( target[l_col] )
			l_no	= long( fnc.strg.of_replace( trim( mid( l_text, l_spos, l_len ) ), "_", "" ) )
				
			// サイズ位置にあたるものが存在するかチェック
			if isexists( l_no, p_target_no, l_col ) then
				// 一つでも合致したなら複数パターンで合致するかチェックして複数ヒットするなら対象項目のみ抽出する
				l_new	= sql_cleansing( l_text, target, p_target_no )
				p_after_syntax[upperbound(p_after_syntax)+1]	= l_new
				l_cnt	= l_cnt + 1
			end if
		else
			p_after_syntax[upperbound(p_after_syntax)+1]	= p_before_syntaxs[l_row]
		end if
	next
end if

return true
end function

private function boolean get_zaiko (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt);
integer	l_size_iti[]

// サイズ位置情報を取得する
if not get_available_size( p_syohin_code, p_iro_ban, l_size_iti ) then
	return false
end if

p_column_cnt	= upperbound( l_size_iti )

custom_syntaxsql	= create_cusrom_syntax( syntaxsql, l_size_iti )

return true

end function

public function inv_datastore of_get_ds (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt);
integer	l_cnt

get_zaiko( p_syohin_code, p_iro_ban, l_cnt )

p_column_cnt	= l_cnt

return i_body_ds
end function

public function string of_get_custom_syntax (long p_syohin_code, long p_iro_ban, ref integer p_column_cnt);
integer	l_cnt

get_zaiko( p_syohin_code, p_iro_ban, l_cnt )

p_column_cnt	= l_cnt

return custom_syntaxsql
end function

private subroutine recolumnid (string p_cols[], ref string p_body_cols[]);
// カラムのIDで並び替えと番号振りなおし
integer	l_row, l_cnt
string	l_text, l_text1, l_text2
string	l_dmy_cols[], l_new_cols[]

integer	l_value

integer	l_spos, l_epos, l_bspos, l_bepos
string	l_word

constant string	c_starget	= " name="
constant string	c_etarget	= " "

constant string	c_bstarget	= " id="
constant string	c_betarget	= " "

for l_row = 1 to upperbound( p_cols )
	l_spos	= pos( p_cols[l_row], c_starget ) + 1
	l_epos	= pos( p_cols[l_row], c_etarget, l_spos + len( c_starget ) )
	l_word	= mid( p_cols[l_row], l_spos, l_epos - l_spos )
	
	for l_cnt = 1 to upperbound( p_body_cols )
		if left( p_body_cols[l_cnt], 6 ) = "column" then
			if pos( p_body_cols[l_cnt], l_word ) > 0 then
				l_bspos	= pos( p_body_cols[l_cnt], c_bstarget ) - 1
				l_bepos	= pos( p_body_cols[l_cnt], c_betarget,  l_bspos + len( c_bstarget ) ) + 1
				
				l_text1	= left( p_body_cols[l_cnt], l_bspos )
				l_text2	= mid( p_body_cols[l_cnt], l_bepos )
				
				p_body_cols[l_cnt]	= l_text1 + c_bstarget + string( l_row ) + c_betarget + l_text2
			end if
		end if
	next
next


/*
constant string	c_bstarget	= " id="
constant string	c_betarget	= " "

for l_row = 1 to upperbound( p_cols )
	l_text	= p_cols[l_row]

	l_spos	= pos( l_text, c_starget ) + len( c_starget )
	l_epos	= pos( l_text, c_etarget, l_spos )

	l_value	= long( mid( l_text, l_spos, l_epos - l_spos ) )
		
	l_dmy_cols[l_value]	= l_text
next

l_cnt	= 1
for l_row = 1 to upperbound( l_dmy_cols )
	if len( l_dmy_cols[l_row] ) > 0 then
		l_spos	= pos( l_dmy_cols[l_row], c_starget ) - 1
		l_epos	= pos( l_dmy_cols[l_row], c_etarget,  l_spos + len( c_starget ) ) + 1
		
		l_text1	= left( l_dmy_cols[l_row], l_spos )
		l_text2	= mid( l_dmy_cols[l_row], l_epos )
		
		l_new_cols[upperbound(l_new_cols)+1]	= l_text1 + c_starget + string( l_cnt ) + c_etarget + l_text2
		l_cnt	= l_cnt + 1
	end if
next

p_body_cols	= l_new_cols

*/

end subroutine

on nv_variable_column.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_variable_column.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
i_head_ds	= create inv_datastore
i_body_ds	= create inv_datastore
i_body_dw	= create ivo_datawindow

end event

event destructor;
destroy inv_datastore
destroy inv_datastore

end event

