' This code try to connect WPS ET，if failed then connect to Excel
Dim ExcelApp

On Error Resume Next
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

newfilename = ExcelApp.ActiveWorkbook.Name
filename = Left(newfilename, InStrRev(newfilename, ".") - 1)
nowpath = ExcelApp.Application.ActiveWorkbook.path
nnfile = nowpath & "\" & filename & ".xlsx"


ExcelApp.Application.DisplayAlerts = False
ExcelApp.ActiveSheet.Copy
With ExcelApp.ActiveWorkbook
  For i = 1 To .Worksheets.Count
    .Worksheets(i).DrawingObjects.Delete
  Next
  .SaveAs nnfile, 51
  .Close
End With
ExcelApp.Application.DisplayAlerts = True


ExcelApp.run "arrToJson"