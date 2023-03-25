#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("wget")
s :=""
aa = %clipboard%


runstr = %exe% -P %A_Desktop%   %aa%

run,%runstr%, , Min
