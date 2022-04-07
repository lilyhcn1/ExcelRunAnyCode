Dim strComputer,objWMIService,objProcess,colProcessList
strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'et.EXE'") '从进程中查询1.exe
For Each objProcess in colProcessList
objProcess.Terminate() '结束进程
next
''''''''''''''''''结束VS平台的程序'''''''''''''''''''''''''''


strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'Excel.exe'") '从进程中查询1.exe
For Each objProcess in colProcessList
objProcess.Terminate() '结束进程
next
''''''''''''''''''结束浩方平台的程序'''''''''''''''''''''''''''