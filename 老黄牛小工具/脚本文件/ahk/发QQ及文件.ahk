#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
SetWorkingDir %A_ScriptDir%
;-------------0.���ú���----------
arr2 := []

;BaiduSecretKey1 := readini("ApiKeys","BaiduSecretKey1")
input1 :="QQ��"
input2 := "�����ı�"
input3 := "�����ļ�"
info := "���н��"
val1 := readjsonconkey(input1)
val2 := readjsonconkey(input2)
val3 := readjsonconkey(input3)
;-------------1.��ȡ�������----------
if (val1 != "" ){  ;��������

main()
arr2[info] :="��"

}else{  ;�����Ĵ���
    arr2[input1] := "187277552"
    arr2[input2] := "Ҫ���͵��ı�"
    arr2[input3] := "D:\�ϻ�ţС����\ExcelQuery\temp\temp.json"    
    
    arr2[info] := "�������Ҳ����ؼ��ʡ�" input1 "����Ϊ�գ����顣"
}

;-------------2.����д�����----------
savearr2json(arr2)

main(){
;------------------------
;�������
global val1,val2,val3
;-----------���ñ���-------------

;---------����01�Ĵ����---------
Run % "tencent://message/?uin=" val1 "&Site=LG&Menu=yes"
Sleep,2500
FileToClipboard(val3)
Sleep 200
Send ^v
Sleep 1000
Send {Enter}
Sleep 2000
SendInput % "{TEXT}" . val2
Sleep % 500
SendInput % "{TEXT}" . ""
Sleep % 300
Send {Enter}    ;ȡ��ע�ͺ����ֱ�ӷ���
Sleep % 2000

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

;~ ��ǰ��������Ƿ��ļ�,����ղ�д��Ŀ���ļ�,������ļ�,��Ŀ���ļ��������������
;~ ���ǽ���ͬĿ¼���ļ���ӵ�������,����һ������
 
FileToClipboard(PathToCopy, Method="copy")
{
 ; չ��Ϊ����·��
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



