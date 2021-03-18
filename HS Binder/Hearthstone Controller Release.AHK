#SingleInstance force ; Replace an existing script
#NoEnv ; Don't check empty variables to see if they are environment variables
SetDefaultMouseSpeed, 0 ; Move mouse instantly

; Changes the tray icon's tooltip (displayed when mouse hovers over it)
Menu, tray, Tip, Hearthstone Hotkeys
; Show Tooltip in the tray that the script is active
TrayTip, SkyWeaver Controller [MOD] wip,,16


;	Reload script for testing
F8::Reload ; F8


; Makes subsequent hotkeys only function if specified window is active
#IfWinActive, SkyWeaver



;; HOTKEYS
; Edit the keys in front of the :: if you wish to modify hotkeys



; Pass the turn
MButton:: ; Middle mouse button
^Space:: ; Ctrl + Spacebar
^Enter:: ; Ctrl + Enter
PassTurn()
return

$+O::
OpenMenu()
return

; Concede the match
$+G:: ; Shift + G
GG()
return


;TEST FUNCTION ---- TEST FUNCTION ---- TEST FUNCTION
^2:: ;Ctrl + 2
GrabScreenRegion()
return

;; FUNCTIONS

; Convert relative positions of buttons on screen into absolute 
; pixels for AHK commands. Allows for different resolutions.
GAP(RatioX, RatioY) {
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
	return [AbsoluteX, AbsoluteY]
}

; Open (and wait for) the game menu
OpenMenu() {
	SendInput, {Esc} ; Bring up the menu
	Sleep, 200 ; Wait until it has popped up
}



; Presses the "END TURN" button on the right side, if possible
PassTurn() {
	BlockInput, On
	EndTurn := GetAbsolutePixels(0.845, 0.46)
	RestingPos := GetAbsolutePixels(0.5, 0.64)
	MouseMove, left EndTurn[1], EndTurn[2]
	Click,
	Sleep, 20
	MouseMove, RestingPos[1], RestingPos[2]
	BlockInput, Off
	return
}



; Bring up the menu and click the "Concede" button
GG() {
	BlockInput, On
	OpenMenu()
	Button := GetAbsolutePixels(0.5, 0.4)
	MouseClick, left, Button[1], Button[2]
	sleep, 240
	BlockInput, Off
}

