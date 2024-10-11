$PBExportHeader$cv_input_tokui_seikyu.sru
$PBExportComments$m_tokuiの請求先の入力フォーム
forward
global type cv_input_tokui_seikyu from cv_input
end type
end forward

global type cv_input_tokui_seikyu from cv_input
integer width = 2308
string title_text = "請求先"
long input_width = 300
end type
global cv_input_tokui_seikyu cv_input_tokui_seikyu

type variables

public:
	str_mtokui		i_para_seikyu[]			// 呼び出し元とデータの受け渡しをする構造体
	
	boolean			syusoku_hyoji			// 備考に「終息」を表示 ※優先して表示する
	boolean			torihiki_hyoji	= true	// 備考に「取引停止区分」を表示
	
protected:
	str_mtokui		i_para_reset[]			// i_para_seikyuを初期化する用の変数
	long			i_tanto_code			// 担当者の入力フォームからセットされる担当者コード
	
private:
	graphicobject	i_control[]				// 親Windowのコントロールをセットする
end variables

forward prototypes
public function long of_get_tokui_code ()
public function integer of_get_bumon_code ()
public function long of_get_nayose_code ()
public function long of_get_seikyu_code ()
public function long of_get_tanto_code ()
public function string of_get_tokui_mei ()
public function string of_get_tokui_mei_full ()
public function string of_get_tokui_mei_syagai ()
public function string of_get_tokui_mei_ryaku ()
public function string of_get_tokui_mei_kana ()
public function string of_get_yubin_no ()
public function string of_get_jyusyo ()
public function string of_get_tel_no ()
public function string of_get_fax_no ()
public function integer of_get_torihiki_teisi_kbn ()
public function integer of_get_unso_code ()
public function integer of_get_todofuken_code ()
public function long of_get_sikutyoson_code ()
public function integer of_get_syusoku_flg ()
public function integer of_get_syohizei_kbn ()
public function boolean of_set_tanto_code ()
end prototypes

public function long of_get_tokui_code ();
// 外部からこの関数を呼んで、得意先コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].tokui_code

end function

public function integer of_get_bumon_code ();
// 外部からこの関数を呼んで、部門コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].bumon_code
end function

public function long of_get_nayose_code ();
// 外部からこの関数を呼んで、名寄コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].nayose_code
end function

public function long of_get_seikyu_code ();
// 外部からこの関数を呼んで、請求先コードをreturnする関数

string	l_input
long	l_seikyu_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_seikyu_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_seikyu ) = 0 then
	return l_seikyu_code
end if

return i_para_seikyu[1].seikyu_code
end function

public function long of_get_tanto_code ();
// 外部からこの関数を呼んで、担当コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].tanto_code
end function

public function string of_get_tokui_mei ();
// 外部からこの関数を呼んで、得意先名(社内表示名)をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tokui_mei
end function

public function string of_get_tokui_mei_full ();
// 外部からこの関数を呼んで、得意先名をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tokui_mei_full
end function

public function string of_get_tokui_mei_syagai ();
// 外部からこの関数を呼んで、得意先名(社外表示名)をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tokui_mei_syagai
end function

public function string of_get_tokui_mei_ryaku ();
// 外部からこの関数を呼んで、得意先名(略称)をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tokui_mei_ryaku
end function

public function string of_get_tokui_mei_kana ();
// 外部からこの関数を呼んで、得意先名(カナ)をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tokui_mei_kana
end function

public function string of_get_yubin_no ();
// 外部からこの関数を呼んで、郵便番号をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].yubin_no
end function

public function string of_get_jyusyo ();
// 外部からこの関数を呼んで、住所をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].jyusyo
end function

public function string of_get_tel_no ();
// 外部からこの関数を呼んで、電話番号をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].tel_no
end function

public function string of_get_fax_no ();
// 外部からこの関数を呼んで、FAX番号をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return ""
end if

return i_para_seikyu[1].fax_no
end function

public function integer of_get_torihiki_teisi_kbn ();
// 外部からこの関数を呼んで、取引停止区分をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].torihiki_teisi_kbn
end function

public function integer of_get_unso_code ();
// 外部からこの関数を呼んで、運送便コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].unso_code
end function

public function integer of_get_todofuken_code ();
// 外部からこの関数を呼んで、都道府県コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].todofuken_code
end function

public function long of_get_sikutyoson_code ();
// 外部からこの関数を呼んで、市区町村コードをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].sikutyoson_code
end function

public function integer of_get_syusoku_flg ();
// 外部からこの関数を呼んで、終息フラグをreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].syusoku_flg
end function

public function integer of_get_syohizei_kbn ();
// 外部からこの関数を呼んで、消費税区分をreturnする関数

if upperbound( i_para_seikyu ) = 0 then
	return 0
end if

return i_para_seikyu[1].syohizei_kbn
end function

public function boolean of_set_tanto_code ();
// cv_input_tantoを探して得意先コードをインスタンス変数にセットする

boolean			l_ret
long			l_null
long			l_row
graphicobject	l_obj
string			l_typeof

l_ret	= false

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_tanto"があれば、得意先コードをセットする
	if l_typeof = "input_tanto" then
		i_tanto_code	= l_obj.dynamic of_get_tanto_code()
		l_ret			= true
		exit
	end if
next

if not l_ret then
	i_tanto_code	= l_null
end if

return l_ret
end function

on cv_input_tokui_seikyu.create
call super::create
end on

on cv_input_tokui_seikyu.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "input_seikyu"

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mtokui	l_mdl_seikyu

// 担当者コードをセットする
if not of_set_tanto_code() then
	// 今は特になし
end if
msg.of_info( string( i_tanto_code ) )
// モーダルを開く
l_mdl_seikyu.in_tanto_code	= i_tanto_code	// nullかどうかはモーダルに任せる
l_mdl_seikyu				= mdl.of_open_modal( "wsm_seikyu", l_mdl_seikyu )

if upperbound( l_mdl_seikyu.ret ) > 0 then
	get												= true
	i_para_seikyu									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_seikyu[upperbound(i_para_seikyu) + 1]	= l_mdl_seikyu.ret[upperbound( l_mdl_seikyu.ret )]
	
//	// i_tanto_codeがセットされていない場合があるのでここでセットしてやるか？
//	if i_tanto_code = 0 or isnull( i_tanto_code ) then
//		this.of_set_tanto_code( i_para_seikyu[upperbound(i_para_seikyu)].tanto_code )
//	end if

	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_seikyu[1].seikyu_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event sle_input_check;call super::sle_input_check;
boolean		l_ret
string		l_input, l_item, l_msg
long		l_seikyu_code
str_mmeisyo	l_para_meisyo[]
integer		l_syusoku_flg, l_torihiki_teisi_kbn

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_seikyu	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "請求先コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_seikyu_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_tokui_gets( l_seikyu_code, i_para_seikyu ) > 0 then
				get	= true
				of_set_meisyo( of_get_tokui_mei() )
				
				// 備考が表示されているなら
				if bikou_visible then
					// 終息の反映
					if syusoku_hyoji then
						l_syusoku_flg	= of_get_syusoku_flg()
						
						if l_syusoku_flg <> 1 then
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						else
							of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
							of_set_bikou( "終息" )
						end if
					
					// 取引停止区分の反映(名称区分＝106)
					elseif torihiki_hyoji then
						l_torihiki_teisi_kbn	= of_get_torihiki_teisi_kbn()
						
						if l_torihiki_teisi_kbn <> 0 then
							if mst.of_meisyo_get( 106, string( l_torihiki_teisi_kbn ), l_para_meisyo ) > 0 then
								// 文字色の設定
								choose case l_torihiki_teisi_kbn
									case 1
										of_set_bikou_color( "black" )
									case else
										of_set_bikou_color( "red" )
								end choose
							
								of_set_bikou( l_para_meisyo[1].meisyo_1 )
							end if
						else
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						end if
					end if
				end if
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
			if mst.of_tokui_checks( l_seikyu_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_seikyu_code ), chk_required, l_item, "m_tokui", "seikyu_code", l_msg ) then
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
	if chk_required then
		l_msg	= l_item + "は必須入力です。"
		l_ret	= false
	else
		of_reset( "meisyobikou" )
	end if
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

type st_bikou from cv_input`st_bikou within cv_input_tokui_seikyu
integer x = 1984
end type

type st_meisyo from cv_input`st_meisyo within cv_input_tokui_seikyu
integer x = 768
integer width = 1200
end type

type cb_modal from cv_input`cb_modal within cv_input_tokui_seikyu
integer x = 644
end type

type sle_input from cv_input`sle_input within cv_input_tokui_seikyu
integer width = 300
end type

type st_title from cv_input`st_title within cv_input_tokui_seikyu
string text = "請求先"
end type

