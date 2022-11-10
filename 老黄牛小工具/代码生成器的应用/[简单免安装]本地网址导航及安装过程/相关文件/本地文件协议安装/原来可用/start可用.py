import urllib.parse
import sys,os


inputstr=sys.argv[1]
print(inputstr)
#a = input("input:")
input1=inputstr[7:-2]
input1=input1.replace("/","\\")

inputfile=urllib.parse.unquote(input1)
print(inputfile)

(filename, extension) = os.path.splitext(inputfile)
print(extension)
if len(extension) > 1:
   os.system("start /max " + inputfile)
else:
   os.system("explorer.exe %s" % inputfile )

#a = input("input:")

#os.system(inputfile)


#os.system('explorer.exe %s'+ data)
