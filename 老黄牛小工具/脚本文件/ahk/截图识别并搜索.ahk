tempjpg := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg"
temptxt := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.txt"


RunWait,D:\�ϻ�ţС����\С����\360screener.exe
exeurl := "D:\�ϻ�ţС����\С����\��СͼƬnconvert\nconvert.exe -out jpeg -clipboard -overwrite -o "tempjpg
RunWait, %exeurl%
exeurl := "C:\Users\lilyhcn\AppData\Local\Programs\Python\Python36\python.exe E:\Seafile\�ϻ�ţС����\�ű��ļ�\py\�򵥰ٶ�ocr.py"
RunWait, %exeurl%

FileRead, str, %temptxt%

run,https://www.baidu.com/s?wd=%str%