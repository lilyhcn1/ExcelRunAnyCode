#r34.cc制作
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="待翻译文本"
#输出区
output1="翻译结果"
exeinfo="执行结果"

#错误时返回
keyarr={}
keyarr[input1]="hello world!"
keyarr[output1]="待返回值"
keyarr[exeinfo]="执行:“"+os.path.basename(__file__)+"”出错。"
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
        arr2save["执行结果"]="标题行不包括“"+ input1+"”."
        img1=listarr[input1]
    else:
        goto.error


    #----------------2.数据提交并返回数组-------------------

    JSONFILE=r'd:/老黄牛小工具/ExcelQuery/temp/temp.json'

    import json

    from tencentcloud.common import credential
    from tencentcloud.common.profile.client_profile import ClientProfile
    from tencentcloud.common.profile.http_profile import HttpProfile
    from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
    from tencentcloud.tmt.v20180321 import tmt_client, models
    try:
        appid=lilyfun.readini("ApiKeys","TencentTranID1")
        appkey=lilyfun.readini("ApiKeys","TencentTranKey1")
        cred = credential.Credential(appid, appkey)
        httpProfile = HttpProfile()
        httpProfile.endpoint = "tmt.tencentcloudapi.com" #接口网址

        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        client = tmt_client.TmtClient(cred, "ap-guangzhou", clientProfile) #接口地域

        req = models.TextTranslateRequest()
        params = {
            "SourceText": img1,#待翻译文本
            "Source": "auto",#语种自动识别
            "Target": "zh",#zh-简体中文 en-英语 ja-日语 ko-韩语
            "ProjectId": 0
        }
        req.from_json_string(json.dumps(params))

        resp = client.TextTranslate(req)
        print(resp.to_json_string())
        #将返回的resp转换为字符后通过json转为字典用于输出翻译结果
        resp=str(resp)
        import json
        user_info = resp
        user_dict = json.loads(user_info)
        print(user_dict)
    except TencentCloudSDKException as err:
        print(err)


    #----------------3.正确时的返回值-------------------
    arr2save[output1]=user_dict['TargetText']
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    
    goto.end
    label.error
    arr2save=keyarr
    #----------------4. 出错时的返回值-------------------

    lilyfun.savearr2json(arr2save,"all")


    label.end

    
        
main()


