;===========================================
;   【AHK机器码生成器】 v2.0  By FeiYue
;
;   使用方法：
;
;   1、下载安装 TDM-GCC 64位版 到默认的安装目录，下载网址为：
;      https://sourceforge.net/projects/tdm-gcc/files/latest/download
;
;   2、下载安装 TCC 的 32位 和 64位版 到AHK的目录，下载网址为：
;      https://bellard.org/tcc/
;
;   3、选择C代码后，按【 Alt+C 】热键生成 GCC 编译的机器码，
;      或者按【 Ctrl+Alt+C 】热键生成 TCC 编译的机器码
;
;===========================================


!c::    ; 选择C代码后用 GCC 编译

^!c::   ; 选择C代码后用 TCC 编译

ClipSaved:=ClipboardAll
Clipboard=
Send {Ctrl Down}c{CtrlUp}
ClipWait, 3
s:=Clipboard, Clipboard:=ClipSaved
if s=
{
  MsgBox, 4096, Error, The contents of the copy are empty！
  Exit
}
Loop, 2 {
  i:=A_Index-1
  hex:=A_ThisLabel="!c" ? Gcc(s,i) : Tcc(s,i)
  hex:=RegExReplace("xxx" hex, ".{1,50}", "`r`n    . ""$0""")
  s%i%:=StrReplace(hex, ". ""xxx", (i ? "x64":"x32") ":=""")
}
MsgBox, 4096, MCode has been generated! (32 + 64)
  , % Clipboard:=s0 . s1
  . "`r`n    MCode(MyFunc, A_PtrSize=8 ? x64:x32)"
s:=s0:=s1:=""
return

Gcc(s, win64=0)
{
  dir:=A_IsCompiled ? A_ScriptDir : RegExReplace(A_AhkPath,"\\[^\\]+$")
  ;-----------------------------
  exe1=C:\TDM-GCC-64\bin\gcc.exe
  exe2=C:\TDM-GCC-64\bin\objcopy.exe
  ;-----------------------------
  IfNotExist, %exe1%
  {
    MsgBox, 4096, Tip, Can't Find %exe1% !
    return
  }
  FileDelete, % cpp:=dir "\5.c"
  FileDelete, % obj:=dir "\5.obj"
  FileDelete, % log:=dir "\5.log"
  FileDelete, % bin:=dir "\5.bin"
  FileAppend, %s%, %cpp%
  arg:=(win64 ? "-m64":"-m32") . " -O2"
  RunWait, %ComSpec% /c ""%exe1%" %arg% -c -o "%obj%" "%cpp%" 2>"%log%""
    ,, Hide
  IfNotExist, %obj%
  {
    FileRead, s, %log%
    FileDelete, %cpp%
    FileDelete, %log%
    MsgBox, 4096, C Compile Error, %s%
    return
  }
  RunWait, "%exe2%" -j .text -O binary "%obj%" "%bin%",, Hide
  hex:=bin2hex(bin)
  FileDelete, %cpp%
  FileDelete, %obj%
  FileDelete, %log%
  FileDelete, %bin%
  return, hex
}

Tcc(s, win64=0)
{
  dir:=A_IsCompiled ? A_ScriptDir : RegExReplace(A_AhkPath,"\\[^\\]+$")
  tcc:=dir (win64 ? "\TCC-64\tcc.exe" : "\TCC-32\tcc.exe")
  IfNotExist, %tcc%
  {
    MsgBox, 4096, Tip, Can't Find %tcc% !
    return
  }
/*
  ;-----------------------------
  ; if Tcc don't have "-Wl,--oformat=binary" parameter
  ;-----------------------------
  add1=`n int _Flag1_() { return 0x11111111; } `n
  add2=`n int _Flag2_() { return 0x11111111; } `n
  add3=`n int _Flag3_() { return 0x11111111; } `n
  s:=add1 . add2 . s . add3
  ;-----------------------------
*/
  FileDelete, % cpp:=dir "\5.c"
  FileDelete, % obj:=dir "\5.obj"
  FileDelete, % log:=dir "\5.log"
  FileAppend, % StrReplace(s,"`r"), %cpp%
  arg = -Wl,--oformat=binary -c -o "%obj%" "%cpp%"
  RunWait, %ComSpec% /c ""%tcc%" %arg% 2>"%log%"",, Hide
  IfNotExist, %obj%
  {
    FileRead, s, %log%
    FileDelete, %cpp%
    FileDelete, %log%
    MsgBox, 4096, C Compile Error, %s%
    return
  }
  hex:=bin2hex(obj)
/*
  ;-----------------------------
  ; if Tcc don't have "-Wl,--oformat=binary" parameter
  ;-----------------------------
  re:="i)B811111111.{0,16}?C3"
  p1:=RegExMatch(hex,re,r), n:=StrLen(r)
  p2:=InStr(hex,r,0,p1+n), p3:=InStr(hex,r,0,0), i:=0
  Loop, % (p2-(p1+n))//2
    if SubStr(hex,p2-i-2,2)!=SubStr(hex,p1-i-2,2)
      Break
    else i+=2
  j:=InStr(hex,SubStr(hex,p2-i,2),0,p2+n)
  hex:=(p1 and p2 and p3>p2) ? SubStr(hex,j,p3-i-j) : ""
  ;-----------------------------
*/
  FileDelete, %cpp%
  FileDelete, %obj%
  FileDelete, %log%
  return, hex
}

bin2hex(obj)
{
  VarSetCapacity(bin,1024), VarSetCapacity(bin,0)
  FileRead, bin, *c %obj%
  size:=VarSetCapacity(bin), p:=&bin
  VarSetCapacity(hex, (2*size+1)*(1+!!A_IsUnicode))
  SetBatchLines, % "-1" (bch:=A_BatchLines)/0
  SetFormat, IntegerFast, % "H" (fmt:=A_FormatInteger)/0
  Loop, %size%
    hex.=SubStr(0x100+(*p++),-1)
  SetFormat, IntegerFast, %fmt%
  SetBatchLines, %bch%
  return, hex
}

;
