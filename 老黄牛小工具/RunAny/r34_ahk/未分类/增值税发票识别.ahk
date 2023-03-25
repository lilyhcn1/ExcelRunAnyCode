#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
#Include D:\老黄牛小工具\RunAny\r34_ahk\Lib\JSON.ahk
#Include D:\老黄牛小工具\RunAny\r34_ahk\Lib\lilyfun.ahk
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;脚本的名字等于文件名
url := getjburl(jbname) ;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
;msgbox % url

args = %0%
if(args=0){
  PostCsvAndFile(url,fkeyold,fkeynew)
}else{



    inarr:=[]
    outarr:=[]
    inarr["TencentSecretId"] := "GetFromIni"
    inarr["TencentsecretKey"] := "GetFromIni"
    inarr["图片地址"] := "D:\\老黄牛小工具\\word模板\\发票.jpg"
    inarr[""] := ""
    inarr[""] := ""
    outarr["销售方识别号"] := "待返回"
    outarr["销售方名称"] := "待返回"
    outarr["金额"] := "待返回"
    outarr["货物或应税劳务、服务名称"] := "待返回"
    outarr["识别返回键值"] := "待返回"

    fkeyold := "图片地址"   ;要发送的旧文件的标题行名称
    fkeynew := ""   ;要接收的新文件的标题行名称
  Loop, %args%{
        param := %A_Index%
        inputpath := param
        arr := []
        ;msgbox,"======="
        if FileExist(param){
          SplitPath, param, name, dir, ext, name_no_ext, drive
          path :=  inputpath
          if (fkeyold!=""){
           inarr[fkeyold] := path
          }
          if (fkeynew!=""){
           inarr[fkeynew] := path
          }
        }else{
          inkey :=returnfirstkey(inarr)
          ;msgbox % inkey
          outkey :=returnfirstkey(outarr) 
           inarr[inkey] := param 
        }
        a := savearr2json(inarr)
        ;msgbox,==
        PostCsvAndFile(url,fkeyold,fkeynew)
      if(fkeynew=""){
        arr :=readjsonarr()
        for key, val in arr{
          ;msgbox % "key is " key " val is " val
          if(key!="执行结果"){
            r:= val " " r
          }
        }
        clipandtemp(r)
        }  
    }
}
