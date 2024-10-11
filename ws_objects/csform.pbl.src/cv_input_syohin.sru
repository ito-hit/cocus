$PBExportHeader$cv_input_syohin.sru
$PBExportComments$m_syohinの入力フォーム
forward
global type cv_input_syohin from cv_input
end type
type st_meisyo_hin_mei from sv_st_meisyo within cv_input_syohin
end type
type sle_input_iro from ivo_singlelineedit within cv_input_syohin
end type
type cb_left from ivo_commandbutton within cv_input_syohin
end type
type cb_right from ivo_commandbutton within cv_input_syohin
end type
type st_meisyo_iro_mei from sv_st_meisyo within cv_input_syohin
end type
end forward

global type cv_input_syohin from cv_input
integer width = 3180
string title_text = "コード"
long input_width = 288
long bikou_width = 400
event type long left_execution ( longptr wparam,  longptr lparam )
event type long right_execution ( longptr wparam,  longptr lparam )
event type boolean sle_iro_input_check ( )
st_meisyo_hin_mei st_meisyo_hin_mei
sle_input_iro sle_input_iro
cb_left cb_left
cb_right cb_right
st_meisyo_iro_mei st_meisyo_iro_mei
end type
global cv_input_syohin cv_input_syohin

type variables

public:
	str_msyohin		i_para_syohin[]					// データの受け渡しをする構造体

	long			input_iro_width		= 180
	long			meisyo_width		= 400
	long			iro_mei_width		= 500	// meisyo_hin_meiはresizeで可変する	

	boolean			input_iro_visible	= true	// チェックが入ったらsle_input_iroを表示する
	boolean			arrow_visible		= true	// チェックが入ったらcb_rightとcb_leftを表示する
	boolean			hin_mei_visible		= true	// チェックが入ったらst_meisyo_hin_meiを表示する
	boolean			iro_mei_visible		= true	// チェックが入ったらst_meisyo_iro_meiを表示する

	boolean			syusoku_hyoji		= true	// 備考に「終息」を表示 ※優先して表示する
	boolean			haiban_hyoji				// 備考に「廃番区分」を表示
	boolean			yoyaku_hyoji				// 備考に「予約登録中」を表示
//	boolean			bhin_hyoji					// 備考に「B品」を表示
	
protected:
	str_msyohin		i_para_reset[]				// i_para_syohinを初期化する用の変数
	long			i_tokui_code				// 得意先の入力フォームからセットする得意先コード 予約登録の確認で使用
	
private:
	graphicobject	i_control[]					// 親Windowのコントロールをセットする
end variables

forward prototypes
public function long of_get_syohin_code ()
public subroutine of_set_enabled (boolean p_bool)
public function long of_get_iro_no ()
public function string of_get_size_code ()
public function integer of_get_eda_no ()
public function integer of_get_size_iti ()
public function longlong of_get_sku_code ()
public function string of_get_hin_ban ()
public function string of_get_hin_mei_kana ()
public function string of_get_iro_mei_kana ()
public function string of_get_hin_mei ()
public function string of_get_iro_mei ()
public function string of_get_size_mei ()
public function integer of_get_haiban_kbn ()
public function integer of_get_haiban_flg ()
public function integer of_get_syusoku_flg ()
public function integer of_get_bettyu_flg ()
public function long of_get_tokui_code ()
public function long of_get_bukken_code ()
public function integer of_get_bhin_flg ()
public function integer of_get_touroku_kbn ()
public function boolean of_chk_tanka_yoyaku (long p_tokui_code, long p_syohin_code)
public subroutine of_set_input_iro (string p_text)
public subroutine of_set_meisyo_hin_mei (string p_text)
public function string of_get_meisyo_hin_mei ()
public function string of_get_input_iro ()
public subroutine of_set_meisyo_iro_mei (string p_text)
public function string of_get_meisyo_iro_mei ()
public function boolean of_syohin_next (ref long p_syohin_code, ref long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
public function boolean of_syohin_prev (ref long p_syohin_code, ref long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
public function integer of_get_bettyu_flg (long p_iro_no, string p_size_code)
public function integer of_get_bettyu_flg (long p_iro_no)
public function integer of_get_bhin_flg (long p_iro_no, string p_size_code)
public function integer of_get_bhin_flg (long p_iro_no)
public function long of_get_bukken_code (long p_iro_no, string p_size_code)
public function long of_get_bukken_code (long p_iro_no)
public function integer of_get_haiban_flg (long p_iro_no, string p_size_code)
public function integer of_get_haiban_flg (long p_iro_no)
public function integer of_get_haiban_kbn (long p_iro_no, string p_size_code)
public function integer of_get_haiban_kbn (long p_iro_no)
public function string of_get_hin_ban (long p_iro_no, string p_size_code)
public function string of_get_hin_ban (long p_iro_no)
public function string of_get_hin_mei (long p_iro_no, string p_size_code)
public function string of_get_hin_mei (long p_iro_no)
public function string of_get_hin_mei_kana (long p_iro_no, string p_size_code)
public function string of_get_hin_mei_kana (long p_iro_no)
public function string of_get_iro_mei (long p_iro_no, string p_size_code)
public function string of_get_iro_mei (long p_iro_no)
public function string of_get_iro_mei_kana (long p_iro_no, string p_size_code)
public function string of_get_iro_mei_kana (long p_iro_no)
public function integer of_get_size_iti (long p_iro_no, string p_size_code)
public function integer of_get_size_iti (long p_iro_no)
public function string of_get_size_mei (long p_iro_no, string p_size_code)
public function string of_get_size_mei (long p_iro_no)
public function longlong of_get_sku_code (long p_iro_no, string p_size_code)
public function longlong of_get_sku_code (long p_iro_no)
public function integer of_get_syusoku_flg (long p_iro_no, string p_size_code)
public function integer of_get_syusoku_flg (long p_iro_no)
public function long of_get_tokui_code (long p_iro_no, string p_size_code)
public function long of_get_tokui_code (long p_iro_no)
public function integer of_get_touroku_kbn (long p_iro_no, string p_size_code)
public function integer of_get_touroku_kbn (long p_iro_no)
public subroutine of_reset (string p_reset_object)
public function boolean of_set_tokui_code ()
end prototypes

event type long left_execution(longptr wparam, longptr lparam);
// cb_leftのexecutionイベントがこのイベントを呼び出す

// 入力されている商品コード(・色番)の前の商品を検索し表示する
// 一番最初の商品まで表示したら、最大商品に進む

long	l_syohin_code, l_iro_no
string	l_hin_ban, l_hin_mei, l_iro_mei
string	l_syohin_code_str, l_iro_no_str

l_syohin_code_str	= trim( of_get_input() )
l_iro_no_str		= trim( of_get_input_iro() )

// 商品コードが入力されていないなら、検索しない
if len( l_syohin_code_str ) <> 0 then
	l_syohin_code	= long( l_syohin_code_str )
else
	return -1
end if

// 色番が入力されていないならnullで検索 商品コードだけでカウントダウンする
if len( l_iro_no_str ) <> 0 then
	l_iro_no	= long( l_iro_no_str )
else
	setnull( l_iro_no )
end if

// 次の商品を検索
if not of_syohin_prev( l_syohin_code, l_iro_no, l_hin_ban, l_hin_mei, l_iro_mei ) then
	return -1
end if

// 検索に成功したら、値をセットしていく
of_set_input( string( l_syohin_code ) )

// 色番が入力されていたらセットする
if len( l_iro_no_str ) <> 0 then
	of_set_input_iro( string( l_iro_no ) )
end if

of_set_meisyo( l_hin_ban )
of_set_meisyo_hin_mei( l_hin_mei )

// 色番が入力されていたらセットする
if len( l_iro_no_str ) <> 0 then
	of_set_meisyo_iro_mei( l_iro_mei )
end if

return 0
end event

event type long right_execution(longptr wparam, longptr lparam);
// cb_rightのexecutionイベントがこのイベントを呼び出す

// 入力されている商品コード(・色番)の次の商品を検索し表示する
// 最終商品まで表示したら、最小商品に戻る

long	l_syohin_code, l_iro_no
string	l_hin_ban, l_hin_mei, l_iro_mei
string	l_syohin_code_str, l_iro_no_str

l_syohin_code_str	= trim( of_get_input() )
l_iro_no_str		= trim( of_get_input_iro() )

// 商品コードが入力されていないなら、検索しない
if len( l_syohin_code_str ) <> 0 then
	l_syohin_code	= long( l_syohin_code_str )
else
	return -1
end if

// 色番が入力されていないならnullで検索 商品コードだけでカウントアップする
if len( l_iro_no_str ) <> 0 then
	l_iro_no	= long( l_iro_no_str )
else
	setnull( l_iro_no )
end if

// 次の商品を検索
if not of_syohin_next( l_syohin_code, l_iro_no, l_hin_ban, l_hin_mei, l_iro_mei ) then
	return -1
end if

// 検索に成功したら、値をセットしていく
of_set_input( string( l_syohin_code ) )

// 色番が入力されていたらセットする
if len( l_iro_no_str ) <> 0 then
	of_set_input_iro( string( l_iro_no ) )
end if

of_set_meisyo( l_hin_ban )
of_set_meisyo_hin_mei( l_hin_mei )

// 色番が入力されていたらセットする
if len( l_iro_no_str ) <> 0 then
	of_set_meisyo_iro_mei( l_iro_mei )
end if

return 0
end event

event type boolean sle_iro_input_check();
boolean		l_ret
string		l_input, l_input_iro, l_item, l_msg
long		l_syohin_code, l_iro_no
str_mmeisyo	l_para_meisyo[]
integer		l_syusoku_flg, l_haiban_kbn, l_bhin_flg

l_ret		= true
l_input		= trim( of_get_input( ) )		// 1つめのシングルラインエディット：商品コード
l_input_iro	= trim( of_get_input_iro( ) )	// 2つめのシングルラインエディット：色番
l_item		= "色番"

// 入力チェック
if len( l_input_iro ) > 0 and l_ret then
	// 数値チェック
	if not isnumber( l_input_iro ) then
		sle_input_iro.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input_iro ) )
		return false
	end if
	
	l_iro_no		= long( l_input_iro )
	
	// 色番の入力がない時に初期化されると商品コードのデータ取得が無駄になるので、ここで初期化する
	get				= false
	i_para_syohin	= i_para_reset
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			l_syohin_code	= long( l_input )
			
			// 存在チェックとついでにデータ取得
			if mst.of_syohin_get( l_syohin_code, l_iro_no, i_para_syohin ) > 0 then
				get			= true
				l_iro_no	= of_get_iro_no()	// 色番を取得したものに更新

				of_set_meisyo( of_get_hin_ban( l_iro_no ) )
				of_set_meisyo_hin_mei( of_get_hin_mei( l_iro_no ) )
				of_set_meisyo_iro_mei( of_get_iro_mei( l_iro_no ) )
				
				// 備考が表示されているなら
				if bikou_visible then
					// 終息の反映
					if syusoku_hyoji then
						l_syusoku_flg	= of_get_syusoku_flg( l_iro_no )
						
						if l_syusoku_flg <> 1 then
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						else
							of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
							of_set_bikou( "終息" )
						end if
					
					// 廃番区分の反映(名称区分＝106)
					elseif haiban_hyoji then
						l_haiban_kbn	= of_get_haiban_kbn( l_iro_no )
						
						if l_haiban_kbn <> 0 then
							if mst.of_meisyo_get( 106, string( l_haiban_kbn ), l_para_meisyo ) > 0 then
								// 文字色の設定
								choose case l_haiban_kbn
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
					
					// 予約登録中の反映 引数のnullチェックは関数内で行う
					elseif yoyaku_hyoji then
						// 得意先コードをセットする
						if not of_set_tokui_code() then
							// 今は特になし
						end if
						
						if of_chk_tanka_yoyaku( i_tokui_code, of_get_syohin_code() ) then
							of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
							of_set_bikou( "予約登録中" )
						else
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						end if
					
					// // B品フラグの反映
					// elseif bhin_hyoji then
					// 	l_bhin_flg	= of_get_bhin_flg()
						
					// 	if l_bhin_flg <> 1 then
					// 		of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
					// 	else
					// 		of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
					// 		of_set_bikou( "B品" )
					// 	end if
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
			// 重複チェック時は商品コードの入力は必要
			if len( l_input ) = 0 then
				sle_input.of_msg_error( "商品コードが入力されていません。" )
				sle_input.setfocus()
				return false
			end if
			
			l_syohin_code	= long( l_input )
			
			// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
			if mst.of_syohin_check( l_syohin_code, l_iro_no ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_iro_no ), chk_required, l_item, "m_syohin", "iro_no", l_msg ) then
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
	// 必須かつ色の入力が見えているとき
	if chk_required and input_iro_visible then
		l_msg	= l_item + "は必須入力です。"
		l_ret	= false
	else
		of_reset( "meisyobikou" )
	end if
end if

// falseの処理
if not l_ret then
	sle_input_iro.of_msg_error( l_msg )
	of_reset( "meisyobikou" )
	sle_input_iro.setfocus()
end if

return l_ret
end event

public function long of_get_syohin_code ();
// 外部からこの関数を呼んで、商品コードをreturnする関数

string	l_input
long	l_syohin_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_syohin_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_syohin ) = 0 then
	return l_syohin_code
end if

return i_para_syohin[1].syohin_code
end function

public subroutine of_set_enabled (boolean p_bool);
// sle_inputとsle_input_iroとcb_modal、cb_left・rightの使用可能を制御する

this.sle_input.enabled		= p_bool
this.sle_input_iro.enabled	= p_bool

this.cb_modal.enabled		= p_bool
this.cb_left.enabled		= p_bool
this.cb_right.enabled		= p_bool
end subroutine

public function long of_get_iro_no ();
// 外部からこの関数を呼んで、色番をreturnする関数
string	l_input_iro
long	l_iro_no
long	l_null

// 色番が表示中でかつ、入力がないならnullを返す
l_input_iro	= trim( of_get_input_iro() )
setnull( l_null )

if input_iro_visible and len( l_input_iro ) = 0 then
	return l_null
end if

l_iro_no	= long( l_input_iro )

if upperbound( i_para_syohin ) = 0 then
	// 色番が表示中なら入力値、表示中ではないならnullを返す
	if input_iro_visible then
		return l_iro_no
	else
		return l_null
	end if
end if

return i_para_syohin[1].iro_no
end function

public function string of_get_size_code ();
// 外部からこの関数を呼んで、サイズコードをreturnする関数

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

return trim( i_para_syohin[1].size_code )
end function

public function integer of_get_eda_no ();
// 外部からこの関数を呼んで、枝番をreturnする関数

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

return i_para_syohin[1].eda_no
end function

public function integer of_get_size_iti ();
// 外部からこの関数を呼んで、サイズ位置をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_size_iti( l_long_null, l_string_null )
end function

public function longlong of_get_sku_code ();
// 外部からこの関数を呼んで、SKUコードをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_sku_code( l_long_null, l_string_null )
end function

public function string of_get_hin_ban ();
// 外部からこの関数を呼んで、品番をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_hin_ban( l_long_null, l_string_null )

end function

public function string of_get_hin_mei_kana ();
// 外部からこの関数を呼んで、カナ品名をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_hin_mei_kana( l_long_null, l_string_null )
end function

public function string of_get_iro_mei_kana ();
// 外部からこの関数を呼んで、カナ色名をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_iro_mei_kana( l_long_null, l_string_null )
end function

public function string of_get_hin_mei ();
// 外部からこの関数を呼んで、品名をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_hin_mei( l_long_null, l_string_null )
end function

public function string of_get_iro_mei ();
// 外部からこの関数を呼んで、色名をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_iro_mei( l_long_null, l_string_null )
end function

public function string of_get_size_mei ();
// 外部からこの関数を呼んで、サイズ名をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_size_mei( l_long_null, l_string_null )
end function

public function integer of_get_haiban_kbn ();
// 外部からこの関数を呼んで、廃番区分をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_haiban_kbn( l_long_null, l_string_null )
end function

public function integer of_get_haiban_flg ();
// 外部からこの関数を呼んで、廃番フラグをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_haiban_flg( l_long_null, l_string_null )
end function

public function integer of_get_syusoku_flg ();
// 外部からこの関数を呼んで、終息フラグをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_syusoku_flg( l_long_null, l_string_null )
end function

public function integer of_get_bettyu_flg ();
// 外部からこの関数を呼んで、別注フラグをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_bettyu_flg( l_long_null, l_string_null )
end function

public function long of_get_tokui_code ();
// 外部からこの関数を呼んで、得意先コード(別注対象)をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_tokui_code( l_long_null, l_string_null )
end function

public function long of_get_bukken_code ();
// 外部からこの関数を呼んで、物件コードをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_bukken_code( l_long_null, l_string_null )
end function

public function integer of_get_bhin_flg ();
// 外部からこの関数を呼んで、B品フラグをreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_bhin_flg( l_long_null, l_string_null )
end function

public function integer of_get_touroku_kbn ();
// 外部からこの関数を呼んで、登録区分をreturnする関数

long	l_long_null
string	l_string_null

setnull( l_long_null )
setnull( l_string_null )

return of_get_touroku_kbn( l_long_null, l_string_null )
end function

public function boolean of_chk_tanka_yoyaku (long p_tokui_code, long p_syohin_code);
// 単価マスターから引数の得意先コード・商品コードを検索し、単価を予約登録中かどうか確認する
// return：True：予約登録中　False：予約なし

str_mtanka	l_tanka[]
long		l_sysdate

// 引数のnullは許可しない
if isnull( p_tokui_code ) or p_tokui_code <= 0 then
	return false
end if

if isnull( p_syohin_code ) or p_syohin_code <= 0 then
	return false
end if

if mst.of_tanka_get( p_tokui_code, p_syohin_code, l_tanka ) > 0 then
	select to_number( to_char( sysdate, 'yyyymmdd' ) )
	  into :l_sysdate
	  from dual
	using cocos;
	
	if cocos.sqlcode <> 0 then
		return false
	end if
	
	// 当日と新単価適用日を比較して、当日 > 新単価適用日なら新単価が適用されているので、予約中ではない
	if l_sysdate > l_tanka[1].tekiyo_date_str then
		return false
	end if
end if

return true
end function

public subroutine of_set_input_iro (string p_text);
// sle_input_iroにパラメータのstringをセットする関数
sle_input_iro.text = p_text
end subroutine

public subroutine of_set_meisyo_hin_mei (string p_text);
// st_meisyo_hin_meiにパラメータのstringをセットする関数
st_meisyo_hin_mei.text = p_text
end subroutine

public function string of_get_meisyo_hin_mei ();
// st_meisyo_hin_meiのテキストを出力する関数
return st_meisyo_hin_mei.text
end function

public function string of_get_input_iro ();
// sle_input_iroのテキストを出力する関数
return sle_input_iro.text
end function

public subroutine of_set_meisyo_iro_mei (string p_text);
// st_meisyo_iro_meiにパラメータのstringをセットする関数
st_meisyo_iro_mei.text = p_text
end subroutine

public function string of_get_meisyo_iro_mei ();
// st_meisyo_iro_meiのテキストを出力する関数
return st_meisyo_iro_mei.text
end function

public function boolean of_syohin_next (ref long p_syohin_code, ref long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);
// 引数の商品コード・色番の次の商品を取得する 色番はnullも可
// 色番が最後なら次の商品コードを(名称も含めて)取得する
// 一番最終まで行ったら、最小商品コード・最小色番を取得する
// True：次の商品の取得成功　False：取得失敗

long	l_nlong
string	l_nstring
long	l_syohin_code, l_iro_no
string	l_hin_ban, l_hin_mei, l_iro_mei

setnull( l_nlong )
setnull( l_nstring )

// 商品検索 引数の次の商品がヒットしなければ最小コードの商品を返す
select syohin_code,iro_no,
       hin_ban, hin_mei, iro_mei
  into :l_syohin_code, :l_iro_no,
       :l_hin_ban, :l_hin_mei, :l_iro_mei
  from ( select rank,
                min( rank ) over() min_rank,
                syohin_code,iro_no,
                hin_ban, hin_mei, iro_mei
           from ( /* --- 引数の商品の次の商品 --- */
                  select 1 rank,
                         syohin_code,iro_no,
                         hin_ban, hin_mei, iro_mei
                    from ( select syohin_code,iro_no,
                                  max( hin_ban ) hin_ban,
                                  max( hin_mei ) hin_mei,
                                  max( iro_mei ) iro_mei,
                                  min( syohin_code * 1000 + iro_no ) syoiro,
                                  min( syohin_code * 1000 + iro_no ) over() syoiro_ovr
                             from m_syohin
                            where decode( :p_iro_no , null, syohin_code, syohin_code * 1000 + iro_no )	> decode( :p_iro_no , null, :p_syohin_code, :p_syohin_code * 1000 + :p_iro_no )
                            group by syohin_code,iro_no
                         )
                   where syoiro	= syoiro_ovr

                  union all

                  /* --- 最小コードの商品 --- */
                  select 2 rank,
                         syohin_code,iro_no,
                         hin_ban, hin_mei, iro_mei
                    from ( select syohin_code,iro_no,
                                  max( hin_ban ) hin_ban,
                                  max( hin_mei ) hin_mei,
                                  max( iro_mei ) iro_mei,
                                  min( syohin_code * 1000 + iro_no ) syoiro,
                                  min( syohin_code * 1000 + iro_no ) over() syoiro_ovr
                             from m_syohin
                            group by syohin_code,iro_no
                         )
                   where syoiro	= syoiro_ovr
                )
       )
 where rank	= min_rank
using cocos;

if cocos.sqlcode <> 0 then
	p_syohin_code	= l_nlong
	p_iro_no		= l_nlong
	p_hin_ban		= l_nstring
	p_hin_mei		= l_nstring
	p_iro_mei		= l_nstring
	
	return false
end if

p_syohin_code	= l_syohin_code
p_iro_no		= l_iro_no
p_hin_ban		= l_hin_ban
p_hin_mei		= l_hin_mei
p_iro_mei		= l_iro_mei

return true
end function

public function boolean of_syohin_prev (ref long p_syohin_code, ref long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);
// 引数の商品コード・色番の前の商品を取得する 色番はnullも可
// 色番が最初ならさらに前の商品コードを(名称も含めて)取得する
// 一番最初まで戻ったら、最大商品コード・最大色番を取得する
// True：前の商品の取得成功　False：取得失敗

long	l_nlong
string	l_nstring
long	l_syohin_code, l_iro_no
string	l_hin_ban, l_hin_mei, l_iro_mei

setnull( l_nlong )
setnull( l_nstring )

// 商品検索 引数の前の商品がヒットしなければ最大コードの商品を返す
select syohin_code,iro_no,
       hin_ban, hin_mei, iro_mei
  into :l_syohin_code, :l_iro_no,
       :l_hin_ban, :l_hin_mei, :l_iro_mei
  from ( select rank,
                min( rank ) over() min_rank,
                syohin_code,iro_no,
                hin_ban, hin_mei, iro_mei
           from ( /* --- 引数の商品の前の商品 --- */
                  select 1 rank,
                         syohin_code,iro_no,
                         hin_ban, hin_mei, iro_mei
                    from ( select syohin_code,iro_no,
                                  max( hin_ban ) hin_ban,
                                  max( hin_mei ) hin_mei,
                                  max( iro_mei ) iro_mei,
                                  max( syohin_code * 1000 + iro_no ) syoiro,
                                  max( syohin_code * 1000 + iro_no ) over() syoiro_ovr
                             from m_syohin
                            where decode( :p_iro_no , null, syohin_code, syohin_code * 1000 + iro_no )	< decode( :p_iro_no , null, :p_syohin_code, :p_syohin_code * 1000 + :p_iro_no )
                            group by syohin_code,iro_no
                         )
                   where syoiro	= syoiro_ovr

                  union all

                  /* --- 最大コードの商品 --- */
                  select 2 rank,
                         syohin_code,iro_no,
                         hin_ban, hin_mei, iro_mei
                    from ( select syohin_code,iro_no,
                                  max( hin_ban ) hin_ban,
                                  max( hin_mei ) hin_mei,
                                  max( iro_mei ) iro_mei,
                                  max( syohin_code * 1000 + iro_no ) syoiro,
                                  max( syohin_code * 1000 + iro_no ) over() syoiro_ovr
                             from m_syohin
                            group by syohin_code,iro_no
                         )
                   where syoiro	= syoiro_ovr
                )
       )
 where rank	= min_rank
using cocos;

if cocos.sqlcode <> 0 then
	p_syohin_code	= l_nlong
	p_iro_no		= l_nlong
	p_hin_ban		= l_nstring
	p_hin_mei		= l_nstring
	p_iro_mei		= l_nstring
	
	return false
end if

p_syohin_code	= l_syohin_code
p_iro_no		= l_iro_no
p_hin_ban		= l_hin_ban
p_hin_mei		= l_hin_mei
p_iro_mei		= l_iro_mei

return true
end function

public function integer of_get_bettyu_flg (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、別注フラグをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の別注フラグをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].bettyu_flg
end if

// サイズコードがnullなら、引数の色番の先頭の別注フラグをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].bettyu_flg
		end if
	next
end if

// 別注フラグを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら別注フラグをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].bettyu_flg
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_bettyu_flg (long p_iro_no);
// 外部からこの関数を呼んで、別注フラグをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_bettyu_flg( p_iro_no, l_string_null )
end function

public function integer of_get_bhin_flg (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、B品フラグをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭のB品フラグをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].bhin_flg
end if

// サイズコードがnullなら、引数の色番の先頭のB品フラグをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].bhin_flg
		end if
	next
end if

// B品フラグを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらB品フラグをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].bhin_flg
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_bhin_flg (long p_iro_no);
// 外部からこの関数を呼んで、B品フラグをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_bhin_flg( p_iro_no, l_string_null )
end function

public function long of_get_bukken_code (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、物件コードをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の物件コードをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].bukken_code
end if

// サイズコードがnullなら、引数の色番の先頭の物件コードをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].bukken_code
		end if
	next
end if

// 物件コードを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら物件コードをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].bukken_code
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function long of_get_bukken_code (long p_iro_no);
// 外部からこの関数を呼んで、物件コードをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_bukken_code( p_iro_no, l_string_null )
end function

public function integer of_get_haiban_flg (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、廃番フラグをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の廃番フラグをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].haiban_flg
end if

// サイズコードがnullなら、引数の色番の先頭の廃番フラグをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].haiban_flg
		end if
	next
end if

// 廃番フラグを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら廃番フラグをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].haiban_flg
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_haiban_flg (long p_iro_no);
// 外部からこの関数を呼んで、廃番フラグをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_haiban_flg( p_iro_no, l_string_null )
end function

public function integer of_get_haiban_kbn (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、廃番区分をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の廃番区分をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].haiban_kbn
end if

// サイズコードがnullなら、引数の色番の先頭の廃番区分をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].haiban_kbn
		end if
	next
end if

// 廃番区分を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら廃番区分をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].haiban_kbn
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_haiban_kbn (long p_iro_no);
// 外部からこの関数を呼んで、廃番区分をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_haiban_kbn( p_iro_no, l_string_null )
end function

public function string of_get_hin_ban (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、品番をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭の品番をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].hin_ban
end if

// サイズコードがnullなら、引数の色番の先頭の品番をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].hin_ban
		end if
	next
end if

// 品番を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら品番をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].hin_ban
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_hin_ban (long p_iro_no);
// 外部からこの関数を呼んで、品番をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_hin_ban( p_iro_no, l_string_null )

end function

public function string of_get_hin_mei (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、品名をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭の品名をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].hin_mei
end if

// サイズコードがnullなら、引数の色番の先頭の品名をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].hin_mei
		end if
	next
end if

// 品名を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら品名をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].hin_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_hin_mei (long p_iro_no);
// 外部からこの関数を呼んで、品名をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_hin_mei( p_iro_no, l_string_null )
end function

public function string of_get_hin_mei_kana (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、カナ品名をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭のカナ品名をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].hin_mei_kana
end if

// サイズコードがnullなら、引数の色番の先頭のカナ品名をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].hin_mei_kana
		end if
	next
end if

// カナ品名を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらカナ品名をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].hin_mei_kana
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_hin_mei_kana (long p_iro_no);
// 外部からこの関数を呼んで、カナ品名をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_hin_mei_kana( p_iro_no, l_string_null )
end function

public function string of_get_iro_mei (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、色名をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭の色名をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].iro_mei
end if

// サイズコードがnullなら、引数の色番の先頭の色名をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].iro_mei
		end if
	next
end if

// 色名を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら色名をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].iro_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_iro_mei (long p_iro_no);
// 外部からこの関数を呼んで、色名をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_iro_mei( p_iro_no, l_string_null )
end function

public function string of_get_iro_mei_kana (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、カナ色名をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭のカナ色名をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].iro_mei_kana
end if

// サイズコードがnullなら、引数の色番の先頭のカナ色名をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].iro_mei_kana
		end if
	next
end if

// カナ色名を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらカナ色名をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].iro_mei_kana
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_iro_mei_kana (long p_iro_no);
// 外部からこの関数を呼んで、カナ色名をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_iro_mei_kana( p_iro_no, l_string_null )
end function

public function integer of_get_size_iti (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、サイズ位置をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭のサイズ位置をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].size_iti
end if

// サイズコードがnullなら、引数の色番の先頭のサイズ位置をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].size_iti
		end if
	next
end if

// サイズ位置を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらサイズ位置をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].size_iti
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_size_iti (long p_iro_no);
// 外部からこの関数を呼んで、サイズ位置をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_size_iti( p_iro_no, l_string_null )
end function

public function string of_get_size_mei (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、サイズ名をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return ""
end if

// 色番がnullなら先頭のサイズ名をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].size_mei
end if

// サイズコードがnullなら、引数の色番の先頭のサイズ名をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].size_mei
		end if
	next
end if

// サイズ名を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらサイズ名をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].size_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_size_mei (long p_iro_no);
// 外部からこの関数を呼んで、サイズ名をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_size_mei( p_iro_no, l_string_null )
end function

public function longlong of_get_sku_code (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、SKUコードをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭のSKUコードをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].sku_code
end if

// サイズコードがnullなら、引数の色番の先頭のSKUコードをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].sku_code
		end if
	next
end if

// SKUコードを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したらSKUコードをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].sku_code
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function longlong of_get_sku_code (long p_iro_no);
// 外部からこの関数を呼んで、SKUコードをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_sku_code( p_iro_no, l_string_null )
end function

public function integer of_get_syusoku_flg (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、終息フラグをreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の終息フラグをreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].syusoku_flg
end if

// サイズコードがnullなら、引数の色番の先頭の終息フラグをreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].syusoku_flg
		end if
	next
end if

// 終息フラグを構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら終息フラグをreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].syusoku_flg
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_syusoku_flg (long p_iro_no);
// 外部からこの関数を呼んで、終息フラグをreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_syusoku_flg( p_iro_no, l_string_null )
end function

public function long of_get_tokui_code (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、得意先コード(別注対象)をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の得意先コード(別注対象)をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].tokui_code
end if

// サイズコードがnullなら、引数の色番の先頭の得意先コード(別注対象)をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].tokui_code
		end if
	next
end if

// 得意先コード(別注対象)を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら得意先コード(別注対象)をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].tokui_code
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function long of_get_tokui_code (long p_iro_no);
// 外部からこの関数を呼んで、得意先コード(別注対象)をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_tokui_code( p_iro_no, l_string_null )
end function

public function integer of_get_touroku_kbn (long p_iro_no, string p_size_code);
// 外部からこの関数を呼んで、登録区分をreturnする関数

long	l_iro_no
string	l_size_code
long	l_row_max, l_count

if upperbound( i_para_syohin ) = 0 then
	return -1
end if

// 色番がnullなら先頭の登録区分をreturnする
l_iro_no	= p_iro_no

if isnull( l_iro_no ) then
	return i_para_syohin[1].touroku_kbn
end if

// サイズコードがnullなら、引数の色番の先頭の登録区分をreturnする
l_size_code	= trim( p_size_code )

if len( l_size_code ) = 0 or isnull( l_size_code ) then
	l_row_max	= upperbound( i_para_syohin )
	
	for l_count = 1 to l_row_max
		if i_para_syohin[l_count].iro_no = l_iro_no then
			return i_para_syohin[l_count].touroku_kbn
		end if
	next
end if

// 登録区分を構造体から検索する
l_row_max	= upperbound( i_para_syohin )

for l_count = 1 to l_row_max
	if i_para_syohin[l_count].iro_no = l_iro_no then
		// 色番とサイズコードが一致したら登録区分をreturnする size_codeがcharなのでtrimをかける
		if trim( i_para_syohin[l_count].size_code ) = l_size_code then
			return i_para_syohin[l_count].touroku_kbn
		end if
	end if
next

// 何も一致しなかったら
return -1
end function

public function integer of_get_touroku_kbn (long p_iro_no);
// 外部からこの関数を呼んで、登録区分をreturnする関数

string	l_string_null

setnull( l_string_null )

return of_get_touroku_kbn( p_iro_no, l_string_null )
end function

public subroutine of_reset (string p_reset_object);
// sle_input、st_meisyo、st_bikouを初期化する関数

choose case p_reset_object
	case "all"
		// すべて初期化
		sle_input.text			= ""
		st_meisyo.text			= ""
		st_bikou.text			= ""
		
		sle_input_iro.text		= ""
		st_meisyo_hin_mei.text	= ""
		st_meisyo_iro_mei.text	= ""
	case "meisyobikou"
		// meisyoとbikouを初期化 iroも初期化
		st_meisyo.text			= ""
		st_bikou.text			= ""
		
		st_meisyo_hin_mei.text	= ""
		st_meisyo_iro_mei.text	= ""
	case "meisyo"
		// meisyoを初期化 iroも初期化
		st_meisyo.text			= ""
		
		st_meisyo_hin_mei.text	= ""
		st_meisyo_iro_mei.text	= ""
	case "bikou"
		// bikouを初期化
		st_bikou.text	= ""
	case else
		// 何もしない
end choose
end subroutine

public function boolean of_set_tokui_code ();
// cv_input_tokuiを探して得意先コードをインスタンス変数にセットする

boolean			l_ret
long			l_null
long			l_row
graphicobject	l_obj
string			l_typeof

l_ret	= false
setnull( l_null )

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_tokui"があれば、得意先コードをセットする
	if l_typeof = "input_tokui" then
		i_tokui_code	= l_obj.dynamic of_get_tokui_code()
		l_ret			= true
		exit
	end if
next

if not l_ret then
	i_tokui_code	= l_null
end if

return l_ret
end function

on cv_input_syohin.create
int iCurrent
call super::create
this.st_meisyo_hin_mei=create st_meisyo_hin_mei
this.sle_input_iro=create sle_input_iro
this.cb_left=create cb_left
this.cb_right=create cb_right
this.st_meisyo_iro_mei=create st_meisyo_iro_mei
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_meisyo_hin_mei
this.Control[iCurrent+2]=this.sle_input_iro
this.Control[iCurrent+3]=this.cb_left
this.Control[iCurrent+4]=this.cb_right
this.Control[iCurrent+5]=this.st_meisyo_iro_mei
end on

on cv_input_syohin.destroy
call super::destroy
destroy(this.st_meisyo_hin_mei)
destroy(this.sle_input_iro)
destroy(this.cb_left)
destroy(this.cb_right)
destroy(this.st_meisyo_iro_mei)
end on

event resize;
// sle_inputの中心に揃えて合わせる
this.height				= sle_input.height// + 2

st_title.y				= sle_input.y + sle_input.height / 2 - st_title.height / 2
sle_input_iro.y			= sle_input.y
cb_modal.y				= sle_input.y	// sle_inputと高さが一緒
cb_left.y				= sle_input.y	// sle_inputと高さが一緒
cb_right.y				= sle_input.y	// sle_inputと高さが一緒
st_meisyo.y				= sle_input.y + sle_input.height / 2 - st_meisyo.height / 2
st_meisyo_hin_mei.y		= sle_input.y + sle_input.height / 2 - st_meisyo_hin_mei.height / 2
st_meisyo_iro_mei.y		= sle_input.y + sle_input.height / 2 - st_meisyo_iro_mei.height / 2
st_bikou.y				= sle_input.y + sle_input.height / 2 - st_bikou.height / 2

st_title.width			= title_width
sle_input.width			= input_width
sle_input_iro.width		= input_iro_width
st_meisyo.width			= meisyo_width
st_meisyo_iro_mei.width	= iro_mei_width
st_bikou.width			= bikou_width

sle_input.x				= st_title.x + st_title.width + code.MGN_GROUP_YOKO /// 3

// sle_input_iroが見えてるとき
if input_iro_visible then
	sle_input_iro.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
	
	// cb_modalが見えてるとき
	if modal_visible then
		cb_modal.x	= sle_input_iro.x + sle_input_iro.width + code.MGN_GROUP_YOKO /// 3
		
		// cb_left・cb_rightが見えてるとき
		if arrow_visible then
			cb_left.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
			cb_right.x	= cb_left.x + cb_left.width + code.MGN_GROUP_YOKO /// 3
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_right.x + cb_right.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_meisyo_iro_meiが見えてるとき
					if iro_mei_visible then
						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_iro_mei.x		= st_bikou.x - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_iro_mei.x		= this.width - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					else
						st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示

						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示
					st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo_hin_meiが非表示ならmeisyo_iro_meiも表示しない

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない
				st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo1が非表示ならmeisyo_iro_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_right.x		= st_bikou.x - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x		= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x		= cb_left.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x	= cb_modal.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_right.x			= this.width - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x			= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= cb_left.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x		= cb_modal.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			cb_left.visible		= false	// cb_leftを非表示
			cb_right.visible	= false	// cb_rightを非表示
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_meisyo_iro_meiが見えてるとき
					if iro_mei_visible then
						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_iro_mei.x		= st_bikou.x - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_iro_mei.x		= this.width - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					else
						st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示

						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示
					st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo_hin_meiが非表示ならmeisyo_iro_meiも表示しない

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない
				st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo1が非表示ならmeisyo_iro_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x		= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x	= cb_modal.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_modal.x			= this.width - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x		= cb_modal.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	else
		cb_modal.visible	= false	// cb_modalを非表示
		
		// cb_left・cb_rightが見えてるとき
		if arrow_visible then
			cb_left.x	= sle_input_iro.x + sle_input_iro.width + code.MGN_GROUP_YOKO /// 3
			cb_right.x	= cb_left.x + cb_left.width + code.MGN_GROUP_YOKO /// 3
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_right.x + cb_right.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_meisyo_iro_meiが見えてるとき
					if iro_mei_visible then
						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_iro_mei.x		= st_bikou.x - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_iro_mei.x		= this.width - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					else
						st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示

						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示
					st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo_hin_meiが非表示ならmeisyo_iro_meiも表示しない

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない
				st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo1が非表示ならmeisyo_iro_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_right.x		= st_bikou.x - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x		= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x	= cb_left.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_right.x			= this.width - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x			= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x		= cb_left.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			cb_left.visible		= false	// cb_leftを非表示
			cb_right.visible	= false	// cb_rightを非表示
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= sle_input_iro.x + sle_input_iro.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_meisyo_iro_meiが見えてるとき
					if iro_mei_visible then
						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_iro_mei.x		= st_bikou.x - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_iro_mei.x		= this.width - st_meisyo_iro_mei.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_meisyo_iro_mei.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					else
						st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示

						// st_bikouが見えてるとき
						if bikou_visible then
							st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
							st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						else
							st_bikou.visible		= false	// st_bikouを非表示
							st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
						end if
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示
					st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo_hin_meiが非表示ならmeisyo_iro_meiも表示しない

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない
				st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiを非表示 meisyo1が非表示ならmeisyo_iro_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input_iro.x	= st_bikou.x - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					sle_input_iro.x		= this.width - sle_input_iro.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= sle_input_iro.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	end if
else
	sle_input_iro.visible		= false	// sle_input_iroを非表示
	st_meisyo_iro_mei.visible	= false	// st_meisyo_iro_meiも同時に非表示にする

	// cb_modalが見えてるとき
	if modal_visible then
		cb_modal.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
		
		// cb_left・cb_rightが見えてるとき
		if arrow_visible then
			cb_left.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
			cb_right.x	= cb_left.x + cb_left.width + code.MGN_GROUP_YOKO /// 3
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_right.x + cb_right.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible		= false	// st_bikouを非表示
						st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_right.x		= st_bikou.x - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x		= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x		= cb_left.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_right.x			= this.width - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x			= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= cb_left.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			cb_left.visible		= false	// cb_leftを非表示
			cb_right.visible	= false	// cb_rightを非表示
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible		= false	// st_bikouを非表示
						st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x		= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_modal.x			= this.width - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	else
		cb_modal.visible	= false	// cb_modalを非表示
		
		// cb_left・cb_rightが見えてるとき
		if arrow_visible then
			cb_left.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
			cb_right.x	= cb_left.x + cb_left.width + code.MGN_GROUP_YOKO /// 3
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= cb_right.x + cb_right.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible		= false	// st_bikouを非表示
						st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_right.x		= st_bikou.x - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x		= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= cb_left.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					cb_right.x			= this.width - cb_right.width - code.MGN_GROUP_YOKO /// 3
					cb_left.x			= cb_right.x - cb_left.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_left.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			cb_left.visible		= false	// cb_leftを非表示
			cb_right.visible	= false	// cb_rightを非表示
			
			// st_meisyoが見えてるとき
			if meisyo_visible then
				st_meisyo.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
				
				// st_meisyo_hin_meiが見えてるとき
				if hin_mei_visible then
					st_meisyo_hin_mei.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo_hin_mei.width	= st_bikou.x - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible		= false	// st_bikouを非表示
						st_meisyo_hin_mei.width	= this.width - st_meisyo_hin_mei.x - code.MGN_GROUP_YOKO /// 3
					end if
				else
					st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示

					// st_bikouが見えてるとき
					if bikou_visible then
						st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
						st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					else
						st_bikou.visible	= false	// st_bikouを非表示
						st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
					end if
				end if
			else
				st_meisyo.visible			= false	// st_meisyoを非表示
				st_meisyo_hin_mei.visible	= false	// st_meisyo_hin_meiを非表示 meisyo1が非表示ならmeisyo_hin_meiも表示しない

				// st_bikouが見えてるとき
				if bikou_visible then
					st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width	= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_bikou.visible	= false	// st_bikouを非表示
					sle_input.width		= this.width - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	end if
end if

end event

event constructor;call super::constructor;
object_type	= "input_syohin"

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納

// 色番の入力がない
if not input_iro_visible then
	iro_mei_visible	= false	// 色名は表示しない
	
	this.event resize( 1, 1, 1 )
else
	// 必須入力のセット
//	sle_input_iro.chk_required	= this.chk_required
end if

// 初期化処理
of_reset( "all" )

return 0
end event

event sle_input_check;call super::sle_input_check;
boolean		l_ret
string		l_input, l_item, l_msg
long		l_syohin_code
str_mmeisyo	l_para_meisyo[]
integer		l_syusoku_flg, l_haiban_kbn, l_bhin_flg

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_syohin	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "商品コード"

if len( l_input ) > 0 then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_syohin_code	= long( l_input )
	
	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// 存在チェックとついでにデータ取得
			if mst.of_syohin_get( l_syohin_code, i_para_syohin ) > 0 then
				get	= true
				
				// input_iroが表示中かどうかチェック 表示されていないなら名称と備考の表示はここで行う
				if not input_iro_visible then
					of_set_meisyo( of_get_hin_ban() )
					of_set_meisyo_hin_mei( of_get_hin_mei() )
					
					// 備考の表示
					// 終息の反映
					if syusoku_hyoji then
						l_syusoku_flg	= of_get_syusoku_flg()
						
						if l_syusoku_flg <> 1 then
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						else
							of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
							of_set_bikou( "終息" )
						end if
					
					// 廃番区分の反映(名称区分＝106)
					elseif haiban_hyoji then
						l_haiban_kbn	= of_get_haiban_kbn()
						
						if l_haiban_kbn <> 0 then
							if mst.of_meisyo_get( 106, string( l_haiban_kbn ), l_para_meisyo ) > 0 then
								// 文字色の設定
								choose case l_haiban_kbn
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

					// 予約登録中の反映 引数のnullチェックは関数内で行う
					elseif yoyaku_hyoji then
						// 得意先コードをセットする
						if not of_set_tokui_code() then
							// 今は特になし
						end if

						if of_chk_tanka_yoyaku( i_tokui_code, of_get_syohin_code() ) then
							of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
							of_set_bikou( "予約登録中" )
						else
							of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
						end if
					
					// // B品フラグの反映
					// elseif bhin_hyoji then
					// 	l_bhin_flg	= of_get_bhin_flg()
						
					// 	if l_bhin_flg <> 1 then
					// 		of_reset( "bikou" )	// 前の備考が残っているときがあるので、リセットする
					// 	else
					// 		of_set_bikou_color( "red" )	// 文字色が変更されている場合がある
					// 		of_set_bikou( "B品" )
					// 	end if
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
			if mst.of_syohin_check( l_syohin_code ) <> 0 then
				// 「登録」するため値の適正チェックをしておく
				if fnc.of_chk_column_info( string( l_syohin_code ), chk_required, l_item, "m_syohin", "syohin_code", l_msg ) then
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

event open_modal;call super::open_modal;
str_mdlpara_msyohin	l_mdl_syohin

// モーダルを開く
l_mdl_syohin	= mdl.of_open_modal( "wsm_syohin", l_mdl_syohin )

if upperbound( l_mdl_syohin.ret ) > 0 then
	get												= true
	i_para_syohin									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_syohin[upperbound(i_para_syohin) + 1]	= l_mdl_syohin.ret[upperbound( l_mdl_syohin.ret )]
	
	// 入力値がない時もあるので、モーダルが取得した値をセット
	of_set_input( string( i_para_syohin[1].syohin_code ) )
	
	if input_iro_visible then
		of_set_input_iro( string( i_para_syohin[1].iro_no ) )
	end if
	
	this.event sle_input_check()
	
	if input_iro_visible then
		this.event sle_iro_input_check()
	end if
end if

sle_input.setfocus()

return true

end event

event getfocus;call super::getfocus;
sle_input.setfocus( )
end event

type st_bikou from cv_input`st_bikou within cv_input_syohin
integer x = 2824
end type

type st_meisyo from cv_input`st_meisyo within cv_input_syohin
integer x = 1288
integer width = 500
end type

type cb_modal from cv_input`cb_modal within cv_input_syohin
integer x = 948
end type

type sle_input from cv_input`sle_input within cv_input_syohin
integer width = 300
end type

type st_title from cv_input`st_title within cv_input_syohin
integer y = 7
string text = "コード"
end type

type st_meisyo_hin_mei from sv_st_meisyo within cv_input_syohin
integer x = 1800
integer y = 4
integer width = 500
boolean bringtotop = true
string text = ""
end type

type sle_input_iro from ivo_singlelineedit within cv_input_syohin
integer x = 636
integer taborder = 20
boolean bringtotop = true
integer init_imemode = 3
string text = ""
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
this.i_function_name	= i_sle_function_name
//this.enabled			= true
end event

event getfocus;call super::getfocus;
// 親のwindowのget_focusesを呼び出す。
parent.event getfocuses( "sle2" )
end event

event input_check;call super::input_check;
// 親のwindowのsle_iro_input_checkを呼び出す。
return parent.event sle_iro_input_check()
end event

event key_f08;call super::key_f08;
// open_modal イベントをコールする
return long( parent.event open_modal() )	// 本当はparentのkey_f08イベントを呼ぶほうががいいかも
end event

event losefocus;call super::losefocus;
// 親のwindowのlose_focusesを呼び出す。
parent.event losefocuses( "sle2" )
end event

type cb_left from ivo_commandbutton within cv_input_syohin
integer x = 1064
integer width = 108
boolean bringtotop = true
string text = "←"
end type

event constructor;call super::constructor;
this.visible	= arrow_visible
end event

event execution;call super::execution;
// 親のwindowのleft_executionを呼び出す。
parent.event left_execution( wparam, lparam )
end event

event losefocus;call super::losefocus;
// 親のwindowのlose_focusesを呼び出す。
parent.event losefocuses( "left" )
end event

event getfocus;call super::getfocus;
// 親のwindowのget_focusesを呼び出す。
parent.event getfocuses( "left" )
end event

type cb_right from ivo_commandbutton within cv_input_syohin
integer x = 1172
integer width = 108
boolean bringtotop = true
string text = "→"
end type

event constructor;call super::constructor;
this.visible	= arrow_visible
end event

event execution;call super::execution;
// 親のwindowのright_executionを呼び出す。
parent.event right_execution( wparam, lparam )
end event

event losefocus;call super::losefocus;
// 親のwindowのlose_focusesを呼び出す。
parent.event losefocuses( "right" )
end event

event getfocus;call super::getfocus;
// 親のwindowのget_focusesを呼び出す。
parent.event getfocuses( "right" )
end event

type st_meisyo_iro_mei from sv_st_meisyo within cv_input_syohin
integer x = 2308
integer y = 4
integer width = 500
boolean bringtotop = true
string text = ""
end type

