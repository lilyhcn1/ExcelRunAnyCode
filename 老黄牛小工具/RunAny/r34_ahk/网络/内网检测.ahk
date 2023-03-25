#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%
url ="http://192.168.7.141/"
loop{
	t:=InternetCheckConnection(url)

	if (t=0){
			tr("网络不通")
	}else{
		msgbox, %t%
	}
	sleep, 5000	

}