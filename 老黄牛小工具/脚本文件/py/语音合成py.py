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
 

secret_id = "AKIDsa2D7k6B0XnlUx83h4B2buwg9MIxLRHq"  # 您腾讯云账号的id， 请自行输入
secret_key = "KM8droUt0rRloZ3HEafT0GEvMbZHjuoR"  # 您腾讯云账号的key，请自行输入
 
 
def get_string_to_sign(method, endpoint, params):
    s = method + endpoint + "/?"
    query_str = "&".join("%s=%s" % (k, params[k]) for k in sorted(params))
    return s + query_str
 
 
def sign_str(key, s, method):
    hmac_str = hmac.new(key.encode("utf8"), s.encode("utf8"), method).digest()
    return base64.b64encode(hmac_str)
 
 
# 保存成文件
def save_audio_file(rsp_dic):
    # 传回的音频, 是base64, 也就是一种用64个字符来表示任意二进制数据的方法（8bit）
    audio_txt = rsp_dic["Response"]["Audio"]
    base64_to_file(audio_txt, file_path)
 
 
def base64_to_file(base64_txt, file_path):
    audio_b_data = base64.b64decode(base64_txt)
    audio_file = open(file_path, 'wb')
    audio_file.write(audio_b_data)
    audio_file.close()
    print("saved:"+file_path)
 
 
# 官方的权限验证、以及调用接口的参数
def test_2_offical():
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
    save_audio_file(resp.json())
 

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



import lilyfun  #导入同路径下的函数
#----------------1.初始化读取数据----------------------
arr={}
#初始化读取数据
listarr=lilyfun.readjson()
img1=listarr['文本']
img2=""
nowpath=lilyfun.readjson('excelpath')
#fv=firstval(listarr)
print(img1 +"--"+ img2)
#----------------2.数据提交并返回数组-------------------
file_path = nowpath+ "\\" +  img1 + ".mp3"


 
if __name__ == "__main__":
    print("Start TTS ....")
    test_2_offical()


arr2save={}
arr2save['语音路径']=file_path
arr2save['语音时长']=get_mp3_duration(file_path)

#----------------3.数据写入json文件-------------------
lilyfun.savearr2json(arr2save,"key")
