$PBExportHeader$w_test_syohin.srw
$PBExportComments$cv_input_syohinのテスト
forward
global type w_test_syohin from iw_main_window
end type
type ddplb_syori from sv_ddplb_syori within w_test_syohin
end type
type uo_syohin from cv_input_syohin within w_test_syohin
end type
type dw_list from ivo_datawindow within w_test_syohin
end type
end forward

global type w_test_syohin from iw_main_window
ddplb_syori ddplb_syori
uo_syohin uo_syohin
dw_list dw_list
end type
global w_test_syohin w_test_syohin

type variables

public:
	long	i_syohin_code
	long	i_iro_no
end variables

on w_test_syohin.create
int iCurrent
call super::create
this.ddplb_syori=create ddplb_syori
this.uo_syohin=create uo_syohin
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_syori
this.Control[iCurrent+2]=this.uo_syohin
this.Control[iCurrent+3]=this.dw_list
end on

on w_test_syohin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddplb_syori)
destroy(this.uo_syohin)
destroy(this.dw_list)
end on

event retrieve_check;call super::retrieve_check;
// 商品コード
if not uo_syohin.event sle_input_check( ) then
	return -1
end if

// 色番
if not uo_syohin.event sle_iro_input_check( ) then
	return -1
end if
end event

event retrieve_event;call super::retrieve_event;
i_syohin_code	= uo_syohin.of_get_syohin_code( )
i_iro_no		= uo_syohin.of_get_iro_no( )

// 入力されていなくてもよい場合は下記のような考慮必要
if isnull( i_syohin_code ) then
	// 条件に加えないなど
end if

if isnull( i_iro_no ) then
	// 条件に加えないなど
end if

if dw_list.retrieve( i_syohin_code, i_iro_no ) > 0 then
	
else
	msg.of_error( "データがありません。" )
end if
end event

type uo_signal from iw_main_window`uo_signal within w_test_syohin
end type

type st_date from iw_main_window`st_date within w_test_syohin
end type

type st_user_mei from iw_main_window`st_user_mei within w_test_syohin
end type

type uo_test_mode from iw_main_window`uo_test_mode within w_test_syohin
end type

type p_size_adjust from iw_main_window`p_size_adjust within w_test_syohin
end type

type st_title from iw_main_window`st_title within w_test_syohin
end type

type st_title_upper from iw_main_window`st_title_upper within w_test_syohin
end type

type st_upper from iw_main_window`st_upper within w_test_syohin
end type

type st_second_upper from iw_main_window`st_second_upper within w_test_syohin
end type

type cb_retrieve from iw_main_window`cb_retrieve within w_test_syohin
end type

type ddplb_syori from sv_ddplb_syori within w_test_syohin
integer x = 96
integer y = 164
integer taborder = 10
boolean bringtotop = true
string init_disp = "照会"
end type

event selectionchanged;call super::selectionchanged;
string	l_syori

l_syori	= trim( this.text )

// カスタムフォームのチェックモードを制御する
choose case l_syori
	case "登録"
		// 重複チェックをする
		uo_syohin.of_set_dbchk_dupe( )
	case "変更", "削除"
		// 存在チェックをする
		uo_syohin.of_set_dbchk_exst( )
	case "照会"
		// チェックはするが、エラーメッセージは必要ない
		uo_syohin.of_set_dbchk_none( )
	case else
		// 何もしない
end choose
end event

event constructor;call super::constructor;
// selectionchangedを呼び出す
this.event selectionchanged( i_idx )
end event

type uo_syohin from cv_input_syohin within w_test_syohin
integer x = 468
integer y = 167
integer taborder = 20
boolean bringtotop = true
boolean bikou_visible = false
end type

on uo_syohin.destroy
call cv_input_syohin::destroy
end on

type dw_list from ivo_datawindow within w_test_syohin
integer x = 156
integer y = 661
integer width = 4448
integer height = 816
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_test_syohin"
boolean vscrollbar = true
end type

event constructor;call super::constructor;
// トランザクション接続
this.settransobject( cocos )
end event

