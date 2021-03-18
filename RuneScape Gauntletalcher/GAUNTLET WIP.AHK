#Include RandomBezier.ahk
FileInstall CloseCircleButton.png, CloseCircleButton.png, 1
FileInstall titlebar2.png, titlebar2.png, 1
FileInstall bg.png, bg.png, 1
FileInstall bank.png, bank.png, 1
FileInstall Inventory.png, Inventory.png, 1


global BraceletCount := 0
global ProfitPerBracelet := 0
global ProfitMade := 0
global TempsSeconde := 0
global TempsMinute := 0
global TempsHeure := 0

Gui, -Caption +AlwaysOnTop

Gui, Add, Picture, x-7 y-2 w500 h50 , titlebar2.png
Gui, Add, Text, x0 y0 w500 h50 +BackgroundTrans gUImove
Gui, Add, Picture, x463 y5 gclose +BackgroundTrans, CloseCircleButton.png
Gui, Add, Picture, x-7 y50 w500 h537 , bg.png
Gui, Font, S12 CWhite Bold, Verdana
Gui, Font, S12 CWhite Bold, Verdana
Gui, Font, S8 CWhite Bold, Verdana
Gui, Add, Text, x50 y75 w288 h19 +BackgroundTrans, Your bank should look like this
Gui, Add, Picture, x50 y95 w288 h86 , bank.png
Gui, Add, Text, x367 y75 w326 h19 +BackgroundTrans, Your inventory should look like this
Gui, Add, Picture, x396 y95 w240 h326 , Inventory.png
Gui, Add, Text, x31 y300 w336 h67 +BackgroundTrans, To start the script`, Press the button.                                                               To stop the script`, press escape.
Gui, Add, Button, x31 y375 w336 h76 gNumpad1, Click To Start

Gui, Add, Text, x100 y200 +BackgroundTrans, Ether
Gui, Add, Text, x75 y225 +BackgroundTrans, Bracelet
Gui, Add, Text, x37 y250 +BackgroundTrans, Nature Rune
Gui, Font, S12 CBlack Bold, Verdana
Gui, Add, Edit, x200 y200 w75 h20 vEther, 180
Gui, Add, Edit, x200 y225 w75 h20 vBracelet, 44000
Gui, Add, Edit, x200 y250 w75 h20 vNature, 260

Gui, Show, w493 h457, Gui 1

SetTimer, UpdateHUD, 1000
Gosub, UpdateHUD  ; Make the first update immediate rather than waiting for the timer.
return

UpdateHUD:
GuiControl,2:,TextVar_Answer1, Bracelet Made : %BraceletCount%
GuiControl,2:,TextVar_Answer2, Profit Per Bracelet : %ProfitPerBracelet%
GuiControl,2:,TextVar_Answer3, Profit Made : %ProfitMade%
GuiControl,2:,TextVar_Answer4, Time Running : %TempsHeure%Hour %TempsMinute%Minute %TempsSeconde%Seconds
TempsSeconde += 1
if (TempsSeconde = 60)
{
	TempsSeconde := 0
	TempsMinute += 01
}
if (TempsMinute = 60)
{
	TempsMinute := 0
	TempsHeure += 1
}
return

GuiClose:
ExitApp

close:
GuiEscape:
Exitapp

uiMove:
PostMessage, 0xA1, 2,,, A 
Return

$Escape::
ExitApp
Return

Numpad1::				; Press Y to start
Gui, 2:-Caption +AlwaysOnTop
Gui, 2:Add, Picture, x-7 y-2 w570 h200, bg.png
Gui, 2:Font, S16 CWhite Bold, Verdana
gui, 2:add, text, x2 y47 w470 h48 vTextVar_Answer1 +BackgroundTrans, Bracelet Made : %BraceletCount%
gui, 2:add, text, x2 y87 w470 h48 vTextVar_Answer2 +BackgroundTrans, Profit Per Bracelet : = %ProfitPerBracelet%
gui, 2:add, text, x2 y127 w470 h48 vTextVar_Answer3 +BackgroundTrans, Profit Made : = %ProfitMade%
gui, 2:add, text, x2 y7 w570 h48 vTextVar_Answer4 +BackgroundTrans, Time Running : %TempsHeure%Hour %TempsMinute%Minute %TempsSeconde%Seconds




GuiControlGet, Ether
GuiControlGet, Bracelet
GuiControlGet, Nature
Gui, 1:Destroy

;Gui, 2:Show, % "x" A_ScreenWidth - 1225 " y" A_ScreenHeight - 420 " w" 540 " h" 180

If (Ether = "" or Bracelet = "" or Nature = "")
{
	ProfitPerBracelet := "No price entered."
}
else
{
	ProfitPerBracelet := Ether+Bracelet+Nature
	ProfitPerBracelet := (45000-ProfitPerBracelet) 
}

If ProfitPerBracelet is digit
{
	ProfitMade := 0
}
else
{
	ProfitMade := "No price entered."
}

WinActivate, RuneLite
sleep 5000
while 1>0
{	
	Bank()
	MakeAllBracelet()
	RandomSleep(1500,9999)
	AlchAllBracelet()
	
}
return





MakeAllBracelet()
{
	global CounterX	:= 2
	global CounterY := 1
	Loop, 25
	{
		RandomSleep(100,500)
		MoveToArray(1,1)
		RandomSleep(150,250)
		Click
		RandomSleep(150,250)
		MovetoArray(CounterX,CounterY)
		RandomSleep(150,250)
		Click
		RandomSleep(150,250)
		if (CounterX = 4 and CounterY = 7)
		{
			RandomSleep(1000,2055)
		}
		else
		{
			PickUpEther()
			RandomSleep(250,750)
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
					CounterX := 1
					CounterY := 2
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
									CounterX := 1
									CounterY := 3
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
													CounterX := 1
													CounterY := 4
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
																	CounterX := 1
																	CounterY := 5
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
																					CounterX := 1
																					counterY := 6
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
																									CounterX := 3
																									CounterY := 7
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
	global CounterX	:= 2
	global CounterY := 1
	Send, {F2 Down}	;RandomBezier(743, 216, 10)  ; Click magic tab
	RandomSleep(100,250)
	Send, {F2 Up}	;Click
	RandomSleep(250,1500)
	Loop, 25
	{
		Random, RNGMISCLICK, 1,9
		RandomBezier(731, 339, 6, "T200 P0")  ; Click High Alch
		Click
		RandomSleep(150,250)
		RandomBezier(716, 473, 7, "OB50 OL150 OR75")
		RandomSleep(150,250)
		Click
		RandomSleep(150,250)
		If (RNGMISCLICK > 7) {
		RandomBezier(731, 339, 17, "OT50 OR50")  ; Click High Alch
		}
		RandomSleep(2000,2579)
		BraceletCount += 1
		
		If ProfitPerBracelet is digit
		{
			ProfitMade := (ProfitMade+ProfitPerBracelet)
		}
		else
		{
			ProfitMade := "No price entered."
		}
		
	}
}
		
Bank()
{

	Send, {Escape Up}	;RandomBezier(651, 214, 10) ; Click Inventory
	RandomSleep(100,300)
	Send, {Escape Down}	;click
	RandomSleep(100,300)
	RandomBezier(294, 131, 10) 			;Click Booth 
	Click
	RandomSleep(100,250)
	RandomBezier(93, 127, 10)		; Right click ether
	RandomSleep(750,1250)
	Click right
	RandomSleep(100,250)
	Random OffsetR, 0, 15
	MouseMove, OffsetR, 35, 1, R
	RandomSleep(100,250)
	Click
	RandomSleep(100,250)
	RandomBezier(141, 127, 10)	  ; Click bracelet
	Click
	RandomSleep(100,250)
	
	Send, {Escape Down} ;RandomBezier(489, 50, 10)      ; Close bank
	RandomSleep(100,250)
	Send, {Escape Up} ;Click
	RandomSleep(1000,1500)
	
}	
	

PickUpEther()
{
	
	RandomBezier(294, 131, 10, "OT500 OB50 OR50 OL500")    ;Click Booth
	Click
	RandomSleep(100,250)
	RandomBezier(93, 127, 6, "OT50 OB500 OR750 OL50") ; Right Click Ether
	RandomSleep(750,1250)
	Click right
	Random OffsetR, 0, 15
	MouseMove, OffsetR, 35, 1, R
	RandomSleep(100,250)
	Click
	RandomSleep(100,250)
	Send, {Escape Down} ;RandomBezier(489, 50, 15)      ; Close bank
	RandomSleep(100,120)
	RandomBezier(591, 257, 50)
	RandomSleep(100,250)
	Send, {Escape Up} ;Click
}

MoveToArray(ArrayX, ArrayY)
{
	global InventoryX	:=	[591, 632, 674, 716]
	global InventoryY	:=	[257, 294, 328, 365, 401, 437, 473]
	MoveX := InventoryX[ArrayX]
	MoveY := InventoryY[ArrayY]	
	RandomBezier(MoveX, MoveY, 5)
}



RandomSleep(Between1, Between2) 
{
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}

+2::reload
+3::AlchAllBracelet()
+4::MakeAllBracelet()