#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <ZeroMQ>
#NoEnv
SetBatchLines -1                       ; 速度最大化

zmq := new ZeroMQ                      ; 初始化 ZeroMQ

context := zmq.context()               ; 创建一个上下文
socket := context.socket(zmq.REQ)      ; 创建一个 REQ 套接字
socket.connect("tcp://localhost:5555") ; 连接到端口



;reg为最后要提取的变量，可以统一输入
arr :=[]
arr["reg"] := "请输入正则公式,正则公式比较复杂，请自行上网检索。`n 相关网站：`nhttps://c.runoob.com/front-end/854/（30秒内免再输入）"
;arr :=arrupdate(arr)
;reg := arr["reg"]

arr2 := arr2excelarr(arr)
str := JSON.Dump(arr2,, 4)
;startstr(str)
socket.send_string(str)          ; 发送消息 Hello 给服务端
msg := socket.recv_string()          ; 从服务端接收回应
;msgbox, %msg%
ExitApp                                ; 退出时会自动释放资源


