#!/usr/bin/env python
# -*- coding:utf-8 -*-
# https://www.jb51.net/article/180307.htm
import os,json
import win32com
from win32com.client import Dispatch
import os,json
import win32com
from win32com.client import Dispatch
import time
import win32com.client
import pythoncom
from win32com.client import gencache

import win32com.client as win32
from win32com.client import constants
import os


# 处理Word文档的类
  
class RemoteWord:
    def __init__(self, filename=None):
        self.xlApp = win32com.client.Dispatch('Word.Application') # 此处使用的是Dispatch，原文中使用的DispatchEx会报错
        self.xlApp.Visible = 0 # 后台运行，不显示
        self.xlApp.DisplayAlerts = 0  #不警告
        if filename:
            self.filename = filename
            if os.path.exists(self.filename):
                self.doc = self.xlApp.Documents.Open(filename)
            else:
                self.doc = self.xlApp.Documents.Add()  # 创建新的文档
                self.doc.SaveAs(filename)
        else:
            self.doc = self.xlApp.Documents.Add()
            self.filename = ''
  
    def add_doc_end(self, string):
        '''在文档末尾添加内容'''
        rangee = self.doc.Range()
        rangee.InsertAfter('\n' + string)
  
    def add_doc_start(self, string):
        '''在文档开头添加内容'''
        rangee = self.doc.Range(0, 0)
        rangee.InsertBefore(string + '\n')
  
    def insert_doc(self, insertPos, string):
        '''在文档insertPos位置添加内容'''
        rangee = self.doc.Range(0, insertPos)
        if (insertPos == 0):
            rangee.InsertAfter(string)
        else:
            rangee.InsertAfter('\n' + string)
  
    def replace_doc(self, string, new_string):
        '''替换文字'''
        self.xlApp.Selection.Find.ClearFormatting()
        self.xlApp.Selection.Find.Replacement.ClearFormatting()
        #(string--搜索文本,
        # True--区分大小写,
        # True--完全匹配的单词，并非单词中的部分（全字匹配）,
        # True--使用通配符,
        # True--同音,
        # True--查找单词的各种形式,
        # True--向文档尾部搜索,
        # 1,
        # True--带格式的文本,
        # new_string--替换文本,
        # 2--替换个数（全部替换）
        self.xlApp.Selection.Find.Execute(string, False, False, False, False, False, True, 1, True, new_string, 2)
        for shp in self.doc.Shapes:
            if shp.TextFrame.HasText:
                #print(shp.TextFrame.TextRange.Text)
                aa=shp.TextFrame.TextRange.Text
                shp.TextFrame.TextRange.Text = aa.replace(string, new_string)



  
    def replace_docs(self, string, new_string):
        '''采用通配符匹配替换'''
        self.xlApp.Selection.Find.ClearFormatting()
        self.xlApp.Selection.Find.Replacement.ClearFormatting()
        self.xlApp.Selection.Find.Execute(FindText=source, ReplaceWith=target, Replace=1, Forward=True)

    def save(self):
        '''保存文档'''
        self.doc.Save()
  
    def save_as(self, filename):
        '''文档另存为'''
        self.doc.SaveAs(filename)
  
    def close(self):
        '''保存文件、关闭文件'''
        self.save()
        self.xlApp.Documents.Close()
        self.xlApp.Quit()



#r34.cc制作
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto       
prstr="true" #是否打印输出


#输入区
input1="模板名"
#输出区
output1="生成名"
exeinfo="执行结果"



@with_goto
def main():
    JSONFILE=r'd:/老黄牛小工具/ExcelQuery/temp/temp.json'
    arr={}
    arr2save={}
    #----------------1.初始化读取数据----------------------

    #初始化读取数据
    try:
        listarr=lilyfun.readjson()
    except:
        arr2save["执行结果"]="readjson出错了。"
        goto.error
    if input1 in listarr.keys(): #对应第一个输入
        img1=listarr[input1]
        if img1=="":
            arr2save["执行结果"]="请输入‘"+ input1+"’对应的值."
            goto.error
    else:
        arr2save["执行结果"]="标题行不包括‘"+ input1+"’."
        goto.error

    #读取输入路径，处理异常 
    excelpath=lilyfun.readjson("excelpath")
    old_file=lilyfun.getwholepath(listarr[input1],excelpath) #相对路径
    new_file=lilyfun.getwholepath(listarr[output1],excelpath) #相对路径
    
    if(os.path.isfile(new_file)):     
        os.remove(new_file)
    lilyfun.mkdir(new_file)  #保证目录的存在

    print(old_file+"=>"+new_file)


    #----------------2.数据提交并返回数组-------------------



    

    #print("-----------")
    doc = RemoteWord(old_file)  # 初始化一个doc对象
    for key,value in listarr.items():
        #print("key:"+key+"  value "+value)
        doc.replace_doc(key, value)  # 替换文本内容
    doc.save_as(new_file)
    doc.close()

    #----------------3.正确时的返回值-------------------
    #arr2save[output1]=""
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]=r"D:\老黄牛小工具\word模板\座位牌3字160磅.docx"
    arr2save[output1]="老黄牛.docx"
    arr2save["数据01"]="替换1"
    arr2save["数据02"]="替换2"
    arr2save["数据03"]="替换3"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()  
    

