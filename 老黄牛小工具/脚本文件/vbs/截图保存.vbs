Dim  tempjpg
tempjpg="D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg"
'ɾ����ʱ�ļ�
Set fso = CreateObject("scripting.filesystemobject")
If fso.FileExists(tempjpg) Then
    fso.DeleteFile tempjpg, True
End If

'���·���Ļ�ȡ
Function getexeurl(exeurl,gdexeurl)
nowpath =createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path 
newpath=nowpath&"\"&exeurl
If fso.FileExists(newpath) Then
    getexeurl=newpath
else
    getexeurl=gdexeurl
End If
End Function

'���ȷ���������ڿ�ʼ��ͼ
msgbox("���ȷ���������ڿ�ʼ��ͼ")
'�ӳ�һ��ִ��
wscript.sleep 3000





screenerurl=getexeurl("360screener.exe","D:\�ϻ�ţС����\С����\360screener.exe")
nconverturl=getexeurl("��СͼƬnconvert\nconvert.exe","D:\�ϻ�ţС����\С����\��СͼƬnconvert\nconvert.exe")
'msgbox (nconverturl) 

'���ý�ͼ�����ͼ��������
Set oShell = CreateObject("WSCript.shell")

ret = oShell.Run(screenerurl, 1, True)
'�Ѽ������ͼ�󱣴�Ϊjpg�ļ�
exeurl = nconverturl & " -out jpeg -clipboard -overwrite -o " & tempjpg
'Call Shell(exeurl, 0)
ret = oShell.Run(exeurl, 0, True)
'ǿ�ƹرս�ͼ����
ret = oShell.Run( "cmd.exe /c /min taskkill /IM 360screener.exe /F",0,True)
