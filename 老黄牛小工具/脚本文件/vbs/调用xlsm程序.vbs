Set oExcel = createobject("Excel.Application")
oExcel.Visible = false
Set oWorkbooks = oExcel.Workbooks.Open("D:\�ϻ�ţС����\�ű��ļ�\�����ļ���.xlsb")
oExcel.AlertBeforeOverwriting=False
run1 = "��ť1_Click(" & """D:\�ϻ�ţС����\""" & ")"
oExcel.Run run1
oExcel.Quit
Set oWorkbooks= nothing
Set oExcel= nothing