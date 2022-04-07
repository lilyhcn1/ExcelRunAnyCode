global my_dll_buffer_size := 4000
global my_dll_use_map := {"cpp2ahk.dll" : {"func" : "cpp2ahk", "divproc" : 0}, "opencv_dll_creat.dll" : { "func" : "opencv_ImageSearch", "divproc" : 0}, "TXGYMailCamera.dll" : {"func" : "CameraWindow", "divproc" : 0}, "PrScrn.dll" : {"func" : "PrScrn", "divproc" : 0}}
global is_log_open := true
load_all_dll_path()
load_all_dll_path()
{
    local
    global my_dll_use_map
    my_load_dll_all := ["opencv_dll_creat.dll","opencv_world341.dll","pthreadVC2.dll"]
    SplitPath,A_LineFile,,dir
    for k,v in my_load_dll_all
    {
        if(A_IsCompiled)
        {
            path :=  A_ScriptDir . "/lib/" . v
        }
        else
        {
            path := dir . "/" . v
        }
        DllCall("LoadLibrary", "Str", path, "Ptr")
    }
    for k,v in my_dll_use_map
    {
        if(A_IsCompiled)
        {
            my_dll_path := A_ScriptDir . "/lib/" . k
        }
        else
        {
            my_dll_path := dir . "/" . k
        }
        func := my_dll_use_map[k]["func"]
        my_dll_use_map[k]["divproc"] := DllCall("GetProcAddress", "Ptr", DllCall("LoadLibrary", "Str", my_dll_path, "Ptr"), "AStr", func, "Ptr")
    }
}

;spglog
; parameter 
;   mode : "info"  "war" "error"
spdlog(str := "", mode := "info")
{
    global my_dll_use_map
    in_func_info := {}
    in_func_info["func"] := "spglog"
    in_func_info["str"] := str
    in_func_info["mode"] := mode
    in_str := obj2json_local(in_func_info)

	VarSetCapacity(out_str,0)
	VarSetCapacity(out_str,my_dll_buffer_size)
    StrPutVar(in_str, buf, "UTF-8")
    if(is_log_open)
    {
      result := DllCall(my_dll_use_map["cpp2ahk.dll"]["divproc"], "str", buf, "str", out_str, "Cdecl Int")
      if(result != 0)
      {
          MsgBox, dll call error! result
      }
      out_str := StrGet(&out_str, my_dll_buffer_size, "UTF-8")
      newObj := json2obj_local(out_str)
      return newObj
    }
}
StrPutVar(string, ByRef var, encoding)
{
    ; 确定容量.
    VarSetCapacity( var, StrPut(string, encoding)
        ; StrPut 返回字符数, 但 VarSetCapacity 需要字节数.
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
    ; 复制或转换字符串.
    return StrPut(string, &var, encoding)
}

/*
;------------------------------------
;  json转码纯AHK实现 v2.0  By FeiYue
;------------------------------------
*/

json2obj_local(s)  ; Json字符串转AHK对象
{
  static rep:=[ ["\\","\u005c"], ["\""",""""]
    , ["\r","`r"], ["\n","`n"], ["\t","`t"]
    , ["\/","/"], ["\b","`b"], ["\f","`f"] ]
  if !(p:=RegExMatch(s, "[\{\[]", r))
    return
  SetBatchLines, % (bch:=A_BatchLines)?"-1":"-1"
  obj:=[], stack:=[], arr:=obj, flag:=r
  , key:=(flag="{" ? "":1), keyok:=0
  While p:=RegExMatch(s, "\S", r, p+StrLen(r))
  {
    if (r="{" or r="[")       ; 如果是 左括号
    {
      arr[key]:=[], stack.Push(arr, flag)
      , arr:=arr[key], flag:=r
      , key:=(flag="{" ? "":1), keyok:=0
    }
    else if (r="}" or r="]")  ; 如果是 右括号
    {
      if !stack.MaxIndex()
        Break
      flag:=stack.Pop(), arr:=stack.Pop()
      , key:=(flag="{" ? "":arr.MaxIndex()), keyok:=0
    }
    else if (r=",")           ; 如果是 逗号
    {
      key:=(flag="{" ? "":Round(key)+1), keyok:=0
    }
    else if (r="""")          ; 如果是 双引号
    {
      if !(RegExMatch(s, """((?:\\[\s\S]|[^""\\])*)""", r, p)=p)
        Break
      if InStr(r1, "\")
      {
        For k,v in rep
          r1:=StrReplace(r1, v.1, v.2)
        While RegExMatch(r1, "\\u[0-9A-Fa-f]{4}", k)
          r1:=StrReplace(r1, k, Chr("0x" SubStr(k,3)))
      }
      if (flag="{" and keyok=0)  ; 如果是 键名
      {
        p+=StrLen(r)
        if !(RegExMatch(s, "\s*:", r, p)=p)
          Break
        key:=r1, keyok:=1
      }
      else arr[key]:=r1
    }
    else if RegExMatch(s, "[\w\+\-\.]+", r, p)=p
    {
      arr[key]:=r  ; 如果是 数字、true、false、null
    }
    else Break
  }
  SetBatchLines, %bch%
  return obj
}

obj2json_local(obj, space:="")  ; AHK对象转Json字符串
{
  ; 默认不替换 "/-->\/" 与 "Unicode字符-->\uXXXX"
  static rep:=[ ["\\","\"], ["\""",""""]  ; , ["\/","/"]
    , ["\r","`r"], ["\n","`n"], ["\t","`t"]
    , ["\b","`b"], ["\f","`f"] ]
  if !IsObject(obj)
  {
    if obj is Number
      return obj
    if (obj=="true" or obj=="false" or obj=="null")
      return obj
    For k,v in rep
      obj:=StrReplace(obj, v.2, v.1)
    ; While RegExMatch(obj, "[^\x20-\x7e]", k)
    ;   obj:=StrReplace(obj, k, Format("\u{:04x}",Ord(k)))
    return """" obj """"
  }
  is_arr:=1  ; 是简单数组
  For k,v in obj
    if (k!=A_Index) and !(is_arr:=0)
      Break
  s:="", space2:=space . "    "
  For k,v in obj
    s.= "`r`n" space2 . (is_arr ? ""
      : """" Trim(%A_ThisFunc%(Trim(k)),"""") """: ")
      . %A_ThisFunc%(v,space2) . ","
  return (is_arr?"[":"{") . Trim(s,",")
       . "`r`n" space . (is_arr?"]":"}")
}
;t = 20 强制替换
SmartZip(s, o, t = 4)
{
    IfNotExist, %s%
        return, -1
    oShell := ComObjCreate("Shell.Application")
    if InStr(FileExist(o), "D") or (!FileExist(o) and (SubStr(s, -3) = ".zip"))
    {
        if !o
            o := A_ScriptDir
        else ifNotExist, %o%
                FileCreateDir, %o%
        Loop, %o%, 1
            sObjectLongName := A_LoopFileLongPath
        oObject := oShell.NameSpace(sObjectLongName)
        Loop, %s%, 1
        {
            oSource := oShell.NameSpace(A_LoopFileLongPath)
            oObject.CopyHere(oSource.Items, t)
        }
    }
}

run_as_admin()
{
    full_command_line := DllCall("GetCommandLine", "str")
    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        try
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }
}

mOpencvPicSearch(picPath,x1,y1,x2,y2,thresh, hold)
{
	local
  global my_dll_use_map
	str1 := ""
	rtn := ""
	VarSetCapacity(str,0)
	VarSetCapacity(str,2000)

  result := DllCall(my_dll_use_map["opencv_dll_creat.dll"]["divproc"],"AStr",picPath,"Int", x1,"Int", y1,"Int", x2,"Int", y2,"Int",thresh,"Str", str,"Cdecl Int")
	if(ErrorLevel != 0)
    {
        MsgBox, dll调用错误 %ErrorLevel%
        return 0
    }
    if(result != 0)
    {
        MsgBox, 参数错误 %result%
        return 0
    }
	rtn := StrGet(&str,2000,"CP0")
	InStr(rtn, "0_0_0", true)
	;MsgBox,% rtn

	arr2 := mStringSplit(rtn)
	for key,value in arr2
	{
		if(arr2[key][1] > hold )
		{
			value[2] := value[2] + x1
			value[3] := value[3] + y1
			return value
		}
	}
	return 0
}
mStringSplit(string)
{
  local
  inside_array := []
  this_color := []
  word_array := StrSplit(string, "|")
  Loop % word_array.MaxIndex()-1
  {
      this_color := word_array[a_index]
      inside_array[a_index]:= StrSplit(this_color, "_")
  }
  return inside_array
}

mylib_capture()
{
  local 
  global my_dll_use_map
  ;MsgBox,% my_dll_use_map["TXGYMailCamera.dll"]["divproc"]
  DllCall(my_dll_use_map["PrScrn.dll"]["divproc"])
}


mylib_run_with_32ahk()
{
    if((A_PtrSize=8&&A_IsCompiled="")||!A_IsUnicode){ ;32 bit=4  ;64 bit=8
    SplitPath,A_AhkPath,,dir
    if(!FileExist(correct:=dir "\AutoHotkeyU32.exe")){
	    MsgBox error
	    ExitApp
    }
    Run,"%correct%" "%A_ScriptName%",%A_ScriptDir%
    ExitApp
    return
    }
}