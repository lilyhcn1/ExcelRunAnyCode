clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
tooltip,%clipboard% ;提示文本
path := "D:\老黄牛小工具\ExcelQuery\temp\temp.txt"

if FileExist( clipboard ){
	FileDelete, %path%
	FileAppend,%clipboard%,%path%


	ox := ComObjActive("Excel.Application")
	ox.run("表格网络上传文件")
}else{
	msgbox, 请先复制文件到剪贴板
}
	

