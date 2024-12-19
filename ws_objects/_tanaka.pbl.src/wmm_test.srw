$PBExportHeader$wmm_test.srw
forward
global type wmm_test from iw_main_window
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_test
end type
type st_syori_kbn from ivo_statictext within wmm_test
end type
type st_atesaki_kbn from ivo_statictext within wmm_test
end type
type uo_tokui from cv_input_tokui within wmm_test
end type
type ddplb_atesaki_kbn from sv_ddplb_meisyo within wmm_test
end type
end forward

global type wmm_test from iw_main_window
string title = "得意先宛先登録"
ddplb_syori_kbn ddplb_syori_kbn
st_syori_kbn st_syori_kbn
st_atesaki_kbn st_atesaki_kbn
uo_tokui uo_tokui
ddplb_atesaki_kbn ddplb_atesaki_kbn
end type
global wmm_test wmm_test

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
//	long	i_tokuisaki_kbn
	long    i_atesaki_kbn
	long	i_tokuisaki_code
 
	
	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時
	
	// 文字列分割用
	string string1
	string string2
	string string3
	string string4
	
	
	
public:
	boolean	visible_touroku	= true
	
	
protected:
	string	init_disp
end variables

forward prototypes
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
public subroutine of_dsp_back ()
public subroutine of_dsp_reset ()
public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock)
public function boolean of_record_lock (long p_tokui_atesaki_code, long p_atesaki_kbn, boolean p_lock)
public function boolean of_cnv_string (string p_string)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		uo_tokui.enabled	= p_enabled
		ddplb_atesaki_kbn.enabled= p_enabled
		cb_retrieve.enabled		= p_enabled
		

end choose

end subroutine

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 参照設定
str_mdlpara_myubin	l_mdl_yubin

// 照会はF8使用不可
if i_syori_kbn = "照会" then
	return
end if

// F8:参照
choose case p_dwo.name
	case "b_yubin"
		// 郵便番号
		l_mdl_yubin	= mdl.of_open_modal( "wsm_yubin", l_mdl_yubin )
		if upperbound( l_mdl_yubin.ret ) > 0 then
//			p_dw.object.yubin[p_row]	= l_mdl_yubin.ret[1].nendo_code
			p_dw.object.yubin_no[p_row]	= l_mdl_yubin.ret[1].yubin_no
		end if
		
end choose
end subroutine

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn
string	l_atesaki_kbn

l_syori_kbn = ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）

ddplb_syori_kbn.event constructor( )
uo_tokui.event constructor( )
ddplb_atesaki_kbn.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn
ddplb_atesaki_kbn.text    = l_atesaki_kbn

of_dsp_edit( "callsection", true )

of_set_secondfocus( )

end subroutine

public function boolean of_record_lock_rowid (string p_rowid, boolean p_lock);
integer	l_haita_flg

if p_lock then
	l_haita_flg	= 1
else
	l_haita_flg	= 0
end if

update m_tokui_atesaki
   set haita_flg			= :l_haita_flg,
       kousin_date			= sysdate,
       kousin_user_id		= :user.user_id,
       kousin_client_id		= :device.name,
       kousin_pg_id			= :i_pg_id
 where rowid				= :p_rowid
using cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	msg.of_error_db( "得意先宛先登録マスタのレコードロックでエラーが発生しました。", cocos )
	return false
else
	commit using cocos;
	uo_signal.of_on_signal( p_lock )
end if

return true
end function

public function boolean of_record_lock (long p_tokui_atesaki_code, long p_atesaki_kbn, boolean p_lock);
string	l_rowid
string	l_henkou_date, l_henkou_user_id, l_henkou_client_id, l_henkou_pg_id
string	l_user_mei,l_window_mei
integer	l_haita_flg

select mm.rowid,mm.haita_flg,
       nvl( to_char( mm.henkou_date, 'yyyy/mm/dd hh24:mi:ss' ), '????/??/?? ??:??:??' ),
       nvl( mm.henkou_user_id, '???' ),
       nvl( mu.user_mei, '???' ),
       nvl( mm.henkou_client_id, '???' ),
       nvl( mm.henkou_pg_id, '???' ),
       nvl( mw.window_name, '???' )
  into :l_rowid,:l_haita_flg,
       :l_henkou_date,
       :l_henkou_user_id,:l_user_mei,
       :l_henkou_client_id,
       :l_henkou_pg_id,:l_window_mei
  from m_tokui_atesaki mm,
       m_user mu,
       m_window mw
	 where mm.henkou_user_id= mu.user_id(+)
	   and mm.henkou_pg_id	= mw.window_id(+)
	   and mm.tokui_code	= :p_tokui_atesaki_code
	   and mm.atesaki_kbn	= :p_atesaki_kbn
   for update
using cocos;

choose case cocos.sqlcode
	case 0
		if l_henkou_user_id <> user.user_id then
			if l_haita_flg <> 0 then
				rollback using cocos;
				msg.of_error( fnc.strg.of_format( "他の端末で編集中です。{1}{2}{1}{3}{1}{4}～", code.crlf, l_user_mei, l_window_mei, l_henkou_date ) )
				return false
			end if
		end if

		// commitはこっちで行う
		return of_record_lock_rowid( l_rowid, p_lock )
	case 100
		rollback using cocos;
		msg.of_error( "対象レコードが存在しません。" )
	case else
		rollback using cocos;
		msg.of_error_db( "レコードロックでエラーが発生しました。", cocos )
		return false
end choose

return true

end function

public function boolean of_cnv_string (string p_string);// -----------------------------------------------------
//	文字列分割（指定バイト数で）
//
//	名称	:	of_cnv_string
//
//	引数	:	as_string	文字列
//				as_string1	文字列1
//				as_string2	文字列2
//
//	戻り値	:	boolean
// ----------------------------------------------------

long	ll_cnt
long	ll_len
long	ll_idx
string	ls_str
int al_maxlength

al_maxlength=40

string1 = ""
string2 = ""
string3 = ""
string4 = ""

IF IsNull( p_string ) OR p_string = "" THEN
	RETURN false
END IF

ll_len = len( p_string )

ll_idx = 1
ls_str = ""

FOR ll_cnt = 1 TO ll_len
	IF LenA( ls_str + mid( p_string, ll_cnt, 1 )) <= al_maxlength THEN
		IF ll_idx = 1 THEN
			string1 = ls_str + mid( p_string, ll_cnt, 1 )
		ELSEIF ll_idx = 2 THEN
			string2 = ls_str + mid( p_string, ll_cnt, 1 )
		ELSEIF ll_idx = 3 THEN
			string3 = ls_str + mid( p_string, ll_cnt, 1 )
		ELSEIF ll_idx = 4 THEN
			string4 = ls_str + mid( p_string, ll_cnt, 1 )
		END IF
	ELSE
		ll_idx++
		IF ll_idx > 4 THEN
			EXIT
		END IF
		ls_str = ""
	END IF
	ls_str = ls_str + mid( p_string, ll_cnt, 1 )
NEXT


RETURN true
end function

on wmm_test.create
int iCurrent
call super::create
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.st_syori_kbn=create st_syori_kbn
this.st_atesaki_kbn=create st_atesaki_kbn
this.uo_tokui=create uo_tokui
this.ddplb_atesaki_kbn=create ddplb_atesaki_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori_kbn
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.st_atesaki_kbn
this.Control[iCurrent+4]=this.uo_tokui
this.Control[iCurrent+5]=this.ddplb_atesaki_kbn
end on

on wmm_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori_kbn)
destroy(this.st_syori_kbn)
destroy(this.st_atesaki_kbn)
destroy(this.uo_tokui)
destroy(this.ddplb_atesaki_kbn)
end on

event retrieve_check;call super::retrieve_check;int l_syusoku_flg
string l_code


// リトリーブ前の事前チェック
// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

l_code		= string( uo_tokui.of_get_input( ) )

//if not ddplb_atesaki_kbn.event input_check( ) then
//	return -1
//end if


// 新規登録の場合
//if i_syori_kbn = "登録" then
//	
//	ddplb_atesaki_kbn.event constructor( )
//
//else
//	if not ddplb_atesaki_kbn.event input_check( ) then
//		return -1
//	end if
//	
//end if

/*

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_tokuisaki_code	= long( sle_tokuisaki_code.text )



// 存在チェック
select count('x')
into :l_syusoku_flg
from m_tokui
where tokui_code	= to_number( :i_tokuisaki_code )
and syusoku_flg    = 1
using cocos;
	
	

// 照会以外は終息の得意先コードは実行不可
if i_syori_kbn <> "照会" and l_syusoku_flg <> 0 then
	msg.of_error("終息の得意先では処理区分は照会以外を選択できません。" )
	this.setfocus()
	return -1
end if


*/

end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event key_f09;call super::key_f09;
// 初期表示
if msg.of_question( "入力された内容を取り消して初期状態に戻しますか？" ) then
	of_dsp_reset()
end if

return 0
end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event key_f06;call super::key_f06;
// 戻り
of_dsp_back()

return 0
end event

type uo_signal from iw_main_window`uo_signal within wmm_test
end type

type st_date from iw_main_window`st_date within wmm_test
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_test
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_test
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_test
end type

type st_title from iw_main_window`st_title within wmm_test
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_test
end type

type st_upper from iw_main_window`st_upper within wmm_test
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_test
integer y = 132
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_test
integer taborder = 40
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_test
integer x = 380
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.event selectionchanged( i_idx )

//setnull( i_syori_kbn )


end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )



// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
//		uo_tokui_tanto.of_set_dbchk_dupe( )
		uo_tokui.of_set_dbchk_exst( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_tokui.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose

end event

type st_syori_kbn from ivo_statictext within wmm_test
integer x = 32
integer y = 167
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type st_atesaki_kbn from ivo_statictext within wmm_test
integer x = 2372
integer y = 263
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "送付物"
alignment alignment = right!
end type

type uo_tokui from cv_input_tokui within wmm_test
string tag = "得意先"
integer x = 64
integer y = 256
integer taborder = 20
boolean bringtotop = true
end type

event sle_input_check;call super::sle_input_check;

string	l_code
string	l_hin_ban
string	l_hin_mei
long	l_syusoku_flg
long	l_cnt

//l_code		= trim( sle_syohin_code.text )
l_code		=string( uo_tokui.of_get_input( ) )

i_syori_kbn	= ddplb_syori_kbn.text
//
//// 必須チェック
//if len( l_code ) = 0 then
////	msg.of_error( this, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ) )
//	this.setfocus()
//	return false
//end if

// 必須チェック
if len( l_code ) = 0 then
	msg.of_error(fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ))
	this.setfocus()
	return false
end if

/*
//

string	l_code
integer	l_syusoku_flg
string	l_input
string	l_colnm
string	l_tableid	= "m_ryutu_kako"
string	l_msg

l_code	= trim( of_get_input( ) )
//l_code		= string( uo_tokui_tanto.text )

// 存在チェック
select syusoku_flg
  into :l_syusoku_flg
  from m_tokui
 where tokui_code	= to_number( :l_code )
using cocos;

messagebox("test",string(l_syusoku_flg))
choose case cocos.sqlcode
	case 0
		if l_syusoku_flg=1 then
			//msg.of_error_sle( this, fnc.strg.of_format( "選択している得意先は終息しているため、この処理は実行できません。", "" ) )
			msg.of_error( "選択している得意先は終息しているため、この処理は実行できません。")

			this.setfocus()
			return false
		end if
	case 100
		msg.of_error( fnc.strg.of_format( "入力チェックでエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		this.setfocus()
		return false
	case else
//		msg.of_error_sle( this, fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
			msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )

		this.setfocus()
		return false
end choose
*/
// 存在チェック
select count('x')
into :l_syusoku_flg
from m_tokui
where tokui_code	= to_number( :l_code )
and syusoku_flg    = 1
using cocos;
	
		
// 終息の得意先コードの場合
//if l_syusoku_flg <> 0 then
////	st_syusoku.visible	= true
//end if

// 存在チェック
select count('x')
into :l_syusoku_flg
from m_tokui
where tokui_code	= to_number( :l_code  )
and syusoku_flg    = 1
using cocos;
	


// 照会以外は終息の得意先コードは実行不可
if i_syori_kbn <> "照会" and l_syusoku_flg <> 0 then
	msg.of_error("終息の得意先では処理区分は照会以外を選択できません。" )
	this.setfocus()
	return false
end if





return true


end event

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

type ddplb_atesaki_kbn from sv_ddplb_meisyo within wmm_test
string tag = "送付物"
integer x = 2636
integer y = 256
integer width = 348
integer taborder = 20
boolean bringtotop = true
integer meisyo_kbn = 147
integer meisyo_no = 1
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_atesaki_kbn )
end event

