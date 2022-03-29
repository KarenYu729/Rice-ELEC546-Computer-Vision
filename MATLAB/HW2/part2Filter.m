clc;
clf;
close All;
% Filter the following matrices
I_1h = [0 120 110 90 115 40 0;
    0 145 135 135 65 35 0;
    0 125 115 55 35 25 0;
    0 80 45 45 20 15 0;
    0 40 35 25 10 10 0]
I_2h = [0 125 130 135 110 125 0;
    0 145 135 135 155 125 0;
    0 65 60 55 45 40 0;
    0 40 35 40 25 15 0;
    0 15 15 20 15 10 0];

I_1v = [0 0 0 0 0;
    120 110 90 115 40;
    145 135 135 65 35;
    125 115 55 35 25;
    80 45 45 20 15;
    40 35 25 10 10;
    0 0 0 0 0]
I_2v = [0 0 0 0 0;
    125 130 135 110 125;
    145 135 135 155 125;
    65 60 55 45 40;
    40 35 40 25 15;
    15 15 20 15 10;
    0 0 0 0 0];

I_1 = [0 0 0 0 0 0 0;
    0 120 110 90 115 40 0;
    0 145 135 135 65 35 0;
    0 125 115 55 35 25 0;
    0 80 45 45 20 15 0;
    0 40 35 25 10 10 0
    0 0 0 0 0 0 0]
I_2 = [0 0 0 0 0 0 0;
    0 125 130 135 110 125 0;
    0 145 135 135 155 125 0;
    0 65 60 55 45 40 0;
    0 40 35 40 25 15 0;
    0 15 15 20 15 10 0;
    0 0 0 0 0 0 0];


core_1 = (1/3)*[1 1 1]
core_2 = (1/3)*[1; 1; 1]
core_3 = (1/9)*[1 1 1; 1 1 1; 1 1 1]

[rh1,ch1] = size(I_1h)    % 读取行r、列c
[rh2,ch2] = size(I_2h)
[rv1,cv1] = size(I_1v)
[rv2,cv2] = size(I_2v)
[r1,c1] = size(I_1)
[r2,c2] = size(I_2)

% core_1 & I_1
for i = 1:rh1
    for j = 1:ch1-2
        C1I1(i,j) = (1/3)*(I_1h(i,j)+I_1h(i,j+1)+I_1h(i,j+2))
    end
end


% core_1 & I_2
for i = 1:rh2
    for j = 1:ch2-2
        C1I2(i,j) = (1/3)*(I_2h(i,j)+I_2h(i,j+1)+I_2h(i,j+2))
    end
end

% core_2 & I_1
for i = 1:rv1-2
    for j = 1:cv1
        C2I1(i,j) = (1/3)*(I_1v(i,j)+I_1v(i+1,j)+I_1v(i+2,j))
    end
end


% core_2 & I_2
for i = 1:rv2-2
    for j = 1:cv2
        C2I2(i,j) = (1/3)*(I_2v(i,j)+I_2v(i+1,j)+I_2v(i+2,j))
    end
end


% core_3 & I_1
for i = 1:r1-2
    for j = 1:c1-2
        C3I1(i,j) = (1/9)*(I_1(i,j)+I_1(i+1,j)+I_1(i+2,j) ...
            +I_1(i,j+1)+I_1(i+1,j+1)+I_1(i+2,j+1) ...
            +I_1(i,j+2)+I_1(i+1,j+2)+I_1(i+2,j+2))
    end
end

% core_3 & I_2
for i = 1:r1-2
    for j = 1:c1-2
        C3I2(i,j) = (1/9)*(I_2(i,j)+I_2(i+1,j)+I_2(i+2,j) ...
            +I_2(i,j+1)+I_2(i+1,j+1)+I_2(i+2,j+1) ...
            +I_2(i,j+2)+I_2(i+1,j+2)+I_2(i+2,j+2))
    end
end



% Apply following filters on the gray scale image of barbara
bImg = imread("barbara.jpg");
grayImg = rgb2gray(bImg);


% Central difference Gradient filter
figure(1);
CenterGF = (1/2)*[-1 0 1];
CenterGFImg = imfilter(grayImg, CenterGF);
imshow(CenterGFImg);title('Central difference Gradient filter')

% Sobel filter
figure(2);
SobelF = fspecial('sobel');
SobelImg = imfilter(grayImg, SobelF);
imshow(SobelImg);title('Sobel filter')


% Mean filter
figure(3);
MeanImg = imnlmfilt(grayImg);
imshow(MeanImg);title('Mean filter')

% Median filter
figure(4);
MidImg = medfilt2(grayImg);
imshow(MidImg);title('Median filter')



