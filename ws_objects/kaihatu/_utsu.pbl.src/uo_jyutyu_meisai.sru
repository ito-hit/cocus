$PBExportHeader$uo_jyutyu_meisai.sru
$PBExportComments$受注明細タブ用ユーザーオブジェクト
forward
global type uo_jyutyu_meisai from ivo_userobject
end type
type dw_jyutyu_meisai from ivo_datawindow within uo_jyutyu_meisai
end type
end forward

global type uo_jyutyu_meisai from ivo_userobject
integer width = 2216
integer height = 537
dw_jyutyu_meisai dw_jyutyu_meisai
end type
global uo_jyutyu_meisai uo_jyutyu_meisai

on uo_jyutyu_meisai.create
int iCurrent
call super::create
this.dw_jyutyu_meisai=create dw_jyutyu_meisai
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_jyutyu_meisai
end on

on uo_jyutyu_meisai.destroy
call super::destroy
destroy(this.dw_jyutyu_meisai)
end on

type dw_jyutyu_meisai from ivo_datawindow within uo_jyutyu_meisai
integer x = 12
integer y = 11
integer width = 2168
integer height = 491
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_jyutyu_meisai"
boolean hscrollbar = true
boolean vscrollbar = true
boolean f1_key = true
boolean f2_key = true
boolean f3_key = true
boolean f5_key = true
boolean f9_key = true
boolean f10_key = true
boolean f11_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;this.i_function_name	= { "全選択", "行追加", "行削除", "", "Excel出力", "", "", "", "初期表示", "終了", "印刷", "更新" }

datawindowchild	l_dwc

this.width	= parent.width - 15
this.height	= parent.height - 15

this.settransobject( cocos )

// # ドロップダウンデータウィンドウ #
// 出荷拠点
this.getchild( "kyoten_code", l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve()

// 引当順
this.getchild( "hikiate_kbn", l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve( 207, 1, 0 )

// 確保区分
this.getchild( "kakuho_kbn1", l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve( 210, 1, 0 )

// 出荷ロケ
this.getchild( "syukka_location1", l_dwc )
l_dwc.settransobject( cocos )
l_dwc.retrieve( 211, 1, 0 )
end event

event key_f02;call super::key_f02;// 行追加 //
this.insertrow( 0 )
return 0

end event

event key_f01;call super::key_f01;// 全選択 //
long l_cnt
long l_check_cnt

this.setredraw( false )

// チェック件数を取得
for l_cnt = 1 to this.rowcount( )
	if this.object.checkbox[l_cnt]	= 1 then
		l_check_cnt	+= 1
	end if
next

if l_check_cnt = this.rowcount( ) then
	// 全部チェック入りの場合はチェックを外す
	for l_cnt = 1 to this.rowcount()
		this.object.checkbox[l_cnt] = 0
	next
else
	// 一部チェック入りの場合は全てチェックON
	for l_cnt = 1 to this.rowcount( )
		this.object.checkbox[l_cnt] = 1
	next
end if

this.setredraw( true )

return 0

end event

