@echo off
SET r34tool=�ϻ�ţС����
SET r34toolpath=d:\%r34tool%

color 2 
rem �����ļ���
if not exist %r34toolpath% (
  mkdir %r34toolpath% >nul
)

rem ���������ļ�
if exist %r34toolpath% (
 @echo ���ڱ��������ļ� %r34toolpath%\�����ļ�\myconf.ini
 copy /Y %r34toolpath%\�����ļ�\myconf.ini %r34tool%\�����ļ�\myconf.ini 
)

rem �����ļ��е�d��
if exist %r34tool% (
   xcopy /e/y/i/f %r34tool% %r34toolpath% >nul
   @echo  ----------------
   @echo ��ظ����ļ���װ��ϡ�
   @echo ��ظ����ļ���װ��ϡ�
   @echo ��ظ����ļ���װ��ϡ�
   @echo ��ظ����ļ���װ��ϡ�
   
   
) else (
  @echo "�ļ��в����ڣ����ѹ�������С�"
)

@echo  ----------------
@echo �ȴ�9����Զ��رա�
choice /t 9 /d y /n >nul