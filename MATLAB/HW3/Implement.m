% read image
caManImg = imread('cameraman.tiff');
canManNoise = imread('cameraman_noisy.tiff');
figure(1);
subplot(1,2,1);imshow(caManImg);title('onriginal image');
subplot(1,2,2);imshow(canManNoise);title('noisy image');

%%%%%                            %%%%%
%%%%%Gradient Magnitude and Angle%%%%%
%%%%%                            %%%%%
% Compute the derivatives
S_x = [-1 0 1; -2 0 2; -1 0 1];
S_y = [1 2 1; 0 0 0; -1 -2 -1];

y_DImg = conv2(caManImg, S_y);
x_DImg = conv2(caManImg, S_x);
y_DImgN = conv2(canManNoise, S_y);
x_DImgN = conv2(canManNoise, S_x);
figure(2);
subplot(2,2,1);imshow(y_DImg);title('original Y');
subplot(2,2,2);imshow(x_DImg);title('original X');
subplot(2,2,3);imshow(y_DImgN);title('noisy Y');
subplot(2,2,4);imshow(x_DImgN);title('noisy X');

%  Compute the gradient magnitude
G_Img = sqrtm(y_DImg.^2+x_DImg.^2);
G_ImgN = sqrtm(y_DImgN.^2+x_DImgN.^2);
figure(3);
subplot(1,2,1);imshow(G_Img);title('original magnitude');
subplot(1,2,2);imshow(G_ImgN);title('noisy magnitude');


% Compute the angle of the gradient
theta_Img = atan2d(y_DImg,x_DImg);
theta_ImgN = atan2d(y_DImgN,x_DImgN);
figure(4);

% change color based on angle
[I_row, I_col] = size(theta_Img);
[NI_row, NI_col] = size(theta_ImgN);
color_I = zeros(I_row, I_col,3);
color_NI = zeros(NI_row,NI_col,3);

for i = 1:I_row
    for j = 1:I_col
        if (theta_Img(i,j)<0 && theta_Img(i,j)>-22.5)||(theta_Img(i,j)>=0 && theta_Img(i,j)<=22.5)
            color_I(i,j,1) = 1;
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<180 && theta_Img(i,j)>157.5)||(theta_Img(i,j)>=-180 && theta_Img(i,j)<=-157.5)
            color_I(i,j,1) = 1;
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<=67.5 && theta_Img(i,j)>22.5)||(theta_Img(i,j)>-157.5 && theta_Img(i,j)<=-112.5)
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<=112.5 && theta_Img(i,j)>67.5)||(theta_Img(i,j)>-112.5 && theta_Img(i,j)<=-67.5)
            color_I(i,j,3) = 1;
        else
            color_I(i,j,1) = 1;
        end
    end
end

for i = 1:I_row
    for j = 1:I_col
        if (theta_ImgN(i,j)<0 && theta_ImgN(i,j)>-22.5)||(theta_ImgN(i,j)>=0 && theta_ImgN(i,j)<=22.5)
            color_NI(i,j,1) = 1;
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<180 && theta_ImgN(i,j)>157.5)||(theta_ImgN(i,j)>=-180 && theta_ImgN(i,j)<=-157.5)
            color_NI(i,j,1) = 1;
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<=67.5 && theta_ImgN(i,j)>22.5)||(theta_ImgN(i,j)>-157.5 && theta_ImgN(i,j)<=-112.5)
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<=112.5 && theta_ImgN(i,j)>67.5)||(theta_ImgN(i,j)>-112.5 && theta_ImgN(i,j)<=-67.5)
            color_NI(i,j,3) = 1;
        else
            color_NI(i,j,1) = 1;
        end
    end
end

subplot(1,2,1);imshow(color_I);title('Image theta');
subplot(1,2,2);imshow(color_NI);title('Noisy Image theta');

%%%%                       %%%%%
%%%%    Noise Reduction    %%%%%
%%%%                       %%%%%
filter_N = (1/159)*[2 4 5 4 2;
    4 9 12 9 4;
    5 12 15 12 5;
    4 9 12 9 4;
    2 4 5 4 2];

cam_Nf = imfilter(caManImg, filter_N);
canN_NF = imfilter(canManNoise, filter_N);
figure(5);
subplot(2,2,1);imshow(caManImg);title('original Image');
subplot(2,2,2);imshow(canManNoise);title('original Noisy Image');
subplot(2,2,3);imshow(cam_Nf);title('filter original Image');
subplot(2,2,4);imshow(canN_NF);title('filter noisy Image');

S_x = [-1 0 1; -2 0 2; -1 0 1];
S_y = [1 2 1; 0 0 0; -1 -2 -1];

y_DImg = conv2(cam_Nf, S_y);
x_DImg = conv2(cam_Nf, S_x);
y_DImgN = conv2(canN_NF, S_y);
x_DImgN = conv2(canN_NF, S_x);
figure(6);
subplot(2,2,1);imshow(y_DImg);title('original Y');
subplot(2,2,2);imshow(x_DImg);title('original X');
subplot(2,2,3);imshow(y_DImgN);title('noisy Y');
subplot(2,2,4);imshow(x_DImgN);title('noisy X');

%  Compute the gradient magnitude
G_Img = sqrtm(y_DImg.^2+x_DImg.^2);
G_ImgN = sqrtm(y_DImgN.^2+x_DImgN.^2);
figure(7);
subplot(1,2,1);imshow(G_Img);title('original magnitude');
subplot(1,2,2);imshow(G_ImgN);title('noisy magnitude');


% Compute the angle of the gradient
theta_Img = atan2d(y_DImg,x_DImg);
theta_ImgN = atan2d(y_DImgN,x_DImgN);
figure(8);

% change color based on angle
[I_row, I_col] = size(theta_Img);
[NI_row, NI_col] = size(theta_ImgN);
color_I = zeros(I_row, I_col,3);
color_NI = zeros(NI_row,NI_col,3);

for i = 1:I_row
    for j = 1:I_col
        if (theta_Img(i,j)<0 && theta_Img(i,j)>-22.5)||(theta_Img(i,j)>=0 && theta_Img(i,j)<=22.5)
            color_I(i,j,1) = 1;
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<180 && theta_Img(i,j)>157.5)||(theta_Img(i,j)>=-180 && theta_Img(i,j)<=-157.5)
            color_I(i,j,1) = 1;
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<=67.5 && theta_Img(i,j)>22.5)||(theta_Img(i,j)>-157.5 && theta_Img(i,j)<=-112.5)
            color_I(i,j,2) = 1;
        elseif (theta_Img(i,j)<=112.5 && theta_Img(i,j)>67.5)||(theta_Img(i,j)>-112.5 && theta_Img(i,j)<=-67.5)
            color_I(i,j,3) = 1;
        else
            color_I(i,j,1) = 1;
        end
    end
end

for i = 1:I_row
    for j = 1:I_col
        if (theta_ImgN(i,j)<0 && theta_ImgN(i,j)>-22.5)||(theta_ImgN(i,j)>=0 && theta_ImgN(i,j)<=22.5)
            color_NI(i,j,1) = 1;
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<180 && theta_ImgN(i,j)>157.5)||(theta_ImgN(i,j)>=-180 && theta_ImgN(i,j)<=-157.5)
            color_NI(i,j,1) = 1;
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<=67.5 && theta_ImgN(i,j)>22.5)||(theta_ImgN(i,j)>-157.5 && theta_ImgN(i,j)<=-112.5)
            color_NI(i,j,2) = 1;
        elseif (theta_ImgN(i,j)<=112.5 && theta_ImgN(i,j)>67.5)||(theta_ImgN(i,j)>-112.5 && theta_ImgN(i,j)<=-67.5)
            color_NI(i,j,3) = 1;
        else
            color_NI(i,j,1) = 1;
        end
    end
end

subplot(1,2,1);imshow(color_I);title('Image theta');
subplot(1,2,2);imshow(color_NI);title('Noisy Image theta');



%%%%                           %%%%%
%%%%  Non-Maximum Suppression  %%%%%
%%%%                           %%%%%

Edge1_I = zeros(I_row, I_col);
Edge1_NI = zeros(NI_row,NI_col);

for i = 2:I_row-1
    for j = 2:I_col-1
        if ((theta_Img(i,j)==0)||(theta_Img(i,j)==180)) && (G_Img(i,j) == max(G_Img(i-1:i+1,j)))
            Edge1_I(i,j) = 1;
        elseif (theta_Img(i,j)==45||(theta_Img(i,j)==-45)) && (G_Img(i,j) == max([G_Img(i-1,j-1),G_Img(i,j),G_Img(i+1,j+1)]))
            Edge1_I(i,j) = 1;
        elseif (theta_Img(i,j)==90||(theta_Img(i,j)==-90)) && (G_Img(i,j) == max(G_Img(i,j-1:j+1)))
            Edge1_I(i,j) = 1;
        elseif (theta_Img(i,j)==135||(theta_Img(i,j)==-135)) && (G_Img(i,j) == max([G_Img(i-1,j+1),G_Img(i,j),G_Img(i+1,j-1)]))
            Edge1_I(i,j) = 1;
        end
        
    end
end


for i = 2:I_row-1
    for j = 2:I_col-1
        if ((theta_ImgN(i,j)==0)||(theta_ImgN(i,j)==180)) && (G_ImgN(i,j) == max(G_ImgN(i-1:i+1,j)))
            Edge1_NI(i,j) = 1;
        elseif (theta_ImgN(i,j)==45||(theta_ImgN(i,j)==-45)) && (G_ImgN(i,j) == max([G_ImgN(i-1,j-1),G_ImgN(i,j),G_ImgN(i+1,j+1)]))
            Edge1_NI(i,j) = 1;
        elseif (theta_ImgN(i,j)==90||(theta_ImgN(i,j)==-90)) && (G_ImgN(i,j) == max(G_ImgN(i,j-1:j+1)))
            Edge1_NI(i,j) = 1;
        elseif (theta_ImgN(i,j)==135||(theta_ImgN(i,j)==-135)) && (G_ImgN(i,j) == max([G_ImgN(i-1,j+1),G_ImgN(i,j),G_ImgN(i+1,j-1)]))
            Edge1_NI(i,j) = 1;
        end
        
    end
end


figure(9);
subplot(1,2,1);imshow(Edge1_I);title('Image Non-Maximum');
subplot(1,2,2);imshow(Edge1_NI);title('Noisy Image Non-Maximum');




%%%%                           %%%%%
%%%%  Hysteresis Thresholding  %%%%%
%%%%                           %%%%%
Edge2_I = zeros(I_row, I_col);
Edge2_NI = zeros(NI_row,NI_col);
high_T = 80;
low_T = 20;

for i = 1:I_row
    for j = 1:I_col
        if abs(G_Img(i,j)) < low_T
            Edge2_I(i,j) = 0;
        elseif abs(G_Img(i,j)) > high_T
            Edge2_I(i,j) = 1;
        else
            if i>1 && i<I_row && j>1 && j<I_col
                submatrix = abs(G_Img(i-1:i+1,j-1:j+1));
                flagmatrix = find(submatrix>high_T);
                if ~isempty(flagmatrix)
                    Edge2_I(i,j) = 1;
                else
                    if i>2 && i<I_row-2 && j>2 && j<I_col-2
                        submatrix = abs(G_Img(i-2:i+2,j-2:j+2));
                        flagmatrix = find(submatrix>high_T);
                        if ~isempty(flagmatrix)
                            Edge2_I(i,j) = 1;
                        end
                    end
                end
            end
        end
    end
end

for i = 1:I_row
    for j = 1:I_col
        if abs(G_ImgN(i,j)) < low_T
            Edge2_NI(i,j) = 0;
        elseif abs(G_ImgN(i,j)) > high_T
            Edge2_NI(i,j) = 1;
        else
            if i>1 && i<I_row && j>1 && j<I_col
                submatrix = abs(G_ImgN(i-1:i+1,j-1:j+1));
                flagmatrix = find(submatrix>high_T);
                if ~isempty(flagmatrix)
                    Edge2_NI(i,j) = 1;
                else
                    if i>2 && i<I_row-2 && j>2 && j<I_col-2
                        submatrix = abs(G_ImgN(i-2:i+2,j-2:j+2));
                        flagmatrix = find(submatrix>high_T);
                        if ~isempty(flagmatrix)
                            Edge2_NI(i,j) = 1;
                        end
                    end
                end
            end
            
        end
    end
end

figure(10);
subplot(1,2,1);imshow(Edge2_I);title('Image Thresholding');
subplot(1,2,2);imshow(Edge2_NI);title('Noisy Image Thresholding');