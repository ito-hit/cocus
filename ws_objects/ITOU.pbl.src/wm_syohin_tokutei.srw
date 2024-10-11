$PBExportHeader$wm_syohin_tokutei.srw
forward
global type wm_syohin_tokutei from iw_main_window
end type
type syohin_iro from ivo_singlelineedit within wm_syohin_tokutei
end type
type iro from ivo_singlelineedit within wm_syohin_tokutei
end type
type sle_1 from ivo_singlelineedit within wm_syohin_tokutei
end type
type dw_list from ivo_datawindow within wm_syohin_tokutei
end type
end forward

global type wm_syohin_tokutei from iw_main_window
string title = "特定得意先商品登録"
syohin_iro syohin_iro
iro iro
sle_1 sle_1
dw_list dw_list
end type
global wm_syohin_tokutei wm_syohin_tokutei

type variables
	private:

	// 呼出し部の情報を保管
	long	i_syohin_iro, i_iro, i_sle_1



protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible
	
		// 初期選択させておきたい名称コード
	string	init_code
end variables

forward prototypes
public subroutine of_dsp_open ()
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
end prototypes

public subroutine of_dsp_open ();long	l_indx
string	l_nendo_mei
end subroutine

public subroutine of_dsp_back ();
//of_dsp_edit( "callsection", true )
dw_list.event constructor( )
of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

end subroutine

public subroutine of_dsp_reset ();string	l_syori_kbn
long	l_indx
string	l_nendo_mei

dw_list.event constructor( )

of_set_secondfocus( )
end subroutine

on wm_syohin_tokutei.create
int iCurrent
call super::create
this.syohin_iro=create syohin_iro
this.iro=create iro
this.sle_1=create sle_1
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.syohin_iro
this.Control[iCurrent+2]=this.iro
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.dw_list
end on

on wm_syohin_tokutei.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.syohin_iro)
destroy(this.iro)
destroy(this.sle_1)
destroy(this.dw_list)
end on

event retrieve_check;call super::retrieve_check;
string	l_syohin_code, l_iro_code, l_sle_1_code
boolean	l_ret

l_ret	= false

// 商品コード
l_syohin_code	= syohin_iro.text
l_iro_code	= iro.text
l_sle_1_code	= iro.text

if l_syohin_code = "" or l_iro_code = "" or l_sle_1_code = "" then	// 入力項目に何も入力がなかったら
	msg.of_error( "商品コード、色番が未入力です" )
	return -1
end if

end event

event resize;call super::resize;// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

//st_second_upper.height	= 821
//cb_retrieve.y			= 836

// 呼出部
long l_row_1_y
long l_row_2_y

long l_komoku_height = 89

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」

syohin_iro.y				= l_row_1_y + 7
iro.y				= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
sle_1.y			= l_row_2_y

// st_second_upper高さ
st_second_upper.height	= l_row_2_y + l_komoku_height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
dw_list.y				= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x				= code.MGN_YOKO
dw_list.width			= newwidth - code.MGN_YOKO * 2
dw_list.height			= key_fnc.y - code.MGN_TATE - dw_list.y
end event

event retrieve_event;call super::retrieve_event;long	l_row
long	l_loop
long	l_syohin_iro, l_iro, l_sle_1

// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syohin_iro	= long(syohin_iro.text)
i_iro	= long(iro.text)
i_sle_1	= long(sle_1.text)
/*
画面.特定得意先販売区分＝1（原則許可）の場合、得意先商品M.可否区分=2（例外的禁止）
画面.特定得意先販売区分＝2（原則禁止）の場合、得意先商品M.可否区分=1（例外的許可）
画面にはテキストで来て、それによって条件を分岐させる
*/

// 更新部初期化
dw_list.event constructor( )

/*
// 排他チェック
		if not of_record_lock( i_syohin_iro, i_iro, i_sle_1, true ) then
//			setredraw( true )
			return -1
		end if
*/

// 検索実行
if dw_list.retrieve( i_syohin_iro, i_iro, i_sle_1 )  = 0 then
	msg.of_error( "検索されたデータはありません。" )
	return -1
end if

dw_list.setfocus()


end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
end if

end event

event open;call super::open;// 初期表示
of_set_firstfocus( )


end event

event key_f12;call super::key_f12;if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event update_event;call super::update_event;string ls_houhou, ll_houhou_value, ll_riyu_value
long ll_row, ll_rowcount, li_checked, ll_new_kahi_kbn, li_delete_flg

// i_sle_1の値を取得
i_sle_1 = long(sle_1.text)

if i_sle_1 = 1 then // 原則許可の場合
    ll_new_kahi_kbn = 2 // 例外的禁止
elseif i_sle_1 = 2 then // 原則禁止の場合
    ll_new_kahi_kbn = 1 // 例外的許可
else
	// エラー処理
	messagebox("エラー", "i_sle_1の値が不正です。")
	return -1
end if

ll_rowcount = dw_list.RowCount()
for ll_row = 1 to ll_rowcount
	li_checked = dw_list.GetItemNumber(ll_row, "chk")
	// チェックが入っている場合
	if li_checked = 1 then
		li_delete_flg = dw_list.GetItemNumber(ll_row, "delete_flg")
		// 行削除がされていない場合
		if li_delete_flg = 0 or isnull(li_delete_flg) then
			dw_list.SetItem(ll_row, "kahi_kbn", ll_new_kahi_kbn)
			dw_list.SetItem(ll_row, "syohin_code", i_syohin_iro)
			dw_list.SetItem(ll_row, "iro_no", i_iro)
	
			// houhou_kbnの処理
			if IsNumber(dw_list.GetItemString(ll_row, "houhou")) then
				 dw_list.SetItem(ll_row, "houhou_kbn", Long(dw_list.GetItemString(ll_row, "houhou")))
			else
				 dw_list.SetItem(ll_row, "houhou_kbn", dw_list.GetItemString(ll_row, "houhou"))
			end if
			
			// riyu_kbnの処理
			if IsNumber(dw_list.GetItemString(ll_row, "riyu")) then
				 dw_list.SetItem(ll_row, "riyu_kbn", Long(dw_list.GetItemString(ll_row, "riyu")))
			else
				 dw_list.SetItem(ll_row, "riyu_kbn", dw_list.GetItemString(ll_row, "riyu"))
			end if
			if sqlca.sqlcode <> 0 then
				exit
			end if
		else
			// delete_flgが1の場合、行を削除
            dw_list.DeleteRow(ll_row)
            // 削除したので、行番号を調整
			ll_row = ll_row - 1
  			ll_rowcount = ll_rowcount - 1
        end if
		
	// チェックが入っていない場合CUDしない
	else
		dw_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	end if	  
next

if not dw_list.update( true, false ) = 1 then
	rollback using cocos;
	msg.of_error_db( "特定得意先商品登録マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
	setredraw( true )
	return -1
end if

// ログ出力
//of_add_db_log( "update_event", 0, st_title.text + "[" + trim( uo_tanto.of_get_input() ) + " " + trim( uo_tanto.of_get_tanto_mei() ) + " " + trim( uo_nendo.ddplb_nendo.text ) + "]" + i_syori_kbn )
		
//msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()
end event

event key_f02;call super::key_f02;long l_insert_position, l_new_row

// チェックされている最初の行を探す
l_insert_position = dw_list.Find("chk = 1", 1, dw_list.RowCount())

// チェックされていたらその一つ上に、チェックが無かったら一番下に行を追加
l_new_row = dw_list.InsertRow(l_insert_position)

if l_new_row > 0 then
    // 追加成功
    dw_list.ScrollToRow(l_new_row)
    dw_list.SetRow(l_new_row)
    dw_list.SetFocus()
    return 1
else
    MessageBox("エラー", "新規行の追加に失敗しました。")
    return -1
end if

end event

event key_f03;call super::key_f03;long l_row, l_row_status, l_color, l_chk_value, l_row_num, l_delete_flg
string ls_row_num_type
boolean lb_any_row_selected = false, lb_is_new_row = false

l_color = RGB(242, 222, 222)

dw_list.SetRedraw(false)

// チェックが入っている行を削除またはフラグをトグル
for l_row = dw_list.RowCount() to 1 step -1
	l_chk_value = dw_list.GetItemNumber(l_row, "chk")
	// チェックが入っている場合
	if l_chk_value = 1 then
		lb_any_row_selected = true
			l_row_num = dw_list.GetItemNumber(l_row, "row_num")    
			// row_numがNullの場合、新規行とみなし行削除
			if IsNull(l_row_num) then
				dw_list.DeleteRow(l_row)
			else
				// 既存行
				l_delete_flg = dw_list.GetItemNumber(l_row, "delete_flg")
				dw_list.SetItem(l_row, "delete_flg", 1 - l_delete_flg)
		end if
	end if
next

// チェックされた行がない場合の処理、いらない？
if not lb_any_row_selected then
    MessageBox("警告", "行が選択されていないか、'chk'が1ではありません。")
end if

dw_list.SetRedraw(true)
return 1

end event

event key_f01;call super::key_f01;
// 全選択

long	l_row
long	l_mode	= 1	// 1:全選択/0:全解除

// 全行のチェックボックスがONでない場合(OFFが１つでもある) = 全選択
// 全行のチェックボックスがONの場合    (OFFが１つもない)   = 全解除
if dw_list.find( "chk = 0", 1, dw_list.rowcount() ) = 0 then
	l_mode	= 0
end if

for l_row = 1 TO dw_list.rowcount()

		dw_list.object.chk[l_row] = l_mode

next

return 0

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

event update_check;call super::update_check;
long	l_row, l_str_date, l_end_date, li_checked

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

setredraw( false )

for l_row = 1 to dw_list.rowcount()
	li_checked = dw_list.GetItemNumber(l_row, "chk")
	// チェックが入っている場合
	if li_checked = 1 then
		dw_list.setrow( l_row )
		if dw_list.event itemchanged( l_row, dw_list.object.tokui_code, string( dw_list.object.tokui_code[l_row] ) ) <> 0 then
			setredraw( true )
			return -1
		end if
		l_str_date = long(dw_list.object.str_date[l_row])
		l_end_date = long(dw_list.object.end_date[l_row])
		if l_str_date > l_end_date then
			msg.of_error( "開始日と終了日の前後関係が不正です" )
			setredraw( true )
			return -1
		end if
	end if
next

setredraw( true )

end event

type uo_signal from iw_main_window`uo_signal within wm_syohin_tokutei
end type

type st_date from iw_main_window`st_date within wm_syohin_tokutei
end type

type st_user_mei from iw_main_window`st_user_mei within wm_syohin_tokutei
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_syohin_tokutei
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_syohin_tokutei
end type

type st_title from iw_main_window`st_title within wm_syohin_tokutei
integer width = 628
end type

type st_title_upper from iw_main_window`st_title_upper within wm_syohin_tokutei
end type

type st_upper from iw_main_window`st_upper within wm_syohin_tokutei
end type

type st_second_upper from iw_main_window`st_second_upper within wm_syohin_tokutei
integer x = 8
integer y = 132
integer height = 491
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_syohin_tokutei
integer x = 4168
integer y = 469
integer taborder = 40
end type

type syohin_iro from ivo_singlelineedit within wm_syohin_tokutei
string tag = "商品"
integer x = 84
integer y = 174
integer width = 404
integer taborder = 10
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "商品"
integer limit = 10
string placeholder = "商品"
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type iro from ivo_singlelineedit within wm_syohin_tokutei
string tag = "色"
integer x = 504
integer y = 174
integer width = 404
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "色"
integer limit = 10
string placeholder = "色"
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type sle_1 from ivo_singlelineedit within wm_syohin_tokutei
string tag = "特定得意先販売区分"
integer x = 72
integer y = 377
integer width = 600
integer taborder = 30
boolean bringtotop = true
integer init_imemode = 3
integer textsize = -11
string text = "特定得意先販売区分"
integer limit = 10
string placeholder = "特定得意先販売区分"
boolean f9_key = true
boolean f10_key = true
integer i_limit = 10
end type

event constructor;call super::constructor;this.i_function_name	= { "", "", "", "", "", "", "", "", "", "", "", "" }
this.enabled			= true

this.text				= ""

end event

type dw_list from ivo_datawindow within wm_syohin_tokutei
integer y = 800
integer width = 5120
integer height = 626
integer taborder = 50
boolean bringtotop = true
string dataobject = "dm_syohin_tokutei"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f2_key = true
boolean f3_key = true
boolean f5_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean sf1_key = true
boolean sf2_key = true
boolean row_focus_ind = true
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "", "", "", "", "" }

this.reset()
this.settransobject(cocos)


DataWindowChild	ldwc_houhou
DataWindowChild	ldwc_riyu
//DataWindowChild	ldwc_tuuti_lvl

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "houhou", ldwc_houhou)
ldwc_houhou.settransobject( cocos )

meisyo_kbn		= 152
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_houhou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "riyu", ldwc_riyu)
ldwc_riyu.settransobject( cocos )

meisyo_kbn		= 153
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_riyu.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

this.settransobject(cocos)

this.reset()

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf1!, true )
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf1!, false )
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

this.of_set_fnkey( keyf12!, true )

end event

event key_f01;call super::key_f01;
// 全選択

integer	l_mode
integer	l_row, l_rowcnt, l_chkcnt

l_rowcnt	= dw_list.rowcount()
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

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "特定得意先商品登録（一覧）マスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event itemchanged;call super::itemchanged;string	l_column_type, l_iro_code
decimal	l_column_length

long	l_code, l_syohin_code, l_iro_no, l_tokui_code, l_syusoku_flg, al_currentRow, ll_tokui_code, low

string	l_input
string	l_colnm
string	l_tableid	= "m_tokui_syohin"
string	l_msg

// 入力チェック
choose case dwo.name
	case "tokui_code"
		long ll_chk_value
		ll_chk_value = dw_list.GetItemNumber(row, "chk")
		if ll_chk_value = 1 then
			l_input	= trim( data )
			l_colnm	= dwo.tag		// タグ値で項目名を取得
			if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
				msg.of_error_dwo( dwo, l_msg )
				return 1
			end if
		end if
	case else
end choose
l_iro_code	= iro.text
// 個別チェック
choose case dwo.name

	case "tokui_code"
		
		l_tokui_code	= long( trim( data ) )
		select  tokui_code, syusoku_flg
		into    :l_tokui_code, :l_syusoku_flg
		from    m_tokui
		where	tokui_code = :l_tokui_code
		using cocos	;
		
		choose case cocos.sqlcode
			case 0
				string ls_row_num_type
				ls_row_num_type = dw_list.Describe("row_num.ColType")   
				boolean lb_is_new_row = false   
				if Left(ls_row_num_type, 7) = "number" then
					// row_numがナンバー型の場合、値を取得
					long ll_row_num
					ll_row_num = dw_list.GetItemNumber(row, "row_num")    
					// row_numがNullの場合、新規行とみなす
					if IsNull(ll_row_num) then
						//ここは新規登録行のみ行う
						// 得意先商品マスタのチェック
						l_tokui_code	= long( trim( data ) )
						l_syohin_code = i_syohin_iro
						l_iro_no = i_iro
						select  syohin_code, tokui_code, iro_no
						into    :l_tokui_code, :l_syohin_code, :l_iro_no
						from    m_tokui_syohin
						where	tokui_code = :l_tokui_code
						and syohin_code = :l_syohin_code
						and iro_no = :l_iro_no
						using cocos	;
					choose case cocos.sqlcode
						case 0
							msg.of_error( fnc.strg.of_format( "この{1}は既に登録されています。", describe( dwo.name + ".tag" ) ) )
							return 1
						case 100
							if l_syusoku_flg = 1 then
								msg.of_error( fnc.strg.of_format( "{1}が終息のため、この処理は実行できません。", describe( dwo.name + ".tag" ) ) )
								return 1
							end if 
						case else
							msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
							return 1
						end choose
					else
				end if
			end if
			case 100
				msg.of_error( fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
				return 1
			case else
				msg.of_error( fnc.strg.of_format( "{1}入力チェック中にエラーが発生しました{2}（{3}）", describe( "bumon_code_t.text" ), code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
				return 1
		end choose
	case else
end choose

return 0

end event

