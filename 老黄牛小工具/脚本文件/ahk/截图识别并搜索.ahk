tempjpg := "D:\老黄牛小工具\ExcelQuery\temp\temp.jpg"
temptxt := "D:\老黄牛小工具\ExcelQuery\temp\temp.txt"


RunWait,D:\老黄牛小工具\小工具\360screener.exe
exeurl := "D:\老黄牛小工具\小工具\缩小图片nconvert\nconvert.exe -out jpeg -clipboard -overwrite -o "tempjpg
RunWait, %exeurl%
exeurl := "C:\Users\lilyhcn\AppData\Local\Programs\Python\Python36\python.exe E:\Seafile\老黄牛小工具\脚本文件\py\简单百度ocr.py"
RunWait, %exeurl%

FileRead, str, %temptxt%

run,https://www.baidu.com/s?wd=%str%