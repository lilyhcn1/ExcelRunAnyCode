
set srcpath="%~1"
set filename="老黄牛小工具(请选择D盘并解压)"

set 7zpath=%~dp0/7z.exe


del %filename%.7z
del %filename%.exe
echo %srcpath%
%7zpath% a %filename%.7z "%srcpath%\*" -r -mx -mf=BCJ2
copy /b 7z.sfx + config.txt + %filename%.7z %filename%.exe
pause