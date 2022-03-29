from PIL import Image
import matplotlib.pyplot as plt
import torch
import numpy as np
import cv2
# Apply the transformations needed

import os
os.environ["KMP_DUPLICATE_LIB_OK"]="True"

import torchvision.transforms as T
from torchvision import models
fcn = models.segmentation.fcn_resnet101(pretrained=True).eval()

# Define the helper function
def decode_segmap(image, source, bgimg, nc=21):
    label_colors = np.array([(0, 0, 0),  # 0=background
                             # 1=aeroplane, 2=bicycle, 3=bird, 4=boat, 5=bottle
                             (128, 0, 0), (0, 128, 0), (128, 128, 0), (0, 0, 128), (128, 0, 128),
                             # 6=bus, 7=car, 8=cat, 9=chair, 10=cow
                             (0, 128, 128), (128, 128, 128), (64, 0, 0), (192, 0, 0), (64, 128, 0),
                             # 11=dining table, 12=dog, 13=horse, 14=motorbike, 15=person
                             (192, 128, 0), (64, 0, 128), (192, 0, 128), (64, 128, 128), (192, 128, 128),
                             # 16=potted plant, 17=sheep, 18=sofa, 19=train, 20=tv/monitor
                             (0, 64, 0), (128, 64, 0), (0, 192, 0), (128, 192, 0), (0, 64, 128)])

    r = np.zeros_like(image).astype(np.uint8)
    g = np.zeros_like(image).astype(np.uint8)
    b = np.zeros_like(image).astype(np.uint8)

    for l in range(0, nc):
        idx = image == l
        r[idx] = label_colors[l, 0]
        g[idx] = label_colors[l, 1]
        b[idx] = label_colors[l, 2]

    rgb = np.stack([r, g, b], axis=2)

    # Load the foreground input image
    # foreground = cv2.imread(source)
    foreground = source

    # Load the background input image
    background = cv2.imread(bgimg)

    # Change the color of foreground image to RGB
    # and resize images to match shape of R-band in RGB output map

    foreground = cv2.resize(foreground, (r.shape[1], r.shape[0]))
    background = cv2.resize(background, (r.shape[1], r.shape[0]))


    # Create a binary mask of the RGB output map using the threshold value 0
    th, alpha = cv2.threshold(np.array(rgb), 0, 255, cv2.THRESH_BINARY)

    # Convert uint8 to float
    foreground = foreground.astype(float)
    background = background.astype(float)

    # # Apply a slight blur to the mask to soften edges
    alpha = cv2.GaussianBlur(alpha, (15, 15), 0.8, borderType = cv2.BORDER_DEFAULT)

    # Normalize the alpha mask to keep intensity between 0 and 1
    alpha = alpha.astype(float) / 255

    # Multiply the foreground with the alpha matte
    foreground = cv2.multiply(alpha, foreground)

    # Multiply the background with ( 1 - alpha )
    background = cv2.multiply(1.0 - alpha, background)

    # Add the masked foreground and background
    outImage = cv2.add(foreground, background)



    # Return a normalized output image for display
    return outImage / 255


def segment(net, path, bgimagepath, dev = 'cpu'):
# def segment(net, path, bgimagepath, show_orig=True):
    # img = cv2.imread(path)
    img = path
    img = Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    # Comment the Resize and CenterCrop for better inference results
    trf = T.Compose([T.Resize(400),
                     # T.CenterCrop(224),
                     T.ToTensor(),
                     T.Normalize(mean=[0.485, 0.456, 0.406],
                                 std=[0.229, 0.224, 0.225])])
    inp = trf(img).unsqueeze(0)
    out = net.to(dev)(inp)['out']
    om = torch.argmax(out.squeeze(), dim=0).detach().cpu().numpy()
    rgb = decode_segmap(om, path, bgimagepath)

    # cv2.imshow('frame', rgb)
    # cv2.waitKey(100)
    # plt.imshow(rgb)
    # plt.axis('off')
    # plt.show()
    return rgb

# dlab = models.segmentation.deeplabv3_resnet101(pretrained=1).eval()
# imagei = cv2.imread('lenna.jpg')
# # imagea = segment(dlab, imagei, 'backGround.jpeg', show_orig=False)
# imagea = segment(fcn, imagei, 'backGround.jpeg', show_orig=False)
# cv2.imshow('frame', imagea)
# plt.imshow(imagea)
# plt.show()
# cv2.destroyAllWindows()



# segment(dlab, 'lenna.jpg', show_orig=False)
# dlab = models.segmentation.deeplabv3_resnet101(pretrained=1).eval()
# #
# imagea = segment(dlab, imagei, 'backGround.jpeg', show_orig=False)
# # segment(dlab, './images/change/girl.png', './images/change/forest.png', show_orig=False)
# # segment(dlab, 'lenna.jpg', 'backGround.jpeg', show_orig=False)

