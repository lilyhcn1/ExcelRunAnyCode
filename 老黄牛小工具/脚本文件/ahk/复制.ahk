#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="�ļ�·��"
input2 := "���ļ�·��"

;input3 := "�����ļ�"
info := "���н��"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
;val3 := readjsonconkey(input3)

;-------------1.��ȡ�������----------
if (val1 != "" ){  ;��������

main()
arr2[info] :="��"

}else{  ;�����Ĵ���
    arr2[input1] := "D:\�ϻ�ţС����\wordģ��\���ü�ͼƬ.jpg"
    arr2[input2] := "���ļ���\���ü�ͼƬ.jpg"

               
    arr2[info] := "�������Ҳ����ؼ��ʡ�" input1 "����Ϊ�գ����顣"
}

;-------------2.����д�����----------
savearr2json(arr2)


main(){
;------------------------
;�������
global val1,val2,val3,val4,val5,val6
;-----------���ñ���-------------

;��ȡ�ļ�
  ;��ȡ�ļ�

path:=val1
newpath := getwholepath(val2) ;��ȡ����·��

creatfolderbyfile(newpath)
FileCopy, %path%, %newpath%


}






















