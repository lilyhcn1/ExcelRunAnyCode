from pypinyin import pinyin, lazy_pinyin, Style
#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="文字"
#输出区
output1="拼音"
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

    #https://github.com/mozillazg/python-pinyin#id3
    #有很多种格式
    #list1 = lazy_pinyin(img1)
    list1 = pinyin(img1)
    str1 = ' '.join(str(e) for e in list1)
    str1=str1.replace("['","")
    str1=str1.replace("']","")



    #----------------3.正确时的返回值-------------------
    arr2save[output1]= str1
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="老黄牛小工具"
    arr2save[output1]="待返回"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    #print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
