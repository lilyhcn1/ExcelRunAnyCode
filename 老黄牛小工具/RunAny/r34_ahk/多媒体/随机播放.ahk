#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


Random, n , 1, 17
path = D:\老黄牛小工具\RunAny\r34_ahk\多媒体\mp3\sound_%n%.mp3
if FileExist(path){
  SoundPlay, %path% , Wait
}