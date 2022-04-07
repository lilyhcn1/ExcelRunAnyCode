dim picsize,picpath
picheight=1080   'ËõÐ¡ºóÍ¼Æ¬µÄ³ß´ç
Set oArgs = WScript.Arguments
rem filepath=WScript.Arguments(0)
Set ws=WScript.CreateObject("wscript.shell")
tpath = createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path &"\"
ws.currentdirectory=tpath
for each filepathtemp in WScript.Arguments
  runstr=tpath & "nconvert  -out jpeg  -quiet -overwrite -ratio " &  " "  & """" & filepathtemp  & """"
  rem msgbox(runstr)
  ws.Run runstr,True
next
