
#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("文件路径")
txt2 := "无"
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


arr:=main(txt1,txt2)

;msgbox % a
arr2["文件名"] :=arr["文件名"]
arr2["修改时间"] :=arr["修改时间"]
arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["文件路径"] := "D:\老黄牛小工具\word模板\扣税模板.docx"
    arr2["文件名"] := "在"
    arr2["修改时间"] := "等找"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(ByRef txt1,ByRef txt2 :=""){
;------------------------
;引入变量
;global txt1,txt2
;-----------引用变量-------------
;方法二，利用FSO对象
fso:=ComObjCreate("Scripting.FileSystemObject")
f:=fso.GetFile(txt1)

arr2 :=[]
dd := StrSplit(f.DateLastModified," ")
arr2["修改时间"]:=dd[1]
;msgbox % arr2["修改时间"]

SplitPath, % f.Name, , , , xName
;MsgBox % "复制后剪切板内内容：`n" f.Name "`n截取后的文件名：`n" xName
arr2["文件名"]:=xName


return arr2

}




