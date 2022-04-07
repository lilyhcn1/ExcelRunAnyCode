clipboard := clipboard ;将富文本转为纯文本
run notepad,,max
sleep,200
send,^v
sleep,100
Send,^a
sleep,100
Send,^c
WinClose, 无标题