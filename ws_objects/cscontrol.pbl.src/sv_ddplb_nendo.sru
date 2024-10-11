$PBExportHeader$sv_ddplb_nendo.sru
$PBExportComments$入力フォーム 年度のドロップダウン
forward
global type sv_ddplb_nendo from ivo_userobject
end type
type st_meisyo_kimatu from sv_st_meisyo within sv_ddplb_nendo
end type
type st_meisyo_kisyo from sv_st_meisyo within sv_ddplb_nendo
end type
type st_aida from ivo_statictext within sv_ddplb_nendo
end type
type ddplb_nendo from ivo_dropdownpicturelistbox within sv_ddplb_nendo
end type
type st_title from ivo_statictext within sv_ddplb_nendo
end type
type r_back from rectangle within sv_ddplb_nendo
end type
end forward

global type sv_ddplb_nendo from ivo_userobject
integer width = 1792
integer height = 491
event type boolean input_check ( )
st_meisyo_kimatu st_meisyo_kimatu
st_meisyo_kisyo st_meisyo_kisyo
st_aida st_aida
ddplb_nendo ddplb_nendo
st_title st_title
r_back r_back
end type
global sv_ddplb_nendo sv_ddplb_nendo

type variables

// 2024.09.25 H.Yamamoto 修正
public:
//protected:
	// 2024.09.25 H.Yamamoto Upd Start インスタンス変数の追加と名称修正
//	integer	init_code						// 初期選択させておきたい年度コード
	integer	init_nendo_code	= 0				// 初期選択させておきたい年度コード
	
	// 今はいらない
//	integer	from_nendo_code	= 0				// リストに表示させたい年度コードの範囲 start
//	integer	to_nendo_code	= 999			// リストに表示させたい年度コードの範囲 end
	
//	boolean	meisyo_display_on				// チェックが入ったらkisyo,aida,kimatuを表示する
	boolean	meisyo_visible	= true			// True：kisyo,aida,kimatuを表示する
	// 2024.09.25 H.Yamamoto Upd End

	// リストに「空欄(未選択)」「すべて」追加
	boolean	enabled_null, enabled_all
	
	// 2024.09.25 H.Yamamoto Add Start インスタンス変数追加
	long	i_idx
	long	i_kisyo_date, i_kimatu_date		// 選択中の年度コードの期初年月日と期末年月日
	// 2024.09.25 H.Yamamoto Add End

// 2024.09.25 H.Yamamoto 修正
protected:
//private:
	integer	nendo_code[], dummy_num[]
	string	nendo_mei[], dummy_str[]

	constant string	c_all_word	= "全て"

end variables
forward prototypes
public function long of_get_kisyo_date ()
public function long of_get_kimatu_date ()
end prototypes

event type boolean input_check();
// selectionchangedイベントから呼ばれる 入力チェックのイベント
// エラーチェックの他に、個別処理を書くならこのイベント

return true
end event

public function long of_get_kisyo_date ();
return i_kisyo_date
end function

public function long of_get_kimatu_date ();
return i_kimatu_date
end function

on sv_ddplb_nendo.create
int iCurrent
call super::create
this.st_meisyo_kimatu=create st_meisyo_kimatu
this.st_meisyo_kisyo=create st_meisyo_kisyo
this.st_aida=create st_aida
this.ddplb_nendo=create ddplb_nendo
this.st_title=create st_title
this.r_back=create r_back
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_meisyo_kimatu
this.Control[iCurrent+2]=this.st_meisyo_kisyo
this.Control[iCurrent+3]=this.st_aida
this.Control[iCurrent+4]=this.ddplb_nendo
this.Control[iCurrent+5]=this.st_title
this.Control[iCurrent+6]=this.r_back
end on

on sv_ddplb_nendo.destroy
call super::destroy
destroy(this.st_meisyo_kimatu)
destroy(this.st_meisyo_kisyo)
destroy(this.st_aida)
destroy(this.ddplb_nendo)
destroy(this.st_title)
destroy(this.r_back)
end on

event constructor;call super::constructor;
object_type	= "sv_ddplb_nendo"

// 2024.09.25 H.Yamamoto Add Start 背景色(透明化)と初期化の処理を追加

// 背景色を透明にする
this.backcolor		= 536870912
r_back.fillcolor	= 536870912
r_back.linecolor	= 536870912
st_title.backcolor	= 536870912
st_aida.backcolor	= 536870912

// ドロップダウンの初期化
ddplb_nendo.event constructor()

// 2024.09.25 H.Yamamoto Add End
end event

event resize;call super::resize;
r_back.width	= this.width
ddplb_nendo.x	= st_title.x + st_title.width + code.MGN_GROUP_YOKO

// 2024.09.25 H.Yamamoto Upd Start インスタンス変数の名称変更と余白の修正

//if meisyo_display_on then	// meisyoを表示する
if meisyo_visible then	// meisyoを表示する

//	st_meisyo_kimatu.x	= this.width - st_meisyo_kimatu.width - 15
//	st_aida.x			= st_meisyo_kimatu.x - st_aida.width - 15
//	st_meisyo_kisyo.x	= st_aida.x - st_meisyo_kisyo.width -15
//	ddplb_nendo.width	= st_meisyo_kisyo.x - ddplb_nendo.x - 15

	st_meisyo_kimatu.x	= this.width - st_meisyo_kimatu.width - code.MGN_YOKO
	st_aida.x			= st_meisyo_kimatu.x - st_aida.width - code.MGN_GROUP_YOKO
	st_meisyo_kisyo.x	= st_aida.x - st_meisyo_kisyo.width -code.MGN_GROUP_YOKO
	ddplb_nendo.width	= st_meisyo_kisyo.x - ddplb_nendo.x - code.MGN_ITEM_YOKO
else
	st_meisyo_kimatu.visible	= false	// 表示を消す
	st_aida.visible				= false 
	st_meisyo_kisyo.visible		= false
	
//	ddplb_nendo.width			= this.width - ddplb_nendo.x - 15
	ddplb_nendo.width			= this.width - ddplb_nendo.x - code.MGN_YOKO
end if

// 2024.09.25 H.Yamamoto Upd End
end event

type st_meisyo_kimatu from sv_st_meisyo within sv_ddplb_nendo
integer x = 1504
integer y = 4
integer width = 252
string text = ""
end type

type st_meisyo_kisyo from sv_st_meisyo within sv_ddplb_nendo
integer x = 1148
integer y = 4
integer width = 252
string text = ""
end type

type st_aida from ivo_statictext within sv_ddplb_nendo
integer x = 1416
integer y = 4
integer width = 72
integer height = 82
long backcolor = 12632256
string text = "～"
alignment alignment = center!
end type

type ddplb_nendo from ivo_dropdownpicturelistbox within sv_ddplb_nendo
integer x = 332
integer width = 796
integer height = 452
integer taborder = 10
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
end type

event constructor;call super::constructor;
// 2024.09.25 H.Yamamoto ここでは不要のため、コメントアウト
//object_type	= "input_nendo_ddplb"

datastore	l_ds

// 2024.09.25 H.Yamamoto Add Start 基本情報マスターの情報取得とフィルターのため変数追加
//long		l_row,init_row,l_cnt
long		l_row, l_init_row, l_cnt
nv_master	mst
str_mkihon	l_kihon[]

string		l_filter

// 0だと後でなんらかの行番号をセットしないといけないので、初期値として1行目をセットしておく
//init_row	= 0
l_init_row	= 1
// 2024.09.25 H.Yamamoto Upd End

// 初期化
nendo_code	= dummy_num
nendo_mei	= dummy_str

ddplb_nendo.reset()

l_ds			= create datastore
l_ds.dataobject	= "d_dddw_nendo"

l_ds.settransobject( cocos )

if l_ds.retrieve( ) > 0 then
	// 配列の1行目として使うので、ここで初期化する
	l_row	= 1

	if enabled_null then
		// 「空欄(未選択)」を表示
		setnull( nendo_code[l_row] )

		nendo_mei[l_row]		= ""
		ddplb_nendo.additem( nendo_mei[l_row] )
	elseif enabled_all then
		// 「すべて」を表示
		setnull( nendo_code[l_row] )

		nendo_mei[l_row]		= c_all_word
		ddplb_nendo.additem( nendo_mei[l_row] )
	end if
	
	// 2024.09.25 H.Yamamoto Add Start 初期選択のコードがセットされていない時は、当期の事業年度を初期選択する(基本情報マスターより)
//	init_row	= ddplb_nendo.totalitems()
	if init_nendo_code = 0 then
		if mst.of_kihon_get( 0, l_kihon ) > 0 then
			init_nendo_code	= l_kihon[1].jigyo_nendo
		end if
	end if
	
	/* 今はいらない
	// 表示させたい年度コードが範囲に入っていなければ、年度コードは初期化
	if init_nendo_code < from_nendo_code or to_nendo_code < init_nendo_code then
		init_nendo_code	= 0
	end if
	
	// 表示期間のフィルターをかける
	l_filter	= string( from_nendo_code ) + " <= nendo_code and nendo_code <= " + string( to_nendo_code )
	
	l_ds.setfilter( l_filter )
	l_ds.filter()
	*/
	// 2024.09.25 H.Yamamoto Add End
	
	for l_row = 1 to l_ds.rowcount()
		l_cnt				= upperbound( nendo_code ) + 1

		nendo_code[l_cnt]	= l_ds.object.nendo_code[l_row]
		nendo_mei[l_cnt]	= l_ds.object.nendo_mei[l_row]
		
		// 初期選択のコードがセットされているなら初期表示する
		// 2024.09.25 H.Yamamoto Upd Start 変数名修正
//		if nendo_code[l_cnt] = init_code then
		if nendo_code[l_cnt] = init_nendo_code then
//			init_row	= l_cnt
			l_init_row	= l_cnt
		end if
		// 2024.09.25 H.Yamamoto Upd End
		
		ddplb_nendo.additem( nendo_mei[l_cnt] )
	next
	
	// ここでは不要のため、コメントアウト
//	if init_row = 0 then
//		init_row	= 1
//	end if
	
	// 2024.09.25 H.Yamamoto Upd Start 変数名修正
//	ddplb_nendo.selectitem( init_row )
	ddplb_nendo.selectitem( l_init_row )
	// 2024.09.25 H.Yamamoto Upd End
	
//	ddplb_nendo.enabled	= true
//else
//	ddplb_nendo.enabled	= false
end if

destroy l_ds

// 2024.09.25 H.Yamamoto Add Start 期初と期末の名称を表示させるためselectionchangedを呼び出し
this.event selectionchanged( l_init_row )
// 2024.09.25 H.Yamamoto Add End

end event

event selectionchanged;call super::selectionchanged;
// string	l_nendo_mei	// 2024.08.19 kin 名称を条件にするのはあまりよくないのでコードに変更
integer	l_nendo_code
long	l_kisyo_date, l_kimatu_date

//l_nendo_mei	= ddplb_nendo.text
l_nendo_code	= nendo_code[index]

// 「すべて」や「空欄（未選択）」が選択された場合は判定しない
if isnull( nendo_code[index] ) then
//	msg.of_info( c_all_word )
	return 0
end if

select kisyo_date, kimatu_date
  into :l_kisyo_date, :l_kimatu_date
  from m_nendo
 where nendo_code	= :l_nendo_code
 using cocos;
 
choose case cocos.sqlcode
	case 0
		st_meisyo_kisyo.text	= mid( fnc.db.of_date_format( string( l_kisyo_date ) ), 1, 7 )
		st_meisyo_kimatu.text	= mid( fnc.db.of_date_format( string( l_kimatu_date ) ), 1, 7 )
		
		// 2024.09.25 H.Yamamoto Add Start 期初年月日と期末年月日の取得を追加
		i_kisyo_date	= l_kisyo_date
		i_kimatu_date	= l_kimatu_date
		// 2024.09.25 H.Yamamoto Add End
	case 100
		msg.of_error( "マスタに存在しません。" )
		return -1
	case else
		msg.of_error( fnc.strg.of_format( "存在チェック中にエラーが発生しました{1}（{2}）", code.crlf, fnc.strg.of_replace( cocos.sqlerrtext, code.lf, " " ) ) )
		return -1
end choose

// 2024.09.25 H.Yamamoto Add Start input_checkイベントの呼び出しを追加
parent.i_idx	= index

if not parent.event input_check() then
	return -1
end if
// 2024.09.25 H.Yamamoto Add End

return 0
end event

type st_title from ivo_statictext within sv_ddplb_nendo
integer x = 12
integer y = 4
integer height = 82
long backcolor = 12632256
string text = "年度"
alignment alignment = right!
end type

type r_back from rectangle within sv_ddplb_nendo
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 12632256
integer width = 1800
integer height = 100
end type

