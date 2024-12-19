$PBExportHeader$wmm_menu.srw
$PBExportComments$メニュー登録
forward
global type wmm_menu from iw_main_window
end type
type dw_list from ivo_datawindow within wmm_menu
end type
type st_syori_kbn from ivo_statictext within wmm_menu
end type
type ddplb_syori_kbn from sv_ddplb_syori within wmm_menu
end type
type uo_menu from cv_input_menu within wmm_menu
end type
type uo_tab from cv_input_tab within wmm_menu
end type
end forward

global type wmm_menu from iw_main_window
string title = "メニュー登録"
windowdockstate windowdockstate = windowdockstatetabbedwindow!
dw_list dw_list
st_syori_kbn st_syori_kbn
ddplb_syori_kbn ddplb_syori_kbn
uo_menu uo_menu
uo_tab uo_tab
end type
global wmm_menu wmm_menu

type variables
private:
	
	// 呼出し部の情報を保管
	string	i_syori_kbn
	string	i_menu_id
	string	i_tab_id




end variables

forward prototypes
public subroutine of_dsp_back ()
public subroutine of_dsp_reset ()
public subroutine of_dsp_edit (string p_control, boolean p_enabled)
public function boolean of_record_lock (boolean p_lock)
end prototypes

public subroutine of_dsp_back ();
of_dsp_edit( "callsection", true )
dw_list.event constructor( )

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_reset ();
string	l_syori_kbn

l_syori_kbn	= ddplb_syori_kbn.text

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
dw_list.event constructor( )
ddplb_syori_kbn.event constructor( )
cb_retrieve.event constructor( )
// csf
uo_menu.event constructor( )
uo_tab.event constructor( )

// 元の選択中だった処理区分を再セット
ddplb_syori_kbn.text	= l_syori_kbn

of_set_secondfocus( )

end subroutine

public subroutine of_dsp_edit (string p_control, boolean p_enabled);
long	l_row

choose case p_control
	case "callsection"
		ddplb_syori_kbn.enabled	= p_enabled
		cb_retrieve.enabled		= p_enabled
		uo_menu.of_set_enabled( p_enabled )
		uo_tab.of_set_enabled( p_enabled )

	case "dw_list"
		if dw_list.rowcount() > 0 then
			dw_list.enabled		= p_enabled
			dw_list.setrow( l_row )
			dw_list.setcolumn( "window_id" )
			dw_list.setfocus()
	 	else
			msg.of_error( "編集可能な行がありません。" )
		end if

end choose

end subroutine

public function boolean of_record_lock (boolean p_lock);
// 悲観ロック＆ロック解除関数

if p_lock then
	// ロック
	if lck.of_menu_lock( i_pg_id, i_menu_id, i_tab_id ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
else
	// アンロック
	if lck.of_menu_unlock( i_pg_id, i_menu_id, i_tab_id ) then
		commit using cocos;  // commitは子孫側で行う
	else
		return false
	end if
end if
	
// 
uo_signal.of_on_signal( p_lock )


return true
end function

on wmm_menu.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_syori_kbn=create st_syori_kbn
this.ddplb_syori_kbn=create ddplb_syori_kbn
this.uo_menu=create uo_menu
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_syori_kbn
this.Control[iCurrent+3]=this.ddplb_syori_kbn
this.Control[iCurrent+4]=this.uo_menu
this.Control[iCurrent+5]=this.uo_tab
end on

on wmm_menu.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.st_syori_kbn)
destroy(this.ddplb_syori_kbn)
destroy(this.uo_menu)
destroy(this.uo_tab)
end on

event closequery;call super::closequery;
// ロック解除はconstructorでやっちゃう
if uo_signal.of_get_status() then
	dw_list.event constructor( )
end if

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

event open;call super::open;
// 初期表示
of_set_firstfocus( )
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

// 呼出部
// 1行目
ddplb_syori_kbn.y	= st_second_upper.y + code.MGN_UPPER_TATE			// 1行目「MGN_UPPER_TATE:21」
st_syori_kbn.y		= st_second_upper.y + code.MGN_UPPER_TATE + 7		// タイトル「+7」
// 2行目
uo_menu.y		= ddplb_syori_kbn.y + 89 + code.MGN_UPPER_TATE_GAP	// 2行目「MGN_UPPER_TATE_GAP:11」
uo_tab.y		= uo_menu.y

// st_second_upper高さ
st_second_upper.height	= uo_menu.y + uo_menu.height + code.MGN_UPPER_TATE - st_second_upper.y
// 表示ボタン
cb_retrieve.y			= ( st_second_upper.y + st_second_upper.height ) - ( cb_retrieve.height + code.MGN_UPPER_TATE )

dw_list.y			= st_second_upper.y + st_second_upper.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= key_fnc.y - code.MGN_TATE - dw_list.y


end event

event retrieve_check;call super::retrieve_check;
// リトリーブ前の事前チェック
// 入力チェック
if not uo_menu.event sle_input_check( ) then
	return -1
end if
if not uo_tab.event sle_input_check( ) then
	return -1
end if

end event

event retrieve_event;call super::retrieve_event;
long	l_row
int		l_button_no


// 検索用に入力された情報をインスタンス変数へ格納する（ボタン押下後はこの変数で処理を進める）
i_syori_kbn	= ddplb_syori_kbn.text
// ユーザーオブジェクトより
i_menu_id	= uo_menu.of_get_menu_id()
i_tab_id	= uo_tab.of_get_tab_id()

choose case i_syori_kbn
	case "登録"
		// 45行固定で追加
		for l_row = 1 to 45
			dw_list.insertrow(0)
			dw_list.object.button_no[l_row]		= l_row
			dw_list.object.menu_id[l_row]		= i_menu_id
			dw_list.object.tab_id[l_row]		= i_tab_id
			dw_list.object.window_id[l_row]		= ""
		next
	case "変更", "削除"
		// 排他チェック
		if not of_record_lock( true ) then
			setredraw( true )
			return -1
		end if
		// 検索実行
		if dw_list.retrieve( i_menu_id,i_tab_id ) = 0 then
			msg.of_error( "入力したメニューID、タブIDで登録されたデータはありません。" )
			uo_menu.setfocus()
			return -1
		end if
	case "照会"
		// 検索実行
		if dw_list.retrieve( i_menu_id,i_tab_id ) = 0 then
			msg.of_error( "入力したメニューID、タブIDで登録されたデータはありません。" )
			uo_menu.setfocus()
			return -1
		end if
end choose

// 照会以外は呼出部ロック
if i_syori_kbn <> "照会" then
	of_dsp_edit( "callsection", false )
end if
// 入力部
of_dsp_edit( "dw_list", true )

// 一旦フォーカスを明細部へ
dw_list.setfocus()


end event

event update_check;call super::update_check;
long	l_row

// DWの入力規則チェック
if dw_list.accepttext() <> 1 then
	return -1
end if

setredraw( false )

for l_row = 1 to dw_list.rowcount()

	dw_list.setrow( l_row )

	if dw_list.event itemchanged( l_row, dw_list.object.window_id, dw_list.object.window_id[l_row] ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.siyo_kanou_flg, string( dw_list.object.siyo_kanou_flg[l_row] ) ) <> 0 then
		setredraw( true )
		return -1
	end if
	
	if dw_list.event itemchanged( l_row, dw_list.object.param, dw_list.object.param[l_row] ) <> 0 then
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
	case "登録", "変更"

		// 更新 ( accepttext実行、更新フラグはリセットしない )
//		if not dw_list.update( true, false ) = 1 then
		if dw_list.update( true, false ) <> 1 then
			rollback using cocos;
			msg.of_error_db( "メニューマスタの更新処理でエラーが発生しました。", cocos )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return -1
		end if
		// 排他解除
		
		// ログ出力
		of_add_db_log( "update_event", 0, st_title.text + "[" + uo_menu.of_get_menu_id() + " " +  uo_tab.of_get_tab_id() + "]" + i_syori_kbn )

	case "削除"

		delete from m_menu
		 where menu_id	= :i_menu_id
		   and tab_id	= :i_tab_id
		using cocos;
		
		if cocos.sqlcode <> 0 then
			rollback using cocos;
			msg.of_error_db( "メニューマスタの削除処理でエラーが発生しました。", cocos )
			of_add_db_log( "update_event", cocos.last_sqlerrcode, cocos.last_sqlerrtext )
			return -1
		end if

		// ログ出力
		of_add_db_log( "update_event", 0, st_title.text + "[" + uo_menu.of_get_menu_id() + " " +  uo_tab.of_get_tab_id() + "]" + i_syori_kbn )


	case "照会"
		// 処理なし
end choose

msg.of_info( fnc.strg.of_format( "{1}しました", i_syori_kbn ) )

commit using cocos;

// 画面初期化
of_dsp_back()

end event

type uo_signal from iw_main_window`uo_signal within wmm_menu
end type

type st_date from iw_main_window`st_date within wmm_menu
integer height = 75
end type

type st_user_mei from iw_main_window`st_user_mei within wmm_menu
integer height = 75
end type

type uo_test_mode from iw_main_window`uo_test_mode within wmm_menu
end type

type p_size_adjust from iw_main_window`p_size_adjust within wmm_menu
end type

type st_title from iw_main_window`st_title within wmm_menu
end type

type st_title_upper from iw_main_window`st_title_upper within wmm_menu
end type

type st_upper from iw_main_window`st_upper within wmm_menu
end type

type st_second_upper from iw_main_window`st_second_upper within wmm_menu
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wmm_menu
integer taborder = 40
integer textsize = -11
fontcharset fontcharset = shiftjis!
end type

event constructor;call super::constructor;
this.enabled	= true
end event

type dw_list from ivo_datawindow within wmm_menu
integer y = 384
integer width = 5120
integer height = 2034
integer taborder = 50
boolean bringtotop = true
string dataobject = "dmm_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f5_key = true
boolean f6_key = true
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
boolean sf9_key = true
boolean sf10_key = true
boolean sf12_key = true
boolean row_focus_ind = true
boolean rbutton_menu = true
end type

event constructor;call super::constructor;
long	l_row
int		l_button_no

// 先頭行を取得
l_row		= long( this.object.datawindow.firstrowonpage )

choose case i_syori_kbn
	case "変更", "削除"

		if l_row > 0 then
			if not of_record_lock( false ) then
				return -1
			end if
		end if
		
end choose

// 参照ボタン設定
this.i_function_name	= { "", "", "", "", "Excel出力", "", "", "参照", "", "", "", "" }

this.reset()
this.settransobject(cocos)

this.enabled	= false

// 横スクロールを一番左に移動
this.object.datawindow.horizontalscrollposition = 0

end event

event getfocus;call super::getfocus;
if this.rowcount() > 0 then
	this.of_set_fnkey( keyf5!, true )
	this.of_set_fnkey( keyf6!, true )
else
	this.of_set_fnkey( keyf5!, false )
	this.of_set_fnkey( keyf6!, false )
end if

choose case i_syori_kbn
	case "登録","変更","削除"
		this.of_set_fnkey( keyf12!, true )
		return
end choose

this.of_set_fnkey( keyf12!, false )

end event

event key_f05;call super::key_f05;
string	l_file

// フルパスで入れれば保存先フォルダが指定可能
l_file	= fnc.strg.of_format( "メニューマスタ_{1}_{2}", string( today(), "yyyymmdd" ), string( now(), "hhmmss" ) )

if not of_saveas_excel( l_file ) then
	return -1
end if

return 0
end event

event itemchanged;call super::itemchanged;

DataWindowChild	ldwc
long	l_row
string	l_input
string	l_colnm
string	l_tableid	= "m_menu"
string	l_msg
string	l_window_id

choose case dwo.name
	case "window_id"
		// null回避
		if isnull( this.object.window_id[row] )  then
			l_window_id	= " "
		else
			l_window_id	= this.object.window_id[row] 
		end if
		
		if l_window_id <> data then
			// dddwより関連項目の値を取得し、画面にセットする
			this.getchild( "window_id", ldwc)
			// 参照からの呼出対応
			l_row	= ldwc.find( "window_id ='" + data + "'", 1, ldwc.rowcount() )
			this.object.window_name[row]	= ldwc.getitemstring( l_row, "window_name" )
			this.object.kengen_kbn_mei[row]	= ldwc.getitemstring( l_row, "kengen_kbn_mei" )

			if len( trim( ldwc.getitemstring( l_row, "window_name" ) ) ) > 1 then
				this.object.siyo_kanou_flg[row]	= 1
			else
				this.object.siyo_kanou_flg[row]	= 0
			end if
		end if	

	case "param"
		
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

event key_f08;call super::key_f08;
long	l_row

str_mdlpara_mwindow	l_mdl_window


if this.rowcount() = 0 then
	return 0
end if

l_row	= this.getrow()

// F8:参照
choose case this.getcolumnname()
	case "window_id"

	// モーダルを開く
	l_mdl_window	= mdl.of_open_modal( "wsm_window", l_mdl_window )
	// 値をセット
	if upperbound( l_mdl_window.ret ) > 0 then
		// 値をセット＆Itemchanged実行 ※DDDWとの兼用なので特別
		if this.event itemchanged( l_row, this.object.window_id, l_mdl_window.ret[1].window_id ) <> 0 then
			return -1
		end if
		this.object.window_id[l_row]	= l_mdl_window.ret[1].window_id
	end if

end choose


return 0
end event

type st_syori_kbn from ivo_statictext within wmm_menu
integer x = 32
integer y = 167
boolean bringtotop = true
long backcolor = 12632256
string text = "処理区分"
alignment alignment = right!
end type

type ddplb_syori_kbn from sv_ddplb_syori within wmm_menu
integer x = 348
integer y = 153
integer width = 240
integer taborder = 10
boolean bringtotop = true
boolean f9_key = true
boolean f10_key = true
string init_disp = "照会"
end type

event constructor;call super::constructor;

this.enabled			= true
setnull( i_syori_kbn )

// selectionchangedを呼び出す
this.event selectionchanged( i_idx )


end event

event selectionchanged;call super::selectionchanged;
string	l_syori
 
l_syori	= trim( this.text )
 
// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
//		uo_menu.of_set_dbchk_dupe( )
		uo_tab.of_set_dbchk_dupe( )
	case "変更", "削除", "照会"
		// 存在チェックをする
		uo_menu.of_set_dbchk_exst( )
		uo_tab.of_set_dbchk_exst( )
	case else
		// 何もしない
end choose
end event

type uo_menu from cv_input_menu within wmm_menu
integer x = 32
integer y = 252
integer width = 1536
integer taborder = 20
boolean bringtotop = true
boolean chk_required = true
long input_width = 1208
long bikou_width = 0
end type

on uo_menu.destroy
call cv_input_menu::destroy
end on

event constructor;call super::constructor;
this.of_set_enabled( true )

end event

type uo_tab from cv_input_tab within wmm_menu
event destroy ( )
integer x = 1600
integer y = 249
integer width = 816
integer taborder = 30
boolean bringtotop = true
boolean chk_required = true
long title_width = 168
long input_width = 488
long bikou_width = 0
end type

on uo_tab.destroy
call cv_input_tab::destroy
end on

event constructor;call super::constructor;
this.of_set_enabled( true )

end event

