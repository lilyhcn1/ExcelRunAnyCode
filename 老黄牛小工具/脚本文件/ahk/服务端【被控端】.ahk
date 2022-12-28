;Server
#Include <Socket>
myTcp := new SocketTCP()
myTcp.bind("addr_any", 12345)


myTcp.listen()
myTcp.onAccept := Func("OnTCPAccept") 
newTcp.sendText("Hello Client!2") 


return

 
OnTCPAccept(){
global myTcp
newTcp := myTcp.accept()
newTcp.sendText("Hello Client!")
MsgBox, % newTcp.recvText()
ExitApp
}

