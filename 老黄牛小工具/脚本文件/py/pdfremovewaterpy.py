﻿#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
import os
import shutil,time
def traverse_folder(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            file_name = os.path.basename(file_path)
            file_name_without_extension = os.path.splitext(file_name)[0]
            # 在这里对每个文件进行操作，例如打印文件路径
            print(file_name_without_extension)
            removepdfwater(file_path,int(file_name_without_extension))

def removepdfwater(path,n):
    dir ="D:\\老黄牛小工具\\小工具\\pdf\\"
    exestr =  dir + "cpdf.exe -draft -draft-remove-only  \"/Im"+str(n*2)+"\" " +path+" -o "+ path
    runexestr(exestr)
    exestr =  dir + "cpdf.exe -draft -draft-remove-only  \"/Im"+"2"+"\" " +path+" -o "+ path
    runexestr(exestr)
    exestr =  dir + "cpdf.exe -draft -draft-remove-only  \"/X"+"2"+"\" " +path+" -o "+ path
    runexestr(exestr)

def runexestr(exestr):
    exestr = "\"" + exestr + "\""
    # print(exestr)
    os.system(exestr)
def removemain(inpath,outpath):
    # 调用函数遍历文件夹
    dir ="D:\\老黄牛小工具\\小工具\\pdf\\"
    os.chdir(dir)
    folder_path = dir+"temp\\"  # 设置文件夹路径
    print("time.sleep")
    #time.sleep(2000)
    os.makedirs(folder_path, exist_ok=True)

    exestr =  dir + "cpdf.exe -split "+inpath+" -o "+dir+"\\temp\\%%%.pdf -chunk 1"
    runexestr(exestr)


    traverse_folder(folder_path)
    exestr =  dir + "cpdf.exe -merge -idir "+folder_path+" -o "+outpath
    runexestr(exestr)
    shutil.rmtree(folder_path)

#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = True  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["pdffile"]="D:\\老黄牛小工具\\word模板\\in.pdf"
inarr[""]=""
inarr[""]=""
inarr[""]=""
inarr["newpdffile"]="D:\\老黄牛小工具\\word模板\\in去水印.pdf"
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
outarr[""] = ""
#文件标志
fkeyold="pdffile"   #输入变量中，哪个是文件的标记。
fkeynew="newpdffile"   #输出变量中，哪个是文件的标记。
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
        errarr = lilyfun.printtraceback(errarr,"读取fd2错误，请检查！",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[1/4] fd2 传入成功！：","传入成功",prflag)

    # ----------------[2/4] 生成f64,json64解码为jsonarr -----------
    try: #1.2 json64解码为jsonarr
        jsonarr = lilyfun.json64tojsonarr(json64)
        jsoncontentarr =jsonarr["contents"]
        jsoncontentarr=lilyfun.updatearrfromini(jsoncontentarr,config)
        jsonarr["contents"]=jsoncontentarr
        f64=lilyfun.getfd2_f64(fd2,fkeyold,jsonarr)
    except Exception as e:# 保存函数出错后的执行结果
        errarr = lilyfun.printtraceback(errarr,"jsonarr解码错误，请检查！",e,prflag)
        #fd2:函数传过来的值，arr2ret:运行得到的数组，prflag：打印标记
        return lilyfun.mboutputarr(fd2,prflag,errarr)
    lilyfun.titlepr("[2/4] 解码成功 jsonarr：",jsonarr,prflag)

    # ----------------[3/4]按输入区读传过来的值并反馈到字典valarr ------
    try:
        valarr=lilyfun.getvalarr(jsonarr,inarr,outarr,prflag,fkeyold,fkeynew)
    except Exception as e:
        errarr = lilyfun.printtraceback(errarr,"标题行没有需要的值，请确保标题行存在！",e,prflag)
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
        valarr = lilyfun.printtraceback(valarr,"读写文件错误，请检查！",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)


    #3333333333333333333333333333333333333333333333333333
    #txt=mainrun(valarr,old_filepath,new_filepath)
    #inarr pdffile    newpdffile
    #inarr     
    #fkeyold pdffile fkeynew newpdffile 
    try:  # 运行函数,最后要生成arr2ret及f64

        removemain(old_filepath,new_filepath)

    #3333333333333333333333333333333333333333333333333333
    except Exception as e:# 保存函数出错后的执行结果
        valarr = lilyfun.printtraceback(valarr,"[运行]调用函数出错，请检查值是否正确。",e,prflag)
        return lilyfun.mboutputarr(fd2,prflag,valarr)

    try:  # 运行函数,最后要生成arr2ret及f64
        f64=lilyfun.readfile2f64(new_filepath)#有新文件就读取
        # newpath = valarr[fkeynew]
        # if f64!="" and fkeynew!="" and fd2=={}:
        #     lilyfun.writefile64(f64,newpath)
        lilyfun.safedel(old_filepath)
        lilyfun.safedel(new_filepath)
        arr2ret["execstat"]="√"
    except Exception as e:
        valarr = lilyfun.printtraceback(valarr,"读写、删除文件错误。！",e,prflag)
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
        valarr = lilyfun.printtraceback(valarr,"写入文件出错，请检查值是否正确！",e,prflag)
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

