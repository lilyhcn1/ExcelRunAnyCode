Set oArgs = WScript.Arguments
on error resume next
filepath0=WScript.Arguments(0)
filepath1=WScript.Arguments(1)
filepath2=WScript.Arguments(2)
filepath3=WScript.Arguments(3)
filepath=Trim(filepath0 & " " & filepath1 & " " & filepath2 & " " & filepath3)
dim fso, f
set fso = CreateObject("Scripting.FileSystemObject")
set f = fso.CreateTextFile("D:\�ϻ�ţС����\ExcelQuery\temp.txt", true) '�ڶ���������ʾĿ���ļ�����ʱ�Ƿ񸲸�
f.Write(filepath)
f.Close()
set f = nothing
set fso = nothing

if filepath="" then
  msgbox ("�����Ӧ���ļ��ϵ����ļ��ϣ�~")
else
  set xlapp=getobject(,"excel.application")
  xlapp.run "��������ϴ��ļ�"
end if
