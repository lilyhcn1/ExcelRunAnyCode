s=%clipboard% ;windows ���Ƶ�ʱ�򣬼����屣����ǡ�·������ֻ��·�������ַ�����ֻҪת�����ַ����Ϳ���ճ��������
l := strlen(s)
i :=0
sleep 3000
while (i<l){
	i :=i+1
	tmp := substr(s, i, 1)
	send,%tmp%
	sleep 50
	
}