  Loop %0%{  ; ��ȡ���εĳ��ļ���
      GivenPath := %A_Index%  ; ��ȡ��һ�������в���.
      Loop %GivenPath%, 1
          LongPath = %A_LoopFileLongPath%
  }
clipboard = %LongPath%
TrayTip , �ϻ�ţС����, ·���Ѹ��Ƶ������壡~