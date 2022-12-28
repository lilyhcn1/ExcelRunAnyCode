rem ------  11  ------
Gui, Add, Button, x10 y10 w110 h40 , 文件管理菜单
rem ------  12  ------
Gui, Add, Button, x130 y10 w110 h40 , 高级常用菜单
rem ------  13  ------
Gui, Add, Button, x250 y10 w110 h40 , 高级全部菜单
rem ------  14  ------
Gui, Add, Button, x370 y10 w110 h40 , -
rem ------  21  ------
Gui, Add, Button, x10 y60 w110 h40 , -
rem ------  22  ------
Gui, Add, Button, x130 y60 w110 h40 , -
rem ------  23  ------
Gui, Add, Button, x250 y60 w110 h40 , -
rem ------  24  ------
Gui, Add, Button, x370 y60 w110 h40 , -
rem ------  31  ------
Gui, Add, Button, x10 y110 w110 h40 , -
rem ------  32  ------
Gui, Add, Button, x130 y110 w110 h40 , -
rem ------  33  ------
Gui, Add, Button, x250 y110 w110 h40 , -
rem ------  34  ------
Gui, Add, Button, x370 y110 w110 h40 , -

Gui, Show, x300 y200 h160 w490, 通用功能界面
Return
GuiClose:
ExitApp
newnemu(mu){
  bf = D:\老黄牛小工具\Excel插件
  jsonpaths = %bf%\res\menu\%mu%.json
  jsonpathd = %bf%\res\list.json
  xmlpaths = %bf%\res\menu\%mu%.xml    
  xmlpathd = %bf%\res\RibbonTemplate.xml    
  FileCopy, %jsonpaths%, %jsonpathd% , 1
  FileCopy, %xmlpaths%, %xmlpathd% , 1
  msgbox,菜单切换完成，请手动重启表格。
}
;空行
;空行
Button文件管理菜单:
  aa = %A_GuiControl%
  newnemu(aa)
return
Button高级常用菜单:
  aa = %A_GuiControl%
  newnemu(aa)
return
Button高级全部菜单:
  aa = %A_GuiControl%
  newnemu(aa)
return
