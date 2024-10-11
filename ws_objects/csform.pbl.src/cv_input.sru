$PBExportHeader$cv_input.sru
$PBExportComments$入力フォームの一番先祖
forward
global type cv_input from ivo_userobject
end type
type st_bikou from ivo_statictext within cv_input
end type
type st_meisyo from sv_st_meisyo within cv_input
end type
type cb_modal from sv_cb_modal within cv_input
end type
type sle_input from ivo_singlelineedit within cv_input
end type
type st_title from ivo_statictext within cv_input
end type
end forward

global type cv_input from ivo_userobject
integer width = 1800
integer height = 89
long backcolor = 12632256
boolean f8_key = true
boolean f9_key = true
boolean f10_key = true
boolean enter_key = true
event type boolean sle_input_check ( )
event type boolean open_modal ( )
event type integer getfocuses ( string p_name )
event type integer losefocuses ( string p_name )
st_bikou st_bikou
st_meisyo st_meisyo
cb_modal cb_modal
sle_input sle_input
st_title st_title
end type
global cv_input cv_input

type variables

public:
	boolean		get				= false		// True：データ取得成功 False：データ取得失敗
	boolean		chk_required	= false		// True：必須入力 False：必須入力ではない
	
	string		title_text		= "未設定"	// st_titleに表示する名称

	long		title_width		= 300
	long		input_width		= 180
	long		bikou_width		= 300

	boolean		modal_visible	= true		// チェックが入ったらcb_modalを表示する。
	boolean		meisyo_visible	= true		// チェックが入ったらst_meisyoを表示する。
	boolean		bikou_visible	= true		// チェックが入ったらst_bikouを表示する。

	string		i_sle_function_name[]	= { "", "", "", "", "", "", "", "", "", "", "", "" }

protected:
	nv_master	mst							// マスタへの存在チェック/データ取得
	
	integer		i_dbchk_mode	= 1			// チェックモード 0：存在チェック後エラーを出さない 1：存在チェック後エラーを出す 2：重複チェックをする(値がテーブルに対して適正かどうかのチェックもしておく)
end variables

forward prototypes
public function string of_get_input ()
public function string of_get_meisyo ()
public subroutine of_set_bikou_color (string p_color)
public subroutine of_set_input (string p_text)
public subroutine of_set_meisyo (string p_text)
public subroutine of_set_bikou (string p_text)
public subroutine of_set_title (string p_text)
public subroutine of_set_enabled (boolean p_bool)
public subroutine of_reset (string p_reset_object)
public subroutine of_set_dbchk_none ()
public subroutine of_set_dbchk_exst ()
public subroutine of_set_dbchk_dupe ()
end prototypes

event type boolean sle_input_check();
// 個別の入力チェックを記述
// ここが2番目にコールされる

// データ取得状態をFalseに戻す
get	= false

return true
end event

event type boolean open_modal();
// データ取得状態をFalseに戻す 必要ないか？
//get	= false

return true
end event

event type integer getfocuses(string p_name);
// sle_inputとcb_modalのget_focusがここをコールする

return 0
end event

event type integer losefocuses(string p_name);
// sle_inputとcb_modalのlose_focusがここをコールする

return 0
end event

public function string of_get_input ();
// sle_inputのテキストを出力する関数
return sle_input.text
end function

public function string of_get_meisyo ();
// st_meisyoのテキストを出力する関数
return st_meisyo.text
end function

public subroutine of_set_bikou_color (string p_color);
// st_bikouのテキストの色を変更する関数

choose case p_color
	case "red"
		st_bikou.textcolor	= rgb( 255, 0, 0 )
//		st_bikou.textcolor	= palette.error_text
	case "glean"
//		st_bikou.textcolor	= rgb( 0, 255, 0 )
		st_bikou.textcolor	= palette.success_text
	case "blue"
//		st_bikou.textcolor	= rgb( 0, 0, 255 )
		st_bikou.textcolor	= palette.info_text
	case "yellow"
		st_bikou.textcolor	= palette.warning_text
	case "black"
		st_bikou.textcolor	= rgb( 0, 0, 0 )
	case "white"
		st_bikou.textcolor	= rgb( 255, 255, 255 )
	case else
		msg.of_error( "色を登録していません。" )
end choose
end subroutine

public subroutine of_set_input (string p_text);
// sle_inputにパラメータのstringをセットする関数
sle_input.text = p_text
end subroutine

public subroutine of_set_meisyo (string p_text);
// st_meisyoにパラメータのstringをセットする関数
st_meisyo.text = p_text
end subroutine

public subroutine of_set_bikou (string p_text);
// st_bikouにパラメータのstringをセットする関数
st_bikou.text	= p_text
end subroutine

public subroutine of_set_title (string p_text);
// st_titleにパラメータのstringをセットする関数
st_title.text	= p_text
end subroutine

public subroutine of_set_enabled (boolean p_bool);
// sle_inputとcb_modalの使用可能を制御する

this.sle_input.enabled	= p_bool
this.cb_modal.enabled	= p_bool
end subroutine

public subroutine of_reset (string p_reset_object);
// sle_input、st_meisyo、st_bikouを初期化する関数

choose case p_reset_object
	case "all"
		// すべて初期化
		sle_input.text	= ""
		st_meisyo.text	= ""
		st_bikou.text	= ""
	case "inputmeisyo"
		// inputとmeisyoを初期化
		sle_input.text	= ""
		st_meisyo.text	= ""
	case "meisyobikou"
		// meisyoとbikouを初期化
		st_meisyo.text	= ""
		st_bikou.text	= ""
	case "meisyo"
		// meisyoを初期化
		st_meisyo.text	= ""
	case "bikou"
		// bikouを初期化
		st_bikou.text	= ""
	case else
		// 何もしない
end choose
end subroutine

public subroutine of_set_dbchk_none ();
// チェックモードを0(何もしない)にセットする
i_dbchk_mode	= 0
end subroutine

public subroutine of_set_dbchk_exst ();
// チェックモードを1(存在チェック)にセットする
i_dbchk_mode	= 1
end subroutine

public subroutine of_set_dbchk_dupe ();
// チェックモードを2(重複チェック)にセットする
i_dbchk_mode	= 2
end subroutine

on cv_input.create
int iCurrent
call super::create
this.st_bikou=create st_bikou
this.st_meisyo=create st_meisyo
this.cb_modal=create cb_modal
this.sle_input=create sle_input
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_bikou
this.Control[iCurrent+2]=this.st_meisyo
this.Control[iCurrent+3]=this.cb_modal
this.Control[iCurrent+4]=this.sle_input
this.Control[iCurrent+5]=this.st_title
end on

on cv_input.destroy
call super::destroy
destroy(this.st_bikou)
destroy(this.st_meisyo)
destroy(this.cb_modal)
destroy(this.sle_input)
destroy(this.st_title)
end on

event resize;call super::resize;
// sle_inputの中心に揃えて合わせる
this.height		= sle_input.height// + 2

st_title.y		= sle_input.y + sle_input.height / 2 - st_title.height / 2
cb_modal.y		= sle_input.y	// sle_inputと高さが一緒
st_meisyo.y		= sle_input.y + sle_input.height / 2 - st_meisyo.height / 2
st_bikou.y		= sle_input.y + sle_input.height / 2 - st_bikou.height / 2

st_title.width	= title_width
sle_input.width	= input_width
st_bikou.width	= bikou_width

sle_input.x		= st_title.x + st_title.width + code.MGN_GROUP_YOKO

if modal_visible then	// cb_modalが見えてる時
	cb_modal.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
			st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
		else
			st_bikou.visible	= false
			st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
			cb_modal.x		= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
			sle_input.width	= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
		else
			st_bikou.visible	= false
			cb_modal.x			= this.width - cb_modal.width - code.MGN_GROUP_YOKO /// 3
			sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
		end if
	end if
else
	cb_modal.visible	= false
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
			st_meisyo.width	= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
		else
			st_bikou.visible	= false
			st_meisyo.width		= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x		= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
			sle_input.width	= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
		else
			st_bikou.visible	= false
			sle_input.width		= this.width - sle_input.x - code.MGN_GROUP_YOKO /// 3
		end if
	end if
end if

end event

event constructor;call super::constructor;
object_type			= "input"
i_sle_function_name	= { "", "", "", "", "", "", "", "参照", "", "", "", "" }

// データ取得状態をFalseに戻す
get	= false

// タイトルをセット
of_set_title( title_text )

// 背景色を透明にする
this.backcolor		= 536870912	// 透明
st_title.backcolor	= this.backcolor
st_bikou.backcolor	= this.backcolor

// 必須入力のセット
//sle_input.chk_required	= this.chk_required

// 有効/無効の解除
//this.of_set_enabled( true )
end event

type st_bikou from ivo_statictext within cv_input
integer x = 1452
integer y = 7
long textcolor = 255
long backcolor = 12632256
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
st_bikou.visible	= bikou_visible
end event

type st_meisyo from sv_st_meisyo within cv_input
integer x = 636
integer y = 4
integer width = 800
string text = ""
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
st_meisyo.visible	= meisyo_visible
end event

type cb_modal from sv_cb_modal within cv_input
integer x = 512
boolean f9_key = true
boolean f10_key = true
end type

event constructor;call super::constructor;
cb_modal.visible	= modal_visible
end event

event getfocus;call super::getfocus;
// 親のwindowのget_focusesを呼び出す。
parent.event getfocuses( "cb" )
end event

event losefocus;call super::losefocus;
// 親のwindowのlose_focusesを呼び出す。
parent.event losefocuses( "cb" )
end event

event execution;call super::execution;
// open_modal イベントをコールする
parent.triggerevent( "open_modal" )
end event

type sle_input from ivo_singlelineedit within cv_input
integer x = 316
integer width = 180
integer taborder = 10
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

event input_check;call super::input_check;
// 親のwindowのsle_input_checkを呼び出す。
return parent.event sle_input_check()
end event

event key_f08;call super::key_f08;
// open_modal イベントをコールする
return long( parent.event open_modal() )	// 本当はparentのkey_f08イベントを呼ぶほうががいいかも
end event

event getfocus;call super::getfocus;
// 親のwindowのget_focusesを呼び出す。
parent.event getfocuses( "sle" )
end event

event losefocus;call super::losefocus;
// 親のwindowのlose_focusesを呼び出す。
parent.event losefocuses( "sle" )
end event

type st_title from ivo_statictext within cv_input
integer y = 4
long backcolor = 12632256
alignment alignment = right!
end type

