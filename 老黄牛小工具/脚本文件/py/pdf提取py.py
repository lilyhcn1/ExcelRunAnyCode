import lilyfun  #导入同路径下的函数
#----------------0.出错时的返回值----------------------
arr={}
arr2save={}
keysarr={}


try:
    #----------------1.初始化读取数据----------------------

    #初始化读取数据
    listarr=lilyfun.readjson()
    f=listarr["pdf地址"]
    fnew=listarr["pdf提取到"]
    pstart=listarr["开始页数"]
    pend=listarr["结束页数"]
    #----------------1.正式操作函数 ----------------------
    from PyPDF2 import  PdfFileReader, PdfFileWriter
    import os

    # 将目标PDF文件的start至end页分割保存至指定文件夹，start从1开始计数
    def pdf_split_2(pdf_input, path_output, start, end):
        pdf = PdfFileReader(pdf_input)
        pdf_writer = PdfFileWriter()
        print(pdf.getNumPages())
        output_filename = newfilename.format(pdf_input,start,end)

        for page in range(start-1, end):
            pdf_writer.addPage(pdf.getPage(page))

        with open(output_filename, 'wb') as out:
            pdf_writer.write(out)


    file_name=f
    newfilename=fnew
    pdf_split_2(file_name,newfilename, int(pstart), int(pend))

    #----------------3.数据写入json文件-------------------
    #print(arr2save)
    #lilyfun.savearr2json(arr2save,"key")
except:
    arr2save["pdf地址"]=r"D:\ocr\dddddddddd.pdf"
    arr2save["pdf提取到"]=r"D:\ocr\aaa.pdf"
    arr2save["开始页数"]="1"
    arr2save["结束页数"]="3"
    lilyfun.savearr2json(arr2save,"key")




    
