import cv2,os
cap = cv2.VideoCapture(0, cv2.CAP_DSHOW) # 打开摄像头
from shutil import copyfile
from sys import exit
import time


tmpjpg = "D:\\老黄牛小工具\\ExcelQuery\\temp\\temp.jpg"
sjpg ="temp.jpg"

while (1):
  
  # get a frame
  
  ret, frame = cap.read()
  frame = cv2.flip(frame, 1) # 摄像头是和人对立的，将图像左右调换回来正常显示
  # show a frame
  time.sleep(1)
  cv2.imshow("capture", frame) # 生成摄像头窗口
  
  if cv2.waitKey(1) & 0xFF == ord(' '): # 如果按下q 就截图保存并退出
    cv2.imwrite("temp.jpg", frame) # 保存路径
    break

cap.release()

cv2.destroyAllWindows()
copyfile(sjpg, tmpjpg)
