on error resume next
SelectFolder
function SelectFolder()
Const MY_COMPUTER = &H11&
Const WINDOW_HANDLE = 0
Const OPTIONS = 0
Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.Namespace(MY_COMPUTER)
Set objFolderItem = objFolder.Self
strPath = objFolderItem.Path
Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.BrowseForFolder(WINDOW_HANDLE, "ѡ���ļӼ�:", OPTIONS, strPath)
If objFolder Is Nothing Then
msgbox "��û��ѡ���κ���ЧĿ¼!"
End If
Set objFolderItem = objFolder.Self
objPath = objFolderItem.Path
msgbox "��ѡ����ļ����ǣ�" & objPath
end function