; AHK version:      1.1.30.01 U32
; Tested on:        Win 10 Pro (x64)
; Version:          0.0.01.00/2019-09-02/thqby
UrlEncode(sString, encoding:="UTF-8"){
	readbytes:=(encoding="UTF-16"||encoding="cp1200")?2:1
	content:=""
	VarSetCapacity(sbin, StrPut(sString, encoding)*readbytes)
	bytes:=StrPut(sString, &sbin, encoding)-1
	If (readbytes=1)
		Loop % bytes
		{
			hex:=format("{1:02x}", hex2:=NumGet(&sbin, A_index-1, "UChar"))
			if (hex2==33 || (hex2>=39 && hex2 <=42) || hex2==45 || hex2 ==46 || (hex2>=48 && hex2<=57) || (hex2>=65 && hex2<=90) || hex2==95 || (hex2>=97 && hex2<=122) || hex2==126)
				content .= Chr(hex2)
			else
				content .= "`%" hex
		}
	Else
		Loop % bytes
		{
			H:=NumGet(&sbin, (A_index-1)*2, "UChar"), L:=NumGet(&sbin, A_index*2-1, "UChar")
			if !L&&(H==33||(H>=39&&H<=42)||H==45||H==46||(H>=48&&H<=57)||(H>=65&&H<=90)||H==95||(H>=97&&H<=122)||H==126)
				content .= Chr(H)
			else
				content .= "`%" format("{1:02x}",H) "`%" format("{1:02x}",L)
		}
	return content
}

UrlDecode(sString, encoding:="UTF-8"){
	While RegExMatch(sString, "i)((%[\da-f]{1,2})+)", hexstr){
		tarr:=StrSplit(SubStr(hexstr, 2), "`%")
		VarSetCapacity(sbin, tarr.Length()+1, 0)
		Loop % tarr.Length()
			NumPut("0x" tarr[A_index], &sbin, A_index-1, "UChar")
		sString:=StrReplace(sString, hexstr, StrGet(&sbin, encoding))
	}
	Return sString
}

Requests(url, Method="GET", postData="", headers="", Encoding="")
{
	hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
	hObject.SetTimeouts(30000, 30000, 30000, 30000) 
	hObject.Open(Method, url, (Method="POST" ? True : False))  
	
	if IsObject(headers){
		for k, v in headers
			if v
				hObject.SetRequestHeader(k, v)
	}
	if postData{
		try
			hObject.Send(postData)
		try
			hObject.WaitForResponse(-1)
	} else {
		try
			hObject.Send()
	}

	if (Encoding && hObject.ResponseBody)
	{
		oADO:=ComObjCreate("adodb.stream")
		oADO.Type:=1, oADO.Mode:=3
		oADO.Open(),oADO.Write(hObject.ResponseBody)
		oADO.Position:=0, oADO.Type:=2
		oADO.Charset:=Encoding
		return oADO.ReadText(), oADO.Close()
	}
	try 
		return hObject.ResponseText
}

; ===================================================================================================================
; Gdip_SaveImageToStream()
;	call Gdip_Startup() before using
; Parameters:
;	pBitmap		- A handle to bitmap
; Return values:
;    -1	:	extension error
;    -2	:	gdiplus.dll is not loaded
; ===================================================================================================================
Gdip_SaveImageToStream(pBitmap, Extension:="PNG", Quality:=75){
	nCount:=0, nSize:=0, _p:=0, Ptr:=A_PtrSize ? "UPtr" : "UInt"
	if !RegExMatch(Extension, "^(?i:BMP|DIB|RLE|JPG|JPEG|JPE|JFIF|GIF|TIF|TIFF|PNG)$")
		return -1

	Extension:="." Extension
	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2

	If (A_IsUnicode){
		StrGet_Name:="StrGet"
		N:=(A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			sString:=%StrGet_Name%(NumGet(ci, (idx:=(48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			pCodec:=&ci+idx
			break
		}
	} else {
		N:=(A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			Location:=NumGet(ci, 76*(A_Index-1)+44)
			nSize:=DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			pCodec:=&ci+76*(A_Index-1)
			break
		}
	}
	if !pCodec
		return -3

	if (Quality !=75)
	{
		Quality:=(Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if RegExMatch(Extension, "^\.(?i:JPG|JPEG|JPE|JFIF)$")
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			nCount:=NumGet(EncoderParameters, "UInt")
			N:=(A_AhkVersion < 2) ? nCount : "nCount"
			Loop %N%
			{
				elem:=(24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad:=A_PtrSize=8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt")=1) && (NumGet(EncoderParameters, elem+20, "UInt")=6)
				{
					_p:=elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, _p+0)+20, "UInt")), "UInt")
					break
				}
			}
		}
	}
	DllCall("ole32\CreateStreamOnHGlobal", Ptr, 0, "int", 1, "ptr*", pStream)
	DllCall("gdiplus\GdipSaveImageToStream", Ptr, pBitmap, Ptr, pStream, Ptr, pCodec, "uint", _p ? _p : 0)
	DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", pBitmap)
	Return pStream
}

StreamToBase64(pStream){
	If pStream<=0
		Return
	Ptr:=A_PtrSize ? "UPtr" : "UInt"
	DllCall("ole32\GetHGlobalFromStream", Ptr, pStream, "Ptr*", hMemory)
	pMemory:=DllCall("GlobalLock", Ptr, hMemory, Ptr)
	pSize:=DllCall("GlobalSize", Ptr, hMemory, Ptr)
	DllCall("GlobalUnlock", Ptr, hMemory)
	Return Base64.Encode(pMemory,pSize)
}

BitmapToBase64(pBitmap, Extension:="PNG", Quality:=75){
	Return StreamToBase64(pStream:=Gdip_SaveImageToStream(pBitmap, Extension, Quality)),ObjRelease(pStream)
}

Class Base64 {
	; ===================================================================================================================
	; Base64.Encode()
	; https://docs.microsoft.com/zh-cn/windows/win32/api/wincrypt/nf-wincrypt-cryptbinarytostringa
	; Parameters:
	;    VarIn  - A pointer to the array of bytes to be converted into a string
	;    SizeIn - Size of the input buffer in bytes
	;    Codec  - CRYPT_STRING_BASE64 0x00000001
	;			  CRYPT_STRING_NOCRLF 0x40000000
	; Return values:
	;    On success: Variable containing a null-terminated Base64 encoded string
	;    On failure: False
	; Remarks:
	;    VarIn may contain any binary contents including NUll bytes.
	; ===================================================================================================================
	Encode(VarIn, SizeIn, Codec:=0x40000001)
	{
		If !DllCall("crypt32\CryptBinaryToString", "Ptr", VarIn, "Uint", SizeIn, "Uint", Codec, "Ptr", 0, "UintP", nSize)
			Return False
		VarSetCapacity(VarOut, nSize << (A_IsUnicode?1:0))
		If !DllCall("crypt32\CryptBinaryToString", "Ptr", VarIn, "Uint", SizeIn, "Uint", Codec, "Ptr", &VarOut, "UintP", nSize)
			Return False
		Return StrGet(&VarOut, (A_IsUnicode ? "utf-16" : "cp0"))
	}
	; ===================================================================================================================
	; Base64.Decode()
	; https://docs.microsoft.com/zh-cn/windows/win32/api/wincrypt/nf-wincrypt-cryptstringtobinarya
	; Parameters:
	;    VarIn  - Variable containing a null-terminated Base64 encoded string
	;    VarOut - Variable to receive the decoded buffer
	;    Codec  - CRYPT_STRING_BASE64 0x00000001
	; Return values:
	;    On success: Number of bytes copied to VarOut
	;    On failure: False
	; Remarks:
	;    VarOut may contain any binary contents including NUll bytes.
	; ===================================================================================================================
	Decode(VarIn, ByRef VarOut, Codec:=0x00000001)
	{
		If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &VarIn, "UInt", 0, "UInt", Codec, "Ptr", 0, "UIntP", SizeOut, "Ptr", 0, "Ptr", 0)
			Return False
		VarSetCapacity(VarOut, SizeOut, 0)
		If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &VarIn, "UInt", 0, "UInt", Codec, "Ptr", &VarOut, "UIntP", SizeOut, "Ptr", 0, "Ptr", 0)
			Return False
		Return SizeOut
	}
}

Class bdocr
{
	; ===================================================================================================================
	; https://console.bce.baidu.com/ai
	; Parameters:
	;	API_KEY,SECRET_KEY
	;	Access_token
	; Return values:
	;	On success	- bdocr object
	;	On failure	- 0
	; Usages:
	;	ocr:=new bdocr(API_KEY,SECRET_KEY)
	;	ocr:=new bdocr(Access_token)
	; ===================================================================================================================
	__New(API_KEY:="",SECRET_KEY:="",Access_token:=""){
		If !SECRET_KEY&&InStr(API_KEY, ".")
			Access_token:=API_KEY, API_KEY:=""
		If (API_KEY&&SECRET_KEY){
			url:="https://aip.baidubce.com/oauth/2.0/token"
			Response:=Requests(url,"Post","grant_type=client_credentials&client_id=" API_KEY "&client_secret=" SECRET_KEY)
			If RegExMatch(Response, """access_token"":\s?""(.*?)""", token)
				Access_token:=token1
			Else
				Return 0
		} Else If Access_token {
			url:="https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=" Access_token
			If RegExMatch(Requests(url), """error_code"":\s?110")
				Return 0
		} Else
			Return 0
		this.Access_token:=Access_token, this.Response:=""
	}

	__Call(method, args){
		If (method!="GetOcr")
			Return this.GetOcr(args, method)
	}

	__Get(Key){
		static quotclosings:={0:",",1:"\}",2:"\]",3:""""}
		result:="", index:=1
		If RegExMatch(this.Response, "O)""" Key """:\s?(\S)", Match){
			quotclosing:=quotclosings[InStr("{[""",Match[1])], quotbegining:=InStr("{[",Match[1])?"\" Match[1]:(quotclosing=","?"":Match[1])
		} Else
			Return
		While (index:=RegExMatch(this.Response, "O)""" Key """:\s?(" quotbegining ".*?" quotclosing ")", Match, index))
			index+=Match.Len, result .= Trim(Match[1],""",") "`n"
		Return result
	}

	; ===================================================================================================================
	; For more information on http://ai.baidu.com/docs#/OCR-API/e1bd77f3
	; Parameters:
	;	data	-	url (http://...)
	;			or	picture file path (d:\\1.png)
	;			or	picture_base64string (iVBORw0KGgoAAAANSUhEUgAAA...)
	;			or	Handle to the bitmap (123456789)
	;			or	object {"image":"iVBORw0KGgoAAAANSUhEUgAAA..." or "url":"http://..." or "HBITMAP":123456789
	;				,"language_type":"CHN_ENG"
	;				,"probability":"true" ...}
	;	apitype	-	general_basic,handwriting,webimage,general ...
	; Usages:
	;	ocr.general_basic("d:\\1.png")	or	ocr.GetOcr("d:\\1.png","general_basic")
	; Return values:
	;	json	-	{"log_id": 3786144210529158018, "words_result_num": 1, "words_result": [{"words": "百度","probability": {"variance": 0.016393, "average": 0.951086, "min": 0.549352}}]}
	;	ocr.wrods				"百度"
	;	ocr.words_result_num	1
	;	ocr.probability			{"variance": 0.016393, "average": 0.951086, "min": 0.549352}
	; ===================================================================================================================
	GetOcr(data, apitype:="general_basic"){
		BD_Url:="https://aip.baidubce.com/rest/2.0/ocr/v1/" apitype "?access_token=" this.Access_token
		postdata:="", this.Response:=""
		If !IsObject(data){
			If InStr(data, "http://")
				postdata:="url=" UrlEncode(data)
			Else If FileExist(data){
				FileGetSize, bytes, %data%
				FileRead, bin, *c %data%
				postdata:="image=" UrlEncode(Base64.Encode(&bin,bytes))
			} Else If data is integer
				postdata:="image=" UrlEncode(BitmapToBase64(data))
			Else If RegExMatch(data, "^[\da-zA-Z+/]+$")
				postdata:="image=" UrlEncode(data)
			If !RegExMatch(postdata,"=.+")
				Return -1
		} Else {
			Parameters:=""
			For key,value In data
			{
				If (key="url")
					postdata:="url=" UrlEncode(value)
				Else If (key="image"){
					If RegExMatch(value, "^[\da-zA-Z+/]+$")
						postdata:="image=" UrlEncode(value)
				} Else If (key="file"){
					If FileExist(value)
					{
						FileGetSize, bytes, %value%
						FileRead, bin, *c %value%
						postdata:="image=" UrlEncode(Base64.Encode(&bin,bytes))
					}
				} Else If (key="HBITMAP"){
					If value Is Integer
						postdata:="image=" UrlEncode(BitmapToBase64(value))
				} Else
					Parameters .= "&" key "=" (value="1"?"true":value="0"?"false":UrlEncode(value))
			}
			If !RegExMatch(postdata,"=.+")
				Return -1
			postdata .= Parameters
		}
		this.Response:=Requests(BD_Url, "POST", postdata, {"Content-Type":"application/x-www-form-urlencoded"}, "UTF-8")
		Return this.Response
	}
	; ===================================================================================================================
	; For more information on http://ai.baidu.com/docs#/OCR-API/e1bd77f3

	; ===================================================================================================================
	GetPjOcr(data, apitype:="general_basic"){
		BD_Url:="https://aip.baidubce.com/rest/2.0/ocr/v1/" apitype "?access_token=" this.Access_token
		postdata:="", this.Response:=""
		If !IsObject(data){
			If InStr(data, "http://")
				postdata:="url=" UrlEncode(data)
			Else If FileExist(data){
				FileGetSize, bytes, %data%
				FileRead, bin, *c %data%
				postdata:="image=" UrlEncode(Base64.Encode(&bin,bytes))
			} Else If data is integer
				postdata:="image=" UrlEncode(BitmapToBase64(data))
			Else If RegExMatch(data, "^[\da-zA-Z+/]+$")
				postdata:="image=" UrlEncode(data)
			If !RegExMatch(postdata,"=.+")
				Return -1
		} Else {
			Parameters:=""
			For key,value In data
			{
				If (key="url")
					postdata:="url=" UrlEncode(value)
				Else If (key="image"){
					If RegExMatch(value, "^[\da-zA-Z+/]+$")
						postdata:="image=" UrlEncode(value)
				} Else If (key="file"){
					If FileExist(value)
					{
						FileGetSize, bytes, %value%
						FileRead, bin, *c %value%
						postdata:="image=" UrlEncode(Base64.Encode(&bin,bytes))
					}
				} Else If (key="HBITMAP"){
					If value Is Integer
						postdata:="image=" UrlEncode(BitmapToBase64(value))
				} Else
					Parameters .= "&" key "=" (value="1"?"true":value="0"?"false":UrlEncode(value))
			}
			If !RegExMatch(postdata,"=.+")
				Return -1
			postdata .= Parameters
		}
		this.Response:=Requests(BD_Url, "POST", postdata, {"Content-Type":"application/x-www-form-urlencoded"}, "UTF-8")
		Return this.Response
	}
}