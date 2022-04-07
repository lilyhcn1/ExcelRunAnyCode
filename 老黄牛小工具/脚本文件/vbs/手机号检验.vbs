' This code try to connect WPS ET£¬if failed then connect to Excel
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
On Error resume next

With ExcelApp
.Application.DisplayAlerts = False
atc = .ActiveCell.Column
atr = .ActiveCell.Row
r = .Cells(.Rows.Count, atc).End(3).Row

ar = .Range(.Cells(1, 1), .Cells(r, atc))
If Not IsArray(ar) Then wscript.Quit
Set RegEx = CreateObject("vbscript.regexp")
With RegEx
.Global = True
.Pattern = "^1[3-9]\d{9}$"
End With

For i = atr + 1 To r
If RegEx.test(ar(i, atc)) = False Then .Cells(i, atc).Interior.ColorIndex = 3
Next

.Application.DisplayAlerts = True
End With

Set ExcelApp = Nothing
Set sh = Nothing
Set RegEx = Nothing