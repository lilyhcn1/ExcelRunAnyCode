#Include D:\�ϻ�ţС����\�ű��ļ�\ahk\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%


Gui, Add, Button, x10 y10 w110 h40 , ��ʱ�ļ�����
Gui, Add, Button, x130 y10 w110 h40 , �洢��֪������
Gui, Add, Button, x250 y10 w110 h40 , 
Gui, Add, Button, x370 y10 w110 h40 , 
Gui, Add, Button, x10 y60 w110 h40 , ΢�Ŵ洢Ǩ��
Gui, Add, Button, x130 y60 w110 h40 , QQ�洢Ǩ��
Gui, Add, Button, x250 y60 w110 h40 , �鿴���ļ�
Gui, Add, Button, x370 y60 w110 h40 , 
Gui, Add, Button, x10 y110 w110 h40 , �����ڴ�ת��
Gui, Add, Button, x130 y110 w110 h40 , 
Gui, Add, Button, x250 y110 w110 h40 , 
Gui, Add, Button, x370 y110 w110 h40 , ��������

Gui, Show, x300 y200 h160 w490, ͨ�ù��ܽ���
Return
GuiClose:
ExitApp
newnemu(mu){
  msgbox,%mu%
}
;����
;����
Button��ʱ�ļ�����:
  ;exe := checkandgetpath("WinSCP")
  run, C:\Windows\System32\cleanmgr.exe
return
Button΢�Ŵ洢Ǩ��:
  bn = %A_GuiControl%
  run, https://www.baidu.com/s?wd=%E5%BE%AE%E4%BF%A1%20%E7%A1%AC%E7%9B%98%20%E8%BF%81%E7%A7%BB
  return
ButtonQQ�洢Ǩ��:
  bn = %A_GuiControl%
  run,   https://www.baidu.com/s?wd=QQ%20%E7%A1%AC%E7%9B%98%20%E8%BF%81%E7%A7%BB
return
Button�鿴���ļ�:
  exe := checkandgetpath("TreeSizeFree")
  run, "%exe%"
return
Button21:
  bn = %A_GuiControl%
return
Button�����ڴ�ת��:
  bn = %A_GuiControl%
  run % "https://www.baidu.com/s?wd=%E8%99%9A%E6%8B%9F%E5%86%85%E5%AD%98%E8%BD%AC%E7%A7%BB"
return
Button�洢��֪������:
  bn = %A_GuiControl%
  run % "https://www.baidu.com/s?wd=%E5%AD%98%E5%82%A8%E6%84%9F%E7%9F%A5%E5%B9%B6%E6%B8%85%E7%90%86"

return
Button24:
  bn = %A_GuiControl%
return
Button31:
  bn = %A_GuiControl%
return
Button32:
  bn = %A_GuiControl%
return
Button33:
  bn = %A_GuiControl%
return
Button��������:
  Reload
return
