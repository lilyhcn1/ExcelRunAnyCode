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
#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="快递单号"
input2="手机后4位"
#输出区
output1="最后物流信息"
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
    if input2 in listarr.keys(): #对应第一个输入
        arr2save["执行结果"]="标题行不包括"+ input2+"."
        img2=listarr[input2]
    else:
        goto.error        

    
    #----------------2.数据提交并返回数组-------------------
    number=img1
    phone=img2
    str1=Kuaidi(number, phone).getdata()


    #----------------3.正确时的返回值-------------------
    arr2save[output1]= str1
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="9886903825406"
    arr2save[input2]="6700"
    arr2save[output1]="待返回"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
