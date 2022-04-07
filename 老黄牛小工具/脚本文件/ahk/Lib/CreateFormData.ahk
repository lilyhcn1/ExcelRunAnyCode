Skip to content
 
Search…
All gists
Back to GitHub
@lilyhcn1 
@tmplinshi
tmplinshi/CreateFormData.ahk
Last active 2 months ago • Report abuse
10
1
 Code
 Revisions 12
 Stars 10
 Forks 1
<script src="https://gist.github.com/tmplinshi/8428a280bba58d25ef0b.js"></script>
https://autohotkey.com/boards/viewtopic.php?f=6&t=7647
CreateFormData.ahk
/*
	CreateFormData - Creates "multipart/form-data" for http post
	https://www.autohotkey.com/boards/viewtopic.php?t=7647
	Usage: CreateFormData(ByRef retData, ByRef retHeader, objParam)
		retData   - (out) Data used for HTTP POST.
		retHeader - (out) Content-Type header used for HTTP POST.
		objParam  - (in)  An object defines the form parameters.
		            To specify files, use array as the value. Example:
		                objParam := { "key1": "value1"
		                            , "upload[]": ["1.png", "2.png"] }
	Requirements: BinArr.ahk -- https://gist.github.com/tmplinshi/a97d9a99b9aa5a65fd20
	Version    : 1.30 / 2019-01-13 - The file parameters are now placed at the end of the retData
	             1.20 / 2016-06-17 - Added CreateFormData_WinInet(), which can be used for VxE's HTTPRequest().
	             1.10 / 2015-06-23 - Fixed a bug
	             1.00 / 2015-05-14
*/

; Used for WinHttp.WinHttpRequest.5.1, Msxml2.XMLHTTP ...
CreateFormData(ByRef retData, ByRef retHeader, objParam) {
	New CreateFormData(retData, retHeader, objParam)
}

; Used for WinInet
CreateFormData_WinInet(ByRef retData, ByRef retHeader, objParam) {
	New CreateFormData(safeArr, retHeader, objParam)

	size := safeArr.MaxIndex() + 1
	VarSetCapacity(retData, size, 1)
	DllCall("oleaut32\SafeArrayAccessData", "ptr", ComObjValue(safeArr), "ptr*", pdata)
	DllCall("RtlMoveMemory", "ptr", &retData, "ptr", pdata, "ptr", size)
	DllCall("oleaut32\SafeArrayUnaccessData", "ptr", ComObjValue(safeArr))
}

Class CreateFormData {

	__New(ByRef retData, ByRef retHeader, objParam) {

		CRLF := "`r`n"

		Boundary := this.RandomBoundary()
		BoundaryLine := "------------------------------" . Boundary

		; Loop input paramters
		binArrs := []
		fileArrs := []
		For k, v in objParam
		{
			If IsObject(v) {
				For i, FileName in v
				{
					str := BoundaryLine . CRLF
					     . "Content-Disposition: form-data; name=""" . k . """; filename=""" . FileName . """" . CRLF
					     . "Content-Type: " . this.MimeType(FileName) . CRLF . CRLF
					fileArrs.Push( BinArr_FromString(str) )
					fileArrs.Push( BinArr_FromFile(FileName) )
					fileArrs.Push( BinArr_FromString(CRLF) )
				}
			} Else {
				str := BoundaryLine . CRLF
				     . "Content-Disposition: form-data; name=""" . k """" . CRLF . CRLF
				     . v . CRLF
				binArrs.Push( BinArr_FromString(str) )
			}
		}

		binArrs.push( fileArrs* )

		str := BoundaryLine . "--" . CRLF
		binArrs.Push( BinArr_FromString(str) )

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
Example.ahk
SetWorkingDir %A_ScriptDir%
#Include CreateFormData.ahk
#Include BinArr.ahk ; https://gist.github.com/tmplinshi/a97d9a99b9aa5a65fd20

if !FileExist("1.png")
	throw "1.png not exist"
if !FileExist("2.png")
	throw "2.png not exist"
            
objParam := { "btSubmit": "Upload It!"
            , "adult": "no"
            , "mode": "local"
            , "forumurl": "http://postimage.org/"
            , "upload[]": ["2.png", "1.png"]
            , "um": "computer"
            , "MAX_FILE_SIZE": 16777216
            , "optsize": 0 }
CreateFormData(postData, hdr_ContentType, objParam)

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("POST", "http://postimage.org/", true)
whr.SetRequestHeader("Content-Type", hdr_ContentType)
whr.SetRequestHeader("Referer", "http://postimage.org/")
whr.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko")
whr.Option(6) := False ; No auto redirect
whr.Send(postData)
whr.WaitForResponse()
Run, % whr.GetResponseHeader("Location")
return
@lilyhcn1
 
Leave a comment
未选择文件
Attach files by dragging & dropping, selecting or pasting them.
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
