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
SET r34tool=老黄牛小工具
SET r34toolpath=d:\%r34tool%
set var=y

color 2 
rem 建立文件夹
if not exist %r34toolpath% (
  mkdir %r34toolpath% >nul
)

rem 备份配置文件
if exist %r34toolpath% (
  @echo ----  老黄牛小工具安装向导  ---- 
  @echo 正在备份配置文件 %r34toolpath%\配置文件\myconf.ini
 copy /Y %r34toolpath%\配置文件\myconf.ini %r34tool%\配置文件\myconf.ini 
)

rem 复制文件夹到d盘
if exist %r34tool% (
   xcopy /e/y/i/f %r34tool% %r34toolpath% >nul
   copy /Y 主控制文件.xlsm %r34toolpath%\主控制文件.xlsm 
   @echo  ---------------------------------------------------
   @echo 相关辅助文件安装完毕。
) else (
   @echo  --------------------------------------------------- 
  @echo “老黄牛小工具”文件夹不存在，复制失败！~请解压后再运行。
  choice /t 9 /d y /n >nul
  exit
)
choice /t 1 /d y /n >nul
rem set /p var=是否安装AutoHotKey,默认y：
if "%var%"=="y" (
  @echo ---------------------------------------------------
  @echo 请手动确认导入注册表！~
  regedit /s D:\老黄牛小工具\小工具\ahk工具\注册ahk.reg
  @echo -- AutoHotKey安装完毕！！
)

choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
@echo 教程地址： https://r34.cc/
@echo 教程地址： https://r34.cc/


choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
@echo 准备打开控制文件
choice /t 3 /d y /n >nul
if "%var%"=="y" (
  start  %r34toolpath%\主控制文件.xlsm
  @echo -- 已打开主控制文件！！
)

choice /t 1 /d y /n >nul
@echo ---------------------------------------------------
rem set /p var=是否打开教程地址？默认y：
choice /t 9 /d y /n >nul
if "%var%"=="y" (
  start  https://r34.cc/
  @echo -- 已打开教程地址！！
)

@echo ---------------------------------------------------
@echo 已完全结束，请尽情使用吧！！
choice /t 19 /d y /n >nul
exit
