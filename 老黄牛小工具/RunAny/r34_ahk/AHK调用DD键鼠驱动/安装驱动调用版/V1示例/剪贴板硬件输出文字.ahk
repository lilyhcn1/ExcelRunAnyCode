; 看dd的反馈普遍都是低延迟导致蓝屏
; 我在不同电脑用循环60ms发送按键，一台没事，另一台就蓝屏，调到100ms就没事了

#NoEnv
#Include %A_ScriptDir%\Class_DD\class_DD.ahk
SetWorkingDir %A_ScriptDir%

OnExit, Clear

ddxoft := new DD()			;将类DD实例化
dd.btn(0)							;初始化
return

; 调用示例
;DD.str("abc") ;发送文字abc	【有些游戏是用这个函数来发送按键】
;DD._key_press("F11") ;发送键击
;DD._key_pressEx("F11", 2) ;发送键击两次
;DD._key_press("F11", "Up") ;发送F11按下
;DD._key_press("F11", "Down") ;发送F11按下
;DD._key_press("LWin", "R") ;发送组合键Win+R
;DD._key_press("Ctrl", "Alt", "S") ;发送组合键Ctrl+Alt+S
;DD._whl("Up") ;鼠标滚轮向前滚动
;DD._btn("RButtonDown") ;鼠标右键按下	【有些游戏是用这个函数来发送鼠标按键】
;DD._btn("RButtonUp") ;鼠标右键弹起		【有些游戏是用这个函数来发送鼠标按键】
;DD._btn("LButtonDown", 672, 997) ;鼠标左键移动到坐标按下
;DD._btn_press("LButton") ;鼠标左键点击
;DD._btn_press("LButton", 672, 997) ;鼠标左键移动到坐标点击
;DD.mov(10, 10) ;鼠标绝对值移动
;DD.movR(10, 10) ;鼠标相对值移动

Clear:
DD_Helper.UnloadDll()
ExitApp


;按下F1运行脚本
$F1::
s=%clipboard% ;
l := strlen(s)
i :=0
sleep 3000
send,%s%
Return

