$PBExportHeader$cv_input_kojyo.sru
$PBExportComments$sy_m_kojyoの入力フォーム
forward
global type cv_input_kojyo from cv_input
end type
end forward

global type cv_input_kojyo from cv_input
integer width = 1936
string title_text = "工場仕入先"
long input_width = 300
boolean bikou_visible = false
end type
global cv_input_kojyo cv_input_kojyo

type variables

public:
	str_symkojyo	i_para_kojyo[]	// データの受け渡しをする構造体
	
protected:
	str_symkojyo	i_para_reset[]	// i_para_kojyoを初期化する用の変数
end variables

on cv_input_kojyo.create
call super::create
end on

on cv_input_kojyo.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_kojyo"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_symkojyo	l_mdl_kojyo

// モーダルを開く
l_mdl_kojyo	= mdl.of_open_modal( "wsm_kojyo", l_mdl_kojyo )

if upperbound( l_mdl_kojyo.ret ) > 0 then
	i_para_kojyo								= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_kojyo[upperbound(i_para_kojyo) + 1]	= l_mdl_kojyo.ret[upperbound( l_mdl_kojyo.ret )]
	
//	of_set_input( string( of_get_kojyo_code() ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

type st_bikou from cv_input`st_bikou within cv_input_kojyo
integer x = 1600
end type

type st_meisyo from cv_input`st_meisyo within cv_input_kojyo
integer x = 784
end type

type cb_modal from cv_input`cb_modal within cv_input_kojyo
integer x = 660
end type

type sle_input from cv_input`sle_input within cv_input_kojyo
integer x = 344
integer width = 300
boolean chk_type_num = true
end type

type st_title from cv_input`st_title within cv_input_kojyo
integer x = 12
string text = "工場仕入先"
end type

