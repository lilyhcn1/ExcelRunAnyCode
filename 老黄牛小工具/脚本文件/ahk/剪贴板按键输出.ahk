s=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
l := strlen(s)
i :=0
sleep 3000
while (i<l){
	i :=i+1
	tmp := substr(s, i, 1)
	send,%tmp%
	sleep 50
	
}