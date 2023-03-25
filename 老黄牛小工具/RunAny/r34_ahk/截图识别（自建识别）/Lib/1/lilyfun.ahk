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


;气泡提示
tr(ByRef s){
  ;TrayTip #1, %s%
  TrayTip , 老黄牛小工具, %s%
  
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

; 函数：arr读取键值
getarr(ByRef arr,ByRef k1,ByRef k2:=""){
if(k2=""){
val := arr[k1]
}else{
val :=arr[k1][k2]
}
return val

}
; 函数：从json中的contents中读取键值
utf8readtext(ByRef path){
FileRead, jsonstr, path
return jsonstr
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



; 函数：get方式获取返回值
readtext(ByRef path){
FileRead, jsonstr, path
  return jsonstr
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
readini(ByRef sec,ByRef key){
myconinifile := "D:\老黄牛小工具\配置文件\myconf.ini"
if FileExist(myconinifile){
  IniRead, inival, %myconinifile%, %sec%, %key%
  
  if(inival ="ERROR"){
      msgbox , %myconinifile% 中的相关配置不存在，请确保【 %sec% 】节中的 %key% 存在！~

  }else if(inival =""){
    msgbox , 请在 D:\老黄牛小工具\配置文件\myconf.ini 中填写\n在【 %sec% 】节中的 %key% 的值
  }
}else{
    msgbox , %myconinifile% 这个文件不存在，请创建后再试！
}
 return inival
}

; 函数：删除并写入文件
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

;通过文件创建文件夹，保证文件夹的存在
creatfolderbyfile(filepathold){
StringReplace, filepath,filepathold,"/","\"
StringMid, floderpath, filepath, 1, InStr(filepath,"\",,0)-1
if !FileExist(floderpath){
  FileCreateDir, %floderpath%
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
try  ; 尝试执行的代码.
{
}
catch e  ; 处理由上面区块产生的首个错误/异常.
{
    MsgBox,发送信息错误: %e%
    Exit
}

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