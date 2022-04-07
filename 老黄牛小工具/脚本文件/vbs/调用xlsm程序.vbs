Set oExcel = createobject("Excel.Application")
oExcel.Visible = false
Set oWorkbooks = oExcel.Workbooks.Open("D:\老黄牛小工具\脚本文件\生成文件夹.xlsb")
oExcel.AlertBeforeOverwriting=False
run1 = "按钮1_Click(" & """D:\老黄牛小工具\""" & ")"
oExcel.Run run1
oExcel.Quit
Set oWorkbooks= nothing
Set oExcel= nothing