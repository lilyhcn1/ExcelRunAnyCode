#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("aria2c")
s :=""
aa = %clipboard%


runstr = %exe% --dir %A_Desktop%   %aa%

run,%runstr%, , Min
