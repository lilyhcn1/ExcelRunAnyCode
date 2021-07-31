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

Dim Workbook, ActiveSheet
Set Workbook = ExcelApp.ActiveWorkbook
Set ActiveSheet = Workbook.ActiveSheet

Dim MaxRow, MaxCol
MaxRow = ActiveSheet.UsedRange.Row + ActiveSheet.UsedRange.Rows.Count-1
MaxCol = ActiveSheet.UsedRange.Column + ActiveSheet.UsedRange.Columns.Count-1

Dim d
Set d = CreateObject("scripting.dictionary")


If ExcelApp.ActiveWorkbook Is Nothing Then
	MsgBox "No documents was opened."
	WScript.Quit
End If

Set selection = ExcelApp.selection

For Each Cell In Selection.Cells
	Cell.Value = removeDup(cell.Value)
Next

Function removeDup(s)
	Dim a
	a = Split(s, " ")
	d.removeall
    For Each i In a
        If Not d.exists(i) Then
            d(i) = ""
        Else
            d.Remove (i)
            d.Add i, ""
        End If
    Next
	removeDup=Join(d.keys," ")
End Function