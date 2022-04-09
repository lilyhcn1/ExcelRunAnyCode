import lilyfun  #导入同路径下的函数
#----------------0.出错时的返回值----------------------
arr={}
arr2save={}
#----------------1.初始化读取数据----------------------
try:
    #初始化读取数据
    listarr=lilyfun.readjson()
    img1=listarr['图片路径']
    print("bbbbbb")

#----------------2.数据提交并返回数组-------------------
    print(922222999)
    from qcloud_image import Client
    from qcloud_image import CIFiles
    print(9999)
    appid = '1252487553'
    secret_id = 'AKIDOcaHhqjLgkZ8QRCfrmPntiGXXGitIRJt'
    secret_key = 'LPCizzjCPLzMRGo55oFPIvHM9fvuc7MK'

    bucket = 'BUCKET'  # 这里默认 不需要动
    client = Client(appid, secret_id, secret_key, bucket)
    client.use_http()
    client.set_timeout(30)
    dic = client.idcard_detect(CIFiles([img1]), 0)
    print(dic['result_list'][0]['data'])

    arr2save["民族"] = dic['result_list'][0]['data']['nation']
    arr2save["性别"] = dic['result_list'][0]['data']['sex']
    arr2save["地址"] = dic['result_list'][0]['data']['address']
    arr2save["姓名"] = dic['result_list'][0]['data']['name']
    arr2save["出生日期"] = dic['result_list'][0]['data']['birth']
    arr2save["身份证号"] = dic['result_list'][0]['data']['id']

#----------------3.数据写入json文件-------------------
    print(arr2save)
    lilyfun.savearr2json(arr2save,"key")

#----------------4.出错处理-------------------
except:
    print("888")

    arr2save["图片路径"]=r"D:\老黄牛小工具\word模板\身份证.jpg"
    arr2save["民族"]="待返.."
    arr2save["性别"]="待返.."
    arr2save["地址"]="待返.."
    arr2save["姓名"]="待返.."
    arr2save["出生日期"]="待返.."
    arr2save["身份证号"]="待返.."
    print(arr2save)
    lilyfun.savearr2json(arr2save,"all",1)
