#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="ͼƬ·��"
input2 := "���ͼƬ"
input3 := "x"
input4 := "y"
input5 := "w"
input6 := "h"
;input3 := "�����ļ�"
info := "���н��"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
val4 := readjsonconkey(input4)
val5 := readjsonconkey(input5)
val6 := readjsonconkey(input6)
;-------------1.��ȡ�������----------
if (val1 != "" ){  ;��������

main()
arr2[info] :="��"

}else{  ;�����Ĵ���
    arr2[input1] := "D:\�ϻ�ţС����\wordģ��\���ü�ͼƬ.jpg"
    arr2[input2] := "D:\�ϻ�ţС����\temp\temp.jpg"
    arr2[input3] := "500"
    arr2[input4] := "60"
    arr2[input5] := "225"
    arr2[input6] := "55"
                
    
    arr2[info] := "�������Ҳ����ؼ��ʡ�" input1 "����Ϊ�գ����顣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(){
;------------------------
;�������
global val1,val2,val3,val4,val5,val6
;-----------���ñ���-------------
nconvert := "D:\�ϻ�ţС����\С����\��СͼƬnconvert\nconvert.exe"
runstr := nconvert " -out jpeg -quiet -overwrite  -crop " val3 " " val4 " " val5 " " val6 " -o " val2 " " val1
;msgbox % runstr
Run, %runstr%,,min

}
