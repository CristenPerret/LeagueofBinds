#SingleInstance force ; Replace an existing script
#NoEnv ; Don't check empty variables to see if they are environment variables
SetDefaultMouseSpeed, 0 ; Move mouse instantly
; Changes the tray icon's tooltip (displayed when mouse hovers over it)
Menu, tray, Tip, LoR Hotkeys
; Show Tooltip in the tray that the script is active
TrayTip, LeagueofRuneterra Hotkeys, XBONE Controller WiP,,16


;	Reload script for testing
F8::Reload ; F8


; Makes subsequent hotkeys only function if specified window is active
#IfWinActive Legends of Runeterra ahk_class UnityWndClass 



;; HOTKEYS
; Edit the keys in front of the :: if you wish to modify hotkeys


; Emote "Wave"
F1:: ; F1 function key on top of the keyboard
;Numpad1:: ; 1 on Numpad
;NumpadEnd:: ; 1 on Numpad when Numlock is off
Emote(0.05, 0.3)
return

; Emote "Shocked"
F2::
;Numpad2::
;NumpadDown::
Emote(0.2, 0.3)
return

; Emote "Facepalm"
F3::
;Numpad3::
;NumpadPgDn::
Emote(0.05, 0.55)
return

; Emote "Qikmaffs"
F4::
;Numpad4::
;NumpadLeft::
Emote(0.2, 0.55)
return

; Emote "Sad"
F5::
;Numpad5::
;NumpadClear::
Emote(0.05, 0.78)
return


; Emote "Threaten"
F6::
;Numpad6::
;NumpadRight::
Emote(0.2, 0.78)
return



; Emote Locations notations
;Emote(0.05, 0.3) ;"Wave"
;Emote(0.2, 0.3) ; "Shocked"
;Emote(0.05, 0.55) ; "Facepalm"
;Emote(0.2, 0.55) ; "Qikmaffs"
;Emote(0.05, 0.78) ; "Sad"
;Emote(0.2, 0.78) ; "Threaten"
;STARTEmote(0.18, 0.95) ; START

; Pass the turn
;MButton:: ; Middle mouse button
^Space:: ; Ctrl + Spacebar
^Enter:: ; Ctrl + Enter
PassTurn()
return

$^M::
PlayCard()
return

$-:: ; See what happens after the stack
Foresight()
return

; Concede the match
$+Escape up:: ; Shift + G
GG()
return

$^Q::
Requeuer() 
return

;; FUNCTIONS

; Convert relative positions of buttons on screen into absolute 
; pixels for AHK commands. Allows for different resolutions.

GAP(RatioX, RatioY) { ; GetAbsolutePixels
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
	Return [AbsoluteX, AbsoluteY]
} 
RandomSleep(Between1, Between2) {
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}

ClickAction() {
	send, {lbutton down}
	RandomSleep(20,40)
	send, {lbutton up}
}


; Open (and wait for) the game menu
OpenMenu() {
	SendInput, {Esc} ; Bring up the menu
	RandomSleep(200,420)
}



; Emote takes relative position of emote to click
Emote(EmoteX, EmoteY) {
	BlockInput, On
	; if not in battle, don't click around
	BtnEmoteAct := GAP(0.18, 0.95)
	Emote := GAP(EmoteX, EmoteY)
	MouseGetPos, MouseX, MouseY
	MouseClick, left, BtnEmoteAct[1], BtnEmoteAct[2]
	Sleep, 120 ; Wait until bubbles have popped up
	RandomSleep(240,420)
	MouseMove, Emote[1], Emote[2]
	RandomSleep(20,40)
	ClickAction()
	;MouseMove, MouseX, MouseY
	RandomSleep(240,420)
	BlockInput, Off
}

PlayCard() {
centerboard := GAP(0.50, 0.54)
	BlockInput, On
	MouseGetPos grabx, graby
	MouseMove, centerboard[1], centerboard[2]
	RandomSleep(20,40)
	ClickAction()
	MouseMove, grabx, graby
	BlockInput, Off
}

; Presses the "END TURN" button on the right side, if possible
PassTurn() {
	BlockInput, On
	EndTurn := GAP(0.845, 0.46)
	RestingPos := GAP(0.23,0.90)
	MouseMove, left EndTurn[1], EndTurn[2]
	Click,
	RandomSleep(20,40)
	MouseMove, RestingPos[1], RestingPos[2]
	BlockInput, Off
	return
}

; Sees what will happen after chains clear
Foresight() {
	BlockInput, On
	MouseGetPos, mx, my
	eye := GAP(0.16,0.5)
	MouseMove, eye[1], eye[2]
	Sleep, 3100
	MouseMove, mx, my
	BlockInput, Off
	return
}

; Bring up the menu and click the "Concede" button
GG() {
	BlockInput, On
	OpenMenu()
	SBtn := GAP(0.46, 0.89)
	Conf := GAP(0.57, 0.56)
	idlepos := GAP(0.65, 0.87)
	MouseClick, left, SBtn[1], SBtn[2]
	RandomSleep(120,140)
	MouseClick, left, Conf[1], Conf[2]
	RandomSleep(120,140)
	MouseMove, idlepos[1], idlepos[2]
	BlockInput, Off
}

Requeuer() {
YelloscanL := GAP(0.68, 0.85)
YelloscanR := GAP(0.83, 0.86)
PixelSearch, FoundX, FoundY, YelloscanL[1], YelloscanL[2], YelloscanR[1], YelloscanR[2], 0xF5C850, 36, Fast RGB
if !Errorlevel 
{
mousemove, FoundX, FoundY
RandomSleep(20,40)
Click
return
}
MouseGetPos, grabx, graby
MouseMove, YelloscanR[1], YelloscanR[2]
RandomSleep(20,40)
click,
MouseMove, grabx, graby
return
}
