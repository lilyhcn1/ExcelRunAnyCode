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
MOBAN="模板"
GENPATH="生成文件夹"
MBPATH=r'd:/老黄牛小工具/word模板'
JSONFILE=r'd:/老黄牛小工具/ExcelQuery/temp/temp.json'
JSONFILE2=r'd:/老黄牛小工具/ExcelQuery/temp/temp2.json'
TEMPTEXT=r'd:/老黄牛小工具/ExcelQuery/temp/temp.txt'
INIPATH=r"D:\老黄牛小工具\配置文件\myconf.ini"

#这里替换成常用函数
def savearr2json(arr,wtype="all",code="0"):
    with open(JSONFILE, 'w') as file_object:
        sc=os.path.splitext(os.path.basename(__file__))[0]
        arr2={}
        arr2['script']=sc
        arr2['w']=wtype
        arr2['code']=code
        arr2['contents']=arr
        file_object.write(json.dumps(arr2))

        
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


#读取json数据
def readjson(key="contents"):
    listarr={}
    with open(JSONFILE,'r',encoding='utf8') as f:
        ct = f.read()
        if ct.startswith(u'\ufeff'):
            ct = ct.encode('utf8')[3:].decode('utf8')
            ct = ct.replace('\\','\\\\')
    jsonarr = json.loads(ct)
    #print(key in jsonarr.keys())
    if key in jsonarr.keys():
        listarr = jsonarr[key]
    else:
        listarr=jsonarr
    return listarr




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
def pr(str,flag="true"):
    if flag=="true":
        print(str)

""" 字典保证值的存在 """
def arrstr(arr,key,s=""):
    if key in arr.keys():
        return arr
    else:
        arr[key]=s
        return arr

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
#raltiveapth 相对路径
#folder 文件夹
def getwholepath(raltiveapth,folder):
    if ":" in raltiveapth:
        new_file = raltiveapth
    else:
        new_file = folder+"\\"+raltiveapth
    return new_file


def mkdir(path):
    folder=os.path.dirname(path)
    print(folder)
    folderexist = os.path.exists(folder)
    if not folderexist:
        os.makedirs(folder)


def GetDesktopPath():
    return os.path.join(os.path.expanduser("~"), 'Desktop')
