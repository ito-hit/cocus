$PBExportHeader$w_kin_sample.srw
$PBExportComments$金藤さんサンプル
forward
global type w_kin_sample from iw_menu_window
end type
type cb_1 from ivo_commandbutton within w_kin_sample
end type
type cb_2 from ivo_commandbutton within w_kin_sample
end type
type cb_3 from ivo_commandbutton within w_kin_sample
end type
type lb_1 from ivo_listbox within w_kin_sample
end type
type cb_4 from ivo_commandbutton within w_kin_sample
end type
type cb_5 from ivo_commandbutton within w_kin_sample
end type
type cb_6 from ivo_commandbutton within w_kin_sample
end type
type cb_7 from ivo_commandbutton within w_kin_sample
end type
type cb_9 from ivo_commandbutton within w_kin_sample
end type
type cb_10 from ivo_commandbutton within w_kin_sample
end type
type cb_11 from ivo_commandbutton within w_kin_sample
end type
type cb_8 from ivo_commandbutton within w_kin_sample
end type
type cb_12 from ivo_commandbutton within w_kin_sample
end type
type cb_13 from ivo_commandbutton within w_kin_sample
end type
type cb_14 from ivo_commandbutton within w_kin_sample
end type
type dw_1 from ivo_datawindow within w_kin_sample
end type
type cb_15 from ivo_commandbutton within w_kin_sample
end type
type cb_16 from ivo_commandbutton within w_kin_sample
end type
type em_1 from ivo_editmask within w_kin_sample
end type
type em_2 from ivo_editmask within w_kin_sample
end type
type cb_17 from ivo_commandbutton within w_kin_sample
end type
type cb_18 from ivo_commandbutton within w_kin_sample
end type
type cb_19 from ivo_commandbutton within w_kin_sample
end type
type cb_20 from ivo_commandbutton within w_kin_sample
end type
type cb_21 from ivo_commandbutton within w_kin_sample
end type
end forward

global type w_kin_sample from iw_menu_window
string title = "金藤さんメニュー"
boolean auto_generate_menu = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
lb_1 lb_1
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_8 cb_8
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
dw_1 dw_1
cb_15 cb_15
cb_16 cb_16
em_1 em_1
em_2 em_2
cb_17 cb_17
cb_18 cb_18
cb_19 cb_19
cb_20 cb_20
cb_21 cb_21
end type
global w_kin_sample w_kin_sample

type prototypes

end prototypes

forward prototypes
public function boolean of_exists_syohin (long p_syohin_code)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei)
end prototypes

public function boolean of_exists_syohin (long p_syohin_code);long	l_cnt

select count(*)
  into :l_cnt
  from m_syohin
 where syohin_code	= :p_syohin_code
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true

end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, string p_size_code, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);
select hin_ban,hin_mei,iro_mei
  into :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
   and size_code	= :p_size_code
using cocos;

if cocos.sqlcode <> 0 then
	return false
end if

return true
end function

public function boolean of_exists_syohin (long p_syohin_code, long p_iro_no, ref string p_hin_ban, ref string p_hin_mei, ref string p_iro_mei);long	l_cnt

select count(*),
       max( hin_ban ),max( hin_mei ),max( iro_mei )
  into :l_cnt,
       :p_hin_ban,:p_hin_mei,:p_iro_mei
  from m_syohin
 where syohin_code	= :p_syohin_code
   and iro_no		= :p_iro_no
using cocos;
			 
if l_cnt <= 0 then
	return false
end if

return true


end function

on w_kin_sample.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.lb_1=create lb_1
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_8=create cb_8
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.dw_1=create dw_1
this.cb_15=create cb_15
this.cb_16=create cb_16
this.em_1=create em_1
this.em_2=create em_2
this.cb_17=create cb_17
this.cb_18=create cb_18
this.cb_19=create cb_19
this.cb_20=create cb_20
this.cb_21=create cb_21
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.lb_1
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_6
this.Control[iCurrent+8]=this.cb_7
this.Control[iCurrent+9]=this.cb_9
this.Control[iCurrent+10]=this.cb_10
this.Control[iCurrent+11]=this.cb_11
this.Control[iCurrent+12]=this.cb_8
this.Control[iCurrent+13]=this.cb_12
this.Control[iCurrent+14]=this.cb_13
this.Control[iCurrent+15]=this.cb_14
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.cb_15
this.Control[iCurrent+18]=this.cb_16
this.Control[iCurrent+19]=this.em_1
this.Control[iCurrent+20]=this.em_2
this.Control[iCurrent+21]=this.cb_17
this.Control[iCurrent+22]=this.cb_18
this.Control[iCurrent+23]=this.cb_19
this.Control[iCurrent+24]=this.cb_20
this.Control[iCurrent+25]=this.cb_21
end on

on w_kin_sample.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.lb_1)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_8)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.dw_1)
destroy(this.cb_15)
destroy(this.cb_16)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.cb_17)
destroy(this.cb_18)
destroy(this.cb_19)
destroy(this.cb_20)
destroy(this.cb_21)
end on

event resize;call super::resize;
end event

type uo_signal from iw_menu_window`uo_signal within w_kin_sample
end type

type st_date from iw_menu_window`st_date within w_kin_sample
end type

type st_user_mei from iw_menu_window`st_user_mei within w_kin_sample
end type

type uo_test_mode from iw_menu_window`uo_test_mode within w_kin_sample
end type

type p_size_adjust from iw_menu_window`p_size_adjust within w_kin_sample
end type

type st_title from iw_menu_window`st_title within w_kin_sample
end type

type st_title_upper from iw_menu_window`st_title_upper within w_kin_sample
end type

type st_upper from iw_menu_window`st_upper within w_kin_sample
end type

type tab_menu from iw_menu_window`tab_menu within w_kin_sample
boolean visible = false
integer x = 20
integer y = 149
integer width = 52
integer height = 50
boolean enabled = false
end type

type pb_exit from iw_menu_window`pb_exit within w_kin_sample
integer taborder = 40
end type

type pb_logoff from iw_menu_window`pb_logoff within w_kin_sample
integer taborder = 70
end type

type shl_notifi from iw_menu_window`shl_notifi within w_kin_sample
end type

type uo_band_message from iw_menu_window`uo_band_message within w_kin_sample
end type

type cb_1 from ivo_commandbutton within w_kin_sample
integer x = 36
integer y = 384
integer width = 700
integer taborder = 20
boolean bringtotop = true
string text = "ユーザー登録"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_user"

open( l_win, l_win_name )
end event

type cb_2 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 384
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "マルチスレッドテスト"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_test_multi"

open( l_win, l_win_name )
end event

type cb_3 from ivo_commandbutton within w_kin_sample
integer x = 32
integer y = 491
integer width = 700
integer taborder = 50
boolean bringtotop = true
string text = "印刷画面（サンプル）"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "iw_print_window"

open( l_win, l_win_name )
end event

type lb_1 from ivo_listbox within w_kin_sample
integer x = 1512
integer y = 391
integer width = 688
integer height = 601
integer taborder = 80
boolean bringtotop = true
end type

type cb_4 from ivo_commandbutton within w_kin_sample
integer x = 1828
integer y = 1045
integer taborder = 90
boolean bringtotop = true
string text = "更新"
end type

event clicked;call super::clicked;
declare oraproc procedure for MMEISYO.PLOCK( '2206','kin',101,'1' ) using cocos;
execute oraproc;

if cocos.sqldbcode <> 0 then
	msg.of_error( "")
end if

msg.of_info("")
commit using cocos;
end event

type cb_5 from ivo_commandbutton within w_kin_sample
integer x = 32
integer y = 597
integer width = 700
integer taborder = 100
boolean bringtotop = true
string text = "関数チェック(opmng)"
end type

event clicked;call super::clicked;nv_unyo	l_opmng

long	l_start_date, l_end_date

if l_opmng.of_get_unyo_range( l_start_date, l_end_date ) then
	msg.of_info( fnc.strg.of_format( "運用中({1}～{2})", string( l_start_date ), string( l_end_date ) ) )
else
	msg.of_info( fnc.strg.of_format( "停止中({1}～{2})", string( l_start_date ), string( l_end_date ) ) )
end if
end event

type cb_6 from ivo_commandbutton within w_kin_sample
integer x = 32
integer y = 697
integer width = 700
integer taborder = 140
boolean bringtotop = true
string text = "帯メッセージ表示"
end type

event clicked;call super::clicked;messagebox( "","" )
//uo_band_msg.transparency	= 100
//uo_band_msg.visible			= true
//
//uo_band_msg.setredraw( true )
//
//uo_band_msg.of_show( "現在システムは運用停止状態です。速やかに終了するようにお願いします。" )
end event

type cb_7 from ivo_commandbutton within w_kin_sample
integer x = 32
integer y = 796
integer width = 700
integer taborder = 190
boolean bringtotop = true
string text = "メール送信テスト"
end type

event clicked;call super::clicked;mail.of_send_mail( "maverick.hiro08@gmail.com", "テストメール", "powerbuilerからのメール送信" )
end event

type cb_9 from ivo_commandbutton within w_kin_sample
integer x = 28
integer y = 949
integer width = 700
integer taborder = 200
boolean bringtotop = true
string text = "帯メッセージ終了"
end type

event clicked;call super::clicked;//uo_band_msg.transparency	= 100
//uo_band_msg.visible			= true
//
//uo_band_msg.setredraw( true )
//
uo_band_message.of_hide()
end event

type cb_10 from ivo_commandbutton within w_kin_sample
integer x = 28
integer y = 1063
integer width = 700
integer taborder = 220
boolean bringtotop = true
string text = "関数呼び出しテスト"
end type

event clicked;call super::clicked;//str_function	l_fnc

//l_fnc.msg.of_info( l_fnc.fnc.of_get_computer_name( ) )

end event

type cb_11 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 796
integer width = 700
integer taborder = 210
boolean bringtotop = true
string text = "印刷画面テスト"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_test_print"

open( l_win, l_win_name )
end event

type cb_8 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 491
integer width = 700
integer taborder = 60
boolean bringtotop = true
string text = "通知画面"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_tuuti"

open( l_win, l_win_name )
end event

type cb_12 from ivo_commandbutton within w_kin_sample
integer x = 28
integer y = 1188
integer width = 700
integer taborder = 120
boolean bringtotop = true
string text = "通知管理登録"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_tuuti_kanri"

open( l_win, l_win_name )
end event

type cb_13 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 1188
integer width = 700
integer taborder = 150
boolean bringtotop = true
string text = "通知管理登録テスト"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_tuuti_kin"

open( l_win, l_win_name )
end event

type cb_14 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 1276
integer width = 700
integer taborder = 160
boolean bringtotop = true
string text = "通知管理登録テスト2"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_master_tuuti_kin2"

open( l_win, l_win_name )
end event

type dw_1 from ivo_datawindow within w_kin_sample
boolean visible = false
integer x = 40
integer y = 1323
integer width = 124
integer height = 121
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_juchu_02_lock"
end type

event constructor;call super::constructor;this.insertrow(1)

end event

event itemchanged;call super::itemchanged;long	l_cnt
integer	l_ret

long	l_syohin_code,l_iro_no
string	l_size_code
string	l_hin_ban,l_hin_mei,l_iro_mei

l_ret	= 0

if row > 0 then
	choose case dwo.name
		case "syohin_code"
			l_syohin_code	= long( data )
		
			if not of_exists_syohin( l_syohin_code ) then
				msg.of_error( "商品コードの入力に誤りがあります。" )
				return 1
			end if
			
			// 色番がすでに入力済みだった場合、存在チェックして存在していればそのまま。なければ消去
			l_iro_no		= long( this.object.iro_no[row] )
			
			if not isnull( l_iro_no ) then
				if of_exists_syohin( l_syohin_code, l_iro_no, l_hin_ban, l_hin_mei, l_iro_mei ) then
					// 色番とサイズがすでに入力済みだった場合、存在チェックして存在していればそのまま。なければ消去（色番未入力なら削除）
					l_size_code		= this.object.size_code[row]

					// サイズは無条件に消す
					l_size_code						= ""
					this.object.size_code[row]		= ""

					if len( trim( l_size_code ) ) > 0 or not isnull( trim( l_size_code ) ) then
						if not of_exists_syohin( l_syohin_code, l_iro_no, l_size_code, l_hin_ban, l_hin_mei, l_iro_mei ) then
							this.object.size_code[row]	= ""
						end if
					end if
				else
					this.object.iro_no[row]		= ""
					this.object.size_code[row]	= ""
				end if
			end if
			
			this.object.hin_ban[row]	= l_hin_ban
			this.object.hin_mei[row]	= l_hin_mei
			this.object.color_nm[row]	= l_iro_mei
			
		case "iro_no"
			if event itemchanged( row, this.object.syohin_code, string( this.object.syohin_code[row] ) ) <> 0 then
				return 1
			end if
			
			l_syohin_code	= long( this.object.syohin_code[row] )
			l_size_code		= this.object.size_code[row]

			// サイズは無条件に消す
			l_size_code						= ""
			this.object.size_code[row]		= ""

			// 未入力の場合は最小色番を取得してセットする
			if len( trim( data ) ) <= 0 or isnull( trim( data ) ) then
				select min( iro_no )
				  into :l_iro_no
				  from m_syohin
				 where syohin_code	= :l_syohin_code
				using cocos;
				
				data					= string( l_iro_no )
				this.object.iro_no[row]	= string( l_iro_no )

				l_ret	= 2
			end if

			l_iro_no		= long( data )

			if not of_exists_syohin( l_syohin_code, l_iro_no, l_hin_ban, l_hin_mei, l_iro_mei ) then
				msg.of_error( "色番の入力に誤りがあります。" )
				return 1
			end if

			// サイズがすでに入力済みだった場合、存在チェックして存在していればそのまま。なければ消去
			l_size_code		= this.object.size_code[row]
			if len( trim( l_size_code ) ) > 0 or not isnull( trim( l_size_code ) ) then
				if not of_exists_syohin( l_syohin_code, l_iro_no, l_size_code, l_hin_ban, l_hin_mei, l_iro_mei ) then
					this.object.size_code[row]	= ""
				end if
			end if

			this.object.hin_ban[row]	= l_hin_ban
			this.object.hin_mei[row]	= l_hin_mei
			this.object.color_nm[row]	= l_iro_mei
		case "size_code"
			if event itemchanged( row, this.object.iro_no, string( this.object.iro_no[row] ) ) <> 0 then
				return 1
			end if

			l_syohin_code	= long( this.object.syohin_code[row] )
			l_iro_no		= long( this.object.iro_no[row] )
			l_size_code		= trim( data )
			
			if not of_exists_syohin( l_syohin_code, l_iro_no, l_size_code, l_hin_ban, l_hin_mei, l_iro_mei ) then
				msg.of_error( "サイズの入力に誤りがあります。" )
				return 1
			end if

			this.object.hin_ban[row]	= l_hin_ban
			this.object.hin_mei[row]	= l_hin_mei
			this.object.color_nm[row]	= l_iro_mei
		case else
	end choose
end if

return l_ret

end event

event itemlosefocuschanged;call super::itemlosefocuschanged;
if row > 0 then
	choose case dwo.name
		case "iro_no"
			if isnull( this.object.iro_no[row] ) or len( string( this.object.iro_no[row] ) ) = 0 then
				// returnが1（値を受け付けずフォーカスも移動しない）だった場合はエラー扱い
				if event itemchanged( row, dwo, string( this.object.iro_no[row] ) ) = 1 then
					return -1
				end if
			end if
	end choose
end if

return 0
end event

type cb_15 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 594
integer width = 700
integer taborder = 130
boolean bringtotop = true
string text = "得意先＆店検索"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "ws_tokui_mise"

open( l_win, l_win_name )
end event

type cb_16 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 693
integer width = 700
integer taborder = 180
boolean bringtotop = true
string text = "得意先＆店検索2"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "ws_tokui_mise2"

open( l_win, l_win_name )
end event

type em_1 from ivo_editmask within w_kin_sample
integer x = 2236
integer y = 523
integer width = 404
integer taborder = 110
boolean bringtotop = true
integer init_imemode = 3
alignment alignment = center!
string mask = "###-##-###"
end type

type em_2 from ivo_editmask within w_kin_sample
integer x = 2236
integer y = 615
integer width = 404
integer taborder = 120
boolean bringtotop = true
integer init_imemode = 3
string text = ""
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
string mask = "X##-##-###"
end type

type cb_17 from ivo_commandbutton within w_kin_sample
integer x = 788
integer y = 907
integer width = 700
integer taborder = 200
boolean bringtotop = true
string text = "カレンダーマスタ"
end type

event clicked;call super::clicked;window	l_win
string	l_win_name

l_win_name	= "w_mente_calendar"

open( l_win, l_win_name )
end event

type cb_18 from ivo_commandbutton within w_kin_sample
integer x = 2244
integer y = 732
integer width = 360
integer taborder = 100
boolean bringtotop = true
string text = "マスタチェック"
end type

event clicked;call super::clicked;
nv_master	l_mst
integer		l_ret

string	l_menu_id		= ""
string	l_tab_id		= ""
string	l_window_id		= ""

integer	l_meisyo_kbn	= 0
long	l_mise_code		= 0
long	l_tanto_code	= 0
long	l_tokui_code	= 0
string	l_meisyo_code	= ""

// 名称チェック
if l_mst.of_meisyo_check ( l_meisyo_kbn ) <> 0 then
	msg.of_info( fnc.strg.of_format( "名称[of_meisyo_check]（失敗）l_meisyo_kbn:{1}", string( l_meisyo_kbn ) ) )
else
	msg.of_info( fnc.strg.of_format( "名称[of_meisyo_check]（成功）l_meisyo_kbn:{1}", string( l_meisyo_kbn ) ) )
end if

if l_mst.of_meisyo_check ( l_meisyo_kbn,  l_meisyo_code ) <> 0 then
	msg.of_info( fnc.strg.of_format( "名称[of_meisyo_check]（失敗）l_meisyo_kbn:{1} l_meisyo_code:{}", string( l_meisyo_kbn ), l_meisyo_code ) )
else
	msg.of_info( fnc.strg.of_format( "名称[of_meisyo_check]（成功）l_meisyo_kbn:{1} l_meisyo_code:{}", string( l_meisyo_kbn ), l_meisyo_code ) )
end if

// メニューチェック
if l_mst.of_menu_check ( l_menu_id ) <> 0 then
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_check]（失敗）l_menu_id:{1}", l_menu_id ) )
else
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_check]（成功）l_menu_id:{1}", l_menu_id ) )
end if

if l_mst.of_menu_check ( l_menu_id,  l_tab_id ) <> 0 then
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_check]（失敗）l_menu_id:{1} l_tab_id:{2}", l_menu_id, l_tab_id ) )
else
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_check]（成功）l_menu_id:{1} l_tab_id:{2}", l_menu_id, l_tab_id ) )
end if

if l_mst.of_menu_checkw ( l_window_id ) <> 0 then
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_checkw]（失敗）l_window_id:{1}", l_window_id ) )
else
	msg.of_info( fnc.strg.of_format( "メニュー[of_menu_checkw]（成功）l_window_id:{1}", l_window_id ) )
end if


// 店チェック
if l_mst.of_mise_check ( l_tokui_code ) <> 0 then
	msg.of_info( fnc.strg.of_format( "店[of_mise_check]（失敗）l_tokui_code:{1}", string( l_tokui_code ) ) )
else
	msg.of_info( fnc.strg.of_format( "店[of_mise_check]（成功）l_tokui_code:{1}", string( l_tokui_code ) ) )
end if

if l_mst.of_mise_check ( l_tokui_code,  l_mise_code ) <> 0 then
	msg.of_info( fnc.strg.of_format( "店[of_mise_check]（失敗）l_tokui_code:{1} l_mise_code:{2}", string( l_tokui_code ), string( l_mise_code ) ) )
else
	msg.of_info( fnc.strg.of_format( "店[of_mise_check]（成功）l_tokui_code:{1} l_mise_code:{2}", string( l_tokui_code ), string( l_mise_code ) ) )
end if


//担当チェック
if l_mst.of_tanto_check ( l_tanto_code ) <> 0 then
	msg.of_info( fnc.strg.of_format( "担当[of_tanto_check]（失敗）l_tanto_code:{1}", string( l_tanto_code ) ) )
else
	msg.of_info( fnc.strg.of_format( "担当[of_tanto_check]（成功）l_tanto_code:{1}", string( l_tanto_code ) ) )
end if


// 得意先チェック
if l_mst.of_tokui_check ( l_tokui_code ) <> 0 then
	msg.of_info( fnc.strg.of_format( "得意先[of_tokui_check]（失敗）l_tokui_code:{1}", string( l_tokui_code ) ) )
else
	msg.of_info( fnc.strg.of_format( "得意先[of_tokui_check]（成功）l_tokui_code:{1}", string( l_tokui_code ) ) )
end if

end event

type cb_19 from ivo_commandbutton within w_kin_sample
integer x = 2608
integer y = 732
integer width = 348
integer taborder = 110
boolean bringtotop = true
string text = "マスタゲット"
end type

event clicked;call super::clicked;
nv_master	l_mst
integer		l_ret

str_mmeisyo	l_meisyo[]
str_mmenu	l_menu[]
str_mmise	l_mise[]
str_mtanto	l_tanto[]
str_mtokui	l_tokui[]

if l_mst.of_meisyo_get( 110, "1", l_meisyo ) > 0 then
	msg.of_info( "110-1有：" + string( l_meisyo[1].meisyo_1 ) )
else
	msg.of_info( "110-1無：" )
end if

if l_mst.of_meisyo_get( 110, l_meisyo ) > 0 then
	msg.of_info( "110有：" + string( l_meisyo[1].meisyo_1 ) )
else
	msg.of_info( "110無：" )
end if
/*
public function integer of_meisyo_get (integer p_meisyo_kbn, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[])
public function integer of_mise_get (long p_tokui_code, ref str_mmise p_recs[])
public function integer of_mise_get (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[])
public function integer of_menu_get (string p_menu_id, ref str_mmenu p_recs[])
public function integer of_menu_get (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[])
public function integer of_menu_getw (string p_window_id, ref str_mmenu p_recs[])
public function integer of_tanto_get (long p_tanto_code, ref str_mtanto p_recs[])
public function integer of_tokui_get (long p_tokui_code, ref str_mtokui p_recs[])
*/
end event

type cb_20 from ivo_commandbutton within w_kin_sample
integer x = 2972
integer y = 732
integer width = 348
integer taborder = 110
boolean bringtotop = true
string text = "マスタフル"
end type

event clicked;call super::clicked;
nv_master	l_mst
integer		l_ret

str_mmeisyo	l_meisyo[]
str_mmenu	l_menu[]
str_mmise	l_mise[]
str_mtanto	l_tanto[]
str_mtokui	l_tokui[]

if l_mst.of_meisyo_get_full( 110, "1", l_meisyo ) > 0 then
	msg.of_info( "110-1有：" + string( l_meisyo[1].meisyo_1 ) )
else
	msg.of_info( "110-1無：" )
end if

if l_mst.of_meisyo_get_full( 110, l_meisyo ) > 0 then
	msg.of_info( "110有：" + string( l_meisyo[1].meisyo_1 ) )
else
	msg.of_info( "110無：" )
end if
/*
public function integer of_meisyo_get_full (integer p_meisyo_kbn, ref str_mmeisyo p_recs[])
public function integer of_meisyo_get_full (integer p_meisyo_kbn, string p_meisyo_code, ref str_mmeisyo p_recs[])
public function integer of_mise_get_full (long p_tokui_code, ref str_mmise p_recs[])
public function integer of_mise_get_full (long p_tokui_code, long p_mise_code, ref str_mmise p_recs[])
public function integer of_menu_get_full (string p_menu_id, ref str_mmenu p_recs[])
public function integer of_menu_get_full (string p_menu_id, string p_tab_id, ref str_mmenu p_recs[])
public function integer of_menu_getw_full (string p_window_id, ref str_mmenu p_recs[])
public function integer of_tanto_get_full (long p_tanto_code, ref str_mtanto p_recs[])
public function integer of_tokui_get_full (long p_tokui_code, ref str_mtokui p_recs[])
*/
end event

type cb_21 from ivo_commandbutton within w_kin_sample
integer x = 2276
integer y = 359
integer width = 700
integer taborder = 30
boolean bringtotop = true
string text = "テスト"
end type

