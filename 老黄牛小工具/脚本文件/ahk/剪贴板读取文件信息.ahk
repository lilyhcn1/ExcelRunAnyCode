
#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

clipboard=%clipboard% ;windows ���Ƶ�ʱ�򣬼����屣����ǡ�·������ֻ��·�������ַ�����ֻҪת�����ַ����Ϳ���ճ��������

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
txt1 := clipboard
txt2 := "��"
;-------------1.��ȡ�������----------
if (txt1 != "" and txt2 !="" ){  ;��������


arr2:=main(txt1,txt2)


arr2["���н��"] :="��"

}else{  ;�����Ĵ���
    arr2["�ļ�·��"] := "D:\�ϻ�ţС����\wordģ��\��˰ģ��.docx"
    arr2["�ļ���"] := "������"
    arr2["�޸�ʱ��"] := "������"
    arr2["���н��"] :="�������Ҳ����ؼ��ʣ���ע�⡣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(ByRef txt1,ByRef txt2 :=""){
;------------------------
;�������
;global txt1,txt2
;-----------���ñ���-------------

if FileExist( txt1 ){
    ;������������FSO����
    fso:=ComObjCreate("Scripting.FileSystemObject")
    f:=fso.GetFile(txt1)

    arr2 :=[]
    dd := StrSplit(f.DateLastModified," ")
    arr2["�ļ�·��"] := txt1
    arr2["�޸�ʱ��"]:=dd[1]
    

    SplitPath, % f.Name, , , , xName
    ;MsgBox % "���ƺ���а������ݣ�`n" f.Name "`n��ȡ����ļ�����`n" xName
    arr2["�ļ���"]:=xName


    return arr2
}else{
	msgbox, ���ȸ����ļ���������
}




}




