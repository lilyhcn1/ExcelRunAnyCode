; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


Macro1:
IfNotExist, D:\老黄牛小工具\小工具\ffmpeg.exe
{
    MsgBox, 0, ffmpeg.exe缺失, ffmpeg.exe太大了，请自行下载并放入 D:\老黄牛小工具\小工具
    Run, https://ffmpeg.org/download.html#build-windows
}
Else
{
Loop, %0%
{
    param := %A_Index%
    Run, ffmpeg.exe -i "%param%"  "%param%.gif"
}
}
Return

