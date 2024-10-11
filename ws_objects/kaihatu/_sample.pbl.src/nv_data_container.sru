$PBExportHeader$nv_data_container.sru
$PBExportComments$モーダルのretrieveを受け持つノンビジュアルオブジェクト
forward
global type nv_data_container from inv_object
end type
end forward

global type nv_data_container from inv_object autoinstantiate
end type

type variables

private:
	datastore	i_ds_container	// datastoreをreturnしたいけどローカルに書くと、destroyするタイミングがない
end variables

forward prototypes
public function datastore of_get_data (string p_dwo, str_dpara p_dpara)
end prototypes

public function datastore of_get_data (string p_dwo, str_dpara p_dpara);// p_dwoとp_dpara.where_string[]を使ってretrieveし、結果をdatastoreでreturnする。

string	l_sqlsyntax
string	l_sql		// 最後にセットするsql
string	l_sqlselect, l_sqlwhere, l_sqlgroup, l_sqlorder
long	l_row

i_ds_container.reset()

i_ds_container.dataobject	= p_dwo
i_ds_container.settransobject( cocos )

// 現行のSQL文を取得し分解する
l_sqlsyntax	= i_ds_container.getsqlselect()

// SQL全文を分解する
if pos( l_sqlsyntax, "where") > 0 then
	// whereあり
	l_sqlselect	= mid( l_sqlsyntax, 1, pos( l_sqlsyntax, "where") - 2 )
	
	// group byがあるか確認する
	if pos( l_sqlsyntax, "group by") > 0 then
		l_sqlwhere	= mid( l_sqlsyntax, pos( l_sqlsyntax, "where"), pos( l_sqlsyntax, "group by" ) - pos( l_sqlsyntax, "where" ) - 2 )
		
		// order byがあるか確認する
		if pos( l_sqlsyntax, "order by") > 0 then
			l_sqlgroup	= mid( l_sqlsyntax, pos( l_sqlsyntax, "group by"), pos( l_sqlsyntax, "order by" ) - pos( l_sqlsyntax, "group by" ) - 2 )
			l_sqlorder	= mid( l_sqlsyntax, pos( l_sqlsyntax, "order by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "order by" ) + 1 )
		else
			l_sqlgroup	= mid( l_sqlsyntax, pos( l_sqlsyntax, "group by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "group by" ) + 1 )
		end if
	else
		// order byがあるか確認する
		if pos( l_sqlsyntax, "order by") > 0 then
			l_sqlwhere	= mid( l_sqlsyntax, pos( l_sqlsyntax, "where"), pos( l_sqlsyntax, "order by" ) - pos( l_sqlsyntax, "where" ) - 2 )
			l_sqlorder	= mid( l_sqlsyntax, pos( l_sqlsyntax, "order by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "order by" ) + 1 )
		else
			l_sqlwhere	= mid( l_sqlsyntax, pos( l_sqlsyntax, "where"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "where" ) + 1 )
		end if
	end if
elseif pos( l_sqlsyntax, "group by") > 0 then
	// whereはないが、group byはある
	l_sqlselect	= mid( l_sqlsyntax, 1, pos( l_sqlsyntax, "group by") - 3 )
	
	// order byがあるか確認する
	if pos( l_sqlsyntax, "order by") > 0 then
		l_sqlgroup	= mid( l_sqlsyntax, pos( l_sqlsyntax, "group by"), pos( l_sqlsyntax, "order by" ) - pos( l_sqlsyntax, "group by" ) - 2 )
		l_sqlorder	= mid( l_sqlsyntax, pos( l_sqlsyntax, "order by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "order by" ) + 1 )
	else
		l_sqlgroup	= mid( l_sqlsyntax, pos( l_sqlsyntax, "group by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "group by" ) +1 )
	end if
elseif pos( l_sqlsyntax, "order by") > 0 then
	// where・group byはないが、order byはある
	l_sqlselect	= mid( l_sqlsyntax, 1, pos( l_sqlsyntax, "order by") - 3 )
	l_sqlorder	= mid( l_sqlsyntax, pos( l_sqlsyntax, "order by"), len( l_sqlsyntax ) - pos( l_sqlsyntax, "order by" ) + 1 )
else
	// whereもorder byもない
	l_sqlselect	= l_sqlsyntax
end if

// p_dpara.where_stringからwhere句を作成
if upperbound( p_dpara.where_string ) > 0 then
	for l_row = 1 to upperbound( p_dpara.where_string )
		if l_sqlwhere <> "" then
			l_sqlwhere = l_sqlwhere + code.CRLF + "   and " + p_dpara.where_string[l_row]
		else
			l_sqlwhere = " where " + p_dpara.where_string[l_row]
		end if
	next
end if

// キレイに整形する小細工
l_sqlwhere	= fnc.of_decode( l_sqlwhere, "", "", code.CRLF + " " + l_sqlwhere )
l_sqlgroup	= fnc.of_decode( l_sqlgroup, "", "", code.CRLF + " " + l_sqlgroup )
l_sqlorder	= fnc.of_decode( l_sqlorder, "", "", code.CRLF + " " + l_sqlorder )

// SQLの作成
l_sql	= l_sqlselect + l_sqlwhere + l_sqlgroup + l_sqlorder

// SQLをセットしてretrieve
i_ds_container.setsqlselect( l_sql )
i_ds_container.retrieve()

return i_ds_container
end function

on nv_data_container.create
call super::create
end on

on nv_data_container.destroy
call super::destroy
end on

event constructor;call super::constructor;
i_ds_container	= create datastore
end event

event destructor;call super::destructor;
destroy( i_ds_container )
end event

