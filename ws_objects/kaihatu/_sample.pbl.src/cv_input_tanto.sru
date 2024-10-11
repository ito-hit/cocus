$PBExportHeader$cv_input_tanto.sru
$PBExportComments$m_tantoの入力フォーム
forward
global type cv_input_tanto from cv_input
end type
end forward

global type cv_input_tanto from cv_input
string i_title = "担当者"
boolean i_modal_visible = true
boolean i_meisyo_visible = true
boolean i_bikou_visible = true
end type
global cv_input_tanto cv_input_tanto

type variables

end variables
forward prototypes
public function long of_get_tanto_code ()
public function string of_get_tanto_mei ()
public function long of_get_nayose_code ()
public function long of_get_bumon_code ()
public function long of_get_eigyosyo_code ()
public function long of_get_ka_code ()
end prototypes

public function long of_get_tanto_code ();
// 外部からこの関数を呼んで、担当コードをreturnする関数
// 担当者コード＝0 の登録は不可

if not i_dpara.ret then
	return 0
end if

return i_dpara.ds.object.tanto_code[1]
end function

public function string of_get_tanto_mei ();
// 外部からこの関数を呼んで、担当名をreturnする関数

if not i_dpara.ret then
	return ""
end if

return i_dpara.ds.object.tanto_mei[1]
end function

public function long of_get_nayose_code ();
// 外部からこの関数を呼んで、名寄コードをreturnする関数

if not i_dpara.ret then
	return 0
end if

return i_dpara.ds.object.nayose_code[1]
end function

public function long of_get_bumon_code ();
// 外部からこの関数を呼んで、部門コードをreturnする関数

if not i_dpara.ret then
	return 0
end if

return i_dpara.ds.object.bumon_code[1]
end function

public function long of_get_eigyosyo_code ();
// 外部からこの関数を呼んで、営業所コードをreturnする関数

if not i_dpara.ret then
	return 0
end if

return i_dpara.ds.object.eigyosyo_code[1]
end function

public function long of_get_ka_code ();
// 外部からこの関数を呼んで、課コードをreturnする関数

if not i_dpara.ret then
	return 0
end if

return i_dpara.ds.object.ka_code[1]
end function

on cv_input_tanto.create
call super::create
end on

on cv_input_tanto.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type			= "input_tanto"

of_set_bikou( "" )
end event

event sle_input_check;call super::sle_input_check;
long	l_tanto_code

l_tanto_code	= long( trim( of_get_input( ) ) )

if l_tanto_code <> 0 then
	i_dpara.multiple	= false	// 単一結果で返ってきてほしい
	i_dpara				= dta.of_get_tanto( l_tanto_code )	// データ取得
	
	if not i_dpara.ret then
		msg.of_error( "入力された担当コードはマスタに存在しません。" )
		of_reset( )	// 備考も消す
		return false
	end if
	
	of_set_meisyo( i_dpara.ds.object.tanto_mei[1] )
	
	// 廃番の確認
	if i_dpara.ds.object.haiban_flg[1] <> 1 then
		of_set_bikou( "" )
	else
		of_set_bikou( "廃番" )
	end if
else
	of_reset()	// 備考も消す
	return false
end if

return true
end event

event open_modal;call super::open_modal;
string	l_meisyo_code

i_dpara	= mdl.of_open_tanto()

if i_dpara.ret then
	of_set_input( string( i_dpara.ds.object.tanto_code[1] ) )
	of_set_meisyo( i_dpara.ds.object.tanto_mei[1] )
	
	// 廃番の確認
	if i_dpara.ds.object.haiban_flg[1] <> 1 then
		of_set_bikou( "" )
	else
		of_set_bikou( "廃番" )
	end if
end if

sle_input.setfocus()

return i_dpara.ret
end event

type st_bikou from cv_input`st_bikou within cv_input_tanto
end type

type st_meisyo from cv_input`st_meisyo within cv_input_tanto
end type

type cb_modal from cv_input`cb_modal within cv_input_tanto
end type

type sle_input from cv_input`sle_input within cv_input_tanto
boolean chk_type_num = true
end type

type st_title from cv_input`st_title within cv_input_tanto
string text = "担当者"
end type

