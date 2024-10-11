$PBExportHeader$cv_input_tokui_tanto.sru
$PBExportComments$m_tokuiの入力フォーム 表示項目に担当(者)を追加した
forward
global type cv_input_tokui_tanto from cv_input_tokui
end type
type st_bumon_mei from sv_st_meisyo within cv_input_tokui_tanto
end type
type st_tanto_code from sv_st_meisyo within cv_input_tokui_tanto
end type
type st_tanto_mei from sv_st_meisyo within cv_input_tokui_tanto
end type
type st_bumon_title from ivo_statictext within cv_input_tokui_tanto
end type
type st_tanto_title from ivo_statictext within cv_input_tokui_tanto
end type
end forward

global type cv_input_tokui_tanto from cv_input_tokui
integer width = 4100
st_bumon_mei st_bumon_mei
st_tanto_code st_tanto_code
st_tanto_mei st_tanto_mei
st_bumon_title st_bumon_title
st_tanto_title st_tanto_title
end type
global cv_input_tokui_tanto cv_input_tokui_tanto

type variables

public:
	boolean	bumon_visible		= false			// True：「担当部門」を表示する　False：表示しない
	string	bumon_title_text	= "担当部門"
	long	bumon_title_width	= 300
	long	bumon_mei_width		= 652
	
	boolean	tanto_visible		= true			// True：「担当者」を表示する　False：表示しない
	string	tanto_title_text	= "担当者"
	long	tanto_title_width	= 250
	long	tanto_code_width	= 180
	long	tanto_mei_width		= 500
end variables

forward prototypes
public subroutine of_set_bumon_mei (string p_bumon_mei)
public subroutine of_set_tanto_code (string p_tanto_code)
public subroutine of_set_tanto_mei (string p_tanto_mei)
public subroutine of_set_bumon_title (string p_bumon_title)
public subroutine of_set_tanto_title (string p_tanto_title)
public subroutine of_reset (string p_reset_object)
end prototypes

public subroutine of_set_bumon_mei (string p_bumon_mei);
// st_bumon_meiに引数の文字列をセットする関数
st_bumon_mei.text	= p_bumon_mei
end subroutine

public subroutine of_set_tanto_code (string p_tanto_code);
// st_tanto_codeに引数の文字列をセットする関数
st_tanto_code.text	= p_tanto_code
end subroutine

public subroutine of_set_tanto_mei (string p_tanto_mei);
// st_tanto_meiに引数の文字列をセットする関数
st_tanto_mei.text	= p_tanto_mei
end subroutine

public subroutine of_set_bumon_title (string p_bumon_title);
// st_bumon_titleに引数の文字列をセットする関数
st_bumon_title.text	= p_bumon_title
end subroutine

public subroutine of_set_tanto_title (string p_tanto_title);
// st_tanto_titleに引数の文字列をセットする関数
st_tanto_title.text	= p_tanto_title
end subroutine

public subroutine of_reset (string p_reset_object);
// sle_input、st_meisyo、st_bikouを初期化する関数

choose case p_reset_object
	case "all"
		// すべて初期化
		sle_input.text		= ""
		st_meisyo.text		= ""
		st_bikou.text		= ""
		
		st_bumon_mei.text	= ""
		st_tanto_code.text	= ""
		st_tanto_mei.text	= ""
	case "meisyobikou"
		// meisyoとbikouを初期化 bumonとtantoも初期化する
		st_meisyo.text		= ""
		st_bikou.text		= ""
		
		st_bumon_mei.text	= ""
		st_tanto_code.text	= ""
		st_tanto_mei.text	= ""
	case "meisyo"
		// meisyoを初期化 bumonとtantoも初期化する
		st_meisyo.text		= ""
		
		st_bumon_mei.text	= ""
		st_tanto_code.text	= ""
		st_tanto_mei.text	= ""
	case "bikou"
		// bikouを初期化
		st_bikou.text	= ""
	case else
		// 何もしない
end choose
end subroutine

on cv_input_tokui_tanto.create
int iCurrent
call super::create
this.st_bumon_mei=create st_bumon_mei
this.st_tanto_code=create st_tanto_code
this.st_tanto_mei=create st_tanto_mei
this.st_bumon_title=create st_bumon_title
this.st_tanto_title=create st_tanto_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_bumon_mei
this.Control[iCurrent+2]=this.st_tanto_code
this.Control[iCurrent+3]=this.st_tanto_mei
this.Control[iCurrent+4]=this.st_bumon_title
this.Control[iCurrent+5]=this.st_tanto_title
end on

on cv_input_tokui_tanto.destroy
call super::destroy
destroy(this.st_bumon_mei)
destroy(this.st_tanto_code)
destroy(this.st_tanto_mei)
destroy(this.st_bumon_title)
destroy(this.st_tanto_title)
end on

event sle_input_check;call super::sle_input_check;
str_mmeisyo	l_meisyo[]
str_mtanto	l_tanto[]

if ancestorreturnvalue then
	// 担当部門 meisyo_kbn = 21
	if bumon_visible then
		if mst.of_meisyo_get( 21, string( of_get_bumon_code( ) ), l_meisyo ) > 0 then
			of_set_bumon_mei( l_meisyo[1].meisyo_1 )
		end if
	end if
	
	// 担当者
	if tanto_visible then
		if mst.of_tanto_get( of_get_tanto_code( ), l_tanto ) > 0 then
			of_set_tanto_code( string( this.of_get_tanto_code( ) ) )
			of_set_tanto_mei( l_tanto[1].tanto_mei )
		end if
	end if
else
	// 初期化する
	of_reset( "meisyobikou" )
	sle_input.setfocus()
end if

return ancestorreturnvalue
end event

event constructor;call super::constructor;
// タイトルをセット
if bumon_visible then
	of_set_bumon_title( bumon_title_text )
end if

if tanto_visible then
	of_set_tanto_title( tanto_title_text )
end if

// 背景色を透明にする
st_bumon_title.backcolor	= this.backcolor
st_tanto_title.backcolor	= this.backcolor

return 0
end event

event resize;
// sle_inputの中心に揃えて合わせる
this.height				= sle_input.height// + 2

st_title.y				= sle_input.y + sle_input.height / 2 - st_title.height / 2
cb_modal.y				= sle_input.y	// sle_inputと高さが一緒
st_meisyo.y				= sle_input.y + sle_input.height / 2 - st_meisyo.height / 2
st_bikou.y				= sle_input.y + sle_input.height / 2 - st_bikou.height / 2

st_bumon_title.y		= sle_input.y + sle_input.height / 2 - st_bumon_title.height / 2
st_bumon_mei.y			= sle_input.y + sle_input.height / 2 - st_bumon_mei.height / 2
st_tanto_title.y		= sle_input.y + sle_input.height / 2 - st_tanto_title.height / 2
st_tanto_code.y			= sle_input.y + sle_input.height / 2 - st_tanto_code.height / 2
st_tanto_mei.y			= sle_input.y + sle_input.height / 2 - st_tanto_mei.height / 2

st_title.width			= title_width
sle_input.width			= input_width
st_bikou.width			= bikou_width

st_bumon_title.width	= bumon_title_width
st_bumon_mei.width		= bumon_mei_width
st_tanto_title.width	= tanto_title_width
st_tanto_code.width		= tanto_code_width
st_tanto_mei.width		= tanto_mei_width

sle_input.x				= st_title.x + st_title.width + code.MGN_GROUP_YOKO

if modal_visible then	// cb_modalが見えてる時
	cb_modal.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_bikou.x + st_bikou.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x				= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_tanto_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			st_bikou.visible	= false

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bumon_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bumon_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_tanto_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_meisyo.width			= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_bikou.x + st_bikou.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x				= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x				= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_tanto_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x				= st_bikou.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			st_bikou.visible	= false

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= cb_modal.x + cb_modal.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= st_bumon_title.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x				= st_bumon_title.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					cb_modal.x			= st_tanto_title.x - cb_modal.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					cb_modal.x				= this.width - cb_modal.x - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= cb_modal.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	end if
else
	cb_modal.visible	= false
	
	if meisyo_visible then	// st_meisyoが見えてる時
		st_meisyo.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_bikou.x + st_bikou.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x				= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_tanto_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bikou.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			st_bikou.visible	= false

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_meisyo.x + st_meisyo.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_bumon_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width			= st_bumon_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_meisyo.width		= st_tanto_title.x - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_meisyo.width			= this.width - st_meisyo.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	else
		st_meisyo.visible	= false
		
		if bikou_visible then	// st_bikouが見えてる時
			st_bikou.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= st_bikou.x + st_bikou.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x				= st_bumon_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bikou.x			= st_tanto_title.x - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bikou.x				= this.width - st_bikou.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= st_bikou.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		else
			st_bikou.visible	= false

			if bumon_visible then	// 担当部門が見えているとき
				st_bumon_title.x	= sle_input.x + sle_input.width + code.MGN_GROUP_YOKO /// 3
				st_bumon_mei.x		= st_bumon_title.x + st_bumon_title.width + code.MGN_GROUP_YOKO /// 3

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x	= st_tanto_code.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_bumon_title.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_mei.x		= st_tanto_title.x - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= st_bumon_mei.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					st_bumon_mei.x			= this.width - st_bumon_mei.width - code.MGN_GROUP_YOKO /// 3
					st_bumon_title.x		= st_bumon_mei.x - st_bumon_title.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width			= st_bumon_title.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			else
				st_bumon_title.visible	= false
				st_bumon_mei.visible	= false

				if tanto_visible then	// 担当者が見えているとき
					st_tanto_mei.x		= this.width - st_tanto_mei.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_code.x		= st_tanto_mei.x - st_tanto_code.width - code.MGN_GROUP_YOKO /// 3
					st_tanto_title.x	= st_tanto_code.x - st_tanto_title.width - code.MGN_GROUP_YOKO /// 3
					sle_input.width		= st_tanto_title.x - sle_input.x - code.MGN_GROUP_YOKO /// 3
				else
					st_tanto_title.visible	= false
					st_tanto_mei.visible	= false
					st_tanto_code.visible	= false

					sle_input.width			= this.width - sle_input.x - code.MGN_GROUP_YOKO /// 3
				end if
			end if
		end if
	end if
end if

end event

type st_bikou from cv_input_tokui`st_bikou within cv_input_tokui_tanto
integer y = 0
end type

type st_meisyo from cv_input_tokui`st_meisyo within cv_input_tokui_tanto
end type

type cb_modal from cv_input_tokui`cb_modal within cv_input_tokui_tanto
end type

type sle_input from cv_input_tokui`sle_input within cv_input_tokui_tanto
end type

type st_title from cv_input_tokui`st_title within cv_input_tokui_tanto
end type

type st_bumon_mei from sv_st_meisyo within cv_input_tokui_tanto
integer x = 2636
integer width = 352
boolean bringtotop = true
string text = ""
boolean righttoleft = true
end type

type st_tanto_code from sv_st_meisyo within cv_input_tokui_tanto
integer x = 3352
integer width = 180
boolean bringtotop = true
string text = ""
alignment alignment = right!
end type

type st_tanto_mei from sv_st_meisyo within cv_input_tokui_tanto
integer x = 3548
integer width = 500
boolean bringtotop = true
string text = ""
end type

type st_bumon_title from ivo_statictext within cv_input_tokui_tanto
integer x = 2312
boolean bringtotop = true
long backcolor = 12632256
string text = "担当部門"
alignment alignment = right!
end type

type st_tanto_title from ivo_statictext within cv_input_tokui_tanto
integer x = 3020
boolean bringtotop = true
long backcolor = 12632256
string text = "担当者"
alignment alignment = right!
end type

