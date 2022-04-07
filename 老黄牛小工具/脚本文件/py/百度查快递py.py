import lilyfun  #导入同路径下的函数
#----------------0.出错时的返回值----------------------
arr=arr2save=keysarr={}
keysarr["快递单号"]="9886903825406"
keysarr["手机后4位"]="6700"
keysarr["最后物流信息"]="待返回值"

#----------------1.初始化读取数据----------------------


try:
    #初始化读取数据
    listarr=lilyfun.readjson()
    img1=listarr['快递单号']
    img2=listarr['手机后4位']
    #print(listarr['录取照片路径'])
    #print(listarr['入学照片路径'])
    #fv=firstval(listarr)
    print(img1 +"--"+ img2)
    #----------------2.数据提交并返回数组-------------------
    import re
    import time
    import random
    import requests_html

    session = requests_html.HTMLSession()

    class Kuaidi(object):
        def __init__(self, number, phone):
            # 转运信息url
            self.url = 'https://www.kuaidi100.com/query'
            # 获取token url和Hm_lvt
            self.token_url = 'https://www.kuaidi100.com/'
            # 获取快递名url
            self.name_url = 'https://www.kuaidi100.com/autonumber/autoComNum'
            # 快递名参数
            self.number_params = {
                'text': number
            }
            self.token_params = {
                'from': 'openv'
            }
            # 转运信息参数
            self.temp = str(random.random())
            self.params = {
                'type': self.getname(),
                'postid': number,
                'temp': self.temp,
                'phone': ''
            }
            csrftoken = self.gettoken()
            self.headers = {
                'Connection': 'keep-alive',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36',
                'Referer': 'https://www.kuaidi100.com/?from=openv',
                'Cookie': 'csrftoken=' + csrftoken[0] + '; Hm_lvt_' + csrftoken[1] + '=' + str(int(time.time())) + '; Hm_lpvt_' + csrftoken[1] + '=' + str(int(time.time()))
            }
        # 获取转运信息
        def getdata(self):
            # 转运信息参数
            rous = session.get(self.url, headers=self.headers, params=self.params)
            #print(rous.text)
            datas = rous.json()['data']
            d2 = rous.json()['data'][0]['context']
            d1 = rous.json()['data'][0]['time']
            #for data in datas:
             #   return data["time"].data["context"]
            return d1 +" "+  d2

        # 获取token 和 Hm_lvt
        def gettoken(self):
            rous = session.get(self.token_url, params=self.token_params)
            Set_Cookie = rous.headers['Set-Cookie']
            csrftoken = re.findall(', csrftoken=(.*?);', Set_Cookie)[0]
            js_url = re.findall('https://cdn.kuaidi100.com/js/share/count.js(.*)">', rous.text)[0]
            url = 'https://cdn.kuaidi100.com/js/share/count.js' + js_url
            rous = session.get(url)
            Hm_lvt = re.findall('https://hm.baidu.com/hm.js\?(.*)";', rous.text)[0]
            return [csrftoken, Hm_lvt]

        # 获取快递名
        def getname(self):
            rous = session.post(self.name_url, params=self.number_params)
            name = rous.json()['auto'][0]['comCode']
            return name

    # 运单号
    number = img1
    # 手机后四位
    phone = img2
    print("2222222")
    arr["最后物流信息"]=Kuaidi(number, phone).getdata()

    print(arr)
    #----------------3.数据写入json文件-------------------
    lilyfun.savearr2json(arr,"key")
#----------------4.出错处理-------------------
except:
    for k in keysarr:
        arr2save[k]=keysarr[k]
    lilyfun.savearr2json(arr2save,"all")
