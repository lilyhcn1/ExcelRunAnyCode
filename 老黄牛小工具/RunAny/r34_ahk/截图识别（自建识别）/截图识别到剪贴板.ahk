;���Ƿ������ĵ�ַ�����ֶ��޸�
apiserver := "http://api1.r34.cc"
sleep,1000
;��ͼ�����棬Ҫ��ʱ�ļ�
nowpath =%A_ScriptDir%
toolpath := nowpath "\Lib\"
tempjpg := toolpath "temp.jpg"
temptxt := toolpath "temp.txt"

#Include ..\Lib\Gdipѡ���ͼ.ahk

ѡ�򲢽�ͼ(tempjpg)

;-----------------------------api����------------------------

#SingleInstance, Force
#Include ..\Lib\JSON.ahk
#Include ..\Lib\lilyfun.ahk

SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
jbname := "ocr" ;�ű������ֵ����ļ���
fkeyold := "ͼƬ��ַ"   ;Ҫ���͵ľ��ļ��ı���������
fkeynew := ""   ;Ҫ���յ����ļ��ı���������
;����post��Ϣ�����أ�����ǳ�����,Ϊ�������ļ�������lilyfun��
;apiserver := getserverurl()

url := apiserver "/jb/" jbname

arr := []
arr["ͼƬ��ַ"] := tempjpg

;"E:\�ϻ�ţ��C���ĵ�\C������\11.png"  "D:\�ϻ�ţС����\wordģ��\��Ʊ.jpg"
arr2 := arr2excelarr(arr)

json64 := Postarr(url, arr2,fkeyold,fkeynew)


jsonarr := json.load(b64Decode(json64))

temp := jsonarr.contents.ʶ����
clipboard = %temp%
tr("�Ѹ��Ƶ�������")

exitapp

