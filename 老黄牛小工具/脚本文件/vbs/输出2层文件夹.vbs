
Dim cc, k, j
k = 2
On Error Resume Next
Set ExcelApp = GetObject(, "Excel.Application")
If ExcelApp Is Nothing Then
	Set ExcelApp= GetObject(, "KET.Application")
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


Dim nowpath

reDim arr(1000, k+1)
Dim  n
arr(0, 0) = "绝对路径"
arr(0, 1) = "相对路径"
For j = 1 To k
    arr(0, j + 1) = j & "层文件夹"
Next 
nowpath = SelectFolder(ExcelApp,Workbook)
Call Getfd(nowpath, nowpath, arr, n, 0, cc, k) 'ThisWorkbook.Path是当前代码文件所在路径，路径名可以根据需求修改
excelapp.activecell.resize(n+1,UBound(arr,2)).Resize(n + 1, cc + 2) = arr

Function Getfd(pth, RelativePath, arr, n, c, cc, k)
 ' On Error Resume Next
    Dim Fso 
    Dim ff 
    Dim f, fd
    Dim RelativePathLen, rpos, xdlj, arrResult, i
    Set Fso = CreateObject("scripting.filesystemobject")
    Set ff = Fso.getfolder(pth)
    RelativePathLen = Len(RelativePath)
    Dim ii, j
    
    n = n + 1
    arr(n, 0) = pth
    arr(n, 1) = Mid(pth, RelativePathLen + 2, Len(pth) - RelativePathLen)
    If c > 0 Then arr(n, 1 + c) = Mid(pth, InStrRev(pth, "\")+1)
    
    For j = 2 To c
        arr(n, j) = arr(n - 1, j)
    Next
    If c > cc Then cc = c
    For Each fd In ff.subfolders
       If c < k Then Call Getfd(fd, RelativePath, arr, n, c + 1, cc, k)
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
