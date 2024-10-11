$PBExportHeader$sv_ddplb_meisyo.sru
$PBExportComments$名称マスタのドロップダウンリストボックスオブジェクト（ドロップダウンピクチャリストボックスは見た目重視で）
forward
global type sv_ddplb_meisyo from ivo_dropdownpicturelistbox
end type
end forward

global type sv_ddplb_meisyo from ivo_dropdownpicturelistbox
integer width = 700
integer height = 356
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
end type
global sv_ddplb_meisyo sv_ddplb_meisyo

type variables
protected:
	integer	meisyo_kbn		// 指定する名称区分
	integer	meisyo_no		// 表示したい名称名１～３（名称区分＝０の場合は名称区分名を表示）

	// True:名称にコードも含めて表示 False:名称のみ表示
	boolean	code_visible

	// 初期選択させておきたい名称コード
	string	init_code

	// リストに「空欄(未選択)」「すべて」追加
	boolean	enabled_null, enabled_all

private:
	string	meisyo_code[], meisyo_mei[], dummy_str[]
	long	meisyo_code_num[], dummy_num[]

	constant string	c_all_word	= "全て"


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

on sv_ddplb_meisyo.create
call super::create
end on

on sv_ddplb_meisyo.destroy
call super::destroy
end on

event constructor;call super::constructor;object_type	= "ddplb_meisyo_kbn"

datastore	l_ds
long		l_row,init_row,l_cnt
integer		l_code_visible

init_row	= 0

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
		// 「空欄(未選択)」を表示
		setnull( meisyo_code[l_row] )
		setnull( meisyo_code_num[l_row]	)

		meisyo_mei[l_row]	= ""

		this.additem( meisyo_mei[l_row] )
	elseif enabled_all then
		// 「すべて」を表示
		setnull( meisyo_code[l_row] )
		setnull( meisyo_code_num[l_row]	)

		meisyo_mei[l_row]		= c_all_word
		this.additem( meisyo_mei[l_row] )
	end if

	init_row	= this.totalitems()

	for l_row = 1 to l_ds.rowcount()
		l_cnt	= upperbound( meisyo_code ) + 1
		meisyo_code[l_cnt]			= l_ds.object.meisyo_code[l_row]
		meisyo_code_num[l_cnt]	= l_ds.object.meisyo_code_num[l_row]
		meisyo_mei[l_cnt]		= l_ds.object.meisyo_mei[l_row]

		// 初期選択のコードがセットされているなら初期表示する
		if meisyo_code[l_cnt] = init_code then
			init_row	= l_cnt
		end if

		this.additem( meisyo_mei[l_cnt] )
	next

	if init_row = 0 then
		init_row	= 1
	end if
	
	this.selectitem( init_row )
	
	i_idx	= init_row
	
	this.enabled	= true
else
	this.enabled	= false
end if

destroy l_ds

end event

