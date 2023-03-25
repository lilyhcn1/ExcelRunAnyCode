#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("notepad2")

Loop, %0%
{
    param := %A_Index%
    inputpath := param


}
if(inputpath=""){
exestr = %exe%
run,%exestr%
}else{
exestr = %exe%  "%inputpath%"
run,%exestr%
}




