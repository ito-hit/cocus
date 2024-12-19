$PBExportHeader$wld_genka_baika.srw
$PBExportComments$郵便番号アップロード登録
forward
global type wld_genka_baika from iw_main_window
end type
type st_status from ivo_statictext within wld_genka_baika
end type
type st_msg from ivo_statictext within wld_genka_baika
end type
type cb_clear from ivo_commandbutton within wld_genka_baika
end type
type dw_list from ivo_datawindow within wld_genka_baika
end type
type st_filename_t from ivo_statictext within wld_genka_baika
end type
type st_filename from ivo_statictext within wld_genka_baika
end type
type st_cnt_t from ivo_statictext within wld_genka_baika
end type
type st_cnt from ivo_statictext within wld_genka_baika
end type
type st_okcnt_t from ivo_statictext within wld_genka_baika
end type
type st_okcnt from ivo_statictext within wld_genka_baika
end type
type st_errcnt_t from ivo_statictext within wld_genka_baika
end type
type st_errcnt from ivo_statictext within wld_genka_baika
end type
type st_warncnt_t from ivo_statictext within wld_genka_baika
end type
type st_warncnt from ivo_statictext within wld_genka_baika
end type
type ddplb_status from ivo_dropdownpicturelistbox within wld_genka_baika
end type
type ddplb_msg from ivo_dropdownpicturelistbox within wld_genka_baika
end type
type hpb_progres from ivo_hprogressbar within wld_genka_baika
end type
end forward

global type wld_genka_baika from iw_main_window
string title = "原価売価アップロード登録"
boolean f7_key = true
boolean f12_key = true
event dropfile pbm_dropfiles
st_status st_status
st_msg st_msg
cb_clear cb_clear
dw_list dw_list
st_filename_t st_filename_t
st_filename st_filename
st_cnt_t st_cnt_t
st_cnt st_cnt
st_okcnt_t st_okcnt_t
st_okcnt st_okcnt
st_errcnt_t st_errcnt_t
st_errcnt st_errcnt
st_warncnt_t st_warncnt_t
st_warncnt st_warncnt
ddplb_status ddplb_status
ddplb_msg ddplb_msg
hpb_progres hpb_progres
end type
global wld_genka_baika wld_genka_baika

type prototypes

end prototypes

type variables

str_para_fileread	i_str_fileread
str_para_fileread	i_para_reset		// i_str_filereadの初期化用

// ドラッグファイル
string	i_dragfile[]		// ドラッグファイル パス・ファイル名を格納する配列
long	i_dragfile_cnt		// ドラッグしたファイル件数
datastore i_dts
end variables

forward prototypes
public function boolean of_erorr_check ()
public subroutine of_dsp_reset ()
public subroutine of_data_count ()
public subroutine of_filter_set ()
public function boolean of_db_update ()
public function integer of_fileread_excel (string p_filename)
public subroutine of_filter_make ()
end prototypes

event dropfile;
// -----------------------------------------------------------------------
//	イベント	:	dropfiles
//	処理概要	:	外部からファイルをドラッグしたときに走るイベント
//	返り値		:	成否( 0:成功 1:失敗 )
// -----------------------------------------------------------------------
nv_dropfile	l_dropfile

if l_dropfile.of_dragqueryfile(handle,i_dragfile_cnt,i_dragfile) <> 0 then
	return 1
end if

if not isnull(i_dragfile) and i_dragfile_cnt > 0 then
	l_dropfile.of_mouseevent()

	i_str_fileread.ret[1].filename	= i_dragfile[1]
	// ファイル読込画面起動
	this.event key_f07(KeyF7!,0)
end if

return 0

end event

public function boolean of_erorr_check ();
long	l_row,l_row_s
long	l_cnt

long	l_err_cnt	= 0

// (速度対策)DWObject参照定義
dwobject dwlo_status
dwobject dwlo_msg
dwobject dwlo_f_tokui_code
dwobject dwlo_t_tokui_mei
dwobject dwlo_f_syohin_code
dwobject dwlo_s_hin_ban
dwobject dwlo_s_hin_mei
dwobject dwlo_f_tanka
dwobject dwlo_f_up1
dwobject dwlo_f_up2
dwobject dwlo_f_up3
dwobject dwlo_f_up4
dwobject dwlo_f_up5
dwobject dwlo_f_zei_kbn
dwobject dwlo_f_zei_ritu
dwobject dwlo_f_tekiyo_date_sta
dwobject dwlo_f_tekiyo_date_end
dwobject dwlo_x_syori_kbn
dwobject dwlo_x_operation
dwobject dwlo_m_tanka
dwobject dwlo_m_zei_kbn
dwobject dwlo_m_operation
dwobject dwlo_x_yakujyo
dwobject dwlo_s_jyoudai
dwobject dwlo_t_syusoku_flg
dwobject dwlo_s_syusoku_flg

dwlo_status				= dw_list.object.status
dwlo_msg				= dw_list.object.msg
dwlo_f_tokui_code		= dw_list.object.f_tokui_code
dwlo_t_tokui_mei		= dw_list.object.t_tokui_mei
dwlo_f_syohin_code		= dw_list.object.f_syohin_code
dwlo_s_hin_ban			= dw_list.object.s_hin_ban
dwlo_s_hin_mei			= dw_list.object.s_hin_mei
dwlo_f_tanka			= dw_list.object.f_tanka
dwlo_f_up1				= dw_list.object.f_up1
dwlo_f_up2				= dw_list.object.f_up2
dwlo_f_up3				= dw_list.object.f_up3
dwlo_f_up4				= dw_list.object.f_up4
dwlo_f_up5				= dw_list.object.f_up5
dwlo_f_zei_kbn			= dw_list.object.f_zei_kbn
dwlo_f_zei_ritu			= dw_list.object.f_zei_ritu
dwlo_f_tekiyo_date_sta	= dw_list.object.f_tekiyo_date_sta
dwlo_f_tekiyo_date_end	= dw_list.object.f_tekiyo_date_end
dwlo_x_syori_kbn		= dw_list.object.x_syori_kbn
dwlo_x_operation		= dw_list.object.x_operation
dwlo_m_tanka			= dw_list.object.m_tanka
dwlo_m_zei_kbn			= dw_list.object.m_zei_kbn
dwlo_m_operation		= dw_list.object.m_operation
dwlo_x_yakujyo			= dw_list.object.x_yakujyo
dwlo_s_jyoudai			= dw_list.object.s_jyoudai
dwlo_t_syusoku_flg		= dw_list.object.t_syusoku_flg
dwlo_s_syusoku_flg		= dw_list.object.s_syusoku_flg

// 6.データチェック
// 6-01.項目数

for l_row = 1 to dw_list.rowcount()
	// 6-27:(Err)エラー500件超えたら処理中断
	if l_err_cnt > 500 then
		msg.of_error("エラーチェック時のエラー件数が500件を超えました。処理を中断します。")
		return false
	end if
	
	// 6-02:(Err)得意先コード 商品コード
	if (dwlo_f_tokui_code.primary[l_row] = 0) and (dwlo_f_syohin_code.primary[l_row] = 0) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "得意先コード、商品コードが不正です。"
		continue
	end if

	// 6-03:(Err)得意先コード 商品コード
	for l_row_s = 1 to l_row - 1
		if (dwlo_f_tokui_code.primary[l_row] = dwlo_f_tokui_code.primary[l_row_s]) and (dwlo_f_syohin_code.primary[l_row] = dwlo_f_syohin_code.primary[l_row_s]) then
			l_err_cnt	= l_err_cnt + 1
			dwlo_status.primary[l_row]	= "エラー"
			dwlo_msg.primary[l_row]		= "得意先コード、商品コードが重複しています。"
			exit
		end if
		if l_row_s <> l_row - 1 then continue
	next
	
	// 6-04:(Err)単価
	if dwlo_m_tanka.primary[l_row] = 0 then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "単価マスタにレコードが存在しません。"
		continue
	end if
	
	// 6-05:(Err)適用終了日
	if (dwlo_f_tekiyo_date_end.primary[l_row] <> 99999999) and (dwlo_x_syori_kbn.primary[l_row] = "1:登録") then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "登録時は適用終了日が99999999以外をセットできません。"
		continue
	end if
	
	// 6-06:(Err)得意先コード
	if dwlo_t_tokui_mei.primary[l_row] = "" then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "得意先マスタに登録されていません。"
		continue
	end if
	
	// 6-07:(Err)商品コード
	if dwlo_s_hin_ban.primary[l_row] = "" then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "商品マスタに登録されていません。"
		continue
	end if
	
	// 6-08:(Err)適用開始日～適用終了日
	
	// 6-09:(Err)適用開始日～適用終了日
	if (dwlo_f_tekiyo_date_sta.primary[l_row] <> 0) and (dwlo_f_tekiyo_date_end.primary[l_row] <> 0) then
		if dwlo_f_tekiyo_date_sta.primary[l_row] > dwlo_f_tekiyo_date_end.primary[l_row] then
			l_err_cnt	= l_err_cnt + 1
			dwlo_status.primary[l_row]	= "エラー"
			dwlo_msg.primary[l_row]		= "適用開始日は適用終了日よりも前の日付を入力してください。"
			continue
		end if
	end if
	
	// 6-10:(Err)適用開始日
	if (dwlo_f_tekiyo_date_sta.primary[l_row] <> 0) and (dwlo_f_tekiyo_date_sta.primary[l_row] < today()) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "適用開始日に過去の日付が入力されています。"
		continue
	end if
	
	// 6-11:(Err)適用終了日
	if (dwlo_f_tekiyo_date_end.primary[l_row] <> 0) and (dwlo_f_tekiyo_date_end.primary[l_row] < today()) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "適用終了日は未来の日付を入力してください。"
		continue
	end if
	
	// 6-12:(Err)適用開始日
	if (dwlo_f_tekiyo_date_sta.primary[l_row] <> 0) and (dwlo_f_tekiyo_date_sta.primary[l_row] > today()) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "適用開始日は現在日付の1年以内で入力してください。"
		continue
	end if
	
	// 6-13:(Err)税区分 税率
	if (dwlo_f_zei_kbn.primary[l_row] = 0) and (dwlo_f_zei_ritu.primary[l_row] <> 0) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "税区分と税率の組み合わせが不正です。"
		continue
	end if
	if (dwlo_f_zei_kbn.primary[l_row] <> 0) and (dwlo_f_zei_ritu.primary[l_row] = 0) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "税区分と税率の組み合わせが不正です。"
		continue
	end if
	
	// 6-14:(Err)税区分
	if dwlo_f_zei_kbn.primary[l_row] <> dwlo_m_zei_kbn.primary[l_row] then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "税区分が得意先の税区分と一致しません。"
		continue
	end if
	
	// 6-15:(Err)単価 アップ額
	if (dwlo_f_tanka.primary[l_row] < 0) or (dwlo_f_tanka.primary[l_row] <> round(dwlo_f_tanka.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "単価は整数を入力してください。"
		continue
	end if
	if (dwlo_f_up1.primary[l_row] < 0) or (dwlo_f_up1.primary[l_row] <> round(dwlo_f_up1.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "Up_1は整数を入力してください。"
		continue
	end if
	if (dwlo_f_up2.primary[l_row] < 0) or (dwlo_f_up2.primary[l_row] <> round(dwlo_f_up2.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "Up_2は整数を入力してください。"
		continue
	end if
	if (dwlo_f_up3.primary[l_row] < 0) or (dwlo_f_up3.primary[l_row] <> round(dwlo_f_up3.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "Up_3は整数を入力してください。"
		continue
	end if
	if (dwlo_f_up4.primary[l_row] < 0) or (dwlo_f_up4.primary[l_row] <> round(dwlo_f_up4.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "Up_4は整数を入力してください。"
		continue
	end if
	if (dwlo_f_up5.primary[l_row] < 0) or (dwlo_f_up5.primary[l_row] <> round(dwlo_f_up5.primary[l_row],0)) then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "Up_5は整数を入力してください。"
		continue
	end if
	
	// 6-16:(Err)商品コード
	if dwlo_s_syusoku_flg.primary[l_row] = 9 then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "商品が終息済です。"
		continue
	end if
	
	// 6-17:(Err)得意先コード
	if dwlo_t_syusoku_flg.primary[l_row] = 9 then
		l_err_cnt	= l_err_cnt + 1
		dwlo_status.primary[l_row]	= "エラー"
		dwlo_msg.primary[l_row]		= "得意先が終息済です。"
		continue
	end if
	
	// 6-18:(Warn)単価
	if dwlo_f_tanka.primary[l_row] > 30000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "単価が30000円以上です。"
		continue
	end if
	
	// 6-19:(Warn)単価
	if dwlo_f_tanka.primary[l_row] > dwlo_s_jyoudai.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "単価が上代より高い金額です。"
		continue
	end if
	
	// 6-20:(Warn)アップ額
	if dwlo_f_up1.primary[l_row] > 5000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が5001円以上です。"
		continue
	end if
	if dwlo_f_up2.primary[l_row] > 5000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が5001円以上です。"
		continue
	end if
	if dwlo_f_up3.primary[l_row] > 5000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が5001円以上です。"
		continue
	end if
	if dwlo_f_up4.primary[l_row] > 5000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が5001円以上です。"
		continue
	end if
	if dwlo_f_up5.primary[l_row] > 5000 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が5001円以上です。"
		continue
	end if
	
	// 6-21:(Warn)アップ額
	if dwlo_f_up1.primary[l_row] > dwlo_x_yakujyo.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が約定価格より高い金額です。"
		continue
	end if
	if dwlo_f_up2.primary[l_row] > dwlo_x_yakujyo.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が約定価格より高い金額です。"
		continue
	end if
	if dwlo_f_up3.primary[l_row] > dwlo_x_yakujyo.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が約定価格より高い金額です。"
		continue
	end if
	if dwlo_f_up4.primary[l_row] > dwlo_x_yakujyo.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が約定価格より高い金額です。"
		continue
	end if
	if dwlo_f_up5.primary[l_row] > dwlo_x_yakujyo.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額が約定価格より高い金額です。"
		continue
	end if
	
	// 6-22:(Warn)アップ額
	if dwlo_f_up1.primary[l_row] < 100 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額に100円未満の金額が入力されています。"
		continue
	end if
	if dwlo_f_up2.primary[l_row] < 100 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額に100円未満の金額が入力されています。"
		continue
	end if
	if dwlo_f_up3.primary[l_row] < 100 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額に100円未満の金額が入力されています。"
		continue
	end if
	if dwlo_f_up4.primary[l_row] < 100 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額に100円未満の金額が入力されています。"
		continue
	end if
	if dwlo_f_up5.primary[l_row] < 100 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額に100円未満の金額が入力されています。"
		continue
	end if
	
	// 6-23:(Warn)アップ額
	if dwlo_f_up1.primary[l_row] > dwlo_f_up2.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額1 ≦ アップ額2 ≦ アップ額3 ≦ アップ額4 ≦ アップ額5ではありません。"
		continue
	end if
	if dwlo_f_up2.primary[l_row] > dwlo_f_up3.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額1 ≦ アップ額2 ≦ アップ額3 ≦ アップ額4 ≦ アップ額5ではありません。"
		continue
	end if
	if dwlo_f_up3.primary[l_row] > dwlo_f_up4.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額1 ≦ アップ額2 ≦ アップ額3 ≦ アップ額4 ≦ アップ額5ではありません。"
		continue
	end if
	if dwlo_f_up4.primary[l_row] > dwlo_f_up5.primary[l_row] then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "アップ額1 ≦ アップ額2 ≦ アップ額3 ≦ アップ額4 ≦ アップ額5ではありません。"
		continue
	end if
	
	// 6-24:(Warn)適用開始日～適用終了日
	if dwlo_f_tekiyo_date_sta.primary[l_row] - dwlo_f_tekiyo_date_sta.primary[l_row] > 6 then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "適用開始日と適用終了日の期間が6か月以上です。"
		continue
	end if
	
	// 6-25:(Warn)適用開始日
	if (dwlo_f_tekiyo_date_sta.primary[l_row] <> 0) and (dwlo_f_tekiyo_date_sta.primary[l_row] > today()) then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "適用開始日が2か月先以降の日付です。"
		continue
	end if
	
	// 6-26:(Warn)予約登録
	if dwlo_m_operation.primary[l_row] = "予約登録" then
		dwlo_status.primary[l_row]	= "警告"
		dwlo_msg.primary[l_row]		= "既に予約登録済です。"
		continue
	end if
next

return true

end function

public subroutine of_dsp_reset ();
string	l_nendo_mei
long	l_kisyo_nengetu
long	l_indx

// constructorで各コントロールリセット(ロック解除優先のため先にDWから）
ddplb_status.event constructor()
ddplb_msg.event constructor()

dw_list.event constructor()
cb_retrieve.event constructor()

st_filename.event constructor()
st_cnt.event constructor()
st_okcnt.event constructor()
st_errcnt.event constructor()
st_warncnt.event constructor()

end subroutine

public subroutine of_data_count ();
// 件数セット
long	l_okcnt		= 0
long	l_errcnt	= 0
long	l_warncnt	= 0
long	l_row
string	l_status
string	l_filter_status
string	l_filter_msg

dwobject dwlo_status
dwlo_status = dw_list.object.status

// フィルター解除
// 解除前条件保持
l_filter_status	= ddplb_status.text
l_filter_msg	= ddplb_msg.text
ddplb_status.text	= "(未選択)"
ddplb_msg.text		= "(未選択)"
of_filter_set()

for l_row = 1 to dw_list.rowcount()
	l_status = dwlo_status.primary[l_row]
	
	choose case l_status
		case "エラー"
			l_errcnt = l_errcnt + 1
			
		case "警告"
			l_warncnt = l_warncnt + 1
			
		case else
			l_okcnt = l_okcnt + 1
			
	end choose
next

// 値をセット
st_cnt.text		= string(dw_list.rowcount())
st_okcnt.text	= string(l_okcnt)
st_errcnt.text	= string(l_errcnt)
st_warncnt.text	= string(l_warncnt)

// フィルター再セット
ddplb_status.text	= l_filter_status
ddplb_msg.text		= l_filter_msg
of_filter_set()

end subroutine

public subroutine of_filter_set ();
// フィルター実行
string	l_status
string	l_msg

integer	l_row
string	l_filter	= ""

l_status	= ddplb_status.text
l_msg		= ddplb_msg.text

l_row	= dw_list.getrow()
dw_list.setredraw(false)

// フィルタのリセット
dw_list.setfilter("")
dw_list.filter()

// ステータス
if l_status <> "(未選択)" then
	l_filter = "status = '" + l_status + "'"
end if

// メッセージ
if l_msg <> "(未選択)" then
	if len( l_filter ) <> 0 then
		l_filter = l_filter + " and msg = '" + l_msg + "'"
	else
		l_filter = "msg = '" + l_msg + "'"
	end if
end if

if len(l_filter) <> 0 then
	// フィルタセット
	dw_list.setfilter(l_filter)
	dw_list.filter()
end if

dw_list.setredraw(true)
end subroutine

public function boolean of_db_update ();
// DB更新処理
// 排他フラグが1件でもONとなっている場合、全RollBack後エラーとする
long	l_row
long	l_cnt

// (速度対策)DWObject参照定義
dwobject dwlo_f_tokui_code
dwobject dwlo_f_syohin_code
dwobject dwlo_f_tanka
dwobject dwlo_f_up1
dwobject dwlo_f_up2
dwobject dwlo_f_up3
dwobject dwlo_f_up4
dwobject dwlo_f_up5
dwobject dwlo_f_zei_kbn
dwobject dwlo_f_zei_ritu
dwobject dwlo_f_tekiyo_date_sta
dwobject dwlo_f_tekiyo_date_end
dwobject dwlo_x_syori_kbn
dwobject dwlo_x_operation
dwobject dwlo_m_tanka

dwlo_f_tokui_code      = dw_list.object.f_tokui_code
dwlo_f_syohin_code     = dw_list.object.f_syohin_code
dwlo_f_tanka           = dw_list.object.f_tanka
dwlo_f_up1             = dw_list.object.f_up1
dwlo_f_up2             = dw_list.object.f_up2
dwlo_f_up3             = dw_list.object.f_up3
dwlo_f_up4             = dw_list.object.f_up4
dwlo_f_up5             = dw_list.object.f_up5
dwlo_f_zei_kbn         = dw_list.object.f_zei_kbn
dwlo_f_zei_ritu        = dw_list.object.f_zei_ritu
dwlo_f_tekiyo_date_sta = dw_list.object.f_tekiyo_date_sta
dwlo_f_tekiyo_date_end = dw_list.object.f_tekiyo_date_end
dwlo_x_syori_kbn       = dw_list.object.x_syori_kbn
dwlo_x_operation       = dw_list.object.x_operation
dwlo_m_tanka           = dw_list.object.m_tanka

long	l_tokui_code
long	l_syohin_code
decimal	l_tanka
long	l_up_1,l_up_2,l_up_3,l_up_4,l_up_5
long	l_tanka_henkou_date
decimal	l_old_tanka
long	l_zei_kbn
decimal	l_zeiritu
decimal	l_zeibetu_tanka
long	l_zeibetu_up_1,l_zeibetu_up_2,l_zeibetu_up_3,l_zeibetu_up_4,l_zeibetu_up_5
decimal	l_new_tanka
long	l_new_up_1,l_new_up_2,l_new_up_3,l_new_up_4,l_new_up_5
long	l_new_zei_kbn
decimal	l_new_zeiritu
long	l_tekiyo_date_str,l_tekiyo_date_end

// 取込データ更新開始
hpb_progres.maxposition = dw_list.rowcount()
hpb_progres.position = 0

for l_row = 1 to dw_list.rowcount()
	hpb_progres.position = l_row

	// 登録データ取得
	l_tokui_code				= dwlo_f_tokui_code.primary[l_row]
	l_syohin_code				= dwlo_f_syohin_code.primary[l_row]
	
	choose case dwlo_x_operation.primary[l_row]
		case "即時"
			l_tanka				= dwlo_f_tanka.primary[l_row]
			l_up_1				= dwlo_f_up1.primary[l_row]
			l_up_2				= dwlo_f_up2.primary[l_row]
			l_up_3				= dwlo_f_up3.primary[l_row]
			l_up_4				= dwlo_f_up4.primary[l_row]
			l_up_5				= dwlo_f_up5.primary[l_row]
			l_tanka_henkou_date	= dwlo_f_tekiyo_date_sta.primary[l_row]
			l_old_tanka			= dwlo_m_tanka.primary[l_row]
			l_zei_kbn			= long(left(dwlo_f_zei_kbn.primary[l_row],1))
			l_zeiritu			= dwlo_f_zei_ritu.primary[l_row]
			
			if l_zei_kbn = 1 then
				// 単価税別
				l_zeibetu_tanka	= l_tanka
				l_zeibetu_up_1	= l_up_1
				l_zeibetu_up_2	= l_up_2
				l_zeibetu_up_3	= l_up_3
				l_zeibetu_up_4	= l_up_4
				l_zeibetu_up_5	= l_up_5
			else
				// 単価税込
				l_zeibetu_tanka	= l_tanka / (1 + l_zeiritu / 100)
				l_zeibetu_up_1	= l_up_1 / (1 + l_zeiritu / 100)
				l_zeibetu_up_2	= l_up_2 / (1 + l_zeiritu / 100)
				l_zeibetu_up_3	= l_up_3 / (1 + l_zeiritu / 100)
				l_zeibetu_up_4	= l_up_4 / (1 + l_zeiritu / 100)
				l_zeibetu_up_5	= l_up_5 / (1 + l_zeiritu / 100)
			end if

			l_new_tanka			= 0
			l_new_up_1			= 0
			l_new_up_2			= 0
			l_new_up_3			= 0
			l_new_up_4			= 0
			l_new_up_5			= 0
			l_new_zei_kbn		= 0
			l_new_zeiritu		= 0
			l_tekiyo_date_str	= 0
			l_tekiyo_date_end	= 0

		case "予約登録"
			l_tanka				= 0
			l_up_1				= 0
			l_up_2				= 0
			l_up_3				= 0
			l_up_4				= 0
			l_up_5				= 0
			l_tanka_henkou_date	= 0
			l_old_tanka			= 0
			l_zei_kbn			= 0
			l_zeiritu			= 0
			l_zeibetu_tanka		= 0
			l_zeibetu_up_1		= 0
			l_zeibetu_up_2		= 0
			l_zeibetu_up_3		= 0
			l_zeibetu_up_4		= 0
			l_zeibetu_up_5		= 0

			l_new_tanka			= dwlo_f_tanka.primary[l_row]
			l_new_up_1			= dwlo_f_up1.primary[l_row]
			l_new_up_2			= dwlo_f_up2.primary[l_row]
			l_new_up_3			= dwlo_f_up3.primary[l_row]
			l_new_up_4			= dwlo_f_up4.primary[l_row]
			l_new_up_5			= dwlo_f_up5.primary[l_row]
			l_new_zei_kbn		= long(left(dwlo_f_zei_kbn.primary[l_row],1))
			l_new_zeiritu		= dwlo_f_zei_ritu.primary[l_row]
			l_tekiyo_date_str	= dwlo_f_tekiyo_date_sta.primary[l_row]
			l_tekiyo_date_end	= dwlo_f_tekiyo_date_end.primary[l_row]
			
	end choose
	
	choose case dwlo_x_syori_kbn.primary[l_row]
		case "1:追加"
			// 単価M追加
			choose case dwlo_x_operation.primary[l_row]
				case "即時"
					insert into m_tanka (
						tokui_code,syohin_code,
						tanka,
						up_1,up_2,up_3,up_4,up_5,
						tanka_henkou_date,
						old_tanka,
						zei_kbn,zeiritu,
						zeibetu_tanka,
						zeibetu_up_1,zeibetu_up_2,zeibetu_up_3,zeibetu_up_4,zeibetu_up_5,
						touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id)
					values (
						:l_tokui_code,:l_syohin_code,
						:l_tanka,
						:l_up_1,:l_up_2,:l_up_3,:l_up_4,:l_up_5,
						:l_tanka_henkou_date,
						:l_old_tanka,
						:l_zei_kbn,:l_zeiritu,
						:l_zeibetu_tanka,
						:l_zeibetu_up_1,:l_zeibetu_up_2,:l_zeibetu_up_3,:l_zeibetu_up_4,:l_zeibetu_up_5,
						SYSDATE,:user.user_id,:device.name,:i_pg_id)
					using cocos;
					
				case "予約登録"
					insert into m_tanka (
						tokui_code,syohin_code,
						new_tanka,
						new_up_1,new_up_2,new_up_3,new_up_4,new_up_5,
						new_zei_kbn,new_zeiritu,
						tekiyo_date_str,tekiyo_date_end,
						touroku_date,touroku_user_id,touroku_client_id,touroku_pg_id)
					values (
						:l_tokui_code,:l_syohin_code,
						:l_new_tanka,
						:l_new_up_1,:l_new_up_2,:l_new_up_3,:l_new_up_4,:l_new_up_5,
						:l_new_zei_kbn,:l_new_zeiritu,
						:l_tekiyo_date_str,:l_tekiyo_date_end,
						SYSDATE,:user.user_id,:device.name,:i_pg_id)
					using cocos;
					
			end choose
			
		case "2:更新"
			// 単価M更新
			choose case dwlo_x_operation.primary[l_row]
				case "即時"
					update	m_tanka
					   set	tanka				= :l_tanka,
							up_1				= :l_up_1,
							up_2				= :l_up_2,
							up_3				= :l_up_3,
							up_4				= :l_up_4,
							up_5				= :l_up_5,
							tanka_henkou_date	= :l_tanka_henkou_date,
							old_tanka			= :l_old_tanka,
							zei_kbn				= :l_zei_kbn,
							zeiritu				= :l_zeiritu,
							zeibetu_tanka		= :l_zeibetu_tanka,
							zeibetu_up_1		= :l_zeibetu_up_1,
							zeibetu_up_2		= :l_zeibetu_up_2,
							zeibetu_up_3		= :l_zeibetu_up_3,
							zeibetu_up_4		= :l_zeibetu_up_4,
							zeibetu_up_5		= :l_zeibetu_up_5,
							henkou_date			= SYSDATE,
							henkou_user_id		= :user.user_id,
							henkou_client_id	= :device.name,
							henkou_pg_id		= :i_pg_id,
							kousin_date			= SYSDATE,
							kousin_user_id		= :user.user_id,
							kousin_client_id	= :device.name,
							kousin_pg_id		= :i_pg_id
					 where	tokui_code  = :l_tokui_code
					   and	syohin_code = :l_syohin_code
					   and	haita_flg   = 0
					 using	cocos;
					
				case "予約登録"
					update	m_tanka
					   set	new_tanka			= :l_new_tanka,
							new_up_1			= :l_new_up_1,
							new_up_2			= :l_new_up_2,
							new_up_3			= :l_new_up_3,
							new_up_4			= :l_new_up_4,
							new_up_5			= :l_new_up_5,
							new_zei_kbn			= :l_new_zei_kbn,
							new_zeiritu			= :l_new_zeiritu,
							tekiyo_date_str		= :l_tekiyo_date_str,
							tekiyo_date_end		= :l_tekiyo_date_end,
							henkou_date			= SYSDATE,
							henkou_user_id		= :user.user_id,
							henkou_client_id	= :device.name,
							henkou_pg_id		= :i_pg_id,
							kousin_date			= SYSDATE,
							kousin_user_id		= :user.user_id,
							kousin_client_id	= :device.name,
							kousin_pg_id		= :i_pg_id
					 where	tokui_code  = :l_tokui_code
					   and	syohin_code = :l_syohin_code
					   and	haita_flg   = 0
					 using	cocos;
					
			end choose
			
		case "3:削除"
			// 単価M削除
			delete from m_tanka
			 where tokui_code  = :l_tokui_code
			   and syohin_code = :l_syohin_code
			   and haita_flg   = 0
			 using cocos;
	end choose
	
	if cocos.sqlnrows = 0 then
		
	end if

	if cocos.sqlcode <> 0 then
		rollback using cocos;
		msg.of_error(fnc.strg.of_format("単価マスタの更新処理でエラーが発生しました。{1}{2}：{3}",code.crlf,string(cocos.last_sqlerrcode),cocos.last_sqlerrtext))
		of_add_db_log("of_db_update", cocos.last_sqlerrcode,cocos.last_sqlerrtext)
		return false
	end if
	
	yield()
next

hpb_progres.position = 0

//登録完了
commit using cocos;

return true
end function

public function integer of_fileread_excel (string p_filename);
// ファイル読込 EXCEL
oleobject	ole_excel
oleobject	ole_xlsheet

int			l_rtn
string		l_savefile
long		l_cnt

ole_excel = create oleobject

// Excelオブジェクト接続
l_rtn = ole_excel.ConnectToNewObject("Excel.Application")
if l_rtn < 0 then
	// EXCEL OLE接続に失敗

	// Excelオブジェクト破棄
	ole_excel.disconnectobject()
	destroy ole_excel
	return 1
end if

ole_excel.workbooks.open(p_filename)

// 保存先
l_savefile	= GetCurrentDirectory() + "\TEMP_" + string(Today(),"YYYYMMDDHHMMSS") + ".txt"

// TAB区切りテキストに変換して保存
ole_excel.application.activeworkbook.saveas(l_savefile,-4158)

// Excelオブジェクト破棄
ole_excel.application.displayalerts = false
ole_excel.application.quit
ole_excel.disconnectobject()
destroy ole_excel

// Text!でインポート
l_cnt = i_dts.importfile(Text!,l_savefile)

if l_cnt < 0 then
	// ファイル削除
	filedelete(l_savefile)
	return 1
end if

// ファイル削除
filedelete(l_savefile)

return 0
end function

public subroutine of_filter_make ();
// フィルター条件セット
long	l_row
string	l_status
string	l_msg

long	l_rtn

dwobject dwlo_status
dwobject dwlo_msg

dwlo_status = dw_list.object.status
dwlo_msg    = dw_list.object.msg

// 初期化
ddplb_status.event constructor()
ddplb_msg.event constructor()

for l_row = 1 to dw_list.rowcount()
	l_status	= dwlo_status.primary[l_row]
	l_msg		= dwlo_msg.primary[l_row]
	
	// ステータス
	//l_rtn	= ddplb_status.FindItem(l_status,0)
	
	if ddplb_status.FindItem(l_status,0) = -1 then
		ddplb_status.insertitem(l_status,upperbound(ddplb_status.item) + 1)
	end if
	
	// メッセージ
	if ddplb_msg.finditem(l_msg,0) = -1 then
		ddplb_msg.insertitem(l_msg,upperbound(ddplb_msg.item) + 1)
	end if
next

end subroutine

on wld_genka_baika.create
int iCurrent
call super::create
this.st_status=create st_status
this.st_msg=create st_msg
this.cb_clear=create cb_clear
this.dw_list=create dw_list
this.st_filename_t=create st_filename_t
this.st_filename=create st_filename
this.st_cnt_t=create st_cnt_t
this.st_cnt=create st_cnt
this.st_okcnt_t=create st_okcnt_t
this.st_okcnt=create st_okcnt
this.st_errcnt_t=create st_errcnt_t
this.st_errcnt=create st_errcnt
this.st_warncnt_t=create st_warncnt_t
this.st_warncnt=create st_warncnt
this.ddplb_status=create ddplb_status
this.ddplb_msg=create ddplb_msg
this.hpb_progres=create hpb_progres
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_status
this.Control[iCurrent+2]=this.st_msg
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.st_filename_t
this.Control[iCurrent+6]=this.st_filename
this.Control[iCurrent+7]=this.st_cnt_t
this.Control[iCurrent+8]=this.st_cnt
this.Control[iCurrent+9]=this.st_okcnt_t
this.Control[iCurrent+10]=this.st_okcnt
this.Control[iCurrent+11]=this.st_errcnt_t
this.Control[iCurrent+12]=this.st_errcnt
this.Control[iCurrent+13]=this.st_warncnt_t
this.Control[iCurrent+14]=this.st_warncnt
this.Control[iCurrent+15]=this.ddplb_status
this.Control[iCurrent+16]=this.ddplb_msg
this.Control[iCurrent+17]=this.hpb_progres
end on

on wld_genka_baika.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_status)
destroy(this.st_msg)
destroy(this.cb_clear)
destroy(this.dw_list)
destroy(this.st_filename_t)
destroy(this.st_filename)
destroy(this.st_cnt_t)
destroy(this.st_cnt)
destroy(this.st_okcnt_t)
destroy(this.st_okcnt)
destroy(this.st_errcnt_t)
destroy(this.st_errcnt)
destroy(this.st_warncnt_t)
destroy(this.st_warncnt)
destroy(this.ddplb_status)
destroy(this.ddplb_msg)
destroy(this.hpb_progres)
end on

event resize;call super::resize;
// 1段目ボタン(Height:85) Y座標：156
// 2段目ボタン(Height:85) Y座標：256
long	l_width

if newwidth < 3924 then
	l_width		= 3924 + code.MGN_YOKO
	this.width	= l_width + code.MGN_YOKO
else
	l_width	= newwidth
end if

hpb_progres.y = st_second_upper.y	+ st_second_upper.height - hpb_progres.height - 4
hpb_progres.width = newwidth - 16

// フィルター部
st_status.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_status.y		= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
st_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE + 7
ddplb_msg.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.y			= st_second_upper.y	+ st_second_upper.height + code.MGN_TATE
cb_clear.x			= l_width - cb_clear.width - code.MGN_YOKO

// フッター1
st_filename.y		= key_fnc.y - code.MGN_TATE - st_filename.height
st_filename_t.y		= st_filename.y
st_cnt_t.y			= st_filename.y + 7
st_cnt.y			= st_filename.y
st_okcnt_t.y		= st_filename.y + 7
st_okcnt.y			= st_filename.y
st_errcnt_t.y		= st_filename.y + 7
st_errcnt.y			= st_filename.y
st_warncnt_t.y		= st_filename.y + 7
st_warncnt.y		= st_filename.y

// dw
dw_list.y			= cb_clear.y + cb_clear.height + code.MGN_TATE
dw_list.x			= code.MGN_YOKO
dw_list.width		= l_width - code.MGN_YOKO * 2
dw_list.height		= st_filename.y - code.MGN_TATE - dw_list.y

end event

event key_f07;call super::key_f07;
// ファイル読込
openwithparm(iw_fileread_window,i_str_fileread,this)

i_str_fileread = message.powerobjectparm

if upperbound(i_str_fileread.ret) > 0 then
	// ファイル名セット
	st_filename.text = i_str_fileread.ret[1].filename
	// ファイル読込結果を画面にセット
	cb_retrieve.event execution(0,0)
end if

return 0

end event

event open;call super::open;
// -------------------------------------------------------------
// ドラッグ＆ドロップの非許可
// -----------------------------------------------------------------
nv_dropfile	l_dropfile

l_dropfile.of_dragacceptfiles(Handle(This),True)

dw_list.setfocus()

end event

event retrieve_event;call super::retrieve_event;
// ファイル読込
string	l_file
long	l_row
long	l_cnt

long	l_tokui_code
long	l_jan_code
long	l_sku_code
long	l_syohin_code
string	l_iro_no,l_iro_mei
string	l_size_mei
decimal	l_jyoudai
long	l_kakaku_group_kbn
long	l_up_iti

string	l_tokui_mei
string	l_hin_ban,l_hin_mei
decimal	l_tanka
decimal	l_kakeritu
long	l_upkomi_kbn

long	l_up_1,l_up_2,l_up_3,l_up_4,l_up_5
string	l_zei_kbn
decimal	l_zeiritu
long	l_tekiyo_date_str,l_tekiyo_date_end
long	l_syusoku_flg

string	l_aite_hinban
decimal	l_aite_baika1,l_aite_baika2

// (速度対策)DWObject参照定義
dwobject dwlo_status
dwobject dwlo_msg

dwobject dwlo_f_tokui_code
dwobject dwlo_t_tokui_mei
dwobject dwlo_f_jan_code
dwobject dwlo_s_syohin_code
dwobject dwlo_s_iro_no
dwobject dwlo_s_hin_ban
dwobject dwlo_s_hin_mei
dwobject dwlo_s_iro_mei
dwobject dwlo_s_size_mei
dwobject dwlo_f_genka
dwobject dwlo_f_up
dwobject dwlo_f_baika1
dwobject dwlo_f_baika2
dwobject dwlo_f_aite_hinban
dwobject dwlo_f_zei_kbn
dwobject dwlo_f_zei_ritu
dwobject dwlo_f_tekiyo_date_sta
dwobject dwlo_f_tekiyo_date_end
dwobject dwlo_x_syori_kbn
dwobject dwlo_x_operation
dwobject dwlo_m_genka
dwobject dwlo_m_up1
dwobject dwlo_n_aite_baika1
dwobject dwlo_n_aite_baika2
dwobject dwlo_n_aite_hinban
dwobject dwlo_m_zei_kbn
dwobject dwlo_m_zei_ritu
dwobject dwlo_m_operation
dwobject dwlo_m_tekiyo_date_sta
dwobject dwlo_m_tekiyo_date_end
dwobject dwlo_t_syusoku_flg
dwobject dwlo_s_syusoku_flg
//dwobject dwlo_s_jyoudai
//dwobject dwlo_s_up_iti
//dwobject dwlo_k_kakeritu
//dwobject dwlo_k_upkomi_kbn

dwobject dso_data01
dwobject dso_data02
dwobject dso_data03
dwobject dso_data04
dwobject dso_data05
dwobject dso_data06
dwobject dso_data07
dwobject dso_data08
dwobject dso_data09
dwobject dso_data10
dwobject dso_data11

string	l_timer_1,l_timer_2,l_timer_3,l_timer_4

l_timer_1 = "データストアセット開始：" + String(Now(),"hh:mm:ss")

if upperbound(i_str_fileread.ret) > 0 then
	// データストア
	i_dts = create DataStore
	i_dts.dataobject = "dld_fileread"
	i_dts.reset()
	i_dts.settransobject(cocos)

	setredraw(false)

	dw_list.reset()

	l_file	= trim(i_str_fileread.ret[1].filename)

	// データストアにデータをセット
	if lena(l_file) > 0 then
		// ファイル読込
		choose case upper(mid(l_file,LastPos(l_file,"."),len(l_file)))
			case ".XLSX"
				if of_fileread_excel(l_file) <> 0 then
					msg.of_error("EXCEL読込に失敗しました。")
					return -1
				end if
				
			case ".CSV"
				i_dts.importfile(CSV!,l_file)
//				if of_fileread_csv(l_file) <> 0 then
//					msg.of_error("CSVL読込に失敗しました。")
//					return -1
//				end if
	
			case else	// TEXT、DAT
				i_dts.importfile(Text!,l_file)
//				if of_fileread_text(l_file) <> 0 then
//					msg.of_error("ファイル読込に失敗しました。")
//					return -1
//				end if
				
		end choose
	end if

	l_timer_2	= "データストアセット完了：" + String(Now(),"hh:mm:ss")
	
	// (速度対策)DWObject参照定義
	dwlo_status				= dw_list.object.status
	dwlo_msg				= dw_list.object.msg
	dwlo_f_tokui_code		= dw_list.object.f_tokui_code
	dwlo_t_tokui_mei		= dw_list.object.t_tokui_mei
	dwlo_f_jan_code			= dw_list.object.f_jan_code
	dwlo_s_syohin_code		= dw_list.object.s_syohin_code
	dwlo_s_iro_no			= dw_list.object.s_iro_no
	dwlo_s_hin_ban			= dw_list.object.s_hin_ban
	dwlo_s_hin_mei			= dw_list.object.s_hin_mei
	dwlo_s_iro_mei			= dw_list.object.s_iro_mei
	dwlo_s_size_mei			= dw_list.object.s_size_mei
	dwlo_f_genka			= dw_list.object.f_genka
	dwlo_f_up				= dw_list.object.f_up
	dwlo_f_baika1			= dw_list.object.f_baika1
	dwlo_f_baika2			= dw_list.object.f_baika2
	dwlo_f_aite_hinban		= dw_list.object.f_aite_hinban
	dwlo_f_zei_kbn			= dw_list.object.f_zei_kbn
	dwlo_f_zei_ritu			= dw_list.object.f_zei_ritu
	dwlo_f_tekiyo_date_sta	= dw_list.object.f_tekiyo_date_sta
	dwlo_f_tekiyo_date_end	= dw_list.object.f_tekiyo_date_end
	dwlo_x_syori_kbn		= dw_list.object.x_syori_kbn
	dwlo_x_operation		= dw_list.object.x_operation
	dwlo_m_genka			= dw_list.object.m_genka
	dwlo_m_up1				= dw_list.object.m_up1
	dwlo_n_aite_baika1		= dw_list.object.n_aite_baika1
	dwlo_n_aite_baika2		= dw_list.object.n_aite_baika2
	dwlo_n_aite_hinban		= dw_list.object.n_aite_hinban
	dwlo_m_zei_kbn			= dw_list.object.m_zei_kbn
	dwlo_m_zei_ritu			= dw_list.object.m_zei_ritu
	dwlo_m_operation		= dw_list.object.m_operation
	dwlo_m_tekiyo_date_sta	= dw_list.object.m_tekiyo_date_sta
	dwlo_m_tekiyo_date_end	= dw_list.object.m_tekiyo_date_end
	dwlo_t_syusoku_flg		= dw_list.object.t_syusoku_flg
	dwlo_s_syusoku_flg		= dw_list.object.s_syusoku_flg
	//dwlo_s_jyoudai			= dw_list.object.s_jyoudai
	//dwlo_s_up_iti				= dw_list.object.s_up_iti
	//dwlo_k_kakeritu			= dw_list.object.k_kakeritu
	//dwlo_k_upkomi_iti			= dw_list.object.k_upkomi_kbn

	dso_data01 = i_dts.object.data01
	dso_data02 = i_dts.object.data02
	dso_data03 = i_dts.object.data03
	dso_data04 = i_dts.object.data04
	dso_data05 = i_dts.object.data05
	dso_data06 = i_dts.object.data06
	dso_data07 = i_dts.object.data07
	dso_data08 = i_dts.object.data08
	dso_data09 = i_dts.object.data09
	dso_data10 = i_dts.object.data10
	dso_data11 = i_dts.object.data11

	// 画面に値をセット
	hpb_progres.maxposition = i_dts.rowcount()
	hpb_progres.position = 0
	
	for l_cnt = i_str_fileread.ret[1].startrow to i_dts.rowcount()
		l_row = dw_list.insertrow(0)
		
		hpb_progres.position = l_cnt
		
		l_tokui_code	= long(dso_data01.primary[l_cnt])	//得意先コード
		l_jan_code		= long(dso_data02.primary[l_cnt])	//JANコード
		
		// 1.取込ファイル項目設定
		dwlo_f_tokui_code.primary[l_row]		= long(dso_data01.primary[l_cnt])	//得意先コード
		dwlo_f_jan_code.primary[l_row]			= long(dso_data02.primary[l_cnt])	//JANコード
		dwlo_f_genka.primary[l_row]				= dec(dso_data03.primary[l_cnt])	//新原価
		dwlo_f_up.primary[l_row]				= dec(dso_data04.primary[l_cnt])	//新Up
		dwlo_f_baika1.primary[l_row]			= dec(dso_data05.primary[l_cnt])	//新売価1
		dwlo_f_baika2.primary[l_row]			= dec(dso_data06.primary[l_cnt])	//新売価2
		dwlo_f_aite_hinban.primary[l_row]		= dso_data07.primary[l_cnt]	//新相手品番
		dwlo_f_zei_kbn.primary[l_row]			= long(dso_data08.primary[l_cnt])	//税区分
		dwlo_f_zei_ritu.primary[l_row]			= dec(dso_data09.primary[l_cnt])	//税率
		dwlo_f_tekiyo_date_sta.primary[l_row]	= long(dso_data10.primary[l_cnt])	//適用開始日
		dwlo_f_tekiyo_date_end.primary[l_row]	= long(dso_data11.primary[l_cnt])	//適用終了日
		
		// 2.GTINマスタ、商品マスタ項目取得
		select	sku_code,syohin_code,iro_no
		  into	:l_sku_code,:l_syohin_code,:l_iro_no
		  from	m_gtin
		 where	gtin_code	= :l_jan_code
		   and	code_kbn	= 1	//1:JAN
		 using	cocos;
		
		select	hin_ban,hin_mei,
				iro_mei,size_mei,
				syusoku_flg,
				jyoudai,
				kakaku_group_kbn,
				up_iti
		  into	:l_hin_ban,:l_hin_mei,
				:l_iro_mei,:l_size_mei,
				:l_syusoku_flg,
				:l_jyoudai,
				:l_kakaku_group_kbn,
				:l_up_iti
		  from	m_syohin
		 where	syohin_code	= :l_syohin_code
		   and	iro_no		= :l_iro_no
		 using	cocos;
		
		dwlo_s_syohin_code.primary[l_row]		= l_syohin_code	//商品コード
		dwlo_s_iro_no.primary[l_row]			= l_iro_no	//色番
		dwlo_s_hin_ban.primary[l_row]			= l_hin_ban	//品番
		dwlo_s_hin_mei.primary[l_row]			= l_hin_mei	//品名
		dwlo_s_iro_mei.primary[l_row]			= l_iro_mei	//色名
		dwlo_s_size_mei.primary[l_row]			= l_size_mei	//サイズ名
		dwlo_s_syusoku_flg.primary[l_row]		= l_syusoku_flg	//終息フラグ(商品)
		//dwlo_s_jyoudai.primary[l_row]			= l_jyoudai	//上代
		//dwlo_s_up_iti.primary[l_row]			= l_size_mei	//Up位置
		
		// 3.掛率マスタ項目取得
		select	kakeritu,
				upkomi_kbn
		  into	:l_kakeritu,
		  		:l_upkomi_kbn
		  from	m_kakeritu
		 where	tokui_code			= :l_tokui_code
		   and	kakaku_group_kbn	= :l_kakaku_group_kbn
		 using	cocos;
		
		//dwlo_k_kakeritu.primary[l_row]					= l_kakeritu	//掛率
		//dwlo_k_upkomi_kbn.primary[l_row]					= l_upkomi_kbn	//掛率

		// 4.単価マスタ項目取得
		select	tanka,up_1,
				zei_kbn,zeiritu,
				tekiyo_date_str,tekiyo_date_end
		  into	:l_tanka,
				:l_up_1,:l_up_2,:l_up_3,:l_up_4,:l_up_5,
				:l_zei_kbn,:l_zeiritu,
				:l_tekiyo_date_str,:l_tekiyo_date_end
		  from	m_tanka
		 where	tokui_code	= :l_tokui_code
		   and	syohin_code	= :l_syohin_code
		 using	cocos;
		
		dwlo_m_genka.primary[l_row]				= l_tanka	//現在原価
		dwlo_m_up1.primary[l_row]				= l_up_1	//現在Up
		dwlo_m_zei_kbn.primary[l_row]			= l_zei_kbn	//現在税区分
		dwlo_m_zei_ritu.primary[l_row]			= l_zeiritu	//現在税率
		dwlo_m_tekiyo_date_sta.primary[l_row]	= l_tekiyo_date_str	//適用開始日
		dwlo_m_tekiyo_date_end.primary[l_row]	= l_tekiyo_date_end	//適用終了日
		
		// 5.相手品番マスタ項目取得
		select	aite_hinban,
				aite_baika1,aite_baika2
		  into	:l_aite_hinban,
		  		:l_aite_baika1,:l_aite_baika2
		  from	m_aite_hinban
		 where	tokui_code	= :l_tokui_code
		   and	sku_code	= :l_sku_code
		 using	cocos;
		
		dwlo_n_aite_hinban.primary[l_row]		= l_aite_hinban	//相手品番
		dwlo_n_aite_baika1.primary[l_row]		= l_aite_baika1	//相手売価1
		dwlo_n_aite_baika2.primary[l_row]		= l_aite_baika2	//相手売価2
		
		// 6.得意先マスタ項目取得
		select	tokui_mei,
				syusoku_flg
		  into	:l_tokui_mei,
		  		:l_syusoku_flg
		  from	m_tokui
		 where	tokui_code = :l_tokui_code
		 using	cocos;
		
		dwlo_t_tokui_mei.primary[l_row]			= trim(l_tokui_mei)	//得意先名
		dwlo_t_syusoku_flg.primary[l_row]		= l_syusoku_flg	//終息フラグ(得意先)
		
		// 6.算出項目設定
		if dwlo_f_genka.primary[l_row] = 0 then
			dwlo_x_syori_kbn.primary[l_row]		= "3:削除"	//処理区分
		else
			if dwlo_m_genka.primary[l_row] = 0 then
				dwlo_x_syori_kbn.primary[l_row]	= "1:登録"	//処理区分
			else
				dwlo_x_syori_kbn.primary[l_row]	= "2:更新"	//処理区分
			end if
		end if
		
		if dwlo_m_tekiyo_date_sta.primary[l_row] > today() then
			dwlo_m_operation.primary[l_row]		= "予約登録"	//登録方法
		end if	
		
		if dwlo_f_tekiyo_date_sta.primary[l_row] > today() then
			dwlo_x_operation.primary[l_row]		= "予約登録"	//登録方法
		else
			dwlo_x_operation.primary[l_row]		= "即時"	//登録方法
		end if	

		yield()
	next

	hpb_progres.position = 0
	
	l_timer_3 = "画面セット完了：" + String(Now(),"hh:mm:ss")

	// エラーチェック
	if of_erorr_check() = false then
		setredraw(true)
		return 1
	end if

	// 件数セット
	of_data_count()
	
	// フィルタ条件セット
	of_filter_make()
	
	// 構造体初期化
	i_str_fileread	= i_para_reset
	
	setredraw(true)
end if

l_timer_4 = "全処理完了：" + String(Now(),"hh:mm:ss")
//msg.of_info(fnc.strg.of_format("{1}{2}{3}{4}{5}{6}{7}",l_timer_1,code.CRLF,l_timer_2,code.CRLF,l_timer_3,code.CRLF,l_timer_4))

return 0

end event

event openquery;call super::openquery;
of_dsp_reset()

end event

event update_event;call super::update_event;
// 更新処理
string	l_rowcount
string	l_timer_s,l_timer_e

l_timer_s = "データ更新開始：" + String(Now(),"hh:mm:ss")

if not of_db_update() then
	rollback using cocos;
	return -1
end if

commit using cocos;

l_timer_e = "データ更新完了：" + String(Now(),"hh:mm:ss")

l_rowcount	= string(dw_list.rowcount(),"\ \ \ \ \ \ \ 0" ) + "件"
//msg.of_info( fnc.strg.of_format("正常終了しました{1}{2}{3}{1}{4}{1}{5}",code.crlf,"更新件数：",l_rowcount,l_timer_s,l_timer_e))

// 画面初期化
of_dsp_reset()

return 0
end event

event key_f01;call super::key_f01;
// 全選択
long	l_row
long	l_mode	// 1:全選択/0:全解除

// チェック全選択状態時のみ全解除処理、でなければ全選択処理
if dw_list.find("chk = 1",1,dw_list.rowcount()) = dw_list.rowcount() then
	l_mode	= 0
else
	l_mode	= 1
end if

for l_row = 1 TO dw_list.rowcount()
	 dw_list.object.chk[l_row] = l_mode
next

return 0
end event

event key_f03;call super::key_f03;
// 行削除
long	l_row

setredraw(false)

// チェックONの行を削除
for l_row = dw_list.rowcount() to 1 step -1
	if dw_list.object.chk[l_row] = 1 then
		dw_list.deleterow(l_row)
	end if
next

// 件数再セット
of_data_count()

setredraw(true)

return 0

end event

event update_check;call super::update_check;
// フィルター解除
cb_clear.event execution(0,0)

// エラー行がある場合は更新しない
if dw_list.find("status = 'エラー'",1,dw_list.rowcount()) > 0 then
	msg.of_error("エラー行がある為更新出来ません。エラー行を削除して下さい。")
	return -1
end if

return 0
end event

event key_f12;call super::key_f12;
if not of_evt_update(0,0) then
	return -1
end if

return 0


end event

type uo_signal from iw_main_window`uo_signal within wld_genka_baika
end type

type st_date from iw_main_window`st_date within wld_genka_baika
end type

type st_user_mei from iw_main_window`st_user_mei within wld_genka_baika
end type

type uo_test_mode from iw_main_window`uo_test_mode within wld_genka_baika
end type

type p_size_adjust from iw_main_window`p_size_adjust within wld_genka_baika
end type

type st_title from iw_main_window`st_title within wld_genka_baika
end type

type st_title_upper from iw_main_window`st_title_upper within wld_genka_baika
end type

type st_upper from iw_main_window`st_upper within wld_genka_baika
end type

type st_second_upper from iw_main_window`st_second_upper within wld_genka_baika
boolean f6_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
end type

type cb_retrieve from iw_main_window`cb_retrieve within wld_genka_baika
end type

event constructor;call super::constructor;
this.visible	= false
end event

type st_status from ivo_statictext within wld_genka_baika
integer x = 32
integer y = 384
integer width = 408
boolean bringtotop = true
string text = "ステータス"
alignment alignment = right!
end type

type st_msg from ivo_statictext within wld_genka_baika
integer x = 908
integer y = 395
integer width = 408
boolean bringtotop = true
string text = "メッセージ"
alignment alignment = right!
end type

type cb_clear from ivo_commandbutton within wld_genka_baika
integer x = 3664
integer y = 380
integer width = 408
integer taborder = 50
boolean bringtotop = true
string text = "条件クリア"
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event execution;call super::execution;
// フィルター解除

ddplb_status.selectitem ( "(未選択)", 0 )
ddplb_msg.selectitem ( "(未選択)", 0 )

of_filter_set()


return 0

end event

type dw_list from ivo_datawindow within wld_genka_baika
integer x = 32
integer y = 498
integer width = 4656
integer height = 1365
integer taborder = 40
boolean bringtotop = true
string dataobject = "dld_tanka"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
this.reset()
this.settransobject(cocos)


end event

type st_filename_t from ivo_statictext within wld_genka_baika
integer x = 32
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込ファイル"
alignment alignment = right!
end type

type st_filename from ivo_statictext within wld_genka_baika
integer x = 380
integer y = 1913
integer width = 1608
integer height = 82
boolean bringtotop = true
integer textsize = -12
string text = ""
boolean border = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_cnt_t from ivo_statictext within wld_genka_baika
integer x = 2008
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "読込件数"
alignment alignment = right!
end type

type st_cnt from ivo_statictext within wld_genka_baika
integer x = 2356
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_okcnt_t from ivo_statictext within wld_genka_baika
integer x = 2664
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "正常件数"
alignment alignment = right!
end type

type st_okcnt from ivo_statictext within wld_genka_baika
integer x = 3012
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 134217741
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_errcnt_t from ivo_statictext within wld_genka_baika
integer x = 3320
integer y = 1916
integer width = 408
boolean bringtotop = true
string text = "エラー件数"
alignment alignment = right!
end type

type st_errcnt from ivo_statictext within wld_genka_baika
integer x = 3748
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 255
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type st_warncnt_t from ivo_statictext within wld_genka_baika
integer x = 4056
integer y = 1916
integer width = 328
boolean bringtotop = true
string text = "警告件数"
alignment alignment = right!
end type

type st_warncnt from ivo_statictext within wld_genka_baika
integer x = 4404
integer y = 1913
integer width = 288
integer height = 82
boolean bringtotop = true
integer textsize = -12
long textcolor = 255
long backcolor = 134217752
string text = ""
alignment alignment = right!
boolean border = true
boolean righttoleft = true
end type

event constructor;call super::constructor;
this.enabled		= true
this.text			= ""


end event

type ddplb_status from ivo_dropdownpicturelistbox within wld_genka_baika
integer x = 460
integer y = 380
integer width = 428
integer height = 363
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","",""}
integer itempictureindex[] = {1,0,0,0}
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset()
this.enabled	= true
this.insertitem("(未選択)",upperbound(this.item) + 1)
this.selectitem("(未選択)",1)


end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type ddplb_msg from ivo_dropdownpicturelistbox within wld_genka_baika
integer x = 1336
integer y = 380
integer width = 2008
integer height = 363
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = true
string item[] = {"(未選択)","","","","","","",""}
integer itempictureindex[] = {1,0,0,0,0,0,0,0}
boolean f1_key = true
boolean f3_key = true
boolean f7_key = true
boolean f9_key = true
boolean f10_key = true
boolean f12_key = true
end type

event constructor;call super::constructor;
// 初期化
this.reset()
this.enabled	= true
this.insertitem("(未選択)",upperbound(this.item) + 1)
this.selectitem("(未選択)",1)


end event

event selectionchanged;call super::selectionchanged;
// フィルター実行
of_filter_set()

return 0

end event

type hpb_progres from ivo_hprogressbar within wld_genka_baika
integer x = 8
integer y = 334
integer height = 21
boolean bringtotop = true
unsignedinteger position = 0
boolean smoothscroll = true
end type

