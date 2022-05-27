#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <Class_bdocr>
SetWorkingDir %A_ScriptDir%

temparr := []
  BaiduAPIKey1 := readini("ApiKeys","BaiduAPIKey1")
  BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")

try{
  ;��ȡ�ļ�
  FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  ;fv := returnfirstvalue(parsed["contents"])
  ;msgbox % fv

  
  ;��ȡapi�Ľ��
  ocr:=new bdocr(BaiduAPIKey1, BaiduSecretKey1)
  ;ret:=ocr.GetOcr(A_ScriptDir "\3.png","accurate_basic")	; �߾���ʶ��
  ret:=ocr.GetOcr("D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg","general_basic")							; ��ͨ����ʶ��





}catch{
  temparr["���н��"] :="�ĸ��ط������ˣ���ע�⣡"
}

n=0
for k,v in JSON.Load(ret).words_result{
  if(n=0){
  temparr["ʶ����"] :=  v.words
  }else{
  temparr["ʶ����"] :=  temparr["ʶ����"] "`n" v.words
  }
n=n+1
}
;-- ��ȡCOM����
objExcel:=Excel_Get()

;-- ������ȵ��Ҫ������Ŀ���е����ұߵĿհ׵�Ԫ��

;-- ��ȡ��ǰ����ĵ�Ԫ����кţ�y�����кţ�x��
y:=objExcel.ActiveCell.Row
x:=objExcel.ActiveCell.Column


;-- �ڵ�ǰ����ĵ�Ԫ��д��ok��ʾ�����Ѿ����������������·��ĵ�Ԫ��
objExcel.Cells(y,x).Value:= temparr["ʶ����"] 


;savearr2json(temparr)






;======== �����Ǻ��� ========


;-- ����������д���¼�ļ�����¼�ļ���AHK������Ŀ¼��
WriteLog(arr)
{
  static f:=A_AhkPath . "\..\������¼.txt"
  s:=""
  For k,v in arr
    s.=A_Index=1 ? v : A_Tab . v
  s:=A_Now . A_Tab . StrReplace(s,"`r") . "`n"
  FileAppend, %s%, %f%
}

;-- ��ȡExcel���ڵ�COM����  By FeiYue
Excel_Get(WinTitle="ahk_class XLMAIN")
{
  static obj
  Try
    if (obj.Version)
      return obj
  return obj:=Office_Get(WinTitle)
}

;-- ��ȡ����Office���ڵ�COM����  By FeiYue
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


















