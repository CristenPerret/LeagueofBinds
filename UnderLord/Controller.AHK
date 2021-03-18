#SingleInstance force ; Replace an existing script
#NoEnv ; Don't check empty variables to see if they are environment variables
SetDefaultMouseSpeed, 0 ; Move mouse instantly
; Changes the tray icon's tooltip (displayed when mouse hovers over it)
Menu, tray, Tip, Underlords Tools
; Show Tooltip in the tray that the script is active (Quiet)
TrayTip, Underlords Tools, running...,,16
; Makes subsequent hotkeys only function if specified window is active
#IfWinActive Dota Underlords ahk_class SDL_app

; Controller Movement
; Grouped in this section
Up up::
MouseGetPos, MX,MY
MouseMove,MX,MY-10
Return

Down up::
MouseGetPos, MX,MY
MouseMove,MX,MY+10
Return

Left up::
MouseGetPos, MX,MY
MouseMove,MX-10,MY
Return

RIght up::
MouseGetPos, MX,MY
MouseMove,MX+10,MY
Return






; Leaves current match.
$+Escape up:: ; Shift + Escape
LeaveMatch()
Sleep, 420
Requeue()
Return

; Starts Queuing, when at the main menu.
$+`:: ; Shift + K
ReQueue()
return

;Reloads Script - Useful for testing changes quickly
$F5:: ; F5
Reload
return

; Improved Send to Bench ability, by clicking the unit first.
$w:: ; w
BoardtoBench()
Return

; Improved Selling a piece, by clicking the unit first.
$f:: ;  HOTKEY IS F
SellPiece()
Return

; Improved Inventory preview, by moving the cursor to the item area
;$c:: ; Shift + I
;AssignItems()
Return

;Toggle Inventory
Space::
Send {XButton1}
KeyWait, Space
Send {XButton1}
return

; BUY EVERYTHING IN SHOP
$F2::
BuyShop()
return

;CLICKS THE YOS'
$XButton2::
Loop {
YO()
}until GetKeyState("XButton2", "P")
Tooltip
return

Return


; Should allow most users to be able to use my screen regions with little issue
GetAbsolutePixels(RatioX, RatioY) {
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
	return [AbsoluteX, AbsoluteY]
}

LeaveMatch() {
BlockInput, on

MMBtn :=GetAbsolutePixels(0.5,0.7) ; First button to leave Match
QConfirm :=GetAbsolutePixels(0.45,0.56) ; Confirm Leaving match button
MMLeave :=GetAbsolutePixels(0.1,0.89) ; MainMenu Leave Match button
Send, {Esc} ;Remove first Semicolon if you dont have this bound to Escape
Sleep, 120
MouseMove, MMBtn[1], MMBtn[2]
Click,
Sleep, 120
MouseMove, QConfirm[1], QConfirm[2]
Click,
Sleep,120
MouseMove, MMLeave[1], MMLeave[2]
Click,
Sleep, 120
MouseMove,QConfirm[1], QConfirm[2]
Click,
Sleep, 120
BlockInput, off
}

ReQueue() {
Rankupclose := GetAbsolutePixels(0.95,0.07)
MMPlay :=GetAbsolutePixels(0.1,0.9) ; Main Menu Play Button
MMMulti :=GetAbsolutePixels(0.35,0.55) ;MainMenu Multiplayer Button
BlockInput, on
MouseMove, MMPlay[1], MMPlay[2]+20
Click,
Sleep, 120
MouseMove, MMMulti[1], MMMulti[2]
Click,
Sleep, 20
MouseMove, Rankupclose[1], Rankupclose[2]
Click,
BlockInput, off
}

BoardtoBench() {
Click, 

Send, {w}
}

SellPiece() {
Click,
Send, {f]
}

AssignItems() {
Gear :=GetAbsolutePixels(0.92,0.55)

Send, {c}
MouseMove, Gear[1], Gear[2]
}

YO() {
ars :=GetAbsolutePixels(0.66,0.02)
BlockInput, on
MouseMove, ars[1], ars[2]
Click
sleep, 20
MouseClick, left, ars[1], ars[2]+50
sleep, 20
MouseClick, left, ars[1], ars[2]+100
sleep, 20
;MouseClick, left, ars[1], ars[2]+150
sleep, 200
BlockInput, off
}

BuyShop() {
BlockInput, on
MouseGetPos, GetX, GetY
;Click, 1,1
;Sleep, 100
Send, XButton1
Sleep, 20
send, 1
sleep, 20
send, 2
sleep, 20
send, 3
sleep, 20
send, 4
sleep, 20
send, 5
sleep, 20
Click, 1,1
Sleep, 20
MouseMove, GetX, GetY

BlockInput, off
}




