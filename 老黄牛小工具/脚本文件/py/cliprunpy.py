#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
import os
import shutil
import urllib.request
import zipfile,subprocess,json,base64

import tkinter as tk
import os
import os,base64,time,sys,json,lilyfun # 导入同路径下的函数
import requests, json,pyperclip
prflag = "true"  # 是否打印输出，true输出 111234
inarr,outarr={},{}
lilyfun.tj()

import winsound

def tipmsgbox(msg, timeout=4000):

    root = tk.Tk()

    # 根据消息的长度，计算窗口的宽度
    window_width = 10 * len(msg)
    # 设置窗口的最大宽度
    if window_width > 300:
        window_width = 300
    if window_width < 120:  # 确保窗口的最小宽度
        window_width = 120

    # 计算弹窗在屏幕右下角的位置
    screen_width = root.winfo_screenwidth()
    screen_height = root.winfo_screenheight()

    # 创建一个无边框的窗口
    root.overrideredirect(True)
    root.geometry('{}x70+{}+{}'.format(window_width, screen_width - window_width - 10, screen_height - 80))

    # 设置窗口的背景颜色
    root.configure(background='black')

    # 在窗口上添加一条消息，右对齐
    tk.Label(root, text=msg, font=('Arial', 12), fg='white', bg='black', wraplength=window_width, justify='left').pack()

    # Windows提示框声音
    winsound.MessageBeep()

    # 在 timeout 毫秒后关闭窗口
    root.after(timeout, root.destroy)

    root.mainloop()
    

def getcliptext():
    root = tk.Tk()
    root.withdraw()  # 隐藏根窗口
    clipboard_text = root.clipboard_get()
    root.destroy()  # 销毁根窗口
    return clipboard_text

def clipboard_content_type(clipboard_text):
    if not clipboard_text:
        return "empty"
    elif all(os.path.isfile(path) for path in clipboard_text.splitlines()):
        return "files"
    elif all(os.path.isdir(path) for path in clipboard_text.splitlines()):
        return "folders"
    else:
        return "text"

def getclipandcheck(tp):
    # 示例用法
    text=getcliptext()
    gettp=clipboard_content_type(text)

    if tp==gettp:
        print("继续操作")
        return text
    else:
        print("类型错误：希望是【"+tp+"】。获取到的类型为：【"+gettp+"】。")
        exit()

def getjburl(jbname):
    return "http://api.r34.cc/jb/"+jbname
#1242323

def postarr2jb(url,inarr={}):
    data=json.dumps(inarr)
    print(data)
    response = requests.post(url, json=data)
    #print(response)
    response_data = json.loads(response.json())
    #print(response_data)
    return response_data

#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = "true"  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["jb"]="金额大写"
inarr[""]=""
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr["stat"] = "待返回"
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
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"读取fd2错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[1/4] fd2 传入成功！：","传入成功",prflag)

    # ----------------[2/4] 生成f64,json64解码为jsonarr -----------
    try: #1.2 json64解码为jsonarr
        jsonarr = lilyfun.json64tojsonarr(json64)
        jsoncontentarr =jsonarr["contents"]
        jsoncontentarr=lilyfun.updatearrfromini(jsoncontentarr,config)
        jsonarr["contents"]=jsoncontentarr
        f64=lilyfun.getfd2_f64(fd2,fkeyold,jsonarr)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"jsonarr解码错误，请检查！",prflag)
        #fd2:函数传过来的值，arr2ret:运行得到的数组，prflag：打印标记
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[2/4] 解码成功 jsonarr：",jsonarr,prflag)

    # ----------------[3/4]按输入区读传过来的值并反馈到字典valarr ------
    try:
        valarr=lilyfun.getvalarr(jsonarr,inarr,outarr,prflag)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"标题行没有需要的值，请确保标题行存在！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("","获取到的f64的长度为: " + str(len(f64)),prflag)
    lilyfun.titlepr("[3/4] 检查输入值成功 valarr：",valarr,prflag)
    #这里可能还要再写读文件的
    
    # ----------------[4/4]调用函数并生成arr2ret及f64 -------------------
    try:  # 运行函数,最后要生成arr2ret及f64
        old_filepath=lilyfun.randfile(inarr,fkeyold,"old")
        new_filepath=lilyfun.randfile(outarr,fkeynew,"new")
        old_filepath=lilyfun.writefile64(f64,old_filepath)
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写文件错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr jb    
    #inarr stat    
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        
        #第一次获得键值
        print("第一次获得键值")
        url =getjburl("金额大写")
        text=getclipandcheck("text")
        print(url)
        retrunarr=postarr2jb(url)
        print(retrunarr)

        #第二次传送正确的值
        print("第二次传送正确的值")
        inarr[lilyfun.firstkey(retrunarr)]=text
        print(inarr)
        retrunarr=postarr2jb(url,inarr)
        print(retrunarr)
        rtext=lilyfun.firstval(retrunarr)
        print(rtext)
        pyperclip.copy(rtext)


        tipmsgbox(rtext+"\n已成功复制文字到剪贴板")



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
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写、删除文件错误。！",prflag)
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
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"写入文件出错，请检查值是否正确！",prflag)
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
