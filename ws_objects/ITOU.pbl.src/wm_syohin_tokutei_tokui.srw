﻿$PBExportHeader$wm_syohin_tokutei_tokui.srw
$PBExportComments$特定得意先商品登録（得意先別）
forward
global type wm_syohin_tokutei_tokui from iw_main_window
end type
type uo_tokui from cv_input_tokui within wm_syohin_tokutei_tokui
end type
type st_kahi_kbn_mei from sv_st_meisyo within wm_syohin_tokutei_tokui
end type
type dw_list from ivo_datawindow within wm_syohin_tokutei_tokui
end type
type ddplb_kahi_kbn from sv_ddplb_meisyo within wm_syohin_tokutei_tokui
end type
type st_kahi_kbn_t from ivo_statictext within wm_syohin_tokutei_tokui
end type
type st_tanto_t from ivo_statictext within wm_syohin_tokutei_tokui
end type
type st_tanto_code from sv_st_meisyo within wm_syohin_tokutei_tokui
end type
type st_tanto_mei from sv_st_meisyo within wm_syohin_tokutei_tokui
end type
type str_check from structure within wm_syohin_tokutei_tokui
end type
end forward

type str_check from structure
	string		syohin_code
	string		iro_no
end type

global type wm_syohin_tokutei_tokui from iw_main_window
string title = "特定得意先商品登録（得意先別）"
windowdockstate windowdockstate = windowdockstatefloating!
uo_tokui uo_tokui
st_kahi_kbn_mei st_kahi_kbn_mei
dw_list dw_list
ddplb_kahi_kbn ddplb_kahi_kbn
st_kahi_kbn_t st_kahi_kbn_t
st_tanto_t st_tanto_t
st_tanto_code st_tanto_code
st_tanto_mei st_tanto_mei
end type
global wm_syohin_tokutei_tokui wm_syohin_tokutei_tokui

type variables
	private:

	// 呼出し部の情報を保管
	long	i_syohin_iro, i_iro, i_kahi_kbn, i_tokui_code
	// ユーザーオブジェクト
	nv_string	i_str
	nv_master	mst

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
public subroutine of_dsp_open ()
public subroutine of_dsp_reset ()
public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row)
end prototypes

public subroutine of_dsp_back ();of_dsp_edit( "callsection", true )
dw_list.event constructor( )

of_set_firstfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);long	l_row

choose case p_control
	case "callsection"
		uo_tokui.of_set_enabled( p_enabled )
		ddplb_kahi_kbn.enabled = p_enabled
		cb_retrieve.enabled		= p_enabled
end choose
end subroutine

public subroutine of_dsp_open ();long	l_indx
string	l_nendo_mei
end subroutine

public subroutine of_dsp_reset ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )
uo_tokui.event constructor( )
st_tanto_code.event constructor( )
st_tanto_mei.event constructor( )
ddplb_kahi_kbn.event constructor( )
st_kahi_kbn_mei.event constructor( )

of_set_firstfocus( )
end subroutine

public subroutine of_reference (datawindow p_dw, dwobject p_dwo, long p_row);
// 未実装あり

// 参照設定
str_mdlpara_msyohin	l_mdl_syohin

// F8:参照
choose case p_dwo.name
	case "syohin_code"
		// 部門
		l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )
		if upperbound( l_mdl_syohin.ret ) > 0 then
			dw_list.object.syohin_code[p_row]	= long( l_mdl_syohin.ret[1].syohin_code )
			dw_list.object.iro_no[p_row]	= long( l_mdl_syohin.ret[1].iro_no )
			dw_list.object.ms_hin_ban[p_row]	= string( l_mdl_syohin.ret[1].hin_ban )
			dw_list.object.ms_hin_mei[p_row]	= string( l_mdl_syohin.ret[1].hin_mei )
			dw_list.object.ms_iro_mei[p_row]	= string( l_mdl_syohin.ret[1].iro_mei )
		end if

end choose


end subroutine

on wm_syohin_tokutei_tokui.create
int iCurrent
call super::create
this.uo_tokui=create uo_tokui
this.st_kahi_kbn_mei=create st_kahi_kbn_mei
this.dw_list=create dw_list
this.ddplb_kahi_kbn=create ddplb_kahi_kbn
this.st_kahi_kbn_t=create st_kahi_kbn_t
this.st_tanto_t=create st_tanto_t
this.st_tanto_code=create st_tanto_code
this.st_tanto_mei=create st_tanto_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tokui
this.Control[iCurrent+2]=this.st_kahi_kbn_mei
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.ddplb_kahi_kbn
this.Control[iCurrent+5]=this.st_kahi_kbn_t
this.Control[iCurrent+6]=this.st_tanto_t
this.Control[iCurrent+7]=this.st_tanto_code
this.Control[iCurrent+8]=this.st_tanto_mei
end on

on wm_syohin_tokutei_tokui.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tokui)
destroy(this.st_kahi_kbn_mei)
destroy(this.dw_list)
destroy(this.ddplb_kahi_kbn)
destroy(this.st_kahi_kbn_t)
destroy(this.st_tanto_t)
destroy(this.st_tanto_code)
destroy(this.st_tanto_mei)
end on

event open;call super::open;
// 初期表示
of_set_firstfocus( )

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
uo_tokui.y	= l_row_1_y
st_tanto_t.y	= l_row_1_y
st_tanto_code.y	= l_row_1_y
st_tanto_mei.y	= l_row_1_y

// 2行目
l_row_2_y	= l_row_1_y + l_komoku_height + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
st_kahi_kbn_t.y	= l_row_2_y
ddplb_kahi_kbn.y		= l_row_2_y
st_kahi_kbn_mei.y		= l_row_2_y

// st_second_upper高さ
st_second_upper.height	= l_row_2_y + l_komoku_height + code.MGN_UPPER_TATE_GAP - st_second_upper.y

// 表示ボタン
cb_retrieve.y	= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

// dw_list
dw_list.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width	= newwidth - code.MGN_YOKO * 2
dw_list.height	= key_fnc.y - code.MGN_TATE - dw_list.y

end event

event retrieve_event;call super::retrieve_event;
// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）

i_tokui_code	= long(uo_tokui.sle_input.text)
//ddplb_kahi_kbnの値を取得
i_kahi_kbn = ddplb_kahi_kbn.of_get_code_num( )

// 更新部初期化
dw_list.event constructor( )

// 検索実行
if dw_list.retrieve( i_tokui_code )  = 0 then
	/*
	msg.of_error( "検索されたデータはありません。" )
	return -1
	*/
end if

of_dsp_edit( "callsection", false )

dw_list.setfocus()

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

for l_row = 1 to dw_list.rowcount()

		dw_list.object.chk[l_row] = l_mode

next

return 0

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
	dw_list.setredraw(false)
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

event key_f12;call super::key_f12;if not of_evt_update( 0, 0 ) then
	return -1
end if

return 0


end event

event update_event;call super::update_event;
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
			dw_list.object.tokui_code[ll_row] = i_tokui_code

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
	
	la_op[1] = i_tokui_code
	la_op[2] = trim(uo_tokui.st_meisyo.text)
	la_op[3] = trim(ddplb_kahi_kbn.text)
	la_op[4] = string(dw_list.object.syohin_code[ll_row])
	la_op[5] = string(dw_list.object.iro_no[ll_row])
	la_op[6] = trim(string(dw_list.object.ms_hin_ban[ll_row]))
	la_op[7] = trim(string(dw_list.object.ms_hin_mei[ll_row]))
	la_op[8] = trim(string(dw_list.object.ms_iro_mei[ll_row]))
	la_op[9] = ls_operation_type

	la_operations[UpperBound(la_operations) + 1] = la_op

	dw_list.object.kahi_kbn[ll_row] = ddplb_kahi_kbn.of_get_code_num()
next

if not dw_list.update( true, false ) = 1 then
	rollback using cocos;
	msg.of_error_db( "特定得意先商品登録（得意先別）マスタの登録処理でエラーが発生しました。", cocos )
	of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
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

commit using cocos;
msg.of_info( fnc.strg.of_format( "{1}しました", "更新" ) )

// 画面初期化
of_dsp_back()
end event

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
end if

end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック

// 入力チェック
if not uo_tokui.event sle_input_check( ) then
	return -1
end if

if ddplb_kahi_kbn.text = "" then
//	msg.of_error_sle(ddplb_kahi_kbn.?, "可否区分が未入力です。")
	msg.of_error("可否区分が未入力です。")
	st_kahi_kbn_mei.text = ""
	return -1
end if
end event

event update_check;call super::update_check;
long	l_row, l_str_date, l_end_date
str_check l_check[]
long l_array_idx, l_check_idx
// 配列を作って、商品コードと色番を入れていく。
// その配列を見て、データウィンドウ内で重複があるかどうかチェックしたい
// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

dw_list.setredraw( false )


for l_row = 1 to dw_list.rowcount()

	choose case dw_list.GetItemStatus(l_row, 0, Primary!)
	case NotModified!
		dw_list.setredraw( true )
		continue
	end choose

	dw_list.setrow( l_row )
	if dw_list.event itemchanged( l_row, dw_list.object.syohin_code, string( dw_list.object.syohin_code[l_row] ) ) <> 0 then
		dw_list.setredraw( true )
		return -1
	end if
	if dw_list.event itemchanged( l_row, dw_list.object.iro_no, string( dw_list.object.iro_no[l_row] ) ) <> 0 then
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
		msg.of_error_dwo( dw_list.object.str_date_inp,  "大小関係がエラーです。")
		dw_list.setredraw( true )
		return -1
	end if
	// 配列のインデックスを増やす
	l_array_idx++
	// 構造体配列に値を格納
	l_check[l_array_idx].syohin_code = string(dw_list.object.syohin_code[l_row])
	l_check[l_array_idx].iro_no = string(dw_list.object.iro_no[l_row])
	
	// 重複チェック
    for l_check_idx = 1 to l_array_idx - 1
        // 商品コードと色番の組み合わせが一致するかチェック
        if l_check[l_check_idx].syohin_code = l_check[l_array_idx].syohin_code and &
           l_check[l_check_idx].iro_no = l_check[l_array_idx].iro_no then
            // 重複エラーメッセージ
            msg.of_error_dwo(dw_list.object.syohin_code, "登録しようとしているデータはすでに登録されています。")
      		dw_list.setredraw( true )
            return -1
        end if
    next
next

dw_list.setredraw( true )

end event

event openquery;call super::openquery;i_str	= create nv_string
end event

type uo_signal from iw_main_window`uo_signal within wm_syohin_tokutei_tokui
end type

type st_date from iw_main_window`st_date within wm_syohin_tokutei_tokui
end type

type st_user_mei from iw_main_window`st_user_mei within wm_syohin_tokutei_tokui
end type

type uo_test_mode from iw_main_window`uo_test_mode within wm_syohin_tokutei_tokui
end type

type p_size_adjust from iw_main_window`p_size_adjust within wm_syohin_tokutei_tokui
end type

type st_title from iw_main_window`st_title within wm_syohin_tokutei_tokui
end type

type st_title_upper from iw_main_window`st_title_upper within wm_syohin_tokutei_tokui
end type

type st_upper from iw_main_window`st_upper within wm_syohin_tokutei_tokui
end type

type st_second_upper from iw_main_window`st_second_upper within wm_syohin_tokutei_tokui
integer x = 8
integer y = 132
integer height = 260
end type

type cb_retrieve from iw_main_window`cb_retrieve within wm_syohin_tokutei_tokui
integer x = 3836
integer y = 263
integer taborder = 30
end type

type uo_tokui from cv_input_tokui within wm_syohin_tokutei_tokui
string tag = "得意先"
integer x = 64
integer y = 153
integer taborder = 10
boolean bringtotop = true
boolean f4_key = false
long title_width = 330
end type

on uo_tokui.destroy
call cv_input_tokui::destroy
end on

event sle_input_check;call super::sle_input_check;long ll_tokui_code, li_ret, ll_syusoku_flg, ll_tanto_code
string ll_tanto_mei
str_mtokui lstr_tokui[]
str_mtanto lstr_tanto[]

if uo_tokui.sle_input.text = "" then
	msg.of_error_sle(this.sle_input, "得意先コードが未入力です。")
	return false
end if

// 終息のチェックどう書いたらいい？i_dbchk_modeの分岐によって書けたらラク？
ll_tokui_code = long(uo_tokui.sle_input.text)

// of_tokui_get関数を呼び出す
li_ret = mst.of_tokui_get(ll_tokui_code,lstr_tokui)

// 結果を確認
if li_ret > 0 then
	ll_syusoku_flg = lstr_tokui[1].syusoku_flg
	ll_tanto_code = lstr_tokui[1].tanto_code
else
end if

// 得意先が終息の場合エラーメッセージ(No3)を表示する

if ll_syusoku_flg = 1 then
	msg.of_error("得意先が終息のため、この処理は実行できません。")
	this.sle_input.setfocus()
	return false
end if

li_ret = mst.of_tanto_get(ll_tanto_code,lstr_tanto)

// 結果を確認
if li_ret > 0 then
	ll_tanto_mei = lstr_tanto[1].tanto_mei
else
end if

st_tanto_code.text = string(ll_tanto_code)
st_tanto_mei.text = ll_tanto_mei

return true
end event

type st_kahi_kbn_mei from sv_st_meisyo within wm_syohin_tokutei_tokui
integer x = 888
integer y = 270
integer width = 2500
boolean bringtotop = true
string text = "kahi_mei"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type dw_list from ivo_datawindow within wm_syohin_tokutei_tokui
integer x = 12
integer y = 412
integer width = 5100
integer height = 1703
integer taborder = 40
boolean bringtotop = true
string dataobject = "dm_syohin_tokutei_tokui"
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

event itemchanged;call super::itemchanged;
string l_str_date, l_end_date, l_input_date

long l_syohin_code, l_iro_no, l_tokui_code, l_syusoku_flg

string	l_input
string	l_colnm
string	l_tableid	= "m_tokui_syohin"
string	l_msg

nv_master	mst
str_mtokui	l_tokui[]
str_msyohin	l_syohin[]
str_mtokui_syohin l_tokui_syohin[]
long li_syohin, li_tokui_syohin

l_input	= trim( data )
l_colnm	= dwo.tag

// 入力チェック
choose case dwo.name
		case "syohin_code", "iro_no", "houhou_kbn", "riyu_kbn"
		if not fnc.of_chk_column_info( l_input, false, l_colnm, l_tableid, dwo.name, l_msg ) then
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

	case "syohin_code"
		// l_syohin_code = long(trim(data))
	case "iro_no"
		l_syohin_code = dw_list.Object.syohin_code[row]
		li_syohin = mst.of_syohin_get_full(l_syohin_code, long(l_input), l_syohin)
		
		if li_syohin = 0 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "入力された{1}はマスタに存在しません。", describe( dwo.name + ".tag" ) ) )
			return 1
		end if
		
		if i_kahi_kbn = 1 and l_syohin[1].tokutei_tokui_kbn =2 then
			msg.of_error_dwo( dwo, "この商品は「原則禁止」設定されていない商品です。")
			return 1
		elseif i_kahi_kbn = 2 and l_syohin[1].tokutei_tokui_kbn =1 then
			msg.of_error_dwo( dwo, "この商品は「原則許可」設定されていない商品です。")
			return 1
		end if
		
		dw_list.object.ms_hin_ban[row] = l_syohin[1].hin_ban
		dw_list.object.ms_hin_mei[row] = l_syohin[1].hin_mei
		dw_list.object.ms_iro_mei[row] = l_syohin[1].iro_mei
		
		if l_syohin[1].syusoku_flg =1 then
			msg.of_error_dwo( dwo, fnc.strg.of_format( "{1}が終息のため、この処理は実行できません。", describe( dwo.name + ".tag" ) ) )
			return 1
		end if

		choose case dw_list.GetItemStatus(row, 0, Primary!)
			case New!,NewModified!
				li_tokui_syohin = mst.of_tokui_syohin_get_full(l_syohin_code, long(l_input), i_tokui_code, l_tokui_syohin)
				// 結果を確認
				if li_tokui_syohin > 0 then
					if l_tokui_syohin[1].tokui_code = i_tokui_code and l_tokui_syohin[1].iro_no = long(l_input) then
						msg.of_error_dwo( dwo, "登録しようとしているデータはすでに登録されています。") 
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
l_file	= fnc.strg.of_format( "特定得意先商品登録（得意先別）_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event key_f08;call super::key_f08;
// F8:参照
choose case this.getcolumnname()
	case "syohin_code"
		// 得意先
		of_reference( this, this.object.syohin_code, this.getrow() )
end choose


return 0
end event

type ddplb_kahi_kbn from sv_ddplb_meisyo within wm_syohin_tokutei_tokui
string tag = "可否区分"
integer x = 412
integer y = 270
integer width = 460
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
boolean f9_key = true
boolean f10_key = true
integer meisyo_kbn = 128
string init_code = "0"
boolean enabled_null = true
end type

event selectionchanged;call super::selectionchanged;
string kahi_kbn_meisyo_2
long l_kahi_kbn, li_ret
str_mmeisyo lstr_meisyo[]

if this.text = "" then
//	msg.of_error_sle(ddplb_kahi_kbn.?, "可否区分が未入力です。")
	msg.of_error("可否区分が未入力です。")
	st_kahi_kbn_mei.text = ""
	return 0
end if

l_kahi_kbn = this.of_get_code_num( )
li_ret = mst.of_meisyo_get(128, string(l_kahi_kbn), lstr_meisyo)
if li_ret > 0 then
	kahi_kbn_meisyo_2 = lstr_meisyo[1].meisyo_2
else
end if

if l_kahi_kbn = 1 then
	st_kahi_kbn_mei.text = kahi_kbn_meisyo_2
else
	st_kahi_kbn_mei.text = kahi_kbn_meisyo_2
end if

end event

event constructor;call super::constructor;
this.text = ""

end event

type st_kahi_kbn_t from ivo_statictext within wm_syohin_tokutei_tokui
integer x = 64
integer y = 270
integer width = 332
boolean bringtotop = true
long backcolor = 12632256
string text = "可否区分"
alignment alignment = right!
end type

type st_tanto_t from ivo_statictext within wm_syohin_tokutei_tokui
integer x = 2388
integer y = 153
integer width = 272
boolean bringtotop = true
long backcolor = 12632256
string text = "担当者"
alignment alignment = right!
end type

type st_tanto_code from sv_st_meisyo within wm_syohin_tokutei_tokui
integer x = 2676
integer y = 153
integer width = 400
boolean bringtotop = true
string text = "tanto_code"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event

type st_tanto_mei from sv_st_meisyo within wm_syohin_tokutei_tokui
integer x = 3092
integer y = 153
integer width = 800
boolean bringtotop = true
string text = "tanto_mei"
end type

event constructor;call super::constructor;// 初期状態
this.text	= ""

end event
