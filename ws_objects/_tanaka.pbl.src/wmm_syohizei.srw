$PBExportHeader$wmm_syohizei.srw
$PBExportComments$消費税率登録
forward
global type wmm_syohizei from iw_main_window
end type
type st_torihiki_kbn from ivo_statictext within wmm_syohizei
end type
type st_zei_kbn from ivo_statictext within wmm_syohizei
end type
type st_syori_kbn from ivo_statictext within wmm_syohizei
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_syohizei
end type
type dw_list from ivo_datawindow within wmm_syohizei
end type
type ddplb_torihiki_kbn from sv_ddplb_meisyo within wmm_syohizei
end type
type ddplb_zei_kbn from sv_ddplb_meisyo within wmm_syohizei
end type
end forward

global type wmm_syohizei from iw_main_window
integer height = 1465
string title = "消費税率登録"
boolean f1_key = true
boolean f3_key = true
boolean f6_key = true
st_torihiki_kbn st_torihiki_kbn
st_zei_kbn st_zei_kbn
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
dw_list dw_list
ddplb_torihiki_kbn ddplb_torihiki_kbn
ddplb_zei_kbn ddplb_zei_kbn
end type
global wmm_syohizei wmm_syohizei

type variables
private:
	// ユーザーの管理者権限保有状況
	boolean	i_admin
	
	// 親レコードから更新権限を取得（0：全ユーザー、1：システム管理者）
	integer	i_permission	
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
//	integer	i_meisyo_kbn
//	string	i_meisyo_mei
	integer	i_torihiki_kbn
	integer	i_zei_kbn
	
	
	// ロック状態
	// boolean	i_lck_parent, i_lck_meisyo

	// 表示コントロールのためのアクションリスト
	constant integer	c_act_init		= 1	// 初期時(F9押下)
	constant integer	c_act_retrieve	= 2	// 読込時(表示押下)
	constant integer	c_act_back		= 3	// 戻り時(F6押下)
	constant integer	c_act_dblclk	= 4	// Wクリック時
	constant integer	c_act_update	= 5	// 更新時

	// ダブルクリック状態検知
	boolean	i_doubleclicked
	
	
	
	
	
	
	public:
	boolean	visible_touroku	= true
	boolean	visible_henkou	= true
	boolean	visible_sakujyo	= true
	boolean	visible_syokai	= true

protected:
	string	init_disp
end variables

forward prototypes
public function boolean of_db_delete (any p_rec)
public function boolean of_db_delete ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_record_lock (integer p_torihiki_kbn, integer p_zei_kbn, boolean p_lock)
public subroutine of_dsp_back ()
public subroutine of_dsp_reset ()
public function string of_replace (string p_reptext, string p_repold, string p_repnew)
public function string of_date_format (string p_date)
public subroutine of_filter_set ()
public subroutine of_data_count ()
public function boolean of_record_lock (boolean p_lock)
end prototypes

public function boolean of_db_delete (any p_rec);

return true

end function

public function boolean of_db_delete ();

return true
end function

public subroutine of_dsp_edit (string p_control, boolean p_enabled);/*
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		ddplb_torihiki_kbn.enabled=p_enabled
		ddplb_zei_kbn.enabled=p_enabled
		cb_retrieve.enabled		= p_enabled
	case "dw_list"
		l_row	= long( dw_list.object.datawindow.firstrowonpage )

		if l_row > 0 then
			dw_list.setrow( l_row )
//			dw_list.setcolumn( "bumon_code" )
//			dw_list.setfocus()
//			 一括入力系
//			sle_bumon_ip.enabled	= p_enabled
//			cb_bumon_ip.enabled		= p_enabled
//			sle_eigyo_ip.enabled	= p_enabled
//			cb_eigyo_ip.enabled		= p_enabled
//			sle_ka_ip.enabled		= p_enabled
//			cb_ka_ip.enabled		= p_enabled
//			cb_copy.enabled			= p_enabled
//			cb_clear.enabled		= p_enabled
			
		else
			msg.of_error( "編集可能な行がありません。" )
		end if

end choose
*/


choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		ddplb_torihiki_kbn.enabled=p_enabled
		ddplb_zei_kbn.enabled=p_enabled
		cb_retrieve.enabled		= p_enabled
end choose
end subroutine

public function boolean of_record_lock (integer p_torihiki_kbn, integer p_zei_kbn, boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_zeiritu_lock( i_pg_id, i_torihiki_kbn, i_zei_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_zeiritu_unlock( i_pg_id, i_torihiki_kbn, i_zei_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )

return true
end function

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn = ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
ddplb_torihiki_kbn.event constructor( )
ddplb_zei_kbn.event constructor( )
//sle_menu_id.event constructor( )
//sle_tab_id.event constructor( )
//cb_menu_id.event constructor( )
//cb_tab_id.event constructor( )
cb_retrieve.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn
ddplb_syori_kbn.event selectionchanged( ddplb_syori_kbn.selectitem( l_syori_kbn, 1 ) )

of_set_secondfocus( )

end subroutine

public function string of_replace (string p_reptext, string p_repold, string p_repnew);// --------------------------------------------------------------------------
// Script:     	of_replace
// Purpose:    	指定した文字列に置換する
//
// Arguments:  	p_reptext	- 置換を行う文字列
//			   	p_repold		- 置換前文字列
//			   	p_repnew		- 置換後文字列
//
// Return:     	string	置換した結果の文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

long	l_repstartpos
string	l_reptext,l_repold,l_repnew

l_reptext		= p_reptext
l_repnew		= p_repnew
l_repold		= p_repold

l_repstartpos	= 1
l_repstartpos	= pos( l_reptext, l_repold )

do while l_repstartpos > 0
    l_reptext 		= replace( l_reptext, l_repstartpos, len( l_repold ), l_repnew )
    l_repstartpos	= pos( l_reptext, l_repold, l_repstartpos + len( l_repnew ) )
loop

return( l_reptext )

end function

public function string of_date_format (string p_date);// --------------------------------------------------------------------------
// Script:		nv_func.of_date_format
// Purpose:		指定された文字列を日付形式文字列に変換する
//
// Arguments:	p_date	- 変換したい文字列
// Return:		string	- 日付形式文字列
//
// Date        Prog/ID	Description of Change / Reason
// ----------  --------	-----------------------------------------------------
// 2011.07.20	Kin		Initial coding
// --------------------------------------------------------------------------

p_date = trim(p_date)

//↓updated by Y.Honda 2011.11.17
long		l_cnt	= 1
long		l_len
string	l_number

l_len		= len( p_date )

DO UNTIL l_cnt	> l_len
	if isnumber( mid( p_date, l_cnt, 1 ) )	= true then
		l_number	+= string( mid( p_date, l_cnt, 1 ) )
	end if

	l_cnt++
LOOP

p_date	= l_number
//↑updated by Y.Honda 2011.11.17

choose case len(p_date)
	case 9
		if pos(p_date,"/") <> 0 then
			if pos(p_date,"/",6) = 8 then
				p_date = mid(p_date,1,4) + "/" + mid(p_date,6,2) + "/" + "0" + mid(p_date,9,1)
			else
				p_date = mid(p_date,1,4) + "/" + "0" + mid(p_date,6,1) + "/" + mid(p_date,8,2)
			end if
		end if
	case 8
		if pos(p_date,"/") = 0 then
			p_date = mid(p_date,1,4) + "/" + mid(p_date,5,2) + "/" + mid(p_date,7,2)
		else
			if pos(p_date,"/",4) = 5 then
				p_date = mid(p_date,1,4) + "/" + "0" + mid(p_date,6,1) + "/" + "0" + mid(p_date,8,1)
			else
				if mid(p_date,1,2) < "90" then
					p_date = "20" + p_date
				else
					p_date = "19" + p_date
				end if
			end if
		end if
	case 7
		if pos(p_date,"/") <> 0 then
			if pos(p_date,"/",4) = 6 then
				if mid(p_date,1,2) < "90" then
					p_date = "20" + mid(p_date,1,6) + "0" + mid(p_date,7,1)
				else
					p_date = "19" + mid(p_date,1,6) + "0" + mid(p_date,7,1)
				end if
			else
				if mid(p_date,1,2) < "90" then
					p_date = "20" + mid(p_date,1,3) + "0" + mid(p_date,4,4)
				else
					p_date = "19" + mid(p_date,1,3) + "0" + mid(p_date,4,4)
				end if
			end if
		end if
	case 6
		if pos(p_date,"/") = 0 then
			if mid(p_date,1,2) < "90" then
				p_date = "20" + mid(p_date,1,2) + "/" + mid(p_date,3,2) + "/" + mid(p_date,5,2)
			else
				p_date = "19" + mid(p_date,1,2) + "/" + mid(p_date,3,2) + "/" + mid(p_date,5,2)
			end if
		else
			if mid(p_date,1,2) < "90" then
				p_date = "20" + mid(p_date,1,2) + "/0" + mid(p_date,4,1) + "/0" + mid(p_date,6,1)
			else
				p_date = "20" + mid(p_date,1,2) + "/0" + mid(p_date,4,1) + "/0" + mid(p_date,6,1)
			end if
		end if
	case else
		
end choose

return(p_date)
end function

public subroutine of_filter_set ();
// フィルター実行

string	l_status_syori_kbn
string	l_status_torihiki_kbn

integer	l_row
string	l_filter	= ""

//if dw_list.rowcount() = 0 then
//	return
//end if

l_status_syori_kbn	= ddplb_syori_kbn.text
l_status_torihiki_kbn		= ddplb_torihiki_kbn.text

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()

// ステータス
if l_status_syori_kbn <> "(未選択)" then
	l_filter	= "status = '" + l_status_syori_kbn + "'"
end if

// メッセージ
if l_status_torihiki_kbn <> "(未選択)" then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and msg = '" + l_status_torihiki_kbn + "'"
	else
		l_filter	= "msg = '" + l_status_torihiki_kbn + "'"
	end if
end if

if len( l_filter ) <> 0 then
	// フィルタセット
	dw_list.setfilter( l_filter )
	dw_list.filter()
end if

// 選択行にスクロール
//dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end subroutine

public subroutine of_data_count ();
// フィルター実行

string	l_syori_kbn
string	l_torihiki_kbn
string	l_zei_kbn

integer	l_row
string	l_filter	= ""

//if dw_list.rowcount() = 0 then
//	return
//end if

l_syori_kbn	= ddplb_syori_kbn.text
l_torihiki_kbn		= ddplb_torihiki_kbn.text
l_zei_kbn		= ddplb_zei_kbn.text

l_row	= dw_list.getrow()
dw_list.setredraw( false )

// フィルタのリセット
dw_list.setfilter( "" )
dw_list.filter()

// ステータス
if l_syori_kbn <> "(未選択)" then
	l_filter	= "torihiki = '" + l_torihiki_kbn + "'"
end if

// メッセージ
if l_torihiki_kbn <> "(未選択)" then
	if len( l_filter ) <> 0 then
		l_filter	= l_filter + " and zei = '" + l_zei_kbn + "'"
	else
		l_filter	= "zei = '" + l_torihiki_kbn + "'"
	end if
end if

if len( l_filter ) <> 0 then
	// フィルタセット
	dw_list.setfilter( l_filter )
	dw_list.filter()
end if

// 選択行にスクロール
//dw_list.scrolltorow( l_row )

dw_list.setredraw( true )
end subroutine

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_zeiritu_lock( i_pg_id, i_torihiki_kbn, i_zei_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_zeiritu_unlock( i_pg_id, i_torihiki_kbn, i_zei_kbn ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )

return true
end function

on wmm_syohizei.create
int iCurrent
call super::create
this.st_torihiki_kbn=create st_torihiki_kbn
this.st_zei_kbn=create st_zei_kbn
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.dw_list=create dw_list
this.ddplb_torihiki_kbn=create ddplb_torihiki_kbn
this.ddplb_zei_kbn=create ddplb_zei_kbn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_torihiki_kbn
this.Control[iCurrent+2]=this.st_zei_kbn
this.Control[iCurrent+3]=this.st_syori_kbn
this.Control[iCurrent+4]=this.ddplb_syori_kbn
this.Control[iCurrent+5]=this.dw_list
this.Control[iCurrent+6]=this.ddplb_torihiki_kbn
this.Control[iCurrent+7]=this.ddplb_zei_kbn
end on

on wmm_syohizei.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_torihiki_kbn)
destroy(this.st_zei_kbn)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.dw_list)
destroy(this.ddplb_torihiki_kbn)
destroy(this.ddplb_zei_kbn)
end on

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

// 呼出部
// 1行目
ddplb_syori_kbn.y	= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7		// タイトル「+7」
// 2行目
ddplb_torihiki_kbn.y		= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
ddplb_zei_kbn.y		= ddplb_torihiki_kbn.y			// sle
st_torihiki_kbn.y			= ddplb_torihiki_kbn.y + 7		// タイトル「+7」
st_zei_kbn.y			= ddplb_torihiki_kbn.y + 7		// タイトル「+7」

// st_second_upper高さ
st_second_upper.height	= ddplb_torihiki_kbn.y + 89 + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_list.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y


end event

event retrieve_event;call super::retrieve_event;
long	l_row
int		l_button_no
datastore	l_dts
int		l_torihiki_kbn
int		l_zei_kbn
string 	l_torihiki_kbn_mei
integer	l_cnt


// 存在チェック

select meisyo_code
	  into :l_torihiki_kbn
	  from m_meisyo
	 where meisyo_1	= :ddplb_torihiki_kbn.text
	 and meisyo_kbn=33
	using cocos;


select meisyo_code
	  into :l_zei_kbn
	  from m_meisyo
	 where meisyo_1	= :ddplb_zei_kbn.text
	 and meisyo_kbn=34
	using cocos;


// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= ddplb_syori_kbn.text
i_torihiki_kbn	= l_torihiki_kbn
i_zei_kbn	= l_zei_kbn


// 存在チェック
select count('x')
  into :l_cnt
  from m_zeiritu
 where torihiki_kbn	= :i_torihiki_kbn
   and zeiritu_kbn	= :i_zei_kbn
using cocos;

choose case i_syori_kbn
	case "登録"
		if l_cnt <> 0 then
			msg.of_error( "該当データが存在します。この処理は実行できません。" )
			this.setfocus()
			return -1
		end if
		
		// 1行固定で追加
			dw_list.insertrow(0)
			dw_list.object.torihiki_kbn[1]  = i_torihiki_kbn
			dw_list.object.zeiritu_kbn[1]	= i_zei_kbn
	case "変更", "削除"
		// 検索実行
		if dw_list.retrieve(l_torihiki_kbn,l_zei_kbn) = 0 then
			msg.of_error( "入力した取引区分、税区分で登録されたデータはありません。" )
			return -1
		end if
		
		// 排他チェック
		if not of_record_lock( true ) then
			setredraw( true )
			return -1
		end if

	case "照会"
		// 検索実行
		if dw_list.retrieve(l_torihiki_kbn,l_zei_kbn ) = 0 then
			msg.of_error( "入力した取引区分、税区分で登録されたデータはありません。" )
			return -1
		end if
end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if

// 一旦フォーカスを明細部へ
dw_list.setfocus()


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

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
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

event open;call super::open;
// 初期表示
of_set_firstfocus( )
end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not ddplb_torihiki_kbn.event input_check( ) then
	return -1
end if

if not ddplb_zei_kbn.event input_check( ) then
	return -1
end if



end event

event update_check;call super::update_check;
long	l_row

string l_zeiritu_str_date
string l_zeiritu_str_date_next
string l_zeiritu_end_date

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

setredraw( false)

for l_row = 1 to dw_list.rowcount()
	
	dw_list.setrow( l_row )


//	if isnull(dw_list.object.zeiritu_str_date_inp[l_row] ) then
//		dw_list.object.zeiritu_str_date_inp[l_row] =""
//	end if
//	
//	if dw_list.object.zeiritu_str_date_inp[l_row] ="" then
//		msg.of_error_dwo(dw_list.object.zeiritu_str_date_inp,  "適用開始日が、入力されていません。"  )
//		return -1
//	end if
//		
//	if isnull(dw_list.object.zeiritu_end_date_inp[l_row] ) then
//		dw_list.object.zeiritu_end_date_inp[l_row] =""
//	end if
//	
//	if dw_list.object.zeiritu_end_date_inp[l_row] ="" then
//		msg.of_error_dwo(dw_list.object.zeiritu_end_date_inp,  "適用開始日が、入力されていません。"  )
//		return -1
//	end if
		


			

	if dw_list.event itemchanged( l_row, dw_list.object.zeiritu_str_date_inp, dw_list.object.zeiritu_str_date_inp[l_row] ) <> 0 then
		setredraw( true )
		dw_list.setrow( l_row )
		dw_list.setcolumn( "zeiritu_str_date_inp" )
		dw_list.setfocus()
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.zeiritu_end_date_inp, dw_list.object.zeiritu_end_date_inp[l_row] ) <> 0 then
		setredraw( true )
		return -1
	end if
		
	if dw_list.event itemchanged( l_row, dw_list.object.syohizei_ritu, string(dw_list.object.syohizei_ritu[l_row]) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if (l_row <> 1) then // 1行目ではないとき
		l_zeiritu_str_date = fnc.db.of_date_format( dw_list.object.zeiritu_str_date_inp[l_row] )
		if not isdate( l_zeiritu_str_date ) then	// 日付として使えるかどうかのチェック
			return -1
		end if
	end if

	if (l_row <> dw_list.rowcount()) then

		l_zeiritu_str_date_next       = fnc.db.of_date_format(dw_list.object.zeiritu_str_date_inp[l_row+1])
		if not isdate( l_zeiritu_str_date_next ) then	// 日付として使えるかどうかのチェック
			return -1
		end if
	
		l_zeiritu_end_date = fnc.db.of_date_format( dw_list.object.zeiritu_end_date_inp[l_row] )

		if not isdate( l_zeiritu_end_date ) then	// 日付として使えるかどうかのチェック
			return -1
		end if
		
		if ( DaysAfter(date(l_zeiritu_str_date),date(l_zeiritu_end_date))  < 0) then	// 開始と終了の整合性のチェック
			msg.of_error( "大小関係がエラーです。" )
			dw_list.setcolumn("zeiritu_str_date_inp")
			return 1
		end if
		
		if( Relativedate(date(l_zeiritu_end_date),1) <>  date(l_zeiritu_str_date_next) ) then
			msg.of_error( "重複、もしくは空白の期間があるため、更新できません。" )
			//dw_list.setrow(l_row+1)
			dw_list.setcolumn("zeiritu_str_date_inp")
			return -1
		end if
		

		
		
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.zeiritu_end_date_inp,dw_list.object.zeiritu_end_date_inp[l_row] ) <> 0 then
		setredraw( true )
		return -1
	end if

	if dw_list.event itemchanged( l_row, dw_list.object.syohizei_ritu,string(dw_list.object.syohizei_ritu[l_row])) <> 0 then
		setredraw( true )
		return -1
	end if

next


setredraw( true )

end event

event update_event;call super::update_event;
long		l_row
long		l_count
string		l_type


choose case i_syori_kbn
	case "登録2"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "消費税率マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if

		// ログ出力( イベントID, エラーコード, メッセージ )
		of_add_db_log( "update_event", 0, st_title.text + "[" + ddplb_torihiki_kbn.text + " " +  ddplb_zei_kbn.text + "]" + i_syori_kbn )

	case "登録","変更"
		long ll_row, ll_rowcount, li_checked, li_delete_flg, l_row_num
		
		string ls_operation_type
		any la_operations[]
		
		any la_current_op[]
		string ls_log_message
		
		// 動的sql使わない場合はいらない
		string ls_sql, ls_values
		long ll_count
		
		ll_rowcount = dw_list.RowCount()
		
		// DataWindow の各行を処理
		for ll_row = 1 to ll_rowcount
			any la_op[9]
			ls_operation_type = ""
		
			// 行のステータスを確認
			choose case dw_list.GetItemStatus(ll_row, 0, Primary!)
		
				case NotModified!
					continue
		
				case NewModified!, New!
					ls_operation_type = "登録"
		//			dw_list.object.tokui_code[ll_row] = i_tokui_code
		
				case DataModified!
					ls_operation_type = "更新"
					li_delete_flg = dw_list.Object.delete_flg[ll_row]
					if li_delete_flg = 1 then
						ls_operation_type = "削除"
						dw_list.DeleteRow(ll_row)
						// 削除したので、行番号を調整
						ll_row = ll_row - 1
						ll_rowcount = ll_rowcount - 1
					end if
			end choose
		
			// 操作情報を配列に格納
			
		//	la_op[1] = i_tokui_code
		//	la_op[2] = trim(uo_tokui.st_meisyo.text)
		//	la_op[3] = trim(ddplb_kahi_kbn.text)
		//	la_op[4] = string(dw_list.object.syohin_code[ll_row])
		//	la_op[5] = string(dw_list.object.iro_no[ll_row])
		//	la_op[6] = trim(string(dw_list.object.ms_hin_ban[ll_row]))
		//	la_op[7] = trim(string(dw_list.object.ms_hin_mei[ll_row]))
		//	la_op[8] = trim(string(dw_list.object.ms_iro_mei[ll_row]))
		//	la_op[9] = ls_operation_type
		
			la_operations[UpperBound(la_operations) + 1] = la_op
		
		//	dw_list.object.kahi_kbn[ll_row] = ddplb_kahi_kbn.of_get_code_num()
		next
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "消費税率マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if

		// ログ出力( イベントID, エラーコード, メッセージ )
		of_add_db_log( "update_event", 0, st_title.text + "[" + ddplb_torihiki_kbn.text + " " +  ddplb_zei_kbn.text + "]" + i_syori_kbn )
		
	case "削除"



		
		//行の削除
		l_count = dw_list.rowcount()
		for l_row = 1 to l_count
			dw_list.deleterow(l_row)
		next
		// 更新 ( accepttext実行、更新フラグはリセットしない )
		if not dw_list.update( true, false ) = 1 then
			rollback using cocos;
			msg.of_error( fnc.strg.of_format( "消費税率マスタの登録処理でエラーが発生しました。{1}{2}：{3}", code.crlf, string( cocos.last_sqlerrcode ), cocos.last_sqlerrtext ) )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return 1
		end if

		// ログ出力( イベントID, エラーコード, メッセージ )
		of_add_db_log( "update_event", 0, st_title.text + "[" + ddplb_torihiki_kbn.text + " " +  ddplb_zei_kbn.text + "]" + i_syori_kbn )

	case "照会"
end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()

end event

event key_f01;call super::key_f01;
// 全選択

integer	l_mode
integer	l_row, l_rowcnt, l_chkcnt

l_rowcnt	= dw_list.RowCount()
l_chkcnt	= long( dw_list.describe( "evaluate( 'sum( chk )', 0 )" ) )

if l_rowcnt = l_chkcnt then
	// 全選択状態なので選択解除
	l_mode	= 0
else
	// 未選択もしくは一部選択状態なので全選択
	l_mode	= 1
end if

for l_row = 1 to dw_list.rowcount()
	dw_list.object.chk[l_row]	= l_mode
next

return 0

end event

event key_f03;call super::key_f03;/*
// 行削除

long	l_row

setredraw( false )

// チェックONの行を削除
for l_row = dw_list.rowcount() to 1 step -1
	if dw_list.object.chk[l_row] = 1 then
		dw_list.deleterow( l_row )
	end if
next

// 件数再セット
//of_data_count()

setredraw( true )



return 0
*/

long l_row, l_chkcnt, l_chkcnt_not_deleted, l_delete_flg
boolean lb_all_deleted, lb_not_new

// チェックされた行の総数とdelete_flgが0の行数をカウント
l_chkcnt = long(dw_list.describe("evaluate('sum(chk)', 0)"))
l_chkcnt_not_deleted = long(dw_list.describe("evaluate('sum(if(chk=1 and delete_flg=0, 1, 0))', 0)"))

// 新規行があったらすべて削除状態にしていい
lb_not_new = true
for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chk[l_row] = 1 then
		choose case dw_list.GetItemStatus(l_row, 0, Primary!)
		case NewModified!, New!
			lb_not_new = false
		end choose
	end if
next

if l_chkcnt = 0 then
	return 0
else
	setredraw(false)
	lb_all_deleted = (l_chkcnt_not_deleted = 0)
	
	for l_row = dw_list.rowcount() to 1 step -1
		if dw_list.object.chk[l_row] = 1 then
			choose case dw_list.GetItemStatus(l_row, 0, Primary!)
			case NewModified!, New!
				// 新規行の場合、行を削除
				dw_list.deleterow(l_row)
			case DataModified!
				if lb_all_deleted and lb_not_new then
					// すべてが削除状態の場合はトグル
					l_delete_flg = dw_list.Object.delete_flg[l_row]
					dw_list.object.delete_flg[l_row] = 1 - l_delete_flg
				else
					// 一つでも未削除があればすべて削除状態に
					dw_list.object.delete_flg[l_row] = 1
				end if
			end choose
		end if
	next
	
	setredraw(true)
end if
return 0

end event

event key_f02;call super::key_f02;
// 行追加

long	l_row
long	l_row_ins

l_row	= dw_list.find( "chk = 1", 1, dw_list.rowcount() )
// 行追加
l_row_ins	= dw_list.insertrow( l_row )
// 初期値セットなどの処理があればここに記載
dw_list.object.torihiki_kbn[l_row_ins]  = i_torihiki_kbn
dw_list.object.zeiritu_kbn[l_row_ins]   = i_zei_kbn

// 状態を戻す
dw_list.setitemstatus( l_row_ins, 0, primary!, notmodified! )
// カーソルを追加行の最初のカラムにセット
dw_list.setrow( l_row_ins )
dw_list.setcolumn( "zeiritu_str_date_inp" )		


return 0
end event

type uo_signal from iw_main_window`uo_signal within wmm_syohizei
end type

type st_date from iw_main_window`st_date within wmm_syohizei
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_syohizei
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_syohizei
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_syohizei
end type

type st_title from iw_main_window`st_title within wmm_syohizei
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_syohizei
end type

type st_upper from iw_main_window`st_upper within wmm_syohizei
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_syohizei
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_syohizei
integer taborder = 40
end type

event constructor;call super::constructor;this.enabled	= true
end event

type st_torihiki_kbn from ivo_statictext within wmm_syohizei
integer x = 32
integer y = 260
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "取引区分"
alignment alignment = right!
end type

type st_zei_kbn from ivo_statictext within wmm_syohizei
integer x = 688
integer y = 260
integer width = 248
boolean bringtotop = true
long backcolor = 12632256
string text = "税区分"
alignment alignment = right!
end type

type st_syori_kbn from ivo_statictext within wmm_syohizei
integer x = 32
integer y = 167
integer width = 328
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_syohizei
integer x = 380
integer y = 156
integer width = 268
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_syori_kbn )

end event

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
//		uo_tokui.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose
end event

type dw_list from ivo_datawindow within wmm_syohizei
integer x = 304
integer y = 416
integer width = 1568
integer height = 665
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_syohizei"
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
boolean f1_key = true
boolean f2_key = true
boolean f3_key = true
boolean f6_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf9_key = true
boolean sf10_key = true
boolean sf12_key = true
boolean save_excel = false
end type

event constructor;call super::constructor;i_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

long			l_row


// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

if l_row > 0 then
	choose case i_syori_kbn
		case "変更", "削除"
			if not of_record_lock( false ) then
				return -1
			end if
	end choose
end if

this.reset()
this.settransobject(cocos)

end event

event itemchanged;call super::itemchanged;
DataWindowChild	ldwc
long	l_row
string l_zeiritu_str_date
string l_zeiritu_end_date

string	l_input
string	l_colnm
string	l_tableid	= "m_zeiritu"
string	l_msg

choose case dwo.name

	case "zeiritu_str_date_inp"
		// null回避
		if isnull( data )  then
			data	= ""
		end if
		
		if  data=""  then
			msg.of_error_dwo(dwo,  "適用開始日が、入力されていません。"  )
			return 1
		end if

		//return 1
		//変更不可　ただし、行追加が行われた場合は新しい行については変更可能。（行追加は未実装）
		
		if row=1 then
			this.post setitem( row, "zeiritu_str_date_inp", "0000/00/00" )
			this.post setitem( row, "zeiritu_str_date", 0 )
		
		else
		
			l_zeiritu_str_date = fnc.db.of_date_format( data )
	
			if not IsDate(l_zeiritu_str_date ) THEN
				return 1
			end if
			
			this.object.zeiritu_str_date[row] 		= long( string( date(l_zeiritu_str_date), "yyyymmdd" ) )
			this.post setitem(row,"zeiritu_str_date_inp", string( date(l_zeiritu_str_date), "yyyy/mm/dd" ))
		end if
		
	case "zeiritu_end_date_inp"
		// null回避
		if isnull( data )  then
			data	= ""
		end if
		
		if  data=""  then
			msg.of_error_dwo(dwo,  "適用終了日が、入力されていません。"  )
			return 1
		end if
		
		l_zeiritu_end_date = fnc.db.of_date_format( data )
		
		if row = this.rowcount() then

			this.post setitem( row, "zeiritu_end_date_inp", "9999/99/99" )
			this.post setitem( row, "zeiritu_end_date", 99999999 )

		else
		
			//日付かどうかチェック。日付形式でない場合はもとに戻す。
	    	if not IsDate(l_zeiritu_end_date) THEN
        		return 1
    		end if
		
			this.object.zeiritu_end_date[row] 		= long( string( date(l_zeiritu_end_date), "yyyymmdd" ) )
			this.post setitem(row,"zeiritu_end_date_inp", string( date(l_zeiritu_end_date), "yyyy/mm/dd" ))

		end if
		
	case "syohizei_ritu"

		l_input	= trim( data )
		l_colnm	= dwo.tag		// タグ値で項目名を取得
		
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
		

end choose

//// 自動行追加
//if i_syori_kbn = "登録" or i_syori_kbn = "変更" then
//	l_row = this.rowcount()
//	if dwo.name  <> "chk" then
//		if l_row = row then
//			this.InsertRow(0)
//		end if
//	end if
//end if


return 0
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

type ddplb_torihiki_kbn from sv_ddplb_meisyo within wmm_syohizei
integer x = 380
integer y = 252
integer width = 268
integer taborder = 20
boolean bringtotop = true
integer meisyo_kbn = 33
integer meisyo_no = 1
string init_code = "1"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_torihiki_kbn )

end event

type ddplb_zei_kbn from sv_ddplb_meisyo within wmm_syohizei
integer x = 956
integer y = 252
integer width = 428
integer taborder = 30
boolean bringtotop = true
integer meisyo_kbn = 34
integer meisyo_no = 1
string init_code = "1"
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

setnull( i_zei_kbn )
end event

