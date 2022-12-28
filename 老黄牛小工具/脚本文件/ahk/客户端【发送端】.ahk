;Client
#Include <Socket>
myTcp := new SocketTCP()
myTcp.connect("127.0.0.1", 12345)

;MsgBox, % myTcp.recvText()
myTcp.sendText("Hello Server!")
MsgBox, % myTcp.recvText()
ExitApp
