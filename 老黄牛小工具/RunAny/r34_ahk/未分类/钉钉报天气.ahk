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
    inarr["zzd_access_token"] := "GetFromIni"
    inarr["zzd_sign"] := "GetFromIni"
    inarr[""] := ""
    inarr[""] := ""
    inarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""
    outarr[""] := ""

    fkeyold := ""   ;要发送的旧文件的标题行名称
    fkeynew := ""   ;要接收的新文件的标题行名称
    inarr["zzd_access_token"] := arrupdatefromconfigini(inarr["zzd_access_token"], "ApiKeys", "zzd_access_token") 
    inarr["zzd_sign"] := arrupdatefromconfigini(inarr["zzd_sign"], "ApiKeys", "zzd_sign") 
    if (fkeyold!=""){
     inarr[fkeyold] := path
    }

    if (fkeynew!=""){
     inarr[fkeynew] := path
    }

    jbname := "钉钉报天气" ;脚本的名字等于文件名
    fkeyold := ""   ;要发送的旧文件的标题行名称
    fkeynew := ""   ;要接收的新文件的标题行名称

    ;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
    url := getjburl(jbname)


    savearr2json(inarr)

    PostCsvAndFile(url,fkeyold,fkeynew)

}
