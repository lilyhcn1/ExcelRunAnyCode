#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("������")
txt2 := readjsonconkey("�����ı�")
;-------------1.��ȡ�������----------
if (txt1 != "" and txt2 !="" ){  ;��������


main(txt1,txt2)
arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["������"] := "�ϻ�ţ"
    arr2["�����ı�"] := "Ҫ���͵��ı�"
    arr2["���н��"] :="�������Ҳ����ؼ��ʣ���ע�⡣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(ByRef ����07,ByRef ����11 :=""){
;------------------------
;�������
global txt1,txt2
;-----------���ñ���-------------

CoordMode, Mouse, Screen
if (x1 > 0) {
}else{
  msgbox % "�������ƣ��˲����кܶ�����������`r`n1.��ʼ���ܶ���ꡣ`r`n2.3���ڽ�����ƶ���������������`r`n3.��Ϣ�����Զ����ͣ�ȷ�����ֶ��س����͡�"
}

TrayTip,,% "����3���ڽ�����ƶ���������"
mousemove,x1, y1 
Sleep % 3000
MouseGetPos, x1, y1 
Send, {LButton}
Send, {Backspace 99}
Sleep % 300
SendInput % "{TEXT}" . ����07
Sleep % 2500
Send, {Enter}
Sleep % 300
Send, {Backspace 99}
Sleep % 300
SendInput % "{TEXT}" . ����11
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 5000
;Send, {Enter}

}




