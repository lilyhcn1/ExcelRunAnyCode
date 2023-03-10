#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := "图片变清晰API" ;脚本的名字等于文件名

fkeyold := "模糊图片地址"   ;要发送的旧文件的标题行名称
fkeynew := "清晰图片地址"   ;要接收的新文件的标题行名称
apiserver := "http://nat.r34.cc:8005" ;apiserver := getserverurl()
url := apiserver "/jb/" jbname

args = %0%
if(args=0){
  ;msgbox,无参数
  PostCsvAndFile(url,fkeyold,fkeynew)
}else{
  ;msgbox,有参数
  Loop, %args%{
      param := %A_Index%
      inputpath := param
      arr := []
      SplitPath, param, name, dir, ext, name_no_ext, drive
      outputpath :=  inputpath
      arr[fkeyold] := inputpath
      arr[fkeynew] := outputpath
      a := savearr2json(arr)
      PostCsvAndFile(url,fkeyold,fkeynew)
      tr(name "转换结束！")
  }

}
tr("全部优化成功！")




