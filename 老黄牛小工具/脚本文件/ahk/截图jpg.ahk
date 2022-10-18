#Include <lilyfun>
sleep,1000
;截图并保存，要临时文件
nowpath =%A_ScriptDir%
toolpath := "D:\老黄牛小工具\ExcelQuery\temp\"
tempjpg := toolpath "temp.jpg"
temptxt := toolpath "temp.txt"

#Include <Gdip选框截图>

选框并截图(tempjpg)
writetextgbk(tempjpg, temptxt)

exitapp


