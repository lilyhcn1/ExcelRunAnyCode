dim url
url="http://hk.r34.cc/index.php/Qwadmin/Rwxy/echojson/type/tablejson/conall/%3B%E6%95%B0%E6%8D%AE%E8%A1%A8%E5%90%8D%E7%AD%89%E4%BA%8E%E5%8F%91%E6%B6%88%E6%81%AF%E6%9C%80%E6%96%B0%E4%BB%A3%E7%A0%81%3B%E6%9F%A5%E7%9C%8B%E5%AF%86%E7%A0%81%E7%AD%89%E4%BA%8Eadmin"
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
On Error GoTo 0

Dim Workbook, ActiveSheet
Set Workbook = ExcelApp.ActiveWorkbook
Set ActiveSheet = Workbook.ActiveSheet

Dim MaxRow, MaxCol
MaxRow = ActiveSheet.UsedRange.Row + ActiveSheet.UsedRange.Rows.Count - 1
MaxCol = ActiveSheet.UsedRange.Column + ActiveSheet.UsedRange.Columns.Count - 1




If ExcelApp.ActiveWorkbook Is Nothing Then
    MsgBox "No documents was opened."
    WScript.Quit
End If

getdata ActiveSheet

Function getdata(sh)
Dim xmlhttp
Dim st
    Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
    With xmlhttp
        .Open "GET", url, True
        .setRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36"
        .send
        Do While .readyState <> 4
            WScript.Sleep 100
        Loop
        st = .responsetext
        st = TestRegUni(st)
        If st <> "" Then
            jx st, sh
        End If
    End With
End Function

Function TestRegUni(st)
    Dim strTest, i, y, arr1(), arr2()
    Dim ireg, imch, mch
    strTest = st ' "\u65e5\u671f"
    Set ireg = CreateObject("vbscript.regexp")
    ireg.Global = True
    ireg.Pattern = "\\u\w{4}"
    Set imch = ireg.Execute(strTest)
    For Each mch In imch
        y = y + 1
        ReDim Preserve arr1(y)
        ReDim Preserve arr2(y)
        arr1(y-1) = ChrW(CLng(Replace(mch.Value, "\u", "&h")))
        arr2(y-1) = mch.Value
    Next
    For i = 0 To UBound(arr1)
        strTest = Replace(strTest, arr2(i), arr1(i))
    Next
    Set ireg = Nothing
    TestRegUni = strTest
End Function

Function jx(st, sh)
    Dim t, a, aa
    Dim i, x, j
    t = Split(Split(st, "[{")(1), "}]")(0)
    a = Split(t, "},{")
    ReDim brr(UBound(a), 100)
    With sh
        .UsedRange.ClearContents
        'i = .Cells(.Cells.Rows.Count, 1).End(3).Row
        For x = 0 To UBound(a)
            aa = Split(a(x), ",""")
            For j = 0 To UBound(aa)
                brr(x , j ) = Split(aa(j), """:")(1)
                brr(x , j ) = Replace(brr(x , j ), """", "")
                brr(x , j ) = Replace(brr(x , j ), "\/", "/")
                If brr(x , j ) = "null" Then 
                  brr(x , j ) = ""
                end if
            Next 
        Next 
        
        .Cells(1, 1).Resize(UBound(brr)+1, UBound(aa)+1) = brr
    End With
End Function
