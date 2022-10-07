Const EXCEL_ADDIN_PATH_BEFORE = "HKCU\Software\Microsoft\Office\" 
Const EXCEL_ADDIN_PATH_AFTER = "\Excel\Options\" 
Const ADDIN_REG_VALUE = """老黄牛工具-功能模块.xlam""" 
Const ADDIN_REG_VALUE1 = """老黄牛工具-64位.xll""" 
Function RegistrationKeyExists(key) 
    On Error Resume Next 
    objShell.RegRead (key) 
    If Err = 0 Then 
        RegistrationKeyExists = True 
    Else 
        RegistrationKeyExists = False 
    End If 
End Function 

Function RegistrationKeyValueGet(name) 
    On Error Resume Next 
    Dim value 
    value = objShell.RegRead(name) 
    If Err = 0 Then 
        RegistrationKeyValueGet = value 
    Else 
        RegistrationKeyValueGet = "" 
    End If 
End Function 

Function RegistrationKeyValueSet(name, value) 
    On Error Resume Next 
    objShell.RegWrite name, value, "REG_SZ" 
    If Err = 0 Then 
        RegistrationKeyValueSet = True 
    Else 
        RegistrationKeyValueSet = False 
    End If 
End Function 

Dim EXCEL_ADDIN_PATH 
Dim versions 
Dim officeval 
Dim objShell 
Dim count 
Dim value 
Dim exists 
Dim success 

Set objShell = CreateObject("WScript.Shell") 

rem WScript.Echo "Excel Add-in Registration Tool" 
Function addxll(openstr, addval) 

versions = Array("12.0", "14.0", "15.0", "16.0") 
For Each officeval In versions 
    EXCEL_ADDIN_PATH = EXCEL_ADDIN_PATH_BEFORE & officeval & EXCEL_ADDIN_PATH_AFTER 


    If RegistrationKeyExists(EXCEL_ADDIN_PATH) Then 
        count = 0 
        exists = False 
        value = RegistrationKeyValueGet(EXCEL_ADDIN_PATH & openstr) 

        While Len(value) > 0 And Not exists 
            count = count + 1 
            value = RegistrationKeyValueGet(EXCEL_ADDIN_PATH & openstr & count) 
            If value = addval Then 
                exists = True 
            End If 
        Wend 

        If exists = True Then 
            rem WScript.Echo "Office Version - " & officeval & " Already Registered" 
        Else 
            If count > 0 Then 
                success = RegistrationKeyValueSet(EXCEL_ADDIN_PATH & openstr & count, addval) 
            Else 
                success = RegistrationKeyValueSet(EXCEL_ADDIN_PATH & openstr, addval) 
            End If 
            If success Then 
                rem WScript.Echo "Office Version - " & officeval & " Registration Complete" 
            Else 
                rem WScript.Echo "Office Version - " & officeval & " Unable to Register Add-In" 
            End If 
        End If 
    Else 
        rem WScript.Echo "Office Version - " & officeval & " Not Found" 
    End If 
Next 
end function

aa= addxll("OPEN",ADDIN_REG_VALUE)
aa=  addxll("OPEN1",ADDIN_REG_VALUE1)
WScript.Echo "office 插件安装完毕，快来试试吧！" 


Set objShell = Nothing 