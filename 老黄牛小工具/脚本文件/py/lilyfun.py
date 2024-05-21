#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- 三思网络(r34.cc) -*-
#import traceback
#    except Exception as e:
#        print("---------- 执行出错，请检查! ---------\n"+traceback.format_exc())

from urllib import request
import urllib.parse
import os,os.path,json,sys
import requests
import time
import base64
import configparser
import chardet,time,subprocess
import os
from datetime import datetime
import random
import pyautogui,pyperclip
import traceback




MBPATH=r'D://老黄牛小工具//word模板'
JSONFILE="D://老黄牛小工具//ExcelQuery//temp//temp.json"

TEMPTEXT=r'..//..//ExcelQuery//temp//temp.txt'
INIPATH=r"..//..//配置文件//myconf.ini"
JBPATH=r'..//..//脚本文件'

FK='临时'
INIUPDATEFLAG='GetFromIni'

        
def savestr(str):
    with open(JSONFILE, 'w') as file_object:
        file_object.write(str)

def savesttxt(str,path=TEMPTEXT):
    with open(path, 'w') as file_object:
        file_object.write(str)

""" 读取图片 """
def get_file_content(filePath):
    with open(filePath, 'rb') as fp:
        return fp.read()

def getjsontype(arr):
    curlurltemp=""
    for key in arr:
        curlurltemp =curlurltemp+ "\""+key+ "\"" +":"+ "\""+arr[key]+ "\""+", "
    curlurltemp=remove_last_segment(curlurltemp,", ")
    return curlurltemp
def remove_last_segment(input_string, target_string):
    # 检查输入字符串是否以目标字符串结尾
    if input_string.endswith(target_string):
        # 获取输入字符串的长度和目标字符串的长度
        input_length = len(input_string)
        target_length = len(target_string)
        
        # 计算最后一段的起始索引位置
        last_segment_start = input_length - target_length
        
        # 截取去除最后一段后的字符串并返回
        return input_string[:last_segment_start].strip()
    
    # 如果输入字符串不以目标字符串结尾，则返回原始字符串
    return input_string


def readini(sec,key):
    config = configparser.ConfigParser()
    config.read(INIPATH)
    appid = config[sec][key]
    return appid

def readiniconfig():
    try:
        config = configparser.ConfigParser()
        config.read(INIPATH)
    except:
        config="error"
    return config

def updatearrfromini(arr,config=""):
    try:
        newarr={}
        for inkey in arr.keys():
            if inkey != "" :
                newarr[inkey]=arr[inkey]

        if config !="":
            # titlepr("config更新中：",config)
            for inkey in arr.keys():
                if inkey != "" :
                    if arr[inkey] ==INIUPDATEFLAG:
                        try:
                            #titlepr("config['ApiKeys'][inkey]",config['ApiKeys'][inkey])
                            newarr[inkey]=config['ApiKeys'][inkey]
                        except:
                            print("从config强制更新配置["+inkey+ "]失败！~")
    except:
        newarr=arr
    return newarr

def firstkey(arr):
    for k,v in arr.items():
        #print(k)
        return k

#读取json数据
def readjson(key="contents"):
    listarr={}
    with open(JSONFILE,'r',encoding='utf8') as f:
        ct = f.read()
        if ct.startswith(u'\ufeff'):
            ct = ct.encode('utf8')[3:].decode('utf8')
            #ct = ct.replace('\\','\\\\')
    jsonarr = json.loads(ct)
    #print(key in jsonarr.keys())
    if key in jsonarr.keys():
        listarr = jsonarr[key]
    else:
        listarr=jsonarr
    return listarr




#读取txt文档,可以兼容不同的编码方式
def readtxt(path):
    f = open(path, 'rb')
    r = f.read()
    f_charInfo = chardet.detect(r)
    geshi=f_charInfo['encoding']
    ct=r.decode(f_charInfo['encoding'])  # 通过取得的文本格式读取txt
    f.close()
    return ct

#读取二进制的文件
def readfile(path):
    f = open(path, 'rb')
    r = f.read()
    return r


#读取二进制的文件并转化为f64
def readfile2f64(path):
    if os.path.exists(path) :
        with open(path,'rb') as f:
            f64=base64.b64encode(f.read()).decode("utf-8")
    else:
        f64=""
    return f64
#读取二进制的文件并转化为f64，然后删除
def readfile2f64anddel(path):
    aa=readfile2f64(path)
    os.remove(path)
    return aa
#读取二进制的文件并转化为f64
def writefile64(f64,path=""):
    if path !="" and f64 !="":
        with open(path, 'wb') as f:
            ff=base64.b64decode(f64)
            f.write(ff)

    return path

def runcmdstr(cmdstr):
    tmp = os.popen(cmdstr)
    res = tmp.read()# 要用read（）方法读取后才是文本对象
    tmp.close()# 需将对象关闭
    return res

# 1213修改
def randfileeee(valarr="",fkey="",flag="new"):

    #print("randfile---"+"fkeyold:"+fkeyold+"flag:"+flag)
    #print(valarr)
    #print("valarr---")
    nowpath= str(os.getcwd()) + "/"
    
    if fkey=="":
        return ""
    
    try:
        f=valarr[fkey]
    except:
        return ""


    random_number = random.randint(0, 1000)
    fex=os.path.splitext(f)[-1]
    #print("fex---"+" fex:"+fex+" flag:"+flag)
    if flag=="new":
        #print("flag in ")
        return nowpath + str(int(round(time.time() * 1000))+random_number)+".tmpnew"+fex
    else:
        #print("flag not in ")
        return nowpath + str(int(round(time.time() * 1000))+random_number)+".tmp"+fex

#输入中文
def paste_text(text):
    pyperclip.copy(text)
    pyautogui.hotkey('ctrl', 'v')
    time.sleep(0.1)
#输入英文
def type_english(text):
    pyautogui.typewrite(text)
    time.sleep(0.1)
 
def randfile(valarr="",key="",flag="new"):
    #print("randfile---"+"key:"+key+"flag:"+flag)
    #print(valarr)
    #print("valarr---")
    nowpath= str(os.getcwd()) + "/"
    
    if key=="":
        return nowpath+ str(int(round(time.time() * 1000)))+".tmp"
    
    
    try:
        f=valarr[key]
    except Exception as e:
        print("---------- 执行出错，请检查! ---------\n"+traceback.format_exc())
        return nowpath + str(int(round(time.time() * 1000)))+".tmp"


    random_number = random.randint(0, 1000)
    fex=os.path.splitext(f)[-1]
    #print("fex---"+" fex:"+fex+" flag:"+flag)
    if flag=="new":
        #print("flag in ")
        return nowpath + str(int(round(time.time() * 1000))+random_number)+".tmpnew"+fex
    else:
        #print("flag not in ")
        return nowpath + str(int(round(time.time() * 1000))+random_number)+".tmp"+fex

        

""" 等待脚本执行结束 """
def runwait(cmd):
    p=subprocess.Popen(cmd,shell=True)
    return_code=p.wait()  #等待子进程结束，并返回状态码；
    return return_code
     



#安全的获得键值
def safegetkey(arr,key):
    try:
        s=arr[key]
    except:
        s=""
    return s


#删除文件，文件可以不存在
def safedel(path):
    if os.path.exists(path):
        os.remove(path)
    safedeltmpfile()
    return 0

#删除当前文件夹的临时文件tt=300秒
def safedeltmpfile(tt=300):
    errstr=""
    root = os.getcwd()
    for dirpath, dirnames, filenames in os.walk(root):
        for filepath in filenames:
             if ".tmp" in filepath:
                try:
                    mtime = os.path.getmtime(filepath) #修改时间
                    nowtime = time.time()
                    if nowtime-mtime >tt:
                        if os.path.exists(filepath):
                            os.remove(filepath)
                except Exception as e:# 保存函数出错后的执行 结果
                    errstr = '错误类型：'+ e.__class__.__name__+"\n"+ '错误明细：'+str(e)
                    #print(errstr)
    return errstr

""" 字符串变base64的字符串 """
def str2f64(s):
    try:
        s=str.encode(s)
    except:
        a=1
    json64=base64.b64encode(s).decode("utf-8")
    return json64

""" base64转换为字符 """
def f64tostr(f64):
    json64=base64.b64decode(f64)
    return json64

#读取json数据
def readjsonarr(key="",key2=""):
    #print(key+"--"+key2)
    listarr={}
    with open(JSONFILE,'r',encoding='utf8') as f:
        ct = f.read()
        if ct.startswith(u'\ufeff'):
            ct = ct.encode('utf8')[3:].decode('utf8')
            #ct = ct.replace('\\','\\\\')
    jsonarr = json.loads(ct)
    
    

    if key2=="" and key=="":
        return jsonarr[key]
    elif key != "":
        return jsonarr[key][key2]
    elif key=="":
        return jsonarr
    else:
        return "error"

#字典合并
def merge(dict1, dict2):
    newdict={}
    for key in dict1.keys():
        if key !="":
            newdict[key]=dict1[key]
    for key in dict2.keys():
        if key !="":
            if key not in dict1.keys():
                newdict[key]=dict2[key]

    return newdict 
#字典相减
def dictdiff(dict1, dict2):
    newdict={}
    for key in dict1.keys():
        newdict[key]=dict1[key]
    for key in dict2.keys():
        if key in dict1.keys():
            del newdict[key]

    return newdict

#备用的统计函数等 
def tj():
    return ""



#这里替换成常用函数
def arr2dict(arr2):
    n=0
    i=0
    k={}
    dictarr={}
    dictarrs={}
    for arr1 in arr2:
        i=0
        for arrval in arr1:
            #print(arrval)
            if n==0:
                k[i]=arrval
            else:
                dictarr[k[i]]=arrval
            i=i+1
        dictarrs[n]=dictarr
        n=n+1

    return dictarrs


def firstval(arr):
    for index in arr:
        return arr[index]


def savesttxt(str,path=TEMPTEXT):
    with open(path, 'w') as file_object:
        file_object.write(str)


def startstr(str):
    savesttxt(str)
    os.system("cmd.exe /c start " +TEMPTEXT)

def startarr(arr):
    str=json.dumps(arr)
    startstr(str)



#保证键值存在，不存在退出
def checkkey(arr,key):
    if key in arr.keys():
        return True
    else:
        print("Error,请确保标题行中有【" + key + "】")
        time.sleep(10)
        sys.exit()
        
""" 打印输出信息 """
def pr(str,prflag="true"):
    if prflag=="true":
        print(str)
""" 打印输出信息 """
def titlepr(title,arr,prflag="true"):
    if prflag=="true":
        if title !="":
            print("                         ----------- " + title + " -----------")
            print(arr)
        else:
            print(arr)


""" 字典保证值的存在 """
def arrstr(arr,key,s=""):
    if key in arr.keys():
        return arr
    else:
        arr[key]=s
        return arr




#这里替换成常用函数
def savearr2json(arr,wtype="all",code="0"):
    arr2=arr2jsonarr(arr,wtype,code)
    with open(JSONFILE, 'w') as file_object:
        file_object.write(json.dumps(arr2))
    return arr2



""" 错误执行时存到json """
def saveerr2json(arr,s="",key="execstat",):
    arr[key]=s
    savearr2json(arr,"all")
    print("函数savearr2json print: "+s)
    return arr
    
""" 数组生成json对应的数组 """
def arr2jsonarr(arr,wtype="all",code="0"):
    sc=os.path.splitext(os.path.basename(__file__))[0]
    arr2={}
    arr2['script']=sc
    arr2['w']=wtype
    arr2['code']=code
    arr2['contents']=arr
    return arr2

""" 数组转成json字符串 """
def arr2json64str(arr,wtype="all",code="0"):
    arr=arr2jsonarr(arr,wtype,code)
    jsonstr=json.dumps(arr)
    return str2f64(jsonstr)  

""" base64转成jsonarr """
def json64tojsonarr(json64):
    json64str=base64.b64decode(json64) #??原来写成fd2.json64
    jsonarr = json.loads(json64str)
    return jsonarr


#list可以转字符串
def list2str3(listorstr,cols=""):
    txt =""
    flag = isinstance(listorstr,list)
    print(flag)
    return listorstr

#list可以转字符串
def list2str(listorstr,cols=""):
    txt =""
    flag = isinstance(listorstr,list)

    if flag ==True:
        for v in listorstr:
            txt = txt + cols + list2str(v)
    else:
        txt =listorstr
    return str(txt)



""" 数组变成base64的字符串 """
def arr2json64(ret2arr):
    jsonarr=arr2jsonarr(ret2arr) #结构化数据
    jsonarrstr=json.dumps(jsonarr)      #编码为字符串
    return str2f64(jsonarrstr)


def sysargvandjson(keyword="webppath",inputstr=""):
    inputpatharr={}
    #print(inputstr !="")
    if inputstr !="":   #1.如果有输入，就强制跳转
        inputpatharr[0]=inputstr
        return inputpatharr
    #print(keyword)
    if len(sys.argv)>1:    #2.判断有没有参数
        n = len(sys.argv)
        temp=""
        for i in range(1, n):
            inputpatharr[i]=sys.argv[i]
    else:                #3.读取json中的配置，看看有没有keyword
        jsonarr=readjson()
        #print(jsonarr)
        if keyword in jsonarr.keys():
            inputpatharr[0] = jsonarr[keyword]
        else:
            inputpatharr = {}

    print(inputpatharr)
    return inputpatharr

def sysargv1(inputstr=r"C:\Users\lilyhcn\Desktop\4\1.webp"): #只有一个参数
    if len(sys.argv)>1:    #判断有没有参数
        n = len(sys.argv)
        temp=""
        for i in range(1, n):
            if i == 1 :
                temp = temp + sys.argv[i]
            else:
                temp = temp + sys.argv[i] +" "
        inputstr=temp
        #print("input: "+ inputstr)
    return inputstr


def readimg2base64(filepath=""):
    with open(filepath, 'rb') as fp:
        data = fp.read()
    return base64.b64encode(data)


def upload(path):
    headers = {'Authorization': 'W2v89ImTEPqkCVr03dpRfW3wvjwbHyjj'}
    files = {'smfile': open(path, 'rb')}
    url = 'https://sm.ms/api/v2/upload'
    res = requests.post(url, files=files, headers=headers).json()
    aa=json.dumps(res, indent=4)
    aa=json.loads(aa)
    successstr = aa['success']
    #print(successstr)
    if  successstr == False:
        imageurl=aa['images']
    elif successstr == True:
        imageurl=aa['data']['url']
    else:
        print('error')
    return imageurl

def test():
    aa='this is test!~'
    print(aa)
    return aa


#把相对路径转成绝对路径
def getwnewfilepath(output1,listarr):
    return 11

#把相对路径转成绝对路径
#raltiveapth 相对路径
#folder 文件夹
def getwholepath(raltiveapth,folder=""):
    if folder =="":
        folder =os.getcwd()
    if ":" in raltiveapth:
        new_file = raltiveapth
    else:
        new_file = folder+"\\"+raltiveapth
        if os.path.exists(folder+"\\"+raltiveapth):
            new_file = folder+"\\"+raltiveapth
        else:
            new_file = raltiveapth

    return new_file


def mkdir(path):
    folder=os.path.dirname(path)
    print(folder)
    folderexist = os.path.exists(folder)
    if not folderexist:
        os.makedirs(folder)


def GetDesktopPath():
    return os.path.join(os.path.expanduser("~"), 'Desktop')

#这里是专用函数，其它地方用不着

def getexepath(jbname):
    jbstr = "ahk,vbs,py"    #可能的后缀
    for jbext in jbstr.split(","):   #遍历可能的后缀
        jbpath=JBPATH + '/' + jbext +'/' + jbname + '.' + jbext
        #print(jbpath)
        if os.path.exists(jbpath):
            return  jbpath
    return  "JbNotExist"  #都找不到，就返回空

def printtraceback(valarr,errstr="错误输出值",prflag=True):
    valarr["execstat"]=errstr
    if prflag==True :
        print(errstr++traceback.format_exc())
    return valarr

def printstrtraceback(errstr="错误输出值",prflag=True):
    if prflag==True :
        print(errstr+traceback.format_exc())
    return valarr

def printvalarr(valarr,errstr="错误输出值",prflag=True):
    valarr["execstat"]=errstr
    if prflag==True :
        print(errstr)
    return valarr

#读取输入的数组
def getvalarr(jsonarr,inarr,outarr,prflag="false"):
    valarr,contarr,temparr={},{},{}
    #计算出contarr
    contarr=jsonarr["contents"]
    contarr=dictdiff(contarr,outarr)
    temparr["execstat"]=""
    contarr=dictdiff(contarr,temparr)
    
    key=getonlykey(contarr)
    if len(contarr)==1  and len(inarr)==1:
        key=getonlykey(inarr)
        key2=getonlykey(contarr)

        if key2 == FK:
            key2=getonlykey(contarr)
            valarr[key]=contarr[key2]
        else:
            for inkey in inarr.keys():
                valarr[inkey]=contarr[inkey]

    else:
        for inkey in inarr.keys():
            valarr[inkey]=contarr[inkey]
        valarr=merge(valarr,contarr)
            
    return valarr

#读取输入的数组
def getonlykey(arr):
    keylen=len(arr)
    if keylen==1:
        for key in arr:
            key=key
    else:
        key="error,getonlykey"
    return key



#处理计算得到的数组
def mboutputarr(fd2,prflag="true",arr2ret={},f64="",wpath="",keyflag="all"):
    #一、 是否有函数的输入
    #titlepr("运行后的返回值：",arr2ret,prflag)    
    if "execstat" not in arr2ret:  
        arr2ret["execstat"] = "√"
    
    if fd2=={}:
        savearr2json(arr2ret, keyflag)

    arr2ret64 = arr2json64str(arr2ret,keyflag)
    
    fd2new={}
    fd2new["json64"]=arr2ret64
    fd2new["f64"]=f64

    if f64!="" and wpath !="":
        writefile64(f64,wpath)
    
    #titlepr("最终输出的数组为：",fd2new,prflag)
    #print("mboutputarr 运行结束")
    return fd2new






#获取fd2的字典
def getfd2(fd2={},flag="json64",path=""):

    if flag=="json64":
        if fd2=={}:#看是否函数传入

            json64=readfile2f64(JSONFILE)
        else:
            #按照默认标题读取
            try:
                json64=fd2["json64"]
            except:
                json64=fd2.json64
        return json64

    elif flag=="f64":

        if fd2=={} and path !="":#看是否函数传入
            f64=readfile2f64(path)
        else:
            try:
                f64=fd2["f64"]
            except:
                try:
                    f64=fd2.f64
                except:
                    f64=""

        return f64
    elif flag=="infilename":

        if fd2=={}:#看是否函数传入
            try:
                infilename=fd2["infilename"]
            except:
                infilename=fd2.infilename
        else:
            try:
                infilename=path
            except:
                infilename=""

        return infilename
    else:
        return "getfd2arr未知错误。"

#获取fd2的字典 20231215修改
def getfd2_f64(fd2={},fkeyold="",jsonarr={}):
    f64=""

    if fd2!={}:

        try:
            try:
                f64=fd2["f64"]
            except:
                try:
                    f64=fd2.f64
                except:
                    f64=""

            if f64=="":
                try:
                    inpath=jsonarr["contents"][fkeyold]
                    f64=readfile2f64(inpath)
                except:
                    f64=""
        except:
            f64=""

        return f64
    elif fkeyold !="":#看是否函数传入, 是excel传入
        try:
            inpath=jsonarr["contents"][fkeyold]
            f64=readfile2f64(inpath)

        except:
            f64=""

        return f64
    elif fd2=={} and fkeyold =="":#看是否函数传入
        return ""
    else:
        return "getfd2arr未知错误。"

