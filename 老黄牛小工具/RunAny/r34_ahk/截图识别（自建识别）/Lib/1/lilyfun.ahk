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


;������ʾ
tr(ByRef s){
  ;TrayTip #1, %s%
  TrayTip , �ϻ�ţС����, %s%
  
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

; ������arr��ȡ��ֵ
getarr(ByRef arr,ByRef k1,ByRef k2:=""){
if(k2=""){
val := arr[k1]
}else{
val :=arr[k1][k2]
}
return val

}
; ��������json�е�contents�ж�ȡ��ֵ
utf8readtext(ByRef path){
FileRead, jsonstr, path
return jsonstr
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



; ������get��ʽ��ȡ����ֵ
readtext(ByRef path){
FileRead, jsonstr, path
  return jsonstr
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
FileAppend,%str%,%path%,utf-8
;run,%path%

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

;ͨ���ļ������ļ��У���֤�ļ��еĴ���
creatfolderbyfile(filepathold){
StringReplace, filepath,filepathold,"/","\"
StringMid, floderpath, filepath, 1, InStr(filepath,"\",,0)-1
if !FileExist(floderpath){
  FileCreateDir, %floderpath%
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
try  ; ����ִ�еĴ���.
{
}
catch e  ; ��������������������׸�����/�쳣.
{
    MsgBox,������Ϣ����: %e%
    Exit
}

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