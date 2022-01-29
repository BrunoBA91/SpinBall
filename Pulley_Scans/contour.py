import cv2
import scipy
import numpy as np

width_contour = 5

kernel = np.ones((3,3))
path = 'D:/MIT/Master Thesis/1 - SpinBall/Pulley_Scans/SolidWorks/GearMaskCopy.png'
im = cv2.imread(path)
im = (im > 50).astype(np.float32)

im_erode = cv2.erode(im, kernel=kernel, iterations=width_contour)
im_result = 255*(im - im_erode)

cv2.imwrite(path.replace('.jpeg', '_contour.jpeg'), im_result)
