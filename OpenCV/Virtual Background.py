import matplotlib.pyplot as plt
import cv2
import time
from utils import segment
from torchvision import models
# creating the videocapture object
# and reading from the input file
# Change it to 0 if reading from webcam
cap = cv2.VideoCapture(0)
cv2.waitKey(1)
fcn50 = models.segmentation.fcn_resnet50(pretrained=True).eval() # 2-3 sec
dlab = models.segmentation.deeplabv3_resnet101(pretrained=1).eval() # 8 sec
fcn = models.segmentation.fcn_resnet101(pretrained=True).eval() # 8 sec
dlab50 = models.segmentation.deeplabv3_resnet50(pretrained=True).eval() # 2-3 sec
LargeDlab = models.segmentation.deeplabv3_mobilenet_v3_large(pretrained=True).eval() # <1sec
LargeLra = models.segmentation.lraspp_mobilenet_v3_large(pretrained=True).eval() # <1sec (fastest)
# used to record the time when we processed last frame
prev_frame_time = 0

# used to record the time at which we processed current frame
new_frame_time = 0
# FPS=cap.get(cv2.CAP_PROP_FPS)
# fourcc = cv2.VideoWriter_fourcc(*"mp4v")
# out = cv2.VideoWriter('virtureBackground.mp4', fourcc,20.0,(500,300))
# numFramesRemaining=10*FPS
# Reading the video file until finished
while(cap.isOpened()): # and numFramesRemaining:

	# Capture frame-by-frame

	ret, frame = cap.read()

	# if video finished or no Video Input
	if not ret:
		break

	# Our operations on the frame come here
	# gray = frame#cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

	# resizing the frame size according to our need
	gray1 = cv2.resize(frame, (500, 300))
	gray = segment(LargeLra, gray1, 'backGround.jpeg')

	# font which we will be using to display FPS
	font = cv2.FONT_HERSHEY_SIMPLEX
	# time when we finish processing for this frame
	new_frame_time = time.time()

	# Calculating the fps

	# fps will be number of frame processed in given time frame
	# since their will be most of time error of 0.001 second
	# we will be subtracting it to get more accurate result
	fps = 1/(new_frame_time-prev_frame_time)
	prev_frame_time = new_frame_time

	# converting the fps into integer
	fps = int(fps)

	# converting the fps to string so that we can display it on frame
	# by using putText function
	fps = str(fps)

	# putting the FPS count on the frame
	cv2.putText(gray, fps, (7, 70), font, 3, (100, 255, 0), 3, cv2.LINE_AA)

	gray2 = gray
	cv2.imshow('frame', gray)
	# if numFramesRemaining>0:
	# 	out.write(gray2)
	# 	numFramesRemaining -= 1
	# 	print(numFramesRemaining)
	# 	if numFramesRemaining == 0:
	# 		out.release()
	# 		break
	# out.write(gray2)
	# numFramesRemaining -= 1


	# # press 'Q' if you want to exit
	if cv2.waitKey(1) & 0xFF == ord('q'):
		break


# When everything done, release the capture
cap.release()
# out.release()
# Destroy the all windows now
cv2.destroyAllWindows()