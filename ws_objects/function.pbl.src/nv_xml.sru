$PBExportHeader$nv_xml.sru
$PBExportComments$XMLファイル操作関数
forward
global type nv_xml from inv_object
end type
end forward

global type nv_xml from inv_object
end type
global nv_xml nv_xml

type variables
pbdom_builder     pbdom_bldr
pbdom_document    pbdom_doc
pbdom_object      pbdom_obj_array[]

pbdom_builder     i_builder
pbdom_document    i_xmldoc

end variables

forward prototypes
public function boolean of_load (string p_file)
public function any of_split (string p_text, string p_mark)
public function any of_selectnodes (string p_nodes)
public function pbdom_element of_nodedown (pbdom_element p_element, string p_node)
public function boolean of_unload ()
public function boolean of_save (string p_file)
public function boolean of_setnodes (string p_nodes, any p_value)
public function string of_getnodestring (string p_node, string p_mark)
public function any of_getnodearray (string p_node)
public function boolean of_setnodearray (string p_node, any p_value)
public function boolean of_setnodestring (string p_node, string p_value)
public function string of_getnodestring (string p_node)
end prototypes

public function boolean of_load (string p_file);try
	i_builder	= create pbdom_builder
	i_xmldoc	= i_builder.buildfromfile(p_file)

	return true

	catch ( pbdom_exception pde )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_load", pde.getexceptioncode(), pde.text )
		return false
	catch ( nullobjecterror noe )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_load", noe.number, noe.text )
		return false
	catch ( pbxruntimeerror pre )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_load", pre.number, pre.text )
		return false
end try


end function

public function any of_split (string p_text, string p_mark);string	l_string[]
any		l_any
string	l_midstr

int	i,l_pos

i = 1

// 最初と最後に分割文字が存在する場合は削除 //
if pos( p_text, p_mark ) = 1 then
	p_text	= mid( p_text, len( p_mark ) + 1 )
end if
if right( p_text, len( p_mark ) ) = p_mark then
	p_text	= left( p_text, len( p_text ) - len( p_mark ) )
end if

setnull( l_pos )
do until	l_pos	= 0
	l_pos	= pos( p_text, p_mark )
	if l_pos <> 0 then
		l_midstr	= left( p_text, l_pos - 1 )
		p_text	= mid( p_text, l_pos + len( p_mark ) )
	else
		l_midstr	= p_text
	end if
	l_string[i]	= l_midstr
	i++
loop

l_any	= l_string

return l_any

end function

public function any of_selectnodes (string p_nodes);int					i,x
string				l_node_array[]
pbdom_element 		l_element
pbdom_element 		l_elements[]
string				l_element_value[]

try
	// 取得するノードを配列に //
	l_node_array	= of_split( p_nodes, "/" )
	
	// ルート要素を取得 //
	l_element		= i_xmldoc.getrootelement()
	
	// 最後の要素までは掘り下げない //
	for i=1 to upperbound( l_node_array ) - 1
		l_element	= of_nodedown( l_element, l_node_array[i] )
	next
	
	// 1レベル上の階層の要素をすべて取得 //
	l_element.getchildelements( l_elements )
		
	// 最後の要素に合致する情報のみ取得 //
	x = 1

	for i=1 to upperbound( l_elements )
		if l_node_array[upperbound( l_node_array )] = l_elements[i].getname() then
			l_element_value[x]	= l_elements[i].gettext()
			x++
		end if
	next
	
	return l_element_value


	catch ( pbdom_exception pde )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_selectnodes", pde.getexceptioncode(), pde.text )
		return false
	catch ( nullobjecterror noe )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_selectnodes", noe.number, noe.text )
		return false
	catch ( pbxruntimeerror pre )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_selectnodes", pre.number, pre.text )
		return false
end try

end function

public function pbdom_element of_nodedown (pbdom_element p_element, string p_node);int				i
pbdom_element	l_elements[]


// エレメント内の要素を取得 //
p_element.getchildelements( l_elements )

// 指定されたエレメント名を検索 //
for i=1 to upperbound( l_elements )
	if l_elements[i].getname() = p_node then
		return l_elements[i]
	end if
next

// 要素が存在しない場合、nullを返す //
setnull( p_element )

return p_element
end function

public function boolean of_unload ();try
	destroy i_builder
	
	return true

	catch ( pbdom_exception pde )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_unload", pde.getexceptioncode(), pde.text )
		return false
	catch ( nullobjecterror noe )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_unload", noe.number, noe.text )
		return false
	catch ( pbxruntimeerror pre )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_unload", pre.number, pre.text )
		return false
end try


end function

public function boolean of_save (string p_file);try
	if i_xmldoc.savedocument( p_file ) = false then
		return false
	end if

	return true

	catch ( pbdom_exception pde )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_save", pde.getexceptioncode(), pde.text )
		return false
	catch ( nullobjecterror noe )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_save", noe.number, noe.text )
		return false
	catch ( pbxruntimeerror pre )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_save", pre.number, pre.text )
		return false
end try


end function

public function boolean of_setnodes (string p_nodes, any p_value);int				i,x
string			l_node_array[]
pbdom_element	l_element
pbdom_element	l_elements[]
string			l_element_value[]

try
	// 格納する値を配列に格納 //
	l_element_value	= p_value
	
	// 取得するノードを配列に //
	l_node_array	= of_split( p_nodes, "/" )
	
	// ルート要素を取得 //
	l_element		= i_xmldoc.getrootelement()
	
	// 最後の要素までは掘り下げない //
	for i=1 to upperbound( l_node_array ) - 1
		l_element	= of_nodedown( l_element, l_node_array[i] )
	next
	
	// 1レベル上の階層の要素をすべて取得 //
	l_element.getchildelements( l_elements )
		
	// 最後の要素に合致する情報のみ取得 //
	x = 1
	
	for i=1 to upperbound( l_elements )
		if l_node_array[upperbound( l_node_array )] = l_elements[i].getname() then
			l_elements[i].settext( l_element_value[x] )
			x++
		end if
	next
	
	return true

	catch ( pbdom_exception pde )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_setnodes", pde.getexceptioncode(), pde.text )
		return false
	catch ( nullobjecterror noe )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_setnodes", noe.number, noe.text )
		return false
	catch ( pbxruntimeerror pre )
		txtlog.of_sys_alert( txtlog.TYPE_ERR, "of_setnodes", pre.number, pre.text )
		return false
end try

end function

public function string of_getnodestring (string p_node, string p_mark);// ノード配列をカンマ編集で返す //
string	l_element_value[]
string	l_return_value
int		i

l_element_value	= of_selectnodes( p_node )

// 取得したノード情報を指定された接続文字列で結合 //
if upperbound( l_element_value ) <> 0 then
	for i=1 to upperbound( l_element_value )
		if l_return_value <> "" then
			l_return_value	= l_return_value + p_mark
		end if
		l_return_value	= l_return_value + l_element_value[i]
	next
end if

return l_return_value
end function

public function any of_getnodearray (string p_node);// ノード配列を配列のままの状態で返す //
string	l_element_value[]

l_element_value	= of_selectnodes( p_node )

return l_element_value
end function

public function boolean of_setnodearray (string p_node, any p_value);return of_setnodes( p_node, p_value )

end function

public function boolean of_setnodestring (string p_node, string p_value);string	l_element_value[]

l_element_value[1]	= p_value

return of_setnodes( p_node, l_element_value )

end function

public function string of_getnodestring (string p_node);// ノード配列をカンマ編集で返す //
string	l_element_value[]
string	l_return_value
int		i

l_element_value	= of_selectnodes( p_node )

// 取得したノード情報を指定された接続文字列で結合 //
if upperbound( l_element_value ) <> 0 then
	for i=1 to upperbound( l_element_value )
		if l_return_value <> "" then
			l_return_value	= l_return_value
		end if
		l_return_value	= l_return_value + l_element_value[i]
	next
end if

return l_return_value
end function

on nv_xml.create
call super::create
end on

on nv_xml.destroy
call super::destroy
end on

