$PBExportHeader$nv_sendkey.sru
$PBExportComments$キー操作関数
forward
global type nv_sendkey from inv_object
end type
end forward

global type nv_sendkey from inv_object
end type
global nv_sendkey nv_sendkey

type prototypes
subroutine keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo ) library "user32.dll"

end prototypes

type variables

public:

protected:

private:
	constant integer	C_VK_ESC	= 27
	constant integer	C_VK_F1		= 112
	constant integer	C_VK_F2		= 113
	constant integer	C_VK_F3		= 114
	constant integer	C_VK_F4		= 115
	constant integer	C_VK_F5		= 116
	constant integer	C_VK_F6		= 117
	constant integer	C_VK_F7		= 118
	constant integer	C_VK_F8		= 119
	constant integer	C_VK_F9		= 120
	constant integer	C_VK_F10	= 121
	constant integer	C_VK_F11	= 122
	constant integer	C_VK_F12	= 123
	constant integer	C_VK_F13	= 124
	constant integer	C_VK_F14	= 125
	constant integer	C_VK_F15	= 126
	constant integer	C_VK_F16	= 127
	constant integer	C_VK_F17	= 128
	constant integer	C_VK_F18	= 129
	constant integer	C_VK_F19	= 130
	constant integer	C_VK_F20	= 131
	constant integer	C_VK_F21	= 132
	constant integer	C_VK_F22	= 133
	constant integer	C_VK_F23	= 134
	constant integer	C_VK_F24	= 135

end variables

forward prototypes
public subroutine of_send_f1 ()
public subroutine of_send_f2 ()
public subroutine of_send_f3 ()
public subroutine of_send_f4 ()
public subroutine of_send_f5 ()
public subroutine of_send_f6 ()
public subroutine of_send_f7 ()
public subroutine of_send_f8 ()
public subroutine of_send_f9 ()
public subroutine of_send_f10 ()
public subroutine of_send_f11 ()
public subroutine of_send_f12 ()
public subroutine of_send_f13 ()
public subroutine of_send_f14 ()
public subroutine of_send_f15 ()
public subroutine of_send_f16 ()
public subroutine of_send_f17 ()
public subroutine of_send_f18 ()
public subroutine of_send_f19 ()
public subroutine of_send_f20 ()
public subroutine of_send_f21 ()
public subroutine of_send_f22 ()
public subroutine of_send_f23 ()
public subroutine of_send_f24 ()
public subroutine of_send_esc ()
end prototypes

public subroutine of_send_f1 ();
// F1キー押下
keybd_event( C_VK_F1, 0, 0, 0 )
keybd_event( C_VK_F1, 0, 2, 0 )

end subroutine

public subroutine of_send_f2 ();
// F2キー押下
keybd_event( C_VK_F2, 0, 0, 0 )
keybd_event( C_VK_F2, 0, 2, 0 )

end subroutine

public subroutine of_send_f3 ();
// F3キー押下
keybd_event( C_VK_F3, 0, 0, 0 )
keybd_event( C_VK_F3, 0, 2, 0 )

end subroutine

public subroutine of_send_f4 ();
// F4キー押下
keybd_event( C_VK_F4, 0, 0, 0 )
keybd_event( C_VK_F4, 0, 2, 0 )

end subroutine

public subroutine of_send_f5 ();
// F5キー押下
keybd_event( C_VK_F5, 0, 0, 0 )
keybd_event( C_VK_F5, 0, 2, 0 )

end subroutine

public subroutine of_send_f6 ();
// F6キー押下
keybd_event( C_VK_F6, 0, 0, 0 )
keybd_event( C_VK_F6, 0, 2, 0 )

end subroutine

public subroutine of_send_f7 ();
// F7キー押下
keybd_event( C_VK_F7, 0, 0, 0 )
keybd_event( C_VK_F7, 0, 2, 0 )

end subroutine

public subroutine of_send_f8 ();
// F8キー押下
keybd_event( C_VK_F8, 0, 0, 0 )
keybd_event( C_VK_F8, 0, 2, 0 )

end subroutine

public subroutine of_send_f9 ();
// F9キー押下
keybd_event( C_VK_F9, 0, 0, 0 )
keybd_event( C_VK_F9, 0, 2, 0 )

end subroutine

public subroutine of_send_f10 ();
// F10キー押下
keybd_event( C_VK_F10, 0, 0, 0 )
keybd_event( C_VK_F10, 0, 2, 0 )

end subroutine

public subroutine of_send_f11 ();
// F11キー押下
keybd_event( C_VK_F11, 0, 0, 0 )
keybd_event( C_VK_F11, 0, 2, 0 )

end subroutine

public subroutine of_send_f12 ();
// F12キー押下
keybd_event( C_VK_F12, 0, 0, 0 )
keybd_event( C_VK_F12, 0, 2, 0 )

end subroutine

public subroutine of_send_f13 ();
// F13キー押下
keybd_event( C_VK_F13, 0, 0, 0 )
keybd_event( C_VK_F13, 0, 2, 0 )

end subroutine

public subroutine of_send_f14 ();
// F14キー押下
keybd_event( C_VK_F14, 0, 0, 0 )
keybd_event( C_VK_F14, 0, 2, 0 )

end subroutine

public subroutine of_send_f15 ();
// F15キー押下
keybd_event( C_VK_F15, 0, 0, 0 )
keybd_event( C_VK_F15, 0, 2, 0 )

end subroutine

public subroutine of_send_f16 ();
// F16キー押下
keybd_event( C_VK_F16, 0, 0, 0 )
keybd_event( C_VK_F16, 0, 2, 0 )

end subroutine

public subroutine of_send_f17 ();
// F17キー押下
keybd_event( C_VK_F17, 0, 0, 0 )
keybd_event( C_VK_F17, 0, 2, 0 )

end subroutine

public subroutine of_send_f18 ();
// F18キー押下
keybd_event( C_VK_F18, 0, 0, 0 )
keybd_event( C_VK_F18, 0, 2, 0 )

end subroutine

public subroutine of_send_f19 ();
// F19キー押下
keybd_event( C_VK_F19, 0, 0, 0 )
keybd_event( C_VK_F19, 0, 2, 0 )

end subroutine

public subroutine of_send_f20 ();
// F20キー押下
keybd_event( C_VK_F20, 0, 0, 0 )
keybd_event( C_VK_F20, 0, 2, 0 )

end subroutine

public subroutine of_send_f21 ();
// F21キー押下
keybd_event( C_VK_F21, 0, 0, 0 )
keybd_event( C_VK_F21, 0, 2, 0 )

end subroutine

public subroutine of_send_f22 ();
// F22キー押下
keybd_event( C_VK_F22, 0, 0, 0 )
keybd_event( C_VK_F22, 0, 2, 0 )

end subroutine

public subroutine of_send_f23 ();
// F23キー押下
keybd_event( C_VK_F23, 0, 0, 0 )
keybd_event( C_VK_F23, 0, 2, 0 )

end subroutine

public subroutine of_send_f24 ();
// F24キー押下
keybd_event( C_VK_F24, 0, 0, 0 )
keybd_event( C_VK_F24, 0, 2, 0 )

end subroutine

public subroutine of_send_esc ();
// ESCキー押下
keybd_event( C_VK_ESC, 0, 0, 0 )
keybd_event( C_VK_ESC, 0, 2, 0 )

end subroutine

on nv_sendkey.create
call super::create
end on

on nv_sendkey.destroy
call super::destroy
end on

