#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("����")
txt2 := "��"
;-------------1.��ȡ�������----------
if (txt1 != "" and txt2 !="" ){  ;��������


main(txt1,txt2)
arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["����"] := "�ϻ�ţ"
    ;arr2["�����ı�"] := "Ҫ���͵��ı�"
    arr2["���н��"] :="�������Ҳ����ؼ��ʣ���ע�⡣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(ByRef ����01,ByRef ����11 :=""){
;------------------------
;�������
global txt1,txt2
;-----------���ñ���-------------

;---------------- ����01 -----------------
if (flag <> 1) {
  msgbox % "����ѡ�ò������棬�����ȷ�ϡ���3�����в�����"
  TrayTip,,% "��3���ڽ�����ƶ���ָ��������"
  Sleep % 2000
  flag := 1
}
;�����ɾ��ԭ������
Click %x1%, %y1%, 1
Sleep % 500
;��������
SendInput % "{TEXT}" . ����01
Sleep % 4000
;����س�
Send, {Enter}
Sleep % 500
}




