#include-once
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ChTer\MainCT.au3>


;GUICreate("",500,500,-1,-1, BitOR($WS_MAXIMIZEBOX,$WS_SYSMENU,$WS_POPUP,$WS_TABSTOP))
;GUISetState(@SW_SHOW)

While GUIGetMsg() <>  $GUI_EVENT_CLOSE
WEnd