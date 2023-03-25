#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

exe := checkandgetpath("nconvert")

InputBox, picsize,  图片缩小工具,    图片的横向尺寸缩小至。, , , , , , , , 1920

Loop, %0%
{
    param := %A_Index%
    inputpath := param
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\%name_no_ext%.%ext%
    ;msgbox % inputpath
    if(ext="png"){
        runstr = %exe%  -quiet -overwrite -out png -ratio -resize %picsize%  0 "%inputpath%"
    }else if (ext="gif"){
        runstr = %exe%  -quiet -overwrite -out gif -ratio -resize %picsize%  0 "%inputpath%"
    }else{
        runstr = %exe%  -quiet -overwrite -out jpeg -ratio -resize %picsize%  0 "%inputpath%"
    }
    
    ;startstr(runstr)
    ;msgbox % exestr
    runwait, %runstr%, , min
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}




