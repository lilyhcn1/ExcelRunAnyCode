fd :="D:\�ϻ�ţС����\������������Ӧ��\[���ⰲװ]������ַ��������װ����\����ļ�\�����ļ�Э�鰲װ"

FileCopy, %A_WorkingDir%\�ֶ���װ\start.exe, %fd%\start.exe
FileCreateDir %fd%
run,%A_WorkingDir%\�ֶ���װ\�����Э��.reg

;if FileExist(%fd%"\start.exe"){
;    MsgBox, At least one .txt file exists.
;}else{
;    MsgBox, error
;}

sleep 5000

msgbox,% "��װ���~"