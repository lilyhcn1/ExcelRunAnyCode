#SingleInstance, Force
SetWorkingDir %A_ScriptDir%

Loop, %0%
{
    param := %A_Index%
    inputpath := param

}
aa = %clipboard%
if(aa <>"" && param =""){
param = %aa%
}


;盒子部落
run,https://www.hezibuluo.com/?s=%param%
Sleep % 100
;果核剥壳
run,https://www.ghxi.com/?s=%param%
Sleep % 100
;亿破姐
run,https://www.ypojie.com/?s=%param%
Sleep % 100
;微当下载
run,https://www.weidown.com/?q=%param%
Sleep % 100
;辅助狗
run,https://www.fuzhugou.com/find/%param%
Sleep % 100
;大眼仔旭
run,http://www.dayanzai.me/?s=%param%
Sleep % 100
;软件仓库
run,https://www.ruancang.net/#/sim?q=%param%
Sleep % 100