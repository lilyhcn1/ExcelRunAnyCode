#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
;input1 :="图片路径"
;input2 := "输出图片"
;input3 := "x"
;input4 := "y"
;input5 := "w"
;input6 := "h"
;input3 := "发送文件"
output1 :="识别结果"
info := "运行结果"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
val4 := readjsonconkey(input4)
val5 := readjsonconkey(input5)
val6 := readjsonconkey(input6)
;-------------1.读取输入变量----------

main()
;FileRead, jsonstr, D:\老黄牛小工具\temp\temp.txt,utf-8
jsonstr := utf8readtext("D:\老黄牛小工具\ExcelQuery\temp\temp.txt")
;msgbox % jsonstr
arr2[output1] := jsonstr
arr2[info] :="√"


;-------------2.最终写入变量----------
savearr2json(arr2)

main(){
;------------------------
;引入变量
global val1,val2,val3,val4,val5,val6
;-----------引用变量-------------
tesseract := "D:\老黄牛小工具\小工具\TesseractOCR\tesseract.exe"
runstr := tesseract " D:\老黄牛小工具\ExcelQuery\temp\temp.jpg D:\老黄牛小工具\ExcelQuery\temp\temp -l chi_sim"

RunWait, %runstr%,,min

}


























