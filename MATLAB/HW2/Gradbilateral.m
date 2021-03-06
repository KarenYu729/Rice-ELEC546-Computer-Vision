clc;
clf;
close all;
ManImg = double(imread("camera_man_noisy.png"))/255;

% Introduce AWGN into test images.
% Note: This will show the benefit of bilateral filtering.
ManImg = ManImg+0.03*randn(size(ManImg));
ManImg(ManImg<0) = 0;
ManImg(ManImg>1) = 1;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3.4 0.34]; % bilateral filter standard deviations

% Apply bilateral filter to each image.
bflt_img1 = bfilter2(ManImg,w,sigma);

% Display grayscale input image and filtered output.
figure(1); clf;
set(gcf,'Name','Grayscale Bilateral Filtering Results');
subplot(1,2,1); imagesc(ManImg);
axis image; colormap gray;
title('Input Image');
subplot(1,2,2); imagesc(bflt_img1);
axis image; colormap gray;
title('Result of Bilateral Filtering');