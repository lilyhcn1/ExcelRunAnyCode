#import logging
# 设置日志级别
#logging.basicConfig(level=logging.INFO)

# 自定义日志格式
#formatter = logging.Formatter('%(asctime)s %(levelname)s: %(message)s')

# 创建控制台日志处理程序
#console_handler = logging.StreamHandler()
#console_handler.setFormatter(formatter)

# 添加处理程序到根日志记录器
#logger = logging.getLogger()
#logger.addHandler(console_handler)


import sys
sys.path.append("d:\\老黄牛小工具\\脚本文件\\py")

import lilyfun  #老黄牛小工具下的文件
import chardet
import json,time,base64
import pyautogui,io
from fastapi import FastAPI
from fastapi.responses import Response
MOBAN="模板"
GENPATH="生成文件夹"
MBPATH=r'd:/老黄牛小工具/word模板'
PYTHONPATH=r'D:/老黄牛小工具/脚本文件/py'
JSONFILE=r'd:/老黄牛小工具/ExcelQuery/temp/temp.json'
JSONFILE2=r'd:/老黄牛小工具/ExcelQuery/temp/temp2.json'
TEMPTEXT=r'd:/老黄牛小工具/ExcelQuery/temp/temp.txt'
TEMPTDOCX=r'd:/老黄牛小工具/ExcelQuery/temp/temp.docx'

PYEXE="C:\\Users\\Administrator\\AppData\\Local\\Programs\\Python\\Python37\\python.exe"
JBPATH=r'D:/老黄牛小工具/脚本文件'

#----------------1.初始化读取数据----------------------
arr={}
prstr="true" #是否打印输出
#----------------fastapi 的区域----------------------

from fastapi import FastAPI
from fastapi import FastAPI, File, UploadFile, Form
from fastapi import FastAPI, Request, Body
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from fastapi import APIRouter,Depends,HTTPException,FastAPI,Request,Form,Body,File,UploadFile
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from typing import Dict
from starlette.staticfiles import StaticFiles
import base64,random,asyncio,uvicorn,os
from starlette.responses import FileResponse
from pydantic import BaseModel
from typing import Union
import lilyfun,requests,json

import urllib.parse
from fastapi.middleware.cors import CORSMiddleware

from urllib.parse import parse_qs
import yaml
from urllib.parse import quote
import traceback

#这里是wsmain的要修改部分
app=FastAPI()
# 记录日志
#logger.info('Application started')



#进入首页
@app.get("/")
async def root(request:Request):
    #return "首页暂时有问题，慢慢修。"
    return templates.TemplateResponse("index.html",{"request":request})
#这里是wsmain的要修改部分
#进入可以网页界面
@app.get('/p/{html}')
def root(request:Request,html:Union[str, None] = ""):
    return templates.TemplateResponse(html,{"request":request})
#进入可用ai首页
@app.get("/jb")
async def root(request:Request):
    return templates.TemplateResponse("jb.html",{"request":request})

#两个合并起来就是截图并实时发送
@app.get("/screenshot")
def capture_screenshot():
    # 截图
    screenshot = pyautogui.screenshot()
    # 创建一个字节流对象
    stream = io.BytesIO()
    # 将截图保存到字节流对象中
    screenshot.save(stream, format='PNG')
    stream.seek(0)
    headers = {
        "Cache-Control": "no-cache, no-store, must-revalidate",  # HTTP 1.1
        "Pragma": "no-cache",  # HTTP 1.0
        "Expires": "0",  # Proxies
    }
    # 生成响应对象，将字节流作为响应内容
    response = Response(content=stream.getvalue(), media_type='image/png',headers=headers)
    return response


    

class MyData(BaseModel):
    constr: str
@app.post("/jbpost")  
async def process_json(data: MyData):
    # 在这里处理接收到的 JSON 数据
    print(data)
    try:
        inputstr = data.constr
        runweburl(inputstr)
    except:
        print("/jbpost出错了。")
        return {"message": f"/jbpost出错了。"}
    
    return {"message": f"Received data: {data.constr}"}

#设置static文件夹与templates文件夹
templates=Jinja2Templates(directory="templates")
app.mount('/static', StaticFiles(directory='static'), name='static')





#设置允许访问的域名

#设置跨域传参
app.add_middleware(
    CORSMiddleware, 
    allow_origins=["*"],  #设置允许的origins来源
    allow_credentials=True,
    allow_methods=["*"],  # 设置允许跨域的http方法，比如 get、post、put等。
    allow_headers=["*"])  #允许跨域的headers，可以用来鉴别来源等作用。


class fd2(BaseModel):
    json64: Union[str, None] = None
    f64: Union[str, None] = None
    fkeyold: Union[str, None] = None
    fkeynew: Union[str, None] = None

class fd1(BaseModel):
    json64: str


    



def try_decode(data, encodings=('utf-8', 'latin-1', 'ascii')):
    for encoding in encodings:
        try:
            return data.decode(encoding), encoding
        except UnicodeDecodeError:
            continue
    raise ValueError("Failed to decode data with provided encodings")



#接收ahk上传过来的数据处理后返回
@app.post("/jb/{jbname}")  
async def receive_data(jbname:str,request:Request):
    #try:
    #    # 直接在这里设置5秒超时来获取请求体
    #    data = await asyncio.wait_for(request.body(), timeout=5.0)
    ##    #原来 data = await request.body()
    #except asyncio.TimeoutError:
    #    # 如果超时，则返回超时信息
    #    print("Request Timeout 5秒超时了。")
    #    return {"error": "Request Timeout"}
    try:
        #print("接收数据之前======================================================")
        data = await request.body()

        detected_encoding = chardet.detect(data)['encoding']  # 检测编码
        data_dict = data.decode(detected_encoding)

        #lilyfun.pr("000000000000000000--------------------------",prstr)
        lilyfun.pr("--------------------------------------------------------------------------------",prstr)
        lilyfun.pr("----------------------   "   + time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) +"       " + jbname + "  ----------" ,prstr)
        lilyfun.pr("--------------------------------------------------------------------------------" ,prstr)
        #print(data_dict)
        #if type(data_dict) is str:
        #    data_dict=yaml.safe_load(data_dict)    
        
        dd= yaml.safe_load(str(data_dict))


        decoded_data_dict ={}
        for  key, value in dd.items():
             decoded_data_dict[key]=value


        #lilyfun.pr("11111111111111--------------------------",prstr)
        #print(decoded_data_dict)
        #lilyfun.pr("111111111111111111-----------------------------------------------------------------" ,prstr)
        #print(decoded_data_dict)

        
        fd2={}
        fd2["fkeyold"]=""
        fd2["fkeynew"]=""
        fd2["f64"] = ""

        # 检查是否存在'json64'键
        if 'json64' in decoded_data_dict:
            fd2["json64"]=decoded_data_dict["json64"]
        else:
            fd2["json64"] =  lilyfun.arr2json64str(decoded_data_dict)
        #lilyfun.pr("6666666666666-----------------------------------------------------------------" ,prstr)
        #lilyfun.pr(fd2)
        # 检查是否存在'json64'键
        if 'f64' in decoded_data_dict:
            fd2["f64"]=decoded_data_dict["f64"]

        json64,f64,fkeyold,fkeynew="","","",""
        # ----------------四、传入funinputarr并运行函数----------------------

        #导入py
        try:
            pyfun=jbname+"py"
            exec("import "+jbname+"py")
            #exec("import aaapy")
            
            lilyfun.pr("[main]导入文件 "+pyfun +" 成功！" ,prstr)
        except Exception as e:
            print("---------- [main]导入文件 "+pyfun +" 出错了！---------\n"+traceback.format_exc())
            return  {"status":jbname+"import error.","json64":"","f64":""}
        
        #执行py,并返回值
        try:
            fd2new={}    
            fd2new=eval(pyfun).main(fd2)
        except Exception as e:
            print("---------- [main]执行 "+pyfun +" 出错了！---------\n"+traceback.format_exc())
            return  {"status":"error,exec ","json64":"","f64":""}

        
        try:
            json64=fd2new["json64"]
            f64=fd2new["f64"]
        except:
            f64=""
        if 'json64' in decoded_data_dict:
            return  {"status":"success","json64":json64,"f64":f64}
        else:
            jsonarr=lilyfun.json64tojsonarr(fd2new["json64"])
            print(jsonarr)
            arr=jsonarr["contents"]
            if f64!="":
                arr["f64"]=f64
            return json.dumps(arr)
    except Exception as e:
        print("---------- 执行出错，请检查! ---------\n"+traceback.format_exc())
        return "---------- 执行出错，请检查! ---------\n"+traceback.format_exc()
        





#构建前端传来的数据类型
class Item3(BaseModel):
    script_name:str  #脚本名称
    values:dict #输入
    database64:str

#接收数据
@app.post('/run4/')
def run4(item1:Item3):
    print("main 执行000000000000000000000000")
    fd2, arr = {}, {}
    #最终返回的字典
    result_={}
    #print("传入的值：")
    #print(item1)
    # 初始化，将前端的信息分离处理
    arr=item1.values
    print(arr)
    jbname = item1.script_name

    lilyfun.titlepr("run4中的arr：",arr,"true")
    #如果有文件就输入base64编码，不然就等于""(空值)
    try:
        base64data=item1.database64.split(",")[1]
    except:
        base64data=item1.database64

    # 导包
    try:
        exec("import " + jbname)
    except Exception as e:
        print("---------- 执行出错，请检查! ---------\n"+traceback.format_exc())



#    except Exception as e:
#        print("---------- 执行出错，请检查! ---------\n"+traceback.format_exc())


    #获取脚本中的一些信息
    n = eval(jbname).fkeyold
    m = eval(jbname).fkeynew
    mv = eval(jbname).inarr

    #将fkeyold值导入
    try:
        if n not in arr :
            arr[n] = eval(jbname).inarr[n]
        else:
            if arr[n]=="":
                arr[n] = eval(jbname).inarr[n]
    except:
        pass

    lilyfun.titlepr("run4中的arr22222：",arr,"true")
    # 将输入数据转化为json、base64形式
    fd2["json64"] = lilyfun.arr2json64str(arr)
    fd2["f64"] = base64data
    print("main 执行1")
    # 执行脚本文件
    fd2new = eval(jbname).main(fd2)
    print("main 执行结束")
    # 获取f64编码
    f64 = fd2new["f64"]

    #将文件名存入字典内
    result_["base64"]=f64

    #构造有文件的文件名，！！！可能有问题，这是只是inarr！！！
    try:
        result_["filename"]="file."+mv[m].split(".")[-1]
    except:
        result_["filename"]=""

    #将结果转化为json（解码）
    jsonarr = lilyfun.json64tojsonarr(fd2new["json64"])
    result=jsonarr["contents"]

    #将输出结果存入result_
    result_li = []
    for i in result.items():
        result_dic = {}
        result_dic["key"] = i[0]
        result_dic["values"] = i[1]
        result_li.append(result_dic)
    result_["state"]=result_li
    return result_




    
#进入首页
@app.get("/id")
async def root(request:Request):
    arr2,r={},{}
    #获取脚本文件
    script_file = os.listdir("./")
    # print(script_file)
    n=0
    li=[]
    t={}
    for i in script_file:     
        n=n+1
        if ".py" in i:
            t={}
            aa=i.split(".py")[0]
            #print(aa[len(aa)-2:len(aa)])
            if aa[len(aa)-2:len(aa)]=="py":
                t["功能名"]=aa[0:len(aa)-2]
            if t!={}:
                li.append(t)

    r["code"]=0
    r["info"]="正常返回json数据。"
    r["arr"]=li
    js=json.dumps(r,ensure_ascii=False)
    return js




def gettodict(queryurl):
    b=str.split(queryurl,"&")
    arr={}
    for t in b:
        tt=str.split(t,"=")
        if len(tt)==2 and tt[0] != "":
            key=urllib.parse.unquote(tt[0])
            val=urllib.parse.unquote(tt[1])
            arr[key]=val
    return arr





#选择功能并进行相对应脚本的运行
@app.get('/jb/{gn_type1}')
def gn(request:Request,gn_type1:Union[str, None] = ""):
    #aa=parse_qs_bytes(request.url.query)
    # 切换工作目录到脚本所在的目录
    script_path = os.path.abspath(__file__)
    script_dir = os.path.dirname(script_path)
    os.chdir(script_dir)
    
    getarr,postarr,newarr={},{},{}
    print(gn_type1)
    if os.path.exists(gn_type1 + ".py"):
       pyfun=gn_type1
    elif os.path.exists(gn_type1 + "py.py"):
       pyfun=gn_type1+"py"
    elif os.path.exists(gn_type1 + ".py"):
       pyfun=gn_type1
       
    else:
        
       return "没有该脚本！"

    #print("jb get运行0")




    try:
        exec("import " + pyfun)
        input1 = eval(pyfun).inarr
        outputarr = eval(pyfun).outarr
        output1 = eval(pyfun).outarr
        fkeyold = eval(pyfun).fkeyold
        fkeynew = eval(pyfun).fkeynew
    except Exception as e:
        print("导入函数出错，可能是引用了多线程函数的原因！")
        # 打印异常的堆栈跟踪信息
        traceback.print_exc()

        return "导入函数出错，可能是引用了多线程函数的原因！~"

    try:
        #print("jb get运行1")
        try:
            getarr=gettodict(request.url.query)
            #print(getarr)
            if getarr!={}:
                postarr["script_name"]=pyfun  #脚本名称
                postarr["values"]=getarr
                postarr["database64"]=""
                print(postarr)
                #print("jb get运行2")
                url=str(request.base_url)+"run4/"
                print(url)
                html = requests.post(url, json.dumps(postarr),headers={"Content-Type": "application/json"}, verify=False)
                print(html.text)
                #print("jb get运行3")
                json1 = json.loads(html.text)

                try:
                    json1 = json.loads(html.text)
                    for arr in json1["state"]:
                        newarr[arr["key"]]=arr["values"]
                    return newarr
                except:
                    return json1

        #print("jb get运行4")
        except Exception as e:
            print("发生了一个错误:", e)
            # 打印异常的堆栈跟踪信息
            traceback.print_exc()
            return "传参后错误，请检查！"





        #print(input2)
        input2=input1.copy()
        output2=output1.copy()
        filename=""
        # 不需要输入文件

        # 需要输入文件
        if fkeyold!="" :
           if fkeyold in input2:
                input2.pop(fkeyold)
                filename=fkeyold
           #print(filename)
           #如果fkeynew非空的话，把输入时把他也删了。

        newkeyarr={}
        fval=""
        if fkeynew!="" :
            if fkeynew in input2:
                newkeyarr[fkeynew]=input2[fkeynew]
                fkey=newkeyarr[fkeynew]
                fval=input2[fkeynew]
                input2.pop(fkeynew)
        #lilyfun.titlepr("input2 ",input2，"true")






      
        inputstr=lilyfun.getjsontype(input2)
        if fkeyold!="":
            inputstr=inputstr+", \"f64\":"+ "\""+fkeyold+" 对应文件的base64"+ "\""

        if fkeynew in outputarr:
            outputarr.pop(fkeynew)
        #if "" in outputarr:
        #    outputarr.pop("")
        outputstr=lilyfun.getjsontype(outputarr)
        if fkeynew!="":
            outputstr=outputstr+", \"f64\":"+ "\""+fkeynew+" 对应文件的base64"+ "\""
          


        #获取到url路径
        geturl="/jb/"+gn_type1+"?"
        for key in input2:
            geturl =geturl+ key +"="+input2[key]+"&"
        geturl=lilyfun.remove_last_segment(geturl,"&")

        
        #获取到curlurl路径
        urlbase=request.url.scheme+"://"+request.url.netloc+quote("/jb/"+gn_type1)
    except Exception as e:
        print("发生了一个错误:", e)
        # 打印异常的堆栈跟踪信息
        traceback.print_exc()
        return "try error"
   




            
            

    print("脚本【"+gn_type1+"】导入结束！")
       # 返回结果

    return templates.TemplateResponse("gn4.html",
{"request": request, "function": pyfun, "input_web": input2.items(),"filename":filename,"jbname":gn_type1, 
"newfilearr": newkeyarr.items(),"outputarr":outputarr.items(), "fval":fval,
"geturl":geturl, "inputstr":inputstr,"outputstr":outputstr, "urlbase":urlbase})
    


#这里是wsmain的要修改部分
#运行配置
#if __name__ == '__main__':
#    uvicorn.run("main:app",host="127.0.0.1",port=8001,reload=True,debug=True)
#    # uvicorn main: app --host 127.0.0.1 --port 8001 --reload
