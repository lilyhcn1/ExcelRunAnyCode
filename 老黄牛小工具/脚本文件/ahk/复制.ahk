#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="文件路径"
input2 := "新文件路径"

;input3 := "发送文件"
info := "运行结果"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
;val3 := readjsonconkey(input3)

;-------------1.读取输入变量----------
if (val1 != "" ){  ;正常运行

main()
arr2[info] :="√"

}else{  ;出错后的处理
    arr2[input1] := "D:\老黄牛小工具\word模板\待裁剪图片.jpg"
    arr2[input2] := "新文件夹\待裁剪图片.jpg"

               
    arr2[info] := "标题行找不到关键词【" input1 "】或为空，请检查。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)


main(){
;------------------------
;引入变量
global val1,val2,val3,val4,val5,val6
;-----------引用变量-------------

;读取文件
  ;读取文件

path:=val1
newpath := getwholepath(val2) ;获取绝对路径

creatfolderbyfile(newpath)
FileCopy, %path%, %newpath%


}






















