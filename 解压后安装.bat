@ECHO OFF
REM  QBFC Project Options Begin
REM  HasVersionInfo: No
REM Companyname: 
REM Productname: 
REM Filedescription: 
REM Copyrights: 
REM Trademarks: 
REM Originalname: 
REM Comments: 
REM Productversion:  0. 0. 0. 0
REM Fileversion:  0. 0. 0. 0
REM Internalname: 
REM ExeType: consoleold
REM Architecture: x86
REM Appicon: r34.ico
REM AdministratorManifest: No
REM  QBFC Project Options End
@ECHO ON
@echo off
SET r34tool=�ϻ�ţС����
SET r34toolpath=d:\%r34tool%
set var=y

color 2 
rem �����ļ���
if not exist %r34toolpath% (
  mkdir %r34toolpath% >nul
)

rem ���������ļ�
if exist %r34toolpath% (
  @echo ----  �ϻ�ţС���߰�װ��  ---- 
  @echo ���ڱ��������ļ� %r34toolpath%\�����ļ�\myconf.ini
 copy /Y %r34toolpath%\�����ļ�\myconf.ini %r34tool%\�����ļ�\myconf.ini 
)

rem �����ļ��е�d��
if exist %r34tool% (
   xcopy /e/y/i/f %r34tool% %r34toolpath% >nul
   copy /Y �������ļ�.xlsm %r34toolpath%\�������ļ�.xlsm 
   @echo  ---------------------------------------------------
   @echo ��ظ����ļ���װ��ϡ�
) else (
   @echo  --------------------------------------------------- 
  @echo ���ϻ�ţС���ߡ��ļ��в����ڣ�����ʧ�ܣ�~���ѹ�������С�
  choice /t 9 /d y /n >nul
  exit
)
choice /t 1 /d y /n >nul
rem set /p var=�Ƿ�װAutoHotKey,Ĭ��y��
if "%var%"=="y" (
  @echo ---------------------------------------------------
  @echo ���ֶ�ȷ�ϵ���ע���~
  regedit /s D:\�ϻ�ţС����\С����\ahk����\ע��ahk.reg
  @echo -- AutoHotKey��װ��ϣ���
)

choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
@echo �̵̳�ַ�� https://r34.cc/
@echo �̵̳�ַ�� https://r34.cc/


choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
@echo ׼���򿪿����ļ�
choice /t 3 /d y /n >nul
if "%var%"=="y" (
  start  %r34toolpath%\�������ļ�.xlsm
  @echo -- �Ѵ��������ļ�����
)

choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
rem set /p var=�Ƿ�򿪽̵̳�ַ��Ĭ��y��
choice /t 9 /d y /n >nul
if "%var%"=="y" (
  start  https://r34.cc/
  @echo -- �Ѵ򿪽̵̳�ַ����
)

@echo ---------------------------------------------------
@echo ����ȫ�������뾡��ʹ�ðɣ���
choice /t 19 /d y /n >nul
exit
