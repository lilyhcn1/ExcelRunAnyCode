﻿#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
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

#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = "true"  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["快递单号"]="JT5171327460531"
inarr["手机号后4位"]="1808"
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr["物流信息"] = "待返回"
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
#文件标志
fkeyold=""   #输入变量中，哪个是文件的标记。
fkeynew=""   #输出变量中，哪个是文件的标记。
#2222222222222222222222222222222222222222222222222222222222222
config=lilyfun.readiniconfig()
inarr=lilyfun.updatearrfromini(inarr,config)




def main(fd2={}):
    global inarr,outarr,prflag,fkeyold,fkeynew,mlkey,config
    arr2ret,valarr,errarr = {},{},{}
    wholepath,f64="",""
    errarr=lilyfun.merge(inarr,outarr)  #合并字典
    # ----------------三、初始化读取数据：----------------------
    #读valarr,即读标题及标题对应的值
    # ----------------[1/4]读取fd2，生成base64字符串 json64 -----
    try: #1.1读取fd2，即传入字典
        json64=lilyfun.getfd2(fd2,"json64")
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"读取fd2错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[1/4] fd2 传入成功！：","传入成功",prflag)

    # ----------------[2/4] 生成f64,json64解码为jsonarr -----------
    try: #1.2 json64解码为jsonarr
        jsonarr = lilyfun.json64tojsonarr(json64)
        jsoncontentarr =jsonarr["contents"]
        jsoncontentarr=lilyfun.updatearrfromini(jsoncontentarr,config)
        jsonarr["contents"]=jsoncontentarr
        f64=lilyfun.getfd2_f64(fd2,fkeyold,jsonarr)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"jsonarr解码错误，请检查！",prflag)
        #fd2:函数传过来的值，arr2ret:运行得到的数组，prflag：打印标记
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[2/4] 解码成功 jsonarr：",jsonarr,prflag)

    # ----------------[3/4]按输入区读传过来的值并反馈到字典valarr ------
    try:
        valarr=lilyfun.getvalarr(jsonarr,inarr,outarr,prflag)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"标题行没有需要的值，请确保标题行存在！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("","获取到的f64的长度为: " + str(len(f64)),prflag)
    lilyfun.titlepr("[3/4] 检查输入值成功 valarr：",valarr,prflag)
    #这里可能还要再写读文件的
    
    # ----------------[4/4]调用函数并生成arr2ret及f64 -------------------
    try:  # 运行函数,最后要生成arr2ret及f64
        old_filepath=lilyfun.randfile(errarr,fkeyold,"old")
        new_filepath=lilyfun.randfile(errarr,fkeynew,"new")
        old_filepath=lilyfun.writefile64(f64,old_filepath)
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写文件错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr 快递单号 手机号后4位   
    #inarr 物流信息    
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        number=valarr["快递单号"]
        phone=valarr["手机号后4位"]
        str1=Kuaidi(number, phone).getdata()
        arr2ret["物流信息"]=str1

    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[运行]调用函数出错，请检查值是否正确。" +"\n"+'错误类型：'+ e.__class__.__name__+"\n"+ '错误明细：'+str(e))
        return lilyfun.mboutputarr(fd2,prflag,valarr)
    #3333333333333333333333333333333333333333333333333333
    
    try:  # 运行函数,最后要生成arr2ret及f64
        f64=lilyfun.readfile2f64(new_filepath)#有新文件就读取
        # newpath = valarr[fkeynew]
        # if f64!="" and fkeynew!="" and fd2=={}:
        #     lilyfun.writefile64(f64,newpath)
        lilyfun.safedel(old_filepath)
        lilyfun.safedel(new_filepath)
        arr2ret["execstat"]="√"
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写、删除文件错误。！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)
    lilyfun.titlepr("[4/4] 函数执行成功 arr2ret：",arr2ret,prflag)
    

    # ----------------五、写入文件，并返回字典 -------------------
    try:  # 写入文件
        if fd2=={} and fkeynew !="":
            excelfolder=lilyfun.safegetkey(jsonarr,"excelpath")
            raltiveapth=jsonarr["contents"][fkeynew]
            wholepath=lilyfun.getwholepath(raltiveapth,excelfolder)
        lilyfun.titlepr("执行、输出成功。","",prflag)
        #这是最关键的返回函数，并写入文件
        #print(wholepath)
        return lilyfun.mboutputarr(fd2,prflag,arr2ret,f64,wholepath,"key")
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"写入文件出错，请检查值是否正确！",prflag)
        lilyfun.titlepr("最后写入文件出错，请检查值是否正确。","",prflag)       
        return lilyfun.mboutputarr(fd2,prflag,valarr)



if __name__ == '__main__':
    main()

    #fd2的内容
    # "json64": json文件  上传过来的json
    # "f64": f64   上传的文件的base64（只能一个文件）
    # "fkeyold": fkeyold  上传时的标题行（只能一个文件）
    # "fkeynew": fkeynew  返回时的标题行（只能一个文件）
        #fd2,prflag="true",arr2ret,f64="",fkeynew="",keyflag="all"
        #fd2:传过来的值，prflag：打印标记,keyflag:excel中的是否全部输出
        #arr2ret:运行得到的字典，f64:反馈文件的base64,fkeynew：输出值
        #return lilyfun.mboutputarr(fd2,prflag,errarr)
