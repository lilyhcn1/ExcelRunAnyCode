;��Ⱥ���������ӡ���һ��Ҫ������D:\�ϻ�ţС����\�����ļ�\myconf.ini
#Include %A_LineFile%\..\JSON.ahk
;��ȡ�ļ�
FileRead, jsonstr, d:\�ϻ�ţС����\ExcelQuery\temp\temp.json
parsed := JSON.Load(jsonstr)
fv := parsed["outputfile"]
if(fv=error)then{
  Loop %0%{  ; ��ȡ���εĳ��ļ���
      GivenPath := %A_Index%  ; ��ȡ��һ�������в���.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
  PathToCopy:=LongPath  
}else{
  PathToCopy :=fv
}


;�����ļ���������
FileToClipboard(PathToCopy)
;��Ⱥ
myconinifile := "D:\�ϻ�ţС����\�����ļ�\myconf.ini"
if FileExist(myconinifile){
IniRead, tobesort, %myconinifile%, SecMsg, tobesort
;msgbox % tobesort
if(tobesort ="ERROR"){
    msgbox , %myconinifile% �е�������ò����ڣ���ȷ����SecMsg�����е�smburl���ڣ�~
    }else{
    ; ֻ��ȡ����ĵ������ļ���:
      ;msgbox % PathToCopy
      SplitPath, PathToCopy, name
      newfilename = %tobesort%\%name%
      ;msgbox ,  %newfilename%
      ;msgbox % filename
      FileDelete, %newfilename%
      FileCopy, %PathToCopy%, %newfilename%
      TrayTip,,%PathToCopy%`n�Ѹ����ļ���������Ŀ¼��
  }
}else{
  msgbox , %myconinifile% ����ļ������ڣ��봴�������ԣ�
}
  return
;------------------������-------------------------------
/*
	path_list =
	(
	d:\test.txt
	d:\test2.txt
	)
	FileToClipboard(path_list)
*/
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