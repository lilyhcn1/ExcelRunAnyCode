@echo off
SET r34tool=老黄牛小工具
SET r34toolpath=d:\%r34tool%

color 2 
rem 建立文件夹
if not exist %r34toolpath% (
  mkdir %r34toolpath% >nul
)

rem 备份配置文件
if exist %r34toolpath% (
 @echo 正在备份配置文件 %r34toolpath%\配置文件\myconf.ini
 copy /Y %r34toolpath%\配置文件\myconf.ini %r34tool%\配置文件\myconf.ini 
)

rem 复制文件夹到d盘
if exist %r34tool% (
   xcopy /e/y/i/f %r34tool% %r34toolpath% >nul
   @echo  ----------------
   @echo 相关辅助文件安装完毕。
   @echo 相关辅助文件安装完毕。
   @echo 相关辅助文件安装完毕。
   @echo 相关辅助文件安装完毕。
   
   
) else (
  @echo "文件夹不存在，请解压后再运行。"
)

@echo  ----------------
@echo 等待9秒后自动关闭。
choice /t 9 /d y /n >nul