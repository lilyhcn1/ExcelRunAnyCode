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
