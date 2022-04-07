
#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="url"
#输出区
output1="网页标题"
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



    #----------------2.数据提交并返回数组-------------------
    #urllib2是python自带的模块，在python3.x中被改为urllib.request
    import urllib.request
    import ssl,re
    ssl._create_default_https_context = ssl._create_unverified_context


    page = urllib.request.urlopen(img1)
    html = page.read().decode('utf-8')
    # Python3 findall数据类型用bytes类型
    # or html=urllib.urlopen(url).read()

    title=re.findall('<title>(.+)</title>',html)
    txt=title
    print(txt)






    #----------------3.正确时的返回值-------------------
    arr2save[output1]=txt
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="http://r34.cc"
    arr2save[output1]="待返回值"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()




