#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
 
import pyautogui
import time,os
import win32api
import win32con
import win32gui
import win32clipboard as w
from PIL import ImageGrab
import requests
import base64
import pyperclip

import win32clipboard

from ctypes import *

#复制任意类型的文件到剪切板 按crtl+v 可粘贴出来

class DROPFILES(Structure):
    _fields_ = [
        ("pFiles", c_uint),
        ("x", c_long),
        ("y", c_long),
        ("fNC", c_int),
        ("fWide", c_bool),
    ]

pDropFiles = DROPFILES()
pDropFiles.pFiles = sizeof(DROPFILES)
pDropFiles.fWide = True
matedata = bytes(pDropFiles)

def setClipboardFiles(paths):
    files = ("\0".join(paths)).replace("/", "\\")
    data = files.encode("U16")[2:]+b"\0\0"
    win32clipboard.OpenClipboard()
    try:
        win32clipboard.EmptyClipboard()
        win32clipboard.SetClipboardData(
            win32clipboard.CF_HDROP, matedata+data)
    finally:
        win32clipboard.CloseClipboard()



 
def FindWindow(chatroom):
    win = win32gui.FindWindow('WeChatMainWndForPC',chatroom)
    print("找到窗口句柄：%x" % win)
    if win != 0:
        win32gui.ShowWindow(win, win32con.SW_SHOWMINIMIZED)
        win32gui.ShowWindow(win, win32con.SW_SHOWNORMAL)
        win32gui.ShowWindow(win, win32con.SW_SHOW)
        win32gui.SetWindowPos(win, win32con.HWND_TOP, 0, 0, 500, 700, win32con.SWP_SHOWWINDOW)
        win32gui.SetForegroundWindow(win)  # 获取控制
        time.sleep(1)
        tit = win32gui.GetWindowText(win)
        print('已启动【'+str(tit)+'】窗口')
    else:
        print('找不到【%s】窗口' % chatroom)
        exit()
 
# 设置和粘贴剪贴板
def ClipboardText(ClipboardText):
    file_path=ClipboardText
     
    if os.path.exists(file_path):
        setClipboardFiles([file_path])
    else:
        w.OpenClipboard()
        w.EmptyClipboard()
        w.SetClipboardData(win32con.CF_UNICODETEXT, ClipboardText)
        w.CloseClipboard()
        
    time.sleep(1)
    win32api.keybd_event(17,0,0,0)
    win32api.keybd_event(86,0,0,0)
    win32api.keybd_event(86,0,win32con.KEYEVENTF_KEYUP,0)
    win32api.keybd_event(17,0,win32con.KEYEVENTF_KEYUP,0)


 
# 模拟发送动作
def SendMsg():
    win32api.keybd_event(18, 0, 0, 0)
    win32api.keybd_event(83,0,0,0)
    win32api.keybd_event(18,0,win32con.KEYEVENTF_KEYUP,0)
    win32api.keybd_event(83,0,win32con.KEYEVENTF_KEYUP,0)
 
# 模拟发送微信文本消息
def SendWxMsg(wxid,sendtext):
    # 先启动微信
    FindWindow('微信')
    time.sleep(1)
    # 定位到搜索框
    pyautogui.moveTo(143, 39)
    pyautogui.click()
    # 搜索微信
    ClipboardText(wxid)
    time.sleep(1)
    # 进入聊天窗口
    pyautogui.moveTo(155, 120)
    pyautogui.click()
    # 粘贴文本内容
    ClipboardText(sendtext)
    # 发送
    SendMsg()
    print('已发送')
    # 关闭微信窗口
    time.sleep(1)
    pyautogui.moveTo(683, 16)
    pyautogui.click()
 
# 模拟发送文件消息（图片、文档、压缩包等）
def SendWxFileMsg(wxid,imgpath):
    # 先启动微信
    FindWindow('微信')
    time.sleep(1)
    # 定位到搜索框
    pyautogui.moveTo(143, 39)
    pyautogui.click()
    # 搜索微信
    ClipboardText(wxid)
    time.sleep(1)
    # 进入聊天窗口
    pyautogui.moveTo(155, 120)
    pyautogui.click()
    # 选择文件
    pyautogui.moveTo(373, 570)
    pyautogui.click()
    ClipboardText(imgpath)
    time.sleep(1)
    pyautogui.moveTo(784, 509)
    pyautogui.click()
    # 发送
    SendMsg()
    print('已发送')
    # 关闭微信窗口
    time.sleep(1)
    pyautogui.moveTo(683, 16)
    pyautogui.click()

def split_string_based_on_delimiter(s):
    # 检查回车符是否是分隔符
    if '\n' in s:
        return s.split('\n')
    # 检查英文逗号是否是分隔符
    elif ',' in s:
        return s.split(',')
    # 检查中文逗号是否是分隔符
    elif '，' in s:
        return s.split('，')
    elif ' ' in s:
        return s.split(' ')
    else:
        # 如果没有找到已知的分隔符，返回整个字符串作为列表的唯一元素
        return [s]
 
#按键或快捷键
def arrsendwechatmsg(userstr,text):
    time.sleep(2)
    userarr =split_string_based_on_delimiter(userstr)
    for user in userarr:
        SendWxMsg(user,text)
        print(user)

#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,lilyfun # 导入同路径下的函数
prflag = "true"  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["nickname"]="老黄牛小号,黄牛6700"
inarr["text"]="你好啊！"
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
#文件标志
fkeyold=""   #输入变量中，哪个是文件的标记。
fkeynew=""   #输出变量中，哪个是文件的标记。
#2222222222222222222222222222222222222222222222222222222222222
config=lilyfun.readiniconfig()
inarr=lilyfun.updatearrfromini(inarr,config)




def main(fd2={}):
    global inarr,outarr,prflag,fkeyold,fkeynew,mlkey,config
    arr2ret,valarr,errarr = {},{},{}
    wholepath,f64="",""
    errarr=lilyfun.merge(inarr,outarr)  #合并字典
    # ----------------三、初始化读取数据：----------------------
    #读valarr,即读标题及标题对应的值
    # ----------------[1/4]读取fd2，生成base64字符串 json64 -----
    try: #1.1读取fd2，即传入字典
        json64=lilyfun.getfd2(fd2,"json64")
    except:
        #errarr["执行结果"]="读取fd2错误，请检查！"
        errarr = lilyfun.printvalarr(errarr,"读取fd2错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[1/4] fd2 传入成功！：","传入成功",prflag)
    
    # ----------------[2/4] 生成f64,json64解码为jsonarr -----------
    try: #1.2 json64解码为jsonarr
        jsonarr = lilyfun.json64tojsonarr(json64)
        jsoncontentarr =jsonarr["contents"]
        jsoncontentarr=lilyfun.updatearrfromini(jsoncontentarr,config)
        jsonarr["contents"]=jsoncontentarr
        f64=lilyfun.getfd2_f64(fd2,fkeyold,jsonarr)
    except:
        errarr = lilyfun.printvalarr(errarr,"jsonarr解码错误，请检查！",prflag)
        #fd2:函数传过来的值，arr2ret:运行得到的数组，prflag：打印标记
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[2/4] 解码成功 jsonarr：",jsonarr,prflag)

    # ----------------[3/4]按输入区读传过来的值并反馈到字典valarr ------
    try:
        valarr=lilyfun.getvalarr(jsonarr,inarr,outarr,prflag)
    except:
        errarr = lilyfun.printvalarr(errarr,"[读输入]标题行没有需要的值，请确保标题行存在。",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("","获取到的f64的长度为: " + str(len(f64)),prflag)
    lilyfun.titlepr("[3/4] 检查输入值成功 valarr：",valarr,prflag)
    #这里可能还要再写读文件的
    
    # ----------------[4/4]调用函数并生成arr2ret及f64 -------------------
    try:  # 运行函数,最后要生成arr2ret及f64
        old_filepath=lilyfun.randfile(inarr,fkeyold,"old")
        new_filepath=lilyfun.randfile(outarr,fkeynew,"new")
        old_filepath=lilyfun.writefile64(f64,old_filepath)
    except:  # 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[运行]读写文件错误。",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr nickname text   
    #inarr     
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        arrsendwechatmsg(valarr["nickname"]),valarr["text"]))

    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[运行]调用函数出错，请检查值是否正确。" +"\n"+'错误类型：'+ e.__class__.__name__+"\n"+ '错误明细：'+str(e))
        return lilyfun.mboutputarr(fd2,prflag,valarr)





    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[运行]调用函数出错，请检查值是否正确。" +"\n"+'错误类型：'+ e.__class__.__name__+"\n"+ '错误明细：'+str(e))
        return lilyfun.mboutputarr(fd2,prflag,valarr)




    #3333333333333333333333333333333333333333333333333333
    
    try:  # 运行函数,最后要生成arr2ret及f64
        f64=lilyfun.readfile2f64(new_filepath)#有新文件就读取
        # newpath = valarr[fkeynew]
        # if f64!="" and fkeynew!="" and fd2=={}:
        #     lilyfun.writefile64(f64,newpath)
        lilyfun.safedel(old_filepath)
        lilyfun.safedel(new_filepath)
        arr2ret["执行结果"]="√"
    except:  # 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[执行函数后]读写、删除文件错误。",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)
    lilyfun.titlepr("[4/4] 函数执行成功 arr2ret：",arr2ret,prflag)
    

    # ----------------五、写入文件，并返回字典 -------------------
    try:  # 写入文件
        if fd2=={} and fkeynew !="":
            excelfolder=lilyfun.safegetkey(jsonarr,"excelpath")
            raltiveapth=jsonarr["contents"][fkeynew]
            wholepath=lilyfun.getwholepath(raltiveapth,excelfolder)
        lilyfun.titlepr("执行、输出成功。","",prflag)
        #这是最关键的返回函数，并写入文件
        #print(wholepath)
        return lilyfun.mboutputarr(fd2,prflag,arr2ret,f64,wholepath,"key")
    except:  # 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"写入文件出错，请检查值是否正确。",prflag)
        lilyfun.titlepr("最后写入文件出错，请检查值是否正确。","",prflag)       
        return lilyfun.mboutputarr(fd2,prflag,valarr)



if __name__ == '__main__':
    main()

    #fd2的内容
    # "json64": json文件  上传过来的json
    # "f64": f64   上传的文件的base64（只能一个文件）
    # "fkeyold": fkeyold  上传时的标题行（只能一个文件）
    # "fkeynew": fkeynew  返回时的标题行（只能一个文件）
        #fd2,prflag="true",arr2ret,f64="",fkeynew="",keyflag="all"
        #fd2:传过来的值，prflag：打印标记,keyflag:excel中的是否全部输出
        #arr2ret:运行得到的字典，f64:反馈文件的base64,fkeynew：输出值
        #return lilyfun.mboutputarr(fd2,prflag,errarr)


