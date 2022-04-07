  Loop %0%{  ; 获取传参的长文件名
      GivenPath := %A_Index%  ; 获取下一个命令行参数.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
clipboard = %LongPath%
