;打开群，分享链接。请一定要先配置D:\老黄牛小工具\配置文件\myconf.ini
#Include %A_LineFile%\..\JSON.ahk
;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := parsed["outputfile"]
if(fv=error)then{
  Loop %0%{  ; 获取传参的长文件名
      GivenPath := %A_Index%  ; 获取下一个命令行参数.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
  PathToCopy:=LongPath  
}else{
  PathToCopy :=fv
}


WinShow,浙政钉 ahk_class StandardFrame_DingTalkGov
WinActivate,浙政钉 ahk_class StandardFrame_DingTalkGov
