;修正，剪贴板上传，lilyfun, postfile
;获取文件的路径
;#Include ZeroMQ.ahk
checkandgetpath(exename){
toolpath  = D:\老黄牛小工具
exefolder = D:\老黄牛小工具\小工具
site = http://pub.r34.cc/toolsoft
site2 = http://nat.r34.cc/toolsoft

if (exename = "RunAny"){
  path = %toolpath%\RunAny\RunAny.exe
  url = %site%/%exename%.zip
}else if(exename = "xll"){
  path = %toolpath%\Excel插件\老黄牛小工具-64位.xll
  url = %site%/%exename%.zip
}else if(exename = "ffmpeg"){
  path = %exefolder%\ffmpeg.exe
  url = %site%/ffmpeg.zip
}else if(exename = "nconvert"){
  path = %exefolder%\缩小图片nconvert\nconvert.exe
  url = %site%/nconvert.zip
}else if(exename = "notepad2"){
  path = %exefolder%\Notepad2\Notepad2.exe
  url = %site%/Notepad2.zip
}else if(exename = "realesrgan"){
  path = %exefolder%\realesrgan\realesrgan-ncnn-vulkan.exe
  url = %site%/realesrgan.zip
}else if(exename = "cpdf"){
  path = %exefolder%\pdf\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "PDFEdit"){
  path = %exefolder%\PDFEdit\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "主文件"){
  path = %A_Desktop%\主文件.xlsx
  url = %site%/%exename%.zip
}else if(exename = "网络表格"){
  path = %A_Desktop%\网络表格.xlsx
  url = %site%/%exename%.zip
}else if(exename = "aria2c"){
  path = %exefolder%\网络\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "wget"){
  path = %exefolder%\网络\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "fastcopy"){
  path = %exefolder%\系统\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "openssl"){
  path = %exefolder%\系统\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "rclone"){
  path = %exefolder%\网络\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "桌面大鹅"){
  path = %exefolder%\多媒体\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "曾大大按键软件"){
  path = %exefolder%\多媒体\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "dism++"){
  path = %exefolder%\系统\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "Rapr驱动清理"){
  path = %exefolder%\系统\%exename%\%exename%.exe
  url = %site%/%exename%.zip
  
}else{
  path = %exefolder%\其它\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}


if not FileExist(path){

    if (url =""){
        MsgBox, 暂无网址，请自行上网下载。
        ExitApp 
    }
    ;msgbox,准备InternetCheckConnection！~
	if (checkurl(site2)){
		url := StrReplace(url,site,site2)  ;替换为新的网站
	}
	
	;startstr(url)
	;MsgBox, 4, , url=%url%，site=%site%， site2=%site2%
	;exit
   ; msgbox,准备检查网址！~
     if(checkurl(url)){
        MsgBox, 4, r34小工具 , 接下来即将安装%exename%软件到%path%。
        IfMsgBox, No
            ExitApp 
        creatfolderbyfile(path)
        SplitPath, path, name, dir, ext, name_no_ext, drive
        zippath = %dir%\temp.zip
        DownloadFile( url, zippath)
        SmartZip(zippath,dir)
        FileDelete, %zippath%    
     }else{
        msgbox , 暂无相关的文件下载网址，请自行上网下载。
        path := ""
        ExitApp          
     }
}
if not FileExist(path){
        msgbox , %path%不存在，请检查。
        path := ""
        ExitApp          
}
return path
}


;错误检查 1 接口有没申请 ，2 第一个值返回对不对
; 函数：找到数组的第一个值
returnfirstvalue(ByRef arr){
  For index, value in arr{
      ;MsgBox % "Item " index " is '" arr[index] "'"
      if(arr["ask"] <> ""){
        fv := arr["ask"]
      }else{
        fv := arr[index]
      }
      break
  }
  return fv
}

; 函数：找到数组的第一个key
returnfirstkey(ByRef arr){
  For index, value in arr{
    return index
  }
}

;获取excel等obj，这样各个人都可以用。
getexcelobj(){
try {
    ox := ComObjActive("Excel.Application")
} catch e {
  try {
      ox := ComObjActive("KET.Application")
  } catch e {
      try {
          ox := ComObjActive("KET.Application")
      } catch e {
         MsgBox, 请先安装Excel或Wps。
         exitapp
      }
  }
}   
return ox 
}

;获取传参的参数
getargs2arr(ByRef args){
arr:=[]
  Loop, %args%
  {
      param := %A_Index%
      inputpath := param
      msgbox,%param%
      arr := []
      SplitPath, param, name, dir, ext, name_no_ext, drive
      outputpath :=  inputpath
      arr[fkeyold] := inputpath
      arr[fkeynew] := outputpath
      
      a := savearr2json(arr)
    ;tr("暂时运行结束")
    ;exitapp
    ;msgbox,==
    ;发送post信息并返回，这个非常复杂,为核心主文件函数在lilyfun里
    ;apiserver := getserverurl()
    apiserver := "http://api7.r34.cc"
    url := apiserver "/jb/" jbname
    ;PostCsvAndFile(url,fkeyold,fkeynew)

  }
}



;把路径改为绝对路径
getwholepath(ByRef raltiveapth,ByRef folder :=""){
  ;读取文件
if(folder=""){
  FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  folder := parsed["excelpath"]
}

if (InStr(raltiveapth, ":")){
  new_file := raltiveapth

}else{
  new_file := folder "\" raltiveapth
}
return new_file
}
 

; 函数：arr读取键值
getarrkey(ByRef arr,ByRef k1,ByRef k2){
if(k1=""){
val := arr[k2]
}else{
val :=arr[k1][k2]
}
return val

}

; 函数：json读取键值
getjsonkey(ByRef k1,ByRef k2 :=""){
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)
if(k2=""){
val := arr[k1]
}else{
val :=arr[k1][k2]
}


return val
}


; 函数：从json中的contents中读取键值
readjsonconkey(ByRef key){
  ;读取文件
  FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  img1 := parsed["contents"][key]
  return img1
}


;发送post信息并返回，这个非常复杂
;url 是发送的url
;fkeyold 是发送文件的信息，可为空
;fkeynew 是接收文件的信息，可为空
RelaceAndRun(){
 tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
 tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"
 
  ;-----------------正式的函数区----------------
  ;读取文件
  FileRead, jsonstr, %tempjsonpath%
  ;msgbox % jsonstr
  parsed := JSON.Load(jsonstr)
  arr := parsed["contents"]
  ;旧的文件路径，通常是文件模板
   For index, value in arr["contents"]{
     
     
  }
}


JsonToAHK(json, rec := false) {
   static doc := ComObjCreate("htmlfile")
         , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
         , JS := doc.parentWindow
   if !rec
      obj := %A_ThisFunc%(JS.eval("(" . json . ")"), true)
   else if !IsObject(json)
      obj := json
   else if JS.Object.prototype.toString.call(json) == "[object Array]" {
      obj := []
      Loop % json.length
         obj.Push( %A_ThisFunc%(json[A_Index - 1], true) )
   }
   else {
      obj := {}
      keys := JS.Object.keys(json)
      Loop % keys.length {
         k := keys[A_Index - 1]
         obj[k] := %A_ThisFunc%(json[k], true)
      }
   }
   Return obj
}


; 函数：get方式获取返回值
geturlcontent(ByRef url){
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("Get", url, true)
    whr.Send()
    whr.WaitForResponse()
    r := whr.ResponseText
  return r
}

;把值写入当前的表格
writeexcelcell(byref val){
  objExcel:=Excel_Get()
  y:=objExcel.ActiveCell.Column
  x:=objExcel.ActiveCell.Row
  objExcel.Cells(x,y).Value:= val
}

; 函数：get方式获取返回值
readtext(ByRef path){
FileRead, t, *P936 %path%  
return t
}

;气泡提示
tr(ByRef s){
  ;TrayTip #1, %s%
  TrayTip , 老黄牛小工具, %s%
  
}
; 函数：get方式获取返回值
utf8readtext(ByRef path){
FileRead, t, *P65001 %path%
if not ErrorLevel{
    return t
}else{
    return 0
}
}

readtext2(File){
	FileGetSize, nBytes, %File%
	FileRead, Bin, *c %File%
	return Bin
}
; 函数：get方式获取返回值
savearr2json(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;构造excel需要的数组
arr2 := []
arr2["script"] := "ahk"
arr2["w"] := wtype
arr2["code"] := code

arr2["contents"] := arr
;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json

}

; 函数：get方式获取返回值
savearrtojson(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;构造excel需要的数组
arr2 := []
arr1 := []
arr2["script"] := "ahk"
arr2["w"] := "key"
arr2["code"] := code

arr2["contents"] := arr



;将构造好的数组写入文本
stringified := JSON.Dump(arr2,, 4)
FileDelete, d:\老黄牛小工具\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\老黄牛小工具\ExcelQuery\temp\temp.json

}

Time_unix2human(time)
{
        human=19700101000000
        time-=((A_NowUTC-A_Now)//10000)*3600        ;时差
        human+=%time%,Seconds
        return human
        }
Time_human2unix(time)
{
    
        time-=19700101000000,Seconds
        time+=((A_NowUTC-A_Now)//10000)*3600        ;时差
        return time
}
 
 

; 函数：get方式获取返回值
arr2excelarr(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;构造excel需要的数组
arr2 := []
arr2["script"] := "ahk"
arr2["w"] := "all"
arr2["code"] := "0"
;arr2["excelpath"] := %A_ScriptDir%
arr2["contents"] := []
arr2["contents"] :=arr
return arr2
}


;发送post信息并返回，这个非常复杂
;url 是发送的url
;fkeyold 是发送文件的信息，可为空
;fkeynew 是接收文件的信息，可为空
Postarr(ByRef url,ByRef arr2,ByRef fkeyold,ByRef fkeynew){

  ;旧的文件路径，通常是文件模板
  if(fkeyold <> ""){
    mbpath := arr2["contents"][fkeyold]
  }
  ;新的文件路径，通常是生成的文件，可以是相对路径
  if(fkeynew <> ""){   
    nowpath := arr2["excelpath"]
    genfname := arr2["contents"][fkeynew]
    if(InStr(genfname,":")){
      newfilepath := genfname 
    }else{
      newfilepath := nowpath  "\"  genfname 
    }
  }




  ;读取文件
  if(mbpath <> ""){
    f64 :=readFile(mbpath)
  }else{
    f64 := ""
  }


json64 := b64Encode(JSON.Dump(arr2,, 4))
  JsonData := {"json64": json64
          , "f64": f64			 
        , "fkeyold": fkeyold
        , "fkeynew": fkeynew			 }
           
  ;发送编码后的base64字段
  result := getWebPage(url,JsonData)

  data := JSON.Load(result)
  ;jsontemparr := JSON.Load(data.json64)
  
  ;将读取到base64字符解码后写入文件
  if(newfilepath <> ""){
    creatfolderbyfile(newfilepath)
    writeBase64File(newfilepath,data.f64)
  }
  return data.json64
}
 
;a := Time_human2unix(A_Now) ;转时间戳
;b := Time_unix2human(a) ;转 YYYYMMDDHH24MISS

; 函数：get方式获取返回值
readini(ByRef sec,ByRef key, myconinifile := "D:\老黄牛小工具\ExcelQuery\temp\temp.ini"){
if FileExist(myconinifile){
  IniRead, inival, %myconinifile%, %sec%, %key%
  
  if(inival ="ERROR"){
      msgbox , %myconinifile% 中的相关配置不存在，请确保【 %sec% 】节中的 %key% 存在！~

  }else if(inival =""){
    msgbox , 请在 %myconinifile% 中填写\n在【 %sec% 】节中的 %key% 的值
  }
}else{
    msgbox , %myconinifile% 这个文件不存在，请创建后再试！
}
 return inival
}
; 函数：get方式获取返回值
readiniarr(arr, myconinifile := "D:\老黄牛小工具\ExcelQuery\temp\temp.ini"){
newarr := []
For index, value in arr{
    ;msgbox % index
    IniRead, inival, %myconinifile%, Temp, %index%
    newarr[index] := inival
}

IniRead, inival, %myconinifile%, Temp, time
newarr["time"] := inival
if( newarr["time"] ="ERROR"){
    newarr["time"] := "0"
}else if( newarr["time"] =""){
    newarr["time"] := "0"
}
return newarr

}
; 函数：get方式获取返回值
writeini(ByRef sec,ByRef key,ByRef inival, myconinifile := "D:\老黄牛小工具\ExcelQuery\temp\temp.ini"){
IniWrite, inival, %myconinifile%, %sec%, %key%
 return 1
}
; 函数：get方式获取返回值
arrwriteini(ByRef arr, myconinifile := "D:\老黄牛小工具\ExcelQuery\temp\temp.ini"){
  For index, value in arr{
    IniWrite, %value%, %myconinifile%, Temp, %index%
  }
 return 1
}
;获取输入的值
getinput(){
Loop, %0%
{
    param := %A_Index%
}
msgbox, %param%
return %param%
}

; 函数：get方式获取返回值
arrupdatefromini(arr, runtime := 30, myconinifile := "D:\老黄牛小工具\ExcelQuery\temp\temp.ini"){
    oldarr :=[]
    oldarr :=arr
    larr := readiniarr(arr)

    jg :=Time_human2unix(A_Now)-larr["time"]
    ;msgbox % larr["reg"] 
    key := returnfirstkey(arr)
    if(larr[key]="" || Abs(jg) > runtime){
      For index, value in oldarr{
          if(index  != "time"){
            InputBox, tmp, %index%, %value% 	
            arr[index] := tmp           
          }
      }
    }else{
        arr :=larr
    }
    arr["time"] :=Time_human2unix(A_Now)

    arrwriteini(arr, myconinifile)
    return arr
}

; 函数：get方式获取返回值
arrupdate(arr, runtime := 30, port := 5555){

SetBatchLines -1                       ; 速度最大化

zmq := new ZeroMQ                      ; 初始化 ZeroMQ

context := zmq.context()               ; 创建一个上下文
socket := context.socket(zmq.REQ)      ; 创建一个 REQ 套接字
socket.connect("tcp://localhost:5555") ; 连接到端口



;reg为最后要提取的变量，可以统一输入
;arr :=[]
;arr["reg"] := "请输入正则公式,正则公式比较复杂，请自行上网检索。`n 相关网站：`nhttps://c.runoob.com/front-end/854/（30秒内免再输入）"
;arr :=arrupdate(arr)
;reg := arr["reg"]

arr2 := arr2excelarr(arr)
str := JSON.Dump(arr2,, 4)
;startstr(str)
socket.send_string(str)          ; 发送消息 Hello 给服务端
jsonstr := socket.recv_string()          ; 从服务端接收回应

temparr2 := JSON.Load(jsonstr)
;socket.send_string("World")     ; 发送消息 World 给客户端
rec_arr :=temparr2["contents"]

return rec_arr
}

; 函数：删除并写入文件
writetext(ByRef str,ByRef path, ByRef encoding := "UTF-8-RAW"){
FileDelete, %path%
FileAppend,%str%,%path%,%encoding%
;run,%path%
}
; 函数：删除并写入文件
writetextutf8(ByRef str,ByRef path, ByRef encoding := "UTF-8"){
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,%encoding%
;run,%path%
}
; 函数：删除并写入文件
writetextgbk(ByRef str,ByRef path){
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,cp936
;run,%path%

}


; 函数：删除并写入文件
writetextencoding(ByRef str,ByRef path,ByRef encoding){
inputpath := str
encoding = "utf-8"
if fileexist(inputpath){
    SplitPath, inputpath, name, dir, ext, name_no_ext, drive
    if (ext = "ahk"){
        encoding = "utf-8"
    }else if (ext = "bat"){
        encoding = "cp936"
    }else{
        encoding = "UTF-8-RAW"
    }
}
msgbox, %encoding%
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,%encoding%
;run,%path%

}

;把字符串写到记事本中，方便复制
startstr(ByRef str){
path :="d:\老黄牛小工具\ExcelQuery\temp\temp.txt"
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,utf-8
run,%path%

}


;-- 获取Excel窗口的COM对象  By FeiYue
Excel_Get(WinTitle="ahk_class XLMAIN")
{
  static obj
  Try
    if (obj.Version)
      return obj
  return obj:=Office_Get(WinTitle)
}

;-- 获取所有Office窗口的COM对象  By FeiYue
Office_Get(WinTitle="")
{
  static h:=DllCall("LoadLibrary", "Str","oleacc", "Ptr")
  WinGet, list, ControlListHwnd, % WinTitle ? WinTitle : "A"
  For i,hWnd in StrSplit(list, "`n")
  {
    ControlGetPos, x, y, w, h,, ahk_id %hWnd%
    if (y<10 or w<100 or h<100)
      Continue
    if DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd
    , "UInt", 0xFFFFFFF0, "Ptr", 0*(VarSetCapacity(IID,16)
    +NumPut(0x0000000000020400,IID,"Int64")
    +NumPut(0x46000000000000C0,IID,8,"Int64"))+&IID, "Ptr*", pacc)=0
    {
      Acc:=ComObject(9, pacc, 1)
      Try
        if (Acc.Application.Version)
          return Acc.Application
    }
  }
  MsgBox, 4096,, Error: Can't Get Object From ACC !
  Exit
}


writeBase64File(fileName,base64Data){
	nBytes := Base64Dec( base64Data, Bin )
	File := FileOpen(fileName, "w")
	File.RawWrite(Bin, nBytes)
	File.Close()
}

writeFile(fileName,data){
	File := FileOpen(fileName, "w")
	File.Write(data)
	File.Close()
}
;
readFile(File){
	FileGetSize, nBytes, %File%
	FileRead, Bin, *c %File%
	B64Data := Base64Enc(Bin, nBytes)
	return B64Data
}
getserverurl(myconinifile := "D:\老黄牛小工具\配置文件\myconf.ini", server:= "http://api1.r34.cc"){

IniRead, server1, %myconinifile%, ApiServer, server1

if(server1 ="ERROR"){
     msgbox , %myconinifile% 中的相关配置不存在，请确保【ApiServer】节中的server1存在！~
}else{
      server := server1
}

return server
}



getserverurl2(myconinifile := "D:\老黄牛小工具\配置文件\myconf.ini", server:= "http://api1.r34.cc"){

if FileExist(myconinifile){
IniRead, server1, %myconinifile%, ApiServer, server1
IniRead, server2, %myconinifile%, ApiServer, server2
;msgbox % server1
;msgbox % server2
if(server1 ="ERROR"){
    msgbox , %myconinifile% 中的相关配置不存在，请确保【ApiServer】节中的server1存在！~
    }else{
    if(InternetCheckConnection(server1)){
      server := server1
    }else if (InternetCheckConnection(server1)){
      server := server2
    }
  }
}
if( server=""){
   msgbox , %myconinifile% 中的相关配置不存在，请确保【ApiServer】节中的server1存在！~
}


return server

}
;测试网页是否正常
checkurl(Url="") {
try {
  whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  ;whr.SetTimeouts(300, 300, 300, 300)
  whr.Open("GET", Url, "True")
  whr.Send()
  ; 使用 'true'(上面) 和调用下面的函数, 允许脚本保持响应.
  ;Status := whr.Status
  whr.WaitForResponse(1) ;等1秒
  ;version := whr.ResponseText
  Status := whr.Status
  if(Status=200){
      Return True   
  }else{
      Return False  
  }
} catch e {
   Return False  
}


}
;测试网页是否正常
InternetCheckConnection(Url="",FIFC=1) {
Return DllCall("Wininet.dll\InternetCheckConnectionW", Str,Url, Int,FIFC, Int,0)
}
getWebPage(url, postData := 0, headers := 0, method := 0)
{
	if (postData && IsObject(postData))
		postData := JSON.Dump(postData)

	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")    ; static will make it use the same object in memory
	whr.Open((method?method:(postData?"POST":"GET")), url, true)                ; Post or Get depending if postdata is submitted
	whr.SetTimeouts("30000", "30000", "30000", "30000")         ; timeout 30 seconds

	postData ? whr.SetRequestHeader("Content-Type", "application/json")

	if (IsObject(headers))
		for k, v in headers
			whr.SetRequestHeader(k, v)

		(postData?whr.Send(postData):whr.Send())
    whr.WaitForResponse()
    Return whr.ResponseText
}


DownloadFile(UrlToFile, SaveFileAs, Overwrite := True, UseProgressBar := True, ExpectedFileSize := 0) {
    ;Check if the file already exists and if we must not overwrite it
    If (!Overwrite && FileExist(SaveFileAs))
        Return
    ;Check if the user wants a progressbar
    If (UseProgressBar) {
        ;Initialize the WinHttpRequest Object
        WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;Download the headers
        WebRequest.Open("HEAD", UrlToFile)
        WebRequest.Send()

        try {
            ;Store the header which holds the file size in a variable:
            FinalSize := WebRequest.GetResponseHeader("Content-Length")
        } catch e {
            ; Cannot get "Content-Length" header
            FinalSize := Exp`ectedFileSize
        }

        ;Create the progressbar and the timer
        Progress, , , Downloading..., %UrlToFile%

        LastSizeTick := 0
        LastSize := 0

        ; Enable progress bar updating if the system knows file size
        SetTimer, __UpdateProgressBar, 1500
    }

    ;Download the file
    UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
    ;Remove the timer and the progressbar because the download has finished
    If (UseProgressBar) {
        Progress, Off
        SetTimer, __UpdateProgressBar, Off
    }
    Return

    ;The label that updates the progressbar
    __UpdateProgressBar:
        ;Get the current filesize and tick
        CurrentSize := FileOpen(SaveFileAs, "r").Length ;FileGetSize wouldn't return reliable results
        CurrentSizeTick := A_TickCount

        ;Calculate the downloadspeed
        SpeedOrig  := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000))

        SpeedUnit  := "KB/s"
        Speed      := SpeedOrig

        if (Speed > 1024) {
            ; Convert to megabytes
            SpeedUnit := "MB/s"
            Speed := Round(Speed/1024, 2)
        }

        SpeedText := Speed . " " . SpeedUnit

        ;Save the current filesize and tick for the next time
        LastSizeTick := CurrentSizeTick
        LastSize := FileOpen(SaveFileAs, "r").Length

        if FinalSize = 0
        {
            PercentDone := 50
        } else {
            ;Calculate percent done
            PercentDone := Round(CurrentSize/FinalSize*100)
            SpeedText := SpeedText . ", " . Round((FinalSize - CurrentSize) / SpeedOrig / 1024) . "s left"
        }

        ;Update the ProgressBar
        Progress, %PercentDone%, %PercentDone%`% (%SpeedText%), Downloading..., Downloading %SaveFileAs% (%PercentDone%`%)
    
    Return
}


;通过文件创建文件夹，保证文件夹的存在
creatfolderbyfile(filepathold){
StringReplace, filepath,filepathold,"/","\"
StringMid, floderpath, filepath, 1, InStr(filepath,"\",,0)-1
if !FileExist(floderpath){
  FileCreateDir, %floderpath%
}

}


SmartZip(s, o, t = 4)
{
    IfNotExist, %s%
        return, -1
    oShell := ComObjCreate("Shell.Application")
    if InStr(FileExist(o), "D") or (!FileExist(o) and (SubStr(s, -3) = ".zip"))
    {
        if !o
            o := A_ScriptDir
        else ifNotExist, %o%
                FileCreateDir, %o%
        Loop, %o%, 1
            sObjectLongName := A_LoopFileLongPath
        oObject := oShell.NameSpace(sObjectLongName)
        Loop, %s%, 1
        {
            oSource := oShell.NameSpace(A_LoopFileLongPath)
            oObject.CopyHere(oSource.Items, t)
        }
    }
}







;发送post信息并返回，这个非常复杂
;url 是发送的url
;fkeyold 是发送文件的信息，可为空
;fkeynew 是接收文件的信息，可为空
PostCsvAndFilearr(ByRef url,ByRef fkeyold,ByRef fkeynew,ByRef argarr){
if(argarr[0]=""){
  ;msgbox,无参数
  PostCsvAndFile(url,fkeyold,fkeynew)
}else{
  ;msgbox,有参数
  for key, param in argarr{
      inputpath := param
      msgbox,%param%
      arr := []
      SplitPath, param, name, dir, ext, name_no_ext, drive
      outputpath :=  inputpath
      arr[fkeyold] := inputpath
      arr[fkeynew] := outputpath
      a := savearr2json(arr)
      PostCsvAndFile(url,fkeyold,fkeynew)
  }
}


}


;发送post信息并返回，这个非常复杂
;url 是发送的url
;fkeyold 是发送文件的信息，可为空
;fkeynew 是接收文件的信息，可为空
PostCsvAndFile(ByRef url,ByRef fkeyold,ByRef fkeynew){
 tempjsonpath := "d:\老黄牛小工具\ExcelQuery\temp\temp.json"
 tempjsonpath2 := "d:\老黄牛小工具\ExcelQuery\temp\temp2.json"
 
  ;-----------------正式的函数区----------------
  ;读取文件
  FileRead, jsonstr, %tempjsonpath%

  parsed := JSON.Load(jsonstr)
  ;旧的文件路径，通常是文件模板
  if(fkeyold <> ""){
    mbpath := parsed["contents"][fkeyold]
  }
  ;新的文件路径，通常是生成的文件，可以是相对路径
  if(fkeynew <> ""){   
    nowpath := parsed["excelpath"]
    genfname := parsed["contents"][fkeynew]
    if(InStr(genfname,":")){
      newfilepath := genfname 
    }else{
      newfilepath := nowpath  "\"  genfname 
    }
  }




  ;读取文件
  if(mbpath <> ""){
    f64 :=readFile(mbpath)
  }else{
    f64 := ""
  }

  JsonData := {"json64": readFile(tempjsonpath)
          , "f64": f64			 
        , "fkeyold": fkeyold
        , "fkeynew": fkeynew			 }
           
  ;发送编码后的base64字段
  result := getWebPage(url,JsonData)

  data := JSON.Load(result)
  ;jsontemparr := JSON.Load(data.json64)

  ;将读取到base64字符解码后写入文件
  writeBase64File(tempjsonpath,data.json64)

  if(newfilepath <> ""){
    creatfolderbyfile(newfilepath)
    writeBase64File(newfilepath,data.f64)
  }
  
  
}


Base64Enc( ByRef Bin, nBytes, LineLength := 64, LeadingSpaces := 0 ) { ; By SKAN / 18-Aug-2017
	local Rqd := 0, B64, B := "", N := 0 - LineLength + 1  ; CRYPT_STRING_BASE64 := 0x1
	DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin ,"UInt",nBytes, "UInt",0x1, "Ptr",0,   "UIntP",Rqd )
	VarSetCapacity( B64, Rqd * ( A_IsUnicode ? 2 : 1 ), 0 )
	DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin, "UInt",nBytes, "UInt",0x1, "Str",B64, "UIntP",Rqd )
	if ( LineLength = 64 and ! LeadingSpaces )
		return B64
	B64 := StrReplace( B64, "`r`n" )
	loop % Ceil( StrLen(B64) / LineLength )
		B .= Format("{1:" LeadingSpaces "s}","" ) . SubStr( B64, N += LineLength, LineLength ) . "`n"
	return RTrim( B,"`n" )
}




Base64Dec( ByRef B64, ByRef Bin ) {  ; By SKAN / 18-Aug-2017
	local Rqd := 0, BLen := StrLen(B64)                 ; CRYPT_STRING_BASE64 := 0x1
	DllCall( "Crypt32.dll\CryptStringToBinary", "Str",B64, "UInt",BLen, "UInt",0x1
				, "UInt",0, "UIntP",Rqd, "Int",0, "Int",0 )
	VarSetCapacity( Bin, 128 ), VarSetCapacity( Bin, 0 ),  VarSetCapacity( Bin, Rqd, 0 )
	DllCall( "Crypt32.dll\CryptStringToBinary", "Str",B64, "UInt",BLen, "UInt",0x1
				, "Ptr",&Bin, "UIntP",Rqd, "Int",0, "Int",0 )
	return Rqd
}
 
CreateFormData(ByRef retData, ByRef retHeader, objParam) {
    New CreateFormData(retData, retHeader, objParam)
}
 
Class CreateFormData {
 
    __New(ByRef retData, ByRef retHeader, objParam) {
 
        CRLF := "`r`n"
 
        ; Create a random Boundary
        Boundary := this.RandomBoundary()
        BoundaryLine := "------------------------------" . Boundary
 
        ; Loop input paramters
        binArrs := []
        For k, v in objParam
        {
            If IsObject(v) {
                For i, FileName in v
                {
                    str := BoundaryLine . CRLF
                         . "Content-Disposition: form-data; name=""" . k . """; filename=""" . FileName . """" . CRLF
                         . "Content-Type: " . this.MimeType(FileName) . CRLF . CRLF
                    binArrs.Push( BinArr_FromString(str) )
                    binArrs.Push( BinArr_FromFile(FileName) )
                    binArrs.Push( BinArr_FromString(CRLF) )
                }
            } Else {
                str := BoundaryLine . CRLF
                     . "Content-Disposition: form-data; name=""" . k """" . CRLF . CRLF
                     . v . CRLF
                binArrs.Push( BinArr_FromString(str) )
            }
        }
 
        str := BoundaryLine . "--" . CRLF
        binArrs.Push( BinArr_FromString(str) )
 
        ; Finish
        retData := BinArr_Join(binArrs*)
        retHeader := "multipart/form-data; boundary=----------------------------" . Boundary
    }
 
    RandomBoundary() {
        str := "0|1|2|3|4|5|6|7|8|9|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z"
        Sort, str, D| Random
        str := StrReplace(str, "|")
        Return SubStr(str, 1, 12)
    }
 
    MimeType(FileName) {
        n := FileOpen(FileName, "r").ReadUInt()
        Return (n        = 0x474E5089) ? "image/png"
             : (n        = 0x38464947) ? "image/gif"
             : (n&0xFFFF = 0x4D42    ) ? "image/bmp"
             : (n&0xFFFF = 0xD8FF    ) ? "image/jpeg"
             : (n&0xFFFF = 0x4949    ) ? "image/tiff"
             : (n&0xFFFF = 0x4D4D    ) ? "image/tiff"
             : "application/octet-stream"
    }
 
}
 
BinArr_FromString(str) {
    oADO := ComObjCreate("ADODB.Stream")
 
    oADO.Type := 2 ; adTypeText
    oADO.Mode := 3 ; adModeReadWrite
    oADO.Open
    oADO.Charset := "UTF-8"
    oADO.WriteText(str)
 
    oADO.Position := 0
    oADO.Type := 1 ; adTypeBinary
    oADO.Position := 3 ; Skip UTF-8 BOM
    return oADO.Read, oADO.Close
}
 
BinArr_FromFile(FileName) {
    oADO := ComObjCreate("ADODB.Stream")
 
    oADO.Type := 1 ; adTypeBinary
    oADO.Open
    oADO.LoadFromFile(FileName)
    return oADO.Read, oADO.Close
}
 
BinArr_Join(Arrays*) {
    oADO := ComObjCreate("ADODB.Stream")
 
    oADO.Type := 1 ; adTypeBinary
    oADO.Mode := 3 ; adModeReadWrite
    oADO.Open
    For i, arr in Arrays
        oADO.Write(arr)
    oADO.Position := 0
    return oADO.Read, oADO.Close
}
 
BinArr_ToString(BinArr, Encoding := "UTF-8") {
    oADO := ComObjCreate("ADODB.Stream")
 
    oADO.Type := 1 ; adTypeBinary
    oADO.Mode := 3 ; adModeReadWrite
    oADO.Open
    oADO.Write(BinArr)
 
    oADO.Position := 0
    oADO.Type := 2 ; adTypeText
    oADO.Charset  := Encoding
    return oADO.ReadText, oADO.Close
}
 
BinArr_ToFile(BinArr, FileName) {
    oADO := ComObjCreate("ADODB.Stream")
 
    oADO.Type := 1 ; adTypeBinary
    oADO.Open
    oADO.Write(BinArr)
    oADO.SaveToFile(FileName, 2)
    oADO.Close
}


; ===============================================================================================================================
; Base64 Encode / Decode a string (binary-to-text encoding)
; ===============================================================================================================================
 
b64Encode(string)
{
    VarSetCapacity(bin, StrPut(string, "UTF-8")) && len := StrPut(string, &bin, "UTF-8") - 1 
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", 0, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    VarSetCapacity(buf, size << 1, 0)
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", &buf, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    return StrGet(&buf)
}
 
b64Decode(string)
{
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    VarSetCapacity(buf, size, 0)
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    return StrGet(&buf, size, "UTF-8")

}