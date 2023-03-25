#SingleInstance, Force
#Include .\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("openssl")
tempinput =  %A_ScriptDir%\Lib\temp.txt
tempoutput =  %A_ScriptDir%\Lib\tempoutput.txt
tempini = %A_ScriptDir%\Lib\temp.ini

^+E::
    Send, ^{c}
    str = %clipboard%
writetext(str, tempinput)

arr :=[]
arr["请输入密码"] := "请输入相应的密码，"
arr :=arrupdatefromini(arr, 10)
key := arr["请输入密码"]

exestr = %exe%  enc -e -des3 -a -salt -k %key% -in "%tempinput%" -out "%tempoutput%"
startstr(exestr)
msgbox, "=="
runwait, %exestr%, min
run, %tempoutput%
tr("替换完毕")
