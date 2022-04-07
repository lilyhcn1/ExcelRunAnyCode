;打开群，分享链接。请一定要先配置D:\老黄牛小工具\配置文件\myconf.ini
#Include %A_LineFile%\..\JSON.ahk
;读取文件
FileRead, jsonstr, d:\老黄牛小工具\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := parsed["outputfile"]
if(fv=error)then{
  Loop %0%{  ; 获取传参的长文件名
      GivenPath := %A_Index%  ; 获取下一个命令行参数.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
  PathToCopy:=LongPath  
}else{
  PathToCopy :=fv
}


PathToCopy:=LongPath
FileToClipboard(PathToCopy)
;打开群
myconinifile := "D:\老黄牛小工具\配置文件\myconf.ini"
if FileExist(myconinifile){
IniRead, smburl, %myconinifile%, SecMsg, smburl
;msgbox % smburl
if(smburl ="ERROR"){
    msgbox , %myconinifile% 中的相关配置不存在，请确保【SecMsg】节中的smburl存在！~
    }else{
    ; 只获取上面的单独的文件名:
      ;msgbox % PathToCopy
      SplitPath, PathToCopy, name, dir, ext, name_no_ext, drive
      newfilename = %smburl%\%name%
      ;msgbox ,  %newfilename%
      ;msgbox % filename
      FileDelete, %newfilename%
      FileCopy, %PathToCopy%, %newfilename%
      if FileExist(newfilename){
      TrayTip,,% "已复制文件到共享文件夹目录。"
      }else{
      TrayTip,,% "Error 哪里出错了！~~"
      }
      
  }
}else{
  msgbox , %myconinifile% 这个文件不存在，请创建后再试！
}
  return
;------------------函数区-------------------------------
/*
	path_list =
	(
	d:\test.txt
	d:\test2.txt
	)
	FileToClipboard(path_list)
*/
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