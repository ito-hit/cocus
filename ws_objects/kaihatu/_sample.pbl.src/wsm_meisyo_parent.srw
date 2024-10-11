$PBExportHeader$wsm_meisyo_parent.srw
$PBExportComments$名称区分検索のモーダル
forward
global type wsm_meisyo_parent from iw_modal_window
end type
type sle_meisyo_parent from ivo_singlelineedit within wsm_meisyo_parent
end type
type st_meisyo_parent from ivo_statictext within wsm_meisyo_parent
end type
end forward

global type wsm_meisyo_parent from iw_modal_window
integer height = 1941
string title = "名称区分検索"
integer dw_height = 1330
integer dw_width = 1415
sle_meisyo_parent sle_meisyo_parent
st_meisyo_parent st_meisyo_parent
end type
global wsm_meisyo_parent wsm_meisyo_parent

type variables

public:
	str_dpara			i_dpara	// 親ウインドウとの受け渡し用構造体

private:
	nv_data_container	con
	string				i_meisyo	// retrieveに使うパラメータ用
end variables

forward prototypes
public function datastore of_get_data (string p_dwo, str_dpara p_dpara)
end prototypes

public function datastore of_get_data (string p_dwo, str_dpara p_dpara);// data_containerのof_get_dataを呼び出してdatastoreをreturnする 先祖化した方がよいのでは?

datastore	l_ds_ret

l_ds_ret	= con.of_get_data( p_dwo, p_dpara )

return l_ds_ret
end function

on wsm_meisyo_parent.create
int iCurrent
call super::create
this.sle_meisyo_parent=create sle_meisyo_parent
this.st_meisyo_parent=create st_meisyo_parent
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_meisyo_parent
this.Control[iCurrent+2]=this.st_meisyo_parent
end on

on wsm_meisyo_parent.destroy
call super::destroy
destroy(this.sle_meisyo_parent)
destroy(this.st_meisyo_parent)
end on

event update_event;call super::update_event;long	l_row

l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る
dw_list.rowscopy( l_row, l_row, Primary!, i_dpara.ds, 1, Primary! )	// visible = trueのときは1レコードだけ返す

closewithreturn( this, i_dpara )
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_dpara	= i_msgparm.powerobjectparm
end event

event resize;call super::resize;
// sle_meisyo_parent
sle_meisyo_parent.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_meisyo_parent
st_meisyo_parent.y			= sle_meisyo_parent.y + sle_meisyo_parent.height / 2 - st_meisyo_parent.height / 2
st_meisyo_parent.x			= dw_list.x

sle_meisyo_parent.x		= st_meisyo_parent.x + st_meisyo_parent.width + code.MGN_GROUP_YOKO

// cb_retrieve
cb_retrieve.y			= sle_meisyo_parent.y// + sle_meisyo_parent.height + code.MGN_TATE

sle_meisyo_parent.width	= cb_retrieve.x - sle_meisyo_parent.x - code.MGN_ITEM_YOKO

return 0
end event

event open;call super::open;
sle_meisyo_parent.setfocus()
//cb_ok.enabled	= false

return 0
end event

event retrieve_check;call super::retrieve_check;string l_text

l_text	= trim( sle_meisyo_parent.text )

if len( l_text ) = 0 then
	setnull( i_meisyo )
end if

return 0
end event

event retrieve_event;call super::retrieve_event;datastore	l_ds
string		l_fil_reset[]
long		l_row

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
i_meisyo	= sle_meisyo_parent.text

dw_list.reset()
i_dpara.where_string	= l_fil_reset	// 毎回リセットしないと同じ条件が何度もwhere句に追加される

// データ取得時にmultiple=false(単一)で結果が複数返ってきたら、その返ってきたdatastoreをモーダルで表示し、レコードを選択させる
if not i_dpara.visibled then
	l_ds	= i_dpara.ds	// visibledがfalseなら、データ取得を経由しておりデータを持っているので、i_dpara.dsをそのままl_ds経由でdw_listにrowscopyする
else
	// retrieveの検索引数にあたるwhere句を生成して、of_get_dataに渡す
	// DWのwhere句は最低限しか書いておらず、検索引数は手で書く必要がある
	// 名称のシングルラインエディット
	if i_meisyo <> "" then
		// ここなかったらimmediate_retrieve(自動検索)でi_dpara.where_string[1]に""が格納されてしまう
		i_dpara.where_string[upperbound( i_dpara.where_string ) + 1]	= mdl.of_sqlmake_where( "meisyo_1", "like", i_meisyo )
	end if

	l_ds	= of_get_data( dw_list.dataobject, i_dpara )	// このof_get_dataはwindowの関数(先祖化したほうが良い?)
	
	if l_ds.rowcount( ) <= 0 then
		msg.of_error( "入力された名称はマスタに存在しません。" )
		sle_meisyo_parent.setfocus()
		return -1
	end if
end if

l_row	= l_ds.rowcount()
l_ds.rowscopy( 1, l_row, Primary!, dw_list, 1, Primary! )

dw_list.setfocus()

return 0
end event

type uo_signal from iw_modal_window`uo_signal within wsm_meisyo_parent
end type

type st_date from iw_modal_window`st_date within wsm_meisyo_parent
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_meisyo_parent
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_meisyo_parent
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_meisyo_parent
end type

type st_title from iw_modal_window`st_title within wsm_meisyo_parent
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_meisyo_parent
end type

type st_upper from iw_modal_window`st_upper within wsm_meisyo_parent
end type

type st_tail from iw_modal_window`st_tail within wsm_meisyo_parent
integer y = 1739
end type

type cb_ok from iw_modal_window`cb_ok within wsm_meisyo_parent
integer y = 1760
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_meisyo_parent
integer y = 1760
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_meisyo_parent
integer x = 12
integer y = 277
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "dsm_meisyo_parent"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
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
sle_meisyo_parent.setfocus()

return 0
end event

event getfocus;call super::getfocus;
//cb_ok.enabled	= true
end event

event losefocus;call super::losefocus;
//cb_ok.enabled	= false
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_meisyo_parent
integer y = 156
integer taborder = 20
end type

type sle_meisyo_parent from ivo_singlelineedit within wsm_meisyo_parent
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "名称を入力してください"
end type

type st_meisyo_parent from ivo_statictext within wsm_meisyo_parent
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "名称"
alignment alignment = right!
end type

