Dim strComputer,objWMIService,objProcess,colProcessList
strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'WINWORD.EXE'") '�ӽ����в�ѯ1.exe
For Each objProcess in colProcessList
objProcess.Terminate() '��������
next
''''''''''''''''''����VSƽ̨�ĳ���'''''''''''''''''''''''''''


strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'GameClient.exe'") '�ӽ����в�ѯ1.exe
For Each objProcess in colProcessList
objProcess.Terminate() '��������
next
''''''''''''''''''�����Ʒ�ƽ̨�ĳ���'''''''''''''''''''''''''''