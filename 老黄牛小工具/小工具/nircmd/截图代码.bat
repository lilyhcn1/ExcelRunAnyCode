
nircmd.exe cmdwait 2000 savescreenshot "temp.jpg"
nconvert.exe -crop 100 200 50 50  -out jpeg -overwrite -o  "temp.jpg"
pause