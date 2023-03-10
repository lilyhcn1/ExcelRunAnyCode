#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- 三思网络(r34.cc) -*-
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


MBPATH=r'd:/老黄牛小工具/word模板'
JSONFILE=r'd:/老黄牛小工具/ExcelQuery/temp/temp.json'

TEMPTEXT=r'd:/老黄牛小工具/ExcelQuery/temp/temp.txt'
INIPATH=r"D:\老黄牛小工具\配置文件\myconf.ini"
JBPATH=r'D:\老黄牛小工具\脚本文件'

FK='临时'


        
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


def readini(sec,key):
    config = configparser.ConfigParser()
    config.read(INIPATH)
    appid = config[sec][key]
    return appid
    
def updatearrfromini(arr,flag=""):
    newarr={}
    for inkey in arr.keys():
        if inkey != "" :
            newarr[inkey]=arr[inkey]
    arr=newarr

    if flag!="":
        config = configparser.ConfigParser()
        config.read(r"D:\老黄牛小工具\配置文件\myconf.ini")
        for inkey in arr.keys():
            if inkey != "" :
                try:
                    arr[inkey]=config['ApiKeys'][inkey]
                except:
                    print("从config强制更新配置["+inkey+ "]失败！~")
    return arr

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


def randfile(valarr="",fkeyold="",flag="new"):
    #print("randfile---"+"fkeyold:"+fkeyold+"flag:"+flag)
    #print(valarr)
    #print("valarr---")
    if fkeyold=="":
        return str(int(round(time.time() * 1000)))+".tmp"
    
    try:
        f=valarr[fkeyold]
    except:
        return str(int(round(time.time() * 1000)))+".tmp"


    fex=os.path.splitext(f)[-1]
    #print("fex---"+" fex:"+fex+" flag:"+flag)
    if flag=="new":
        #print("flag in ")
        return str(int(round(time.time() * 1000)))+".tmpnew"+fex
    else:
        #print("flag not in ")
        return str(int(round(time.time() * 1000)))+".tmp"+fex

    path =str(int(round(time.time() * 1000)))+".tmp"
    return path
            

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
                except Exception as e:# 保存函数出错后的执行结果
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
        newdict[key]=dict1[key]
    for key in dict2.keys():
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
def saveerr2json(arr,s="",key="执行结果",):
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
    #print(new_file)
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



def printvalarr(valarr,errstr="错误输出值",prflag=True):
    valarr["执行结果"]=errstr
    if prflag==True :
        print(errstr)
    return valarr

#读取输入的数组
def getvalarr(jsonarr,inarr,outarr,prflag="false"):
    valarr,contarr,temparr={},{},{}
    #计算出contarr
    contarr=jsonarr["contents"]
    contarr=dictdiff(contarr,outarr)
    temparr["执行结果"]=""
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
    if "执行结果" not in arr2ret:  
        arr2ret["执行结果"] = "√"
    
    if fd2=={}:
        savearr2json(arr2ret, keyflag)

    arr2ret64 = arr2json64str(arr2ret)
    
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
    else:
        return "getfd2arr未知错误。"

#获取fd2的字典
def getfd2_f64(fd2={},fkeyold="",jsonarr={}):
    f64=""
    if fd2=={} and fkeyold !="":#看是否函数传入
        inpath=jsonarr["contents"][fkeyold]
        f64=readfile2f64(inpath)
        return f64
    elif fd2!={}:
        try:
            f64=fd2["f64"]
        except:
            try:
                f64=fd2.f64
            except:
                f64=""

        return f64
    elif fd2=={} and fkeyold =="":#看是否函数传入
        return ""
    else:
        return "getfd2arr未知错误。"

