#Include <lilyfun>
sleep,1000
;��ͼ�����棬Ҫ��ʱ�ļ�
nowpath =%A_ScriptDir%
toolpath := "D:\�ϻ�ţС����\ExcelQuery\temp\"
tempjpg := toolpath "temp.jpg"
temptxt := toolpath "temp.txt"

#Include <Gdipѡ���ͼ>

ѡ�򲢽�ͼ(tempjpg)
writetextgbk(tempjpg, temptxt)

exitapp


