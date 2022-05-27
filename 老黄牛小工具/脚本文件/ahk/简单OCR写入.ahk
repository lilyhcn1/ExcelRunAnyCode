#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

try{
  ;读取文件
  FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  ;fv := returnfirstvalue(parsed["contents"])
  ;msgbox % fv

  
  ;读取api的结果
  ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
  ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; 高精度识别
  ret:=ocr.GetOcr("D:\老黄牛小工具\ExcelQuery\temp\temp.jpg","general_basic")							; 普通精度识别





}catch{
  temparr["运行结果"] :="哪个地方出错了，请注意！"
}

n=0
for k,v in JSON.Load(ret).words_result{
  if(n=0){
  temparr["识别结果"] :=  v.words
  }else{
  temparr["识别结果"] :=  temparr["识别结果"] "`n" v.words
  }
n=n+1
}
;-- 获取COM对象
objExcel:=Excel_Get()

;-- 用鼠标先点击要操作的目标行的最右边的空白单元格

;-- 获取当前激活的单元格的行号（y）、列号（x）
y:=objExcel.ActiveCell.Row
x:=objExcel.ActiveCell.Column


;-- 在当前激活的单元格写入ok表示本行已经操作过，并激活下方的单元格
objExcel.Cells(y,x).Value:= temparr["识别结果"] 


;savearr2json(temparr)






;======== 下面是函数 ========


;-- 将对象数据写入记录文件，记录文件在AHK主程序目录中
WriteLog(arr)
{
  static f:=A_AhkPath . "\..\操作记录.txt"
  s:=""
  For k,v in arr
    s.=A_Index=1 ? v : A_Tab . v
  s:=A_Now . A_Tab . StrReplace(s,"`r") . "`n"
  FileAppend, %s%, %f%
}

;-- 获取Excel窗口的COM对象  By FeiYue
Excel_Get(WinTitle="ahk_class XLMAIN")
{
  static obj
  Try
    if (obj.Version)
      return obj
  return obj:=Office_Get(WinTitle)
}

;-- 获取所有Office窗口的COM对象  By FeiYue
Office_Get(WinTitle="")
{
  static h:=DllCall("LoadLibrary", "Str","oleacc", "Ptr")
  WinGet, list, ControlListHwnd, % WinTitle ? WinTitle : "A"
  For i,hWnd in StrSplit(list, "`n")
  {
    ControlGetPos, x, y, w, h,, ahk_id %hWnd%
    if (y<10 or w<100 or h<100)
      Continue
    if DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd
    , "UInt", 0xFFFFFFF0, "Ptr", 0*(VarSetCapacity(IID,16)
    +NumPut(0x0000000000020400,IID,"Int64")
    +NumPut(0x46000000000000C0,IID,8,"Int64"))+&IID, "Ptr*", pacc)=0
    {
      Acc:=ComObject(9, pacc, 1)
      Try
        if (Acc.Application.Version)
          return Acc.Application
    }
  }
  MsgBox, 4096,, Error: Can't Get Object From ACC !
  Exit
}


















