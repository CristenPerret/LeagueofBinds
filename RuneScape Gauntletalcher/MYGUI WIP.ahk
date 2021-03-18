#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include RandomBezier.ahk
#Include %A_ScriptDir%\ControlColor.ahk
FileInstall bg.png, bg.png, 1
FileInstall bank.png, bank.png, 1
FileInstall Inventory.png, Inventory.png, 1

Menu Tray, Icon, X:\Software\Scripts\AHK\Game\RuneScape\Ethereum Scale 100.exe

mPos(mX, mY) {
	return [mX, mY] 
	}


global Key_Closeui := "Escape"
global Key_Inventory := "Escape"
global Key_MagicTab := "F2"
global Key_CombatTab := "F1"
global Key_Start := "F9"
global Key_Bankteller :="F5"
global Pos_Bankteller := mPos(234, 121)
global Pos_Bankteller2 := mPos(227, 259)
global Pos_CloseBankui := mPos(486, 46)
global Pos_Bracelet_in_bank := mPos(141, 127)
global Pos_Ether_in_bank := mPos(93, 127)
global Pos_Inventory := mPos(651, 214)
global Pos_MagicTab := mPos(743, 216)
global Pos_HighAlch := mPos(731, 339)
global InventoryX	:=	[591, 632, 674, 716]
global InventoryY	:=	[257, 294, 328, 365, 401, 437, 473]

global BraceletCount := 0
global AFKCOUNT := 0
global StoredSleep := 0


WinGetPos, RSx, RSy, RSw, RSh, RuneLite

AnchorWin := RSx + (RSw - 252)
Gui New, +hWndhMainWnd -MinimizeBox -MaximizeBox +AlwaysOnTop -DPIScale +Owner -E0x20
Gui Add, Picture, x-1 y0 w250 h153, bg.png
;Gui Add, Picture, x-10 y154 w427 h37, titlebar2.png
Gui Add, Button, gStart x69 y130 w80 h23 -E0x20, START (%Key_Start%)
Gui Font, Bold c0xFFFFFF
Gui Add, Text, x18 y130 w34 h12 +BackgroundTrans +0x2, COST
Gui Font
Gui Font, Italic c0x8080FF
Gui Add, Edit, hWndhEdtValue vBracelet x69 y105 w80 h18 -VScroll +Number -E0x20, 44000
Gui Font
ControlColor(hEdtValue, hMainWnd, 0x626262)
Gui Font, Italic c0x8080FF
Gui Add, Edit, hWndhEdtValue2 vEther x69 y87 w80 h18 -VScroll +Number -E0x20, 180
Gui Font
ControlColor(hEdtValue2, hMainWnd, 0x626262)
Gui Font, Italic c0x008000
Gui Add, Edit, hWndhEdtValue3 vNature x69 y69 w80 h18 -VScroll +Number -E0x20, 260
Gui Font
ControlColor(hEdtValue3, hMainWnd, 0x626262)
Gui Add, Text, x4 y125 w150 h2 +0x10 -E0x20
Gui Font, Bold c0xFFFFFF
Gui Add, Text, x12 y70 w46 h13 +BackgroundTrans +0x2, Nature
Gui Font
Gui Font, Bold c0xFFFFFF
Gui Add, Text, x14 y89 w46 h13 +BackgroundTrans +0x2, Ether 
Gui Font
Gui Font, Bold c0xFFFFFF
Gui Add, Text, x12 y109 w50 h13 +BackgroundTrans +0x2, Bracelet 
Gui Font
Gui Add, Picture, x13 y5 w131 h55, bank.png
Gui Add, Picture, x151 y6 w98 h146, Inventory.png
Gui Add, DropDownList, vQuantLoop x172 y27 w60 -E0x20, 50|75|100|125|150|175|200|225|250|500|1000|25||
Gui Font, c0xC0C0C0
Gui Add, Text, x184 y47 w35 h16 +0x200 +BackgroundTrans +0x1, Quant
Gui Font
Gui Add, Button, ggHelp x3 y3 w15 h23 -E0x20, &?
Gui Show, x%AnchorWin% y%RSy% w248 h153, Ether-Alcher
Return


gHelp:
hx := 420, hy := 350, Styleoffset := 7
Tw := hx - ( Styleoffset * 2 ), Th := hy * 85 * 0.01
Tcx := Styleoffset + 2, Tcy := Styleoffset * 4, Tcw := Tw - Styleoffset, Tch :=  Th - (Styleoffset * 3.5 )
hbh := 35, hbw := 140, hbx := ( hx / 2 ) - ( hbw / 2 ), hby := hy - hbh - Styleoffset
SubmitButtony := Th - 22, SubmitButtonw := hbw / 2, SubmitButtonh := hbh / 2, SubmitButtonx := ( hx / 2 ) - ( SubmitButtonw / 2 )
T1Txt1 := "The Resolution this script was calibrated to is 765x503.`nWhich can be configured on Runelite if its not by default.`n`nMake sure the window is as small as it can be w/o black spaces.`n`n _____In OSRS_____`nGo into the options and set the client to be static sized.`n`nPress (F5) to move the mouse to where the Bankteller should be centered on. Currently its calibrated perfectly looking north with a teller 1sq to the West when zoomed in and camera is directly top/down.`n`nMake a new Bank Tab as displayed, and make sure the deposit`nquantity is anything >= 25.`nFor the Inventory setup, just have the bottom left two spaces for the`ngold and the nature runes.`n`n_____USAGE_____`n`nEnter the Price (optional), select the quantity, and enjoy!"
T1Txt2 := "`n`nThis should be the In-Game Keybinds`nthat the script will use to close / switch UIs`n`n`nSpecific parts of the cycle like just High Alching can be individually bound aswell"
T1Txt3 := "`n`n`n`n`nOriginal Credits for the bones of the script go to 'DejaVu'.`nAlso MasterFocus for RandomBezier albiet modded.`nThank you.`n`n`n`n`nRefined by TheOneWhoSighs@UnknownCheats.me`nHMU on discord @ Dumpsterman#2870"@

Gui, 3:-MinimizeBox -MaximizeBox +AlwaysOnTop -DPIScale +Owner
Gui, 3:Add, Button, ghclose x%hbx% y%hby% w%hbw% h%hbh%, &CLOSE
Gui, 3:Font, Bold 0x000000
Gui, 3:Color, 0x5BCAFF
Gui, 3:Add, Tab3, x%Styleoffset% y%Styleoffset% w%Tw% h%Th%, Setup|Hotkeys|About
Gui 3:Font
Gui, 3:Tab, 1
Gui, 3:Add, Picture, x%Tcx% y%Tcy% w%Tcw% h%Tch% 0x4000000, bg.png
Gui 3:Font, Bold c0xFFFFFF
Gui 3:Add, Text, x%Tcx% y%Tcy% w%Tcw% h%Tch% +BackgroundTrans +0x1, %T1Txt1%
Gui, 3:Tab, 2
Gui, 3:Add, Picture, x%Tcx% y%Tcy% w%Tcw% h%Tch% 0x4000000, bg.png
Gui 3:Add, Text, x%Tcx% y%Tcy% w%Tcw% h%Tch% +BackgroundTrans +0x1, %T1Txt2%
Gui 3:Add, Hotkey, x88 y222 w120 h21 +Disabled, %Key_Closeui% ; 1
Gui 3:Add, Hotkey, x209 y222 w120 h21 +Disabled, %Key_Inventory% ;2
Gui 3:Add, Hotkey, x88 y246 w120 h21 +Disabled, %Key_MagicTab% ; 3
Gui 3:Add, Hotkey, x209 y246 w120 h21 +Disabled, %Key_CombatTab% ;4
Gui 3:Add, Hotkey, gStart vStart x148 y199 w120 h21 +Disabled, %Key_Start% ; Top Center
Gui 3:Add, Text, x178 y185 w120 h21 +BackgroundTrans, Start Script
Gui 3:Add, Text, x88 y208 w120 h21 +BackgroundTrans, CloseUI
Gui 3:Add, Text, x209 y208 w120 h21 +BackgroundTrans +0x2, Inventory
Gui 3:Add, Text, x0 y250 w85 h21 +BackgroundTrans +0x2, MagicTab
Gui 3:Add, Text, x330 y250 w85 h21 +BackgroundTrans, CombatTab
Gui 3:Add, Button,x%SubmitButtonx% y%SubmitButtony% w%SubmitButtonw% h%SubmitButtonh%, Submit
Gui, 3:Tab, 3
Gui, 3:Add, Picture, x%Tcx% y%Tcy% w%Tcw% h%Tch% 0x4000000, bg.png
Gui 3:Add, Text, x%Tcx% y%Tcy% w%Tcw% h%Tch% +BackgroundTrans +0x1, %T1Txt3%
Gui 3:Show, w%hx% h%hy%, Info
Return

hclose:
Gui, 3:Destroy
return

Reset:
Reload
return

$Escape::ExitApp ;Escape closes app
GuiEscape:
GuiClose:
    ExitApp

Start:
GuiControlGet, Ether
GuiControlGet, Bracelet
GuiControlGet, Nature
GuiControlGet, QuantLoop
Gui Show, Hide

ProfitPerBracelet := (45000 - ( Ether + Bracelet + Nature))
TotalProfit := QuantLoop * ProfitPerBracelet

WinActivate, RuneLite
sleep 2000
while QuantLoop > BraceletCount
{	
	BlockInput On
	Bank()
	MakeAllBracelet()
	RandomSleep(1500,9999)
	AlchAllBracelet()
	BlockInput Off
If (QuantLoop == BraceletCount) {
	time := 19990101  ; *Midnight* of an arbitrary date.
    time += (StoredSleep / 1000), seconds
    FormatTime, mmss, %time%, mm:ss
    FormatedSleep := mmss
Msgbox, Total time Slept! : %FormatedSleep%`nWith AFKSleep Interrupts: %AFKCOUNT%`nTotal Gold Accrued : %TotalProfit%`n
Reload
}	
}

return




MakeAllBracelet()
{
	global CounterX	:= 2
	global CounterY := 1
	Loop, 25
	{
		RandomSleep(100,500)
		MoveToArray(1,1) ; Ether
		RandomSleep(250,350)
		Click
		RandomSleep(150,250)
		MovetoArray(CounterX,CounterY) ; Move to Bracelet
		RandomSleep(150,250)
		Click
		RandomSleep(150,250)
		if (CounterX = 4 and CounterY = 7) ; Complete
		{
			RandomSleep(1000,2055)
		}
		else
		{
			PickUpEther()
			RandomSleep(400,670)
		}
		
		if (CounterX = 2 and CounterY = 1)
		{
			CounterX := 3
		}
		else
		{
			if (CounterX = 3 and CounterY = 1)
			{
				CounterX := 4
			}
			else
			{
				if (CounterX = 4 and CounterY = 1)
				{
					CounterX := 1, CounterY := 2
				}
				else
				{
					if (CounterX = 1 and CounterY = 2)
					{
						CounterX := 2
					}
					else
					{
						if (CounterX = 2 and CounterY = 2)
						{
							CounterX := 3
						}
						else
						{
							if (CounterX = 3 and CounterY = 2)
							{
								CounterX := 4
							}
							else
							{
								if (CounterX = 4 and CounterY = 2)
								{
									CounterX := 1, CounterY := 3
								}
								else
								{
									if (CounterX = 1 and CounterY = 3)
									{
										CounterX := 2
									}
									else
									{
										if (CounterX = 2 and CounterY = 3)
										{
											CounterX := 3
										}
										else
										{
											if (CounterX = 3 and CounterY = 3)
											{
												CounterX := 4
											}
											else
											{
												if (CounterX = 4 and CounterY = 3)
												{
													CounterX := 1, CounterY := 4
												}
												else
												{
													if (CounterX = 1 and CounterY = 4)
													{
														CounterX := 2
													}
													else
													{
														if (CounterX = 2 and CounterY = 4)
														{
															CounterX := 3
														}
														else
														{
															if (CounterX = 3 and CounterY = 4)
															{
																CounterX :=4
															}
															else
															{
																if (CounterX = 4 and CounterY = 4)
																{
																	CounterX := 1, CounterY := 5
																}
																else
																{
																	if (CounterX = 1 and CounterY = 5)
																	{
																		CounterX := 2
																	}
																	else
																	{
																		if (CounterX = 2 and CounterY = 5)
																		{
																			CounterX := 3
																		}
																		else
																		{
																			if (CounterX = 3 and CounterY = 5)
																			{
																				CounterX := 4
																			}
																			else
																			{
																				if (CounterX = 4 and CounterY = 5)
																				{
																					CounterX := 1, CounterY := 6
																				}
																				else
																				{
																					if (CounterX = 1 and CounterY = 6)
																					{
																						CounterX := 2
																					}
																					else
																					{
																						if (CounterX = 2 and CounterY = 6)
																						{
																							CounterX := 3
																						}
																						else
																						{
																							if (CounterX = 3 and CounterY = 6)
																							{
																								CounterX := 4
																							}
																							else
																							{
																								if (CounterX = 4 and CounterY = 6)
																								{
																									CounterX := 3, CounterY := 7
																								}
																								else
																								{
																									if (CounterX = 3 and CounterY = 7)
																									{
																										CounterX := 4
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

AlchAllBracelet()
{
	WinActivate, RuneLite
	global CounterX	:= 2
	global CounterY := 1
	
	Random OOPSMispress, 1, 10
	If ( OOPSMispress == 5 ) {
		Send, {%Key_StatTab% Down}
		RandomSleep(100,150)
		Send, {%Key_StatTab% Up}
		Send, {%Key_MagicTab% Down}
		RandomSleep(160,200)
		Send, {%Key_MagicTab% Up}
		} 
	If ( OOPSMispress ) < 5 {
		Send, {%Key_MagicTab% Down}
		RandomSleep(100,250)
		Send, {%Key_MagicTab% Up}	
		RandomSleep(250,1500)
	}
	If ( OOPSMispress ) > 5 {
		RandomBezier(743, 216, 10)  ; Click magic tab
		RandomSleep(100,250)
		Click
		}	
	RandomSleep(250,1500)
		
	Send, {%Key_MagicTab% Down}
	RandomSleep(100,250)
	Send, {%Key_MagicTab% Up}
	RandomSleep(250,1500)
	Loop, 25
	{
		Random, RNGMISCLICK, 1,9
		
		MainmouseMove(Pos_HighAlch[1], Pos_HighAlch[2], 6, "T250 P0")  ; Click High Alch
		Click
		RandomSleep(150,250)
		MainmouseMove(InventoryX[4], InventoryY[7], 7, "OB100 OL75 OR75")
		RandomSleep(150,250)
		Click
		RandomSleep(150,250)
		
		If (RNGMISCLICK > 7) {
			MainmouseMove(Pos_HighAlch[1], Pos_HighAlch[2], 17, "OT50 OR50")
			}
			
		RandomSleep(2000,2579)
		BraceletCount += 1
		ProfitMade := (ProfitMade+ProfitPerBracelet)		
	}
RandomSleep(250,1000)

RandomBezier(404, 267, 133, "t1500 p3") ; Moves mouse off the normal path
}
		
Bank()
{
	Random RNGInventory, 1, 25
	If ( RNGInventory <= 14 ) {
		MainmouseMove(Pos_Inventory[1], Pos_Inventory[2], 10, "") ; Click Inventory
		RandomSleep(100,300)
		click
		} else {		
		Send, {%Key_Inventory% Up}
		RandomSleep(100,300)
		Send, {%Key_Inventory% Down}
		}
	
	RandomSleep(100,300)
	MainmouseMove(Pos_Bankteller2[1], Pos_Bankteller2[2], 10, "OT150 OB150 OR150 OL150") 			;Click Booth 
	RandomSleep(125,255)
	Click
	RandomSleep(200,350)
	MainmouseMove(Pos_Ether_in_bank[1], Pos_Ether_in_bank[2], 5, "OT25 OB25 OR25 OL25")		; Right click ether
	RandomSleep(650,1050)
	Click right
	RandomSleep(350,450)
	Random OffsetR, 0, 15
	MouseMove, OffsetR, 35, 1, R
	RandomSleep(300,400)
	Click
	RandomSleep(450,750)
	MainmouseMove(Pos_Bracelet_in_bank[1], Pos_Bracelet_in_bank[2], 6, "OT25 OB25 OR25 OL25")	  ; Click bracelet
	RandomSleep(200,350)
	Click
	RandomSleep(450,650)
	
	
	Random RNGBank, 1, 25
	If ( RNGBank <= 14 ) {
		MainmouseMove(Pos_CloseBankui[1], Pos_CloseBankui[2], 10, "OT25 OB25 OR25 OL25")      ; Close bank
		RandomSleep(100,250)
		click
		} else {
		Send, {%Key_Closeui% Up}
		RandomSleep(100,250)
		Send, {%Key_Closeui% Down} 
		}
		RandomSleep(1000,1500)	
}	
	
PickUpEther()
{
	Random, RNGEther, 1, 25 ; Adds irregularity 
	MainmouseMove(Pos_Bankteller2[1], Pos_Bankteller2[2], 10, "OT250 OB150 OR150 OL250")    ;Click Booth
	RandomSleep(125,255)
	Click
	RandomSleep(200,350)
	
	If ( RNGEther >= 25 ) {
	MainmouseMove(Pos_Ether_in_bank[1], Pos_Ether_in_bank[2], 6, "OT50 OB50 OR75 OL50") ; Right Click Ether
	RandomSleep(750,1250)
	Click right
	Random OffsetR, 0, 15
	MouseMove, OffsetR, 27, 1, R ;SELECTS ALL ETHER INTENTIONALLY
	RandomSleep(250,350)
	Click
	RandomSleep(150,250)
	Send, {%Key_Closeui% Down} ; Close Ui
	RandomSleep(150,250)
	MainmouseMove(InventoryX[1],InventoryY[1], 14, "T1500 P0")
	RandomSleep(1200,3500)
	MainmouseMove(Pos_Bankteller2[1], Pos_Bankteller2[2], 8, "OT250 OB150 OR150 OL250 T1000 P0")    ;Click Booth
	RandomSleep(150,250)
	Click
	RandomSleep(250,500)
	MainmouseMove(InventoryX[1],InventoryY[1], 5, "T1000 P0")
	RandomSleep(750,1150)
	Click,
	RandomSleep(250,500)
	}
	
	MainmouseMove(Pos_Ether_in_bank[1], Pos_Ether_in_bank[2], 5, "OT50 OB50 OR75 OL50") ; Right Click Ether
	RandomSleep(750,1250)
	Click right
	Random OffsetR, 0, 15
	MouseMove, OffsetR, 35, 1, R
	RandomSleep(100,250)
	Click
	RandomSleep(100,250)
	Send, {%Key_Closeui% Down} ; Close Ui
	RandomSleep(100,120)
	
	
	If ( RNGEther <= 16 ) {
		RandomBezier(InventoryX[1], InventoryY[2], 50, "OT50 OB75 OR50 OL50") ; Miss Ether item
		}
	
	
	RandomSleep(100,250)
	Send, {%Key_Closeui% Up} ;Click
}

MoveToArray(ArrayX, ArrayY)
{
	MoveX := InventoryX[ArrayX]
	MoveY := InventoryY[ArrayY]	
	MainmouseMove(MoveX, MoveY, 5, "")
}

MainmouseMove(Mx, My, Os, str){
Random, Badmovement, 0, 10
if ( Badmovement == 0 ) {
	RandomBezier(Mx, My, Os * 5, str)
	RandomSleep(250,350)
}
RandomBezier(Mx, My, Os, str)
}

RandomSleep(Between1, Between2) 
{
	Random, RandomizedSleepTime, Between1, Between2 ; MAIN Sleep
	Random, AFKSleep, 0, 66666666 ;Random Sleep emulating being afk/distracted
	
	if (( AFKSleep  >= 44444 ) AND ( AFKSleep <= 66666  )) OR (( AFKSleep >= 13000 ) AND ( AFKSleep <= 20000 )) OR (( AFKSleep >= 115000) AND ( AFKSleep <= 120000)) {
		MouseGetPos, Gx, Gy
		AFKCOUNT += 1
		Midpointx := RSx / 2, Midpointy := RSy / 2, Midpointw := RSw / 2, Midpointh := RSh / 2
		StoredSleep += AFKSleep
		Sleepsplit1 := AFKSleep * 0.2 ; AFKSleep variable is random, and also split
		Sleepsplit2 := AFKSleep * 0.8
		
		RandomBezier( 404, 267, 133, "t1500 p3") ; Moves mouse off the normal path
		Sleep, Sleepsplit1
		AFKtime := 19990101
		AFKtime += (AFKtime / 1000), seconds
		FormatTime, mmss, %AFKtime%, mm:ss
		AFKFormat := mmss
		Tooltip, [iDLE] %AFKFormat%, 380 , 0
		Sleep, Sleepsplit2
		RandomBezier(Gx, Gy, 10, "t2500")
		sleep, 50
		MouseMove, Gx, Gy
		Tooltip,
		sleep, 150
	}
	StoredSleep += RandomizedSleepTime ;Counts up how long 'RandomSleep' has accumulated.
	Sleep, RandomizedSleepTime
}

return
+2::reload
+3::AlchAllBracelet()
+4::MakeAllBracelet()
^1::MouseMove, Pos_Bankteller2[1], Pos_Bankteller2[2]

/*
	The raw Pixels for the 28 inventory grid dump
	Pos1 := [591, 257]
	Pos2 := [632, 257]
	Pos3 := [674, 257]
	Pos4 := [716, 257]
	Pos5 := [591, 294]
	Pos6 := [632, 294]
	Pos7 := [674, 294]
	Pos8 := [716, 294]
	Pos9 := [591, 328]
	Pos10 := [632, 328]
	Pos11 := [674, 328]
	Pos12 := [716, 328]
	Pos13 := [591, 365]
	Pos14 := [632, 365]
	Pos15 := [674, 365]
	Pos16 := [716, 365]
	Pos17 := [591, 401]
	Pos18 := [632, 401]
	Pos19 := [674, 401]
	Pos20 := [716, 401]
	Pos21 := [591, 437]
	Pos22 := [632, 437]
	Pos23 := [674, 437]
	Pos24 := [716, 437]
	Pos25 := [591, 473]
	Pos26 := [632, 473]
	Pos27 := [674, 473]
	Pos28 := [716, 473]
 /*