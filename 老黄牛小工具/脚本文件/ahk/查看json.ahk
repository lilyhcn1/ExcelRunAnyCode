#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;FileRead, jsonstr, D:\�ϻ�ţС����\ExcelQuery\temp\temp.json,utf-8
FileRead, jsonstr, D:\�ϻ�ţС����\ExcelQuery\temp\temp.json
;msgbox % jsonstr

clipboard := jsonstr
run,https://www.bejson.com/
Sleep % 2000
msgbox % "���ڵ��ȷ�Ϻ�2���ڣ�ѡ���ı��򡣻��Զ�ճ�����ֵ����ڡ�"

Sleep % 2000
Send, ^a
Sleep % 100
Send, {Delete}
Sleep % 100
Send, ^v






















