; Rendu a essayer d'incrémenter profit per bracelet

FileInstall CloseCircleButton.png, CloseCircleButton.png, 1
FileInstall titlebar2.png, titlebar2.png, 1
FileInstall bg.png, bg.png, 1
FileInstall bank.png, bank.png, 1
FileInstall Inventory.png, Inventory.png, 1


global NbrBracelet := 0
global ProfitPerBracelet := 0
global ProfitMade := 0
global TempsSeconde := 0
global TempsMinute := 0
global TempsHeure := 0
global MakeXBracelet := 1

Gui, -Caption +AlwaysOnTop
Gui, Add, Picture, x-7 y-2 w729 h57 , titlebar2.png
Gui, Add, Text, x0 y0 w675 h40 +BackgroundTrans gUImove
Gui, Add, Picture, x680 y6 gclose +BackgroundTrans, CloseCircleButton.png
Gui, Add, Picture, x-7 y55 w729 h537 , bg.png
Gui, Font, S16 CWhite Bold, Verdana
Gui, Font, S16 CWhite Bold, Verdana
Gui, Font, S12 CWhite Bold, Verdana
Gui, Add, Text, x50 y75 w288 h19 +BackgroundTrans, Your bank should look like this
Gui, Add, Picture, x50 y95 w288 h86 , bank.png
Gui, Add, Text, x367 y75 w326 h19 +BackgroundTrans, Your inventory should look like this
Gui, Add, Picture, x396 y95 w240 h326 , Inventory.png
Gui, Add, Text, x31 y300 w336 h67 +BackgroundTrans, To start the script`, Press the button.                                                               To stop the script`, press escape.
Gui, Add, Button, x31 y375 w336 h76 gNumpad1, Click To Start

Gui, Add, Text, x32 y200 +BackgroundTrans, Bracelets to make
Gui, Add, Text, x100 y225 +BackgroundTrans, Ether Cost
Gui, Add, Text, x75 y250 +BackgroundTrans, Bracelet Cost
Gui, Add, Text, x37 y275 +BackgroundTrans, Nature Rune Cost
Gui, Font, S12 CBlack Bold, Verdana
Gui, Add, Edit, x200 y200 w75 h20 vMakeX,
Gui, Add, Edit, x200 y225 w75 h20 vEther,
Gui, Add, Edit, x200 y250 w75 h20 vBracelet,
Gui, Add, Edit, x200 y275 w75 h20 vNature,

Gui, Show, w726 h457, Gui 1

SetTimer, UpdateHUD, 1000
Gosub, UpdateHUD  ; Make the first update immediate rather than waiting for the timer.
return

UpdateHUD:
GuiControl,2:,TextVar_Answer1, Bracelet Made : %NbrBracelet%
GuiControl,2:,TextVar_Answer2, Profit Per Bracelet : %ProfitPerBracelet%
GuiControl,2:,TextVar_Answer3, Profit Made : %ProfitMade%
GuiControl,2:,TextVar_Answer4, Time Running : %TempsHeure%Hour %TempsMinute%Minute %TempsSeconde%Seconds
GuiControl,2:,TextVar_Answer5, Bracelets to make : %MakeXBracelet%
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

If (MakeXBracelet = NbrBracelet)
{
	SoundBeep, 1000, 250  ; Play a higher pitch for half a second.
	sleep 250
	SoundBeep, 1000, 250
	sleep 250
	SoundBeep, 1000, 250
	ExitApp
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

Escape::
ExitApp
Return

Numpad1::				; Press Y to start
Gui, 2:-Caption +AlwaysOnTop
Gui, 2:Add, Picture, x-7 y-2 w570 h200, bg.png
Gui, 2:Font, S16 CWhite Bold, Verdana
gui, 2:add, text, x2 y87 w470 h48 vTextVar_Answer1 +BackgroundTrans, Bracelet Made : %NbrBracelet%
gui, 2:add, text, x2 y127 w470 h48 vTextVar_Answer2 +BackgroundTrans, Profit Per Bracelet : = %ProfitPerBracelet%
gui, 2:add, text, x2 y167 w470 h48 vTextVar_Answer3 +BackgroundTrans, Profit Made : = %ProfitMade%
gui, 2:add, text, x2 y7 w570 h48 vTextVar_Answer4 +BackgroundTrans, Time Running : %TempsHeure%Hour %TempsMinute%Minute %TempsSeconde%Seconds
gui, 2:add, text, x2 y47 w470 h48 vTextVar_Answer5 +BackgroundTrans, Bracelets to make : %MakeXBracelet%

GuiControlGet, Ether
GuiControlGet, Bracelet
GuiControlGet, Nature
GuiControlGet, MakeX
MakeXBracelet := MakeX
If MakeXBracelet is not digit
{
	ExitApp
}

Gui, 1:Destroy

Gui, 2:Show, % "x" A_ScreenWidth - 1225 " y" A_ScreenHeight - 420 " w" 540 " h" 180


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
sleep 10000
while 1>0
{	
	;Bank()
	;MakeAllBracelet()
	;RandomSleep(1000,5000)
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
		MoveToArray(1,1)			; Click Inv1,1
		RandomSleep(100,250)
		Click
		RandomSleep(100,250)
		MovetoArray(CounterX,CounterY)
		RandomSleep(100,250)
		Click
		RandomSleep(100,250)
		if (CounterX = 2 and CounterY = 7)
		{
			sleep 1000
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
																									CounterX := 1
																									CounterY := 7
																								}
																								else
																								{
																									if (CounterX = 1 and CounterY = 7)
																									{
																										CounterX := 2
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
	MouseMoveRandom(1392, 260, 15, 15)  ; Click magic tab
	RandomSleep(100,250)
	Click
	RandomSleep(100,250)
	Loop, 25
	{
		MouseMoveRandom(1355,442, 10, 10)  ; Click High Alch
		RandomSleep(100,250)
		Click
		RandomSleep(100,250)
		MouseMoveRandom(1233, 589, 10, 10)
		RandomSleep(100,250)
		Click
		RandomSleep(2500,3250)
		NbrBracelet += 1
		
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
	MouseMoveRandom(1260,260,10,10)
	RandomSleep(100,300)
	click
	RandomSleep(100,300)
	MouseMoveRandom(817, 142, 10, 10)    ;Click Booth
	RandomSleep(100,250)
	Click
	RandomSleep(750,1250)
	MouseMoveRandom(571, 156, 10, 10)	  ; Click ether
	RandomSleep(100,250)
	Click
	RandomSleep(100,250)
	MouseMoveRandom(629, 153, 10, 10)	  ; Right click bracelet
	RandomSleep(100,250)
	Click right
	RandomSleep(100,250)
	MouseMove, 0, 80, 1, R
	RandomSleep(250,500)
	Click
	RandomSleep(100,250)
	MouseMoveRandom(1066, 59, 3, 3)      ; Close bank
	RandomSleep(100,250)
	Click
	RandomSleep(1000,1500)
}	
	

PickUpEther()
{
	MouseMoveRandom(817, 142, 25, 25)   ; Click Bank
	RandomSleep(100,250)
	Click
	RandomSleep(750,1250)
	MouseMoveRandom(571, 156, 10, 10)  ; Click Ether
	RandomSleep(100,250)
	Click
	MouseMoveRandom(1066, 59, 3, 3)	; Close bank
	RandomSleep(100,250)
	Click
}

MoveToArray(ArrayX, ArrayY)
{
	global InventoryX	:=	[1182, 1236, 1288, 1340]
	global InventoryY	:=	[313, 360, 406, 450, 497, 544, 594]
	MoveX := InventoryX[ArrayX]
	MoveY := InventoryY[ArrayY]
	
	RandomPositionXLess := MoveX-10
	RandomPositionXMore := MoveX+10
	Random, RandomX, RandomPositionXLess, RandomPositionXMore
	
	RandomPositionYLess := MoveY-10
	RandomPositionYMore := MoveY+10
	Random, RandomY, RandomPositionYLess, RandomPositionYMore
	
	MouseMove RandomX, RandomY
}



MouseMoveRandom(PositionX,PositionY, Less, More)
{
	BlockInput MouseMove
	RandomPositionXLess := PositionX-Less
	RandomPositionXMore := PositionX+More
	Random, RandomX, RandomPositionXLess, RandomPositionXMore
	
	RandomPositionYLess := PositionY-Less
	RandomPositionYMore := PositionY+More
	Random, RandomY, RandomPositionYLess, RandomPositionYMore
	MouseMove RandomX, RandomY
	BlockInput off
}

RandomizeNumber(PositionX,PositionY, Less, More)
{
	RandomPositionXLess := PositionX-Less
	RandomPositionXMore := PositionX+More
	Random, RandomX, RandomPositionXLess, RandomPositionXMore
	
	RandomPositionYLess := PositionY-Less
	RandomPositionYMore := PositionY+More
	Random, RandomY, RandomPositionYLess, RandomPositionYMore
}


RandomSleep(Between1, Between2) 
{
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}
