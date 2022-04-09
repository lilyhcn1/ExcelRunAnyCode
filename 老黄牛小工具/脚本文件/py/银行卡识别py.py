import lilyfun  # 导入同路径下的函数

arr = {}
arr2save = {}

try:

    # 初始化读取数据
    listarr = lilyfun.readjson()
    img1 = listarr['图片路径']
    print(img1)

    # ----------------2.数据提交并返回数组-------------------
    import requests
    import base64

    # 获取access_token

    # client_id 为官网获取的AK， client_secret 为官网获取的SK
    host = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=qG1RyyDmTy7PS5P1yzoReUdH&client_secret=PrSoSH2LqyLFuBv5xedk5oyQ6Ta0Paxy'
    response = requests.get(host)
    # if response:
    # print(response.json()['access_token'])
    access_token = response.json()['access_token']

    '''
    银行卡识别
    '''
    request_url = "https://aip.baidubce.com/rest/2.0/ocr/v1/bankcard"
    # 二进制方式打开图片文件
    f = open(img1, 'rb')
    img = base64.b64encode(f.read())
    # print(img)

    params = {"image": img}
    request_url = request_url + "?access_token=" + access_token
    headers = {'content-type': 'application/x-www-form-urlencoded'}
    response = requests.post(request_url, data=params, headers=headers)
    # if response:
    # print (response.json())
    aa = response.json()
    print('日期:' + aa['result']['valid_date'])
    print('卡号:' + aa['result']['bank_card_number'])
    print('银行名:' + aa['result']['bank_name'])
    if aa['result']['bank_card_type'] == 0:
        print('银行卡类型:不能识别 ')
    if aa['result']['bank_card_type'] == 1:
        print('银行卡类型:借记卡 ')
    if aa['result']['bank_card_type'] == 2:
        print('银行卡类型:贷记卡 ')
    if aa['result']['bank_card_type'] == 3:
        print('银行卡类型:准贷记卡 ')
    if aa['result']['bank_card_type'] == 4:
        print('银行卡类型:预付费卡 ')
    print('持卡人姓名:' + aa['result']['holder_name'])

    arr2save["日期"] = aa['result']['valid_date']
    arr2save["卡号"] = aa['result']['bank_card_number']
    arr2save["银行名"] = aa['result']['bank_name']
    if aa['result']['bank_card_type'] == 0:
        arr2save["银行卡类型"] = '不能识别'
    if aa['result']['bank_card_type'] == 1:
        arr2save["银行卡类型"] = '借记卡'
    if aa['result']['bank_card_type'] == 2:
        arr2save["银行卡类型"] = '贷记卡'
    if aa['result']['bank_card_type'] == 3:
        arr2save["银行卡类型"] = '准贷记卡'
    if aa['result']['bank_card_type'] == 4:
        arr2save["银行卡类型"] = '预付费卡'
    if aa['result']['holder_name'] == '':
        arr2save["持卡人姓名"] = '空'
    else:
        arr2save["持卡人姓名"] = aa['result']['holder_name']




    # ----------------3.数据写入json文件-------------------
    print(arr2save)
    lilyfun.savearr2json(arr2save,"key")

    # ----------------4.出错处理-------------------
except:

    arr2save["图片路径"] = r"D:\老黄牛小工具\word模板\银行卡.jpg"
    arr2save["日期"] = "待返.."
    arr2save["卡号"] = "待返.."
    arr2save["银行名"] = "待返.."
    arr2save["银行卡类型"] = "待返.."
    arr2save["持卡人姓名"] = "待返.."

    lilyfun.savearr2json(arr2save, "all", 1)



