#SingleInstance, Force
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%

clipboard=%clipboard% ;windows ���Ƶ�ʱ�򣬼����屣����ǡ�·������ֻ��·�������ַ�����ֻҪת�����ַ����Ϳ���ճ��������
tooltip,%clipboard% ;��ʾ�ı�
path := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.txt"

if FileExist( clipboard ){
	FileDelete, %path%
	FileAppend,%clipboard%,%path%


	ox := getexcelobj()
	ox.run("���������ϴ�")
}else{
	msgbox, ���ȸ����ļ���������
}
	
