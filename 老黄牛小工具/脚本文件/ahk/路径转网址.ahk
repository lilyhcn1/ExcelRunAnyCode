ox := ComObjActive("Excel.Application")

stra := ox.ActiveCell.Value
if  (stra != ""){
	ox.ActiveCell.Value := ""



	path := "D:\老黄牛小工具\ExcelQuery\temp\temp.txt"
	FileDelete, %path%
	FileAppend,%stra%,%path%
	ox.run("表格网络上传文件")
	exit	
}

	

