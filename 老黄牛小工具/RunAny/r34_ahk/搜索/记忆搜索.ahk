#SingleInstance, Force
SetWorkingDir %A_ScriptDir%

Loop, %0%
{
    param := %A_Index%
    msgbox, %param%
    inputpath := param

}
msgbox, %param%
exitapp
;aa = %clipboard%
;if(aa <>"" && param =""){
;param = %aa%
;}
url = http://192.168.7.69/index.php/Qwadmin/Vi/uniquerydata/rpw/CGATY5L562/sheetname/台州学院公开信息数据库/name/%param%
;msgbox, %url%
run, %url%
;Run, msedge.exe --window-size=800`,600 --app=%url%

