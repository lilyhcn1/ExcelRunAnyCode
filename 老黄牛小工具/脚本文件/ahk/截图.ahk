;这是服务器的地址，请手动修改
apiserver := "http://api1.r34.cc"
sleep,1000
;截图并保存，要临时文件
nowpath =%A_ScriptDir%
toolpath := "D:\老黄牛小工具\ExcelQuery\temp\"
tempjpg := toolpath "temp.jpg"


#Include <Gdip选框截图>

选框并截图(tempjpg)
exitapp


