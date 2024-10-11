$PBExportHeader$nv_modal.sru
$PBExportComments$modalを開くときの仲介をするノンビジュアルオブジェクト
forward
global type nv_modal from inv_object
end type
type lstr_window from structure within nv_modal
end type
end forward

type lstr_window from structure
	string		win_name
	window		win_obj
end type

global type nv_modal from inv_object
event type str_dpara control_event ( string p_object,  str_dpara p_dpara )
end type
global nv_modal nv_modal

type variables

private:
	datastore			i_ds_modal	// modal内でdatastoreに渡すデータの大元を生成すると、closeしたときに(rowscopyしてても)nv_modalにデータが渡らない。何も入ってない。
	nv_data_container	con			// データコンテナのテスト_20230517
end variables

forward prototypes
public function string of_replace_object (string p_object)
public function str_dpara of_get_data (string p_dwo, str_dpara p_dpara)
public function string of_sqlmake_where (string p_column, string p_operator, string p_value1, string p_value2)
public function string of_sqlmake_where (string p_column, string p_operator, string p_value)
public function str_dpara of_open_tanto ()
public function str_dpara of_open_menu ()
public function str_dpara of_open_tab (string p_menu_id)
public function str_dpara of_open_meisyo_parent ()
public function str_dpara of_open_tokui ()
public function str_dpara of_open_mise (long p_tokui_code)
end prototypes

event type str_dpara control_event(string p_object, str_dpara p_dpara);// of_get_dataとof_open_modalのメイン処理イベント p_objectの名称によって、データ取得とモーダル表示の処理を分岐させる

str_dpara	l_dpara
string		l_dwo		// モーダル もしくは containerのdatastoreにセットするデータウィンドウオブジェクト
string		l_modal		// データ取得時に、multipleの条件によって開くモーダルwindow名
window		l_win		// モーダルのopenwithparamで使う空window
integer		l_ret

l_dpara				= p_dpara
l_dpara.visibled	= true		// 初期値がfalseなのでここでvisibledをtrueにしておかないと、モーダル表示の条件でi_ds_modalがセットされない

// "d_～"ならデータ取得
if mid( p_object, 1, 1 ) = "d" then
	l_dwo			= p_object
	l_modal			= of_replace_object( p_object )

	l_dpara.visibled	= false								// モーダル非表示
	l_dpara.ds			= con.of_get_data( l_dwo, l_dpara )	// data_containerでデータを取得

	// 取得したデータの個数とmultipleでmodalを表示するかどうか制御する
	if l_dpara.ds.rowcount() > 0 then
		if l_dpara.multiple or l_dpara.ds.rowcount() = 1 then	// multiple=false(単一結果)だったらif抜けるけど、rowcount=1なら単一結果が返ってきているためreturnする
			l_dpara.ret	= true
			return l_dpara
		end if
	else
		l_dpara.ret	= false
		return l_dpara
	end if
else
	l_dwo	= of_replace_object( p_object )
	l_modal	= p_object
end if

// モーダルを表示してデータを取得する falseの場合は↑のデータ取得を経由してモーダル表示するため、i_ds_modalは使用せずp_dpara.dsをそのまま使う
if l_dpara.visibled then
	l_dpara.visibled	= true	// モーダル表示
	l_dpara.multiple	= false	// 単一結果

	i_ds_modal.reset()
	i_ds_modal.dataobject	= l_dwo
	l_dpara.ds				= i_ds_modal	// modalのupdate_eventで、returnするdatastore(このイベントのl_dpara.ds)に直接rowscopyしているのでdataobjectのセット必要
end if

openwithparm( l_win, l_dpara, l_modal )

l_ret	= message.doubleparm

if l_ret = 0 then
	l_dpara		= message.powerobjectparm
	l_dpara.ret	= true
else
	l_dpara.ret	= false
end if

return l_dpara
end event

public function string of_replace_object (string p_object);
// p_objectの頭文字をw→d、d→wへ置換する

string	l_ret

if mid( p_object, 1, 1 ) = "w" then
	// 頭文字がw
	l_ret	= replace( p_object, 1, 1, "d" )
else
	// 頭文字がd
	l_ret	= replace( p_object, 1, 1, "w" )
end if

return l_ret
end function

public function str_dpara of_get_data (string p_dwo, str_dpara p_dpara);
// nv_dataのget_data(呼び出し元)へ、control_eventから構造体をバイパスする関数

str_dpara	l_ret	// バイパスしてreturnする用の変数

l_ret	= event control_event( p_dwo, p_dpara )

return l_ret
end function

public function string of_sqlmake_where (string p_column, string p_operator, string p_value1, string p_value2);
// p_operator(演算子)によってSQLのwhere句を作成してreturnする

string	l_ret

// nullは除外
if not isnull( p_value1 ) then
	choose case p_operator
		case "like"
			l_ret	=  p_column + " " + p_operator + " '%' || trim( '" + p_value1 + "' ) || '%'"
		case "between"
			// nullは除外
			if not isnull( p_value2 ) then
				l_ret	=  p_column + " " + p_operator + " " + p_value1 + " and " + p_value2
			end if
		case "in"
			// 検索する値の個数は増える可能性あり
			if isnull( p_value2 ) then
				l_ret	=  p_column + " " + p_operator + " ( " + p_value1 + " )"
			else
				l_ret	=  p_column + " " + p_operator + " ( " + p_value1 + ", " + p_value2 + " )"
			end if
		case else
			// =, < , >, <>など
			l_ret	= p_column + " " + p_operator + " " + p_value1
	end choose
end if

return l_ret
end function

public function string of_sqlmake_where (string p_column, string p_operator, string p_value);
string	l_ret
string	l_value2	// p_value2の代わり

setnull( l_value2 )
l_ret	= of_sqlmake_where( p_column, p_operator, p_value, l_value2 )

return l_ret
end function

public function str_dpara of_open_tanto ();
// control_eventからwsm_tantoを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

l_dpara	= event control_event( "wsm_tanto", l_dpara )

return l_dpara
end function

public function str_dpara of_open_menu ();
// control_eventからwsm_menuを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

l_dpara	= event control_event( "wsm_menu", l_dpara )

return l_dpara
end function

public function str_dpara of_open_tab (string p_menu_id);
// 引数をin_para[]にセット後、control_eventからwsm_tabを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

if p_menu_id <> "" then
	// メニューIDを格納
	l_dpara.in_para[1]	= string( p_menu_id )
end if

l_dpara	= event control_event( "wsm_tab", l_dpara )

return l_dpara
end function

public function str_dpara of_open_meisyo_parent ();
// control_eventからwsm_meisyo_parentを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

l_dpara	= event control_event( "wsm_meisyo_parent", l_dpara )

return l_dpara
end function

public function str_dpara of_open_tokui ();
// control_eventからwsm_tokuiを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

l_dpara	= event control_event( "wsm_tokui", l_dpara )

return l_dpara
end function

public function str_dpara of_open_mise (long p_tokui_code);
// 引数をin_para[]にセット後、control_eventからw_modal_mise_containerを呼び出し、返ってきた構造体をバイパスする関数

str_dpara	l_dpara

if p_tokui_code <> 0 then
	// 得意先コードを格納
	l_dpara.in_para[1]	= string( p_tokui_code )
end if

l_dpara	= event control_event( "wsm_mise", l_dpara )

return l_dpara
end function

on nv_modal.create
call super::create
end on

on nv_modal.destroy
call super::destroy
end on

event constructor;call super::constructor;
i_ds_modal	= create datastore
end event

event destructor;call super::destructor;
destroy( i_ds_modal )
end event

