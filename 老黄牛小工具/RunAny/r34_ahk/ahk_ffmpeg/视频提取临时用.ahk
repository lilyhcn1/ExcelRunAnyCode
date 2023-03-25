ffmpeg := checkandgetpath("ffmpeg")
st := 0:00:00
lt := 58
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\牧童结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:00:58
lt := 38
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\拔绳结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:01:36
lt := 27
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\抬杆结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:02:03
lt := 64
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\接绳结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:03:07
lt := 80
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\套圈绳结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:04:27
lt := 47
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\打死结接绳.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:05:14
lt := 62
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\拖车结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:06:16
lt := 50
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\称人结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:07:06
lt := 69
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\拉绳结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:08:15
lt := 76
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\吊物结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

ffmpeg := checkandgetpath("ffmpeg")
st := 0:09:31
lt := 59
inputpath = "C:\Users\lilyhcn\Desktop\绳结.mp4"
outputpath = "C:\Users\lilyhcn\Desktop\下降结.mp4"
tempexe = %ffmpeg%  -ss %st% -i %inputpath% -t %lt% -c:v copy -c:a -y copy %outputpath%
runwait,%tempexe%, , Min

