  Loop %0%{  ; 获取传参的长文件名
      GivenPath := %A_Index%  ; 获取下一个命令行参数.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
clipboard = %LongPath%
TrayTip , 老黄牛小工具, 路径已复制到剪贴板！~