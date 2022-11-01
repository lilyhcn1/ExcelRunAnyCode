#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


updateweb := readjsonconkey("updateweb")
uploadfile := readjsonconkey("uploadfile")
conall := readjsonconkey("conall")
excelpath :=getjsonkey("excelpath")
;uploadfile := getjsonkey("contents","fdf")
tempcsv := uploadfile

aa := uploadfile(updateweb, tempcsv,conall)
savehtml =%excelpath%\管理文件.html

writetext(aa, savehtml)
run, %savehtml%
uploadfile(url, src, conall){
    ;msgbox , %url%
    IfExist % src
    {
        objParam := {"file":[src], "conall":conall} ;post数据
        CreateFormData(PostData, hdr_ContentType, objParam)
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", url, true) ;地址
        whr.SetRequestHeader("Content-Type", hdr_ContentType)
        whr.Send(PostData)
        whr.WaitForResponse()
        return whr.ResponseText
    }
}
