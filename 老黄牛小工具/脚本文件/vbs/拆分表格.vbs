aa =msgbox("ʹ��˵����"& chr(13) & "1.��һ�б���Ϊ��ͷ���ڶ��б���Ϊ�����У�"& chr(13)  & "2.����궨λ��Ҫ��ֵĵ�Ԫ���ϣ�"& chr(13) &"3.���д�VBS��"& chr(13) &"�������˷��������ò��ֻ���������ϸ������н����",vbOKCancel,"ɸѡ���" )

if aa <> 1 then  ' ����ȷ���˳�
	WScript.Quit
end if 

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
'.Application.ScreenUpdating = False
.Application.DisplayAlerts = False
atc = .ActiveCell.Column
atr = .ActiveCell.Row
nnfile = .ActiveWorkbook.Path & "\"
Set sh = .ActiveWorkbook.ActiveSheet
With sh
r = .Cells.Find("*", , , , , 2).Row
r = r + .Cells(r, atc).MergeArea.Rows.Count - 1
If Not IsNumeric(r) Then wscript.Quit
c = .Cells(atr, .Columns.Count).End(-4159).Column
r2 = r
Set rng0 = .Range(.Cells(1, 1), .Cells(atr, c))
Set dic = CreateObject("scripting.dictionary")

For i = atr + 1 To r
a = .Cells(i, atc).MergeArea.Cells(1, 1)
a2 = a
If Len(a2) = 0 Then a2 = "�հ�"
If Not dic.Exists(a2) Then Set dic(a2) = rng0
Set Rng = .Cells(i, 1).Resize(1, c)
If IsNull(Rng.MergeCells) Then
r2 = r2 + 1
Rng.Copy .Cells(r2, 1)
For j = 1 To c
.Cells(r2, j) = .Cells(i, j).MergeArea.Cells(1, 1)
Next
Set dic(a2) = .Range(dic(a2).Address & "," & .Cells(r2, 1).Resize(1, c).Address)
Else
Set dic(a2) = .Range(dic(a2).Address & "," & Rng.Address)
End If
Next
End With

Set wb = .Workbooks.Add
With wb
With .ActiveSheet
sh.Cells.Copy .Cells
.Cells.EntireColumn.AutoFit
For i = 0 To dic.Count - 1
.Range(.Cells(atr + 1, 1), .Cells(r, c)).ClearContents
dic.items()(i).Copy .Cells(1, 1)
.Rows(r + 1 & ":" & r2).Delete
.DrawingObjects.Delete
wb.SaveAs nnfile & dic.keys()(i), 51
Next
End With
.Close
End With

sh.Rows(r + 1 & ":" & r2).Delete
.Application.DisplayAlerts = True
 ' .Application.ScreenUpdating = True
End With

Set Rng = Nothing
Set rng0 = Nothing
Set sh = Nothing
Set wb = Nothing
Set dic = Nothing
Set ExcelApp = Nothing

