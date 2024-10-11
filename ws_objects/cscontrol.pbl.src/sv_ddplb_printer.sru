$PBExportHeader$sv_ddplb_printer.sru
$PBExportComments$プリンタのドロップダウンリストボックスオブジェクト（ドロップダウンピクチャリストボックスは見た目重視で）
forward
global type sv_ddplb_printer from ivo_dropdownpicturelistbox
end type
type lstr_printer from structure within sv_ddplb_printer
end type
end forward

type lstr_printer from structure
	string		printer_mei
	string		printer_mei_ryaku
	string		printer_syubetu
	string		addition_info
end type

global type sv_ddplb_printer from ivo_dropdownpicturelistbox
integer width = 1236
integer height = 619
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"登録","","",""}
integer itempictureindex[] = {1,0,0,0}
long picturemaskcolor = 16777215
end type
global sv_ddplb_printer sv_ddplb_printer

type variables
protected:
//	boolean ignore_master		// True：m_printerの登録に関係なくOSに登録されたプリンタを使用する

	boolean type_lbp	= true	// レーザープリンタ使用
	boolean type_imp			// インパクトプリンタ使用
	boolean type_llp			// ラベルプリンタ使用
	
private:
	lstr_printer i_list[]

	string	i_printer_type

	constant string	c_printer_lbp	= "LBP"	// m_printer検索用文字（レーザー）
	constant string	c_printer_imp	= "IMP"	// m_printer検索用文字（インパクト）
	constant string	c_printer_llp	= "LLP"	// m_printer検索用文字（ラベル）



end variables

forward prototypes
public function boolean of_available (string p_window)
private function boolean check_printer_type ()
private function boolean create_printer_list ()
private function any get_os_printers ()
private function string get_os_default_printer ()
public function string of_get_printer ()
public function string of_get_printer_ryaku ()
public function string of_get_syubetu ()
public function string of_get_addition_info ()
end prototypes

public function boolean of_available (string p_window);return true
end function

private function boolean check_printer_type ();//if ignore_master then
//	i_printer_type	= ""
//	return true
//end if

if type_lbp then
	i_printer_type	= c_printer_lbp
	return true
end if

if type_imp then
	i_printer_type	= c_printer_imp
	return true
end if

if type_llp then
	i_printer_type	= c_printer_llp
	return true
end if

return false

end function

private function boolean create_printer_list ();integer	l_row
string	l_printers[]

lstr_printer	l_prt, l_list[]


// リストを初期化
i_list		= l_list
this.reset()

l_printers	= get_os_printers()

//if not ignore_master then
//	// プリンタマスタに登録されているプリンタを基にOSのプリンタとマッチング
//	declare prt_cur cursor for
//		select printer_mei,printer_mei_ryaku,
//			   printer_syubetu,
//			   addition_info
//		  from m_printer
//		 where use_flg <> 0
//		   and printer_syubetu	= :i_printer_type
//		 order by printer_no
//	using cocos;
//
//	open prt_cur;
//	if cocos.sqlcode <> 0 then
//		return false
//	else
//		fetch prt_cur into :l_prt.printer_mei, :l_prt.printer_mei_ryaku, :l_prt.printer_syubetu, :l_prt.addition_info;
//		if cocos.sqlcode <> 0 then
//			return false
//		else
//			do until cocos.sqlcode <> 0
//				// OSのプリンタに同一名のプリンタが存在すればリストに追加
//				for l_row = 1 to upperbound( l_printers )
//					if l_prt.printer_mei = l_printers[l_row] then
//						this.additem( l_prt.printer_mei_ryaku )
//						i_list[upperbound(i_list)+1]	= l_prt
//						exit
//					end if
//				next
//				
//				fetch prt_cur into :l_prt.printer_mei, :l_prt.printer_mei_ryaku, :l_prt.printer_syubetu, :l_prt.addition_info;
//				choose case cocos.sqlcode
//					case 0,100
//					case else
//						msg.of_error_db( fnc.strg.of_format( "メニュー情報({1})の取得に失敗しました。", this.classname() ), cocos )
//				end choose
//			loop
//		end if
//	
//		close prt_cur;
//	end if
//else
	// OSのプリンタ名をそのままリストに追加
	for l_row = 1 to upperbound( l_printers )
		l_prt.printer_mei		= l_printers[l_row]
		l_prt.printer_mei_ryaku	= l_printers[l_row]

		this.additem( l_prt.printer_mei_ryaku )
		i_list[upperbound( i_list)+1]	= l_prt
	next
//end if

return true

end function

private function any get_os_printers ();string	l_printers[]

nv_registry	l_reg

// レジストリからOSで登録されているプリンタを配列に格納する
l_reg	= create nv_registry

l_printers	= l_reg.of_get_os_printers( )

destroy l_reg

return l_printers
end function

private function string get_os_default_printer ();string	l_printer

nv_registry	l_reg

// レジストリからOSで登録されているプリンタを配列に格納する
l_reg	= create nv_registry

l_printer	= l_reg.of_get_os_default_printer( )

destroy l_reg

return l_printer
end function

public function string of_get_printer ();return i_list[i_idx].printer_mei
end function

public function string of_get_printer_ryaku ();return i_list[i_idx].printer_mei_ryaku
end function

public function string of_get_syubetu ();return i_list[i_idx].printer_syubetu
end function

public function string of_get_addition_info ();return i_list[i_idx].addition_info
end function

on sv_ddplb_printer.create
call super::create
end on

on sv_ddplb_printer.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "ddplb_printer"

string	l_default_printer

// プリンタ種別が選択されていなければエラー
if not check_printer_type() then
	msg.of_error( "プリンタ種別が選択されていません。" )
	this.enabled	= false
	return -1
end if

// リスト作成
if not create_printer_list( ) then
	msg.of_error( "印刷可能なプリンタもしくはリスト生成でエラーが発生しました。" )
	this.enabled	= false
	return -1
end if

// マスタに登録されたものを表示する場合は登録通りに、OSプリンタそのまま出しなら通常使うプリンタに
//if not ignore_master then
//	// プリンタ初期選択
//	select printer_mei
//	  into :l_default_printer
//	  from m_printer_def
//	 where user_id			= :user.user_id
//	   and printer_syubetu	= :i_printer_type
//	using cocos;
	
//	if cocos.sqlcode <> 0 then
		// デフォルトプリンタが取得できない場合は、リストの先頭にとりあえずしておく。
		
//		i_idx	= 1
//		this.selectitem( i_idx )
//	else
//		i_idx	= this.selectitem( l_default_printer, 1 )
//	end if
//else
	l_default_printer	= get_os_default_printer( )

	// 通常使うプリンタが設定されていなければ1個目を表示
	if len( trim( l_default_printer ) ) > 0 then
		i_idx	= this.selectitem( l_default_printer, 1 )
	else
		i_idx	= 1
		this.selectitem( i_idx )
	end if
//end if

end event

