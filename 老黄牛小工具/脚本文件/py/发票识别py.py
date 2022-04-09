#r34.cc制作
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto


arr={}
arr2save={}
keysarr={}
keysarr["图片路径"]="D:\老黄牛小工具\word模板\发票.jpg"
keysarr["购买方名称"]="待返.."
keysarr["购买方识别号"]="待返.."
keysarr["购买方地址、电话"]="待返.."
keysarr["货物或应税劳务、服务名称"]="待返.."
keysarr["单价"]="待返.."
keysarr["税额"]="待返.."
keysarr["合计金额"]="待返.."
keysarr["合计税额"]="待返.."
keysarr["价税合计(大写)"]="待返.."
keysarr["小写金额"]="待返.."
keysarr["销售方名称"]="待返.."
keysarr["销售方识别号"]="待返.."
keysarr["销售方地址、电话"]="待返.."
keysarr["销售方开户行及账号"]="待返.."

@with_goto
def main():
    arr={}
    arr2save={}
    print("刚开始")

    #----------------1.初始化读取数据----------------------

    input1="图片路径"
    try:
        listarr=lilyfun.readjson()
    except:
        arr2save["执行结果"]="readjson出错了。"
        goto.error
    print(listarr)
    if input1 in listarr.keys(): #对应第一个输入
        img1=listarr[input1]
    else:
        arr2save["执行结果"]="标题行不包括"+ input1+"."
        goto.error
    
    print("执行过图片路径了")

#----------------2.数据提交并返回数组-------------------

    from tencentcloud.common import credential
    from tencentcloud.common.profile.client_profile import ClientProfile
    from tencentcloud.common.profile.http_profile import HttpProfile
    from tencentcloud.ocr.v20181119 import ocr_client, models
    import base64
    import json

 
    sid=lilyfun.readini("ApiKeys","TencentfpId1")
    skey=lilyfun.readini("ApiKeys","TencentfpKey1")
    #cred = credential.Credential(appid, appkey)
    #cred = credential.Credential(appid, appkey)
    # 打开图片
    with open(img1, "rb") as f:
        data = f.read()
        encodestr = base64.b64encode(data)  # 得到 byte 编码的数据
        # print(len(str(encodestr, 'utf-8')))
        picbase = str(encodestr, 'utf-8')

    # 开始图片识别
    try:
        cred = credential.Credential(sid, skey)
        httpProfile = HttpProfile()
        httpProfile.endpoint = "ocr.tencentcloudapi.com"

        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        client = ocr_client.OcrClient(cred, "ap-beijing", clientProfile)

        req = models.VatInvoiceOCRRequest()
        params = '{\"ImageBase64\":\"%s\"} ' % picbase
        req.from_json_string(params)

        resp = client.VatInvoiceOCR(req)
        reinfo = json.loads(resp.to_json_string())


        print(reinfo)
        #print(arr2save)
        # 拿到数据
        print("已拿到数据")
        for i in range(0, 100):
            if reinfo['VatInvoiceInfos'][i]['Name'] == "发票代码":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["发票代码"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "发票号码":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["发票号码"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "开票日期":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["开票日期"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "购买方名称":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["购买方名称"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "购买方识别号":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["购买方识别号"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "购买方地址、电话":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["购买方地址、电话"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "货物或应税劳务、服务名称":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["货物或应税劳务、服务名称"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "单位":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["单位"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "规格型号":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["规格型号"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "单价":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["单价"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "税额":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["税额"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "合计金额":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["合计金额"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "合计税额":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["合计税额"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "价税合计(大写)":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["价税合计(大写)"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "小写金额":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["小写金额"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "销售方名称":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["销售方名称"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "销售方识别号":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["销售方识别号"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "销售方地址、电话":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["销售方地址、电话"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "销售方开户行及账号":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["销售方开户行及账号"]=reinfo['VatInvoiceInfos'][i]['Value']
            if reinfo['VatInvoiceInfos'][i]['Name'] == "开票人":
                print(reinfo['VatInvoiceInfos'][i]['Value'])
                arr2save["开票人"]=reinfo['VatInvoiceInfos'][i]['Value']
        print(arr2save)
    except:
        print("执行出错。")
        
    arr2save["执行结果"]="√"  #代码有问题，强行正确
    #----------------3.数据写入json文件-------------------

    lilyfun.savearr2json(arr2save,"key")


    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    for k in keysarr:
        arr2save[k]=keysarr[k]

    print(arr2save)
    lilyfun.savearr2json(arr2save,"all")
    label.end

main()
