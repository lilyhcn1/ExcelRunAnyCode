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
.Pattern = "(^\d{15}$)|(^\d{18}$)|(^\d{17}([\dXx])$)"
End With

For i = atr + 1 To r
sfz = ar(i, atc)
If RegEx.test(sfz) Then
If Len(sfz) = 18 Then
s17 = Mid(sfz, 1, 17)
ElseIf Len(sfz) = 15 Then
s17 = Left(sfz, 6) & "19" & Mid(sfz, 7, 9)
Else
.Cells(i, atc).Interior.ColorIndex = 3
End If

yy = Mid(s17, 7, 4)
mm = Mid(s17, 11, 2)
dd = Mid(s17, 13, 2)
If mm < 13 Then
If dd < 32 Then
d2 = CDate(yy & "/" & mm & "/" & dd)
End If
End If

If IsDate(d2) Then
If DateDiff("yyyy", Now, d2) < -140 Then .Cells(i, atc).Interior.ColorIndex = 3
If d2 > Date Then .Cells(i, atc).Interior.ColorIndex = 3
Else
.Cells(i, atc).Interior.ColorIndex = 3
End If

xr = Split("1,0,x,9,8,7,6,5,4,3,2", ",")
yr = Split("7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2", ",")

For j = 0 To 16
ttl = ttl + Mid(s17, j + 1, 1) * yr(j)
Next

x = xr(ttl Mod 11)
s17 = s17 & x
If InStr(sfz, s17) = 0 Then .Cells(i, atc).Interior.ColorIndex = 3

Else
.Cells(i, atc).Interior.ColorIndex = 3
End If
ttl = 0
Next

.Application.DisplayAlerts = True
End With

Set ExcelApp = Nothing
Set sh = Nothing
Set RegEx = Nothing


