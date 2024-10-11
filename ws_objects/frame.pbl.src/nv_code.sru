$PBExportHeader$nv_code.sru
$PBExportComments$グローバルな定数管理
forward
global type nv_code from inv_object
end type
end forward

global type nv_code from inv_object autoinstantiate
end type

type variables
constant string		CRLF				= "~r~n"				// 改行
constant string		LF					= "~n"					// ラインフィード
constant string		TAB					= "~t"					// タブ
constant string		DQUOTE				= "~""					// ダブルクォーテーション
constant string		SQUOTE				= "~'"					// シングルクォーテーション

constant integer	DEF_WIN_WIDTH		= 1280					// メインウインドウの初期横サイズ（ピクセル）
constant integer	DEF_WIN_HEIGHT		= 900					// メインウインドウの初期縦サイズ（ピクセル）
constant integer	DEF_MNU_WIDTH		= DEF_WIN_WIDTH			// メニューウインドウの初期横サイズ（ピクセル）
constant integer	DEF_MNU_HEIGHT		= 900					// メニューウインドウの初期縦サイズ（ピクセル）
constant integer	DEF_PRT_WIDTH		= DEF_WIN_WIDTH			// 印刷ウインドウの初期横サイズ（ピクセル）
constant integer	DEF_PRT_HEIGHT		= DEF_WIN_HEIGHT / 2	// 印刷ウインドウの初期縦サイズ（ピクセル）

constant integer	MSG_INFO			= 0						// 情報
constant integer	MSG_SUCCESS			= 1						// 成功
constant integer	MSG_WARNING			= 8						// 警告
constant integer	MSG_ERROR			= 9						// 失敗

constant integer	MGN_UPPER_TATE		= 21					// 呼び出し部の縦マージン
constant integer	MGN_UPPER_TATE_GAP	= 11					// 呼び出し部の１段目と２段目の間隔

constant integer	MGN_TATE			= 16					// 縦マージン（ベース枠同士のスペース）
constant integer	MGN_YOKO			= 32					// 横マージン（ベース枠同士のスペース）

constant integer	MGN_TATE_MIDDLE		= 32					// 縦マージン（広めのスペース）
constant integer	MGN_YOKO_MIDDLE		= 64					// 横マージン（広めのスペース）

constant integer	MGN_TATE_LARGE		= 64					// 縦マージン（超広めのスペース）
constant integer	MGN_YOKO_LARGE		= 96					// 横マージン（超広めのスペース）

constant integer	MGN_ITEM_TATE		= 16					// 項目ごとの縦マージン（次の入力枠(グループ)間のスペース）※太いコントロール(sle)基準で
constant integer	MGN_ITEM_YOKO		= 32					// 項目ごとの横マージン（次の入力枠(グループ)間のスペース）

constant integer	MGN_GROUP_TATE		= 8						// グループごとの縦マージン（タイトル枠と入力枠間のスペース）※太いコントロール(sle)基準で
constant integer	MGN_GROUP_YOKO		= 16					// グループごとの横マージン（タイトル枠と入力枠間のスペース）

constant integer	MGN_DW_ITEM_TATE	= 20					// 項目ごとの縦マージン（次の入力枠(グループ)間のスペース）※3D入力カラム基準で
constant integer	MGN_DW_ITEM_YOKO	= 40					// 項目ごとの横マージン（次の入力枠(グループ)間のスペース）

constant integer	MGN_DW_GROUP_TATE	= 10					// グループごとの縦マージン（タイトル枠と入力枠間のスペース）※3D入力カラム基準で
constant integer	MGN_DW_GROUP_YOKO	= 20					// グループごとの横マージン（タイトル枠と入力枠間のスペース）

constant integer	MGN_DW_UPPER_HEIGHT	= 32					// フリーフォームのDWの明細行上部のマージン（※3D入力カラム基準でマスタ管理系）
constant integer	MGN_DW_LOWER_HEIGHT	= 16					// フリーフォームのDWの明細行下段のマージン（※3D入力カラム基準でマスタ管理系）


end variables
on nv_code.create
call super::create
end on

on nv_code.destroy
call super::destroy
end on

