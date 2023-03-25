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


;V盘搜
run,http://www.vpansou.com/query?wd=%param%
Sleep % 100
;盘么么
run,http://www.panmeme.com/query?key=%param%
Sleep % 100
;56盘
run,https://www.56wangpan.com/search/kw%param%
Sleep % 100
;小马盘
run,https://www.xiaomapan.com/#/main/search?keyword=%param%
Sleep % 100
;罗马盘
run,https://www.luomapan.com/#/main/search?keyword=%param%
Sleep % 100
;来搜一下
run,https://www.laisoyixia.com/s/search?q=%param%
Sleep % 100
;搜盘吧
run,https://www.sopanbar.com/search/kw%param%
Sleep % 100
