$PBExportHeader$wm_syohin_tokutei.srw
$PBExportComments$特定得意先商品登録
forward
global type wm_syohin_tokutei from iw_main_window
end type
type dw_list from ivo_datawindow within wm_syohin_tokutei
end type
type uo_syohin_iro from cv_input_syohin within wm_syohin_tokutei
end type
type st_tokutei_tokui_kbn_mei2 from sv_st_meisyo within wm_syohin_tokutei
end type
type st_tokutei_tokui_kbn_mei1 from sv_st_meisyo within wm_syohin_tokutei
end type
type st_tokutei_tokui_kbn_label from ivo_statictext within wm_syohin_tokutei
end type
end forward

global type wm_syohin_tokutei from iw_main_window
string title = "特定得意先商品登録"
dw_list dw_list
uo_syohin_iro uo_syohin_iro
st_tokutei_tokui_kbn_mei2 st_tokutei_tokui_kbn_mei2
st_tokutei_tokui_kbn_mei1 st_tokutei_tokui_kbn_mei1
st_tokutei_tokui_kbn_label st_tokutei_tokui_kbn_label
end type
global wm_syohin_tokutei wm_syohin_tokutei

type variables
	private:
	nv_string	i_str
	// 呼出し部の情報を保管
	long	i_syohin_iro, i_iro,i_size, i_tokutei_tokui_kbn
protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible
	
		// 初期選択させておきたい名称コード
	string	init_code
end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public subroutine of_dsp_reset ()
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )

of_set_firstfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		uo_syohin_iro.of_set_enabled( p_enabled )
		cb_retrieve.enabled		= p_enabled
end choose
end subroutine

public subroutine of_dsp_reset ();
of_dsp_edit( "callsection", true )
uo_syohin_iro.event constructor( )
st_tokutei_tokui_kbn_mei1.event constructor( )
st_tokutei_tokui_kbn_mei2.event constructor( )
dw_list.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装あり

// 参照設定
str_mdlpara_mtokui	l_mdl_tokui

// F8:参照
choose case p_dwo.name
	case "tokui_code"
		// 部門
		l_mdl_tokui	= mdl.of_open_modal( "wsm_tokui", l_mdl_tokui )
		if upperbound( l_mdl_tokui.ret ) > 0 then
			dw_list.object.tokui_code[p_row]	= dec( l_mdl_tokui.ret[1].tokui_code )
			dw_list.object.tokui_mei[p_row]	= l_mdl_tokui.ret[1].tokui_mei
		end if

end choose


end subroutine

on wm_syohin_tokutei.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.uo_syohin_iro=create uo_syohin_iro
this.st_tokutei_tokui_kbn_mei2=create st_tokutei_tokui_kbn_mei2
this.st_tokutei_tokui_kbn_mei1=create st_tokutei_tokui_kbn_mei1
this.st_tokutei_tokui_kbn_label=create st_tokutei_tokui_kbn_label
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.uo_syohin_iro
this.Control[iCurrent+3]=this.st_tokutei_tokui_kbn_mei2
this.Control[iCurrent+4]=this.st_tokutei_tokui_kbn_mei1
this.Control[iCurrent+5]=this.st_tokutei_tokui_kbn_label
end on

on wm_syohin_tokutei.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.uo_syohin_iro)
destroy(this.st_tokutei_tokui_kbn_mei2)
destroy(this.st_tokutei_tokui_kbn_mei1)
destroy(this.st_tokutei_tokui_kbn_label)
end on

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック

// 入力チェック
if not uo_syohin_iro.event sle_iro_input_check( ) then
	return -1
end if

end event

event resize;call super::resize;
// 検索1段目ボタン(Height:85) Y座標：156
// 検索2段目ボタン(Height:85) Y座標：256

//st_second_upper.height	= 821
//cb_retrieve.y			= 836

// 呼出部
long l_row_1_y
long l_row_2_y

long l_komoku_height = 89

// 1行目
l_row_1_y	= st_second_upper.y + code.MGN_UPPER_TATE				// 1行目「MGN_UPPER_TATE:21」
uo_syohin_iro.y				= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
st_tokutei_tokui_kbn_label.y			= l_row_2_y
st_tokutei_tokui_kbn_mei2.y			= l_row_2_y

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

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syohin_iro	= long(uo_syohin_iro.sle_input.text)
i_iro	= long(uo_syohin_iro.sle_input_iro.text)

if st_tokutei_tokui_kbn_mei1.text = "原則許可" then
	i_tokutei_tokui_kbn	= 2
elseif st_tokutei_tokui_kbn_mei1.text = "原則禁止" then
	i_tokutei_tokui_kbn	= 1
end if

// 更新部初期化
dw_list.event constructor( )

// 排他チェックいらない

// 検索実行
if dw_list.retrieve( i_syohin_iro, i_iro, i_tokutei_tokui_kbn )  = 0 then
	/*
	msg.of_error( "検索されたデータはありません。" )
	return -1
	*/
end if

of_dsp_edit( "callsection", false )
	
dw_list.setfocus()

end event

event open;call super::open;
// 初期表示
of_set_firstfocus( )

end event

event key_f12;call super::key_f12;
if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0

end event

event update_event;call super::update_event;
long ll_row, ll_rowcount, li_delete_flg

string ls_operation_type
any la_operations[]

any la_current_op[]
string ls_log_message

// 動的sql使わない場合はいらない
string ls_sql, ls_values
long ll_count

// DataWindow の行数を取得
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
            dw_list.object.syohin_code[ll_row] = i_syohin_iro
            dw_list.object.iro_no[ll_row] = i_iro
        
        case DataModified!
            ls_operation_type = "変更"
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
	la_op[1] = string(dw_list.object.syohin_code[ll_row])
	la_op[2] = string(dw_list.object.iro_no[ll_row])
	la_op[3] = trim(uo_syohin_iro.st_meisyo.text)
	la_op[4] = trim(uo_syohin_iro.st_meisyo_hin_mei.text)
	la_op[5] = trim(uo_syohin_iro.st_meisyo_iro_mei.text)
	la_op[6] = string(dw_list.object.tokui_code[ll_row])
	la_op[7] = trim(string(dw_list.object.tokui_mei[ll_row]))
	la_op[8] = st_tokutei_tokui_kbn_mei1.text
	la_op[9] = ls_operation_type
	
	la_operations[UpperBound(la_operations) + 1] = la_op
    
	dw_list.object.kahi_kbn[ll_row] = i_tokutei_tokui_kbn
next

// DataWindow の更新
if not dw_list.update(true, false) = 1 then
    rollback using cocos;
    msg.of_error_db("特定得意先商品登録マスタの登録処理でエラーが発生しました。", cocos)
    of_add_db_log("update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext)
    return -1
end if

// ログを明細ごとに出す
for ll_row = 1 to UpperBound(la_operations)
	la_current_op = la_operations[ll_row]
	ls_log_message = st_title.text + "[" + &
							string(la_current_op[1]) + " " + &
							string(la_current_op[2]) + " " + &
							string(la_current_op[3]) + " " + &
							string(la_current_op[4]) + " " + &
							string(la_current_op[5]) + " " + &
							string(la_current_op[6]) + " " + &
							string(la_current_op[7]) + " " + &
							string(la_current_op[8]) + "]" + &
							string(la_current_op[9])
    of_add_db_log("update_event", 0, ls_log_message)
next
/*
// 動的SQLを構築
ls_sql = "INSERT ALL "

ll_count = UpperBound(la_operations)

for ll_row = 1 to ll_count
    la_current_op = la_operations[ll_row]
    
    ls_log_message = st_title.text + "[" + &
                     string(la_current_op[1]) + " " + &
                     string(la_current_op[2]) + " " + &
                     string(la_current_op[3]) + " " + &
                     string(la_current_op[4]) + "]" + &
                     string(la_current_op[5])
    
    // シングルクォートのエスケープ処理
    ls_log_message = fnc.strg.of_replace(ls_log_message, "'", "''")
    
	    ls_values = "INTO d_log (seq_no, user_id, client_id, pg_id, event_id, error_code, msg) VALUES " + &
                "('" + string(ll_row - 1) + "', '" + &
                fnc.strg.of_replace(user.user_id, "'", "''") + "', '" + &
                fnc.strg.of_replace(device.name, "'", "''") + "', '" + &
                fnc.strg.of_replace(this.classname(), "'", "''") + "', " + &
                "'update_event', 0, '" + ls_log_message + "') "
    ls_sql += ls_values
next

ls_sql += "SELECT * FROM DUAL"

// SQLを実行
EXECUTE IMMEDIATE :ls_sql USING cocos;

if cocos.sqlcode <> 0 then
	rollback using cocos;
	return -1
else
end if
*/

commit using cocos;
msg.of_info(fnc.strg.of_format("{1}しました", "更新"))

// 画面初期化
of_dsp_back()

end event

event key_f02;call super::key_f02;
long l_insert_position, l_new_row
date ld_system_date

// チェックされている最初の行を探す
l_insert_position = dw_list.Find("chk = 1", 1, dw_list.RowCount())

// チェックされていたらその一つ上に、チェックが無かったら一番下に行を追加
l_new_row = dw_list.InsertRow(l_insert_position)

if l_new_row > 0 then
	// 追加成功
	dw_list.ScrollToRow(l_new_row)
	dw_list.SetRow(l_new_row)
	dw_list.SetFocus()

	ld_system_date = fnc.db.of_get_date()
	dw_list.object.str_date_inp[l_new_row] = string( date(ld_system_date), "yyyy/mm/dd" )
	dw_list.object.str_date[l_new_row] = long( string( date(ld_system_date), "yyyymmdd" ) )

	dw_list.object.end_date_inp[l_new_row] = "9999/99/99"
	dw_list.object.end_date[l_new_row] = 99999999
	return 1
else
    MessageBox("エラー", "新規行の追加に失敗しました。")
    return -1
end if

end event

event key_f03;call super::key_f03;
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
	dw_list.setredraw( false )
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
	dw_list.setredraw(true)
end if
return 0

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
long	l_row, l_str_date, l_end_date

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

//setredraw( false )
dw_list.setredraw( false )

for l_row = 1 to dw_list.rowcount()
	dw_list.setrow( l_row )

	choose case dw_list.GetItemStatus(l_row, 0, Primary!)
	case NotModified!
		continue
	end choose

	if dw_list.event itemchanged( l_row, dw_list.object.tokui_code, string( dw_list.object.tokui_code[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	if dw_list.event itemchanged( l_row, dw_list.object.houhou_kbn, string( dw_list.object.houhou_kbn[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	if dw_list.event itemchanged( l_row, dw_list.object.riyu_kbn, string( dw_list.object.riyu_kbn[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	if dw_list.event itemchanged( l_row, dw_list.object.str_date_inp, string( dw_list.object.str_date_inp[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	if dw_list.event itemchanged( l_row, dw_list.object.end_date_inp, string( dw_list.object.end_date_inp[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	l_str_date = long(dw_list.object.str_date[l_row])
	l_end_date = long(dw_list.object.end_date[l_row])
	
	if l_str_date > l_end_date then
		msg.of_error_dwo( dw_list.object.str_date_inp,  "大小関係がエラーです。" )
		dw_list.setredraw( true )
		return -1
	end if
next

dw_list.setredraw( true )
end event

event openquery;call super::openquery;
i_str	= create nv_string
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
integer height = 260
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_syohin_tokutei
integer x = 3948
integer y = 263
integer taborder = 20
end type

type dw_list from ivo_datawindow within wm_syohin_tokutei
integer y = 412
integer width = 5100
integer height = 1703
integer taborder = 30
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
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)


DataWindowChild	ldwc_houhou
DataWindowChild	ldwc_riyu
//DataWindowChild	ldwc_tuuti_lvl

long			l_row
string			l_rowid
integer		l_code_visible

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "houhou_kbn", ldwc_houhou)
ldwc_houhou.settransobject( cocos )

meisyo_kbn		= 152
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_houhou.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

// dddwより関連項目の値を取得し、画面にセットする
this.getchild( "riyu_kbn", ldwc_riyu)
ldwc_riyu.settransobject( cocos )

meisyo_kbn		= 153
meisyo_no		= 1
l_code_visible	= 0

l_row	= ldwc_riyu.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) 

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

this.reset()

this.settransobject(cocos)

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf1!, true )
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
	this.of_set_fnkey( keyf12!, true )
else
	this.of_set_fnkey( keyf1!, false )
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
	this.of_set_fnkey( keyf12!, false )
end if

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
l_file	= fnc.strg.of_format( "特定得意先商品登録_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event key_f08;call super::key_f08;
// F8:参照
choose case this.getcolumnname()
	case "tokui_code"
		// 得意先
		of_reference( this, this.object.tokui_code, this.getrow() )
end choose


return 0
end event

event itemchanged;call super::itemchanged;
string l_str_date, l_end_date

string	l_input, l_input_date
string	l_colnm
string	l_tableid	= "m_tokui_syohin"
string	l_msg

nv_master	mst
str_mtokui	l_tokui[]
str_mtokui_syohin l_tokui_syohin[]
long li_tokui, li_tokui_syohin, li_tokui_syusoku

l_input	= trim( data )
l_colnm	= dwo.tag

// 入力チェック、入力項目は全て必須、開始日と終了日はチェックしない
choose case dwo.name
//	case "tokui_code", "houhou_kbn", "riyu_kbn"
	case "tokui_code", "riyu_kbn"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case "houhou_kbn"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, 'tokui_code', l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case "str_date_inp", "end_date_inp"
		l_input_date = i_str.of_replace(l_input, "/", "")
		if not fnc.of_chk_column_info( l_input_date, false, l_colnm, l_tableid, i_str.of_replace(dwo.name,'_inp',''), l_msg ) then
			msg.of_error_dwo( dwo, l_msg )
			return 1
		end if
	case else
end choose

// 個別チェック
choose case dwo.name
	case "tokui_code"
		li_tokui = mst.of_tokui_get(long(l_input), l_tokui)
		// 早期リターンで認知負荷を下げる
		// 結果を確認、得意先がない、あるが終息
		if li_tokui = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
			return 1
		end if
		
		if l_tokui[1].syusoku_flg =1 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}が終息のため、この処理は実行できません。", describe( dwo.name + ".tag" ) ) )
			return 1
		end if
		
		// 新規行のみ、得意先商品マスタをチェックする
		choose case dw_list.GetItemStatus(row, 0, Primary!)
			case New!,NewModified!
				li_tokui_syohin = mst.of_tokui_syohin_get_full(i_syohin_iro, i_iro, long(l_input), l_tokui_syohin)
				// 結果を確認
				if li_tokui_syohin > 0 then
					if l_tokui_syohin[1].tokui_code = long(l_input) then
						msg.of_error_dwo( dwo, fnc.strg.of_format( "この{1}は既に登録されています。", describe( dwo.name + ".tag" ) ) )
						return 1
					end if
				end if
			case else
		end choose
	case "str_date_inp"
		l_str_date = fnc.db.of_date_format( l_input )
		// 2024.12.10ito歴日のみ入力可能
		if isnull( l_str_date ) or not isdate( l_str_date ) then
			msg.of_error_dwo(dwo, "不正な日付です。")
			return 1
		else
			this.object.str_date[row] 		= long( string( date(l_str_date), "yyyymmdd" ) )
			this.post setitem(row,"str_date_inp", string( date(l_str_date), "yyyy/mm/dd" ))			
		end if
	case "end_date_inp"
		// 9999/99/99と99999999を例外的に許可する
		/*
		if l_input = "9999/99/99" or l_input = "99999999" or l_input = "9" then
			this.post setitem( row, "end_date_inp", "9999/99/99" )
			this.post setitem( row, "end_date", 99999999 )
		else
			l_end_date = fnc.db.of_date_format( data )
	
			if not IsDate(l_end_date ) THEN
				return 1
			end if
			this.object.end_date[row] 		= long( string( date(l_end_date), "yyyymmdd" ) )
			this.post setitem(row,"end_date_inp", string( date(l_end_date), "yyyy/mm/dd" ))
		end if
		*/
		l_end_date = fnc.db.of_date_format( l_input )
		// 2024.12.10ito9999/99/99入力可能
		if isnull( l_end_date ) or ( not isdate( l_end_date) and l_end_date <> "9999/99/99") then
			msg.of_error_dwo(dwo, "不正な日付です。")
			return 1
		else
			if l_end_date = "9999/99/99" then
				this.post setitem( row, "end_date_inp", "9999/99/99" )
				this.post setitem( row, "end_date", 99999999 )
			else
				this.object.end_date[row] 		= long( string( date(l_end_date), "yyyymmdd" ) )
				this.post setitem(row,"end_date_inp", string( date(l_end_date), "yyyy/mm/dd" ))		
			end if
		end if
	case else
end choose

return 0

end event

type uo_syohin_iro from cv_input_syohin within wm_syohin_tokutei
event destroy ( )
integer x = 32
integer y = 153
integer width = 3980
integer taborder = 10
boolean bringtotop = true
string title_text = "商品・色"
long title_width = 630
long meisyo_width = 390
long iro_mei_width = 690
boolean arrow_visible = false
end type

on uo_syohin_iro.destroy
call cv_input_syohin::destroy
end on

event constructor;call super::constructor;//this.of_set_enabled( true )
end event

event sle_iro_input_check;call super::sle_iro_input_check;
// 変数宣言
long ll_syohin_code, ll_iro_no, li_ret, ll_tokutei_tokui_kbn, ll_syusoku_flg
string ls_size_code
str_msyohin l_syohin[]
str_mmeisyo	l_meisyo[]

if uo_syohin_iro.sle_input.text = "" then
	msg.of_error_sle(this.sle_input, "商品コード、色番が未入力です。")
	return false
end if

if uo_syohin_iro.sle_input_iro.text = "" then
	msg.of_error_sle(this.sle_input_iro, "商品コード、色番が未入力です。")
	return false
end if

// 終息のチェック
ll_syohin_code = long(uo_syohin_iro.sle_input.text)
ll_iro_no =  long(uo_syohin_iro.sle_input_iro.text)

// of_syohin_get_full関数を呼び出す
li_ret = mst.of_syohin_get_full(ll_syohin_code, ll_iro_no, '', l_syohin)

// 結果を確認
if li_ret > 0 then
	ll_tokutei_tokui_kbn = l_syohin[1].tokutei_tokui_kbn
	ll_syusoku_flg = l_syohin[1].syusoku_flg
else
	return false
end if

// 商品が終息の場合エラーメッセージ(No3)を表示する	
if ll_syusoku_flg = 1 then
	msg.of_error_sle(this.sle_input, "商品が終息のため、この処理は実行できません。")
	this.sle_input.setfocus()
	return false
else
end if

// 商品の特定得意先販売区分が1(原則許可)または(2原則禁止)ではない場合エラーメッセージ(No7)を表示する
if ll_tokutei_tokui_kbn <> 1 and ll_tokutei_tokui_kbn <> 2 then
	
	msg.of_error_sle(this.sle_input, "この商品は「原則禁止」「原則許可」いずれも設定されていません。")
	this.sle_input.setfocus()
	return false
end if

mst.of_meisyo_get( 129, string(ll_tokutei_tokui_kbn ), l_meisyo )
st_tokutei_tokui_kbn_mei1.text = l_meisyo[1].meisyo_1
st_tokutei_tokui_kbn_mei2.text = l_meisyo[1].meisyo_2

return true
end event

type st_tokutei_tokui_kbn_mei2 from sv_st_meisyo within wm_syohin_tokutei
integer x = 1056
integer y = 263
integer width = 1592
boolean bringtotop = true
long textcolor = 255
string text = "tokutei_tokui_kbn_mei2"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type st_tokutei_tokui_kbn_mei1 from sv_st_meisyo within wm_syohin_tokutei
integer x = 680
integer y = 263
integer width = 360
boolean bringtotop = true
string text = "tokutei_tokui_kbn_mei1"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type st_tokutei_tokui_kbn_label from ivo_statictext within wm_syohin_tokutei
integer x = 32
integer y = 263
integer width = 632
boolean bringtotop = true
long backcolor = 12632256
string text = "特定得意先販売区分"
alignment alignment = right!
end type

