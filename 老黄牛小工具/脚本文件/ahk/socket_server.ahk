; 收发文本示例 - 服务端



#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP) ; 创建一个 REP 套接字
socket.bind("tcp://*:5555")       ; 绑定到端口

runtime := 30
arr := []  ;存在服务器上的数组
rec_arr :=[]  ;发送过来的旧数组

loop{
jsonstr := socket.recv_string()     ; 接收客户端的请求

;startstr(jsonstr)
;msgbox, 接收到的数据
temparr2 := JSON.Load(jsonstr)
;socket.send_string("World")     ; 发送消息 World 给客户端
rec_arr :=temparr2["contents"]

;MsgBox Server received request %msg%s
;startstr(JSON.Dump(pct,, 4))

if(arr.count()=0){  ;初始化arr
      For index, value in rec_arr{
        arr[index] := value           
      }
	;arr["time"] :=Time_human2unix(A_Now)
	arr["time"] :=0
	;startstr(JSON.Dump(arr,, 4))
}

;如果小于间隔就弹窗，否则用上次的
    jg :=Time_human2unix(A_Now)-arr["time"]
    ;msgbox % Time_human2unix(A_Now)
    ;msgbox % arr["time"]
    key := returnfirstkey(rec_arr)
    ;msgbox, key is %key%
    if(Abs(jg) > runtime){
      For index, value in rec_arr{
          if(index  != "time"){
            InputBox, tmp, %index%, %value% 	
            arr[index] := tmp           
          }
      }
    }
    arr["time"] :=Time_human2unix(A_Now)
;startstr(JSON.Dump(arr,, 4))
;返回arr
arrout := arr2excelarr(arr)
str := JSON.Dump(arrout,, 4)

socket.send_string(str)
}
exitapp


#SingleInstance, Force
#Include <JSON>
#Include <lilyfun>
#Include <ZeroMQ>
