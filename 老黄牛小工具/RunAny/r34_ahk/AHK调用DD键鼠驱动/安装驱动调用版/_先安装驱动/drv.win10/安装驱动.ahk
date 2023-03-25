SetWorkingDir %A_ScriptDir%

if not A_IsAdmin
	Run *RunAs "%A_AhkPath%" /r "%A_ScriptFullPath%"

Run dc64 install dd.key.94396.inf "dd.key.94396"
Run dc64 install dd.mou.94396.inf "dd.mou.94396"