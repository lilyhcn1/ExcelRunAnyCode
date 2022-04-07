'当前单元格行倒序
On Error Resume Next
' try to connect to et or excel
Set ExcelApp = GetObject(, "Excel.Application")
If ExcelApp Is Nothing Then
    Set ExcelApp = GetObject(, "KET.Application")
    If ExcelApp Is Nothing Then
        Set ExcelApp = GetObject(, "et.Application")
        If ExcelApp Is Nothing Then
            MsgBox "Run Excel or Kingsoft ET first.", vbInformation, "Information"
            wscript.Quit
        End If
    End If
End If

With ExcelApp
    stra = .ActiveCell.Value
    ar = Split(stra, Chr(10))
    r = UBound(ar)
    br = ar
    For i = r To 0 Step -1
        br(j) = ar(i)
        j = j + 1
    Next
    .ActiveCell = Join(br, Chr(10))
End With

Set ExcelApp = Nothing


