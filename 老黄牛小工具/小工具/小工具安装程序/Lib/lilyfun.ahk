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
  TrayTip #1, %s%
}
; ������get��ʽ��ȡ����ֵ
utf8readtext(ByRef path){
FileRead, t, *P65001 %path%
  return t
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
readini(ByRef sec,ByRef key){
myconinifile := "D:\�ϻ�ţС����\�����ļ�\myconf.ini"
if FileExist(myconinifile){
  IniRead, inival, %myconinifile%, %sec%, %key%
  
  if(inival ="ERROR"){
      msgbox , %myconinifile% �е�������ò����ڣ���ȷ���� %sec% �����е� %key% ���ڣ�~

  }else if(inival =""){
    msgbox , ���� D:\�ϻ�ţС����\�����ļ�\myconf.ini ����д\n�ڡ� %sec% �����е� %key% ��ֵ
  }
}else{
    msgbox , %myconinifile% ����ļ������ڣ��봴�������ԣ�
}
 return inival
}

; ������ɾ����д���ļ�
writetext(ByRef str,ByRef path){
FileDelete, %path%
;TrayTip %path%, "path"
;TrayTip %str%, "str"
FileAppend,%str%,%path%,UTF-8-RAW
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

;��ȡ�ļ���·��
checkandgetpath(exename){
toolpath  = D:\�ϻ�ţС����
exefolder = D:\�ϻ�ţС����\С����
site = http://pub.r34.cc/toolsoft
site2 = http://nat.r34.cc/toolsoft

if (exename = "ffmpeg"){
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
  url = 
}else if(exename = "xll"){
  path = %toolpath%\Excel���\�ϻ�ţС����-64λ.xll
  url = %site%/%exename%.zip
}else if(exename = "���ļ�"){
  path = %A_Desktop%\���ļ�.xlsx
  url = %site%/%exename%.zip
}

if not FileExist(path){
    if (url =""){
        MsgBox, ������ַ���������������ء�
        ExitApp 
    }
	if (InternetCheckConnection(site2)){
		site= site2
	}
    MsgBox, 4, r34С���� , ������������װ%exename%�����%path%��
    IfMsgBox, No
        ExitApp 
     
      creatfolderbyfile(path)
      SplitPath, path, name, dir, ext, name_no_ext, drive
      zippath = %dir%\temp.zip
      DownloadFile( url, zippath)
      
      SmartZip(zippath,dir)
      FileDelete, %zippath% 
}

if not FileExist(path){
    msgbox , %path% �����ڣ����������ء�
    path := ""
    ExitApp 
}
return path
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
            FinalSize := ExpectedFileSize
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
