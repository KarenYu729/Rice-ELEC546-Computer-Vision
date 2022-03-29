clc;
clf;
close All;
img1 = imread('part1Img.jpg');
%Crop image
subImg = img1(5:250,50:350,:);
figure(1);
imshow(subImg);title('Cropped Image');


% Save cropped image
imwrite(subImg, 'subImage.png');

% Display the green component
figure(2)
green = subImg(:,:,2);
a = zeros(size(subImg, 1), size(subImg, 2));
just_green = cat(3, a, green, a);
imshow(just_green);title('Green Component Image');


% Change the order of the color components to [Green,Red,Blue]
newcolors = {'green', 'red', 'blue'}
colororder(newcolors)
figure(3);
imshow(subImg);title('Image with new color order');