dim picsize,picpath
picsize=1920   '��С��ͼƬ�ĳߴ�
filepathtemp="picdfd.png"
Set oArgs = WScript.Arguments
rem filepath=WScript.Arguments(0)
Set ws=WScript.CreateObject("wscript.shell")
tpath = createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path &"\"
ws.currentdirectory=tpath
runstr=tpath & "nconvert -out png -clipboard -overwrite -o aaa.png"

