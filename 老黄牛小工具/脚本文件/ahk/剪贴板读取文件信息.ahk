
#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := clipboard
txt2 := "无"
;-------------1.读取输入变量----------
if (txt1 != "" and txt2 !="" ){  ;正常运行


arr2:=main(txt1,txt2)


arr2["运行结果"] :="√"

}else{  ;出错后的处理
    arr2["文件路径"] := "D:\老黄牛小工具\word模板\扣税模板.docx"
    arr2["文件名"] := "待返回"
    arr2["修改时间"] := "待返回"
    arr2["运行结果"] :="标题行找不到关键词，请注意。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(ByRef txt1,ByRef txt2 :=""){
;------------------------
;引入变量
;global txt1,txt2
;-----------引用变量-------------

if FileExist( txt1 ){
    ;方法二，利用FSO对象
    fso:=ComObjCreate("Scripting.FileSystemObject")
    f:=fso.GetFile(txt1)

    arr2 :=[]
    dd := StrSplit(f.DateLastModified," ")
    arr2["文件路径"] := txt1
    arr2["修改时间"]:=dd[1]
    

    SplitPath, % f.Name, , , , xName
    ;MsgBox % "复制后剪切板内内容：`n" f.Name "`n截取后的文件名：`n" xName
    arr2["文件名"]:=xName


    return arr2
}else{
	msgbox, 请先复制文件到剪贴板
}




}




