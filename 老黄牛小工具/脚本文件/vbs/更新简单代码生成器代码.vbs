
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
Dim url
Dim xmlhttp
Dim st
    Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
    url = "http://r34.cc/Uploads/code.json"
    With xmlhttp
        .Open "GET", url, True
        .setRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36"
        .send
        Do While .readyState <> 4
            WScript.Sleep 100
        Loop
        st = .responsetext
'        st = TestRegUni(st)
        If st <> "" Then
            jiefan st, sh
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

Sub jiefan(st,sh)
    Dim a, aa
    Dim x, y
    Dim t 
'    t=right(st,5)
    st=Replace(st,"""","")
    st=Replace(st,"[","")
    st=Replace(st,"]","")
    st=Replace(st,Chr(13),"")
    st=Replace(st,Chr(10),"")
    a = Split(st, ";")
    aa = Split(a(0), ",")
    ReDim brr(UBound(a), UBound(aa))
    For x = 0 To UBound(a)
        aa = Split(a(x), ",")
        For y = 0 To UBound(aa)
            brr(x, y) = aa(y)
            brr(x, y) = URLDecode(brr(x, y))
        Next
    Next
    sh.UsedRange.ClearContents
    sh.Range("a1").Resize(UBound(brr) + 1, UBound(brr, 2) + 1) = brr
    sh.cells.WrapText = false
    sh.cells.ShrinkToFit = True
    
End Sub

Function URLDecode(ByVal strIn)
    URLDecode = ""
    Dim sl: sl = 1
    Dim tl: tl = 1
    Dim key: key = "%"
    Dim kl: kl = Len(key)
    sl = InStr(sl, strIn, key, 1)
    Do While sl > 0
        If (tl = 1 And sl <> 1) Or tl < sl Then
            URLDecode = URLDecode & Mid(strIn, tl, sl - tl)
        End If
        Dim hh, hi, hl
        Dim a
        Select Case UCase(Mid(strIn, sl + kl, 1))
        Case "U" 'Unicode URLEncode
            a = Mid(strIn, sl + kl + 1, 4)
            URLDecode = URLDecode & ChrW("&H" & a)
            sl = sl + 6
        Case "E" 'UTF-8 URLEncode
            hh = Mid(strIn, sl + kl, 2)
            a = Int("&H" & hh) 'ascii码
            If Abs(a) < 128 Then
                sl = sl + 3
                URLDecode = URLDecode & Chr(a)
            Else
                hi = Mid(strIn, sl + 3 + kl, 2)
                hl = Mid(strIn, sl + 6 + kl, 2)
                a = ("&H" & hh And &HF) * 2 ^ 12 Or ("&H" & hi And &H3F) * 2 ^ 6 Or ("&H" & hl And &H3F)
            If a < 0 Then a = a + 65536
            URLDecode = URLDecode & ChrW(a)
            sl = sl + 9
            End If
        Case "X"
            a = Int(Mid(strIn, sl + kl + 1, 3))
            URLDecode = URLDecode & ChrW(a)
            sl = sl + 5
        Case Else 'Asc URLEncode
            hh = Mid(strIn, sl + kl, 2) '高位
            a = Int("&H" & hh) 'ascii码
            If Abs(a) < 128 Then
                sl = sl + 3
            Else
                hi = Mid(strIn, sl + 3 + kl, 2) '低位
                a = Int("&H" & hh & hi) '非ascii码
                sl = sl + 6
            End If
            URLDecode = URLDecode & Chr(a)
        End Select
        tl = sl
        sl = InStr(sl, strIn, key, 1)
    Loop
    URLDecode = URLDecode & Mid(strIn, tl)
End Function