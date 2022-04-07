import lilyfun  #导入同路径下的函数
#----------------0.出错时的返回值----------------------
arr={}
arr2save={}
keysarr={}

from PyPDF2 import PdfFileMerger

pdfs = ['file1.pdf', 'file2.pdf', 'file3.pdf', 'file4.pdf']

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(open(pdf, 'rb'))

with open('result.pdf', 'wb') as fout:
    merger.write(fout)


    
