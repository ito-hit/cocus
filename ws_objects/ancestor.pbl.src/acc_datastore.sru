$PBExportHeader$acc_datastore.sru
$PBExportComments$データストアの始祖オブジェクト
forward
global type acc_datastore from datastore
end type
end forward

global type acc_datastore from datastore
end type
global acc_datastore acc_datastore

type variables

end variables

forward prototypes
public subroutine of_set_document_name (string p_doc_name)
public subroutine of_set_printer (string p_printer)
public subroutine of_set_copies (integer p_copies)
public function integer of_get_copies ()
public function string of_get_document_name ()
public function string of_get_printer ()
end prototypes

public subroutine of_set_document_name (string p_doc_name);
this.object.datawindow.print.documentname	= p_doc_name
end subroutine

public subroutine of_set_printer (string p_printer);
this.object.datawindow.print.printername	= p_printer
end subroutine

public subroutine of_set_copies (integer p_copies);
this.object.datawindow.print.copies	= p_copies
end subroutine

public function integer of_get_copies ();
return this.object.datawindow.print.copies
end function

public function string of_get_document_name ();
string	l_doc_name

if len( trim( this.object.datawindow.print.documentname ) ) > 0 then
	l_doc_name	= this.object.datawindow.print.documentname
else
	setnull( l_doc_name )
end if

return l_doc_name
end function

public function string of_get_printer ();
string	l_printer

if len( trim( this.object.datawindow.print.printername ) ) > 0 then
	l_printer	= this.object.datawindow.print.printername
else
	setnull( l_printer )
end if

return l_printer
end function

on acc_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on acc_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

