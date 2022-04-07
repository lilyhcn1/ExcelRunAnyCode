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




#---------------r34.cc制作----------------------------------
import lilyfun  #导入同路径下的函数
import os
from goto import with_goto
prstr="true" #是否打印输出


#输入区
input1="金额"
#输出区
output1="大写金额"
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


    print(instr1)

    #outstr1=aoligeiganle(instr1) #大写转小写

    outstr1 = num2money_format(instr1) #小写转大写
    print(outstr1)
    #----------------3.正确时的返回值-------------------
    arr2save[output1]=outstr1
    arr2save[exeinfo]="√"
    lilyfun.savearr2json(arr2save,"key")
    
    lilyfun.pr("正确执行结束",prstr)
    goto.end
    label.error
    #----------------4. 出错时的返回值-------------------
    arr2save[input1]="987654321"
    arr2save[output1]="待返回值"
    s="执行:“"+os.path.basename(__file__)+"”出错。"

    
    arr2save=lilyfun.arrstr(arr2save,exeinfo,s)
    lilyfun.savearr2json(arr2save,"all")
    print(arr2save)
    lilyfun.pr("Warning,执行结束但有错误！~",prstr)
    label.end

    
        
main()
