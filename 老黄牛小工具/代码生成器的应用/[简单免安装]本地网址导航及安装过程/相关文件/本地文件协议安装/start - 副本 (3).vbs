'把环境变量替换一下
Set oShell = CreateObject("WScript.Shell")	
r34 = oShell.ExpandEnvironmentStrings("%r34%")
lilyfolder = oShell.ExpandEnvironmentStrings("%lilyfolder%")
TobeSearchpath = "E:\Seafile\私人资料库\分类工作\"





Dim z
Set oArgs = wscript.Arguments
filepath = wscript.Arguments(0)
Set ws = wscript.CreateObject("wscript.shell")
tpath = CreateObject("Scripting.FileSystemObject").GetFile(wscript.ScriptFullName).ParentFolder.Path & "\"
ws.currentdirectory = tpath
'MsgBox (TobeSearchpath)


myfile = Split(filepath, "r34://")(1)
myfile = URLDecode(myfile)
myfile = Left(myfile, Len(myfile) - 1)
myfile = Replace(myfile, "%r34%", r34)
myfile = Replace(myfile, "%lilyfolder%", lilyfolder)
'MsgBox (myfile)

Set fso = CreateObject("Scripting.FileSystemObject")
If Len(myfile) = 0 Then wscript.Quit

If InStr(myfile, "http") Then ' 网址(不能排除http名字文件夹，建议用 \\: )
    z = -1
ElseIf InStr(myfile, "\") Then ' 本地
    If InStr(myfile, ".") Then ' 文件类型
        If fso.FileExists(myfile) Then
            z = -1
        Else
            If fso.FolderExists(myfile) Then
                z = -1
            End If
        End If
    End If
Else
    Getmyfile fso, TobeSearchpath, myfile, z ' 查找关键字文件夹
End If
If z = -1 Then OpenFile myfile




Sub Getmyfile(fso, p, kw, z)
  For Each s In fso.GetFolder(p).SubFolders
    If InStr(s, kw) Then
    OpenFile s
    wscript.Quit
    Else
    Getmyfile fso, s, kw, z
    End If
  Next
End Sub

Sub OpenFile(myfile)
  CreateObject("Shell.Application").ShellExecute myfile, 0, "", "", 1
  wscript.sleep 1000 * 1
End Sub


Function URLDecode(ByVal strIn)
    URLDecode = ""
    Dim sl: sl = 1
    Dim tl: tl = 1
    Dim key: key = "%"
    Dim kl: kl = Len(key)
    sl = InStr(sl, strIn, key, 1)
    Do While sl > 0
        If (tl = 1 And sl <> 1) Or tl < sl Then
            URLDecode = URLDecode & Mid(strIn, tl, sl - tl)
        End If
        Dim hh, hi, hl
        Dim a
        Select Case UCase(Mid(strIn, sl + kl, 1))
        Case "U" 'Unicode URLEncode
            a = Mid(strIn, sl + kl + 1, 4)
            URLDecode = URLDecode & ChrW("&H" & a)
            sl = sl + 6
        Case "E" 'UTF-8 URLEncode
            hh = Mid(strIn, sl + kl, 2)
            a = Int("&H" & hh) 'ascii码
            If Abs(a) < 128 Then
                sl = sl + 3
                URLDecode = URLDecode & Chr(a)
            Else
                hi = Mid(strIn, sl + 3 + kl, 2)
                hl = Mid(strIn, sl + 6 + kl, 2)
                a = ("&H" & hh And &HF) * 2 ^ 12 Or ("&H" & hi And &H3F) * 2 ^ 6 Or ("&H" & hl And &H3F)
            If a < 0 Then a = a + 65536
            URLDecode = URLDecode & ChrW(a)
            sl = sl + 9
            End If
        Case "X"
            a = Int(Mid(strIn, sl + kl + 1, 3))
            URLDecode = URLDecode & ChrW(a)
            sl = sl + 5
        Case Else 'Asc URLEncode
            hh = Mid(strIn, sl + kl, 2) '高位
            a = Int("&H" & hh) 'ascii码
            If Abs(a) < 128 Then
                sl = sl + 3
            Else
                hi = Mid(strIn, sl + 3 + kl, 2) '低位
                a = Int("&H" & hh & hi) '非ascii码
                sl = sl + 6
            End If
            URLDecode = URLDecode & Chr(a)
        End Select
        tl = sl
        sl = InStr(sl, strIn, key, 1)
    Loop
    URLDecode = URLDecode & Mid(strIn, tl)
End Function

