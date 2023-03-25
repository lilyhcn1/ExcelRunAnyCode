#SingleInstance, Force
#Include ..\Lib\lilyfun.ahk
SetWorkingDir %A_ScriptDir%

configpath = D:\老黄牛小工具\配置文件\myconf.ini

try{
   lama_cleaner := readini("ServerList","lama_cleaner", configpath) 
}catch{
    msgbox, "请保证config中【ServerList】【lama_cleaner】的存在！~"
    exitapp
}

url := lama_cleaner

if(checkurl(url)){
	run, %url%
}else{
    msgbox,"%url% 站点故障，请检查服务器！点击确认后跳转服务站点。"
    run, %url%
}

