#r34.cc制作
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="文件地址"
#输出区
output1="识别结果"
exeinfo="执行结果"


@with_goto
def main():
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
        arr2save["执行结果"]="标题行不包括"+ input1+"."
        img1=listarr[input1]
    else:
        goto.error



    #----------------2.数据提交并返回数组-------------------

    from urllib import request
    import urllib.parse

    import requests
    import time


    from aip import AipSpeech
    """ 你的 APPID AK SK """
    APP_ID = '10330658'
    API_KEY = 'r5ariWB9htPUkbmt9y4CzjGG'
    SECRET_KEY = 'hu8k6fQl0BlbEqmXrIZlqANyKKeKKIRM  '

    client = AipSpeech(APP_ID, API_KEY, SECRET_KEY)

    # 读取文件
    def get_file_content(file_path):
        with open(file_path, 'rb') as fp:
            return fp.read()
    # 识别本地文件
    result = client.asr(get_file_content(img1), 'wav', 16000, {
        'dev_pid': 1537,  # 默认1537（普通话 输入法模型），dev_pid参数见本节开头的表格
    })

    print(result)
    vv=""
    arr2save={}
    bb=result['result']
    vv=bb
    #for v in bb:
    #    vv=vv+vars





    #----------------3.正确时的返回值-------------------
    arr2save[output1]=vv
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="D:\老黄牛小工具\word模板\录音.wav"
    arr2save[output1]="待返回值"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()

