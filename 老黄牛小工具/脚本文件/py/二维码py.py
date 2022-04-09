import qrcode
import os
#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="文字"
#输出区
output1="文件名"
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
        
    #读取输入路径，处理异常 
    excelpath=lilyfun.readjson("excelpath")
    #old_file=lilyfun.getwholepath(listarr[input1],excelpath) #相对路径
    if output1 in listarr.keys() : #对应第一个输入
        if not listarr[output1] =="":
            new_file=lilyfun.getwholepath(listarr[output1],excelpath) #相对路径
            if(os.path.isfile(new_file)):     
                os.remove(new_file)
            lilyfun.mkdir(new_file)  #保证目录的存在
    #print(old_file+"=>"+new_file)
    
    #----------------2.数据提交并返回数组-------------------


    png = qrcode.make(img1)
    #print("new_file: "+new_file)
    png.save(new_file)

    #----------------3.正确时的返回值-------------------

    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="老黄牛小工具"
    arr2save[output1]="生成文件夹\老黄牛小工具.png"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    #print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
