#r34.cc制作
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出



# #################################
# Copyright(C) 2012-2017
# Environment:        python 3.9.7
# Package:                       -
# D&P Author By:            常成功
# Create Date:          2021-12-09
# Modify Date:          2021-12-09
# #################################
 
# 描述：
# 测试腾讯云的语音合成技术（TTS）, 把返回的音频存储成MP3文件
 
import base64
import hashlib
import hmac
import requests
import time
import random
import eyed3

def get_mp3_duration(audio_path):
    xx = eyed3.load(audio_path)
    print(u'时长为：{}秒'.format(xx.info.time_secs))
    return "{:.1f}".format(xx.info.time_secs)
 

 
def get_string_to_sign(method, endpoint, params):
    s = method + endpoint + "/?"
    query_str = "&".join("%s=%s" % (k, params[k]) for k in sorted(params))
    return s + query_str
 
 
def sign_str(key, s, method):
    hmac_str = hmac.new(key.encode("utf8"), s.encode("utf8"), method).digest()
    return base64.b64encode(hmac_str)
 
 
# 保存成文件
def save_audio_file(rsp_dic,file_path):
    # 传回的音频, 是base64, 也就是一种用64个字符来表示任意二进制数据的方法（8bit）
    audio_txt = rsp_dic["Response"]["Audio"]
    base64_to_file(audio_txt, file_path)
 
 
def base64_to_file(base64_txt, file_path):
    audio_b_data = base64.b64decode(base64_txt)
    audio_file = open(file_path, 'wb')
    audio_file.write(audio_b_data)
    audio_file.close()
    print("saved:"+file_path)
 
 




#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="文本"
#输出区
output1="语音路径"
output2="语音时长"
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
        
    #读取输入路径，处理异常 
    excelpath=lilyfun.readjson("excelpath")
    #old_file=lilyfun.getwholepath(listarr[input1],excelpath) #相对路径
    if output1 in listarr.keys() : #对应第一个输入
        if not listarr[output1] =="":
            new_file=lilyfun.getwholepath(listarr[output1],excelpath) #相对路径
            if(os.path.isfile(new_file)):     
                os.remove(new_file)
            lilyfun.mkdir(new_file)  #保证目录的存在
    #print(old_file+"=>"+new_file)

    #----------------2.数据提交并返回数组-------------------
    secret_id=lilyfun.readini("ApiKeys","TencentfpId1")
    secret_key=lilyfun.readini("ApiKeys","TencentfpKey1")



    endpoint = "tts.tencentcloudapi.com"
    data = {
        'Action': 'TextToVoice',
        'Text': img1,
        'SessionId': 'session_chang',   # 'session'+str(random.randint(1,10000)),   # 随机
        'ModelType': '1',
        'Volume': '1',
        'Speed': '0',
        'ProjectId': '0',
        'VoiceType': '1002',
        'PrimaryLanguage': '1',
        'SampleRate': '16000',
        'Codec': 'mp3',
        # 下面是其他必选公共参数
        'Region': 'ap-beijing',
        'Nonce': random.randint(1, 100000),
        'SecretId': secret_id,
        'Timestamp': int(time.time()),
        'Version': '2019-08-23',
    }


    s = get_string_to_sign("GET", endpoint, data)
    data["Signature"] = sign_str(secret_key, s, hashlib.sha1)
    #print(data["Signature"])
    # 此处会实际调用，成功后可能产生计费
    resp = requests.get("https://" + endpoint, params=data)
    # 输出一下拼出来的参数
    #print(resp.url)
    # 输出一下返回
    #print(resp.json())
    # 保存返回的音频数据
    save_audio_file(resp.json(),new_file)


    arr2save={}
    #arr2save['语音路径']=new_file
    arr2save['语音时长']=get_mp3_duration(new_file)

    #----------------3.正确时的返回值-------------------

    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="老黄牛小工具"
    arr2save[output1]="生成文件夹\老黄牛小工具.mp3"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    #print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
