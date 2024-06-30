#一、 引用函数、库等写在最上方
#11111111111111111111111111111111111111111111111111111111111111
import re
from decimal import Decimal

def aoligeiganle(amount):
    chinese_num = {'零': 0, '壹': 1, '贰': 2, '叁': 3, '肆': 4, '伍': 5, '陆': 6, '柒': 7, '捌': 8, '玖': 9}
    chinese_amount = {'分': 0.01, '角': 0.1, '元': 1, '拾': 10, '佰': 100, '仟': 1000, '圆': 1}
    amount_float = 0
    if '亿' in amount:
        yi = re.match(r'(.+)亿.*', amount).group(1)
        amount_yi = 0
        for i in chinese_amount:
            if i in yi:
                amount_yi += chinese_num[yi[yi.index(i) - 1]] * chinese_amount[i]
        if yi[-1] in chinese_num.keys():
            amount_yi += chinese_num[yi[-1]]
        amount_float += amount_yi * 100000000
        amount = re.sub(r'.+亿', '', amount, count=1)
    if '万' in amount:
        wan = re.match(r'(.+)万.*', amount).group(1)
        amount_wan = 0
        for i in chinese_amount:
            if i in wan:
                amount_wan += chinese_num[wan[wan.index(i) - 1]] * chinese_amount[i]
        if wan[-1] in chinese_num.keys():
            amount_wan += chinese_num[wan[-1]]
        amount_float += amount_wan * 10000
        amount = re.sub(r'.+万', '', amount, count=1)

    amount_yuan = 0
    for i in chinese_amount:
        if i in amount:
            if amount[amount.index(i) - 1] in chinese_num.keys():
                amount_yuan += chinese_num[amount[amount.index(i) - 1]] * chinese_amount[i]
    amount_float += amount_yuan

    return amount_float

def num2money_format(change_number):
    """
    .转换数字为大写货币格式( format_word.__len__() - 3 + 2位小数 )
    change_number 支持 float, int, long, string
    """
    format_word = ["元",
                   "拾", "佰", "仟", "万",
                   "拾", "佰", "仟", "亿",
                   "拾", "佰", "仟", "万",
                   "拾", "佰", "仟"]

    format_word_decimal = ['分', '角']

    format_num = {'0': "零", '1': "壹", '2': "贰", '3': "叁", '4': "肆", '5': "伍", '6': "陆", '7': "柒", '8': "捌", '9': "玖"}

    res = []  # 存放转换结果

    if '.' not in change_number:
        # 输入的数字没有'.'，为整元，没有角和分
        k = len(change_number) - 1
        for i in change_number:
            res.append(format_num[i])
            res.append(format_word[k])
            k = k - 1

    elif '.' in change_number:
        float_2_change_num = Decimal(float(change_number)).quantize(Decimal("0.00"))
        # 如果输入的字符串有“.”，则将其转换为浮点数后，四舍五入取两位小数
        # print(float_2_change_num)
        # print(type(float_2_change_num))

        depart = str(float_2_change_num).split('.')
        # 将四舍五入得到的浮点数整数部分和小数部分拆开，实现操作为：先将浮点数转为字符串类型，再以“.”为分隔符分开
        # print(depart)

        int_part = depart[0]  # 整数部分
        # print(int_part)

        decimal_part = depart[1]  # 小数部分
        # print(decimal_part)

        k = len(int_part) - 1
        for i in int_part:  # 整数部分转换
            res.append(format_num[i])
            res.append(format_word[k])
            k = k - 1

        m = len(decimal_part) - 1
        for i in decimal_part:  # 小数部分转换
            res.append(format_num[i])
            res.append(format_word_decimal[m])
            m = m - 1

    return ''.join(res)  # 返回结果




#11111111111111111111111111111111111111111111111111111111111111
# ---------------r34.cc制作 excel 的输入输出---------------
import os,base64,time,sys,json,traceback,lilyfun # 导入同路径下的函数
prflag = True  # 是否打印输出，true输出
inarr,outarr={},{}
lilyfun.tj()

# 二、运行出错时，默认的输入、输出的默认标题行
#2222222222222222222222222222222222222222222222222222222222222
#输入文本
inarr["大写金额"]="壹拾贰亿叁仟肆佰伍拾陆万柒仟捌佰玖拾零元"
inarr[""]=""
inarr[""]=""
inarr[""]=""
inarr[""]=""
outarr["小写金额"] = "待返回"
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
    #inarr 大写金额    
    #inarr 小写金额    
    #fkeyold  fkeynew  
    try:  # 运行函数,最后要生成arr2ret及f64

        outstr1=aoligeiganle(valarr["大写金额"]) #大写转小写

        #outstr1 = num2money_format(valarr["金额"]) #小写转大写
        arr2ret["小写金额"] = outstr1


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

