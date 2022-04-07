dim picsize,picpath,filename,command
Set oArgs = WScript.Arguments
filepath=WScript.Arguments(0)

Set Sh = WScript.CreateObject("WScript.Shell")
Sh.Run filepath, 3
set Sh=nothing
