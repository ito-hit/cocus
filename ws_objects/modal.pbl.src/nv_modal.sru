$PBExportHeader$nv_modal.sru
$PBExportComments$Windowをコントロールするスクリプト
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
end type
global nv_modal nv_modal

type variables

datastore	i_ds_meisyo
end variables

forward prototypes
public function any of_open_modal (string p_modal, any p_str)
end prototypes

public function any of_open_modal (string p_modal, any p_str);integer	l_ret
window	l_win

choose case p_modal
	case "wsm_user"
		str_mdlpara_muser	l_user

		l_user	= p_str
		openwithparm( l_win, l_user, p_modal )

		// 選択せずに終了する場合はdoubleparmに-1が入る
		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_user	= message.powerobjectparm
		end if

		return l_user

	case "wsm_meisyo_parent"
		str_mdlpara_mmeisyo	l_meisyo_parent

		l_meisyo_parent	= p_str
		openwithparm( l_win, l_meisyo_parent, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_meisyo_parent	= message.powerobjectparm
		end if

		return l_meisyo_parent

	case "wsm_meisyo"
		str_mdlpara_mmeisyo	l_meisyo

		l_meisyo	= p_str
		openwithparm( l_win, l_meisyo, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_meisyo	= message.powerobjectparm
		end if

		return l_meisyo

	case "wsm_syohin"
		str_mdlpara_msyohin	l_syohin

		l_syohin	= p_str
		openwithparm( l_win, l_syohin, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_syohin	= message.powerobjectparm
		end if

		return l_syohin

	case "wsm_menu"
		str_mdlpara_mmenu	l_menu

		l_menu	= p_str
		openwithparm( l_win, l_menu, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_menu	= message.powerobjectparm
		end if

		return l_menu

	case "wsm_tab"
		str_mdlpara_mmenu	l_tab

		l_tab	= p_str
		openwithparm( l_win, l_tab, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_tab	= message.powerobjectparm
		end if

		return l_tab

	case "wsm_tokui"
		str_mdlpara_mtokui	l_tokui

		l_tokui	= p_str
		openwithparm( l_win, l_tokui, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_tokui	= message.powerobjectparm
		end if

		return l_tokui

	case "wsm_seikyu"
		str_mdlpara_mtokui	l_seikyu

		l_seikyu	= p_str
		openwithparm( l_win, l_seikyu, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_seikyu	= message.powerobjectparm
		end if

		return l_seikyu

	case "wsm_mise"
		str_mdlpara_mmise	l_mise

		l_mise	= p_str
		openwithparm( l_win, l_mise, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_mise	= message.powerobjectparm
		end if

		return l_mise
/*
	case "wsm_teisu"
		str_mdlpara_mteisu	l_teisu

		l_teisu	= p_str
		openwithparm( l_win, l_teisu, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_teisu	= message.powerobjectparm
		end if

		return l_teisu
*/
	case "wsm_window"
		str_mdlpara_mwindow	l_window

		l_window	= p_str
		openwithparm( l_win, l_window, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_window	= message.powerobjectparm
		end if

		return l_window

	case "wsm_nendo"
		str_mdlpara_mnendo	l_nendo

		l_nendo	= p_str
		openwithparm( l_win, l_nendo, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_nendo	= message.powerobjectparm
		end if

		return l_nendo

	case "wsm_kihon"
		str_mdlpara_mkihon	l_kihon

		l_kihon	= p_str
		openwithparm( l_win, l_kihon, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_kihon	= message.powerobjectparm
		end if

		return l_kihon

	case "wsm_kyoten"
		str_mdlpara_mkyoten	l_kyoten

		l_kyoten	= p_str
		openwithparm( l_win, l_kyoten, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_kyoten	= message.powerobjectparm
		end if

		return l_kyoten

	case "wsm_kyoten_group"
		str_mdlpara_mkyoten_group	l_kyoten_group

		l_kyoten_group	= p_str
		openwithparm( l_win, l_kyoten_group, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_kyoten_group	= message.powerobjectparm
		end if

		return l_kyoten_group

	case "wsm_tanto"
		str_mdlpara_mtanto	l_tanto

		l_tanto	= p_str
		openwithparm( l_win, l_tanto, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_tanto	= message.powerobjectparm
		end if

		return l_tanto

	case "wsm_yubin"
		str_mdlpara_myubin	l_yubin

		l_yubin	= p_str
		openwithparm( l_win, l_yubin, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_yubin	= message.powerobjectparm
		end if

		return l_yubin

	case "wsm_jyusyo"
		str_mdlpara_myubin	l_jyusyo

		l_jyusyo	= p_str
		openwithparm( l_win, l_jyusyo, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_jyusyo	= message.powerobjectparm
		end if

		return l_jyusyo

	case "wsm_unso"
		str_mdlpara_munso	l_unso

		l_unso	= p_str
		openwithparm( l_win, l_unso, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_unso	= message.powerobjectparm
		end if

		return l_unso

	case "wsm_untin_kijyun"
		str_mdlpara_muntin_kijyun	l_untin_kijyun

		l_untin_kijyun	= p_str
		openwithparm( l_win, l_untin_kijyun, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_untin_kijyun	= message.powerobjectparm
		end if

		return l_untin_kijyun

	case "wsm_kojyo"
		str_mdlpara_symkojyo	l_kojyo

		l_kojyo	= p_str
		openwithparm( l_win, l_kojyo, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_kojyo	= message.powerobjectparm
		end if

		return l_kojyo

	case "wsm_bukken"
		str_mdlpara_mbukken	l_bukken

		l_bukken	= p_str
		openwithparm( l_win, l_bukken, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_bukken	= message.powerobjectparm
		end if

		return l_bukken

	case "wsm_syohin_bunrui"
		str_mdlpara_mbunrui	l_bunrui

		l_bunrui	= p_str
		openwithparm( l_win, l_bunrui, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_bunrui	= message.powerobjectparm
		end if

		return l_bunrui

	case "wsm_brand"
		str_mdlpara_mbrand	l_brand

		l_brand	= p_str
		openwithparm( l_win, l_brand, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_brand	= message.powerobjectparm
		end if

		return l_brand

	case "wsm_syohin_group"
		str_mdlpara_mgroup	l_group

		l_group	= p_str
		openwithparm( l_win, l_group, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_group	= message.powerobjectparm
		end if

		return l_group

	case "wsm_jigyosya_code"
		str_mdlpara_mgtin_kanri	l_gtin_kanri

		l_gtin_kanri	=p_str
		openwithparm( l_win, l_gtin_kanri, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_gtin_kanri	= message.powerobjectparm
		end if

		return l_gtin_kanri

	case "wsm_tyakuten"
		str_mdlpara_mtyakuten	l_tyakuten

		l_tyakuten	= p_str
		openwithparm( l_win, l_tyakuten, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_tyakuten	= message.powerobjectparm
		end if

		return l_tyakuten

	case "wsm_niokurinin"
		str_mdlpara_mniokurinin	l_niokurinin

		l_niokurinin	= p_str
		openwithparm( l_win, l_niokurinin, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_niokurinin	= message.powerobjectparm
		end if

		return l_niokurinin

	case "wsm_kamoku"
		str_mdlpara_mkamoku	l_kamoku

		l_kamoku	= p_str
		openwithparm( l_win, l_kamoku, p_modal )

		l_ret	= message.doubleparm

		if l_ret = 0 then
			l_kamoku	= message.powerobjectparm
		end if

		return l_kamoku

	case else
end choose


end function

on nv_modal.create
call super::create
end on

on nv_modal.destroy
call super::destroy
end on

event constructor;call super::constructor;// datastoreのインスタンス化

// modal_meisyo
i_ds_meisyo				= create datastore
i_ds_meisyo.dataobject	= "d_modal_meisyo_datastore"
end event

event destructor;call super::destructor;// datastoreのdestory

// modal_meisyo
destroy( i_ds_meisyo )
end event

