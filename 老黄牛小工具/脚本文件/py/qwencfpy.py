﻿#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
import os
import time
import json
import requests
import re
import json


def extract_last_json_string(s):
    # 初始化堆栈和结果列表
    stack = []
    result = []

    # 遍历字符串的每个字符
    for i, char in enumerate(s):
        if char == '{':
            if not stack:
                start = i  # 记录 JSON 对象的起始位置
            stack.append(char)
        elif char == '}':
            stack.pop()
            if not stack:
                end = i + 1  # 记录 JSON 对象的结束位置
                result.append(s[start:end])
    
    # 如果找到 JSON 字符串，返回最后一个
    if result:
        return result[-1]
    
    return None



def run(msg,api_key="",cfid="",model="@cf/qwen/qwen1.5-14b-chat-awq"):
    apibaseurl = "https://api.cloudflare.com/client/v4/accounts/"+cfid+"/ai/run/"
    headers = {"Authorization": "Bearer "+api_key}
    inputs = [
        { "role": "system", "content": "你有一个有用的助手。回复时都会使用中文回答。" },
        { "role": "user", "content": msg}
    ];
    input = { "messages": inputs }
    response = requests.post(f"{apibaseurl}{model}", headers=headers, json=input)
    return response.json()



def chataicf(msg="你是什么模型？通问千义吗？版本号多少？ ",cf_apikey="43wk1ivE3fkbmTXsNtUa7AzD7dHi4HpzAQohwMY3",cf_id="6e8b16061cc1d83f72f84615d806cd33",model="@cf/qwen/qwen1.5-14b-chat-awq"):

    output = run(msg,cf_apikey,cf_id,model)
    return output["result"]["response"]

def chataicfarr(msg="你能从下面的字符串中提取信息，并以json的形式返回。Json的键值为校区、周数、周几。字符串为：(临海第11周周五下午）电信学院教风学风督查记录表",cf_apikey="43wk1ivE3fkbmTXsNtUa7AzD7dHi4HpzAQohwMY3",cf_id="6e8b16061cc1d83f72f84615d806cd33",model="@cf/qwen/qwen1.5-14b-chat-awq"):

    outputstr = chataicf(msg,cf_apikey,cf_id,model)
    s= extract_last_json_string(outputstr)

    last_json = extract_last_json_string(s)

    # 解析 JSON 字符串为字典
    if last_json:
        json_obj = json.loads(last_json)
        return json_obj
    else:
        return s

#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = True  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["msg"]="你是什么模型？是通问千义吗？"
inarr[""]=""
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr["remsg"] = "已返回"
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
        errarr = lilyfun.printtraceback(errarr,"读取fd2错误，请检查！",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[1/4] fd2 传入成功！：","传入成功",prflag)

    # ----------------[2/4] 生成f64,json64解码为jsonarr -----------
    try: #1.2 json64解码为jsonarr
        jsonarr = lilyfun.json64tojsonarr(json64)
        jsoncontentarr =jsonarr["contents"]
        jsoncontentarr=lilyfun.updatearrfromini(jsoncontentarr,config)
        jsonarr["contents"]=jsoncontentarr
        f64=lilyfun.getfd2_f64(fd2,fkeyold,jsonarr)
    except Exception as e:# 保存函数出错后的执行结果
        errarr = lilyfun.printtraceback(errarr,"jsonarr解码错误，请检查！",e,prflag)
        #fd2:函数传过来的值，arr2ret:运行得到的数组，prflag：打印标记
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[2/4] 解码成功 jsonarr：",jsonarr,prflag)

    # ----------------[3/4]按输入区读传过来的值并反馈到字典valarr ------
    try:
        valarr=lilyfun.getvalarr(jsonarr,inarr,outarr,prflag,fkeyold,fkeynew)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"标题行没有需要的值，请确保标题行存在！",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("","获取到的f64的长度为: " + str(len(f64)),prflag)
    lilyfun.titlepr("[3/4] 检查输入值成功 valarr：",valarr,prflag)
    #这里可能还要再写读文件的
    
    # ----------------[4/4]调用函数并生成arr2ret及f64 -------------------
    try:  # 运行函数,最后要生成arr2ret及f64
        old_filepath=lilyfun.randfile(errarr,fkeyold,"old")
        new_filepath=lilyfun.randfile(errarr,fkeynew,"new")
        old_filepath=lilyfun.writefile64(f64,old_filepath)
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写文件错误，请检查！",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr msg    
    #inarr remsg    
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        msg=valarr["msg"]
        r=chataicf(msg)
        arr2ret["remsg"]=r

    #3333333333333333333333333333333333333333333333333333
    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printtraceback(valarr,"[运行]调用函数出错，请检查值是否正确。",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)

    try:  # 运行函数,最后要生成arr2ret及f64
        f64=lilyfun.readfile2f64(new_filepath)#有新文件就读取
        # newpath = valarr[fkeynew]
        # if f64!="" and fkeynew!="" and fd2=={}:
        #     lilyfun.writefile64(f64,newpath)
        lilyfun.safedel(old_filepath)
        lilyfun.safedel(new_filepath)
        arr2ret["execstat"]="√"
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写、删除文件错误。！",e,prflag)
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
        valarr = lilyfun.printtraceback(valarr,"写入文件出错，请检查值是否正确！",e,prflag)
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

