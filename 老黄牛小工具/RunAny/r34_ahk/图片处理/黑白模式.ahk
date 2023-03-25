#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
#Include ..\Lib\JSON.ahk
#Include ..\Lib\lilyfun.ahk
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
    inarr["TencentSecretId"] := "AKIDOcaHhqjLgkZ8QRCfrmPntiGXXGitIRJt"
    inarr["TencentsecretKey"] := "LPCizzjCPLzMRGo55oFPIvHM9fvuc7MK"
    inarr["图片地址"] := "D:\\老黄牛小工具\\word模板\\待裁剪图片.jpg"
    inarr["新图片地址"] := "D:\\老黄牛小工具\\ExcelQuery\\temp\\增强图片.jpg"
    inarr[""] := ""
    outarr[""]  :=  ""
    outarr[""]  :=  ""
    outarr[""]  :=  ""
    outarr[""]  :=  ""
    outarr[""]  :=  ""

    fkeyold := "图片地址"
    fkeynew := "新图片地址" 
    updateflag := "y" 

    if (fkeyold!=""){
     inarr[fkeyold] := path
    }

    if (fkeynew!=""){
     inarr[fkeynew] := path
    }

    jbname := "文本图像增强黑白模式" ;脚本的名字等于文件名
    fkeyold := "图片地址"   ;要发送的旧文件的标题行名称
    fkeynew := "新图片地址"   ;要接收的新文件的标题行名称

    ;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
    apiserver := getserverurl()
    ;apiserver := "http://127.0.0.1:8001"
    url := apiserver "/jb/" jbname

    savearr2json(inarr)

    PostCsvAndFile(url,fkeyold,fkeynew)

}


