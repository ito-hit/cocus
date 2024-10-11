$PBExportHeader$wsm_tanto.srw
$PBExportComments$営業担当者検索のモーダル
forward
global type wsm_tanto from iw_modal_window
end type
type st_tanto_mei from ivo_statictext within wsm_tanto
end type
type sle_tanto_mei from ivo_singlelineedit within wsm_tanto
end type
type cbx_haiban_flg from ivo_checkbox within wsm_tanto
end type
end forward

global type wsm_tanto from iw_modal_window
integer height = 2297
string title = "営業担当者検索"
st_tanto_mei st_tanto_mei
sle_tanto_mei sle_tanto_mei
cbx_haiban_flg cbx_haiban_flg
end type
global wsm_tanto wsm_tanto

type variables

public:
	str_dpara			i_dpara	// 親ウインドウとの受け渡し用構造体

private:
	nv_data_container	con
	string				i_tanto_mei	// retrieveに使うパラメータ用
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

on wsm_tanto.create
int iCurrent
call super::create
this.st_tanto_mei=create st_tanto_mei
this.sle_tanto_mei=create sle_tanto_mei
this.cbx_haiban_flg=create cbx_haiban_flg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tanto_mei
this.Control[iCurrent+2]=this.sle_tanto_mei
this.Control[iCurrent+3]=this.cbx_haiban_flg
end on

on wsm_tanto.destroy
call super::destroy
destroy(this.st_tanto_mei)
destroy(this.sle_tanto_mei)
destroy(this.cbx_haiban_flg)
end on

event resize;call super::resize;
// sle_tanto_mei
sle_tanto_mei.y	= st_upper.y + st_upper.height + code.MGN_TATE

// st_tanto_mei
st_tanto_mei.y	= sle_tanto_mei.y + sle_tanto_mei.height / 2 - st_tanto_mei.height / 2
st_tanto_mei.x	= dw_list.x

sle_tanto_mei.x	= st_tanto_mei.x + st_tanto_mei.width + code.MGN_GROUP_YOKO

// cbx_haiban_flg
cbx_haiban_flg.y	= sle_tanto_mei.y + sle_tanto_mei.height / 2 - cbx_haiban_flg.height / 2
cbx_haiban_flg.x	= cb_retrieve.x + cb_retrieve.width - cbx_haiban_flg.width

sle_tanto_mei.width	= cbx_haiban_flg.x - sle_tanto_mei.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= sle_tanto_mei.y + sle_tanto_mei.height + code.MGN_TATE

return 0
end event

event retrieve_event;call super::retrieve_event;
datastore	l_ds
string		l_fil_reset[]
long		l_row

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
i_tanto_mei	= trim( sle_tanto_mei.text )

dw_list.reset()
i_dpara.where_string	= l_fil_reset	// 毎回リセットしないと同じ条件が何度もwhere句に追加される

// データ取得時にmultiple=false(単一)で結果が複数返ってきたら、その返ってきたdatastoreをモーダルで表示し、レコードを選択させる
if not i_dpara.visibled then
	l_ds	= i_dpara.ds	// visibledがfalseなら、データ取得を経由しておりデータを持っているので、i_dpara.dsをそのままl_ds経由でdw_listにrowscopyする
else
	// retrieveの検索引数にあたるwhere句を生成して、of_get_dataに渡す
	// DWのwhere句は最低限しか書いておらず、検索引数は手で書く必要がある
	// 担当者名のシングルラインエディット
	if i_tanto_mei <> "" then
		// ここなかったらimmediate_retrieve(自動検索)でi_dpara.where_string[1]に""が格納されてしまう
		i_dpara.where_string[upperbound( i_dpara.where_string ) + 1]	= mdl.of_sqlmake_where( "tanto_mei", "like", i_tanto_mei )
	end if

	l_ds	= of_get_data( dw_list.dataobject, i_dpara )	// このof_get_dataはwindowの関数(先祖化したほうが良い?)
	
	if l_ds.rowcount( ) <= 0 then
		msg.of_error( "入力された担当者名はマスタに存在しません。" )
		sle_tanto_mei.setfocus()
		return -1
	end if
end if

l_row	= l_ds.rowcount()
l_ds.rowscopy( 1, l_row, Primary!, dw_list, 1, Primary! )

// DWにフィルタ適用
cbx_haiban_flg.event clicked( )

dw_list.setfocus()

return 0
end event

event open;call super::open;
sle_tanto_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_dpara	= i_msgparm.powerobjectparm
end event

event retrieve_check;call super::retrieve_check;
string l_tanto_mei

l_tanto_mei	= trim( sle_tanto_mei.text )

if len( l_tanto_mei ) = 0 then
	setnull( i_tanto_mei )
end if

return 0
end event

event update_event;call super::update_event;
long	l_row

l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る
dw_list.rowscopy( l_row, l_row, Primary!, i_dpara.ds, 1, Primary! )	// visible = trueのときは1レコードだけ返す

closewithreturn( this, i_dpara )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_tanto
end type

type st_date from iw_modal_window`st_date within wsm_tanto
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_tanto
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_tanto
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_tanto
end type

type st_title from iw_modal_window`st_title within wsm_tanto
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_tanto
end type

type st_upper from iw_modal_window`st_upper within wsm_tanto
end type

type st_tail from iw_modal_window`st_tail within wsm_tanto
integer y = 2055
end type

type cb_ok from iw_modal_window`cb_ok within wsm_tanto
integer y = 2076
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_tanto
integer y = 2076
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_tanto
integer x = 40
integer y = 423
integer width = 3440
integer height = 1383
integer taborder = 30
string dataobject = "dsm_tanto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean enter2tab = false
end type

event constructor;call super::constructor;
this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_tanto_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_tanto
integer x = 1180
integer y = 316
integer taborder = 20
end type

type st_tanto_mei from ivo_statictext within wsm_tanto
integer x = 108
integer y = 188
integer width = 256
boolean bringtotop = true
string text = "担当者名"
end type

type sle_tanto_mei from ivo_singlelineedit within wsm_tanto
integer x = 504
integer y = 213
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "担当者名を入力してください"
end type

type cbx_haiban_flg from ivo_checkbox within wsm_tanto
integer x = 912
integer y = 224
integer width = 368
string text = "廃番を含む"
end type

event clicked;call super::clicked;
integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	// 廃番フラグが0のみ表示
	dw_list.setfilter( "haiban_flg = 0" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

return 0
end event

