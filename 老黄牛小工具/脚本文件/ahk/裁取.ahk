#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="图片路径"
input2 := "输出图片"
input3 := "x"
input4 := "y"
input5 := "w"
input6 := "h"
;input3 := "发送文件"
info := "运行结果"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
val4 := readjsonconkey(input4)
val5 := readjsonconkey(input5)
val6 := readjsonconkey(input6)
;-------------1.读取输入变量----------
if (val1 != "" ){  ;正常运行

main()
arr2[info] :="√"

}else{  ;出错后的处理
    arr2[input1] := "D:\老黄牛小工具\word模板\待裁剪图片.jpg"
    arr2[input2] := "D:\老黄牛小工具\temp\temp.jpg"
    arr2[input3] := "500"
    arr2[input4] := "60"
    arr2[input5] := "225"
    arr2[input6] := "55"
                
    
    arr2[info] := "标题行找不到关键词【" input1 "】或为空，请检查。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(){
;------------------------
;引入变量
global val1,val2,val3,val4,val5,val6
;-----------引用变量-------------
nconvert := "D:\老黄牛小工具\小工具\缩小图片nconvert\nconvert.exe"
runstr := nconvert " -out jpeg -quiet -overwrite  -crop " val3 " " val4 " " val5 " " val6 " -o " val2 " " val1
;msgbox % runstr
Run, %runstr%,,min

}
