clc;
clf;
close All;
bImg = imread("barbara.jpg");

% Convert the image to gray scale
figure(1);
grayImg = rgb2gray(bImg);
imshow(grayImg);title('Gray Scale Image');

% Plot a histogram of the gray scale image
figure(2);
imhist(grayImg, 51);title('Histogram of theGray Scale Image');

% Blur the gray scale image
% Gaussian filters, with standard deviations 2
figure(3);
gaussFilt1 = fspecial('gaussian',15,2);
blurImg1 = imfilter(grayImg, gaussFilt1, 'symmetric'); 
subplot(1,2,1), imshow(grayImg); title('Grayscale Image');
subplot(1,2,2), imshow(blurImg1); title('Gaussian Filtered Image1');


% Gaussian filters, with standard deviations 8
figure(4);
gaussFilt2 = fspecial('gaussian',15,8);
blurImg2 = imfilter(grayImg, gaussFilt2, 'symmetric'); 
subplot(1,2,1), imshow(grayImg); title('Grayscale Image');
subplot(1,2,2), imshow(blurImg2); title('Gaussian Filtered Image2');


% Plot histograms for the blurred images
figure(5);
subplot(1,3,1),imhist(grayImg,51);
subplot(1,3,2),imhist(blurImg1,51);
subplot(1,3,3),imhist(blurImg2,51);

% Subtract the blurred image
figure(6);
subtImg = grayImg - blurImg1;
imshow(subtImg);

% Threshold the resultant image
figure(7);
thresh = 100;
tImg1 = subtImg;
index = find(subtImg<=thresh*0.05);  
tImg1(index) =  0;
imshow(tImg1);
