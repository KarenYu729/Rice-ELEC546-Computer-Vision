clc;
clf;
close All;
sImg = imread("camera_man_noisy.png")

% Averaging filters of sizes 2 × 2
figure(1);
aveFilt1 = fspecial('average', [2 2]);
filtImg1 = imfilter(sImg, aveFilt1, 'symmetric');
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(filtImg1); title('Averaging Filtered Image1');


% Averaging filters of sizes 4 × 4
figure(2);
aveFilt2 = fspecial('average', [4 4]);
filtImg2 = imfilter(sImg, aveFilt2, 'symmetric');
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(filtImg2); title('Averaging Filtered Image2');


% Averaging filters of sizes 8 × 8
figure(3);
aveFilt3 = fspecial('average', [8 8]);
filtImg3 = imfilter(sImg, aveFilt3, 'symmetric');
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(filtImg3); title('Averaging Filtered Image3');


% Averaging filters of sizes 16 × 16
figure(4);
aveFilt4 = fspecial('average', [16 16]);
filtImg4 = imfilter(sImg, aveFilt4, 'symmetric');
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(filtImg4); title('Averaging Filtered Image4');


% Compare Averaging filters
figure(5);
subplot(2,2,1), imshow(filtImg1); title('Averaging Filtered Image1');
subplot(2,2,2), imshow(filtImg2); title('Averaging Filtered Image2');
subplot(2,2,3), imshow(filtImg3); title('Averaging Filtered Image3');
subplot(2,2,4), imshow(filtImg4); title('Averaging Filtered Image4');


% Gaussian filter of standard deviations 2
figure(6);
gaussFilt1 = fspecial('gaussian',15,2);
gImg1 = imfilter(sImg, gaussFilt1, 'symmetric'); 
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(gImg1); title('Gaussian Filtered Image1');


% Gaussian filter of standard deviations 4
figure(7);
gaussFilt2 = fspecial('gaussian',15,4);
gImg2 = imfilter(sImg, gaussFilt2, 'symmetric'); 
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(gImg2); title('Gaussian Filtered Image2');


% Gaussian filter of standard deviations 8
figure(8);
gaussFilt3 = fspecial('gaussian',15,8);
gImg3 = imfilter(sImg, gaussFilt3, 'symmetric'); 
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(gImg3); title('Gaussian Filtered Image3');


% Gaussian filter of standard deviations 16
figure(9);
gaussFilt4 = fspecial('gaussian',15,16);
gImg4 = imfilter(sImg, gaussFilt4, 'symmetric'); 
subplot(1,2,1), imshow(sImg); title('Original Image');
subplot(1,2,2), imshow(gImg4); title('Gaussian Filtered Image4');


% Compare Gaussian filters
figure(10);
subplot(2,2,1), imshow(gImg1); title('Gaussian Filtered Image1');
subplot(2,2,2), imshow(gImg2); title('Gaussian Filtered Image2');
subplot(2,2,3), imshow(gImg3); title('Gaussian Filtered Image3');
subplot(2,2,4), imshow(gImg4); title('Gaussian Filtered Image4');


% Compare All filters
figure(11);
% subplot(2,4,1), imshow(filtImg1); title('Averaging Filtered Image1');
% subplot(2,4,2), imshow(filtImg2); title('Averaging Filtered Image2');
% subplot(2,4,3), imshow(filtImg3); title('Averaging Filtered Image3');
% subplot(2,4,4), imshow(filtImg4); title('Averaging Filtered Image4');
% subplot(2,4,5), imshow(gImg1); title('Gaussian Filtered Image1');
% subplot(2,4,6), imshow(gImg2); title('Gaussian Filtered Image2');
% subplot(2,4,7), imshow(gImg3); title('Gaussian Filtered Image3');
% subplot(2,4,8), imshow(gImg4); title('Gaussian Filtered Image4');
subplot(2,4,1), imhist(filtImg1); title('Averaging Filtered Image1');
subplot(2,4,2), imhist(filtImg2); title('Averaging Filtered Image2');
subplot(2,4,3), imhist(filtImg3); title('Averaging Filtered Image3');
subplot(2,4,4), imhist(filtImg4); title('Averaging Filtered Image4');
subplot(2,4,5), imhist(gImg1); title('Gaussian Filtered Image1');
subplot(2,4,6), imhist(gImg2); title('Gaussian Filtered Image2');
subplot(2,4,7), imhist(gImg3); title('Gaussian Filtered Image3');
subplot(2,4,8), imhist(gImg4); title('Gaussian Filtered Image4');