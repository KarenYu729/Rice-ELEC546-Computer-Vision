
% read image
wearGlass = imread('wearglass.jpg');
noGlass = imread('noglass.jpg');
% crop image
wearGlass = wearGlass(451:1550,501:1600,:);
noGlass = noGlass(551:1650,491:1590,:);

%%%%%%%%%%%%%%
%% method 1 %%  
%%%%%%%%%%%%%%
radius = 50;      
I1 = fftshift(fft2(double(wearGlass)));
I2 = fftshift(fft2(double(noGlass)));
[m, n, z]=size(wearGlass);
h = fspecial('gaussian', [m,n], radius);
h = h./max(max(h));
for colorI = 1:3
   J_(:,:,colorI) = I1(:,:,colorI).*(1-h) + I2(:,:,colorI).*h;
end
J = uint8(real(ifft2(ifftshift(J_)))); 
imshow(J); title('hybrid image') 
figure(2);
for colorI = 1:3
   J_1(:,:,colorI) = I1(:,:,colorI).*(1-h);
end
J1 = uint8(real(ifft2(ifftshift(J_1)))); 
subplot(1,2,1);imshow(J1);title('hige Freq')
for colorI = 1:3
   J_2(:,:,colorI) = I2(:,:,colorI).*h;
end
J2 = uint8(real(ifft2(ifftshift(J_2)))); 
subplot(1,2,2);imshow(J2);title('low Freq')

%%%%%%%%%%%%%%
%% method 2 %%  
%%%%%%%%%%%%%%

d0=50;  % Threshold

[row_n ,col_n, c]=size(noGlass);

img_Lf = fft2(double(noGlass));
img_Lf=fftshift(img_Lf);  

row_mid=floor(row_n/2);
col_mid=floor(col_n/2);  

hLow = zeros(row_n,col_n);
for i = 1:row_n
    for j = 1:col_n
        d = ((i-row_mid)^2+(j-col_mid)^2);
        hLow(i,j) = exp(-(d)/(2*(d0^2)));      
    end
end

img_LowpassF = hLow.*img_Lf;

img_LowpassF=ifftshift(img_LowpassF); 
img_LowpassF=uint8(real(ifft2(img_LowpassF))); 


img_Hf = fft2(double(wearGlass));
img_Hf=fftshift(img_Hf);  

row_mid=floor(row_n/2);
col_mid=floor(col_n/2);  
hHigh = zeros(row_n,col_n);
for i = 1:row_n
    for j = 1:col_n
        d = ((i-row_mid)^2+(j-col_mid)^2);
        hHigh(i,j) = 1-exp(-(d)/(2*(d0^2)));      
    end
end

img_HighpassF = hHigh.*img_Hf;

img_HighpassF=ifftshift(img_HighpassF);  
img_HighpassF=uint8(real(ifft2(img_HighpassF)));
figure(3);
imshow(img_HighpassF+img_LowpassF);title('hybrid image')

