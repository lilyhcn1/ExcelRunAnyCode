'����Excel��WPS�Ĵ���
On Error Resume Next
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



'������
ExcelApp.Selection.WrapText = False





Set ExcelApp = Nothing


