$PBExportHeader$wsm_tab.srw
$PBExportComments$タブ検索のモーダル
forward
global type wsm_tab from iw_modal_window
end type
type uo_menu from cv_input_menu within wsm_tab
end type
end forward

global type wsm_tab from iw_modal_window
integer height = 1604
string title = "タブ検索"
boolean immediate_retrieve = false
integer dw_height = 1382
integer dw_width = 1846
uo_menu uo_menu
end type
global wsm_tab wsm_tab

type variables

public:
	str_dpara			i_dpara		// 親ウインドウとの受け渡し用構造体

private:
	nv_data_container	con
	string				i_menu_id	// retrieveに使うパラメータ用
end variables

forward prototypes
public function datastore of_get_data (string p_dwo, str_dpara p_dpara)
end prototypes

public function datastore of_get_data (string p_dwo, str_dpara p_dpara);
// data_containerのof_get_dataを呼び出してdatastoreをreturnする 先祖化した方がよいのでは?

datastore	l_ds_ret

l_ds_ret	= con.of_get_data( p_dwo, p_dpara )

return l_ds_ret
end function

on wsm_tab.create
int iCurrent
call super::create
this.uo_menu=create uo_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_menu
end on

on wsm_tab.destroy
call super::destroy
destroy(this.uo_menu)
end on

event update_event;call super::update_event;long	l_row

l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る
dw_list.rowscopy( l_row, l_row, Primary!, i_dpara.ds, 1, Primary! )	// visible = trueのときは1レコードだけ返す

closewithreturn( this, i_dpara )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_dpara	= i_msgparm.powerobjectparm

// inパラメータがあるかチェック  immediate_retrieveがtrueのときはopenqueryに書かないと値がセットされない
if upperbound( i_dpara.in_para ) <> 0 then
	immediate_retrieve	= true					// メニューIDがセットされているときだけ自動検索する
	
	uo_menu.of_set_input( i_dpara.in_para[1] )	// メニューIDをsleにセット
	uo_menu.event sle_input_check()				// sleに入った値をチェックする
end if
end event

event resize;call super::resize;
// uo_menu
uo_menu.y		= st_upper.y + st_upper.height + code.MGN_TATE
uo_menu.x		= dw_list.x

uo_menu.width	= cb_retrieve.x - uo_menu.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= uo_menu.y


end event

event open;call super::open;
uo_menu.setfocus()

return 0
end event

event retrieve_event;call super::retrieve_event;
datastore	l_ds
string		l_fil_reset[]
long		l_row

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
i_menu_id	= trim( uo_menu.of_get_input( ) )

dw_list.reset()
i_dpara.where_string	= l_fil_reset	// 毎回リセットしないと同じ条件が何度もwhere句に追加される

// データ取得時にmultiple=false(単一)で結果が複数返ってきたら、その返ってきたdatastoreをモーダルで表示し、レコードを選択させる
if not i_dpara.visibled then
	l_ds	= i_dpara.ds	// visibledがfalseなら、データ取得を経由しておりデータを持っているので、i_dpara.dsをそのままl_ds経由でdw_listにrowscopyする
else
	// retrieveの検索引数にあたるwhere句を生成して、of_get_dataに渡す
	// DWのwhere句は最低限しか書いておらず、検索引数は手で書く必要がある
	// メニューIDのシングルラインエディット
	if i_menu_id <> "" then
		// ここなかったらimmediate_retrieve(自動検索)でi_dpara.where_string[1]に""が格納されてしまう
		i_dpara.where_string[upperbound( i_dpara.where_string ) + 1]	= mdl.of_sqlmake_where( "menu_id", "like", i_menu_id )
	end if

	l_ds	= of_get_data( dw_list.dataobject, i_dpara )	// このof_get_dataはwindowの関数(先祖化したほうが良い?)
	
	if l_ds.rowcount( ) <= 0 then
		msg.of_error( "入力されたメニューIDはマスタに存在しません。" )
		uo_menu.setfocus()
		return -1
	end if
end if

l_row	= l_ds.rowcount()
l_ds.rowscopy( 1, l_row, Primary!, dw_list, 1, Primary! )

dw_list.setfocus()

return 0
end event

event retrieve_check;call super::retrieve_check;
string	l_menu_id

l_menu_id	= trim( uo_menu.of_get_input() )

if len( l_menu_id ) = 0 then
	setnull( i_menu_id )
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_tab
end type

type st_date from iw_modal_window`st_date within wsm_tab
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_tab
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_tab
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_tab
end type

type st_title from iw_modal_window`st_title within wsm_tab
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_tab
end type

type st_upper from iw_modal_window`st_upper within wsm_tab
end type

type st_tail from iw_modal_window`st_tail within wsm_tab
integer y = 1412
end type

type cb_ok from iw_modal_window`cb_ok within wsm_tab
integer y = 1433
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_tab
integer y = 1433
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_tab
integer x = 12
integer y = 338
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_tab"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
end type

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
uo_menu.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_tab
integer x = 1724
integer y = 181
integer taborder = 20
end type

type uo_menu from cv_input_menu within wsm_tab
event destroy ( )
integer x = 16
integer y = 171
integer width = 1616
integer taborder = 30
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_menu.destroy
call cv_input_menu::destroy
end on

