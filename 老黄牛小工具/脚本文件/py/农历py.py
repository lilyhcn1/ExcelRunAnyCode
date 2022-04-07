

import  sxtwl
import sxtwl
from datetime import datetime


#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="日期"
#输出区
output1="农历"
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
        instr1=listarr[input1]
    else:
        goto.error



    #----------------2.数据提交并返回数组-------------------

    t=datetime.strptime(instr1,'%Y/%m/%d')
    y=int(t.strftime('%Y'))
    m=int(t.strftime('%m'))
    d=int(t.strftime('%d'))


    day = sxtwl.fromSolar(y, m, d)

    # 以春节为界的农历(注getLunarYear如果没有传参，或者传true，是以春节为界的)
    s = "%d/%s%d/%d" % (day.getLunarYear(), '闰' if day.isLunarLeap() else '', day.getLunarMonth(), day.getLunarDay())
    # 以立春为界的农历
    #s = "农历:%d年%s%d月%d日" % (day.getLunarYear(False), '闰' if day.isLunarLeap() else '', day.getLunarMonth(), day.getLunarDay())

    # 如果查的是闰月，只要在第四个参数加一个true 如sxtwl.fromLunar(2020, 4, 1, true)
    #day = sxtwl.fromLunar(2022, 3, 1)
    # 公历的年月日
    #s = "公历:%d年%d月%d日" % (day.getSolarYear(), day.getSolarMonth(), day.getSolarDay())



    outstr1=s

    print(outstr1)
    #----------------3.正确时的返回值-------------------
    arr2save[output1]=outstr1
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="2022/4/1"
    arr2save[output1]="待返回值"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
