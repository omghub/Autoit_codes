#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <color.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <WinAPISysWin.au3>
ChTer1()
Global $Move = False
Global $ForP[5]
	$ForP = LoadData(FileRead("ForP.xyz"))
Func ChTer1()
; <Var>
	Global $BK = 808080
	Local $Label1BkCL[3] = [255,128,128]
	Global $img1 = "img\003.png"
; </Var>

Global $GUI = GUICreate("",@DesktopWidth,@DesktopHeight,0,0, -1,$WS_EX_LAYERED)
	GUISetBkColor($BK)
	_WinAPI_SetLayeredWindowAttributes($GUI, $BK)
GUISetState(@SW_SHOW)
GUISetStyle($WS_POPUP, -1, $GUI)
EndFunc
$pic1 = CreatePicPNG($ForP[0], $GUI, $ForP[1], $ForP[2], $ForP[3], $ForP[4])
;DeletePicPNG($pic1)
;SetPicPNG($pic1, $img1, 700, 400, 500, 500)

; Keep Gui running
While GUIGetMsg() <> $GUI_EVENT_CLOSE
	SeeCmdK(FileRead("Command.Kcmd"))
	;If $Move Then
WEnd

Func CreatePicPNG($link, $GUI, $x, $y, $w, $h)
; Load img PNG
	_GDIPlus_Startup()
	$img = _GDIPlus_ImageLoadFromFile($link)
; Draw PNG img
	$Graphic = _GDIPlus_GraphicsCreateFromHWND($GUI)
	_GDIPlus_GraphicsDrawImageRect($Graphic, $img, $x, $y, $w, $h)

	Return $Graphic
EndFunc
Func DeletePicPNG($item)
	_GDIPlus_GraphicsClear($item, 0xFF000000+$BK)
	ReCommand()
EndFunc
Func SetPicPNG($ID, $Link, $x, $y, $w, $h)
	ReCommand()
	DeletePicPNG($ID)
	$img = _GDIPlus_ImageLoadFromFile($Link)
	_GDIPlus_GraphicsDrawImageRect($ID, $img, $x, $y, $w, $h)
EndFunc
Func ReCommand()
	FileWrite(FileOpen("Command.Kcmd",2),"")
	FileClose("Command.Kcmd")
EndFunc
Func LoadData($Data)
	Global $OutData[5] = ['','','','','']
	$OutData[0] = StringMid($Data,StringInStr($Data,'Link"')+5,StringInStr($Data,'X"')-6)
	$OutData[1] = StringMid($Data,StringInStr($Data,'X"')+2,StringInStr($Data,'Y"')-(StringInStr($Data,'X"')+2))
	$OutData[2] = StringMid($Data,StringInStr($Data,'Y"')+2,StringInStr($Data,'W"')-(StringInStr($Data,'Y"')+2))
	$OutData[3] = StringMid($Data,StringInStr($Data,'W"')+2,StringInStr($Data,'H"')-(StringInStr($Data,'W"')+2))
	$OutData[4] = StringMid($Data,StringInStr($Data,'H"')+2,StringLen($Data))

	;MsgBox(0,0,"Link:"&$OutData[0]&@CRLF& _
	;			"X:"&$OutData[1]&@CRLF& _
	;			"Y:"&$OutData[2]&@CRLF& _
	;			"W:"&$OutData[3]&@CRLF& _
	;			"H:"&$OutData[4])
	Return $OutData
EndFunc
Func MovePicPNG($ID, $x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)

EndFunc
Func SeeCmdK($cmd)
	Switch $cmd
		Case "/DelP"
			DeletePicPNG($pic1)
		Case "/Info"
			ReCommand()
			MsgBox(0,0,"None")
		Case "/Exit"
			ReCommand()
			Exit
	EndSwitch
	If StringLeft($cmd, 5) = "/Move" Then $Move = True
EndFunc


#cs The commands test
	If WinActive($GUI) Then
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
	EndIf
	If WinActive($GUI) Then
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
		_WinAPI_SetWindowPos ( $GUI, $HWND_BOTTOM, 0, 0, 0, 0,BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
	EndIf
#ce

#cs List Command
	/DelP = Delete Pic
	/SetP = Setting Pic
#ce