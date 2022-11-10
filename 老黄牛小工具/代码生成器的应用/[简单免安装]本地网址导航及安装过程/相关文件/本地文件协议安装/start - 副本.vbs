Set oArgs = Wscript.Arguments
filepath = Wscript.Arguments(0)
Set ws = Wscript.CreateObject("wscript.shell")
tpath = CreateObject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path & "\"
ws.currentdirectory = tpath
MsgBox (filepath)

TobeSearchpath="D:\"



myfile = Split(filepath, "r34://")(1)
If Len(myfile) Then
Set fso = CreateObject("Scripting.FileSystemObject")
If InStr(myfile, "/") Then ' 网址
Z = -1
ElseIf InStr(myfile, "\") Then ' 本地盘
If InStr(myfile, ".") Then ' 文件类型
If fso.fileExists(myfile) Then Z = -1
Else
If fso.folderExists(myfile) Then Z = -1
End If
End If
If Z = -1 Then CreateObject("Shell.Application").ShellExecute myfile, 0, "", "", 1
End If