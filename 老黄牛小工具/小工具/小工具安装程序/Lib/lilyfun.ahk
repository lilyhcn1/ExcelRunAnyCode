;�������������ϴ���lilyfun, postfile
;��ȡ�ļ���·��
;#Include ZeroMQ.ahk
checkandgetpath(exename){
toolpath  = D:\�ϻ�ţС����
exefolder = D:\�ϻ�ţС����\С����
site = http://pub.r34.cc/toolsoft
site2 = http://nat.r34.cc/toolsoft

if (exename = "RunAny"){
  path = %toolpath%\RunAny\RunAny.exe
  url = %site%/%exename%.zip
}else if(exename = "xll"){
  path = %toolpath%\Excel���\�ϻ�ţС����-64λ.xll
  url = %site%/%exename%.zip
}else if(exename = "ffmpeg"){
  path = %exefolder%\ffmpeg.exe
  url = %site%/ffmpeg.zip
}else if(exename = "nconvert"){
  path = %exefolder%\��СͼƬnconvert\nconvert.exe
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
}else if(exename = "���ļ�"){
  path = %A_Desktop%\���ļ�.xlsx
  url = %site%/%exename%.zip
}else if(exename = "������"){
  path = %A_Desktop%\������.xlsx
  url = %site%/%exename%.zip
}else if(exename = "aria2c"){
  path = %exefolder%\����\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "wget"){
  path = %exefolder%\����\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "fastcopy"){
  path = %exefolder%\ϵͳ\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "openssl"){
  path = %exefolder%\ϵͳ\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "rclone"){
  path = %exefolder%\����\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "������"){
  path = %exefolder%\��ý��\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "����󰴼����"){
  path = %exefolder%\��ý��\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "dism++"){
  path = %exefolder%\ϵͳ\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}else if(exename = "Rapr��������"){
  path = %exefolder%\ϵͳ\%exename%\%exename%.exe
  url = %site%/%exename%.zip
  
}else{
  path = %exefolder%\����\%exename%\%exename%.exe
  url = %site%/%exename%.zip
}


if not FileExist(path){

    if (url =""){
        MsgBox, ������ַ���������������ء�
        ExitApp 
    }
    ;msgbox,׼��InternetCheckConnection��~
	if (checkurl(site2)){
		url := StrReplace(url,site,site2)  ;�滻Ϊ�µ���վ
	}
	
	;startstr(url)
	;MsgBox, 4, , url=%url%��site=%site%�� site2=%site2%
	;exit
   ; msgbox,׼�������ַ��~
     if(checkurl(url)){
        MsgBox, 4, r34С���� , ������������װ%exename%�����%path%��
        IfMsgBox, No
            ExitApp 
        creatfolderbyfile(path)
        SplitPath, path, name, dir, ext, name_no_ext, drive
        zippath = %dir%\temp.zip
        DownloadFile( url, zippath)
        SmartZip(zippath,dir)
        FileDelete, %zippath%    
     }else{
        msgbox , ������ص��ļ�������ַ���������������ء�
        path := ""
        ExitApp          
     }
}
if not FileExist(path){
        msgbox , %path%�����ڣ����顣
        path := ""
        ExitApp          
}
return path
}


;������ 1 �ӿ���û���� ��2 ��һ��ֵ���ضԲ���
; �������ҵ�����ĵ�һ��ֵ
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

; �������ҵ�����ĵ�һ��key
returnfirstkey(ByRef arr){
  For index, value in arr{
    return index
  }
}

;��ȡexcel��obj�����������˶������á�
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
         MsgBox, ���Ȱ�װExcel��Wps��
         exitapp
      }
  }
}   
return ox 
}

;��ȡ���εĲ���
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
    ;tr("��ʱ���н���")
    ;exitapp
    ;msgbox,==
    ;����post��Ϣ�����أ�����ǳ�����,Ϊ�������ļ�������lilyfun��
    ;apiserver := getserverurl()
    apiserver := "http://api7.r34.cc"
    url := apiserver "/jb/" jbname
    ;PostCsvAndFile(url,fkeyold,fkeynew)

  }
}



;��·����Ϊ����·��
getwholepath(ByRef raltiveapth,ByRef folder :=""){
  ;��ȡ�ļ�
if(folder=""){
  FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
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
 

; ������arr��ȡ��ֵ
getarrkey(ByRef arr,ByRef k1,ByRef k2){
if(k1=""){
val := arr[k2]
}else{
val :=arr[k1][k2]
}
return val

}

; ������json��ȡ��ֵ
getjsonkey(ByRef k1,ByRef k2 :=""){
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
arr := JSON.Load(jsonstr)
if(k2=""){
val := arr[k1]
}else{
val :=arr[k1][k2]
}


return val
}


; ��������json�е�contents�ж�ȡ��ֵ
readjsonconkey(ByRef key){
  ;��ȡ�ļ�
  FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
  parsed := JSON.Load(jsonstr)
  img1 := parsed["contents"][key]
  return img1
}


;����post��Ϣ�����أ�����ǳ�����
;url �Ƿ��͵�url
;fkeyold �Ƿ����ļ�����Ϣ����Ϊ��
;fkeynew �ǽ����ļ�����Ϣ����Ϊ��
RelaceAndRun(){
 tempjsonpath := "d:\�ϻ�ţС����\ExcelQuery\temp\temp.json"
 tempjsonpath2 := "d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json"
 
  ;-----------------��ʽ�ĺ�����----------------
  ;��ȡ�ļ�
  FileRead, jsonstr, %tempjsonpath%
  ;msgbox % jsonstr
  parsed := JSON.Load(jsonstr)
  arr := parsed["contents"]
  ;�ɵ��ļ�·����ͨ�����ļ�ģ��
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


; ������get��ʽ��ȡ����ֵ
geturlcontent(ByRef url){
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("Get", url, true)
    whr.Send()
    whr.WaitForResponse()
    r := whr.ResponseText
  return r
}

;��ֵд�뵱ǰ�ı��
writeexcelcell(byref val){
  objExcel:=Excel_Get()
  y:=objExcel.ActiveCell.Column
  x:=objExcel.ActiveCell.Row
  objExcel.Cells(x,y).Value:= val
}

; ������get��ʽ��ȡ����ֵ
readtext(ByRef path){
FileRead, t, *P936 %path%  
return t
}

;������ʾ
tr(ByRef s){
  ;TrayTip #1, %s%
  TrayTip , �ϻ�ţС����, %s%
  
}
; ������get��ʽ��ȡ����ֵ
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
; ������get��ʽ��ȡ����ֵ
savearr2json(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;����excel��Ҫ������
arr2 := []
arr2["script"] := "ahk"
arr2["w"] := wtype
arr2["code"] := code

arr2["contents"] := arr
;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json

}

; ������get��ʽ��ȡ����ֵ
savearrtojson(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;����excel��Ҫ������
arr2 := []
arr1 := []
arr2["script"] := "ahk"
arr2["w"] := "key"
arr2["code"] := code

arr2["contents"] := arr



;������õ�����д���ı�
stringified := JSON.Dump(arr2,, 4)
FileDelete, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
FileAppend,%stringified%,d:\�ϻ�ţС����\ExcelQuery\temp\temp.json

}

Time_unix2human(time)
{
        human=19700101000000
        time-=((A_NowUTC-A_Now)//10000)*3600        ;ʱ��
        human+=%time%,Seconds
        return human
        }
Time_human2unix(time)
{
    
        time-=19700101000000,Seconds
        time+=((A_NowUTC-A_Now)//10000)*3600        ;ʱ��
        return time
}
 
 

; ������get��ʽ��ȡ����ֵ
arr2excelarr(ByRef arr, ByRef wtype := "all", ByRef code := "0"){
;����excel��Ҫ������
arr2 := []
arr2["script"] := "ahk"
arr2["w"] := "all"
arr2["code"] := "0"
;arr2["excelpath"] := %A_ScriptDir%
arr2["contents"] := []
arr2["contents"] :=arr
return arr2
}


;����post��Ϣ�����أ�����ǳ�����
;url �Ƿ��͵�url
;fkeyold �Ƿ����ļ�����Ϣ����Ϊ��
;fkeynew �ǽ����ļ�����Ϣ����Ϊ��
Postarr(ByRef url,ByRef arr2,ByRef fkeyold,ByRef fkeynew){

  ;�ɵ��ļ�·����ͨ�����ļ�ģ��
  if(fkeyold <> ""){
    mbpath := arr2["contents"][fkeyold]
  }
  ;�µ��ļ�·����ͨ�������ɵ��ļ������������·��
  if(fkeynew <> ""){   
    nowpath := arr2["excelpath"]
    genfname := arr2["contents"][fkeynew]
    if(InStr(genfname,":")){
      newfilepath := genfname 
    }else{
      newfilepath := nowpath  "\"  genfname 
    }
  }




  ;��ȡ�ļ�
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
           
  ;���ͱ�����base64�ֶ�
  result := getWebPage(url,JsonData)

  data := JSON.Load(result)
  ;jsontemparr := JSON.Load(data.json64)
  
  ;����ȡ��base64�ַ������д���ļ�
  if(newfilepath <> ""){
    creatfolderbyfile(newfilepath)
    writeBase64File(newfilepath,data.f64)
  }
  return data.json64
}
 
;a := Time_human2unix(A_Now) ;תʱ���
;b := Time_unix2human(a) ;ת YYYYMMDDHH24MISS

; ������get��ʽ��ȡ����ֵ
readini(ByRef sec,ByRef key, myconinifile := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.ini"){
if FileExist(myconinifile){
  IniRead, inival, %myconinifile%, %sec%, %key%
  
  if(inival ="ERROR"){
      msgbox , %myconinifile% �е�������ò����ڣ���ȷ���� %sec% �����е� %key% ���ڣ�~

  }else if(inival =""){
    msgbox , ���� %myconinifile% ����д\n�ڡ� %sec% �����е� %key% ��ֵ
  }
}else{
    msgbox , %myconinifile% ����ļ������ڣ��봴�������ԣ�
}
 return inival
}
; ������get��ʽ��ȡ����ֵ
readiniarr(arr, myconinifile := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.ini"){
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
; ������get��ʽ��ȡ����ֵ
writeini(ByRef sec,ByRef key,ByRef inival, myconinifile := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.ini"){
IniWrite, inival, %myconinifile%, %sec%, %key%
 return 1
}
; ������get��ʽ��ȡ����ֵ
arrwriteini(ByRef arr, myconinifile := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.ini"){
  For index, value in arr{
    IniWrite, %value%, %myconinifile%, Temp, %index%
  }
 return 1
}
;��ȡ�����ֵ
getinput(){
Loop, %0%
{
    param := %A_Index%
}
msgbox, %param%
return %param%
}

; ������get��ʽ��ȡ����ֵ
arrupdatefromini(arr, runtime := 30, myconinifile := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.ini"){
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

; ������get��ʽ��ȡ����ֵ
arrupdate(arr, runtime := 30, port := 5555){

SetBatchLines -1                       ; �ٶ����

zmq := new ZeroMQ                      ; ��ʼ�� ZeroMQ

context := zmq.context()               ; ����һ��������
socket := context.socket(zmq.REQ)      ; ����һ�� REQ �׽���
socket.connect("tcp://localhost:5555") ; ���ӵ��˿�



;regΪ���Ҫ��ȡ�ı���������ͳһ����
;arr :=[]
;arr["reg"] := "����������ʽ,����ʽ�Ƚϸ��ӣ�����������������`n �����վ��`nhttps://c.runoob.com/front-end/854/��30�����������룩"
;arr :=arrupdate(arr)
;reg := arr["reg"]

arr2 := arr2excelarr(arr)
str := JSON.Dump(arr2,, 4)
;startstr(str)
socket.send_string(str)          ; ������Ϣ Hello �������
jsonstr := socket.recv_string()          ; �ӷ���˽��ջ�Ӧ

temparr2 := JSON.Load(jsonstr)
;socket.send_string("World")     ; ������Ϣ World ���ͻ���
rec_arr :=temparr2["contents"]

return rec_arr
}

; ������ɾ����д���ļ�
writetext(ByRef str,ByRef path, ByRef encoding := "UTF-8-RAW"){
FileDelete, %path%
FileAppend,%str%,%path%,%encoding%
;run,%path%
}
; ������ɾ����д���ļ�
writetextutf8(ByRef str,ByRef path, ByRef encoding := "UTF-8"){
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,%encoding%
;run,%path%
}
; ������ɾ����д���ļ�
writetextgbk(ByRef str,ByRef path){
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,cp936
;run,%path%

}


; ������ɾ����д���ļ�
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

;���ַ���д�����±��У����㸴��
startstr(ByRef str){
path :="d:\�ϻ�ţС����\ExcelQuery\temp\temp.txt"
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,utf-8
run,%path%

}


;-- ��ȡExcel���ڵ�COM����  By FeiYue
Excel_Get(WinTitle="ahk_class XLMAIN")
{
  static obj
  Try
    if (obj.Version)
      return obj
  return obj:=Office_Get(WinTitle)
}

;-- ��ȡ����Office���ڵ�COM����  By FeiYue
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
getserverurl(myconinifile := "D:\�ϻ�ţС����\�����ļ�\myconf.ini", server:= "http://api1.r34.cc"){

IniRead, server1, %myconinifile%, ApiServer, server1

if(server1 ="ERROR"){
     msgbox , %myconinifile% �е�������ò����ڣ���ȷ����ApiServer�����е�server1���ڣ�~
}else{
      server := server1
}

return server
}



getserverurl2(myconinifile := "D:\�ϻ�ţС����\�����ļ�\myconf.ini", server:= "http://api1.r34.cc"){

if FileExist(myconinifile){
IniRead, server1, %myconinifile%, ApiServer, server1
IniRead, server2, %myconinifile%, ApiServer, server2
;msgbox % server1
;msgbox % server2
if(server1 ="ERROR"){
    msgbox , %myconinifile% �е�������ò����ڣ���ȷ����ApiServer�����е�server1���ڣ�~
    }else{
    if(InternetCheckConnection(server1)){
      server := server1
    }else if (InternetCheckConnection(server1)){
      server := server2
    }
  }
}
if( server=""){
   msgbox , %myconinifile% �е�������ò����ڣ���ȷ����ApiServer�����е�server1���ڣ�~
}


return server

}
;������ҳ�Ƿ�����
checkurl(Url="") {
try {
  whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  ;whr.SetTimeouts(300, 300, 300, 300)
  whr.Open("GET", Url, "True")
  whr.Send()
  ; ʹ�� 'true'(����) �͵�������ĺ���, ����ű�������Ӧ.
  ;Status := whr.Status
  whr.WaitForResponse(1) ;��1��
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
;������ҳ�Ƿ�����
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


;ͨ���ļ������ļ��У���֤�ļ��еĴ���
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







;����post��Ϣ�����أ�����ǳ�����
;url �Ƿ��͵�url
;fkeyold �Ƿ����ļ�����Ϣ����Ϊ��
;fkeynew �ǽ����ļ�����Ϣ����Ϊ��
PostCsvAndFilearr(ByRef url,ByRef fkeyold,ByRef fkeynew,ByRef argarr){
if(argarr[0]=""){
  ;msgbox,�޲���
  PostCsvAndFile(url,fkeyold,fkeynew)
}else{
  ;msgbox,�в���
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


;����post��Ϣ�����أ�����ǳ�����
;url �Ƿ��͵�url
;fkeyold �Ƿ����ļ�����Ϣ����Ϊ��
;fkeynew �ǽ����ļ�����Ϣ����Ϊ��
PostCsvAndFile(ByRef url,ByRef fkeyold,ByRef fkeynew){
 tempjsonpath := "d:\�ϻ�ţС����\ExcelQuery\temp\temp.json"
 tempjsonpath2 := "d:\�ϻ�ţС����\ExcelQuery\temp\temp2.json"
 
  ;-----------------��ʽ�ĺ�����----------------
  ;��ȡ�ļ�
  FileRead, jsonstr, %tempjsonpath%

  parsed := JSON.Load(jsonstr)
  ;�ɵ��ļ�·����ͨ�����ļ�ģ��
  if(fkeyold <> ""){
    mbpath := parsed["contents"][fkeyold]
  }
  ;�µ��ļ�·����ͨ�������ɵ��ļ������������·��
  if(fkeynew <> ""){   
    nowpath := parsed["excelpath"]
    genfname := parsed["contents"][fkeynew]
    if(InStr(genfname,":")){
      newfilepath := genfname 
    }else{
      newfilepath := nowpath  "\"  genfname 
    }
  }




  ;��ȡ�ļ�
  if(mbpath <> ""){
    f64 :=readFile(mbpath)
  }else{
    f64 := ""
  }

  JsonData := {"json64": readFile(tempjsonpath)
          , "f64": f64			 
        , "fkeyold": fkeyold
        , "fkeynew": fkeynew			 }
           
  ;���ͱ�����base64�ֶ�
  result := getWebPage(url,JsonData)

  data := JSON.Load(result)
  ;jsontemparr := JSON.Load(data.json64)

  ;����ȡ��base64�ַ������д���ļ�
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