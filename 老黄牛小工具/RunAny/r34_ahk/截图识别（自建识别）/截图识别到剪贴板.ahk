;这是服务器的地址，请手动修改
apiserver := "http://api1.r34.cc"
sleep,1000
;截图并保存，要临时文件
nowpath =%A_ScriptDir%
toolpath := nowpath "\Lib\"
tempjpg := toolpath "temp.jpg"
temptxt := toolpath "temp.txt"

#Include ..\Lib\Gdip选框截图.ahk

选框并截图(tempjpg)

;-----------------------------api区域------------------------

#SingleInstance, Force
#Include ..\Lib\JSON.ahk
#Include ..\Lib\lilyfun.ahk

SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
jbname := "ocr" ;脚本的名字等于文件名
fkeyold := "图片地址"   ;要发送的旧文件的标题行名称
fkeynew := ""   ;要接收的新文件的标题行名称
;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
;apiserver := getserverurl()

url := apiserver "/jb/" jbname

arr := []
arr["图片地址"] := tempjpg

;"E:\老黄牛的C盘文档\C盘桌面\11.png"  "D:\老黄牛小工具\word模板\发票.jpg"
arr2 := arr2excelarr(arr)

json64 := Postarr(url, arr2,fkeyold,fkeynew)


jsonarr := json.load(b64Decode(json64))

temp := jsonarr.contents.识别结果
clipboard = %temp%
tr("已复制到剪贴板")

exitapp

