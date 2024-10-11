$PBExportHeader$uo_p_db_sql_server.sru
forward
global type uo_p_db_sql_server from uo_p_base
end type
end forward

global type uo_p_db_sql_server from uo_p_base
integer width = 128
integer height = 114
string picturename = "image\loadsave\db_sql_server.png"
end type
global uo_p_db_sql_server uo_p_db_sql_server

on uo_p_db_sql_server.create
call super::create
end on

on uo_p_db_sql_server.destroy
call super::destroy
end on

