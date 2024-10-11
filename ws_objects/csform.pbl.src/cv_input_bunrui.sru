$PBExportHeader$cv_input_bunrui.sru
$PBExportComments$m_bunruiの入力フォーム
forward
global type cv_input_bunrui from cv_input
end type
end forward

global type cv_input_bunrui from cv_input
string title_text = "分類"
boolean bikou_visible = false
end type
global cv_input_bunrui cv_input_bunrui

type variables

public:
	str_mbunrui		i_para_bunrui[]			// 呼び出し元とデータの受け渡しをする構造体
	
	boolean			daibunrui	= true		// True：大分類の入力フォームとして使用　False：大分類ではない
	boolean			tyubunrui				// True：中分類の入力フォームとして使用　False：中分類ではない
	boolean			syobunrui				// True：小分類の入力フォームとして使用　False：小分類ではない
	
protected:
	str_mbunrui		i_para_reset[]			// i_para_bunruiを初期化する用の変数
	
	long			i_daibunrui_code		// 大分類の分類フォームからセットされる大分類コード
	long			i_tyubunrui_code		// 中分類の分類フォームからセットされる中分類コード 小分類コードは最下層のため他からセットされない

private:
	graphicobject	i_control[]				// 親Windowのコントロールをセットする
end variables
forward prototypes
public function long of_get_daibunrui_code ()
public function long of_get_tyubunrui_code ()
public function long of_get_syobunrui_code ()
public function string of_get_daibunrui_mei (long p_tyubunrui_code, long p_syobunrui_code)
public function string of_get_daibunrui_mei ()
public function string of_get_daibunrui_mei (long p_tyubunrui_code)
public function string of_get_tyubunrui_mei (long p_tyubunrui_code, long p_syobunrui_code)
public function string of_get_tyubunrui_mei ()
public function string of_get_tyubunrui_mei (long p_tyubunrui_code)
public function string of_get_syobunrui_mei (long p_tyubunrui_code, long p_syobunrui_code)
public function string of_get_syobunrui_mei ()
public function string of_get_syobunrui_mei (long p_tyubunrui_code)
public function boolean of_set_daibunrui_code ()
public function boolean of_set_tyubunrui_code ()
end prototypes

public function long of_get_daibunrui_code ();
// 外部からこの関数を呼んで、大分類コードをreturnする関数

string	l_input
long	l_bunrui_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_bunrui_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_bunrui ) = 0 then
	// 自分が大分類の時だけ入力値を返す
	if daibunrui then
		return l_bunrui_code
	else
		return l_null
	end if
end if

return i_para_bunrui[1].daibunrui_code
end function

public function long of_get_tyubunrui_code ();
// 外部からこの関数を呼んで、中分類コードをreturnする関数

string	l_input
long	l_bunrui_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_bunrui_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_bunrui ) = 0 then
	// 自分が中分類の時だけ入力値を返す
	if tyubunrui then
		return l_bunrui_code
	else
		return l_null
	end if
end if

return i_para_bunrui[1].tyubunrui_code
end function

public function long of_get_syobunrui_code ();
// 外部からこの関数を呼んで、小分類コードをreturnする関数

string	l_input
long	l_bunrui_code
long	l_null

l_input	= trim( of_get_input() )
setnull( l_null )

// 入力値があるかどうか確認 なければnullを返す
if len( l_input ) = 0 then
	return l_null
end if

l_bunrui_code	= long( l_input )

// まずは構造体にデータが格納されているかを確認 されていなければ入力値を返す
if upperbound( i_para_bunrui ) = 0 then
	// 自分が小分類の時だけ入力値を返す
	if syobunrui then
		return l_bunrui_code
	else
		return l_null
	end if
end if

return i_para_bunrui[1].syobunrui_code
end function

public function string of_get_daibunrui_mei (long p_tyubunrui_code, long p_syobunrui_code);
// 外部からこの関数を呼んで、大分類名をreturnする関数

long	l_tyubunrui_code, l_syobunrui_code
long	l_row_max, l_count

if upperbound( i_para_bunrui ) = 0 then
	return ""
end if

// 中分類コードがnullなら先頭の大分類名をreturnする
l_tyubunrui_code	= p_tyubunrui_code

if isnull( l_tyubunrui_code ) then
	return i_para_bunrui[1].daibunrui_mei
end if

// 小分類コードがnullなら、引数の中分類コードの先頭の大分類名をreturnする
l_syobunrui_code	= p_syobunrui_code

if isnull( l_syobunrui_code ) then
	l_row_max	= upperbound( i_para_bunrui )
	
	for l_count = 1 to l_row_max
		if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
			return i_para_bunrui[l_count].daibunrui_mei
		end if
	next
end if

// 大分類名を構造体から検索する
l_row_max	= upperbound( i_para_bunrui )

for l_count = 1 to l_row_max
	if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
		// 中分類コードと小分類コードが一致したら大分類名をreturnする
		if i_para_bunrui[l_count].syobunrui_code = l_syobunrui_code then
			return i_para_bunrui[l_count].daibunrui_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_daibunrui_mei ();
// 外部からこの関数を呼んで、大分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_daibunrui_mei( l_null, l_null )
end function

public function string of_get_daibunrui_mei (long p_tyubunrui_code);
// 外部からこの関数を呼んで、大分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_daibunrui_mei( p_tyubunrui_code, l_null )
end function

public function string of_get_tyubunrui_mei (long p_tyubunrui_code, long p_syobunrui_code);
// 外部からこの関数を呼んで、中分類名をreturnする関数

long	l_tyubunrui_code, l_syobunrui_code
long	l_row_max, l_count

if upperbound( i_para_bunrui ) = 0 then
	return ""
end if

// 中分類コードがnullなら先頭の中分類名をreturnする
l_tyubunrui_code	= p_tyubunrui_code

if isnull( l_tyubunrui_code ) then
	return i_para_bunrui[1].tyubunrui_mei
end if

// 小分類コードがnullなら、引数の中分類コードの先頭の中分類名をreturnする
l_syobunrui_code	= p_syobunrui_code

if isnull( l_syobunrui_code ) then
	l_row_max	= upperbound( i_para_bunrui )
	
	for l_count = 1 to l_row_max
		if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
			return i_para_bunrui[l_count].tyubunrui_mei
		end if
	next
end if

// 中分類名を構造体から検索する
l_row_max	= upperbound( i_para_bunrui )

for l_count = 1 to l_row_max
	if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
		// 中分類コードと小分類コードが一致したら中分類名をreturnする
		if i_para_bunrui[l_count].syobunrui_code = l_syobunrui_code then
			return i_para_bunrui[l_count].tyubunrui_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_tyubunrui_mei ();
// 外部からこの関数を呼んで、中分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_tyubunrui_mei( l_null, l_null )
end function

public function string of_get_tyubunrui_mei (long p_tyubunrui_code);
// 外部からこの関数を呼んで、中分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_tyubunrui_mei( p_tyubunrui_code, l_null )
end function

public function string of_get_syobunrui_mei (long p_tyubunrui_code, long p_syobunrui_code);
// 外部からこの関数を呼んで、小分類名をreturnする関数

long	l_tyubunrui_code, l_syobunrui_code
long	l_row_max, l_count

if upperbound( i_para_bunrui ) = 0 then
	return ""
end if

// 中分類コードがnullなら先頭の小分類名をreturnする
l_tyubunrui_code	= p_tyubunrui_code

if isnull( l_tyubunrui_code ) then
	return i_para_bunrui[1].syobunrui_mei
end if

// 小分類コードがnullなら、引数の中分類コードの先頭の小分類名をreturnする
l_syobunrui_code	= p_syobunrui_code

if isnull( l_syobunrui_code ) then
	l_row_max	= upperbound( i_para_bunrui )
	
	for l_count = 1 to l_row_max
		if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
			return i_para_bunrui[l_count].syobunrui_mei
		end if
	next
end if

// 小分類名を構造体から検索する
l_row_max	= upperbound( i_para_bunrui )

for l_count = 1 to l_row_max
	if i_para_bunrui[l_count].tyubunrui_code = l_tyubunrui_code then
		// 中分類コードと小分類コードが一致したら小分類名をreturnする
		if i_para_bunrui[l_count].syobunrui_code = l_syobunrui_code then
			return i_para_bunrui[l_count].syobunrui_mei
		end if
	end if
next

// 何も一致しなかったら
return ""
end function

public function string of_get_syobunrui_mei ();
// 外部からこの関数を呼んで、小分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_syobunrui_mei( l_null, l_null )
end function

public function string of_get_syobunrui_mei (long p_tyubunrui_code);
// 外部からこの関数を呼んで、小分類名をreturnする関数

long	l_null

setnull( l_null )

return of_get_syobunrui_mei( p_tyubunrui_code, l_null )
end function

public function boolean of_set_daibunrui_code ();
// cv_input_daibunruiを探して大分類コードをインスタンス変数にセットする

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
	
	// object_typeに"input_daibunrui"があれば、大分類コードをセットする
	if l_typeof = "input_daibunrui" then
		i_daibunrui_code	= l_obj.dynamic of_get_daibunrui_code()
		l_ret				= true
		exit
	end if
next

if not l_ret then
	i_daibunrui_code	= l_null
end if

return l_ret
end function

public function boolean of_set_tyubunrui_code ();
// cv_input_tyubunruiを探して中分類コードをインスタンス変数にセットする

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
	
	// object_typeに"input_tyubunrui"があれば、中分類コードをセットする
	if l_typeof = "input_tyubunrui" then
		i_tyubunrui_code	= l_obj.dynamic of_get_tyubunrui_code()
		l_ret				= true
		exit
	end if
next

if not l_ret then
	i_tyubunrui_code	= l_null
end if

return l_ret
end function

on cv_input_bunrui.create
call super::create
end on

on cv_input_bunrui.destroy
call super::destroy
end on

event constructor;call super::constructor;
//object_type	= "input_bunrui"

// どの分類コードの入力フォームか確認してタイトルを変更
if daibunrui then
	object_type	= "input_daibunrui"
	of_set_title( "大分類" )
	
	// 一応falseにしておく
	tyubunrui		= false
	syobunrui		= false
elseif tyubunrui then
	object_type	= "input_tyubunrui"
	of_set_title( "中分類" )
	
	// 一応falseにしておく
	daibunrui	= false
	syobunrui	= false
else
	syobunrui	= true
	
	object_type	= "input_syobunrui"
	of_set_title( "小分類" )
	
	// 一応falseにしておく
	daibunrui	= false
	tyubunrui	= false
end if

parent.dynamic of_get_controls( i_control )	// ウィンドウのコントロールを全て格納

// 初期化処理
of_reset( "all" )

//setnull( i_daibunrui_code )
//setnull( i_tyubunrui_code )

return 0
end event

event open_modal;call super::open_modal;
str_mdlpara_mbunrui	l_mdl_bunrui

// モーダルを開く
l_mdl_bunrui	= mdl.of_open_modal( "wsm_syohin_bunrui", l_mdl_bunrui )

if upperbound( l_mdl_bunrui.ret ) > 0 then
	get												= true
	i_para_bunrui									= i_para_reset	// マスタからデータ取得しているかもしれないので初期化する
	i_para_bunrui[upperbound(i_para_bunrui) + 1]	= l_mdl_bunrui.ret[upperbound( l_mdl_bunrui.ret )]
	
	// どの分類コードの入力フォームか確認して値をセット 入力値がない時もあるので、モーダルが取得した値をセット
	if daibunrui then
		of_set_input( string( i_para_bunrui[1].daibunrui_code ) )
	elseif tyubunrui then
		of_set_input( string( i_para_bunrui[1].tyubunrui_code ) )
	else
		of_set_input( string( i_para_bunrui[1].syobunrui_code ) )
	end if
	
	this.event sle_input_check()	// 呼ぶと、「存在チェックモードかつ関係性チェックしない」ときに、input_checkで名称が初期化されるので↑で名称までセットする
end if

sle_input.setfocus()

return true

end event

event sle_input_check;call super::sle_input_check;
boolean	l_ret
string	l_input, l_item, l_msg
long	l_bunrui_code

l_ret			= true
l_input			= trim( of_get_input( ) )
i_para_bunrui	= i_para_reset	// モーダルでデータ取得しているかもしれないので初期化する
l_item			= "分類コード"

// 入力チェック
if len( l_input ) > 0 and l_ret then
	// 数値チェック
	if not isnumber( l_input ) then
		sle_input.of_msg_error( fnc.strg.of_format( "数値以外の文字が入力されています。（入力：{1}）", l_input ) )
		return false
	end if
	
	l_bunrui_code	= long( l_input )

	// 自分が中分類か小分類の時は、親分類コードをセットする
	if tyubunrui or syobunrui then
		if not of_set_daibunrui_code() then
			// 今は特になし
		end if
	end if

	if syobunrui then
		if not of_set_tyubunrui_code() then
			// 今は特になし
		end if
	end if

	// i_dbchk_modeによって○○チェックをする
	choose case i_dbchk_mode
		case 0, 1
			// --- 大分類の場合 ----------------------------------------------------------------------------//
			if daibunrui then
				// 存在チェックとついでにデータ取得
				if mst.of_bunrui_get( l_bunrui_code, i_para_bunrui ) > 0 then
					get	= true
					of_set_meisyo( of_get_daibunrui_mei() )
				else
					// 1ならエラーメッセージを表示する
					if i_dbchk_mode = 1 then
						l_msg	= "入力された大" + l_item + "はマスタに存在しません。"
						l_ret	= false
					else
						of_reset( "meisyobikou" )
					end if
				end if

			// --- 中分類の場合 ----------------------------------------------------------------------------//
			elseif tyubunrui then
				// データ取得と存在チェック
				if mst.of_bunrui_get( i_daibunrui_code, l_bunrui_code, i_para_bunrui ) > 0 then
					get	= true
					of_set_meisyo( of_get_tyubunrui_mei( l_bunrui_code ) )
				else
					// 1ならエラーメッセージを表示する
					if i_dbchk_mode = 1 then
						l_msg	= "入力された中" + l_item + "はマスタに存在しません。"
						l_ret	= false
					else
						of_reset( "meisyobikou" )
					end if
				end if

			// --- 小分類の場合 ----------------------------------------------------------------------------//
			else
				// データ取得と存在チェック
				if mst.of_bunrui_get( i_daibunrui_code, i_tyubunrui_code, l_bunrui_code, i_para_bunrui ) > 0 then
					get	= true
					of_set_meisyo( of_get_syobunrui_mei( i_tyubunrui_code, l_bunrui_code ) )
				else
					// 1ならエラーメッセージを表示する
					if i_dbchk_mode = 1 then
						l_msg	= "入力された小" + l_item + "はマスタに存在しません。"
						l_ret	= false
					else
						of_reset( "meisyobikou" )
					end if
				end if
			end if

		case 2
			// --- 大分類の場合 ----------------------------------------------------------------------------//
			if daibunrui then
				// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
				if mst.of_bunrui_check( l_bunrui_code ) <> 0 then
					// 「登録」するため値の適正チェックをしておく
					if fnc.of_chk_column_info( string( l_bunrui_code ), chk_required, l_item, "m_bunrui", "daibunrui_code", l_msg ) then
						of_reset( "meisyobikou" )
					else
						l_ret	= false
					end if
				else
					l_msg	= "入力された大" + l_item + "はマスタに存在しています。"
					l_ret	= false
				end if
			
			// --- 中分類の場合 ----------------------------------------------------------------------------//
			elseif tyubunrui then
				// 重複チェック時は親分類コードの入力は必要
				if isnull( i_daibunrui_code ) then
					sle_input.of_msg_error( "大" + l_item + "が入力されていません。" )
					sle_input.setfocus()
					return false
				end if

				// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
				if mst.of_bunrui_check( i_daibunrui_code, l_bunrui_code ) <> 0 then
					// 「登録」するため値の適正チェックをしておく
					if fnc.of_chk_column_info( string( l_bunrui_code ), chk_required, l_item, "m_bunrui", "tyubunrui_code", l_msg ) then
						of_reset( "meisyobikou" )
					else
						l_ret	= false
					end if
				else
					l_msg	= "入力された中" + l_item + "はマスタに存在しています。"
					l_ret	= false
				end if

			// --- 小分類の場合 ----------------------------------------------------------------------------//
			else
				// 重複チェック時は親分類コードの入力は必要
				if isnull( i_daibunrui_code ) then
					sle_input.of_msg_error( "大" + l_item + "が入力されていません。" )
					sle_input.setfocus()
					return false
				end if

				if isnull( i_tyubunrui_code ) then
					sle_input.of_msg_error( "中" + l_item + "が入力されていません。" )
					sle_input.setfocus()
					return false
				end if

				// 重複チェックをする 「登録」時を想定してるので重複はエラーとする 重複しなければtrue
				if mst.of_bunrui_check( i_daibunrui_code, i_tyubunrui_code, l_bunrui_code ) <> 0 then
					// 「登録」するため値の適正チェックをしておく
					if fnc.of_chk_column_info( string( l_bunrui_code ), chk_required, l_item, "m_bunrui", "syobunrui_code", l_msg ) then
						of_reset( "meisyobikou" )
					else
						l_ret	= false
					end if
				else
					l_msg	= "入力された小" + l_item + "はマスタに存在しています。"
					l_ret	= false
				end if
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

type st_bikou from cv_input`st_bikou within cv_input_bunrui
end type

type st_meisyo from cv_input`st_meisyo within cv_input_bunrui
end type

type cb_modal from cv_input`cb_modal within cv_input_bunrui
end type

type sle_input from cv_input`sle_input within cv_input_bunrui
end type

event modified;call super::modified;/*
// 親Windowのcontrolを確認し、object_typeに"input_bunrui"があれば、自分類コードをそのオブジェクトのインスタンス変数にセットする

boolean			l_empty
long			l_row, l_cnt
long			l_null
string			l_typeof
//string			l_tyubunrui_name[], l_syobunrui_name[]
graphicobject	l_obj
//cv_input_bunrui	l_uo_bunrui

// 自分が小分類の入力フォームならセットする対象がいないので、ここはスキップ
if syobunrui then
	return 0
end if

// 入力の確認
if trim( this.text ) <> "" then
	l_empty	= false
else
	// テキストが空っぽだった
	l_empty	= true
	setnull( l_null )
end if

//// 自分類コードをセットしたいinput_bunruiの名前を格納しておく	2024.09.13 H.Yamamoto 必要になったら戻す
//if daibunrui then
//	l_tyubunrui_name	= fnc.strg.of_split( uo_tyubunrui_name, "," )
//	l_syobunrui_name	= fnc.strg.of_split( uo_syobunrui_name, "," )
//else
//	l_syobunrui_name	= fnc.strg.of_split( uo_syobunrui_name, "," )
//end if

// 取得した親Windowのコントロールを確認する
for l_row = 1 to upperbound( i_control )
	l_obj		= i_control[l_row]
	l_typeof	= l_obj.dynamic of_typeof()
	
	// object_typeに"input_tyubunrui"があれば、自分類コードをセットする
	if l_typeof = "input_tyubunrui" then

		// 自分が大分類
		if daibunrui then
			// テキストが空っぽじゃなければ、取得している大分類コードをセット
			if not l_empty then
				l_obj.dynamic of_set_daibunrui_code( parent.of_get_daibunrui_code( ) )
			else
				l_obj.dynamic of_set_daibunrui_code( l_null )
			end if
		end if

	// object_typeに"input_syobunrui"があれば、自分類コードをセットする
	elseif l_typeof = "input_syobunrui" then
		// 自分が大分類
		if daibunrui then
			// テキストが空っぽじゃなければ、取得している大分類コードをセット
			if not l_empty then
				l_obj.dynamic of_set_daibunrui_code( parent.of_get_daibunrui_code( ) )
			else
				l_obj.dynamic of_set_daibunrui_code( l_null )
			end if
		
		// 自分が中分類
		elseif tyubunrui then
			// テキストが空っぽじゃなければ、取得している中分類コードをセット
			if not l_empty then
				l_obj.dynamic of_set_tyubunrui_code( parent.of_get_tyubunrui_code( ) )
			else
				l_obj.dynamic of_set_tyubunrui_code( l_null )
			end if
		end if
	end if
next

return 0*/







/*	2024.09.13 H.Yamamoto 分類コードのセットが複数ある(得意先コード+店コード+送り店コードみたいな)時が出たら改修する

	// object_typeに"input_bunrui"があれば、自分類コードをセットする
	if l_typeof = "input_bunrui" then
		l_uo_bunrui	= l_obj		// ローカルにセットしないと名前とか取得できない

		/* --- 自分が大分類 ---------------------------------------------------------------------------- */
		if daibunrui then
			// 大分類コードを中分類コードにセット セットする対象がなければ小分類コードをセットしにいく
			for l_cnt = 1 to upperbound( l_tyubunrui_name )
				// セットしたいinput_bunruiが見つかったら、大分類コードをセットする
				if l_uo_bunrui.classname() = l_tyubunrui_name[l_cnt] then
					// テキストが空っぽじゃなければ、取得している大分類コードをセット
					if not l_empty then
						l_uo_bunrui.dynamic of_set_daibunrui_code( parent.of_get_daibunrui_code( ) )
					else
						l_uo_bunrui.dynamic of_set_daibunrui_code( l_null )
					end if

					// 大分類コードをセットできたら、tyubunrui_nameの確認は抜け出す
					exit
				end if
			next

			// for文を抜け出してない(中分類コードをセットしていない)ので、小分類コードをセットしにいく
			for l_cnt = 1 to upperbound( l_syobunrui_name )
				// セットしたいinput_bunruiが見つかったら、大分類コードをセットする
				if l_uo_bunrui.classname() = l_syobunrui_name[l_cnt] then
					// テキストが空っぽじゃなければ、取得している大分類コードをセット
					if not l_empty then
						l_uo_bunrui.dynamic of_set_daibunrui_code( parent.of_get_daibunrui_code( ) )
					else
						l_uo_bunrui.dynamic of_set_daibunrui_code( l_null )
					end if

					// 大分類コードをセットできたら、syobunrui_nameの確認は抜け出す
					exit
				end if
			next
		end if

		/* --- 自分が中分類 ---------------------------------------------------------------------------- */
		if tyubunrui then
			// 中分類コードを小分類コードにセット
			for l_cnt = 1 to upperbound( l_syobunrui_name )
				// セットしたいinput_bunruiが見つかったら、中分類コードをセットする
				if l_uo_bunrui.classname() = l_syobunrui_name[l_cnt] then
					// テキストが空っぽじゃなければ、取得している中分類コードをセット
					if not l_empty then
						l_uo_bunrui.dynamic of_set_tyubunrui_code( parent.of_get_tyubunrui_code( ) )
					else
						l_uo_bunrui.dynamic of_set_tyubunrui_code( l_null )
					end if

					// 中分類コードをセットできたら、syobunrui_nameの確認は抜け出す
					exit
				end if
			next
		end if
	end if

*/
end event

type st_title from cv_input`st_title within cv_input_bunrui
string text = "分類"
end type

