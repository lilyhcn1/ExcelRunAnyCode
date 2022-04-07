set nowpath=%~dp0
%nowpath%/nconvert -out png -clipboard -overwrite -o  %USERPROFILE%\Desktop\temp.png
start %USERPROFILE%\Desktop
choice /t 1 /d y /n >nul