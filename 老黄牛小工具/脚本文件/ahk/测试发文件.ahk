MsgBox % uploadfile("D:\老黄牛小工具\脚本文件\ahk\test.mp3","success.mp3")
 
uploadfile(src,dst){
    IfExist % src
    {
        objParam := {"upfile":[src],"dst":dst} ;post数据
        CreateFormData(PostData, hdr_ContentType, objParam)
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", "http://135.230.71.1/upload.php", true) ;地址
        whr.SetRequestHeader("Content-Type", hdr_ContentType)
        whr.Send(PostData)
        whr.WaitForResponse()
        return whr.ResponseText
    }
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