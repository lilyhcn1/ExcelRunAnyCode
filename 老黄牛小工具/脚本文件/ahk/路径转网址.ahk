ox := ComObjActive("Excel.Application")

stra := ox.ActiveCell.Value
if  (stra != ""){
	ox.ActiveCell.Value := ""



	path := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.txt"
	FileDelete, %path%
	FileAppend,%stra%,%path%
	ox.run("��������ϴ��ļ�")
	exit	
}

	

