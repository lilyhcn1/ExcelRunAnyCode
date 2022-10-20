#SingleInstance, Force

#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


mu = 高级菜单

newnemu(mu)
msgbox, 插件切换完毕，手动重启Excel.


newnemu(mu){
bf = D:\老黄牛小工具\Excel插件

jsonpaths = %bf%\res\menu\%mu%.json
jsonpathd = %bf%\res\list.json

xmlpaths = %bf%\res\menu\%mu%.xml    
xmlpathd = %bf%\res\RibbonTemplate.xml    
FileCopy, %jsonpaths%, %jsonpathd% , 1
FileCopy, %xmlpaths%, %xmlpathd% , 1
}


