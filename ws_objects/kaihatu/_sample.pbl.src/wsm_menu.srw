$PBExportHeader$wsm_menu.srw
$PBExportComments$メニュー検索のモーダル
forward
global type wsm_menu from iw_modal_window
end type
type sle_menu_id from ivo_singlelineedit within wsm_menu
end type
type st_menu_id from ivo_statictext within wsm_menu
end type
end forward

global type wsm_menu from iw_modal_window
integer height = 1604
string title = "メニュー検索"
integer dw_height = 1383
integer dw_width = 1838
sle_menu_id sle_menu_id
st_menu_id st_menu_id
end type
global wsm_menu wsm_menu

type variables

public:
	str_dpara			i_dpara	// 親ウインドウとの受け渡し用構造体

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

on wsm_menu.create
int iCurrent
call super::create
this.sle_menu_id=create sle_menu_id
this.st_menu_id=create st_menu_id
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_menu_id
this.Control[iCurrent+2]=this.st_menu_id
end on

on wsm_menu.destroy
call super::destroy
destroy(this.sle_menu_id)
destroy(this.st_menu_id)
end on

event update_event;call super::update_event;
long	l_row

l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る
dw_list.rowscopy( l_row, l_row, Primary!, i_dpara.ds, 1, Primary! )	// visible = trueのときは1レコードだけ返す

closewithreturn( this, i_dpara )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_dpara	= i_msgparm.powerobjectparm
end event

event resize;call super::resize;
// sle_menu
sle_menu_id.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_menu
st_menu_id.y		= sle_menu_id.y + sle_menu_id.height / 2 - st_menu_id.height / 2
st_menu_id.x		= dw_list.x

sle_menu_id.x		= st_menu_id.x + st_menu_id.width + code.MGN_GROUP_YOKO

sle_menu_id.width	= cb_retrieve.x - sle_menu_id.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= sle_menu_id.y
end event

event open;call super::open;
sle_menu_id.setfocus()
end event

event retrieve_event;call super::retrieve_event;
datastore	l_ds
string		l_fil_reset[]
long		l_row

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
i_menu_id	= trim( sle_menu_id.text )

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
		sle_menu_id.setfocus()
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

l_menu_id	= trim( sle_menu_id.text )

if len( l_menu_id ) = 0 then
	setnull( i_menu_id )
end if

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_menu
end type

type st_date from iw_modal_window`st_date within wsm_menu
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_menu
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_menu
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_menu
end type

type st_title from iw_modal_window`st_title within wsm_menu
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_menu
end type

type st_upper from iw_modal_window`st_upper within wsm_menu
end type

type st_tail from iw_modal_window`st_tail within wsm_menu
integer y = 1412
end type

type cb_ok from iw_modal_window`cb_ok within wsm_menu
integer y = 1433
integer taborder = 40
end type

event clicked;call super::clicked;
//parent.i_tab_string	= i_menu_string
end event

type cb_cancel from iw_modal_window`cb_cancel within wsm_menu
integer y = 1433
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_menu
integer x = 12
integer y = 338
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
end type

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_menu_id.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_menu
integer x = 1428
integer y = 164
integer taborder = 20
end type

type sle_menu_id from ivo_singlelineedit within wsm_menu
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "メニューIDを入力してください"
end type

type st_menu_id from ivo_statictext within wsm_menu
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "メニューID"
alignment alignment = right!
end type

