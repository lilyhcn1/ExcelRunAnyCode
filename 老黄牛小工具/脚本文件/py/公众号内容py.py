#driver_path = r'D:\桌面文件\11\Chrome\chromedriver.exe'
from selenium import webdriver
import time

from selenium.webdriver.chrome.options import Options
#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="链接url"
#输出区
output1="公众号内容"
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
    #chrome选项
    #options = webdriver.ChromeOptions()
    #chrome_options = Options()
    #chrome_options.add_argument('--headless')
    #wd = webdriver.Chrome('D:\\老黄牛小工具\\小工具\\爬虫\\Chrome\\chromedriver.exe',options=chrome_options)

    wd = webdriver.Chrome('D:\\老黄牛小工具\\小工具\\爬虫\\Chrome\\chromedriver.exe')
    #发起get请求


    url = img1
    wd.get(url)
    text = wd.find_element_by_xpath("//*[@id=\"js_content\"]").text
    wd.quit()

    #----------------3.正确时的返回值-------------------
    arr2save[output1]= text
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="https://mp.weixin.qq.com/s?__biz=MzIyODIwMzE2Nw==&mid=2650302896&idx=1&sn=28b77a3c6c79c5a532698450472edd8c&chksm=f0594640c72ecf56ef7a1bd32d9f86e1a82b660f2b235d3b13f64f4e2c9b3675d7f540611fd0#rd"
    arr2save[output1]="待返回"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    #print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()


