$PBExportHeader$sv_ddplb_meisyo_2.sru
$PBExportComments$名称マスタのドロップダウンリストボックスオブジェクト（ドロップダウンピクチャリストボックスは見た目重視で）~r~nリストボックスの作成をSQLでするパターン
forward
global type sv_ddplb_meisyo_2 from ivo_dropdownpicturelistbox
end type
end forward

global type sv_ddplb_meisyo_2 from ivo_dropdownpicturelistbox
integer width = 700
integer height = 356
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
end type
global sv_ddplb_meisyo_2 sv_ddplb_meisyo_2

type variables

protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible

	// 初期選択させておきたい名称コード
	string	init_code
	
	// 2024.10.07 H.Yamamoto Add Start リストに「未選択」追加
	// リストに「空欄」「すべて」追加
	boolean	enabled_null, enabled_none//, enabled_all
	// 2024.10.07 H.Yamamoto Add End

private:
	string	meisyo_code[], meisyo_mei[], dummy_str[]
	long	meisyo_code_num[], dummy_num[]
	
	// 2024.10.07 H.Yamamoto Add Start リストに「未選択」追加
	constant string	c_noselected_word	= "（未選択）"
	// 2024.10.07 H.Yamamoto Add End
	
//	constant string	c_all_word			= "全て"
end variables
forward prototypes
public function string of_get_meisyo ()
public function string of_get_code ()
public function long of_get_code_num ()
end prototypes

public function string of_get_meisyo ();return meisyo_mei[i_idx]
end function

public function string of_get_code ();return meisyo_code[i_idx]
end function

public function long of_get_code_num ();return meisyo_code_num[i_idx]
end function

on sv_ddplb_meisyo_2.create
call super::create
end on

on sv_ddplb_meisyo_2.destroy
call super::destroy
end on

event constructor;call super::constructor;
object_type	= "ddplb_meisyo_kbn"

datastore	l_ds
long		l_row,l_init_row,l_cnt
integer		l_code_visible

l_init_row	= 0

// 初期化
meisyo_code		= dummy_str
meisyo_mei		= dummy_str
meisyo_code_num	= dummy_num

this.reset()

l_ds			= create datastore
l_ds.dataobject	= "d_dddw_meisyo"

l_ds.settransobject( cocos )

if code_visible then
	l_code_visible	= 1
else
	l_code_visible	= 0
end if

if l_ds.retrieve( meisyo_kbn, meisyo_no, l_code_visible ) > 0 then
	l_row	= 1
	
	if enabled_null then
		// 「空欄」を表示
		/*
		setnull( meisyo_code[l_row] )
		setnull( meisyo_code_num[l_row]	)

		meisyo_mei[l_row]	= ""
		
		this.additem( meisyo_mei[l_row] )
		*/
//		l_ds.setfilter( "not ( meisyo_code is null and meisyo_mei = ' ' )" )
		l_ds.setfilter( "meisyo_mei <> '（未選択）' " )
		l_ds.filter()
	// 2024.10.07 H.Yamamoto Add Start リストに「未選択」追加
	elseif enabled_none then
		// 「（未選択）」を表示
		/*
		setnull( meisyo_code[l_row] )
		setnull( meisyo_code_num[l_row]	)

		meisyo_mei[l_row]	= c_noselected_word
		
		this.additem( meisyo_mei[l_row] )
		*/
		l_ds.setfilter( "not ( meisyo_code is null and meisyo_mei = '（未選択）' )" )
		l_ds.filter()
	// 2024.10.07 H.Yamamoto Add End
	
	/*
	elseif enabled_all then
		// 「すべて」を表示
		setnull( meisyo_code[l_row] )
		setnull( meisyo_code_num[l_row]	)

		meisyo_mei[l_row]		= c_all_word
		this.additem( meisyo_mei[l_row] )
	*/
	end if

	l_init_row	= this.totalitems()

	for l_row = 1 to l_ds.rowcount()
		l_cnt	= upperbound( meisyo_code ) + 1
		meisyo_code[l_cnt]			= l_ds.object.meisyo_code[l_row]
		meisyo_code_num[l_cnt]	= l_ds.object.meisyo_code_num[l_row]
		meisyo_mei[l_cnt]		= l_ds.object.meisyo_mei[l_row]

		// 初期選択のコードがセットされているなら初期表示する
		if meisyo_code[l_cnt] = init_code then
			l_init_row	= l_cnt
		end if
		
		this.additem( meisyo_mei[l_cnt] )
	next

	if l_init_row = 0 then
		l_init_row	= 1
	end if
	
	this.selectitem( l_init_row )
	
	i_idx	= l_init_row
	
	this.enabled	= true
else
	this.enabled	= false
end if

destroy l_ds

end event

