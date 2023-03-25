#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
#Include D:\老黄牛小工具\RunAny\r34_ahk\Lib\JSON.ahk
#Include D:\老黄牛小工具\RunAny\r34_ahk\Lib\lilyfun.ahk
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive

argarr := [],n = 0  ;获取传到的值到argarr
path := "empty"
Loop, %0%{
  argarr[n++] := %A_Index%
  path := %A_Index%
  if not FileExist(path){
     msgbox, 【%path%】文件存在空格等，请修改文件名后再试！~
     exitapp
  }
}

if (path=="empty"){
 msgbox, "请拖动文件到脚本上。"
 exitapp
}
For key, path in argarr{

    inarr:=[]
    outarr:=[]
    inarr["模糊图片地址"] := "D:\\老黄牛小工具\\word模板\\笑脸.jpg"
    inarr["清晰图片地址"] := "D:\\老黄牛小工具\\ExcelQuery\\temp\\清晰图片.jpg"
    inarr[""] := ""
    inarr[""] := ""
    inarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""

    fkeyold := "模糊图片地址"   ;要发送的旧文件的标题行名称
    fkeynew := "清晰图片地址"   ;要接收的新文件的标题行名称
    inarr["模糊图片地址"] := arrupdatefromconfigini(inarr["模糊图片地址"], "ApiKeys", "模糊图片地址") 
    inarr["清晰图片地址"] := arrupdatefromconfigini(inarr["清晰图片地址"], "ApiKeys", "清晰图片地址") 
    if (fkeyold!=""){
     inarr[fkeyold] := path
    }

    if (fkeynew!=""){
     inarr[fkeynew] := path
    }

    jbname := "图片变清晰" ;脚本的名字等于文件名
    fkeyold := "模糊图片地址"   ;要发送的旧文件的标题行名称
    fkeynew := "清晰图片地址"   ;要接收的新文件的标题行名称

    ;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
    url := getjburl(jbname)


    savearr2json(inarr)

    PostCsvAndFile(url,fkeyold,fkeynew)

}
