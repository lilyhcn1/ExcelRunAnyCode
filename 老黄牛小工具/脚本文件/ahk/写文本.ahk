
#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

txt1 := readjsonconkey("文本内容")
txt2 := readjsonconkey("文件路径")
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


arr:=main(txt1,txt2)


arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["文件路径"] := "D:\老黄牛小工具\word模板\文本内容.txt"
    arr2["文本内容"] := "这是文本内容！~"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}


;-------------2.最终写入变量----------
savearr2json(arr2)

main(ByRef txt1,ByRef txt2 :=""){
writetext(txt1, txt2)
}






