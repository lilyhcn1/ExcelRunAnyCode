#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := readjsonconkey("΢����")
txt2 := readjsonconkey("�����ı�")
;-------------1.��ȡ�������----------
if (txt1 != "" and txt2 !="" ){  ;��������


main()
arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["΢����"] := "�ϻ�ţ"
    arr2["�����ı�"] := "Ҫ���͵��ı�"
    arr2["���н��"] :="�������Ҳ����ؼ��ʣ���ע�⡣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(){
;------------------------
;�������
global txt1,txt2
;-----------���ñ���-------------

WinShow,΢�� ahk_class WeChatMainWndForPC
WinActivate,΢�� ahk_class WeChatMainWndForPC
Sleep,300
Send ^f
Sleep,200
Send {text} %txt1%

Sleep,1500
Send {Enter}
Sleep 500
SendInput % "{TEXT}" . txt2

Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 5000
;Send {Enter}

}




