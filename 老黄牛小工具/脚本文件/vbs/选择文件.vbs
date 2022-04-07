' This code try to connect WPS ET£¬if failed then connect to Excel
Dim ExcelApp

On Error Resume Next

Dim Workbook, ActiveSheet
Set Workbook = ExcelApp.ActiveWorkbook
Set ActiveSheet = Workbook.ActiveSheet
' try to connect to et or excel
Set ExcelApp = GetObject(, "Excel.Application")
If ExcelApp Is Nothing Then
	Set ExcelApp = GetObject(, "KET.Application")
	If ExcelApp Is Nothing Then
		Set ExcelApp = GetObject(, "et.Application")
		If ExcelApp Is Nothing Then
			MsgBox "Run Excel or Kingsoft ET first.", vbInformation, "Information"
			WScript.Quit
		End If
	End If
End If
On Error Goto 0


'msgbox workbook.activesheet.name
Set ActiveCell = ExcelApp.ActiveCell
'msgbox Activecell.address
'msgbox ExcelApp.ActiveCell.Row
Function SelectFile()
    Set oExec = CreateObject("WScript.Shell")._
    Exec("mshta.exe ""about:<input type=file id=path><script>path.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(path.value);close();resizeTo(0,0);</script>""")
    StrLine = oExec.StdOut.ReadAll
    Pos = InStr(StrLine, Chr(13))
    If Pos <= 0 Then
        SelectFile = ""
    Else
        SelectFile = Left(StrLine, Pos - 1)
    End If
End Function
aa=SelectFile()
'msgbox aa
ActiveCell.Value=aa 

