#SingleInstance Force

#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Menu Tray, Icon, shell32.dll, 131




Gui Body: New, LabelBody hWndhBody
Gui Color, White

Gui Add, Edit, x-1 y-1 w0 h0 ; Focus
Gui Font, s8 w700 cBlack, Segoe UI
Gui Add, Text, x10 y46 w187 h16, 你正在安装老黄牛小工具。
Gui Font
Gui Font,, Segoe UI
Gui Add, Text, x10 y62 w456 h16 +0x200,安装完成后，你就可以正常使用此程序了。
Gui Add, Text, x10 y80 w480 h1 0x10 ; Separator

Gui Add, Text, x33 y90 w500 h16 +0x200, 这是一个小工具，
Gui Add, Text, x33 y107 w500 h16 +0x200, 我自己一直在用,喜欢的话,可以github.com点个star
Gui Add, Text, x33 y124 w500 h16 +0x200, 邮箱:admin@upsir.com
Gui Add, Text, x33 y141 w500 h16 +0x200, 网址:https://github.com/lilyhcn1/ExcelRunAnyCode

Gui Font, w700 cBlack, Segoe UI
Gui Add, Text, x10 y224 w480 h16 +0x200, 请选择要安装的内容
Gui Font
Gui Add, Text, x10 y243 w480 h2 0x10 ; Separator
Gui Font, w700, Segoe UI
Gui Add, CheckBox, x33 y253 w92 h23 Checked vc1, 基本程序
Gui Add, CheckBox, x33 y282 w92 h23 Checked  vc2, 使用说明
Gui Add, CheckBox, x33 y311 w92 h23 Checked vc3, Excel插件
Gui Add, CheckBox, x33 y342 w92 h23  vc4, RunAny
Gui Font

Gui Font,, Segoe UI
Gui Add, Text, x126 y253 w410 h23 +0x200, (8M MB) - 核心程序
Gui Add, Text, x126 y282 w393 h23 +0x200, (0 MB) - 介绍老黄牛小工具的使用方法.
Gui Add, Text, x126 y311 w362 h23 +0x200, (0 MB) - Excel插件，可以使用实现无限功能。
Gui Add, Text, x126 y341 w364 h23 +0x200, (0 MB) - 基于RunAny的快速启动程序

Gui Font
Gui Add, Text, x10 y400 w480 h2 0x10 ; Separator
;Gui Add, Text, x10 y400 w263 h25 +0x200,在线查看内容
;Gui Font

Gui Add, Progress, -1 y430 w502 h49 Border, 0
Gui Font,, Segoe UI
;Gui Add, Button, x413 y439 w75 h23 Default  g2ButtonOK, 下一步
Gui, Add, Button, x413 y439 w75 h23 gBnext , 下一步  ; ButtonOK(如果存在) 会在此按钮被按下时运行.


Gui Show, w499 h471, r34.cc

Gui Header: New, -Caption +Parent%hBody%
Gui Header: Color, 0x008EBC
;Gui Header: Add, Picture, x24 y6 w28 h28 Icon131, shell32.dll
Gui Font, s14 c0xF3F8FB, Ms Shell Dlg 2
Gui Header: Add, Text, x54 y1 w394 h38 +0x200 BackgroundTrans, 老黄牛小程序 安装向导
Gui Font
Gui Header: Show, x0 y0 w500 h38

Return

Bnext:
Gui, Submit  ; 保存用户的输入到每个控件的关联变量中.
floderpath =D:\老黄牛小工具
inipath = D:\老黄牛小工具\配置文件\myconf.ini
scriptpath = ..\..\..\
;msgbox , %scriptpath%

; c1安装老黄牛小工具
;FileCopyDir, ..\老黄牛小工具, %floderpath% , 1
if(c1=1){
;建文件夹creatfolderbyfile

;建立老黄牛小工具的文件夹
if !FileExist(floderpath){
  FileCreateDir, %floderpath%
}

;备份配置文件
if FileExist(inipath){
  FileCopy, %inipath%, %scriptpath%\老黄牛小工具\配置文件\myconf.ini  , 1
}
;复制文件夹过去
if FileExist(floderpath){
  FileCopyDir, %scriptpath%\老黄牛小工具, %floderpath% , 1
}
;安装autohotkey程序
 runwait,regedit.exe /s %floderpath%\小工具\小工具安装程序\注册ahk.reg

}




if(c3=1){

; c2安装插件
sleep % 500
xllpath := checkandgetpath("xll")

;FileCopy, %scriptpath%\老黄牛小工具\Excel插件\,%AppData%\Microsoft\AddIns\ , 1


vbspath = %scriptpath%\老黄牛小工具\Excel插件\res\安装插件.vbs
runwait ,Wscript.exe %vbspath%

}


if(c4=1){
; c3安装RunAny
sleep % 2000
RunAnypath := checkandgetpath("RunAny")
Run ,%RunAnypath%

msgbox,RunAny已经运行,您可以按 ~ 键查看效果.
}


if(c2=1){
; 使用说明的介绍
Run ,https://github.com/lilyhcn1/ExcelRunAnyCode
sleep % 3000
}

sleep % 2000
msgbox,安装完成,请使用.
exitapp
return

BodyEscape:
BodyClose:
    ExitApp