#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

ffmpeg := checkandgetpath("ffmpeg")
s :=""
n := 0
Loop, %0%
{
    param := %A_Index%
    inputpath := param
    
    SplitPath, param, name, dir, ext, name_no_ext, drive
    outputpath =  %dir%\img%n%.%ext%
    FileCopy, %inputpath%, %outputpath% , 1
    n := n + 1
    ;%ffexe% -i "%inputpath%" -y -acodec libmp3lame -aq 0 "%outputpath%"
}
;msgbox % param
InputBox, tt,持继时间,请输入图片持继的时间，建议30秒！   图片必须为0.jpg，1.jpg，2.jpg，……, , , , , , , , 30
SplitPath, param, name, dir, ext, name_no_ext, drive

    tempexe = %ffmpeg% -r 1/%tt% -i "%dir%\img`%d.%ext%"  "%dir%\新视频.avi"
    ;ffmpeg -r 0.1 -i "快照%%2d.png" video.avi -y
    ; tempexe = %ffmpeg% -framerate 1/5 -i "%inputpath%"  -vcodec libx264  -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2"   -y -an "%outputts%"
    ; ffmpeg -f image2 -i path_to_img_dir/image_%d.jpg vid.mp4
    ;startstr(tempexe)
    runwait,%tempexe%, , Min
    FileDelete,  %dir%\img*.*



