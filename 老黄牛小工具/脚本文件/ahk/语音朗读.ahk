#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.ÒýÓÃº¯Êý----------



txt := getjsonkey("now_val")

spovice:=ComObjCreate("sapi.spvoice")
spovice.Speak(txt)



;msgbox,%pathnew%
