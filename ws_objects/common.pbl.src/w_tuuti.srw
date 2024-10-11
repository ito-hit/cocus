$PBExportHeader$w_tuuti.srw
forward
global type w_tuuti from aw_base_window
end type
type dw_list from ivo_datawindow within w_tuuti
end type
type cb_select from ivo_commandbutton within w_tuuti
end type
type cb_kidoku from ivo_commandbutton within w_tuuti
end type
type cb_midoku from ivo_commandbutton within w_tuuti
end type
type cb_close from ivo_commandbutton within w_tuuti
end type
type ddplb_disp from ivo_dropdownpicturelistbox within w_tuuti
end type
type st_disp from ivo_statictext within w_tuuti
end type
type ddplb_level from sv_ddplb_meisyo within w_tuuti
end type
type ddplb_syubetu from sv_ddplb_meisyo within w_tuuti
end type
type uo_user from cv_input_user within w_tuuti
end type
type cb_reload from ivo_commandbutton within w_tuuti
end type
end forward

global type w_tuuti from aw_base_window
string title = "通知確認"
boolean fnkey_enabled = false
dw_list dw_list
cb_select cb_select
cb_kidoku cb_kidoku
cb_midoku cb_midoku
cb_close cb_close
ddplb_disp ddplb_disp
st_disp st_disp
ddplb_level ddplb_level
ddplb_syubetu ddplb_syubetu
uo_user uo_user
cb_reload cb_reload
end type
global w_tuuti w_tuuti

type variables
private:
	string	i_user_id
end variables

forward prototypes
public subroutine of_button_enable ()
public subroutine of_filter ()
public subroutine of_kidoku (boolean p_kidoku)
end prototypes

public subroutine of_button_enable ();long	l_chk_cnt
boolean	l_enabled

l_chk_cnt	= dw_list.object.chkbox_sum[dw_list.rowcount()]

if l_chk_cnt <> 0 then
	l_enabled	= true
else
	l_enabled	= false
end if

cb_kidoku.enabled	= l_enabled
cb_midoku.enabled	= l_enabled

end subroutine

public subroutine of_filter ();string	l_dsp
integer	l_kidoku,l_level,l_syubetu

string	l_filter

choose case ddplb_disp.text
	case "未読"
		l_kidoku	= 0
	case "既読"
		l_kidoku	= 1
	case else
		setnull( l_kidoku )
end choose

l_level		= ddplb_level.of_get_code_num( )
l_syubetu	= ddplb_syubetu.of_get_code_num( )

// 未読／既読が指定されていればフィルタ追加
if not isnull( l_kidoku ) then
	l_filter	= fnc.strg.of_format( "kidoku_flg={1}", string( l_kidoku ) )
end if

// 通知レベルが指定されていればフィルタ追加
if l_level <> 0 then
	l_filter	= fnc.strg.of_format( "{1}{2}tuuti_lvl={3}", l_filter, fnc.of_decode( len( l_filter ),0, "", " and "), string( l_level ) )
end if

// 通知種別が指定されていればフィルタ追加
if l_syubetu <> 0 then
	l_filter	= fnc.strg.of_format( "{1}{2}tuuti_syubetu={3}", l_filter, fnc.of_decode( len( l_filter ),0, "", " and "), string( l_syubetu ) )
end if
	
dw_list.setfilter( l_filter )
dw_list.filter( )
end subroutine

public subroutine of_kidoku (boolean p_kidoku);long	l_row
integer	l_kidoku

l_kidoku	= fnc.of_cnv_bool2int( p_kidoku )

for l_row = 1 to dw_list.rowcount()
	if dw_list.object.chkbox[l_row] = 1 then
		dw_list.object.kidoku_flg[l_row]	= l_kidoku
	end if
next
end subroutine

on w_tuuti.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.cb_select=create cb_select
this.cb_kidoku=create cb_kidoku
this.cb_midoku=create cb_midoku
this.cb_close=create cb_close
this.ddplb_disp=create ddplb_disp
this.st_disp=create st_disp
this.ddplb_level=create ddplb_level
this.ddplb_syubetu=create ddplb_syubetu
this.uo_user=create uo_user
this.cb_reload=create cb_reload
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_kidoku
this.Control[iCurrent+4]=this.cb_midoku
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.ddplb_disp
this.Control[iCurrent+7]=this.st_disp
this.Control[iCurrent+8]=this.ddplb_level
this.Control[iCurrent+9]=this.ddplb_syubetu
this.Control[iCurrent+10]=this.uo_user
this.Control[iCurrent+11]=this.cb_reload
end on

on w_tuuti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_list)
destroy(this.cb_select)
destroy(this.cb_kidoku)
destroy(this.cb_midoku)
destroy(this.cb_close)
destroy(this.ddplb_disp)
destroy(this.st_disp)
destroy(this.ddplb_level)
destroy(this.ddplb_syubetu)
destroy(this.uo_user)
destroy(this.cb_reload)
end on

event resize;call super::resize;setredraw( false )

// dw_list(横の部)
dw_list.x			= code.MGN_YOKO
dw_list.width		= long( dw_list.object.tuuti_no.x ) + long( dw_list.object.tuuti_no.width ) + 90	// 90はスクロールバーの幅

this.width			= dw_list.x + dw_list.width + code.MGN_YOKO * 3	// なぜか右側余白は左余白×３くらいがちょうどいい

// uo_user
uo_user.y 			= st_upper.y + st_upper.height + code.MGN_TATE
uo_user.x			= dw_list.x + dw_list.width - uo_user.width

// st_disp
st_disp.y			= uo_user.y + uo_user.height / 2 - st_disp.height / 2
st_disp.x			= dw_list.x

// ddplb_disp(リスト部も含めての高さなので頭で合わせる)
ddplb_disp.y		= uo_user.y
ddplb_disp.x		= st_disp.x + st_disp.width + code.MGN_GROUP_YOKO

// ddplb_level
ddplb_level.y		= ddplb_disp.y
ddplb_level.x		= ddplb_disp.x + ddplb_disp.width + code.MGN_ITEM_YOKO

// ddplb_syubetu
ddplb_syubetu.y		= ddplb_disp.y
ddplb_syubetu.x		= ddplb_level.x + ddplb_level.width + code.MGN_GROUP_YOKO

// dw_list(縦の部1)
dw_list.y			= uo_user.y + uo_user.height + code.MGN_TATE
dw_list.height		= 1468

// cb_select
cb_select.y	= dw_list.y + dw_list.height + code.MGN_TATE
cb_select.x	= dw_list.x
// 
cb_kidoku.y	= cb_select.y
cb_kidoku.x	= cb_select.x + cb_select.width + code.MGN_ITEM_YOKO

// cb_midoku
cb_midoku.y	= cb_select.y
cb_midoku.x	= cb_kidoku.x + cb_kidoku.width + code.MGN_GROUP_YOKO

// cb_reload
cb_reload.y	= cb_select.y
cb_reload.x	= cb_midoku.x + cb_midoku.width + code.MGN_YOKO

// cb_close
cb_close.y	= cb_select.y
cb_close.x	= dw_list.x + dw_list.width - cb_close.width

this.height	= cb_select.y + cb_select.height + code.MGN_TATE * 10	// なぜか下余白は単純足し算では足りない。縦余白×10くらいがちょうどよかった

setredraw( true )

end event

event retrieve_event;call super::retrieve_event;dw_list.retrieve( i_user_id )
end event

event open;call super::open;i_user_id	= user.user_id

// フィルタ条件をセットしてから読み込み
of_filter( )

// 再読み込みボタン作ったのでここでまとめる
cb_reload.event execution( 0, 0 )

end event

event update_event;call super::update_event;if dw_list.update() <> 1 then
	rollback using cocos;
	msg.of_error_db( "更新処理でエラーが発生しました。", cocos )
	return -1
end if

commit using cocos;

// 更新後は再読み込み
cb_reload.event execution( 0, 0 )

return 0
end event

event update_check;call super::update_check;if dw_list.accepttext() <> 1 then
	return -1
end if
end event

type uo_signal from aw_base_window`uo_signal within w_tuuti
end type

type st_date from aw_base_window`st_date within w_tuuti
boolean visible = false
end type

type st_user_mei from aw_base_window`st_user_mei within w_tuuti
end type

type uo_test_mode from aw_base_window`uo_test_mode within w_tuuti
end type

type p_size_adjust from aw_base_window`p_size_adjust within w_tuuti
end type

type st_title from aw_base_window`st_title within w_tuuti
end type

type st_title_upper from aw_base_window`st_title_upper within w_tuuti
end type

type st_upper from aw_base_window`st_upper within w_tuuti
end type

type dw_list from ivo_datawindow within w_tuuti
integer x = 40
integer y = 306
integer width = 1012
integer height = 562
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_tuuti"
boolean vscrollbar = true
boolean row_focus_ind = true
end type

event constructor;call super::constructor;this.settransobject( cocos )

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "chkbox"
		if this.object.chkbox[row] = 0 then
			this.object.chkbox[row] = 1
		else
			this.object.chkbox[row] = 0
		end if
		
		of_button_enable( )
end choose

end event

event doubleclicked;call super::doubleclicked;string	l_rowid

if row > 0 then
	l_rowid	= this.object.rowid[row]
	
	openwithparm( w_tuuti_meisai, l_rowid )
	
	// 自分自身の通知だったら既読にする
	if i_user_id = user.user_id then
		// 開いたら既読に
		this.object.kidoku_flg[row]	= 1
		
		// 既読情報をDBに更新
		parent.of_evt_update( 0, 0 )
	end if
end if
end event

type cb_select from ivo_commandbutton within w_tuuti
integer x = 28
integer y = 1241
integer taborder = 20
boolean bringtotop = true
string text = "全て選択"
end type

event clicked;call super::clicked;long	l_row,l_row_cnt,l_chk_cnt
integer	l_flg

l_row_cnt	= dw_list.rowcount( )
l_chk_cnt	= dw_list.object.chkbox_sum[l_row_cnt]

if l_row_cnt <> l_chk_cnt then
	// 全選択
	l_flg	= 1
else
	// 選択解除
	l_flg	= 0
end if

for l_row = 1 to dw_list.rowcount( )
	dw_list.object.chkbox[l_row]	= l_flg
next

of_button_enable( )
end event

type cb_kidoku from ivo_commandbutton within w_tuuti
integer x = 416
integer y = 1230
integer width = 252
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string text = "既読"
boolean cmdb_update = true
end type

event clicked;if i_user_id <> user.user_id then
	if not msg.of_question( fnc.strg.of_format( "他のユーザー宛ての通知を{1}にします。{2}よろしいですか？", fnc.strg.of_replace( fnc.strg.of_replace( this.text, "　", " " ), " ", "" ), code.crlf ) ) then
		return
	end if
end if

// 選択行を既読状態に変更
of_kidoku( true )

event execution( 0, 0 )
end event

type cb_midoku from ivo_commandbutton within w_tuuti
integer x = 680
integer y = 1227
integer width = 252
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string text = "未読"
boolean confirm_enabled = true
boolean cmdb_update = true
end type

event clicked;if i_user_id <> user.user_id then
	if not msg.of_question( fnc.strg.of_format( "他のユーザー宛ての通知を{1}にします。{2}よろしいですか？", fnc.strg.of_replace( fnc.strg.of_replace( this.text, "　", " " ), " ", "" ), code.crlf ) ) then
		return
	end if
end if

// 選択行を未読状態に変更
of_kidoku( false )

event execution( 0, 0 )
end event

type cb_close from ivo_commandbutton within w_tuuti
integer x = 3804
integer y = 1237
integer taborder = 50
boolean bringtotop = true
string text = "戻る"
end type

type ddplb_disp from ivo_dropdownpicturelistbox within w_tuuti
integer x = 368
integer y = 160
integer height = 299
integer taborder = 10
boolean bringtotop = true
string item[] = {"(全て)","未読","既読"}
integer itempictureindex[] = {1,1,1}
end type

event selectionchanged;call super::selectionchanged;of_filter()
end event

event constructor;call super::constructor;this.i_idx	= this.selectitem( "未読", 1 )
end event

type st_disp from ivo_statictext within w_tuuti
integer x = 32
integer y = 167
boolean bringtotop = true
string text = "表示対象"
alignment alignment = right!
end type

type ddplb_level from sv_ddplb_meisyo within w_tuuti
integer x = 768
integer y = 160
integer width = 400
integer taborder = 20
boolean bringtotop = true
integer meisyo_kbn = 164
integer meisyo_no = 1
end type

event selectionchanged;call super::selectionchanged;of_filter()
end event

type ddplb_syubetu from sv_ddplb_meisyo within w_tuuti
integer x = 1216
integer y = 160
integer height = 999
integer taborder = 30
boolean bringtotop = true
integer meisyo_kbn = 163
end type

event selectionchanged;call super::selectionchanged;of_filter()
end event

type uo_user from cv_input_user within w_tuuti
integer x = 2360
integer y = 160
integer width = 1500
integer height = 92
integer taborder = 20
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_user.destroy
call cv_input_user::destroy
end on

event open_modal;call super::open_modal;// モーダルクローズ後の処理
if ancestorreturnvalue then
	i_user_id	= this.of_get_input( )
	
	cb_reload.event execution( 0, 0 )
end if

return true
end event

event sle_input_check;call super::sle_input_check;i_user_id	= this.of_get_input( )
parent.of_evt_retrieve( 0, 0 )

return true
end event

type cb_reload from ivo_commandbutton within w_tuuti
integer x = 1004
integer y = 1230
integer width = 300
integer taborder = 50
boolean bringtotop = true
string text = "再読込"
boolean cmdb_retrieve = true
end type

