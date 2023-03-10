
' This code try to connect WPS ET，if failed then connect to Excel

Dim ExcelApp
Dim ph
ph = "D:\老黄牛小工具\ExcelQuery\code.json"
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

With ActiveSheet
	MaxRow=.cells(.cells.rows.count,1).end(3).row
	MaxCol=.cells(1,.cells.columns.count).end(1).column
	arr=.cells(1,1).resize(MaxRow,MaxCol)
End with	

If MaxRow>0 Then 
	For i = 1 To UBound(arr)
	    st = ""
	    For j = 1 To UBound(arr, 2)
	        st = st & "," & UTF8EncodeURI(arr(i, j))
	    Next
	    t = t & ";" & "[" & Mid(st, 2) & "]"
	Next
	If t <> "" Then
		xrtxt(Mid(t,2))
	End If
End if


If ExcelApp.ActiveWorkbook Is Nothing Then
    MsgBox "No documents was opened."
    WScript.Quit
End If

rem 打开文件夹等，方便上传。
Set objShell = CreateObject("Wscript.Shell")
strPath = "D:\老黄牛小工具\ExcelQuery"
strPath = "explorer.exe /e," & strPath
objShell.Run strPath
strPath2 = "http://r34.cc/kod"
objShell.Run strPath2


Function UTF8EncodeURI(szInput)
    Dim wch, uch, szRet
    Dim x
    Dim nAsc, nAsc2, nAsc3
    If szInput = "" Then
        UTF8EncodeURI = szInput
        Exit Function
    End If
    For x = 1 To Len(szInput)
        wch = Mid(szInput, x, 1)
        nAsc = AscW(wch)
        If nAsc < 0 Then nAsc = nAsc + 65536
        If (nAsc And &HFF80) = 0 Then
            szRet = szRet & "%" & "X" & fortext(nAsc)
        Else

            If (nAsc And &HF000) = 0 Then
                uch = "%" & Hex(((nAsc \ 2 ^ 6)) Or &HC0) & Hex(nAsc And &H3F Or &H80)
                szRet = szRet & uch
            Else
                uch = "%" & Hex((nAsc \ 2 ^ 12) Or &HE0) & "%" & _
                      Hex((nAsc \ 2 ^ 6) And &H3F Or &H80) & "%" & _
                      Hex(nAsc And &H3F Or &H80)
                szRet = szRet & uch
            End If
        End If
    Next
    UTF8EncodeURI = szRet
End Function

Function fortext(st)
	Dim x
	x=st
	If Len(st)<3 Then 
		x=Mid("000",1,3-Len(st)) & st
	End if
	fortext=x	
End function

Function xrtxt(data)
	Dim fs
	Dim f
	set fs =CreateObject("scripting.filesystemobject")
	if (fs.fileexists(ph)) then
	  set f =fs.opentextfile(ph,2)
	  f.write data
'	  f.writeline data
	  f.close
	else
	  set f=fs.opentextfile(ph,8, true)
	  'f.writeblanklines 2
	  f.write data
	  f.close
	end if
End function

