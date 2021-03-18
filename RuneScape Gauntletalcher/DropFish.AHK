#SingleInstance Force
#NoEnv
Escape::Exitapp
F5::Reload
;Space::Click
+1:: 
Loop{
ClickRng(3000,3200)
}
Return
ClickRng(win, wax) {
Random, zRNG, win, wax
1RNG := zRNG * 0.8
2RNG := zRNG * 0.2
Click,
Sleep, 1RNG
Click, 
Sleep, 2RNG

}
