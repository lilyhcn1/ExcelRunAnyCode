Numpad1::Run % "Notepad.exe"


#A::
Loop,1{
CoordMode, Menu, Screen
CoordMode, Mouse, Screen

Menu,MyMenu_482,Add,�_��AHK�پW,�_��AHK�پW_1_482
Menu,MyMenu_482,Add,
Menu,MyMenu_482,Add,�_��ӛ�±�,�_��ӛ�±�_2_482
Menu,MyMenu_482,Add,�_��С����,�_��С����_3_482

MouseGetPos,MX,MY
Menu,MyMenu_482,Show,% MX,% MY
Menu,MyMenu_482,DeleteAll
return

�_��AHK�پW_1_482:
    Run % "https://www.autohotkey.com"
return
�_��ӛ�±�_2_482:
    Run % "Notepad.exe"
return
�_��С����_3_482:
    Run % "mspaint.exe"
return
}
Return


