import cv2
import matplotlib.pyplot as plt

image_o = cv2.imread("bird_image.jpg") # Read image
img = cv2.cvtColor(image_o, cv2.COLOR_BGR2GRAY)



# edge 1
t_lower = 100 # Lower Threshold
t_upper = 200 # Upper threshold
# Applying the Canny Edge filter
# with Aperture Size and L2Gradient
edge1 = cv2.Canny(img, t_lower, t_upper)

# edge2
t_lower = 100 # Lower Threshold
t_upper = 200 # Upper threshold
aperture_size = 5 # Aperture size
edge2 = cv2.Canny(img, t_lower, t_upper,
				apertureSize = aperture_size)

# edge3
t_lower = 100 # Lower Threshold
t_upper = 200 # Upper threshold
L2Gradient = True # Boolean
edge3 = cv2.Canny(img, t_lower, t_upper,
				L2gradient = L2Gradient )

# edge4
t_lower = 100 # Lower Threshold
t_upper = 200 # Upper threshold
aperture_size = 5 # Aperture size
L2Gradient = True # Boolean
edge4 = cv2.Canny(img, t_lower, t_upper,
				apertureSize = aperture_size,
				L2gradient = L2Gradient )

plt.subplot(221),plt.imshow(edge1,cmap = 'gray')
plt.title('Only threshold')
plt.axis('off')
plt.subplot(222),plt.imshow(edge2,cmap = 'gray')
plt.title('Only Add Aperture size')
plt.axis('off')
plt.subplot(223),plt.imshow(edge3,cmap = 'gray')
plt.title('Only Add L2Gradient')
plt.axis('off')
plt.subplot(224),plt.imshow(edge4,cmap = 'gray')
plt.title('Add both Grad and Aperture')
plt.axis('off')

plt.show()