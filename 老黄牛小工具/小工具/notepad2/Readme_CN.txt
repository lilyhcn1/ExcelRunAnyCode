Notepad2-mod x86 简体中文化计划

2012/9/8
Notepad2-mod 4.2.25 rev774 x86 简体中文版发布
2012/9/26
Notepad2-mod 4.2.25 rev796 x86 简体中文版发布
2013/1/26
Notepad2-mod 4.2.25 rev823 x86 简体中文版发布
2013/3/21
Notepad2-mod 4.2.25 rev837 x86 简体中文版发布
2013/4/9
Notepad2-mod 4.2.25 rev844 x86 简体中文版发布
2013/5/17
Notepad2-mod 4.2.25 rev855 x86 简体中文版发布
2013/5/22
Notepad2-mod 4.2.25 rev856 x86 简体中文版发布
2013/7/23
Notepad2-mod 4.2.25 rev870 x86 简体中文版发布
2013/12/15
Notepad2-mod 4.2.25 rev890 x86 简体中文版发布
2013/12/17
Notepad2-mod 4.2.25 rev891 x86 简体中文版发布
2014/1/3
Notepad2-mod 4.2.25 rev897 x86 简体中文版发布
2014/3/24
Notepad2-mod 4.2.25 rev904 x86 简体中文版发布
2014/4/21
Notepad2-mod 4.2.25 rev906 x86 简体中文版发布
2014/10/3
Notepad2-mod 4.2.25 rev935 x86 简体中文版发布
2014/12/4
Notepad2-mod 4.2.25 rev939 x86 简体中文版发布
2015/2/23
Notepad2-mod 4.2.25 rev940 x86 简体中文版发布
2015/3/11
Notepad2-mod 4.2.25 rev945 x86 简体中文版发布
2015/4/19
Notepad2-mod 4.2.25 rev953 x86 简体中文版发布
2015/5/27
Notepad2-mod 4.2.25 rev954 x86 简体中文版发布
2015/6/23
Notepad2-mod 4.2.25 rev955 x86 简体中文版发布
2015/9/15
Notepad2-mod 4.2.25 rev964 x86 简体中文版发布
2016/1/29
Notepad2-mod 4.2.25 rev970 x86 简体中文版发布
2016/3/29
Notepad2-mod 4.2.25 rev972 x86 简体中文版发布
2016/6/6
Notepad2-mod 4.2.25 rev980 x86 简体中文版发布
2016/9/7
Notepad2-mod 4.2.25 rev985 x86 简体中文版发布
2017/3/28
Notepad2-mod 4.2.25 rev991 x86 简体中文版发布
2017/6/15
Notepad2-mod 4.2.25 rev995 x86 简体中文版发布
2017/08/13 
Notepad2-mod 4.2.25 rev998 x86 简体中文版发布

Semidio
Semidio7@gmail.com

附录：通过映像劫持实现Notepad2替换记事本
1、打开注册表创建如下注册表项：HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe，如果无法修改，需要先右键取得权限；
2、在notepad.exe注册表项中，创建名为Debugger的字符串值(REG_SZ)；
3、修改字符串值Debugger的数据为Notepad2.exe的完整路径，最后以 /z参数结尾。(如："D:\Program Files\Notepad2\Notepad2.exe" /z)