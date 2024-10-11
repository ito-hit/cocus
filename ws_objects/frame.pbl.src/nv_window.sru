$PBExportHeader$nv_window.sru
$PBExportComments$ウインドウ管理オブジェクト
forward
global type nv_window from inv_object
end type
type str_window from structure within nv_window
end type
end forward

type str_window from structure
	string		window_name
	window		window_object
end type

global type nv_window from inv_object autoinstantiate
end type

type variables
string	win_name[]
window	win_object[]
end variables

forward prototypes
public subroutine of_array_add (string p_name, window p_window)
public subroutine of_array_remove (string p_name)
public subroutine of_close (string p_parent_name, boolean p_logoff)
public function boolean of_open (string p_window_id)
public function boolean of_open (string p_window_id, str_para_window p_win_para)
private function boolean check_window (string p_window_id, ref boolean p_duplicate, ref boolean p_enabled, ref boolean p_readonly)
public function boolean of_chk_duplicate (string p_window_id)
public function boolean of_chk_enabled (string p_window_id)
public function boolean of_chk_readonly (string p_window_id)
public subroutine of_close (string p_parent_name)
public function boolean of_open_readonly (string p_window_id)
end prototypes

public subroutine of_array_add (string p_name, window p_window);integer	l_row

l_row	= upperbound( win_name ) + 1

win_name[l_row]		= p_name
win_object[l_row]	= p_window

end subroutine

public subroutine of_array_remove (string p_name);integer		l_row, l_new_row
string		l_classname
boolean		l_removed	= false

string	l_win_name[]
window	l_win_object[]

l_classname	= p_name

for l_row = 1 to upperbound( win_name )
	if not l_removed and ( win_name[l_row] = l_classname ) then
		l_removed	= true
	else
		l_new_row	= upperbound( l_win_name ) + 1

		l_win_name[l_new_row]	= win_name[l_row]
		l_win_object[l_new_row]	= win_object[l_row]
	end if
next

win_name	= l_win_name
win_object	= l_win_object

end subroutine

public subroutine of_close (string p_parent_name, boolean p_logoff);integer	l_row,l_parent_row

string	l_win_name[]
window	l_win_object[]

// ローカルにもってくる（インスタンス変数は動的に変更されるため）
l_win_name		= winctl.win_name
l_win_object	= winctl.win_object

// ログオフクリックしたウインドウ以外を落とす
for l_row = 1 to upperbound( l_win_name )
	if p_parent_name <> l_win_name[l_row] then
		close( l_win_object[l_row] )
	else
		l_parent_row	= l_row
	end if
next

if p_logoff then
	// ログインウインドウを表示する
	nv_startup	l_startup

	l_startup	= create nv_startup
	l_startup.of_logon_start()

	destroy l_startup
end if

// ログオフクリックしたウインドウは最後に落とす
close( l_win_object[l_parent_row] )


end subroutine

public function boolean of_open (string p_window_id);str_para_window	l_win_para

return of_open( p_window_id, l_win_para )


end function

public function boolean of_open (string p_window_id, str_para_window p_win_para);window	l_win
boolean	l_duplicate, l_enabled, l_readonly


// 運用チェック
if not unyo.of_get_operation() then
	msg.of_error( "運用時間外もしくはシステムメンテナンスのため、現在ご利用いただけません。" )
	return false
end if

// 権限チェック
// 2024.09.17 kin 権限チェックは照会のみモードで起動させるかを判断するので場所変更（照会のみ=falseの部分へ移動）
//if not kengen.of_check( p_window_id ) then
//	msg.of_error( "権限を持っていないためこの機能を開くことはできません。" )
//	return false
//end if

// Window設定取得
check_window( p_window_id, l_duplicate, l_enabled, l_readonly )

// 重複チェック
if not l_duplicate then
	msg.of_error( "既に同じ画面が起動しているため新たに開くことはできません。" )
	return false
end if

// 使用可チェック
if not l_enabled then
	msg.of_error( "この機能は現在利用できません。" )
	return false
end if

// 照会のみチェック
if l_readonly then
	// パラメータの内容に特に指定がなさそうならWindowsマスタの初期値をセット（あえてのことも想定して）
	if len( p_win_para.window_id ) <= 0 then
		p_win_para.readonly_flg	= l_readonly
	end if
else
	if not kengen.of_check( p_window_id ) then
		msg.of_error( "権限を持っていないためこの機能を開くことはできません。" )
		return false
	end if
end if

try
	if openwithparm( l_win, p_win_para, p_window_id ) <> 1 then
		return false
	else
		return true
	end if
catch( runtimeerror rte )
	//txtlog.of_sys_alert_log( /*integer p_type*/, /*string p_name*/, /*integer p_code*/, /*string p_msg */)
	msg.of_error( fnc.strg.of_format( "選択された機能（{1}）はシステムに存在しないため起動することができません。", p_window_id ) )
	return false
end try
end function

private function boolean check_window (string p_window_id, ref boolean p_duplicate, ref boolean p_enabled, ref boolean p_readonly);
integer	l_duplicate, l_siyo_kinsi, l_readonly, l_kengen
integer	l_row

// 2024.09.17 kin Windowチェックで権限がない場合に照会モード=trueなら照会モードで開くように修正
//select nvl( fukusu_kinsi_flg, 0 ),
//       nvl( siyo_kinsi_flg, 0 ),
//       nvl( syokai_flg, 0 )
//  into :l_duplicate,:l_siyo_kinsi,:l_readonly
//  from m_window
// where window_id	= :p_window_id
//using cocos;
select nvl( wd.fukusu_kinsi_flg, 0 ),
       nvl( wd.siyo_kinsi_flg, 0 ),
	   nvl( wd.syokai_flg, 0 ),
	   nvl( kg.kengen_kbn, 0 )
  into :l_duplicate,:l_siyo_kinsi,:l_readonly,:l_kengen
  from m_window wd,
       ( select kengen_kbn
           from m_kengen
          where user_id	= :user.user_id
       ) kg
 where wd.kengen_kbn	= kg.kengen_kbn(+)
   and wd.window_id		= :p_window_id
using cocos;

choose case cocos.sqlcode
	case 0
	case 100
		l_duplicate		= 0
		l_siyo_kinsi	= 1
		l_readonly		= 1
	case else
		//Oracleエラー
		msg.of_error( fnc.strg.of_format( "ユーザー名の取得でエラーが発生しました。（{1}：{2}）", string( cocos.sqldbcode ), cocos.sqlerrtext ) )
		return false
end choose

// 重複起動チェック（ true:重複なし（起動可） false:重複発見（起動不可） ）
p_duplicate	= true

if l_duplicate <> 0 then
	// Windows配列に同じwindows_idが存在していたら重複している
	for l_row = 1 to upperbound( win_name )
		if win_name[l_row] = p_window_id then
			win_object[l_row].setfocus()
			p_duplicate	= false
			exit
		end if
	next
end if

// 使用禁止（ true:使用可 false:使用不可 ）
if l_siyo_kinsi <> 0 then
	p_enabled	= false
else
	p_enabled	= true
end if

// 照会のみ（ true:照会のみ false:編集可 ）
// 2024.09.17 kin m_windowの照会フラグをそのまま参照していたが、権限がない場合に限り照会モードで開くことを許可するか判断するように修正
if l_kengen <> 0 then
	p_readonly	= false
else
	if l_readonly <> 0 then
		p_readonly	= true
	else
		p_readonly	= false
	end if
end if

return true
end function

public function boolean of_chk_duplicate (string p_window_id);
// true:起動可 false:起動不可
boolean	l_duplicate, l_enabled, l_readonly

check_window( p_window_id, l_duplicate, l_enabled, l_readonly )

return l_duplicate

end function

public function boolean of_chk_enabled (string p_window_id);
// true:使用可 false:使用不可
boolean	l_duplicate, l_enabled, l_readonly

check_window( p_window_id, l_duplicate, l_enabled, l_readonly )

return l_enabled

end function

public function boolean of_chk_readonly (string p_window_id);
// true:照会のみモード false:全部OKモード
boolean	l_duplicate, l_enabled, l_readonly

check_window( p_window_id, l_duplicate, l_enabled, l_readonly )

return l_readonly

end function

public subroutine of_close (string p_parent_name);of_close( p_parent_name, false )

end subroutine

public function boolean of_open_readonly (string p_window_id);str_para_window	l_win_para

// 照会のみ設定
l_win_para.readonly_flg	= true

return of_open( p_window_id, l_win_para )


end function

on nv_window.create
call super::create
end on

on nv_window.destroy
call super::destroy
end on

