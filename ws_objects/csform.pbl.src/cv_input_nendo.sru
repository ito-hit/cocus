$PBExportHeader$cv_input_nendo.sru
$PBExportComments$m_nendoの入力フォーム
forward
global type cv_input_nendo from cv_input
end type
end forward

global type cv_input_nendo from cv_input
string title_text = "年度"
boolean bikou_visible = false
end type
global cv_input_nendo cv_input_nendo

type variables

public:
	str_mnendo		i_para_nendo[]		// データの受け渡しをする構造体
	
protected:
	str_mnendo		i_para_reset[]		// i_para_nendoを初期化する用の変数
end variables

forward prototypes
public function string of_get_nendo_mei ()
public function long of_get_nendo_code ()
public function long of_get_kisyo_date ()
public function long of_get_kimatu_date ()
end prototypes

public function string of_get_nendo_mei ();
// 外部からこの関数を呼んで、事業年度名をreturnする関数

if upperbound( i_para_nendo ) = 0 then
	return ""
end if

return i_para_nendo[1].nendo_mei
end function

public function long of_get_nendo_code ();
// 外部からこの関数を呼んで、年度コードをreturnする関数

string	l_input
long	l_nendo_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_nendo_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_nendo ) = 0 then
	return l_nendo_code
end if

return i_para_nendo[1].nendo_code
end function

public function long of_get_kisyo_date ();
// 外部からこの関数を呼んで、開始日をreturnする関数

if upperbound( i_para_nendo ) = 0 then
	return 0
end if

return i_para_nendo[1].kisyo_date
end function

public function long of_get_kimatu_date ();
// 外部からこの関数を呼んで、終了日をreturnする関数

if upperbound( i_para_nendo ) = 0 then
	return 0
end if

return i_para_nendo[1].kimatu_date
end function

on cv_input_nendo.create
call super::create
end on

on cv_input_nendo.destroy
call super::destroy
end on

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_nendo_code

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_nendo	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "年度コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_nendo_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_nendo_get( l_nendo_code, i_para_nendo ) > 0 then
				get	= true
				of_set_meisyo( of_get_nendo_mei() )
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
			if mst.of_nendo_check( l_nendo_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_nendo_code ), chk_required, l_item, "m_nendo", "nendo_code", l_msg ) then
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






/* 2024.07.25 より以前

string	l_input_code
long	l_nendo_code, l_latest_nendo, l_now_nendo

l_input_code	= trim( of_get_input( ) )

if l_input_code <> "" then
	l_nendo_code	= long( l_input_code )
		
	choose case l_nendo_code	// ここがないと「入力された年度はデータベースに存在しません。」が毎回反応する。
		case is > 0
			if i_exist_result then
				// 変更, 照会, 削除の時
				// 入力データをチェックし、存在するなら同時にoutパラメータも取得する
				if not get.of_nendo( i_str_nendo, l_nendo_code ) then
					msg.of_error( "入力された年度コードはマスタに存在しません。" )
					of_reset()
					return false
				end if
				
				of_set_meisyo( i_str_nendo.out_nendo_mei )
			else
				// 登録の時
				of_set_meisyo( "" )	// 表示をリセット
				
				// 存在しているなら登録できない
				if exist.of_check_nendo( l_nendo_code ) then
					msg.of_error( "データが既に登録されています。" )
					of_reset( )
					return false
				else
					// 翌々期以降の登録を不可とする
					l_now_nendo		= get_now_nendo( )		// sysdateの年度が登録されているなら0以外を格納する
					l_latest_nendo	= get_latest_nendo( )	// 登録されている最新年度を取得する
					
					if l_now_nendo > 0 then
						if ( l_nendo_code - l_now_nendo ) > 1 then	// 78-76 = 2
							msg.of_error( "翌々期以降は登録できません。" )
							of_reset( )
							return false
						end if
					else
						if ( l_nendo_code - l_latest_nendo ) > 1 then	// 78-75 = 3
							msg.of_error( "登録されている最新データの翌々期以降は登録できません。" )	// 要確認
							of_reset( )
							return false
						end if
					end if
				end if
			end if
		case 0
			msg.of_error( "入力された値は登録できません。" )
			of_reset( )
			return false
		case else
			// 何もしない
			//of_reset()
			return false
	end choose
else
	//of_reset()
	return false
end if

return true
*/
end event

event constructor;call super::constructor;
object_type	= "input_nendo"

// 初期化処理
of_reset( "all" )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mnendo	l_mdl_nendo

// モーダルを開く
l_mdl_nendo	= mdl.of_open_modal( "wsm_nendo", l_mdl_nendo )

if upperbound( l_mdl_nendo.ret ) > 0 then
	get											= true
	i_para_nendo								= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_nendo[upperbound(i_para_nendo) + 1]	= l_mdl_nendo.ret[upperbound( l_mdl_nendo.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_nendo[1].nendo_code ) )
	
	this.event sle_input_check()
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_nendo
end type

type st_meisyo from cv_input`st_meisyo within cv_input_nendo
end type

type cb_modal from cv_input`cb_modal within cv_input_nendo
end type

type sle_input from cv_input`sle_input within cv_input_nendo
end type

type st_title from cv_input`st_title within cv_input_nendo
string text = "年度"
end type

