#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
SplitPath, A_ScriptName, name, dir, ext, name_no_ext, drive
jbname := name_no_ext ;�ű������ֵ����ļ���

fkeyold := ""   ;Ҫ���͵ľ��ļ��ı���������
fkeynew := ""   ;Ҫ���յ����ļ��ı���������

;����post��Ϣ�����أ�����ǳ�����,Ϊ�������ļ�������lilyfun��
apiserver := getserverurl()
url := apiserver "/jb/" jbname
PostCsvAndFile(url,fkeyold,fkeynew)

