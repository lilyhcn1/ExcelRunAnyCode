#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
import os
import shutil
import urllib.request
import zipfile,subprocess,json,base64

# 检测软件是否存在的函数
def check_software_exists(url):
    try:
        response = urllib.request.urlopen(url)
        return True
    except urllib.error.HTTPError as e:
        return False

# 下载并解压软件的函数
def download_and_extract_software(url, download_path, extract_path):
    # 下载软件zip文件
    urllib.request.urlretrieve(url, download_path)

    # 解压zip文件
    with zipfile.ZipFile(download_path, "r") as zip_ref:
        zip_ref.extractall(extract_path)
    # 解压zip文件
        
    # 返回解压后的软件目录路径
    return extract_path
def start(url):
#    os.startfile(url)
    # os.system(f"start {url}")
    subprocess.call(["start", url], shell=True)

def runconjb(content="",ex="bat"):
    bat_file = os.environ ['TEMP'] + "\\temp."+ex
    if content=="":
        print("未接到参数。")
    else:
        # 将批处理程序内容写入文件
        with open(bat_file, 'wb') as f:
            f.write(content)
        # 运行批处理程序
        start(bat_file)  

def getcodeandrun(argument,dataurl="http://r34.cc/index.php/Qwadmin/Rwxy/echojson/type/json/conall/%3B%E6%95%B0%E6%8D%AE%E8%A1%A8%E5%90%8D%E7%AD%89%E4%BA%8Ebat_r34_cc%3B%E6%9F%A5%E7%9C%8B%E5%AF%86%E7%A0%81%E7%AD%89%E4%BA%8E8K3130517E"):
   flag=False
   # 发送HTTP请求并获取响应
   response = urllib.request.urlopen(dataurl)
   data = response.read().decode('utf-8')
   json_data = json.loads(data)
# 提取"arr"键值
   arr_data = json_data['arr']
   for item in arr_data:
      if item["功能名"]==argument:
         #print(item["codebs64"])
         if item["codebs64"]!=None:
            content = base64.b64decode(item["codebs64"])
         elif item["code"]!=None:
            content=item["code"]
            content=content.encode('utf-8')
         else:
             return False
         ex = "bat" if item["ex"]==None else item["ex"]
         flag=True
         break    #跳出for
   if flag==True:
      runconjb(content,ex)
      return True
      print("正确运行脚本！")
   else:
      print("warning!数据库中找不到相应的代码！")
      return False

   
 

def downsoftandrun(inputstr,softwaresite= "http://pub.r34.cc/toolsoft/",softwarepath="d:/r34tool/tools/"):
    softurl=softwaresite +urllib.parse.quote(inputstr) +".zip"
    software_download_path=softwarepath+"temp.zip"
    software_extract_path=softwarepath+inputstr+"/"
    software_executable=software_extract_path+inputstr+".exe"

    #文件是否存在，并保存temp.zip删除
    if os.path.exists(software_executable):
        start(software_executable)
        return True
    elif check_software_exists(softurl):
        software_path = download_and_extract_software(softurl, software_download_path, software_extract_path)
        start(software_executable)
        return True
    else:
        print("网上找不到exe的url")
        return False


#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = "true"  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["程序名"]="ipconfig"
inarr[""]=""
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr[""] = ""
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
        old_filepath=lilyfun.randfile(inarr,fkeyold,"old")
        new_filepath=lilyfun.randfile(outarr,fkeynew,"new")
        old_filepath=lilyfun.writefile64(f64,old_filepath)
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写文件错误，请检查！",prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr 程序名    
    #inarr     
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        jb=valarr["程序名"]

        if getcodeandrun(jb)==True:
            print("成功运行脚本")
        elif downsoftandrun(jb)==True:
            print("成功下载并打开exe")    
        else:
            print("即没有运行脚本，也没有下载文件")

    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printvalarr(valarr,"[运行]调用函数出错，请检查值是否正确。" +"\n"+'错误类型：'+ e.__class__.__name__+"\n"+ '错误明细：'+str(e))
        return lilyfun.mboutputarr(fd2,prflag,valarr)





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
        arr2ret["执行结果"]="√"
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
