#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------


updateweb := readjsonconkey("updateweb")
f := readjsonconkey("file")
nowfield := readjsonconkey("nowfield")
conall := readjsonconkey("conall")
excelpath :=getjsonkey("excelpath")
;uploadfile := getjsonkey("contents","fdf")
;msgbox, % file
aa := uploadfile(updateweb, f,nowfield)
arr := []
arr["fileurl"] := aa
savearrtojson(arr)
;msgbox % aa
;writetext(aa, savehtml)
run, %savehtml%
uploadfile(url, src, nowfield){
    ;msgbox , %url%
    IfExist % src
    {
        objParam := {"file":[src], "conall":conall, "nowfield":nowfield} ;post数据
        CreateFormData(PostData, hdr_ContentType, objParam)
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", url, true) ;地址
        whr.SetRequestHeader("Content-Type", hdr_ContentType)
        whr.Send(PostData)
        whr.WaitForResponse()
        return whr.ResponseText
    }
}
