#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------


Random, n , 1, 17
path = D:\�ϻ�ţС����\RunAny\r34_ahk\��ý��\mp3\sound_%n%.mp3
if FileExist(path){
  SoundPlay, %path% , Wait
}