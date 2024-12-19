$PBExportHeader$w_yamamoto_test_input2.srw
$PBExportComments$入力フォームのテスト画面 連携無し
forward
global type w_yamamoto_test_input2 from iw_main_window
end type
type ddplb_syori from sv_ddplb_syori within w_yamamoto_test_input2
end type
type uo_meisyo from cv_input_meisyo within w_yamamoto_test_input2
end type
type uo_meisyo_parent from cv_input_meisyo_parent within w_yamamoto_test_input2
end type
type uo_user from cv_input_user within w_yamamoto_test_input2
end type
type uo_yubin from cv_input_yubin within w_yamamoto_test_input2
end type
type cb_req from ivo_commandbutton within w_yamamoto_test_input2
end type
type uo_kojyo from cv_input_kojyo within w_yamamoto_test_input2
end type
type uo_group from cv_input_group within w_yamamoto_test_input2
end type
end forward

global type w_yamamoto_test_input2 from iw_main_window
ddplb_syori ddplb_syori
uo_meisyo uo_meisyo
uo_meisyo_parent uo_meisyo_parent
uo_user uo_user
uo_yubin uo_yubin
cb_req cb_req
uo_kojyo uo_kojyo
uo_group uo_group
end type
global w_yamamoto_test_input2 w_yamamoto_test_input2

on w_yamamoto_test_input2.create
int iCurrent
call super::create
this.ddplb_syori=create ddplb_syori
this.uo_meisyo=create uo_meisyo
this.uo_meisyo_parent=create uo_meisyo_parent
this.uo_user=create uo_user
this.uo_yubin=create uo_yubin
this.cb_req=create cb_req
this.uo_kojyo=create uo_kojyo
this.uo_group=create uo_group
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori
this.Control[iCurrent+2]=this.uo_meisyo
this.Control[iCurrent+3]=this.uo_meisyo_parent
this.Control[iCurrent+4]=this.uo_user
this.Control[iCurrent+5]=this.uo_yubin
this.Control[iCurrent+6]=this.cb_req
this.Control[iCurrent+7]=this.uo_kojyo
this.Control[iCurrent+8]=this.uo_group
end on

on w_yamamoto_test_input2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori)
destroy(this.uo_meisyo)
destroy(this.uo_meisyo_parent)
destroy(this.uo_user)
destroy(this.uo_yubin)
destroy(this.cb_req)
destroy(this.uo_kojyo)
destroy(this.uo_group)
end on

event retrieve_check;call super::retrieve_check;
if not uo_meisyo_parent.event sle_input_check() then
//	return -1
end if

if not uo_user.event sle_input_check() then
//	return -1
end if

if not uo_yubin.event sle_input_check() then
	return -1
end if
end event

type uo_signal from iw_main_window`uo_signal within w_yamamoto_test_input2
end type

type st_date from iw_main_window`st_date within w_yamamoto_test_input2
end type

type st_user_mei from iw_main_window`st_user_mei within w_yamamoto_test_input2
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_yamamoto_test_input2
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_yamamoto_test_input2
end type

type st_title from iw_main_window`st_title within w_yamamoto_test_input2
end type

type st_title_upper from iw_main_window`st_title_upper within w_yamamoto_test_input2
end type

type st_upper from iw_main_window`st_upper within w_yamamoto_test_input2
end type

type st_second_upper from iw_main_window`st_second_upper within w_yamamoto_test_input2
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_yamamoto_test_input2
integer taborder = 0
end type

type ddplb_syori from sv_ddplb_syori within w_yamamoto_test_input2
integer x = 100
integer y = 171
boolean bringtotop = true
string init_disp = "登録"
end type

event constructor;call super::constructor;
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
		uo_meisyo.of_set_dbchk_dupe( )
		uo_meisyo_parent.of_set_dbchk_dupe( )
		uo_user.of_set_dbchk_dupe( )
		uo_yubin.of_set_dbchk_dupe( )
		
		uo_kojyo.of_set_dbchk_dupe( )
		
	case "変更", "削除"
		// 存在チェックをする
		uo_meisyo.of_set_dbchk_exst( )
		uo_meisyo_parent.of_set_dbchk_exst( )
		uo_user.of_set_dbchk_exst( )
		uo_yubin.of_set_dbchk_exst( )
		
		uo_kojyo.of_set_dbchk_exst( )
		
	case "照会"
		uo_meisyo.of_set_dbchk_none( )
		uo_meisyo_parent.of_set_dbchk_none( )
		uo_user.of_set_dbchk_none( )
		uo_yubin.of_set_dbchk_none( )
		
		uo_kojyo.of_set_dbchk_none( )
		
	case else
		// 何もしない
end choose
end event

type uo_meisyo from cv_input_meisyo within w_yamamoto_test_input2
integer x = 8
integer y = 416
integer taborder = 10
boolean bringtotop = true
end type

on uo_meisyo.destroy
call cv_input_meisyo::destroy
end on

type uo_meisyo_parent from cv_input_meisyo_parent within w_yamamoto_test_input2
integer y = 530
integer taborder = 20
boolean bringtotop = true
boolean chk_required = true
end type

on uo_meisyo_parent.destroy
call cv_input_meisyo_parent::destroy
end on

type uo_user from cv_input_user within w_yamamoto_test_input2
integer y = 768
integer taborder = 30
boolean bringtotop = true
boolean chk_required = true
end type

on uo_user.destroy
call cv_input_user::destroy
end on

type uo_yubin from cv_input_yubin within w_yamamoto_test_input2
integer x = 16
integer y = 942
integer taborder = 40
boolean bringtotop = true
boolean chk_required = true
end type

on uo_yubin.destroy
call cv_input_yubin::destroy
end on

type cb_req from ivo_commandbutton within w_yamamoto_test_input2
integer x = 436
integer y = 178
boolean bringtotop = true
end type

event execution;call super::execution;
boolean	l_bool

// 名称
if uo_meisyo.chk_required then
	uo_meisyo.chk_required	= false
else
	uo_meisyo.chk_required	= true
end if

// 名称parent
if uo_meisyo_parent.chk_required then
	uo_meisyo_parent.chk_required	= false
else
	uo_meisyo_parent.chk_required	= true
end if

// ユーザー
if uo_user.chk_required then
	uo_user.chk_required	= false
else
	uo_user.chk_required	= true
end if

// 郵便番号
if uo_yubin.chk_required then
	uo_yubin.chk_required	= false
else
	uo_yubin.chk_required	= true
end if

// 工場
if uo_kojyo.chk_required then
	uo_kojyo.chk_required	= false
else
	uo_kojyo.chk_required	= true
end if

l_bool		= uo_meisyo.chk_required
this.text	= string( l_bool )

//uo_menu.event sle_input_check()

return 0
end event

type uo_kojyo from cv_input_kojyo within w_yamamoto_test_input2
integer y = 1145
integer taborder = 50
boolean bringtotop = true
end type

on uo_kojyo.destroy
call cv_input_kojyo::destroy
end on

type uo_group from cv_input_group within w_yamamoto_test_input2
integer y = 1305
integer taborder = 60
boolean bringtotop = true
end type

on uo_group.destroy
call cv_input_group::destroy
end on

