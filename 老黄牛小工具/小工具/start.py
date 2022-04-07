import urllib.parse
import sys,os
import time

#自定义打开协议
ptl="li://"  #文件夹打开协议
indexname="index.html"  #网页文件首页
exitflag=""
time.sleep(11)
def runfolder(filefolder):
   dirpath=filefolder
   newindex=filefolder+"\\" +indexname
   #print(filefolder)
   #print(newindex)
   f="<html><head>  <title>打开文件夹</title>  <meta charset='utf-8'> <meta name='viewport' content='width=device-width, initial-scale=1'><link rel='stylesheet' href='http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css'>  <script src='http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js'></script><script src='http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js'></script></head><body><div class='container-fluid'><div class='row-fluid'><div class='span12'><p class='text-warning'>"
   e="			</p>		</div>	</div></div></body></html>"
   urls=""
   #urls=urls+"<h3><a href='#' onClick=\"javascript:history.back(-1);\">返回上一页</a></h3>"
   urls=urls+"<h3><a href='cmd://"    + dirpath + "\"'>"  +"打开文件夹 "+  dirpath.split("\\")[-1] +"</a></h3>"
   # 获取文件名
   for file in os.listdir(dirpath):
       allpath = dirpath + "\\" +file
       (filename, extension) = os.path.splitext(file)
       urls=urls+"<h3><a href='cmd://" + allpath + "'>" + filename +"</a></h3>"
       #print("<h3><a href='cmd://" + allpath + "'>" + filename +"</a></h3>")
   contents=f+ urls +e
   #time.sleep(1)
   fh = open(newindex, 'w', encoding='utf-8')
   fh.write(contents)
   fh.close()
   os.system("start " + newindex)


inputstr=sys.argv[1]
#inputstr=r"cmd://li://%lilyfolder%\%E5%88%86%E7%B1%BB%E5%B7%A5%E4%BD%9C\%E7%A7%91%E7%A0%94_%E5%AD%A6%E6%9C%AF%E8%AE%B2%E5%BA%A7\%E4%BA%BA%E6%96%87%E5%AD%A6%E6%9C%AF%E8%AE%B2%E5%BA%A7.xlsm"
#inputstr=r"cmd://li://%lilyfolder%\%E5%88%86%E7%B1%BB%E5%B7%A5%E4%BD%9C\%E7%A7%91%E7%A0%94_%E5%AD%A6%E6%9C%AF%E8%AE%B2%E5%BA%A7\\"
#inputstr=r"cmd://2021%E5%B9%B4%E5%BA%A6%E4%BB%AA%E5%99%A8%E8%AE%BE%E5%A4%87%E9%9B%86%E4%B8%AD%E6%8A%A5%E5%BA%9F%E7%94%B3%E6%8A%A5%E5%B7%A5%E4%BD%9C"
print(inputstr)

#去除cmd://这几个字
input1=inputstr[6:]
extstr=inputstr[1:3]

input1=input1.replace("/","\\")
inputfile=urllib.parse.unquote(input1)

#print(inputfile)
#time.sleep(1)

#环境变量及\\变量的处理
realfolderpath = os.environ.get('LILYFOLDER')
inputfile=inputfile.replace("%lilyfolder%",realfolderpath)
(filename, extension) = os.path.splitext(inputfile)
#print(inputfile)
#time.sleep(1)
if len(extension) < 1:

   if inputfile[-1:] =="\\":
      inputfile=inputfile[:-1]
   #print("inputfile1:"+ inputfile)
   #time.sleep(3)
   #这里处理文件夹   
   if inputfile.find("\\") < 0:
         path = os.environ.get('LILYFOLDER')
         path=path + "\\分类工作"
         #print("inputfile1: "+ inputfile)
         #print("path:"+ path)
         #time.sleep(7)
         try:
             for root, dirs, _ in os.walk(path):
                 for d in dirs:
                    #print(d)
                    if d.find(inputfile) >= 0:
                        fo=root + "\\" + d +"\\"
                        print("inputfile2: "+ inputfile)
                        print("path:"+ path)
                        print("fo:"+ fo)
                        #time.sleep(7)
                        exitflag="true"
                        os.system("explorer.exe %s" % fo )
                        sys.exit()
         except:
             pass

print("执行下半部分")
if exitflag == "true":
   print("不执行")
   #time.sleep(5)
else:
   #time.sleep(5)
   (filename, extension) = os.path.splitext(inputfile)

   if len(extension) > 1:
      os.system("start /max " + inputfile)
   else:
      keyword=inputfile[0:2]
      pathvalue=inputfile[5:]
      if keyword == "li":
         print(pathvalue)
         #input(inputfile)
         runfolder(pathvalue)
         #os.startfile(pathvalue)
      else:
         print(inputfile)
         os.system("explorer.exe %s" % inputfile )

print("结束了等待几秒。")
time.sleep(5)


