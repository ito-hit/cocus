$PBExportHeader$w_modal_user.srw
$PBExportComments$ユーザー検索のモーダル
forward
global type w_modal_user from iw_modal_window
end type
type cbx_out_enabled from ivo_checkbox within w_modal_user
end type
type sle_user from ivo_singlelineedit within w_modal_user
end type
type st_user from ivo_statictext within w_modal_user
end type
end forward

global type w_modal_user from iw_modal_window
integer height = 1604
string title = "ユーザー一覧"
cbx_out_enabled cbx_out_enabled
sle_user sle_user
st_user st_user
end type
global w_modal_user w_modal_user

type variables
// 親ウインドウとの受け渡し用構造体
str_mdlpara_user	i_param

private string	i_user_string

end variables

on w_modal_user.create
int iCurrent
call super::create
this.cbx_out_enabled=create cbx_out_enabled
this.sle_user=create sle_user
this.st_user=create st_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_out_enabled
this.Control[iCurrent+2]=this.sle_user
this.Control[iCurrent+3]=this.st_user
end on

on w_modal_user.destroy
call super::destroy
destroy(this.cbx_out_enabled)
destroy(this.sle_user)
destroy(this.st_user)
end on

event update_event;call super::update_event;long	l_row

l_row							= dw_list.getrow()
i_param.out_user_id				= dw_list.object.user_id[l_row]

// 追加
i_param.out_user_mei			= dw_list.object.user_mei[l_row]
i_param.out_user_mei_ryaku		= dw_list.object.user_mei_ryaku[l_row]
i_param.out_mail_address		= dw_list.object.mail_address[l_row]
i_param.out_busyo_code			= dw_list.object.busyo_code[l_row]
i_param.out_class				= dw_list.object.class[l_row]
i_param.out_init_menu_id		= dw_list.object.init_menu_id[l_row]
i_param.out_init_tab_id			= dw_list.object.init_tab_id[l_row]
i_param.out_kyoten_code			= dw_list.object.kyoten_code[l_row]
i_param.out_kyoten_group_code	= dw_list.object.kyoten_group_code[l_row]
i_param.out_login_kengen		= dw_list.object.login_kengen[l_row]
i_param.out_riyou_str_date		= dw_list.object.riyou_str_date[l_row]
i_param.out_riyou_end_date		= dw_list.object.riyou_end_date[l_row]

closewithreturn( this, i_param )
end event

event openquery;call super::openquery;// 親ウインドウからのパラメータを変数に格納
i_param	= i_msgparm.powerobjectparm

// DWにフィルタ適用
cbx_out_enabled.event clicked( )


end event

event resize;call super::resize;// sle_user
sle_user.y	= st_upper.y + st_upper.height + code.MGN_TATE

// st_user
st_user.y	= sle_user.y + sle_user.height / 2 - st_user.height / 2
st_user.x	= dw_list.x

sle_user.x	= st_user.x + st_user.width + code.MGN_GROUP_YOKO

// cbx_out_enabled
cbx_out_enabled.y	= sle_user.y + sle_user.height / 2 - cbx_out_enabled.height / 2
cbx_out_enabled.x	= cb_retrieve.x + cb_retrieve.width - cbx_out_enabled.width

sle_user.width		= cbx_out_enabled.x - sle_user.x - code.MGN_ITEM_YOKO

// cb_retrieve
cb_retrieve.y	= sle_user.y + sle_user.height + code.MGN_TATE


end event

event open;call super::open;sle_user.setfocus()
end event

event retrieve_event;call super::retrieve_event;
if dw_list.retrieve( i_user_string ) > 0 then
	dw_list.setfocus()
else
	sle_user.setfocus()
end if
end event

event retrieve_check;call super::retrieve_check;string	l_text

l_text	= trim( sle_user.text )

if len( l_text ) <> 0 then
	i_user_string	= l_text
else
	setnull( i_user_string )
end if
end event

type uo_signal from iw_modal_window`uo_signal within w_modal_user
end type

type st_date from iw_modal_window`st_date within w_modal_user
end type

type st_user_mei from iw_modal_window`st_user_mei within w_modal_user
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_modal_user
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_modal_user
end type

type st_title from iw_modal_window`st_title within w_modal_user
end type

type st_title_upper from iw_modal_window`st_title_upper within w_modal_user
end type

type st_upper from iw_modal_window`st_upper within w_modal_user
end type

type st_tail from iw_modal_window`st_tail within w_modal_user
integer y = 1412
end type

type cb_ok from iw_modal_window`cb_ok within w_modal_user
integer y = 1433
integer taborder = 40
end type

type cb_cancel from iw_modal_window`cb_cancel within w_modal_user
integer y = 1433
integer taborder = 50
end type

type dw_list from iw_modal_window`dw_list within w_modal_user
integer x = 12
integer y = 338
integer width = 1740
integer height = 1127
integer taborder = 30
string dataobject = "d_modal_user"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f6_key = true
end type

event constructor;call super::constructor;// トランザクション
this.settransobject( cocos )


end event

event dw_list::doubleclicked;call super::doubleclicked;cb_ok.event clicked( )
end event

event key_f06;call super::key_f06;
// メイン画面のF6は「戻り」動作なので、モーダルは検索文字入力欄へ
sle_user.setfocus()
return 0
end event

type cb_retrieve from iw_modal_window`cb_retrieve within w_modal_user
integer y = 242
integer taborder = 20
end type

type cbx_out_enabled from ivo_checkbox within w_modal_user
integer x = 1268
integer y = 156
integer width = 488
boolean bringtotop = true
string text = "利用不可を含む"
end type

event clicked;call super::clicked;integer	l_row

l_row	= dw_list.getrow()

dw_list.setredraw( false )

if this.checked then
	dw_list.setfilter( "" )
else
	dw_list.setfilter( "riyou_kikan_flg = 1 and login_kengen = 1" )
end if

// フィルタセット
dw_list.filter()

// 選択行にスクロール
dw_list.scrolltorow( l_row )

dw_list.setredraw( true )

end event

type sle_user from ivo_singlelineedit within w_modal_user
integer x = 364
integer y = 156
integer width = 744
integer taborder = 10
boolean bringtotop = true
string text = ""
string placeholder = "ユーザー名を入力してください"
end type

type st_user from ivo_statictext within w_modal_user
integer x = 32
integer y = 160
boolean bringtotop = true
string text = "ユーザー名"
alignment alignment = right!
end type

