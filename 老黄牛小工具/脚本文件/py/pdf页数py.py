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

    #----------------1.正式操作函数 ----------------------
    from PyPDF2 import  PdfFileReader, PdfFileWriter
    import os


    #----------------3.数据写入json文件-------------------
    pdf = PdfFileReader(f)
    pdf_writer = PdfFileWriter()

    arr2save["页数"]=pdf.getNumPages()
    lilyfun.savearr2json(arr2save,"key")
except:
    arr2save["pdf地址"]=r"D:\ocr\dddddddddd.pdf"
    arr2save["页数"]="待返.."
    lilyfun.savearr2json(arr2save,"key")




    
