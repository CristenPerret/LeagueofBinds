#NoEnv
#UseHook
#SingleInstance force ; Replace an existing script
Menu, tray, Tip, [Mi and Yuu] - Tools
TrayTip, Yuumi Tools, running...,,16
#IfWinActive League of Legends (TM) Client ahk_class RiotWindowClass



; KEYBINDS HERE 
;	https://www.autohotkey.com/docs/commands/Send.htm#keynames
; In League Options > Hotkeys > Camera Control > "Select Ally"
; Where Select Ally 4 = ADC, 3 = MID, 2 = JUNG, 1 = TOP
; For AutoAttack. Hotkeys > Player Mvnt > "Player Attack Move Click"
global Spell_Attach := "w"
global AutoAttack :="a"
global ADC := "0"
global jungle := "9"
global midlane := "8"
global toplane := "7"
global Emote1 := "F1"
global Emote2 := "F2"
global Emote4 := "F4"
global Emote5 := "F5"
global EmoteM := "PgDn"

; SCRIPTED HOTKEYS
;	https://www.autohotkey.com/docs/commands/Send.htm#keynames
; EDIT AttachToTeam(ROLE)NeverDetach(ROLE) - Primarly if a role swap happens in draft.
; I Unbind my Mousewheel up + down to '[', and ']'.
; League still camera zooms if AHK has MWUP/MWDN bound. Have bound via Razer Synapse to fix.
$+a::ProcPassive()

$+w:: ; to ADC
AttachToTeam(ADC)
return
$]:: ; to ADC
NeverDetach(ADC)
return
$+]:: ; to Jung
AttachToTeam(jungle)
return
$[:: ; to Mid
AttachToTeam(midlane)
return
$+[:: ; to top
AttachToTeam(toplane)
return
F6::reload



; | - - EDiT AT YOUR OWN RISK - - |
;|| \-/-\-/\-/-\-/\-/-\-/\-/-\-/\-/||
; | - - - - - - - - C O R E - - - - - - -   |
;|| /-\-/-\/-\-/-\/-\-/-\/-\-/-\/-\||

RandomSleep(Between1, Between2) {
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}

GAP(RatioX, RatioY) { ; GetAbsolutePixels
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
Return [AbsoluteX, AbsoluteY]
} 

NeverDetach(Role) {
SpellTopL := GAP(0.44, 0.91)
SpellBtmR := GAP(0.46, 0.95)
ImageSearch, AttachActive, , SpellTopL[1], SpellTopL[2], SpellBtmR[1], SpellBtmR[2], *120 YesAttach.png
ImageSearch, NotAttachedNotOnCD, ,SpellTopL[1], SpellTopL[2], SpellBtmR[1], SpellBtmR[2], *120 NoAttach.png
if AttachActive {
	Send, ^{3} ;Dance Hotkey
	RandomSleep(10,20)
	BadManner()
	Send, {%Role%}
	Return
	}
if NotAttachedNotOnCD {
	AttachToTeam(%Role%)
	BadManner()
	Return
	}
	Return
	}

ProcPassive() { ; Change the key in the 'Send' Line, if Pick a Card isn't bound as 'W'
PassiveTopL := GAP(0.40, 0.91)
PassiveBtmR := GAP(0.42, 0.94)
SpellTopL := GAP(0.44, 0.91)
SpellBtmR := GAP(0.46, 0.95)
ImageSearch, AttachActive, , SpellTopL[1], SpellTopL[2], SpellBtmR[1], SpellBtmR[2], *120 YesAttach.png
ImageSearch, NotAttachedNotOnCD, ,SpellTopL[1], SpellTopL[2], SpellBtmR[1], SpellBtmR[2], *120 NoAttach.png
ImageSearch, PassiveActive, , PassiveTopL[1], PassiveTopL[2], PassiveBtmR[1], PassiveBtmR[2], *120 YesPassive.png
if AttachActive {
	AttachStart()
	Send, {%Spell_Attach% up}
	BadManner()
	Return
	}
if NotAttachedNotOnCD {
	AttachStart()
	Send, {%Spell_Attach% up}
	Return
	}
if PassiveActive {
	Send, {%AutoAttack%}
	Return
	}
	Return
	}
	
AttachStart() {
Send, {%Spell_Attach% down}
RandomSleep(10,20)
}

AttachToTeam(Role) {
AttachStart()
Send,{%Role%}
RandomSleep(10,20)
Send, {%Spell_Attach% up}
RandomSleep(10,20)
}

BadManner() { ; 1:1 Emotes:Mastery
Random, Rage, 1, 10
if (Rage = 1)
 {
	Send, {%Emote1%}
	}
else if (Rage = 2)
{
	Send, {%Emote2%}
	}
else if (Rage = 3)
{
	Send, {%Emote3%}
	}
else if (Rage = 4)
{
	Send, {%Emote4%}
	}
else if (Rage = 5)
{
	Send, {%Emote5%}
	}
else if (Rage > 5)
{
	Send, {%EmoteM%}
	}
RandomSleep(10,20)
Return
}
