#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
argarr := [],n = 0  ;获取传到的值到argarr
Loop, %0%{
  argarr[n++] := %A_Index%
}
jbname := name_no_ext ;脚本的名字等于文件名

fkeyold := "模板路径"   ;要发送的旧文件的标题行名称
fkeynew := "生成文件路径"   ;要接收的新文件的标题行名称
;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
url := GetApiUrl(jbname)
;msgbox % url
PostCsvAndFilearr(url,fkeyold,fkeynew,argarr)

