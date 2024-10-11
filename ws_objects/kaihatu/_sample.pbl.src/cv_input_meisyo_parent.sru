$PBExportHeader$cv_input_meisyo_parent.sru
$PBExportComments$m_meisyo(parent)の入力フォーム
forward
global type cv_input_meisyo_parent from cv_input
end type
end forward

global type cv_input_meisyo_parent from cv_input
integer width = 3276
string i_title = "名称区分"
long i_bikou_width = 984
boolean i_modal_visible = true
boolean i_meisyo_visible = true
boolean i_bikou_visible = true
end type
global cv_input_meisyo_parent cv_input_meisyo_parent

type variables

public:
	boolean		i_meisyo_1_hyouji	= true	// チェックが入ったらm_meisyoはmeisyo_1を表示させる
	boolean		i_meisyo_2_hyouji			// チェックが入ったらm_meisyoはmeisyo_2を表示させる
	boolean		i_meisyo_3_hyouji			// チェックが入ったらm_meisyoはmeisyo_3を表示させる
end variables

forward prototypes
public function string of_get_meisyo_code ()
public function string of_get_meisyo_1 ()
public function string of_get_meisyo_2 ()
public function string of_get_meisyo_3 ()
public function string of_get_meisyo_mei ()
public function string of_get_setumei ()
public function string of_get_meisyo_code (long p_index)
end prototypes

public function string of_get_meisyo_code ();
// 外部からこの関数を呼んで、名称コードをreturnする関数

return of_get_meisyo_code(1)
end function

public function string of_get_meisyo_1 ();
// 外部からこの関数を呼んで、名称1をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.meisyo_1[1]
end function

public function string of_get_meisyo_2 ();
// 外部からこの関数を呼んで、名称2をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.meisyo_2[1]
end function

public function string of_get_meisyo_3 ();
// 外部からこの関数を呼んで、名称3をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.meisyo_3[1]
end function

public function string of_get_meisyo_mei ();
// 外部からこの関数を呼んで、名称名をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.meisyo_mei[1]
end function

public function string of_get_setumei ();
// 外部からこの関数を呼んで、説明をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.setumei[1]
end function

public function string of_get_meisyo_code (long p_index);
// 外部からこの関数を呼んで、名称コードをreturnする関数

if not i_dpara.ret then
	return ""
end if

if p_index <= 0 then
	return ""
end if

if p_index > i_dpara.ds.rowcount() then
	return ""
end if

return i_dpara.ds.object.meisyo_code[p_index]
end function

on cv_input_meisyo_parent.create
call super::create
end on

on cv_input_meisyo_parent.destroy
call super::destroy
end on

event sle_input_check;call super::sle_input_check;
string	l_meisyo_code

l_meisyo_code	= trim( of_get_input( ) )

if len( l_meisyo_code ) <> 0 then
	i_dpara.multiple	= false	// 単一結果で返ってきてほしい
	i_dpara				= dta.of_get_meisyo_parent( l_meisyo_code )	// データ取得

	if not i_dpara.ret then
		msg.of_error( "入力された名称コードはマスタに存在しません。" )
		of_reset( false )	// 備考は消さない
		return false
	end if
	
	// meisyo_**にチェックがあればここが動く
	if i_meisyo_1_hyouji then
		of_set_meisyo( fnc.of_nvl( i_dpara.ds.object.meisyo_1[1], "???" ) )
	elseif i_meisyo_2_hyouji then
		of_set_meisyo( fnc.of_nvl( i_dpara.ds.object.meisyo_2[1], "???" ) )
	elseif i_meisyo_3_hyouji then
		of_set_meisyo( fnc.of_nvl( i_dpara.ds.object.meisyo_3[1], "???" ) )
	else
		// 何もしない
	end if
else
	of_reset( false )	// 備考は消さない
	return false
end if

return true
end event

event constructor;call super::constructor;
object_type	= "input_meisyo_parent"
end event

event open_modal;call super::open_modal;
// モーダルを開く
i_dpara	= mdl.of_open_meisyo_parent()

if i_dpara.ret then
	of_set_input( i_dpara.ds.object.meisyo_code[1] )
	of_set_meisyo( i_dpara.ds.object.meisyo_1[1] )
end if

sle_input.setfocus()

return i_dpara.ret
end event

type st_bikou from cv_input`st_bikou within cv_input_meisyo_parent
integer x = 2180
integer width = 984
string text = "※新区分登録時は名称区分＝0を入力"
end type

event st_bikou::constructor;call super::constructor;st_bikou.visible	= true
end event

type st_meisyo from cv_input`st_meisyo within cv_input_meisyo_parent
integer width = 1512
end type

type cb_modal from cv_input`cb_modal within cv_input_meisyo_parent
end type

type sle_input from cv_input`sle_input within cv_input_meisyo_parent
boolean chk_type_num = true
end type

type st_title from cv_input`st_title within cv_input_meisyo_parent
string text = "名称区分"
end type

