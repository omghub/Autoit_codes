#include <ColorConstants.au3>
#include <GUIConstantsEX.au3>
#include <FontConstants.au3>
#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <MsgBoxConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <TreeViewConstants.au3>
#include <WinAPISysWin.au3>

;Hàm dùng để thoát chương trình khi người dùng ấn F5
HotKeySet("{F5}","EX")
Func EX()
	Exit
EndFunc

;Tạo Form chứ các item
Func Create_Menu()
	Global $G_Menu = GUICreate("",100,100,100,100,BitOR($WS_MAXIMIZE,$WS_MAXIMIZEBOX,$WS_SYSMENU,$WS_POPUP,$WS_TABSTOP),$WS_EX_LAYERED)
	;Sét màu Background thành 50% Gray
	GUISetBkColor(0x808080)
	;Hiển thị form
	GUISetState(@SW_SHOW)
	;Xóa màu 50% Gray của Background (Bắt buộc phải có thuộc tính $WS_EX_LAYERED ở câu lệnh tạo Form
	;Và phải khai báo thư viện WinAPISysWin.au3
	;Tùy trường hợp màu mà set 0 hay 255
	_WinAPI_SetLayeredWindowAttributes($G_Menu, 0x808080, 255)
EndFunc

;Hàm tạo list item
Func Create_Select($Cout_Select,$X,$Y,$W,$H)
	Global $Select_ID[$Cout_Select]
	$i=0
	While $i<$Cout_Select
		$Select_ID[$i] = GUICtrlCreateLabel($i,$X,$Y,$W,$H)
		$X+=$W
		$Y+=$H
		GUICtrlSetBkColor($Select_ID[$i],0x414141)
		$i+=1
	WEnd
EndFunc

Func Set_Color()
			;Kiểm tra xem màu của ô đầu tiên có phải là màu hồng hay không
			;Nếu đúng thì kiểm tra tiếp xem con trỏ có phải đang nằm tại vị trí này hay không
			;Nếu không thì đổi thành màu xám ban đầu
			$Scan_CL=PixelSearch(100,100,130,130,0xff00ff)
			If Not @error Then
				Select
					Case $Scan_CL[0] >= 100 And $Scan_CL[0] <= 130 and _
							$Scan_CL[1] >= 100 And $Scan_CL[1] <= 130
								Select
									Case MouseGetPos()[0]<100 Or MouseGetPos()[0]>130 Or MouseGetPos()[1]<100 Or MouseGetPos()[1]>130
										GUICtrlSetBkColor($Select_ID[0],0x414141)
								EndSelect
				EndSelect
			EndIf

			;Kiểm tra xem con trỏ có nằm tại vị trí của cô cần cheast không
			;Nếu có thì kiểm tra xem màu tại vị trí mà con trỏ chỉ vào có phải là màu xám mặt định không
			;Nếu phải thì đổi màu của ô tại vị trí đó thành màu hồng
			Select
				Case MouseGetPos()[0]>100 And MouseGetPos()[0]<130 And MouseGetPos()[1]>100 And MouseGetPos()[1]<130
						If PixelGetColor(MouseGetPos()[0],MouseGetPos()[1]) <> 0xff00ff Then GUICtrlSetBkColor($Select_ID[0],0xff00ff)
			EndSelect
EndFunc

Create_Menu()
Create_Select(4,100,100,30,30)

While True
	;Hiển thị tooltip báo vị trí con trỏ trên màng hình
	ToolTip(MouseGetPos()[0]&":"&MouseGetPos()[1],0,0)

	Switch GUIGetMsg($GUI_EVENT_ARRAY)[0]
		;Thoát chương trình khi nhấm close hoặc phím ESC
		Case $GUI_EVENT_CLOSE
			Exit
		; Khi không tương tác thì thược hiện các lệnh thay đổi hiển thị trong Form
		Case $GUI_EVENT_NONE
			Set_Color()
		Case $Select_ID[0]
	EndSwitch
WEnd