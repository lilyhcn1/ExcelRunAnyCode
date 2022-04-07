Numpad1::Run % "Notepad.exe"


#A::
Loop,1{
CoordMode, Menu, Screen
CoordMode, Mouse, Screen

Menu,MyMenu_482,Add,開啟AHK官網,開啟AHK官網_1_482
Menu,MyMenu_482,Add,
Menu,MyMenu_482,Add,開啟記事本,開啟記事本_2_482
Menu,MyMenu_482,Add,開啟小畫家,開啟小畫家_3_482

MouseGetPos,MX,MY
Menu,MyMenu_482,Show,% MX,% MY
Menu,MyMenu_482,DeleteAll
return

開啟AHK官網_1_482:
    Run % "https://www.autohotkey.com"
return
開啟記事本_2_482:
    Run % "Notepad.exe"
return
開啟小畫家_3_482:
    Run % "mspaint.exe"
return
}
Return


