$PBExportHeader$wsm_user.srw
$PBExportComments$ユーザー検索のモーダル
forward
global type wsm_user from iw_modal_window
end type
type st_user_mei_title from ivo_statictext within wsm_user
end type
type sle_user_mei from ivo_singlelineedit within wsm_user
end type
type cbx_riyo_fuka from ivo_checkbox within wsm_user
end type
end forward

global type wsm_user from iw_modal_window
integer dw_height = 1382
integer dw_width = 2537
st_user_mei_title st_user_mei_title
sle_user_mei sle_user_mei
cbx_riyo_fuka cbx_riyo_fuka
end type
global wsm_user wsm_user

type variables

public:
	str_mdlpara_muser	i_mdl_user		// 親ウインドウとの受け渡し用構造体

private:
	str_muser			i_para_reset[]	// i_mdl_user.retの初期化用
	
	string				i_sysdate		// チェックボックスで利用する現在日付
	string				i_user_mei		// retrieveに使うパラメータ用
end variables

on wsm_user.create
int iCurrent
call super::create
this.st_user_mei_title=create st_user_mei_title
this.sle_user_mei=create sle_user_mei
this.cbx_riyo_fuka=create cbx_riyo_fuka
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_user_mei_title
this.Control[iCurrent+2]=this.sle_user_mei
this.Control[iCurrent+3]=this.cbx_riyo_fuka
end on

on wsm_user.destroy
call super::destroy
destroy(this.st_user_mei_title)
destroy(this.sle_user_mei)
destroy(this.cbx_riyo_fuka)
end on

event open;call super::open;
sle_user_mei.setfocus()

return 0
end event

event openquery;call super::openquery;
// 親ウインドウからのパラメータを変数に格納
i_mdl_user		= i_msgparm.powerobjectparm

// inパラメータ以外を初期化しておく
i_mdl_user.ret	= i_para_reset

// DWにフィルタ適用 現在日付が必要なのでここで取得しておく
select to_char( sysdate, 'yyyymmdd' )
  into :i_sysdate
  from dual
using cocos;

if cocos.sqlcode <> 0 then
	msg.of_error( "日付の取得時にエラーが発生しました。" )
end if

cbx_riyo_fuka.event clicked( )
end event

event retrieve_event;call super::retrieve_event;
string l_user_mei

l_user_mei	= trim( sle_user_mei.text )

// retrieveに使うインスタンス変数を格納(これ以降はインスタンス変数を確認する)
if len( l_user_mei ) <> 0 then
	i_user_mei	= l_user_mei
else
	setnull( i_user_mei )
end if

if dw_list.retrieve( i_user_mei ) > 0 then
	dw_list.setfocus()
else
	sle_user_mei.setfocus()
end if

return 0
end event

event resize;call super::resize;
// sle_user_mei
sle_user_mei.y		= st_upper.y + st_upper.height + code.MGN_TATE

// st_user_mei
st_user_mei_title.y	= sle_user_mei.y + sle_user_mei.height / 2 - st_user_mei_title.height / 2
st_user_mei_title.x	= dw_list.x

sle_user_mei.x		= st_user_mei_title.x + st_user_mei_title.width + code.MGN_GROUP_YOKO

// cbx_riyo_fuka
cbx_riyo_fuka.y		= sle_user_mei.y + sle_user_mei.height / 2 - cbx_riyo_fuka.height / 2
cbx_riyo_fuka.x		= cb_retrieve.x + cb_retrieve.width - cbx_riyo_fuka.width

sle_user_mei.width	= cbx_riyo_fuka.x - sle_user_mei.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y		= sle_user_mei.y + sle_user_mei.height + code.MGN_TATE

return 0
end event

event update_event;call super::update_event;
long	l_row, l_index

l_index	= upperbound( i_mdl_user.ret ) + 1
l_row	= dw_list.getrow()	// 何もフォーカスしなかったら1が返る

// 構造体へデータのセット
i_mdl_user.ret[l_index].user_id				= dw_list.object.user_id[l_row]
i_mdl_user.ret[l_index].user_mei			= dw_list.object.user_mei[l_row]
i_mdl_user.ret[l_index].user_mei_ryaku		= dw_list.object.user_mei_ryaku[l_row]
i_mdl_user.ret[l_index].password			= dw_list.object.password[l_row]
i_mdl_user.ret[l_index].password_new		= dw_list.object.password_new[l_row]
i_mdl_user.ret[l_index].password_new_date	= dw_list.object.password_new_date[l_row]
i_mdl_user.ret[l_index].mail_address		= dw_list.object.mail_address[l_row]
i_mdl_user.ret[l_index].busyo_code			= dw_list.object.busyo_code[l_row]
i_mdl_user.ret[l_index].class				= dw_list.object.class[l_row]
i_mdl_user.ret[l_index].init_menu_id		= dw_list.object.init_menu_id[l_row]
i_mdl_user.ret[l_index].init_tab_id			= dw_list.object.init_tab_id[l_row]
i_mdl_user.ret[l_index].kyoten_code			= dw_list.object.kyoten_code[l_row]
i_mdl_user.ret[l_index].kyoten_code_2		= dw_list.object.kyoten_code_2[l_row]
i_mdl_user.ret[l_index].kyoten_group_code	= dw_list.object.kyoten_group_code[l_row]
i_mdl_user.ret[l_index].login_kengen		= dw_list.object.login_kengen[l_row]
i_mdl_user.ret[l_index].riyou_str_date		= dw_list.object.riyou_str_date[l_row]
i_mdl_user.ret[l_index].riyou_end_date		= dw_list.object.riyou_end_date[l_row]
i_mdl_user.ret[l_index].sid					= dw_list.object.sid[l_row]
i_mdl_user.ret[l_index].serial				= dw_list.object.serial[l_row]
i_mdl_user.ret[l_index].touroku_date		= dw_list.object.touroku_date[l_row]
i_mdl_user.ret[l_index].touroku_user_id		= dw_list.object.touroku_user_id[l_row]
i_mdl_user.ret[l_index].touroku_client_id	= dw_list.object.touroku_client_id[l_row]
i_mdl_user.ret[l_index].touroku_pg_id		= dw_list.object.touroku_pg_id[l_row]
i_mdl_user.ret[l_index].henkou_date			= dw_list.object.henkou_date[l_row]
i_mdl_user.ret[l_index].henkou_user_id		= dw_list.object.henkou_user_id[l_row]
i_mdl_user.ret[l_index].henkou_client_id	= dw_list.object.henkou_client_id[l_row]
i_mdl_user.ret[l_index].henkou_pg_id		= dw_list.object.henkou_pg_id[l_row]
i_mdl_user.ret[l_index].kousin_date			= dw_list.object.kousin_date[l_row]
i_mdl_user.ret[l_index].kousin_user_id		= dw_list.object.kousin_user_id[l_row]
i_mdl_user.ret[l_index].kousin_client_id	= dw_list.object.kousin_client_id[l_row]
i_mdl_user.ret[l_index].kousin_pg_id		= dw_list.object.kousin_pg_id[l_row]
i_mdl_user.ret[l_index].haita_flg			= dw_list.object.haita_flg[l_row]

closewithreturn( this, i_mdl_user )
end event

type uo_signal from iw_modal_window`uo_signal within wsm_user
end type

type st_date from iw_modal_window`st_date within wsm_user
end type

type st_user_mei from iw_modal_window`st_user_mei within wsm_user
end type

type uo_test_mode from iw_modal_window`uo_test_mode within wsm_user
end type

type p_size_adjust from iw_modal_window`p_size_adjust within wsm_user
end type

type st_title from iw_modal_window`st_title within wsm_user
end type

type st_title_upper from iw_modal_window`st_title_upper within wsm_user
end type

type st_upper from iw_modal_window`st_upper within wsm_user
end type

type st_tail from iw_modal_window`st_tail within wsm_user
end type

type cb_ok from iw_modal_window`cb_ok within wsm_user
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within wsm_user
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within wsm_user
integer x = 556
integer y = 277
integer width = 2488
integer taborder = 30
string dataobject = "dsm_user"
boolean vscrollbar = true
boolean f6_key = true
boolean save_excel = false
end type

event doubleclicked;call super::doubleclicked;
cb_ok.event clicked( )

return 0
end event

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )

this.i_function_name	= { "", "", "", "", "", "戻り", "", "", "", "", "", "" }

return 0
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_user_mei.setfocus()

return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within wsm_user
integer x = 1636
integer y = 164
integer taborder = 20
end type

type st_user_mei_title from ivo_statictext within wsm_user
integer x = 68
integer y = 164
boolean bringtotop = true
string text = "ユーザー名"
end type

type sle_user_mei from ivo_singlelineedit within wsm_user
integer x = 468
integer y = 160
integer taborder = 10
boolean bringtotop = true
string text = ""
end type

type cbx_riyo_fuka from ivo_checkbox within wsm_user
integer x = 924
integer y = 153
integer width = 528
string text = "利用不可を含む"
end type

event clicked;call super::clicked;
integer	l_row
string	l_filter

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	// ログイン権限=1と利用開始～利用終了の間かどうか確認する
	l_filter	= "login_kengen = 1"
	l_filter	= l_filter + " and " + i_sysdate + " between riyou_str_date and riyou_end_date"
	
	dw_list.setfilter( l_filter )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

return 0
end event

