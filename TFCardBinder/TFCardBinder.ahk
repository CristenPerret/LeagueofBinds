#SingleInstance force
#NoEnv
Menu, tray, Tip, TF CardPick
TrayTip, Pick a Fate, running...,,16
#IfWinActive League of Legends (TM) Client ahk_class RiotWindowClass
 
Global Spell_PAC := "w"
Global AutoAttack  := "a"
Global TimerLoop := "20" ; SECONDS

F5::Reload

$F1::Card("Gold")
$F2::Card("Red")
$F3::Card("Blue")

; | - - EDiT AT YOUR OWN RISK - - |
;|| \-/-\-/\-/-\-/\-/-\-/\-/-\-/\-/||
; | - - - - - - - - C O R E - - - - - - -   |
;|| /-\-/-\/-\-/-\/-\-/-\/-\-/-\/-\||
 
RandomSleep(Between1, Between2) {
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}

CSpell() { ; Change the key in the 'Send' Line, if Pick a Card isn't bound as 'W'
send, {%Spell_PAC% down} ;Pick a Card
RandomSleep(10,25)
send, {%Spell_PAC% up}
}

GAP(RatioX, RatioY) { ; GetAbsolutePixels
	WinGetPos,,, Width, Height
	AbsoluteX := Round(Width * RatioX)
	AbsoluteY := Round(Height * RatioY)
	return [AbsoluteX, AbsoluteY]
}

Card(color) {
	TopL := GAP(0.44, 0.91)
	BtmR := GAP(0.46, 0.95)
	TTsTaTus := GAP(0.47, 0.90)
	Tooltip, Looking for %color%, TTsTaTus[1], TTsTaTus[2]-15
	c := 0
	Cards:
	TTimer :=floor(c)
	Tooltip, Looking for %color% [%TTimer%/%TimerLoop%], TTsTaTus[1], TTsTaTus[2]-15
	c += .07 ;semi close to counting the loop per second.
		if c >= %TimerLoop%
		{
		Tooltip,
		Return
		}
	ImageSearch, %color%, , TopL[1], TopL[2], BtmR[1], BtmR[2], *120 %color%Card.png
	while %color% {
		CSpell()
		BadManner()
		Goto Cards
	}
	RandomSleep(15,25)
	Goto Cards
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