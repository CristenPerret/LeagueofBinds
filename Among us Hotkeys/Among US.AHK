#SingleInstance force ; Replace an existing script
#UseHook
#NoEnv
;#X:\Software\Scripts\AHK\VA.ahk ;mute db
#Include X:\Software\Scripts\AHK\VA.ahk ;mute db
Menu, Tray, Tip, Among US Hotkeys
Menu Tray, Icon, X:\Software\Scripts\AHK\Game\Among Us\AU.ico
TrayTip, [OWS] AU Keybinds, running...,,16



~F5::reload



; Movement
toggle:=0 ; start toggle in the on/true state
F4::toggle:=!toggle ; changes value of toggle from True to False or Vice Versa with each press of F12

#If toggle ; only when toggle is on do hotkeys below this work
global DefaultUp := w
global DefaultLeft:= a
global DefaultDown := s
global DefaultRight := d
global DefaultUse := e
global DefaultReport :=r
global DefaultKill :=q

; Movement
w::w
a::a
r::s
s::d

; Use
XButton1::e

; Report
XButton2::r

; Kill
q::q

; Map
Space::Tab

return
#If 
; a blank #If will reset context sensitivity for all hotkeys below it (and also those at the top of the script, because the effect of #If "wraps around" from bottom to top until it hits the next #if)

; ---------v-MUTE BIND-v-------

F1::  				; F1 hotkey - toggle mute state of Game
  
; ---------^-MUTE BIND-^-------  
  
  WinGet, ActivePid, PID, A
  if !(Volume := GetVolumeObject(ActivePid))
    MsgBox, There was a problem retrieving the application volume interface
  VA_ISimpleAudioVolume_GetMute(Volume, Mute)  ;Get mute state
  ; Msgbox % "Application " ActivePID " is currently " (mute ? "muted" : "not muted")
  VA_ISimpleAudioVolume_SetMute(Volume, !Mute) ;Toggle mute state
  ObjRelease(Volume)
return

; ----------^-MUTE Funct-^----------
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
;----------^-MvP.functs-^----------




funct(v) {
Send, %v%
KeyWait, %A_ThisHotkey%
Send, %v%
}

















; -----------MUTE FUNCT-----------

;Required for app specific mute
GetVolumeObject(Param = 0)
{
    static IID_IASM2 := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
    , IID_IASC2 := "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}"
    , IID_ISAV := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"

    ; Get PID from process name
    if Param is not Integer
    {
        Process, Exist, %Param%
        Param := ErrorLevel
    }

    ; GetDefaultAudioEndpoint
    DAE := VA_GetDevice()

    ; activate the session manager
    VA_IMMDevice_Activate(DAE, IID_IASM2, 0, 0, IASM2)

    ; enumerate sessions for on this device
    VA_IAudioSessionManager2_GetSessionEnumerator(IASM2, IASE)
    VA_IAudioSessionEnumerator_GetCount(IASE, Count)

    ; search for an audio session with the required name
    Loop, % Count
    {
        ; Get the IAudioSessionControl object
        VA_IAudioSessionEnumerator_GetSession(IASE, A_Index-1, IASC)

        ; Query the IAudioSessionControl for an IAudioSessionControl2 object
        IASC2 := ComObjQuery(IASC, IID_IASC2)
        ObjRelease(IASC)

        ; Get the session's process ID
        VA_IAudioSessionControl2_GetProcessID(IASC2, SPID)

        ; If the process name is the one we are looking for
        if (SPID == Param)
        {
            ; Query for the ISimpleAudioVolume
            ISAV := ComObjQuery(IASC2, IID_ISAV)

            ObjRelease(IASC2)
            break
        }
        ObjRelease(IASC2)
    }
    ObjRelease(IASE)
    ObjRelease(IASM2)
    ObjRelease(DAE)
    return ISAV
}

;
; ISimpleAudioVolume : {87CE5498-68D6-44E5-9215-6DA47EF883D8}
;
VA_ISimpleAudioVolume_SetMasterVolume(this, ByRef fLevel, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+3*A_PtrSize), "ptr", this, "float", fLevel, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMasterVolume(this, ByRef fLevel) {
    return DllCall(NumGet(NumGet(this+0)+4*A_PtrSize), "ptr", this, "float*", fLevel)
}
VA_ISimpleAudioVolume_SetMute(this, ByRef Muted, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+5*A_PtrSize), "ptr", this, "int", Muted, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMute(this, ByRef Muted) {
    return DllCall(NumGet(NumGet(this+0)+6*A_PtrSize), "ptr", this, "int*", Muted)
}


