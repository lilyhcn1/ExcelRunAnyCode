#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="΢����"
input2 := "�����ı�"
input3 := "�����ļ�"
info := "���н��"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
;-------------1.��ȡ�������----------
if (val1 != "" ){  ;��������

main()
arr2[info] :="��"

}else{  ;�����Ĵ���
    arr2[input1] := "�ϻ�ţ"
    arr2[input2] := "Ҫ���͵��ı�"
    arr2[input3] := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.json"    
    
    arr2[info] := "�������Ҳ����ؼ��ʡ�" input1 "����Ϊ�գ����顣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(){
;------------------------
;�������
global val1,val2,val3
;-----------���ñ���-------------

FileToClipboard(val3)
WinShow,΢�� ahk_class WeChatMainWndForPC
WinActivate,΢�� ahk_class WeChatMainWndForPC
Sleep,300
Send ^f
Sleep,200
Send {text} %val1%
Sleep,1500
OutputDebug, "�ҵ�"
Send {Enter}
OutputDebug, "����"
Sleep 1000
OutputDebug,  "ճ��"
Send ^v
Sleep 1000
Send {Enter}
Sleep 2000
SendInput % "{TEXT}" . val2
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 100
Send {Enter}

}

 
GetFullPath(fpath)
{
 Loop, %fpath%
  Return, A_LoopFileLongPath
}



