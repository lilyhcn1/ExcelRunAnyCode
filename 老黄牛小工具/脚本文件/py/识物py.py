import lilyfun, os  # 导入同路径下的函数
from aip import AipImageClassify
class AI_image_classify(object):

    API_Key=lilyfun.readini("ApiKeys","BaiduAPIKey2")
    Secret_Key=lilyfun.readini("ApiKeys","BaiduSecretKey2")
    AppID = '16612216'
    #API_Key = '7SUIDjrUt01HcUXD9kbBvLan'
    #Secret_Key = 'OKHysIXt3nGNjTiPfjSiyBjntGq8XRlY'
    client = AipImageClassify(AppID, API_Key, Secret_Key)

    def get_file_content(self, filePath):
        '''
        读取图片
        :param filePath: 图片路径
        :return:
        '''
        with open(filePath, 'rb') as fp:
            return fp.read()


    def get_general(self, filePath):
        '''
        通用物体识别
        :param filePath: 读取的图片的路径
        :return: AI识别的结果
        '''
        image = self.get_file_content(filePath)
        x=self.client.advancedGeneral(image)['result']
        # print(x)
        #print(x[0]['keyword'])
        return x[0]['keyword']

#aa=AI_image_classify().get_general('2222.png')

# ---------------r34.cc制作 excel 的输入输出----------------------------------
import lilyfun, os  # 导入同路径下的函数

prstr = "true"  # 是否打印输出

# 输入、输出的的标题行
input1 = "图片路径"
output1 = "物体名字"

##如果出错的话，返回的值
err2arr = {}
err2arr[input1] = "D:\老黄牛小工具\word模板\笑脸.jpg"
err2arr[output1] = "待返回值"

def main():
    global err2arr, s, input1, input2, input3, output1, output2, output3
    arr2save = {}
    # ----------------1.初始化读取数据----------------------
    lilyfun.pr(input1 + "------" + output1, prstr)

    try:  # 读取json中内容

        val1 = lilyfun.readjsonarr("contents", input1)
    except:  # 保存出错后的默认信息err2arr及原因
        arr2save = lilyfun.saveerr2json(err2arr, "标题行不包括" + input1 + ".")
        return arr2save

    lilyfun.pr("[" + input1 + "]: " + val1, prstr)
    # ----------------2.调用函数并返回-------------------
    str = val1

    try:  # 运行函数
        name = AI_image_classify().get_general(str)
        print(name)
    except:  # 保存函数出错后的执行结果
        arr2save = lilyfun.saveerr2json(arr2save, "调用函数出错，请检查输入。")
        return arr2save

    # ----------------3.正确时的返回值-------------------
    arr2save[output1] = name
    arr2save["执行结果"] = "√"
    lilyfun.savearr2json(arr2save, "key")  # 数据写入json.参数key代表有标题才写入

    lilyfun.pr("正确执行结束", prstr)

main()
