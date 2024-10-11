$PBExportHeader$cv_input_yubin.sru
$PBExportComments$m_yubinの入力フォーム
forward
global type cv_input_yubin from cv_input
end type
end forward

global type cv_input_yubin from cv_input
string title_text = "郵便番号"
long input_width = 450
boolean meisyo_visible = false
boolean bikou_visible = false
end type
global cv_input_yubin cv_input_yubin

type variables

public:
	str_myubin	i_para_yubin[]	// データの受け渡しをする構造体
	
protected:
	str_myubin	i_para_reset[]	// i_para_yubinを初期化する用の変数

end variables

forward prototypes
public function string of_get_yubin_no ()
public function string of_get_full_mei ()
end prototypes

public function string of_get_yubin_no ();
// 外部からこの関数を呼んで、郵便番号をreturnする関数

string	l_yubin_no

l_yubin_no	= trim( of_get_input() )

// 入力値があるかどうか確認
if len( l_yubin_no ) = 0 then
	return ""
end if

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_yubin ) = 0 then
	return l_yubin_no
end if

// 入力値をそのまま返す
return i_para_yubin[1].yubin_no
end function

public function string of_get_full_mei ();
// 外部からこの関数を呼んで、フル住所をreturnする関数

if upperbound( i_para_yubin ) = 0 then
	return ""
end if

return i_para_yubin[1].full_mei
end function

on cv_input_yubin.create
call super::create
end on

on cv_input_yubin.destroy
call super::destroy
end on

event resize;
// sle_inputの中心に揃えて合わせる
this.height		= sle_input.height// + 2

st_title.y		= sle_input.y + sle_input.height / 2 - st_title.height / 2
cb_modal.y		= sle_input.y	// sle_inputと高さが一緒
st_meisyo.y		= sle_input.y + sle_input.height / 2 - st_meisyo.height / 2
st_bikou.y		= sle_input.y + sle_input.height / 2 - st_bikou.height / 2

st_title.width	= title_width
sle_input.width	= input_width
st_bikou.width	= bikou_width

if modal_visible then	// cb_modalが見えてる時
	cb_modal.x	= st_title.x + st_title.width + code.MGN_GROUP_YOKO
	sle_input.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO / 3
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO / 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO / 3
			st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO / 3
		else
			st_bikou.visible	= false
			st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO / 3
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO / 3
			sle_input.width	= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO / 3
		else
			st_bikou.visible	= false
			sle_input.width		= this.width - sle_input.x - code.MGN_GROUP_YOKO / 3
		end if
	end if
else
	cb_modal.visible	= false
	sle_input.x			= st_title.x + st_title.width + code.MGN_GROUP_YOKO
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO / 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO / 3
			st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO / 3
		else
			st_bikou.visible	= false
			st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO / 3
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO / 3
			sle_input.width	= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO / 3
		else
			st_bikou.visible	= false
			sle_input.width		= this.width - sle_input.x - code.MGN_GROUP_YOKO / 3
		end if
	end if
end if

end event

event constructor;call super::constructor;
object_type	= "input_yubin"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_myubin	l_mdl_yubin

// モーダルを開く
l_mdl_yubin	= mdl.of_open_modal( "wsm_yubin", l_mdl_yubin )

if upperbound( l_mdl_yubin.ret ) > 0 then
	get											= true
	i_para_yubin								= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_yubin[upperbound(i_para_yubin) + 1]	= l_mdl_yubin.ret[upperbound( l_mdl_yubin.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( i_para_yubin[1].yubin_no )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_item, l_msg
string	l_yubin_no

l_ret			= true
l_yubin_no		= trim( of_get_input( ) )
i_para_yubin	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する

if len( l_yubin_no ) > 0 then
	l_item	= "郵便番号"
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_yubin_get( l_yubin_no, i_para_yubin ) > 0 then
				get	= true
			else
				// 1ならエラーメッセージを表示する
				if i_dbchk_mode = 1 then
					l_msg	= "入力された" + l_item + "はマスタに存在しません。"
					l_ret	= false
				else
					of_reset( "meisyobikou" )
				end if
			end if
		case 2
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_yubin_check( l_yubin_no ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( l_yubin_no, chk_required, l_item, "m_yubin", "yubin_no", l_msg ) then
					of_reset( "meisyobikou" )
				else
					l_ret	= false
				end if
			else
				l_msg	= "入力された" + l_item + "はマスタに存在しています。"
				l_ret	= false
			end if
		case else
			// 何もしない
	end choose
else
	// 入力値が何もないなら何もしない
	of_reset( "meisyobikou" )
end if

// falseの処理
if not l_ret then
	sle_input.of_msg_error( l_msg )
	of_reset( "meisyobikou" )
	sle_input.setfocus()
end if

return l_ret
end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_yubin
integer x = 1664
integer width = 88
end type

type st_meisyo from cv_input`st_meisyo within cv_input_yubin
integer x = 1560
integer width = 72
end type

type cb_modal from cv_input`cb_modal within cv_input_yubin
integer x = 340
end type

type sle_input from cv_input`sle_input within cv_input_yubin
integer x = 484
integer width = 1000
end type

type st_title from cv_input`st_title within cv_input_yubin
string text = "郵便番号"
end type

