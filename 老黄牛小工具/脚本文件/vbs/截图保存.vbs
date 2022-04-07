Dim  tempjpg
tempjpg="D:\老黄牛小工具\ExcelQuery\temp\temp.jpg"
'删除临时文件
Set fso = CreateObject("scripting.filesystemobject")
If fso.FileExists(tempjpg) Then
    fso.DeleteFile tempjpg, True
End If

'相对路径的获取
Function getexeurl(exeurl,gdexeurl)
nowpath =createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path 
newpath=nowpath&"\"&exeurl
If fso.FileExists(newpath) Then
    getexeurl=newpath
else
    getexeurl=gdexeurl
End If
End Function

'点击确定后，三秒内开始截图
msgbox("点击确定后，三秒内开始截图")
'延迟一秒执行
wscript.sleep 3000





screenerurl=getexeurl("360screener.exe","D:\老黄牛小工具\小工具\360screener.exe")
nconverturl=getexeurl("缩小图片nconvert\nconvert.exe","D:\老黄牛小工具\小工具\缩小图片nconvert\nconvert.exe")
'msgbox (nconverturl) 

'调用截图程序截图到剪贴板
Set oShell = CreateObject("WSCript.shell")

ret = oShell.Run(screenerurl, 1, True)
'把剪贴板的图象保存为jpg文件
exeurl = nconverturl & " -out jpeg -clipboard -overwrite -o " & tempjpg
'Call Shell(exeurl, 0)
ret = oShell.Run(exeurl, 0, True)
'强制关闭截图程序
ret = oShell.Run( "cmd.exe /c /min taskkill /IM 360screener.exe /F",0,True)
