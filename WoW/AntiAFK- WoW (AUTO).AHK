SetWorkingDir %A_ScriptDir%




RandomSleep(Between1, Between2) {
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}
  
values:=["w","a"]
SetTimer, Idle, 150000
return
 
Idle:
	if (A_TimeIdle > 20000) ; wait 10 seconds then continue to loop
	{
	; loop start here
	random, rand, 1, 4
	SendInput, % "{" values[rand] " down}"
	RandomSleep(69,420)
	SendInput, % "{" values[rand] " up}"
	RandomSleep(69,420)
	; loop end here
	}
	return 

End:: ; press End key to forcefully suspend scipt
Suspend, Toggle
Pause, Toggle, 1
return
