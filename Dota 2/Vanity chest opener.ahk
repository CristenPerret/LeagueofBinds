#SingleInstance force ; Replace an existing script
#NoEnv ; Don't check empty variables to see if they are environment variables
SetDefaultMouseSpeed, 0 ; Move mouse instantly
SetWorkingDir %A_ScriptDir%
; Changes the tray icon's tooltip (displayed when mouse hovers over it)
Menu, tray, Tip, Dota 2 Tools
; Show Tooltip in the tray that the script is active (Quiet)
TrayTip, Dota2 Tools, running...,,16
; Makes subsequent hotkeys only function if specified window is active
#IfWinActive Dota 2 ahk_class SDL_app


;gui, add, checkbox, vOpenChest gRNGChestOpen, Open Chest?
;gui, show, w100 h25, Quality of Life
return
;Submit:
;Gui, Submit, NoHide



$F5::
Reload
Return



$F1::
;RNGChestOpen:
RNGChestOpen()
Return

$F2::
RNGPackOpen()
Return


GetAbsolutePixels(RatioX, RatioY) {
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
	return [AbsoluteX, AbsoluteY]
}
RandomSleep(Between1, Between2) {
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}


RNGChestOpen() {
z=0
OpenPack :=GetAbsolutePixels(0.5,0.5)
OpenAnother :=GetAbsolutePixels(0.3,0.75)
Loop{

Tooltip, LoopCount:%z% , OpenAnother[1]-20, OpenAnother[2]-40
RandomSleep(6969,69420)
MouseMove, OpenAnother[1], OpenAnother[2]
Click
z+= 1
}
}

RNGPackOpen() {
z=0
OpenAnother :=GetAbsolutePixels(0.3,0.75)
OpenPack :=GetAbsolutePixels(0.5,0.5)
Loop{

Tooltip, LoopCount:%z% , OpenAnother[1]-20, OpenAnother[2]-40
MouseMove, OpenAnother[1], OpenAnother[2]
Sleep, 1500
Click
z+= 1
}
}






