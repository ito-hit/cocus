$PBExportHeader$wmm_tokui_atesaki.srw
forward
global type wmm_tokui_atesaki from iw_main_window
end type
type dw_entry from ivo_datawindow within wmm_tokui_atesaki
end type
type st_syori_kbn from ivo_statictext within wmm_tokui_atesaki
end type
type st_atesaki_kbn from ivo_statictext within wmm_tokui_atesaki
end type
type uo_tokui from cv_input_tokui within wmm_tokui_atesaki
end type
type ddplb_atesaki_kbn from sv_ddplb_meisyo within wmm_tokui_atesaki
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_tokui_atesaki
end type
end forward

global type wmm_tokui_atesaki from iw_main_window
string title = "得意先宛先登録"
dw_entry dw_entry
st_syori_kbn st_syori_kbn
st_atesaki_kbn st_atesaki_kbn
uo_tokui uo_tokui
ddplb_atesaki_kbn ddplb_atesaki_kbn
ddplb_syori_kbn ddplb_syori_kbn
end type
global wmm_tokui_atesaki wmm_tokui_atesaki

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
//	long	i_tokuisaki_kbn
	integer i_atesaki_kbn
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
public function boolean of_cnv_string (string p_string)
public function boolean of_record_lock (boolean p_lock)
end prototypes

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
	//	uo_tokui.enabled	= p_enabled
		uo_tokui.of_set_enabled( p_enabled )
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
dw_entry.event constructor( )
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn
string	l_atesaki_kbn

l_syori_kbn = ddplb_syori_kbn.text
l_atesaki_kbn = ddplb_atesaki_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_entry.event constructor( )
ddplb_syori_kbn.event constructor( )
uo_tokui.event constructor( )
ddplb_atesaki_kbn.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn
ddplb_atesaki_kbn.text    = l_atesaki_kbn
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

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

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_tokui_atesaki_lock( i_pg_id, i_tokuisaki_code, i_atesaki_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_tokui_atesaki_unlock( i_pg_id, i_tokuisaki_code, i_atesaki_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true
end function

on wmm_tokui_atesaki.create
int iCurrent
call super::create
this.dw_entry=create dw_entry
this.st_syori_kbn=create st_syori_kbn
this.st_atesaki_kbn=create st_atesaki_kbn
this.uo_tokui=create uo_tokui
this.ddplb_atesaki_kbn=create ddplb_atesaki_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_entry
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.st_atesaki_kbn
this.Control[iCurrent+4]=this.uo_tokui
this.Control[iCurrent+5]=this.ddplb_atesaki_kbn
this.Control[iCurrent+6]=this.ddplb_syori_kbn
end on

on wmm_tokui_atesaki.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_entry)
destroy(this.st_syori_kbn)
destroy(this.st_atesaki_kbn)
destroy(this.uo_tokui)
destroy(this.ddplb_atesaki_kbn)
destroy(this.ddplb_syori_kbn)
end on

event retrieve_check;call super::retrieve_check;int l_syusoku_flg
string l_code


// リトリーブ前の事前チェック
// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

// 入力チェック
if not ddplb_atesaki_kbn.event input_check() then
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

event retrieve_event;call super::retrieve_event;

long	l_atesaki_kbn
string  l_atesaki_kbn_mei
long    l_tokuisaki
string  l_tokuisaki_mei_full
string  l_jyusyo
string  l_yubin_no
integer	l_cnt


// 存在チェック

select meisyo_code
	  into :l_atesaki_kbn
	  from m_meisyo
	 where meisyo_1	= :ddplb_atesaki_kbn.text
	 and meisyo_kbn=147
	using cocos;

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= ddplb_syori_kbn.text
i_tokuisaki_code	= long( uo_tokui.of_get_input( ) )
i_atesaki_kbn       = long(ddplb_atesaki_kbn.of_get_code_num( ))


l_tokuisaki_mei_full	= uo_tokui.i_para_tokui[1].tokui_mei	// uo_tokuiの得意先名を取得
l_atesaki_kbn_mei =ddplb_atesaki_kbn.text

choose case i_syori_kbn
	case "登録"

		// 存在チェック
		select count('x')
  		into :l_cnt
  		from m_tokui_atesaki
 		where tokui_code	= :i_tokuisaki_code
    	and atesaki_kbn	= :i_atesaki_kbn
		using cocos;

		if l_cnt <> 0 then
			msg.of_error(fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。{1}【登録済の得意先コード】{2}：{3}{4}【登録済の送付物】{5}：{6}",  code.crlf,string(i_tokuisaki_code),l_tokuisaki_mei_full, code.crlf,string(l_atesaki_kbn),l_atesaki_kbn_mei))
			this.setfocus()
			return -1
		end if
/*		
		if l_cnt <> 0 then
			msg.of_error(fnc.strg.of_format( "登録しようとしているコードはすでに登録があります。登録済の得意先コード：{1}",  string(sle_tokuisaki_code.text) ))
			this.setfocus()
			return -1
		end if
		
		// 存在チェック
		select count('x')
  		into :l_cnt
  		from m_tokui
 		where tokui_code	= :i_tokuisaki_code
		using cocos;
		
		if l_cnt = 0 then
			msg.of_error(fnc.strg.of_format( "登録しようとしているコードは得意先マスタに登録されていません。未登録の得意先コード：{1}",  string(sle_tokuisaki_code.text) ))
			this.setfocus()
			return -1
		end if
		*/

		dw_entry.insertrow(0)

		select tokui_mei_full,yubin_no,jyusyo
		into :l_tokuisaki_mei_full, :l_yubin_no,:l_jyusyo
		from m_tokui
		where tokui_code      = :i_tokuisaki_code
		using cocos;

		dw_entry.object.tokui_mei_full[1]	= l_tokuisaki_mei_full
		dw_entry.object.yubin_no_std[1]		= l_yubin_no
		dw_entry.object.jyusyo[1]			= l_jyusyo

		
	case "変更", "削除"
		// 排他処理
		if not of_record_lock( true ) then
			return -1
		end if
		
		if dw_entry.retrieve( i_tokuisaki_code,i_atesaki_kbn ) = 0 then
			msg.of_error( "入力した得意先コード、送付物で登録されたデータはありません。" )
			uo_tokui.setfocus()
			return -1
		end if

	case "照会"
		if dw_entry.retrieve( i_tokuisaki_code,i_atesaki_kbn ) = 0 then
			msg.of_error( "入力した得意先コード、送付物で登録されたデータはありません。" )
			uo_tokui.setfocus()
			return -1
		end if

end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

dw_entry.object.atesaki_tokui_code[1]  = i_tokuisaki_code
dw_entry.object.atesaki_kbn[1] = i_atesaki_kbn

setredraw( true )
dw_entry.setfocus()

end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event update_check;call super::update_check;
long	l_row
long	l_cnt

// DWの入力規則チェック
if dw_entry.accepttext() <> 1 then
	return -1
end if

l_row	= long( dw_entry.object.datawindow.firstrowonpage )

if dw_entry.event itemchanged( l_row, dw_entry.object.yubin_no, string( dw_entry.object.yubin_no[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo1, string( dw_entry.object.jyusyo1[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo2, string( dw_entry.object.jyusyo2[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo3, string( dw_entry.object.jyusyo3[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.jyusyo4, string( dw_entry.object.jyusyo4[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.atena1, string( dw_entry.object.atena1[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.atena2, string( dw_entry.object.atena2[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.atena3, string( dw_entry.object.atena3[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.atena4, string( dw_entry.object.atena4[l_row] ) ) <> 0 then
	return -1
end if

if dw_entry.event itemchanged( l_row, dw_entry.object.note, string( dw_entry.object.note[l_row] ) ) <> 0 then
	return -1
end if


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

event update_event;call super::update_event;
long		l_row
long		l_count


choose case i_syori_kbn
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_entry.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "得意先宛先登録マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if

		// ログ出力( イベントID, エラーコード, メッセージ )
		of_add_db_log( "update_event", 0, st_title.text + "[得意先=" + string( uo_tokui.of_get_tokui_code( ) ) + " " + trim(uo_tokui.of_get_tokui_mei( ))+ " 送付物="+ ddplb_atesaki_kbn.text+"]" + i_syori_kbn )

end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 結果を明細部に再読み込み
of_dsp_back()

end event

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

dw_entry.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_entry.x			= code.MGN_YOKO
dw_entry.width		= l_width - code.MGN_YOKO * 2
dw_entry.height		= key_fnc.y - code.MGN_TATE - dw_entry.y


// DWの登録日時と変更日時

dw_entry.object.henkou_date.x = dw_entry.width -long( dw_entry.object.henkou_date.width ) - 40
dw_entry.object.henkou_date_t.x = long( dw_entry.object.henkou_date.x ) -long( dw_entry.object.henkou_date_t.width ) - 20

dw_entry.object.touroku_date.x = long( dw_entry.object.henkou_date_t.x ) -long( dw_entry.object.touroku_date.width ) - 40
dw_entry.object.touroku_date_t.x = long( dw_entry.object.touroku_date.x ) -long( dw_entry.object.touroku_date_t.width ) - 20

end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_entry.event constructor( )
end if
end event

type uo_signal from iw_main_window`uo_signal within wmm_tokui_atesaki
end type

type st_date from iw_main_window`st_date within wmm_tokui_atesaki
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_tokui_atesaki
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_tokui_atesaki
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_tokui_atesaki
end type

type st_title from iw_main_window`st_title within wmm_tokui_atesaki
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_tokui_atesaki
end type

type st_upper from iw_main_window`st_upper within wmm_tokui_atesaki
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_tokui_atesaki
integer y = 132
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_tokui_atesaki
integer taborder = 40
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type dw_entry from ivo_datawindow within wmm_tokui_atesaki
integer x = 36
integer y = 380
integer width = 4360
integer height = 1860
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_tokui_atesaki"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
long			l_row
string l_rowid

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	l_rowid		= trim( this.object.rowid[l_row] )
	choose case i_syori_kbn
		case "変更", "削除"
			// ロック解除
			of_record_lock( false )
			// ロック解除
//			of_record_lock( i_tokuisaki_code, i_atesaki_kbn, false )
	end choose
end if

this.i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

this.reset()
this.insertrow(0)
this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		if this.rowcount() > 0 then
			this.of_set_fnkey( keyf12!, true )
			return
		end if
end choose

this.of_set_fnkey( keyf12!, false )

end event

event itemfocuschanged;call super::itemfocuschanged;
// F8:参照の有効/無効設定

choose case dwo.name
	case "nayose_code"
		// 参照可能
		this.of_set_fnkey( keyf8!, true )
		
	case else
		// 参照不可
		this.of_set_fnkey( keyf8!, false )

end choose
end event

event clicked;call super::clicked;// F8:参照
choose case dwo.name
	case "cb_copy"

		this.object.yubin_no[row]=	this.object.yubin_no_std[row]

		if of_cnv_string(this.object.jyusyo[row])=true then
			this.object.jyusyo1[row]=string1
			this.object.jyusyo2[row]=string2
			this.object.jyusyo3[row]=string3
			this.object.jyusyo4[row]=string4
			
		else
				msg.of_error( "複写でエラーが発生しました。" )
				return 0
		end if

		if of_cnv_string(this.object.tokui_mei_full[row])=true then
			this.object.atena1[row]=string1
			this.object.atena2[row]=string2
			this.object.atena3[row]=string3
			this.object.atena4[row]=string4
			
		else
				msg.of_error( "複写でエラーが発生しました。" )
				return 0
		end if


end choose
end event

event itemchanged;call super::itemchanged;string	l_input
string	l_colnm
string	l_tableid	= "m_tokui_atesaki"
string	l_msg

// 桁数チェック
choose case dwo.name
	case "yubin_no", "jyusyo1", "atena1"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		
	case "jyusyo2", "jyusyo3", "jyusyo4", "atena2", "atena3", "atena4","note"
		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		if not fnc.of_chk_column_info( l_input, true, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

return 0
end event

event buttonclicked;call super::buttonclicked;
// F8:参照
choose case dwo.name
	case "b_yubin"
		// 参照起動
		of_reference( this, dwo, row )
		
end choose
end event

event key_f08;call super::key_f08;
// F8:参照
choose case this.getcolumnname()
//choose case i_colname
	case "b_yubin"
		// 郵便番号
		of_reference( this, this.object.yubin_no, this.getrow() )
		
end choose


return 0
end event

type st_syori_kbn from ivo_statictext within wmm_tokui_atesaki
integer x = 32
integer y = 167
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type st_atesaki_kbn from ivo_statictext within wmm_tokui_atesaki
integer x = 2372
integer y = 263
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "送付物"
alignment alignment = right!
end type

type uo_tokui from cv_input_tokui within wmm_tokui_atesaki
string tag = "得意先"
integer x = 64
integer y = 256
integer taborder = 20
boolean bringtotop = true
end type

event sle_input_check;call super::sle_input_check;

string	l_code
string  l_tokui_mei_full
string	l_hin_ban
string	l_hin_mei
long	l_syusoku_flg
long	l_cnt

//l_code		= trim( sle_syohin_code.text )
l_code		= string( uo_tokui.of_get_input( ) )

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
select tokui_mei_full
into :l_tokui_mei_full
from m_tokui
where tokui_code	= to_number( :l_code )
and syusoku_flg    = 0
using cocos;
	
choose case cocos.sqlcode
	case 0
		this.st_meisyo.text= l_tokui_mei_full
	case 100
		msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", this.tag ) )
		return false
	case else
		msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", this.tag, code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		return false
end choose


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

event constructor;call super::constructor;
uo_tokui.of_set_enabled(true)
end event

type ddplb_atesaki_kbn from sv_ddplb_meisyo within wmm_tokui_atesaki
string tag = "送付物"
integer x = 2636
integer y = 256
integer width = 348
integer taborder = 30
boolean bringtotop = true
integer meisyo_kbn = 147
integer meisyo_no = 1
boolean enabled_null = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_atesaki_kbn )
end event

event input_check;call super::input_check;

string	l_code
string	l_hin_ban
string	l_hin_mei
string	l_syusoku_flg
long	l_cnt
string  l_atesaki_kbn


l_atesaki_kbn	= ddplb_atesaki_kbn.text
//
//// 必須チェック
//if len( l_code ) = 0 then
////	msg.of_error( this, fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ) )
//	this.setfocus()
//	return false
//end if

// 必須チェック
if len( l_atesaki_kbn ) = 0 then
	msg.of_error(fnc.strg.of_format( "必須入力項目に値が設定されていません。 [ {1} ]", this.tag ))
	this.setfocus()
	return false
end if
end event

type ddplb_syori_kbn from sv_ddplb_syori within wmm_tokui_atesaki
integer x = 380
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean visible_sakujyo = false
string init_disp = "変更"
end type

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
//		uo_tokui_tanto.of_set_dbchk_dupe( )
//		uo_tokui_tanto.of_set_dbchk_dupe( )

	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_tokui.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose
end event

event constructor;call super::constructor;
this.enabled			= true

setnull( i_syori_kbn )

// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

