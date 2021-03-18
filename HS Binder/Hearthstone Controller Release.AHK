#SingleInstance force ; Replace an existing script
#NoEnv ; Don't check empty variables to see if they are environment variables
SetDefaultMouseSpeed, 0 ; Move mouse instantly

; Changes the tray icon's tooltip (displayed when mouse hovers over it)
Menu, tray, Tip, Hearthstone Hotkeys
; Show Tooltip in the tray that the script is active
TrayTip, Hearthstone Hotkeys, XBONE Controller WiP,,16

; run "X:\Software\Applications\win32\Hearthstone Deck Tracker\Deck Tracker\Hearthstone Deck Tracker.exe"

;	Reload script for testing
F8::Reload ; F8


; Makes subsequent hotkeys only function if specified window is active
#IfWinActive Hearthstone ahk_class UnityWndClass 



;; HOTKEYS
; Edit the keys in front of the :: if you wish to modify hotkeys

; Pass the turn
MButton:: ; Middle mouse button
^Space:: ; Ctrl + Spacebar
^Enter:: ; Ctrl + Enter
PassTurn()
return

; Target enemy hero
; ^LButton:: ; Ctrl + Left mouse button
^3:: ; Ctrl + 3
TargetEnemyHero(false)
return

;Smorc
^4::
AttackFaceWithAllMinions()
Return



; Emote "Greetings"
F1:: ; F1 function key on top of the keyboard
Numpad1:: ; 1 on Numpad
NumpadEnd:: ; 1 on Numpad when Numlock is off
Emote(0.42, 0.80)
return

; Emote "Well Played"
F2::
Numpad2::
NumpadDown::
Emote(0.42, 0.72)
return

; Emote "Thanks"
F3::
Numpad3::
NumpadPgDn::
Emote(0.42, 0.64)
return

; Emote "Sorry"
F4::
Numpad4::
NumpadLeft::
Emote(0.58, 0.64)
return

; Emote "Oops"
F5::
Numpad5::
NumpadClear::
Emote(0.58, 0.72)
return

; Emote "Threaten"
F6::
Numpad6::
NumpadRight::
Emote(0.58, 0.80)
return

; Emote Locations notations
;Emote(0.42, 0.80) ;"Greetings"
;Emote(0.42, 0.72) ; "Well Played"
;Emote(0.42, 0.64) ; "Thanks"
;Emote(0.58, 0.64) ; "Sorry"
;Emote(0.58, 0.72) ; "Oops"
;Emote(0.58, 0.80) ; "Threaten"



; Concede the match
$+G:: ; Ctrl + Escape
Concede()
return




;TEST FUNCTION ---- TEST FUNCTION ---- TEST FUNCTION
^2:: ;Ctrl + 2
;Smorc2(true)
TestFunct()
return

;; FUNCTIONS

; Convert relative positions of buttons on screen into absolute 
; pixels for AHK commands. Allows for different resolutions.
GetAbsolutePixels(RatioX, RatioY) {
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

; Bring up the menu and click the "Concede" button
Concede() {
	Surrender := GetAbsolutePixels(0.5, 0.35)
	QueBtn := GetAbsolutePixels(0.725, 0.75)
	BlockInput, On
	OpenMenu()
	MouseClick, left, Surrender[1], Surrender[2]
	Sleep, 20
	MouseMove, QueBtn[1], QueBtn[2]
	BlockInput, Off
}


; Emote takes relative position of emote to click
Emote(EmoteX, EmoteY) {
	BlockInput, On
	; if not in battle, don't click around
	Avatar := GetAbsolutePixels(0.5, 0.775)
	Emote := GetAbsolutePixels(EmoteX, EmoteY)
	MouseGetPos, MouseX, MouseY
	MouseClick, right, Avatar[1], Avatar[2]
	Sleep, 120 ; Wait until bubbles have popped up
	MouseMove, Emote[1], Emote[2]
	Sleep, 100
	Click,
	;MouseMove, MouseX, MouseY
	sleep,  240
	BlockInput, Off
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

; Drags from current mouse location to enemy hero
TargetEnemyHero(returnToOriginalPos=true) {
	BlockInput, On
	Hero := GetAbsolutePixels(0.5, 0.211)
	Click down
	Sleep, 10
	Click down
	MouseMove, Hero[1], Hero[2], 5
	
	Click up left
	Click, left
	; MouseClickDrag, L,,, HeroX, HeroY, 5 ; unreliable
	if (returnToOriginalPos) {
		MouseMove, %MouseX%, %MouseY%
	}
	BlockInput, Off
	return
}


AttackFaceWithAllMinions() {
	BlockInput, On
	MouseGetPos, MouseX, MouseY
	TopLeft := GetAbsolutePixels(0.22, 0.475)
	BottomRight := GetAbsolutePixels(0.75, 0.475)
	HeroSmorc := GetAbsolutePixels(0.458, 0.77)
	; Have to position the mouse so that minions aren't hovered over, changing the color of their active aura
	RestingPos := GetAbsolutePixels(0.5, 0.64)
	MouseMove, RestingPos[1], RestingPos[2]
	PixelSearch, FoundX, FoundY, TopLeft[1], TopLeft[2], BottomRight[1], BottomRight[2]+1, 0x6EFF43, 10, Fast RGB
	PixelSearch WeapX, WeapY, HeroSmorc[1], HeroSmorc[2], HeroSmorc[1], HeroSmorc[2]+1, 0xFFFFFF, 80, Fast RGB	
	while FoundX {
		MouseMove, FoundX+20, FoundY+30
		TargetEnemyHero(false)
		Sleep, 1550
		MouseMove, RestingPos[1], RestingPos[2]
		PixelSearch, FoundX, FoundY, TopLeft[1], TopLeft[2], BottomRight[1], BottomRight[2]+1, 0x00FF00, 80, Fast RGB
	}
	if WeapX {
	sleep, 200
	MouseMove, WeapX+40, WeapY+10
	TargetEnemyHero(false)
	Sleep, 500
	MouseMove, RestingPos[1], RestingPos[2]
}	
	MouseMove, MouseX, MouseY
	BlockInput, Off
}




Smorc2(EndTurnAfterwards=false) {
    BlockInput, On
    MouseGetPos, MouseX, MouseY
    TopLeft := GetAbsolutePixels(0.1, 0.57)
    BottomRight := GetAbsolutePixels(0.9, 0.57)
    ; Have to position the mouse so that minions aren't hovered over, changing the color of their active aura
    RestingPos := GetAbsolutePixels(0.5, 0.65)
    MouseMove, RestingPos[1], RestingPos[2]
    PixelSearch, FoundX, FoundY, TopLeft[1], TopLeft[2], BottomRight[1], BottomRight[2]+1, 0x6EFF43, 30, Fast RGB
    attacked := FoundX

    ; Store a BoundFunc for the function we want to call after the timer ends
    ; Bind the parameters it will need to it
    global AfterFoundFn := Func("AfterFound").Bind(attacked, EndTurnAfterwards)
    ; Store a BoundFunc for the check function, so it can use it to kill itself
    global CheckFoundFn := Func("CheckFound").Bind(FoundX, FoundY)
    SetTimer, % CheckFoundFn, 100
}

CheckFound(FoundX, FoundY){
    global CheckFoundFn, AfterFoundFn
    MouseMove, FoundX+20, FoundY
    TargetEnemyHero(false)
    Sleep, 500
    MouseMove, RestingPos[1], RestingPos[2]
    PixelSearch, FoundX, FoundY, TopLeft[1], TopLeft[2], BottomRight[1], BottomRight[2]+1, 0x00FF00, 80, Fast RGB
    if (!FoundX){
        SetTimer, % CheckFoundFn, Off ; Turn off the timer calling this function
        CheckFoundFn := "" ; Clear the reference
        AfterFoundFn.Call() ; Call the boundfunc we stored before
    }
}

AfterFound(attacked, EndTurnAfterwards){
    global AfterFoundFn
    if (attacked and EndTurnAfterwards) {
        PassTurn()
    }
    MouseMove, MouseX, MouseY
    BlockInput, Off
    AfterFoundFn := ""
}
	
	
	
	
TestFunct() {
BlockInput On


ars := GetAbsolutePixels(0.725, 0.75)
MouseMove ars[1] , ars[2]

BlockInput Off 
}
