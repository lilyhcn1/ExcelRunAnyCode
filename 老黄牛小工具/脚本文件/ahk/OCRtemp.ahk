#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
;input1 :="ͼƬ·��"
;input2 := "���ͼƬ"
;input3 := "x"
;input4 := "y"
;input5 := "w"
;input6 := "h"
;input3 := "�����ļ�"
output1 :="ʶ����"
info := "���н��"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
val4 := readjsonconkey(input4)
val5 := readjsonconkey(input5)
val6 := readjsonconkey(input6)
;-------------1.��ȡ�������----------

main()
;FileRead, jsonstr, D:\�ϻ�ţС����\temp\temp.txt,utf-8
jsonstr := utf8readtext("D:\�ϻ�ţС����\ExcelQuery\temp\temp.txt")
;msgbox % jsonstr
arr2[output1] := jsonstr
arr2[info] :="��"


;-------------2.����д�����----------
savearr2json(arr2)

main(){
;------------------------
;�������
global val1,val2,val3,val4,val5,val6
;-----------���ñ���-------------
tesseract := "D:\�ϻ�ţС����\С����\TesseractOCR\tesseract.exe"
runstr := tesseract " D:\�ϻ�ţС����\ExcelQuery\temp\temp.jpg D:\�ϻ�ţС����\ExcelQuery\temp\temp -l chi_sim"

RunWait, %runstr%,,min

}


























