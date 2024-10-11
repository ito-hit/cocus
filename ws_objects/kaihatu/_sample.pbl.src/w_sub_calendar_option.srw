$PBExportHeader$w_sub_calendar_option.srw
$PBExportComments$カレンダーマスタメンテナンス（新規）
forward
global type w_sub_calendar_option from iw_modal_window
end type
type uo_id from sv_ddplb_meisyo within w_sub_calendar_option
end type
type st_1 from ivo_statictext within w_sub_calendar_option
end type
type st_2 from ivo_statictext within w_sub_calendar_option
end type
type cbx_holiday from ivo_checkbox within w_sub_calendar_option
end type
type uo_kubun from sv_ddplb_meisyo within w_sub_calendar_option
end type
end forward

global type w_sub_calendar_option from iw_modal_window
integer width = 1480
integer height = 885
string title = "新規カレンダー"
uo_id uo_id
st_1 st_1
st_2 st_2
cbx_holiday cbx_holiday
uo_kubun uo_kubun
end type
global w_sub_calendar_option w_sub_calendar_option

type variables

str_calendar	i_para
boolean			i_new
end variables

on w_sub_calendar_option.create
int iCurrent
call super::create
this.uo_id=create uo_id
this.st_1=create st_1
this.st_2=create st_2
this.cbx_holiday=create cbx_holiday
this.uo_kubun=create uo_kubun
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_id
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cbx_holiday
this.Control[iCurrent+5]=this.uo_kubun
end on

on w_sub_calendar_option.destroy
call super::destroy
destroy(this.uo_id)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_holiday)
destroy(this.uo_kubun)
end on

event open;call super::open;// インスタンス変数に構造体が定義してあるため使用する構造体に変更(変数名は変更しない)するのを忘れずに //

// 画面サイズ固定 //
this.width	= PixelsToUnits ( 375, XPixelsToUnits!  )
this.height	= PixelsToUnits ( 229, YPixelsToUnits! )

// プログラム(ここから) //

	
if isnull(i_para.answer) then
	i_new			= True
	i_para.answer	= False
	
	// 初期値をセット //
	// uo_id.init_code		= 0
	// uo_kubun.init_code	= 100
else
	i_new			= False

	// uo_id.init_code		= i_para.id
	// uo_kubun.init_code	= i_para.kbn
	cbx_holiday.checked	= i_para.holiday_flg
end if

// プログラム(ここまで) //

// ↓ロジックの一番最後に設置すること //
//if open_retrieve then
//	this.event retrieve_event( 0, 0 )
//end if

end event

event update_event;call super::update_event;// updatecheck_eventからの戻り値取得 //
//if AncestorReturnValue = -1 then
//// ロールバックの記述(サンプル) //
////  rollback using syukkadb;	
////	close(popup_process)
//	return -1
//end if
//
// プログラム(ここから) //
integer	l_row

// 名称マスタには事前に登録しておく //
// 新規の場合は名称マスタにレコード生成 //
//if i_new then
//	string	l_kubun,l_meisyo
//	integer	l_holiday_flg
//
//	l_kubun			= sle_kubun.text
//	l_holiday_flg	= gf.of_boolean2integer( cbx_holiday.checked )
//	l_meisyo		= sle_meisyo.text
//                            
//	insert into m_meisyo( meisyo_kubun, meisyo_code, meisyo_mei,
//	                      touroku_user_id, touroku_client_id, touroku_pg_id, touroku_date,
//						  kousin_user_id, kousin_client_id, kousin_pg_id, kousin_date
//						)
//			      values( 350, :l_kubun, :l_meisyo,
//				          :user_id, :client_id, :i_pgid, sysdate,
//				          :user_id, :client_id, :i_pgid, sysdate
//				        )
//	using syukkadb;
//end if

i_para.answer 		= True
i_para.id			= long( uo_id.of_get_code( ) )
i_para.kbn		= long( uo_kubun.of_get_code( ) )
i_para.holiday_flg	= cbx_holiday.checked

// プログラム(ここまで) //

// コミットの記述(サンプル) //
//commit using syukkadb;

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

event close( )
end event

event retrieve_event;call super::retrieve_event;// retrievecheck_event先祖からの戻り値取得 //
if AncestorReturnValue = -1 then
// ロールバックの記述(サンプル) //
//  rollback using syukkadb;	
//	close(popup_process)
	return -1
end if

// プログラム(ここから) //
// プログラム(ここまで) //

// コミットの記述(サンプル) //
//commit using syukkadb;

// retrieve //
//dw_ichiran.retrieve()

// ↓ロジックの一番最後に設置すること //
//close(popup_process)

end event

event retrieve_check;call super::retrieve_check;// retrieve_eventの前に動作するイベント //
end event

event update_check;// update_eventの前に動作するイベント //
integer	l_cnt
integer	l_id,l_kubun



end event

event close;closewithreturn( this, i_para )

end event

event openquery;call super::openquery;
i_para	= message.powerobjectparm

end event

event resize;// st_upper
st_upper.x		= 0
st_upper.y		= 4
st_upper.width	= newwidth
st_upper.height	= 140

// st_title_upper
st_title_upper.height	= 96
st_title_upper.width	= st_upper.width * 0.4
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title_upper.y		= st_upper.height / 2 - st_title_upper.height / 2 + st_upper.y

// st_title
st_title.height	= 82
st_title.width	= st_title_upper.width * 0.9
st_title.x		= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x
st_title.y		= st_title_upper.height / 2 - st_title.height / 2 + st_title_upper.y

// p_size_adjust
p_size_adjust.y	= st_upper.height / 2 - p_size_adjust.height / 2 + st_upper.y
p_size_adjust.x	= st_title_upper.x - p_size_adjust.width - 8

// st_upper
st_upper.width	= this.width - 20

// window( ログイン画面は中身でWindowsサイズを決めるため再設定 )
st_title_upper.width	= st_upper.width * 0.8
st_title_upper.x		= st_upper.width / 2 - st_title_upper.width / 2 + st_upper.x
st_title.width			= st_title_upper.width * 0.9
st_title.x				= st_title_upper.width / 2 - st_title.width / 2 + st_title_upper.x

// st_tail
st_tail.width	= st_upper.width
st_tail.y		= dw_list.y + dw_list.height + code.MGN_TATE

// cb_cancel
cb_cancel.width		= 340
cb_cancel.y			= st_tail.height / 2 - cb_cancel.height / 2 + st_tail.y
cb_cancel.x			= st_tail.width - cb_cancel.width - code.MGN_YOKO

// cb_ok
cb_ok.width		= 340
cb_ok.y			= st_tail.height / 2 - cb_ok.height / 2 + st_tail.y
cb_ok.x			= cb_cancel.x - cb_ok.width - code.MGN_GROUP_YOKO

this.height		= st_tail.y + st_tail.height + 100	// 100はおまじない

end event

type uo_signal from iw_modal_window`uo_signal within w_sub_calendar_option
end type

type st_date from iw_modal_window`st_date within w_sub_calendar_option
end type

type st_user_mei from iw_modal_window`st_user_mei within w_sub_calendar_option
integer x = 8
integer y = 135
end type

type uo_test_mode from iw_modal_window`uo_test_mode within w_sub_calendar_option
end type

type p_size_adjust from iw_modal_window`p_size_adjust within w_sub_calendar_option
end type

type st_title from iw_modal_window`st_title within w_sub_calendar_option
integer x = 40
end type

type st_title_upper from iw_modal_window`st_title_upper within w_sub_calendar_option
end type

type st_upper from iw_modal_window`st_upper within w_sub_calendar_option
integer width = 1456
end type

type st_tail from iw_modal_window`st_tail within w_sub_calendar_option
integer y = 569
integer width = 1456
end type

type cb_ok from iw_modal_window`cb_ok within w_sub_calendar_option
integer x = 528
integer y = 587
integer taborder = 50
end type

type cb_cancel from iw_modal_window`cb_cancel within w_sub_calendar_option
integer x = 992
integer y = 587
integer taborder = 60
end type

type dw_list from iw_modal_window`dw_list within w_sub_calendar_option
boolean visible = false
end type

type cb_retrieve from iw_modal_window`cb_retrieve within w_sub_calendar_option
boolean visible = false
integer x = 992
integer taborder = 0
end type

type uo_id from sv_ddplb_meisyo within w_sub_calendar_option
integer x = 592
integer y = 185
integer width = 784
integer taborder = 10
boolean bringtotop = true
integer meisyo_kbn = 340
integer meisyo_no = 1
end type

on uo_id.destroy
call sv_ddplb_meisyo::destroy
end on

type st_1 from ivo_statictext within w_sub_calendar_option
integer x = 48
integer y = 199
integer width = 540
boolean bringtotop = true
string text = "カレンダー種別："
end type

type st_2 from ivo_statictext within w_sub_calendar_option
integer x = 48
integer y = 313
integer width = 540
boolean bringtotop = true
string text = "カレンダー区分："
end type

type cbx_holiday from ivo_checkbox within w_sub_calendar_option
integer x = 608
integer y = 441
integer width = 564
integer taborder = 40
string text = "休日表示指定"
end type

type uo_kubun from sv_ddplb_meisyo within w_sub_calendar_option
integer x = 592
integer y = 299
integer width = 784
integer taborder = 20
boolean bringtotop = true
integer meisyo_kbn = 350
integer meisyo_no = 1
end type

on uo_kubun.destroy
call sv_ddplb_meisyo::destroy
end on

