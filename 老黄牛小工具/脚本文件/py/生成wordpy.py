import lilyfun  #导入同路径下的函数
from goto import with_goto

 

arr={}
arr2save={}

try:
    #初始化读取数据
    listarr=lilyfun.readjson()
    #print(listarr)
    excelpath=lilyfun.readjson("excelpath")
    replace_dict = listarr


    import os
    from docx import Document

    def check_and_change(document, replace_dict):
        """
        遍历word中的所有 paragraphs，在每一段中发现含有key 的内容，就替换为 value 。
        （key 和 value 都是replace_dict中的键值对。）
        """
        for para in document.paragraphs:
            for i in range(len(para.runs)):
                for key, value in replace_dict.items():
                    if key in para.runs[i].text:
                        #print(key+"-->"+value)
                        para.runs[i].text = para.runs[i].text.replace(key, value)
        return document


    #print("222222222")
    # 放了一些docx 文件
    old_file = listarr["模板名"]
    #old_file=lilyfun.MBPATH+"\\"+listarr["模板名"]+".docx"
    #print("word111122222222")
    # 生成新文件后的存放地址,保证转成绝对路径
    new_file=lilyfun.getwholepath(listarr["生成名"],excelpath)

    lilyfun.mkdir(new_file)  #保证目录的存在
    print(old_file+"=>"+new_file)
    replace_dict = listarr



    document = Document(old_file)
    document = check_and_change(document, replace_dict)
    document.save(new_file)
    #print("^"*30)
    #input()

    #----------------3.数据写入json文件-------------------
    #print(arr2save)
    #lilyfun.savearr2json(arr2save,"key")




    #----------------4.出错处理-------------------
except:

    arr2save["模板名"]=r"D:\老黄牛小工具\word模板\校车信封.docx"
    arr2save["生成名"]="生成文件夹\老黄牛--校车信封.docx"
    arr2save["数据01"]="材料"
    arr2save["数据02"]="老黄牛"
    arr2save["数据03"]="椒江图书馆"
    arr2save["数据05"]="121344"
    arr2save["数据06"]="社科处"
    arr2save["数据10"]="小黄牛"
    arr2save["数据11"]="121222"

    lilyfun.savearr2json(arr2save,"all",1)
