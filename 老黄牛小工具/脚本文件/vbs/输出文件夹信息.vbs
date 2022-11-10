
Dim nowpath
Dim arr(1000, 20), n

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

'MsgBox Format_Time(#2021/11/1#,2)
Dim Workbook, ActiveSheet
Set Workbook = ExcelApp.ActiveWorkbook
Set ActiveSheet = Workbook.ActiveSheet

Dim MaxRow, MaxCol
n=0
nowpath = SelectFolder(ExcelApp,Workbook)
arr(0,0)="文件名称"
arr(0,1)="文件绝对路径"
arr(0,2)="文件夹绝对路径"
arr(0,3)="文件夹相对路径"
arr(0,4)="文件名"
arr(0,5)="修改时间"
arr(0,6)="大小(kb)"
arr(0,7)="扩展名"

Call Getfd(nowpath, nowpath, arr, n) 'ThisWorkbook.Path是当前代码文件所在路径，路径名可以根据需求修改

excelapp.activecell.resize(n+1,UBound(arr,2))=arr
Function Getfd(pth, RelativePath, arr, n)
 ' On Error Resume Next
    Dim Fso 
    Dim ff 
    Dim f, fd
    Dim RelativePathLen, rpos, xdlj, arrResult, i
    Set Fso = CreateObject("scripting.filesystemobject")
    Set ff = Fso.GetFolder(pth)
    RelativePathLen = Len(RelativePath)
    Dim ii, j
    
    
    For Each f In ff.Files
        rpos = Mid(f, RelativePathLen + 2, Len(f) - RelativePathLen - 1)
        
        xdlj = ""
        arrResult = Split(rpos, "\")
        n = n + 1
        For i = LBound(arrResult) To UBound(arrResult) - 1
            arr(n, i + 8) = Trim(arrResult(i))
            'Cells(nowrow, LISTFIRSTCOLS + i + LISTSTARTCOL) = Trim(arrResult(i))
            arr(o,i+8)=i+1 & "层目录"
            xdlj = xdlj & Trim(arrResult(i)) & "\"
        Next
        arr(n, 0) = Left(f.Name, InStrRev(f.Name, ".") - 1)
        arr(n, 1) = f
        arr(n, 2)=pth & "\"
        arr(n, 3) = xdlj
        arr(n, 4) = f.Name
        arr(n, 5) = Format_Time(f.DateLastModified, 4)
        arr(n, 6) = Int(f.Size / 1024)
        arr(n, 7) = Mid(f.Name, InStrRev(f.Name, ".") + 1, Len(f.Name))
    Next 
    For Each fd In ff.subfolders
       Call Getfd(fd, RelativePath, arr, n)
    Next
End Function


Function SelectFolder(ExcelApp,Workbook)
Dim aa
    '选择单一文件
    With ExcelApp.FileDialog(4)
         .InitialFileName = Workbook.Path & "\"
        If .Show = -1 Then
            SelectFolder = .SelectedItems(1)
        End If
    End With
End Function

Function Format_Time(s_Time, n_Flag)
    Dim y, m, d, h, mi, s
    Format_Time = ""
    If IsDate(s_Time) = False Then Exit Function
    y = cstr(year(s_Time))
    m = cstr(month(s_Time))
    If len(m) = 1 Then m = "0" & m
    d = cstr(day(s_Time))
    If len(d) = 1 Then d = "0" & d
    h = cstr(hour(s_Time))
    If len(h) = 1 Then h = "0" & h
    mi = cstr(minute(s_Time))
    If len(mi) = 1 Then mi = "0" & mi
    s = cstr(second(s_Time))
    If len(s) = 1 Then s = "0" & s
    Select Case n_Flag
        Case 1
            ' yyyy-mm-dd hh:mm:ss
            Format_Time = y & "-" & m & "-" & d & " "& h &":" & mi &":" & s
        Case 2
            ' yyyy-mm-dd
            Format_Time = y & "-" & m & "-" & d
        Case 3
            ' hh:mm:ss
            Format_Time = h & ":" & mi & ":" & s
        Case 4
            ' yyyy年mm月dd日
            Format_Time = y & "年" & m & "月" & d & "日"
        Case 5
            ' yyyymmdd
            Format_Time = y & m & d
    End Select
End Function