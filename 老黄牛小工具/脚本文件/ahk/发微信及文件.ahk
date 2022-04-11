#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.引用函数----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="微信名"
input2 := "发送文本"
input3 := "发送文件"
info := "运行结果"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
;-------------1.读取输入变量----------
if (val1 != "" ){  ;正常运行

main()
arr2[info] :="√"

}else{  ;出错后的处理
    arr2[input1] := "老黄牛"
    arr2[input2] := "要发送的文本"
    arr2[input3] := "D:\老黄牛小工具\ExcelQuery\temp\temp.json"    
    
    arr2[info] := "标题行找不到关键词【" input1 "】或为空，请检查。"
}

;-------------2.最终写入变量----------
savearr2json(arr2)

main(){
;------------------------
;引入变量
global val1,val2,val3
;-----------引用变量-------------

FileToClipboard(val3)
WinShow,微信 ahk_class WeChatMainWndForPC
WinActivate,微信 ahk_class WeChatMainWndForPC
Sleep,300
Send ^f
Sleep,200
Send {text} %val1%
Sleep,1500
OutputDebug, "找到"
Send {Enter}
OutputDebug, "进入"
Sleep 1000
OutputDebug,  "粘贴"
Send ^v
Sleep 1000
Send {Enter}
Sleep 2000
SendInput % "{TEXT}" . val2
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 100
Send {Enter}

}

Explorer_GetSelection(hwnd="")   
{  
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")  
    WinGetClass class, ahk_id %hwnd%  
    if (process != "explorer.exe")  
        return  
    if (class ~= "Progman|WorkerW") {  
            ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%  
            Loop, Parse, files, `n, `r  
                ToReturn .= A_Desktop "\" A_LoopField "`n"  
        } else if (class ~= "(Cabinet|Explore)WClass") {  
            for window in ComObjCreate("Shell.Application").Windows 
   {
    try{
                if (window.hwnd==hwnd)  
                    sel := window.Document.SelectedItems  
    }catch e {
     continue
   }
   }
            for item in sel  
                ToReturn .= item.path "`n"  
        }  
    return Trim(ToReturn,"`n")  
} 

;~ 当前内容如果是非文件,则清空并写入目标文件,如果是文件,则将目标文件加入剪贴板行列
;~ 就是将不同目录的文件添加到剪贴板,可以一并复制
 
FileToClipboard(PathToCopy, Method="copy")
{
 ; 展开为完整路径
  Loop, Parse, PathToCopy, `n, `r
   PathToCopy_Full .= "`n" GetFullPath(A_LoopField)
  PathToCopy := Trim(PathToCopy_Full, "`n")
 
 FileCount:=0
 PathLength:=0
 
 ; Count files and total string length
 Loop,Parse,PathToCopy,`n,`r
 {
  FileCount++
  PathLength += StrLen(A_LoopField)
 }
 
 pid:=DllCall("GetCurrentProcessId","uint")
 hwnd:=WinExist("ahk_pid " . pid)
 ; 0x42 = GMEM_MOVEABLE(0x2) | GMEM_ZEROINIT(0x40)
 hPath := DllCall("GlobalAlloc","uint",0x42,"uint",20 + (PathLength + FileCount + 1) * 2,"UPtr")
 pPath := DllCall("GlobalLock","UPtr",hPath)
 NumPut(20,pPath+0),pPath += 16 ; DROPFILES.pFiles = offset of file list
 NumPut(1,pPath+0),pPath += 4 ; fWide = 0 -->ANSI,fWide = 1 -->Unicode
 Offset:=0
 Loop,Parse,PathToCopy,`n,`r ; Rows are delimited by linefeeds (`r`n).
  offset += StrPut(A_LoopField,pPath+offset,StrLen(A_LoopField)+1,"UTF-16") * 2
 
 DllCall("GlobalUnlock","UPtr",hPath)
 DllCall("OpenClipboard","UPtr",hwnd)
 DllCall("EmptyClipboard")
 DllCall("SetClipboardData","uint",0xF,"UPtr",hPath) ; 0xF = CF_HDROP
 
 ; Write Preferred DropEffect structure to clipboard to switch between copy/cut operations
 ; 0x42 = GMEM_MOVEABLE(0x2) | GMEM_ZEROINIT(0x40)
 mem := DllCall("GlobalAlloc","uint",0x42,"uint",4,"UPtr")
 str := DllCall("GlobalLock","UPtr",mem)
 
 if (Method="copy")
  DllCall("RtlFillMemory","UPtr",str,"uint",1,"UChar",0x05)
 else if (Method="cut")
  DllCall("RtlFillMemory","UPtr",str,"uint",1,"UChar",0x02)
 else
 {
  DllCall("CloseClipboard")
  return
 }
 
 DllCall("GlobalUnlock","UPtr",mem)
 
 cfFormat := DllCall("RegisterClipboardFormat","Str","Preferred DropEffect")
 DllCall("SetClipboardData","uint",cfFormat,"UPtr",mem)
 DllCall("CloseClipboard")
 return
}
 
GetFullPath(fpath)
{
 Loop, %fpath%
  Return, A_LoopFileLongPath
}



